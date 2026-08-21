Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B343F4B7
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306294; cv=none; b=vDt5HXZTM1DwUj/8dVXPwtuN8SXCwQMsWNt0zMZA0TCx0i/ljgftg9NRExwZTKDrEmW4xMjcAxbR9x9FpgJ870WcLJNUd7JfxJXYsTVTDQTH1/kZcstFgjZ929I9PqMiUwl8l9//SdyMHnjA4X9bwz5iDN9M0ehuRghDBTmZR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306294; c=relaxed/simple;
	bh=+c7hoNds9Snhwyr8UXxD2TYxtQfySiyUnFl3pvuhglM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mCJNUP+b9EFNr8llGXfoZUfWzQ/npdDJ4RKml9X9ESdV2FkP2VaZRSO7kNdE6I/znxr9u0TDWam+pOcbd0P5HrImBeTUWHAYV3lnt0kfl0L0iTqTxByPildT6sSzvNotVlTEohkPkq6Kz5VUUfh44CZEYYMDSmi7nSl1gm/u+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IWHW3kV6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HjG1fODS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWHW3kV6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HjG1fODS"
Date: Fri, 21 Aug 2026 11:57:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787306277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qyUaXmGB2mdv+D0sBNnhoclj9x59kqqMWIb5B9TkZv0=;
	b=IWHW3kV6q5aZjBTcOk1/h1ewpxWKlK+mou21e8s/jlml64NITGeGV3Pkk9MEgSMbICRVWc
	Fqg6soV/Bb2CH5MJrP2K3x0FtUx/497SxXvzMv81slwlwG602meuvTPzW+uB7Y+iTkA2GB
	fG0h5c85DVgi5XLZQG80COUtuNf64zBtu14gvdwXOYgCBh0Kno3XIxpjTx1deFwfS2lCBT
	BKPgv+nSIo3DZzgaLKWoIcHIk498ICAJlRWaMNEQw7nMQ1ODai6RIkaG8Vkwd/LZTtLIia
	ZSYzUpnC8ctXu0vlkGf3TnYHT/2W8qpxSfynxx3jaU6vl/HEaXabkMvf377JTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787306277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qyUaXmGB2mdv+D0sBNnhoclj9x59kqqMWIb5B9TkZv0=;
	b=HjG1fODS8kh0If/2kfA4aKkS8opkSKzsyhVS/uuEuPeFyhyRmYnwUewYWqGgBXmKgyzQab
	AmK+9795fAlSNCAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>, Boqun Feng <boqun@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Sean Young <sean@mess.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] sched: Allow sleeping spinlocks on PREEMPT_RT within
 non_block_start()/end block.
Message-ID: <20260821095755.am1-Segb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit 312364f3534cc ("kernel.h: Add non_block_start/end()") added
non_block_star()/end(). The intention was to catch any callbacks which
depend on locks or sleep able conditionals in order to ensure forward
progress. According to the commit message spinlocks were excluded
"because spinlocks can't have an indirect dependency upon the page
allocator=E2=80=A6".
On PREEMPT_RT this leads to a splat because spinlock_t and rwlock_t are
turned into a sleeping spinlock which have a might_sleep() as they could
schedule() on lock contention.

Besids mm, the other used of non_block_start() is pwm. Here the hrtimer
can acnqure a spinlock_t on RT and I can't tell other user but I assume
it is not atomic on RT since it wouldn't be able to acquire its own
(spinlock_t) lock.

Since spinlock_t (and rwlock_t) are not problem, add a sleeping_lock
argument to __might_resched() signaling if this is scheduling request
is from a sleeping lock (true) or regular scheduling request (false).
Add the `true' argument to rtlock_might_resched() which is used on
PREEMPT_RT for both sleeping lock types.

Cc: Michal Hocko <mhocko@suse.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Young <sean@mess.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/kernel.h       |  5 +++--
 include/linux/sched.h        | 24 ++++++++++++------------
 kernel/locking/spinlock_rt.c |  2 +-
 kernel/sched/core.c          |  7 ++++---
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e5570a16cbb1a..fbafdfe9bdb78 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -70,7 +70,8 @@ extern int dynamic_might_resched(void);
 #endif /* CONFIG_PREEMPT_* */
=20
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void __might_resched(const char *file, int line, unsigned int offse=
ts);
+extern void __might_resched(const char *file, int line, unsigned int offse=
ts,
+			    bool rt_sleeping_lock);
 extern void __might_sleep(const char *file, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
@@ -128,7 +129,7 @@ extern void __cant_migrate(const char *file, int line);
 # define non_block_end() WARN_ON(current->non_block_count-- =3D=3D 0)
 #else
   static inline void __might_resched(const char *file, int line,
-				     unsigned int offsets) { }
+				     unsigned int offsets, bool rt_sleeping_lock) { }
 static inline void __might_sleep(const char *file, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 373bcc0598d10..650e42d55e1e8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2158,9 +2158,9 @@ static inline int _cond_resched(void)
=20
 #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
=20
-#define cond_resched() ({			\
-	__might_resched(__FILE__, __LINE__, 0);	\
-	_cond_resched();			\
+#define cond_resched() ({				\
+	__might_resched(__FILE__, __LINE__, 0, false);	\
+	_cond_resched();				\
 })
=20
 extern int __cond_resched_lock(spinlock_t *lock) __must_hold(lock);
@@ -2186,19 +2186,19 @@ extern int __cond_resched_rwlock_write(rwlock_t *lo=
ck) __must_hold(lock);
 	(PREEMPT_LOCK_OFFSET + (1U << MIGHT_RESCHED_RCU_SHIFT))
 #endif
=20
-#define cond_resched_lock(lock) ({						\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
-	__cond_resched_lock(lock);						\
+#define cond_resched_lock(lock) ({							\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS, false);=
	\
+	__cond_resched_lock(lock);							\
 })
=20
-#define cond_resched_rwlock_read(lock) ({					\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
-	__cond_resched_rwlock_read(lock);					\
+#define cond_resched_rwlock_read(lock) ({						\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS, false);=
	\
+	__cond_resched_rwlock_read(lock);						\
 })
=20
-#define cond_resched_rwlock_write(lock) ({					\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
-	__cond_resched_rwlock_write(lock);					\
+#define cond_resched_rwlock_write(lock) ({						\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS, false);=
	\
+	__cond_resched_rwlock_write(lock);						\
 })
=20
 #ifndef CONFIG_PREEMPT_RT
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 1d5e1b3c60bfa..0a89e7f10af18 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -33,7 +33,7 @@
 	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
=20
 #define rtlock_might_resched()						\
-	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS)
+	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS, true)
=20
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96226707c2f61..ee0fbb41fc61c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9123,7 +9123,7 @@ void __might_sleep(const char *file, int line)
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
=20
-	__might_resched(file, line, 0);
+	__might_resched(file, line, 0, false);
 }
 EXPORT_SYMBOL(__might_sleep);
=20
@@ -9148,7 +9148,8 @@ static inline bool resched_offsets_ok(unsigned int of=
fsets)
 	return nested =3D=3D offsets;
 }
=20
-void __might_resched(const char *file, int line, unsigned int offsets)
+void __might_resched(const char *file, int line, unsigned int offsets,
+		     bool rt_sleeping_lock)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -9159,7 +9160,7 @@ void __might_resched(const char *file, int line, unsi=
gned int offsets)
 	rcu_sleep_check();
=20
 	if ((resched_offsets_ok(offsets) && !irqs_disabled() &&
-	     !is_idle_task(current) && !current->non_block_count) ||
+	     !is_idle_task(current) && (rt_sleeping_lock || !current->non_block_c=
ount)) ||
 	    system_state =3D=3D SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
 	    oops_in_progress)
 		return;
--=20
2.55.0

