Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897477;
	b=iG+sU4rnye8YTWn5XOSHwj2SM81F8sM9N1T2F5ObN3pQC5PA5KlrxYGOpPN6P968F+BI
	 6dtL1lccyfSEoq3jE/BaPyK4HZZtP6gcJ75w/ee/rPq7FXgoeGAcF1ESfUvFTf8GukUvE
	 Yj8OF5gKuh3mHsYLPi/8AhmeRFd4vHSfe6cB7jz9oyhVRBoRj/+UbWW5B6LIbG7FubNPp
	 ISbx6mJS0TeN2ZFpz1lkIkCUMTTs++JRM6QMbaX7nHR3I2rwD6vPGMO5gPMR3jgqx9S0+
	 HB020GSKXWZnX3UFsYBUKKsdrCiNAwI7OLWtLeoQkv1JTRaomiGP2k5uYmmGofUrSyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897477;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=dRY4RgE8pVrnvLjUzvGh8641xUK8KLSvtxfM6OHu1ZU=;
	b=VlMW3+4WHKXoUgAox2KWgoFq63xuV7nIxCkBSjM9V2UgSxXtwguzw++Z9RfobdbA8DAN
	 GDX6xKjais4xWG1XFqdj1w6+7WZ6YLTpOml3KUyzgO7VJsLntNRGaM109Cj55VnecgqZG
	 tfNH/HFp0qQdkIimkGTG9Ny98OOc8vgKLbI0QI8gHmtRSpCcnQGQstkDELJbHpprengoK
	 bvc+D0T6JaCXeTXoB0LjFBKl9F9fs/ztyyeHsgvc9e7t86aqtWxqyLd6GbCCLqtRwis1G
	 /Y3BPLcmqTsxu5VaUwY7UUCcg1pKiLy+FnTFgbGQl20PnO98fPKLU6ivwa8O3at7atw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DZpD2FgP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=bJieYEle;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC8606D807
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 16:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCC8606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DZpD2FgP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=bJieYEle
Date: Thu, 5 Nov 2026 17:51:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793897474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dRY4RgE8pVrnvLjUzvGh8641xUK8KLSvtxfM6OHu1ZU=;
	b=DZpD2FgPKlCj0ePyzA+cOucwIMpQP0h4LURA9oKIJhl3x/xp/od/5eO+wXqYL0B49Szr+Q
	DA8rospYVPvevmV3sBj2LjLJudlsl+PTT5+Bgz/DU9qUifymbdaqmayNncQDXl5u8fWQMd
	+xCYOAGx6IXPkuKfRJUZM+b3LpSpxlTTKdL1KSe4qOXTXBSwkWE4dBsZsaKz3UQXDLKghR
	zYYBFYpxoq9+M/tQjBgGlC3h73JRO/7tOU38I/QxX7cBtUvxmbSJ8jazh/YovBkvj+3TMk
	P4a62JhQNXuUPGD5obvKum7mMwYl24YxEjMCxSVw23cx1V2aXUeWo2YiRUx0vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793897474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dRY4RgE8pVrnvLjUzvGh8641xUK8KLSvtxfM6OHu1ZU=;
	b=bJieYEleus19EWqjvuenQVna0BV9Aggee5606Vk9jNZciQqmVdGHb05/si9be82YSdVPL5
	ZXmDKghxN7lDXSCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <20261105165113.82N-rPMG@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
tests") added the ability to disable RT throttling while rcutorture was
run.

Since v6.12 the DL fair_server takes control of throttling and this
interface no longer serves this purpose. That sysctl control still
exists but serves a different cause.

There is no in-kernel interface to provide this feature, one needs to
echo -1 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.

Since sysctl_sched_rt_runtime does not do what it once did, remove it
from rcutorture.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/rcu.h        |  2 --
 kernel/rcu/rcutorture.c | 35 -----------------------------------
 2 files changed, 37 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d60444bf3a02d..6d1034e49d411 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -69,8 +69,6 @@
 /* A complete grace period count */
 #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
 
-extern int sysctl_sched_rt_runtime;
-
 /*
  * Return the counter portion of a sequence number previously returned
  * by rcu_seq_snap() or rcu_seq_current().
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 968343be4e0d1..acab425e72ad5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1333,39 +1333,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 	return cur_ops->gp_diff(new, old);
 }
 
-/*
- * RCU torture priority-boost testing.  Runs one real-time thread per
- * CPU for moderate bursts, repeatedly starting grace periods and waiting
- * for them to complete.  If a given grace period takes too long, we assume
- * that priority inversion has occurred.
- */
-
-static int old_rt_runtime = -1;
-
-static void rcu_torture_disable_rt_throttle(void)
-{
-	/*
-	 * Disable RT throttling so that rcutorture's boost threads don't get
-	 * throttled. Only possible if rcutorture is built-in otherwise the
-	 * user should manually do this by setting the sched_rt_period_us and
-	 * sched_rt_runtime sysctls.
-	 */
-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
-		return;
-
-	old_rt_runtime = sysctl_sched_rt_runtime;
-	sysctl_sched_rt_runtime = -1;
-}
-
-static void rcu_torture_enable_rt_throttle(void)
-{
-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
-		return;
-
-	sysctl_sched_rt_runtime = old_rt_runtime;
-	old_rt_runtime = -1;
-}
-
 static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
 {
 	int cpu;
@@ -3390,7 +3357,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
 	mutex_lock(&boost_mutex);
 	t = boost_tasks[cpu];
 	boost_tasks[cpu] = NULL;
-	rcu_torture_enable_rt_throttle();
 	mutex_unlock(&boost_mutex);
 
 	/* This must be outside of the mutex, otherwise deadlock! */
@@ -3428,7 +3394,6 @@ static int rcutorture_booster_init(unsigned int cpu)
 
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
-	rcu_torture_disable_rt_throttle();
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
 	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
 					      cpu, "rcu_torture_boost_%u");
-- 
2.55.0

