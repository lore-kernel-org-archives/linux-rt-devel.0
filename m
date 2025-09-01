Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD52EF66A
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Sep 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744699; cv=none; b=iLk9Wrpp1KsCPtsHT+pgnCBczQsw01G/7ATV4ULtB/+8OScKsYUIJuq6ERdvy1MwMQCUTlGaYvfqO4G5/b1BxCZ4sWhvPWd0y2q5NvwrR+KCKP6+BA1SJeVRiVV4b8aW0FVRPAYEMA3O7TQVGCQAQ/kzdXZZFNV03YEgSqVYccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744699; c=relaxed/simple;
	bh=ntLMxMTJJL8iq2rbfSuz0Vqw+9K2PaY2gC9lbyvr3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoiGXg4WJUoWiTOUBJiLNCkXathSEDstphL9BvenPuZsAvRv3U5WzD5NZFBnoCxHZD/HtFrilAHIeUDCaAGyuqDkDvawn8WkuHOAC91+dUEUnkR4E/lZCK38MGFZdJ/2B8NZ92XI3PKvsN7acp93t2i7l/BPi4uiGr2M2rngfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vg2L5s3A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PotjeZeJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vg2L5s3A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PotjeZeJ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756744696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpqMI9FznM8U9iJMEFpqpF+IGwhgXp8qLalooxsCxCo=;
	b=Vg2L5s3Aeu3pWukpzsHFtKelYefl6wKlCH56F/aFlW9jgYn7QO3/j4t9fe+baOZPDOVJVK
	GsTgU+mGdEGQ28mBfyH0Cve7ouE4on1syDchRwLj82HVHuy3sIdgc2fsY3gdEIIXu0zmt0
	TNBz78/6TUAGdTBLtamtKmW1L9qdJQ+HnKiMJEBXPstF650UjYhGMAzShMo0TK9Mi0s+BI
	r6WxLM9DKmaTHuVzIvAe0j/R9y/nMK4gECcth7iJaRHAmAdSSK+VKH2rJZ9lFdBO78p/Vy
	mabwyfKtAJDF+dgb1IDLguPcdscbBJ88nm1xm2a3LfNy0xgHDl8ibEFNtG5RSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756744696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpqMI9FznM8U9iJMEFpqpF+IGwhgXp8qLalooxsCxCo=;
	b=PotjeZeJYGw8dF/H2QWUiyXu5lvEBKA8y5CQEk02RPz5r9/OdRVttW4H+DEmYzE8zA8g4P
	NTQI7wRICMEougCw==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/3] softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT
Date: Mon,  1 Sep 2025 18:38:11 +0200
Message-ID: <20250901163811.963326-4-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-1-bigeasy@linutronix.de>
References: <20250901163811.963326-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

softirqs are preemptible on PREEMPT_RT. There is synchronisation between
individual sections which disable bottom halves. This in turn means that
a forced threaded interrupt can not preempt another forced threaded
interrupt. Instead it will PI-boost the other handler and wait for its
completion.

This is required because code within a softirq section is assumed to be
non-preemptible and may expect exclusive access to per-CPU resources
such as variables or pinned timers.
Code with such expectation has been identified and updated to use
local_lock_nested_bh() for locking of the per-CPU resource. This means
the lock can be removed.

Add CONFIG_PREEMPT_RT_NEEDS_BH_LOCK which keeps the old behaviour if
selected. Otherwise the softirq synchronising is lifted. The
softirq_ctrl.cnt accounting remains to let NOHZ code if softirqs are
currently handled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/Kconfig.preempt | 13 +++++++
 kernel/softirq.c       | 83 ++++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 54ea59ff8fbeb..da326800c1c9b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -103,6 +103,19 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
=20
+config PREEMPT_RT_NEEDS_BH_LOCK
+	bool "Enforce softirq synchronisation on PREEMPT_RT"
+	depends on PREEMPT_RT
+	help
+	  Enforce synchronisation across the softirqs context. On PREEMPT_RT
+	  the softirq is preemptible. This enforces the same per-CPU BLK
+	  semantic non-PREEMPT_RT builds have. This should not be needed
+	  because per-CPU locks were added to avoid the per-CPU BKL.
+
+	  This switch provides the old behaviour for testing reasons. Select
+	  this if you suspect an error with preemptible softirq and want test
+	  the old synchronized behaviour.
+
 config PREEMPT_COUNT
        bool
=20
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4e2c980e7712e..77198911b8dd4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -165,7 +165,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned =
int cnt)
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
-			local_lock(&softirq_ctrl.lock);
+			if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+				local_lock(&softirq_ctrl.lock);
+			else
+				migrate_disable();
+
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
@@ -177,17 +181,34 @@ void __local_bh_disable_ip(unsigned long ip, unsigned=
 int cnt)
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt =3D __this_cpu_add_return(softirq_ctrl.cnt, cnt);
-	/*
-	 * Reflect the result in the task state to prevent recursion on the
-	 * local lock and to make softirq_count() & al work.
-	 */
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_add_return(softirq_ctrl.cnt, cnt);
+		/*
+		 * Reflect the result in the task state to prevent recursion on the
+		 * local lock and to make softirq_count() & al work.
+		 */
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
-		raw_local_irq_save(flags);
-		lockdep_softirqs_off(ip);
-		raw_local_irq_restore(flags);
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
+	} else {
+		bool sirq_dis =3D false;
+
+		if (!current->softirq_disable_cnt)
+			sirq_dis =3D true;
+
+		this_cpu_add(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt +=3D cnt;
+		WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_dis) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
@@ -195,23 +216,42 @@ EXPORT_SYMBOL(__local_bh_disable_ip);
 static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
 	unsigned long flags;
+	bool sirq_en =3D false;
 	int newcnt;
=20
-	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
-			    this_cpu_read(softirq_ctrl.cnt));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
+				    this_cpu_read(softirq_ctrl.cnt));
+		if (softirq_count() =3D=3D cnt)
+			sirq_en =3D true;
+	} else {
+		if (current->softirq_disable_cnt =3D=3D cnt)
+			sirq_en =3D true;
+	}
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() =3D=3D cnt) {
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_en) {
 		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
 		raw_local_irq_restore(flags);
 	}
=20
-	newcnt =3D __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (!newcnt && unlock) {
-		rcu_read_unlock();
-		local_unlock(&softirq_ctrl.lock);
+		if (!newcnt && unlock) {
+			rcu_read_unlock();
+			local_unlock(&softirq_ctrl.lock);
+		}
+	} else {
+		current->softirq_disable_cnt -=3D cnt;
+		this_cpu_sub(softirq_ctrl.cnt, cnt);
+		if (unlock && !current->softirq_disable_cnt) {
+			migrate_enable();
+			rcu_read_unlock();
+		} else {
+			WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+		}
 	}
 }
=20
@@ -228,7 +268,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned i=
nt cnt)
 	lock_map_release(&bh_lock_map);
=20
 	local_irq_save(flags);
-	curcnt =3D __this_cpu_read(softirq_ctrl.cnt);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+		curcnt =3D this_cpu_read(softirq_ctrl.cnt);
+	else
+		curcnt =3D current->softirq_disable_cnt;
=20
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to
--=20
2.51.0

