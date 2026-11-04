Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836568;
	b=P3x9q+DsE8gJb3yAquIN8lYxdquclq9go3S4CR14lN3Y1FeHIEu8nKWI9rF5pJ99paFk
	 ePkGO1lRI0cZA7FKT/TsQYettZHj7UTmkpbW4J/FAFcSyNrvz/4g/4RkzQXCDZCbaEMFW
	 Yw6DF5VgapimYiijeAll161yLf8QqZ0RWc33x4NpbxCC/Wcw2mFDGJqP1qg/0nRi/6ZN5
	 jE2TXewI50DCzoSXSA8QfcLPbiunL9LjbNjwJRMEziGa8CUxOU3bAGNmVsuHzBi4GAPDL
	 SOGLilSWJXCBghrkS4a/IhBtmxdrtRI5LG80WC2Epl4Sc53uXWzHIdhJo1+SHj5+vvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LNTKtXKj8efrBSJrwCvl6GJ90e2epflJbFTJhdFl0Xs=;
	b=I2+LFt18Wd0cKCaIG3Ro9NLDgU7bCr8zRtUA+lp8Hx7K2dJcSUoJnpb/w32zK1FQDRLA
	 1tuYYAXFhZfrz9alsBN05kBzTO9K22tN3r2oq8gzKUkeLit0knNILrMmyL+kKpP36/Cf0
	 W+CxVhneJlxc8G5CfZA4FsdOt9KrNAx45yNx3mUKjVLIl4p4jkoIouov0tDbD5iTa+38e
	 4G+K+loBKwW5oFPRAgu/DUOKKhOIQeGrmYxYmG2nxZOxXTYipkfUSBCoJ+xiAKK4s/jRD
	 D3RjowSeGDITNRUnq33ur6GAdSMIkjRXFqpje38APL/q5qU5BL8RoJsuByt96nliLsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBstR5yx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A4606A326;
	Wed,  4 Nov 2026 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBstR5yx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88B41F000C1;
	Wed,  4 Nov 2026 23:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836568;
	bh=LNTKtXKj8efrBSJrwCvl6GJ90e2epflJbFTJhdFl0Xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EBstR5yx3u9GrUbboID3DR6kyQxjFiQFBwhwOfWA3ne6CbgRd/ZlFyMB65OG5Nw8f
	 C02+ivahrTpAGhM5bM/kIm11iUKfJvwL0v/kvOuKRXkz0jMWai28DoyDWbrIk7/UVx
	 1pg2fgbijY35OdhdDw2j3+FMqXZktoRqJwS5T0Ek0xqpeBK5vZcoxeBfN9kHJM96bv
	 DZ1Agn+Jd1HexaM0equ10lO8ccAb9WURjAAgSrWB1GAi2c4bQi6IkIV7qHJc3I6J3n
	 1bjJqpZlCOi9i8T2ngrHoRydclrAwHZ1q7wyuJW3K1wWWPv12twVoO6pdtCapjt9Xy
	 59pCP2I4JYvEA==
Message-ID: <sashiko-outbox-198323@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/21] cgroup/cpuset: Give back the bandwidth an
 attach did not move
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-18-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-18-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:56:07 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cgroup/cpuset: clear_attach_data() frees rebuilt bandwidth on conc=
urrent rebuild
--

commit 8c5e4a02e2c52ea15855fb0f7b705db9ce328dd1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Give back the bandwidth an attach did not move

This commit tracks the deadline bandwidth actually moved during
cpuset_attach_task() in sum_moved_dl_bw via set_cpus_allowed_bw_reserved()
and frees any unused reservation (sum_migrate_dl_bw - sum_moved_dl_bw) in
clear_attach_data().

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ae0bbe23a6332..1ae86338f3c2a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3197,10 +3197,24 @@ static void clear_attach_data(struct llist_head *=
head, bool cancel)
>  		if (cs->nr_migrate_dl_tasks) {
>  			if (!cancel)
>  				atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
> -			else if (cs->dl_bw_cpu >=3D 0) /* && cancel */
> -				dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
> +			/*
> +			 * Give back the bandwidth the attach did not move:
> +			 * all of the reservation when it is cancelled, and
> +			 * what was set aside for the tasks that are no
> +			 * longer deadline tasks otherwise. Theirs is
> +			 * released by the class they left, from the root
> +			 * domain that counts it.
> +			 */
> +			if (cs->dl_bw_cpu >=3D 0) {
> +				u64 bw =3D cancel ? cs->sum_migrate_dl_bw :
> +					 cs->sum_migrate_dl_bw - cs->sum_moved_dl_bw;
> +
> +				if (bw)
> +					dl_bw_free(cs->dl_bw_cpu, bw);
> +			}

[Severity: High]
Can clear_attach_data() free bandwidth that was already wiped or attributed
to the migrated tasks if rebuild_sched_domains() runs between
cpuset_can_attach() and cpuset_attach()?

During cgroup migration, cgroup_attach_lock() holds cpus_read_lock(), and
cpuset_can_attach() reserves cs->sum_migrate_dl_bw in cs->dl_bw_cpu's root
domain via cpuset_reserve_dl_bw(), increments attach_ctx.in_progress, and
drops cpuset_mutex.

Before cpuset_attach() runs, another thread calling rebuild_sched_domains()
(for instance via sched_rt_handler() or rebuild_sched_domains_energy()) only
takes cpus_read_lock() and mutex_lock(&cpuset_mutex) directly rather than
waiting on attach_ctx.in_progress via wait_attach_done_lock():

kernel/cgroup/cpuset.c:rebuild_sched_domains_cpuslocked() {
	mutex_lock(&cpuset_mutex);
	rebuild_sched_domains_locked();
	mutex_unlock(&cpuset_mutex);
}

rebuild_sched_domains_locked() -> partition_sched_domains() ->
dl_rebuild_rd_accounting() calls dl_clear_root_domains(), resetting
rd->dl_bw.total_bw to 0 and wiping the reservation made by
cpuset_reserve_dl_bw().

If dl_rebuild_rd_accounting() runs after css_set_move_task() moves the task
into cs, dl_add_task_root_domain() accounts the task's bandwidth into cs's
root domain and sets task->dl.dl_bw_cpu to a CPU in cs. When
cpuset_attach_task() then runs, dl_task_needs_bw_move(task,
cs->effective_cpus) returns false because task->dl.dl_bw_cpu is already in
cs's root domain, leaving cs->sum_moved_dl_bw at 0. Even if the rebuild runs
before css_set_move_task() and the task leaves SCHED_DEADLINE before
cpuset_attach_task(), the reservation in cs's root domain has already been
cleared by dl_clear_root_domains().

When clear_attach_data() subsequently calls dl_bw_free(cs->dl_bw_cpu,
cs->sum_migrate_dl_bw - cs->sum_moved_dl_bw), wouldn't it subtract
cs->sum_migrate_dl_bw from the rebuilt total_bw and leave the destination
root domain's total_bw short of what its tasks hold?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D17
