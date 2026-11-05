Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903243;
	b=DBHX0Y6oC75oI1XyVBx4sTtmniFKKo6zCMon22Byhbq5VYTkRGNEUYg4Ahu+O9Pzvk0e
	 hg8v8DkyBX1ephJu35+c0r7knB3Qnv5TXlQs21kCc+rwxMjR7sKxyuTMQxA8piaJrXcFX
	 fBBg2dpBYh1cpZSykQ+BcKtpOLcV7QRW7Xb0ncKFcNRhKGIvNciQ/+UOn5MLqPyNvHPu4
	 FQU1mmJRKmyX8yS0qjogsQE2sO+W2HKHxkG2kYaIVONtlEaZ+sZgu0HJUlhVvLy0cCdfv
	 +dAEYS/gw4xFpLu+aYabK2CI6eTXXcU4QPQhbOJhR3gMT2vUBxdmjMyQuLs+LeqbkAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903243;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v9bf5TraVDBw+BXmTb1pntN5SpIF/07yRWB5dx4ozSk=;
	b=mq5lY2zZMWvky7miX0KttjqpQRB+QQdBnqsbn7mHK59mr24ttwIeDiJUyvTlqYu5Oq9z
	 vB26nxZ3yRkEIlgm7jmbTUydhEU6kBJARhw/dmfxVj3Vx1SpdC8dw5GF9Z+CfiVmuS6Fh
	 kUt8kBgtiOCtYAOUqcnwxnDSTy7CeFHN3cMYMVRnxDnv7l8F8vtMDYJxL6F+uY6d6Xi0z
	 aSwhOT7eS1PdiEWBv8N/2VO+xwpDRUkSlHAa5DqCZEA8lUh/fV47aWarZET/Yl8VWa1Rb
	 3ul3WEUJxUu6vZYcDASm3Z2deuxKbhbsndZmnr3+PYbGT+bd/L7DHHSQSFfg/hEiMnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jxijkUNy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6wHXkpcO;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344F606A32D
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 18:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D344F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jxijkUNy;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6wHXkpcO
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793903214; bh=v9bf5TraVDBw+BXmTb1pntN
	5SpIF/07yRWB5dx4ozSk=; b=jxijkUNyQgQC1O1YGmbst97vWkuVILwTT5hFnAYwqO31iYFotj
	O8wuTJsU9UAhcVBggQnbSGcSq98QztSdPHe9lvErSJCKSYgZHAVyT3I9O/0PcozKC4xDaFkNY+0
	a2733LyWSky2Be2rYqN5SsEId9l3pRjo4Yilh26P+1IAnvrMVCgP7HQMMFCLHZ3f2ooyvyKm+5Y
	EOZNcyR8OLn6VQcK9nzeVzvDhQwIMLXKtqX0hIwmYrWLXrbCZYTlmD/E3Z3It0JX8KjTGNDEnH5
	oS+D4oUfqAmB92wCbZryNqXJmz4B3sErHZ3w8X0O5zvulaTqx+Hmf6blWS838H7sKrg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793903214; bh=v9bf5TraVDBw+BXmTb1pntN
	5SpIF/07yRWB5dx4ozSk=; b=6wHXkpcO6iGutudRYL+m+fjmRMISpYO8vKX0LYJgGDeGK4Yhlx
	daJjlqEex/J2QweYq4L5O+a1MA+o/TwfsiBg==;
Date: Thu, 05 Nov 2026 18:26:57 +0000
From: Bradley Morgan <brads@mainlining.org>
To: bigeasy@linutronix.de
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, juri.lelli@redhat.com,
 linux-rt-devel@lists.linux.dev, mingo@redhat.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, peterz@infradead.org, rcu@vger.kernel.org,
 urezki@gmail.com
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
In-Reply-To: <20261105165113.82N-rPMG@linutronix.de>
Message-ID: <3422A405-7F7A-4CD4-AFEF-52E91BFB7C47@mainlining.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 November 2026 16:51:13 GMT, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
>tests") added the ability to disable RT throttling while rcutorture was
>run.
>
>Since v6.12 the DL fair_server takes control of throttling and this
>interface no longer serves this purpose. That sysctl control still
>exists but serves a different cause.
>
>There is no in-kernel interface to provide this feature, one needs to
>echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.
>
>Since sysctl_sched_rt_runtime does not do what it once did, remove it
>from rcutorture.
>

Thanks a ton for this patch!

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>---
> kernel/rcu/rcu.h        |  2 --
> kernel/rcu/rcutorture.c | 35 -----------------------------------
> 2 files changed, 37 deletions(-)
>
>diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>index d60444bf3a02d..6d1034e49d411 100644
>--- a/kernel/rcu/rcu.h
>+++ b/kernel/rcu/rcu.h
>@@ -69,8 +69,6 @@
> /* A complete grace period count */
> #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
> 
>-extern int sysctl_sched_rt_runtime;
>-
> /*
>  * Return the counter portion of a sequence number previously returned
>  * by rcu_seq_snap() or rcu_seq_current().
>diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>index 968343be4e0d1..acab425e72ad5 100644
>--- a/kernel/rcu/rcutorture.c
>+++ b/kernel/rcu/rcutorture.c
>@@ -1333,39 +1333,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
> 	return cur_ops->gp_diff(new, old);
> }
> 
>-/*
>- * RCU torture priority-boost testing.  Runs one real-time thread per
>- * CPU for moderate bursts, repeatedly starting grace periods and waiting
>- * for them to complete.  If a given grace period takes too long, we assume
>- * that priority inversion has occurred.
>- */
>-
>-static int old_rt_runtime = -1;
>-
>-static void rcu_torture_disable_rt_throttle(void)
>-{
>-	/*
>-	 * Disable RT throttling so that rcutorture's boost threads don't get
>-	 * throttled. Only possible if rcutorture is built-in otherwise the
>-	 * user should manually do this by setting the sched_rt_period_us and
>-	 * sched_rt_runtime sysctls.
>-	 */
>-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
>-		return;
>-
>-	old_rt_runtime = sysctl_sched_rt_runtime;
>-	sysctl_sched_rt_runtime = -1;
>-}
>-
>-static void rcu_torture_enable_rt_throttle(void)
>-{
>-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
>-		return;
>-
>-	sysctl_sched_rt_runtime = old_rt_runtime;
>-	old_rt_runtime = -1;
>-}
>-
> static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned
> long *start)
> {
> 	int cpu;
>@@ -3390,7 +3357,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
> 	mutex_lock(&boost_mutex);
> 	t = boost_tasks[cpu];
> 	boost_tasks[cpu] = NULL;
>-	rcu_torture_enable_rt_throttle();
> 	mutex_unlock(&boost_mutex);
> 
> 	/* This must be outside of the mutex, otherwise deadlock! */
>@@ -3428,7 +3394,6 @@ static int rcutorture_booster_init(unsigned int cpu)
> 
> 	/* Don't allow time recalculation while creating a new task. */
> 	mutex_lock(&boost_mutex);
>-	rcu_torture_disable_rt_throttle();
> 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
> 	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
> 					      cpu, "rcu_torture_boost_%u");
>

--- Thanks!
