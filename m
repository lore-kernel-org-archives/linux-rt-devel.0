Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364A31E832;
	Thu, 27 Aug 2026 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874800; cv=none; b=mdtuDKjSIweBXa55egBHQsu2kv8rfkpVZCQQ0Bot3wEjUqsGUkmluVgcopyZ8FGveAAEFwHFuMJh02lSSxjrxiQ1nMYQdvsIGRrRA3QrmvQVU1oEcR9bjp6EIZvrbiwbuOht0wTaETIMqghJXPoytImuPi4GjOq6ZqlF/TUpbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874800; c=relaxed/simple;
	bh=vLo2VI+0C0J3aVd8SMQfwtoqv33cP04oTaLDxelHnzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1hvCR2YsOD9aDKswZPT28wxpDfwTo8HKZVmXAH99KvyEwSoL3pXMUHmdFmHJiYMSEgJaGxnCe7GG3nhg8hM/uO44XqZgPyit8/E418P7YXaJ9H421KHFMUBlHr2VFAO+ZjNPqJ9cJ18hXlfd1+jwaiePJhMF9/xlq1BrYH5zJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZI3L8YZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZI3L8YZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5D41F000E9;
	Thu, 27 Aug 2026 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787874799;
	bh=PUx29jOzmz0uh2pkxvhqZkp3C9LqyIZVmo5/Mm3m74A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZI3L8YZgAyp/WKUV+1YEoG4jGMluYnuYk3CrHmusSvfCtZaNMQJw0Ldr+nII/B2v
	 0B8XzaEw6UI91hUcjLyeliR4j3fv/Fm/putk9gzYljHJYFOTruRq1Kd+bCyYFSk9vt
	 KYNHWHKLNnTz8LfsdFlpWMZa0C1LjhJISn9mn+otU76xZucxDJJOtAh7CstGiBF45M
	 TRA/X8lSCyI8z2M4kmgl9JGunMxbs6n9fvlB3+oGVUBGWzL/RKETcM3IapHzwV00hv
	 EEEh5vBxRYMswe3x72FnuL4pf6OZaK3d5lVypWOzxFTzzteWU+PrvkIyD2q21VzJl4
	 gp4zdwjVJ7cYA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Stevens" <stevensd@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260827232948.2520558-7-stevensd@google.com>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 23:53:18 +0000
Message-Id: <20260827235319.0D5D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Memory leak of `obj_cgroup` in the `copy_process()` error path.
- [Medium] Repopulating kernel stack pages with `NUMA_NO_NODE` silently byp=
asses the task's NUMA mempolicy.
--

commit 19da8486785bcd64133ab34a423835e83ba21942
Author: David Stevens <stevensd@google.com>
Subject: Reclaim memory from blocked kernel stacks

This commit introduces a mechanism to reclaim unused portions of kernel
stacks for blocked tasks. It adds scheduler hooks and a new task flag
PF_RECLAIMABLE_STACK to manage safe stack reclaim and repopulation.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6acad0038b78e..9b2cc3d01dd10 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -460,6 +462,7 @@ static int alloc_thread_stack_node(struct task_struct=
 *tsk, int node)
> =20
>  		tsk->stack_vm_area =3D vm_area;
>  		tsk->stack =3D stack;
> +		add_to_stack_shrinker(tsk, node);
>  		return 0;
>  	}

[Severity: High]
Does this leak the obj_cgroup reference in the copy_process() error path?

When dup_task_struct() completes successfully, we acquire an obj_cgroup
reference inside add_to_stack_shrinker(). However, if a subsequent step in
copy_process() fails (such as copy_mm()), the kernel jumps to the=20
bad_fork_free label:

kernel/fork.c:copy_process() {
    ...
    bad_fork_free:
        WRITE_ONCE(p->__state, TASK_DEAD);
        exit_task_stack_account(p);
        put_task_stack(p);
        delayed_free_task(p);
    ...
}

Because delayed_free_task() directly frees the task without calling
__put_task_struct() or remove_from_stack_shrinker(), it seems the
obj_cgroup reference is permanently leaked, preventing the associated
mem_cgroup from being destroyed.

> diff --git a/kernel/stack_shrinker.c b/kernel/stack_shrinker.c
> new file mode 100644
> index 0000000000000..d7b1a7dfa7165
> --- /dev/null
> +++ b/kernel/stack_shrinker.c
[ ... ]
> +static bool repopulate_stack(struct task_struct *tsk, bool is_deferred,
> +			     struct llist_head *fail_list)
> +{
[ ... ]
> +	if (is_deferred) {
> +		gfp_t gfp =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO;
[ ... ]
> +		for (; nr_allocated < num_missing_pages; nr_allocated++) {
> +			pages[nr_allocated] =3D alloc_pages_node_noprof(node, gfp, 0);

[Severity: Medium]
Can this silently bypass the task's NUMA mempolicy?

If a task has no specific node forced, the target node is set to NUMA_NO_NO=
DE.=20

Calling alloc_pages_node_noprof() with NUMA_NO_NODE unconditionally ignores
the task's explicit NUMA mempolicy (like MPOL_BIND or MPOL_INTERLEAVE) and
allocates from the current CPU's local node instead.

Should this branch and use alloc_pages_noprof() when the target node is=20
NUMA_NO_NODE to properly respect the policy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827232948.2520=
558-1-stevensd@google.com?part=3D6
