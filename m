Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860E423E81;
	Thu, 23 Jul 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799115; cv=none; b=kqV0l0/75s834ieXk25okwZzoEHeNPCHdT5dKwohGOKf6407wvD1gCDsINi7qJ7C/Z1eL0mWCQOqDpLgGk4dZdg37gW9OEKYuPsma9DGCiAcEF8ekeLbXiRmHwVNkzJOkDSEXu12hveGsSvfEYiyoHtfPx5O36zl74G8EiUBNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799115; c=relaxed/simple;
	bh=x93hvEAS3+Hb1J8Ej+JHG3CjD2eOFJjvuSVp3r8NjGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvX3pndbUQvg0xDW3FuR/RrW7PKTjFd2mB4aQwVUI9KlKxpMKTJ9lsUzrLN8XdJgZ7t4ayMb0BQSuH5rxBtWwGo0b0Sgd2uKCuIzQMP6hYrulMgLu9XzvtcSykS5bw2b0rOAKCY1tWUVrinURrPn2v2gN+pWhMeysBKl1kX9Vcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004131F000E9;
	Thu, 23 Jul 2026 09:31:53 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/3] af_unix: Do not wait for garbage
 collector in sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <f005544705b193975c6a108fa733abc3d0e01755.1784712370.git.namcao@linutronix.de>
References: <cover.1784712370.git.namcao@linutronix.de>
 <f005544705b193975c6a108fa733abc3d0e01755.1784712370.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:31:53 +0000
Message-Id: <20260723093154.004131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing `unix_schedule_gc()` from `sendmsg()` prevents the AF_UNI=
X garbage collector from being proactively triggered for isolated cyclic re=
ferences, leading to spurious -ETOOMANYREFS failures and indefinite resourc=
e leaks.
- [Low] The `user` parameter and its associated conditional logic in `unix_=
schedule_gc()` are now dead code.
--

--- Patch [2]: [PATCH net-next v3 2/3] af_unix: Do not wait for garbage col=
lector in sendmsg() ---
commit e95749602b1bd36f1394eab73582d88874294091
Author: Nam Cao <namcao@linutronix.de>
af_unix: Do not wait for garbage collector in sendmsg()

This commit removes the unix_schedule_gc() call from the af_unix sendmsg()
path to prevent priority inversion scenarios. The change relies on the
assumption that checking RLIMIT_NOFILE and running the garbage collector
asynchronously are sufficient to prevent historical soft lockup and
out-of-memory issues.

> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e25266..f180c59b3da9d 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>  	if (!fpl->edges)
>  		goto err;
> =20
> -	unix_schedule_gc(fpl->user);
> -

[Severity: High]
Does removing this call prevent the af_unix garbage collector from being
proactively triggered for isolated cyclic references?

If a long-running task generates cyclic af_unix references and drops its
file descriptors, the cyclic references' f_count remains > 0, so
unix_release_sock() is never called. Without this trigger, wouldn't the
garbage collector remain unscheduled unless the task exits or closes an
unrelated, non-cyclic af_unix socket?

Could this regression lead to legitimate operations failing with
-ETOOMANYREFS for unprivileged processes, or allow a privileged process
to bypass RLIMIT_NOFILE and leak memory unboundedly?

[Severity: Low]
Does removing this call leave the user parameter in unix_schedule_gc()
as dead code?

If all other callers now unconditionally pass NULL, the conditional logic
checking user in unix_schedule_gc() will permanently evaluate to false:

net/unix/garbage.c:unix_schedule_gc() {
    ...
	if (user &&
	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
		return;
    ...
	if (user && READ_ONCE(unix_graph_cyclic_sccs))
		flush_work(&unix_gc_work);
    ...
}

Should the user parameter and these checks be removed as well?

>  	return 0;
> =20
>  err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784712370.gi=
t.namcao@linutronix.de?part=3D2
