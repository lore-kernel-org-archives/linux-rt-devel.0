Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474230C141;
	Sat, 18 Jul 2026 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356057; cv=none; b=hdlolS8wpHPRNcPS7jpf0lKTegd2nikj2TKIlgOgM115Iqbh4G1eGFWcDFBzNWwBUyWlm7mkK7cv+8zKil/BsZMGiw7Q+w6Xjdq8H3qqzDB1bXsLUBRArY6BXZvJKfimgnj8AD/NYyfgVqnrAothhW3D5+Pe9yLTPaoAxTpgin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356057; c=relaxed/simple;
	bh=r33ZnNdw93WrGYA5rBf4DveJ6zTy/Flqvh+wfw7CcqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozJCM/05HriRhMZxDrWfxih3MmG4WlJmijZpMUpn7YbW/8Qq+WYs8D4d1Iz6jhFCXQWUDeDQSQ4VK8FzDgFtlYfZAXuSlq2xv0qhdwS2lCKPPZ3W/1tZ54Xb/0U6r2VBhaj/DZhEGCDxiGTfXvJTnC9nGlC+H3XKzVJ1xsYZxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdStRZH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdStRZH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199E41F000E9;
	Sat, 18 Jul 2026 06:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784356056;
	bh=ngDUQtHjFUIYvdNgeAV4i6YS7Owci0iw31oav+755x0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LdStRZH5GNuuHP2/BkuJ96cdTKviJQ/f6srdaXX/XJzaM26McS9PdkO9cbfPRaqs4
	 rqBLkbOEvD3zN1YC6HnGVcZidFlb5c9AITHWezR8UoTJ8Q2L0KGWIn0mVH7IoXUu2i
	 PkUK72lwfdymzr5ysBXWjtSj9E9/S67W2K32ZqrjjQTHzhCEwVOGV2rGHOv2ikzVSc
	 7ulb2FPkAQASAKy8cdf0UGQ4EFG7RYX/ODA83iXIECS+oiV7LjQR+9w4YBXcMLn7wX
	 +0rSIUrVv/IdJZ1SbU8M5bPy+0Gp5SJrDGDgBNtig1Z0Xu62+5qBAXT6loqFQTpwn7
	 jGH6/qpC8d6jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/3] af_unix: Schedule the garbage collector
 at task exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <d500ff36af658ad412e5d6f8d5665070359ef68e.1784268931.git.namcao@linutronix.de>
References: <cover.1784268931.git.namcao@linutronix.de>
 <d500ff36af658ad412e5d6f8d5665070359ef68e.1784268931.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 06:27:35 +0000
Message-Id: <20260718062736.199E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch reuses `unix_schedule_gc()` in `do_exit()`, but its `g=
c_in_progress` optimization introduces a race condition that leaks cyclic s=
ockets during concurrent task exits.
--

--- Patch [1]: [PATCH net-next v2 1/3] af_unix: Schedule the garbage collec=
tor at task exit ---
commit a622ecdd6ba9403d5e403273ed947355870471a8
Author: Nam Cao <namcao@linutronix.de>

af_unix: Schedule the garbage collector at task exit

This commit aims to resolve an issue where dead cyclic reference AF_UNIX
sockets stay behind indefinitely when a task exits. It does so by
scheduling the garbage collector during task exit, after the task's file
descriptors have been closed.

> diff --git a/kernel/exit.c b/kernel/exit.c
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -997,6 +998,7 @@ void __noreturn do_exit(long code)
>  	exit_sem(tsk);
>  	exit_shm(tsk);
>  	exit_files(tsk);
> +	unix_schedule_gc(NULL); /* Must be after exit_files() */

[Severity: Medium]
Will this race with concurrent task exits and leak cyclic sockets?

In net/unix/garbage.c, unix_schedule_gc() only queues the work if a garbage
collection is not already running:

void unix_schedule_gc(void)
{
        if (!READ_ONCE(gc_in_progress))
                queue_work(system_dfl_wq, &unix_gc_work);
}

If Task A and Task B exit concurrently with dead cyclic sockets:

Task A calls unix_schedule_gc() and triggers the work, which sets
gc_in_progress to true.

Task B then calls unix_schedule_gc() while the GC is running, observes
gc_in_progress is true, and silently skips queuing the work.

Task B's newly dead cycles might be missed by the currently running GC pass.
Since no new GC is queued by Task B, won't those sockets stay behind
indefinitely until another unrelated task exits, defeating the purpose of
the patch for concurrent exits?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784268931.gi=
t.namcao@linutronix.de?part=3D1
