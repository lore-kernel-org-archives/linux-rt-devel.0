Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E88424D76;
	Thu, 23 Jul 2026 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799118; cv=none; b=tA8U3b5F4bn1jnD2hiV9oOqnvuYPpT3VHP8jISZANtCTUcC2dkAb9TPnXY9aJHK3VuI5InZAI+pD9M/jP+d+SbM6Ok5Ln/xVi5LDDFI30ZR2BNLrRvZAB7DC4oiIVp1XwtjY7YNtG1om2swOccYYtK1quw3gy7nAu7EfRHCWXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799118; c=relaxed/simple;
	bh=RWcNRxBbg3lXxRxj+8TS7R/kkFibFRa3C5wEJBPkIQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzYxBiriPvX05n+lzg7hDrPkLlggnJrq7Nn2f7IY3dvZJiNBYPDh/KFPROkejUTx93OBnICJDdj4HKHDjLAxjNA1OrKMz75/CUZltfr5pCKPJCFmcxkAyGSvgrpu9CsRWpjB4pQrImr3m6WLFS+o2SxE2EShrAsPi8yyfdUSSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPMfUVj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPMfUVj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE571F00A3A;
	Thu, 23 Jul 2026 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799116;
	bh=xk+h6zrZwQGEblLp5f0GalUVaM+X7VKVrbT5NaaW2yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPMfUVj01d9CtShRlabsGRo0Cor9Ue7houbzNJyr6YAY2LR7UPWLVtei8fxlUUHZA
	 aKqy6VIxuKW1ic6p5T0lRf5aLXWLbGBBcjZhlUf/22rwzczcGckp95gG0SgwMcKfL4
	 gkPMIgw7jOMzrD5GgMdQKycFoLhT+/GvtV7FL6Sh56blKvl3HFsf9K3eCc4bw/vlXV
	 bumm2woGNOFrakL82KutmobPIcXufPgqTnTsESsbL4SiWgxxF0qUeT+lkrM3KrW402
	 1aaHYP/2GQtXvseWDK7uUywDTzuZ3a3ytRBi/3RQKm9f1T+47qMfwVYXflNDr91E7S
	 y4H0hcn/DehGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/3] af_unix: Schedule the garbage collector
 at task exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
References: <cover.1784712370.git.namcao@linutronix.de>
 <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:31:56 +0000
Message-Id: <20260723093156.8CE571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditionally triggering the global AF_UNIX garbage collector on=
 task exit creates a severe system-wide denial of service vulnerability.
- [Medium] A TOCTOU race on `gc_in_progress` causes `do_exit()` to skip que=
ueing the garbage collector if it is currently running, leaving the cyclic =
sockets leaked indefinitely.
--

--- Patch [1]: [PATCH net-next v3 1/3] af_unix: Schedule the garbage collec=
tor at task exit ---
commit 9a35b6370cf5aa7dba01e2ce8f06d95e2eb14265
Author: Nam Cao <namcao@linutronix.de>

af_unix: Schedule the garbage collector at task exit

This commit attempts to fix a memory leak involving dead cyclic reference
AF_UNIX sockets when a task exits. It does this by scheduling the garbage
collector during task exit, after the task's file descriptors have been
closed.

> diff --git a/kernel/exit.c b/kernel/exit.c
> index 2c0b1c02920f4..593ac4b0105f2 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
[ ... ]
> @@ -1009,6 +1010,12 @@ void __noreturn do_exit(long code)
>  	exit_task_work(tsk);
>  	exit_thread(tsk);
> =20
> +	/*
> +	 * Must be after exit_files() and exit_task_work(tsk) to ensure that
> +	 * the task's AF_UNIX sockets have all been closed.
> +	 */
> +	unix_schedule_gc(NULL);

[Severity: High]
Does unconditionally triggering the global AF_UNIX garbage collector on task
exit create a severe system-wide denial of service vulnerability?

By passing NULL to unix_schedule_gc(), the rate-limiting check
(user->unix_inflight) is bypassed. If an unprivileged user creates a cyclic
graph of AF_UNIX sockets, every task exit system-wide would unconditionally
queue unix_gc_work.

The GC thread would then take the global unix_gc_lock spinlock and perform
an O(N) traversal of all cyclic sockets, burning CPU and blocking all
legitimate AF_UNIX operations system-wide.

[Severity: Medium]
Can a race on gc_in_progress cause do_exit() to skip queueing the garbage
collector if it is currently running, leaving the cyclic sockets leaked
indefinitely?

If a background GC run is currently active, gc_in_progress is true. If the
concurrent GC scans the exiting task's sockets before they are closed, it
considers them alive.

When the exiting task subsequently closes them and calls
unix_schedule_gc(NULL), it sees gc_in_progress is true and silently skips
queueing a new GC pass. This fails to reliably fix the socket leak it was
intended to resolve.

> +
>  	sched_autogroup_exit_task(tsk);
>  	cgroup_task_exit(tsk);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784712370.gi=
t.namcao@linutronix.de?part=3D1
