Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF2424D5A;
	Thu, 23 Jul 2026 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799117; cv=none; b=rJyderqVtpCudUXuJKYu8HSVQM3JTr8+6yTvuruVSfA3Fb/uUGUrBfljK7Oopeus/q2pEc1YOEVuWU9gDIhSht702xfsCOGf6Yd9+f1ctXYcP65BQVcnGgz42KwgK3EZan0BZiFjPnXX6wpwFaZiPpYrwsOO6bXEMaOPaUkJWp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799117; c=relaxed/simple;
	bh=OA+z3FsTTMW9oDbn5SqZapoYUlO4cqVP8L/Jy26u7fI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JcfWFg14b2HljoRiUQ/2rMdazaGETMRpZ2xhG7AWoaAT7vYJ44TeKK3vvZI8vjHfmSL8djHmzT4p7L3sriN/WlGKBPsUtrEIwPmjGFnj+BYpB2blQhPTY5XpLuSQXZk/2u4P/C5xXifiiOFGr/j/NzovAw9dFdCDLgfqu44pFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW1BhyX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW1BhyX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB141F000E9;
	Thu, 23 Jul 2026 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799116;
	bh=SyJAZKVKDenfJqn/tM1yLuel/bmPPemVXz2xKaeEdMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XW1BhyX9leQ4dxEmA02LjEB3PNvw35kxG/nhrXSY2RDI6CMx8yjEG2f0KUDZvFb55
	 7goQHD85JHbrSuu4odgmuP5H/muhphAPBPEL9lulb764zmA7/anF4Zus4GM3jpaCou
	 2VyNeJ69iy9/p8wxBvYl89Wyz0Kd7B2XBwEHzp4pHD8wqBnQgO6rwtsfl+mJJ6BLlk
	 k8YM9tL+VZ/lBDraQN5k/ABP+tTOoz3YZD9shtoGuMGX567dllFog9u+kplwIrVZLm
	 dqGZtj30t1sTanFHGKQyv0eAqUw5qa5/sq4KkWWecG+9o9G3nZyZLpugrsDo9g6+yB
	 YEZpYYu3ZIfwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 3/3] af_unix: Clean up unix_schedule_gc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <79c2a0d700639a430bacea5dd9581caebcd54b08.1784712370.git.namcao@linutronix.de>
References: <cover.1784712370.git.namcao@linutronix.de>
 <79c2a0d700639a430bacea5dd9581caebcd54b08.1784712370.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:31:54 +0000
Message-Id: <20260723093155.DDB141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] An unconditional call to `unix_schedule_gc()` in `do_exit()` cause=
s a severe system-wide GC storm and CPU exhaustion if any live cyclic AF_UN=
IX sockets exist.
--

--- Patch [3]: [PATCH net-next v3 3/3] af_unix: Clean up unix_schedule_gc()=
 ---
commit fc308672f15e1ad0994af5c62a43b996e97d2e7a
Author: Nam Cao <namcao@linutronix.de>

af_unix: Clean up unix_schedule_gc()

This commit simplifies unix_schedule_gc() by removing its user argument,
since it is currently only called with NULL. The conditionals checking the
user parameter within the function body are also removed.

> diff --git a/kernel/exit.c b/kernel/exit.c
> index 593ac4b0105f2..50c5eff07bd65 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1014,7 +1014,7 @@ void __noreturn do_exit(long code)
>  	 * Must be after exit_files() and exit_task_work(tsk) to ensure that
>  	 * the task's AF_UNIX sockets have all been closed.
>  	 */
> -	unix_schedule_gc(NULL);
> +	unix_schedule_gc();
> =20
>  	sched_autogroup_exit_task(tsk);
>  	cgroup_task_exit(tsk);

[ ... ]

> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index f180c59b3da9d..d46aeb9d20518 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -635,23 +635,11 @@ static void unix_gc(struct work_struct *work)
> =20
>  static DECLARE_WORK(unix_gc_work, unix_gc);
> =20
> -#define UNIX_INFLIGHT_SANE_USER		(SCM_MAX_FD * 8)
> -
> -void unix_schedule_gc(struct user_struct *user)
> +void unix_schedule_gc(void)
>  {
>  	if (READ_ONCE(unix_graph_state) =3D=3D UNIX_GRAPH_NOT_CYCLIC)
>  		return;
> =20
> -	/* Penalise users who want to send AF_UNIX sockets
> -	 * but whose sockets have not been received yet.
> -	 */
> -	if (user &&
> -	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
> -		return;
> -
>  	if (!READ_ONCE(gc_in_progress))
>  		queue_work(system_dfl_wq, &unix_gc_work);

[Severity: High]
Does this unconditional call to unix_schedule_gc() from do_exit() create a
risk of system-wide GC storms?

If an unprivileged local user creates a cyclic graph of AF_UNIX sockets (for
example, by sending the FDs of a socketpair to each other) and keeps the fi=
le
descriptors open, it forms a "live" cycle.

In this scenario:
1. unix_graph_state becomes UNIX_GRAPH_CYCLIC (as set in unix_walk_scc_fast=
).
2. When unix_gc_work runs, it ignores the live cycle but leaves
   unix_graph_state as UNIX_GRAPH_CYCLIC.
3. Once GC finishes, gc_in_progress becomes false.

Since do_exit() unconditionally calls unix_schedule_gc(), any unrelated task
exiting anywhere in the system will immediately re-queue the GC.

Could this result in CPU exhaustion and a denial of service due to heavy lo=
ck
contention on unix_gc_lock, as the GC continuously walks the inflight socket
graph?

> -
> -	if (user && READ_ONCE(unix_graph_cyclic_sccs))
> -		flush_work(&unix_gc_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784712370.gi=
t.namcao@linutronix.de?part=3D3
