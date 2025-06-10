Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC628DB42
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Jun 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553330; cv=none; b=BJhWmM7nd58mPgbcBstyNzU4HqKeRkRDbEF7dnPkHpDsVlxclmPVD/cOcs42SR69v8XHRcDpqFHWyN6wzh2fsUsonrdbLpwlB+GYuyLWmIPkMEKAU+QqdkfqAxghHIeGalUsB2bmQNb5fxw24MUeuPTA9mULLv6GqjwvxzxmvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553330; c=relaxed/simple;
	bh=pnumnEgMONqC2sB0h2/3e/8Px5yvws2pdjGq64D49Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FChMIUTx5juvYlCa4rCM+GUpXXJaKUOkQSQwKNB2OO07TZwYbZ1H9KoVnVtPtVqTjEwc0AaE+976N1VLVguZAQpFYCNSukV1KpUhrH1nISr54ih8uGx/66JUZYOpYF6qY/outsFvdTYxvKN90O08CP/uRUjcOxMujIWiYy/iPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3tgKEga; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3t0OotR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3tgKEga";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3t0OotR"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749553327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9L1epFIrxpVQ8bZI5Xv86SU+O2nArDBf9rMp846oO1Q=;
	b=F3tgKEgaax6gQgaRFpSuoJ6/4d6z000z83SHZ0rQ8xymuOfaGtlsyqqsTo1jDlpqTI7PwC
	fwxx2CHBlV2OeVKCuLfpSvjbzoj8qzEDIUfZW06whQlr9ioGH25I/vzRUlIdG+7+bv4ZxN
	0BhVRydfKa0syOa6aeGv1CJooDGy8fhSqH79I0S+yxUwOqzvvs0Q9Tmm2D2UHt2Mq/znNv
	kX0eyBTKAPgIokXFYaHjXRr6jDhlxuiQncyLx9qpIuxPvxkJIt2TPGpv8LN8TEc83JK1un
	zi6bviLs2gJGqrGktE8nLDG/ByMs9Gk4J4Rk10oLSruxMtI+Zc8Q6kFHGLqNxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749553327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9L1epFIrxpVQ8bZI5Xv86SU+O2nArDBf9rMp846oO1Q=;
	b=W3t0OotR82kgiAotMTuKlEw1d3Fh45tbtus2VlC4eIq14DZ4qOkwDKKTo6gt4UKmtikbkJ
	X38ycAO1TOuGLrDQ==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/1] local_lock: Move this_cpu_ptr() notation from internal to main header.
Date: Tue, 10 Jun 2025 13:02:04 +0200
Message-ID: <20250610110205.1111719-2-bigeasy@linutronix.de>
In-Reply-To: <20250610110205.1111719-1-bigeasy@linutronix.de>
References: <20250610110205.1111719-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The local_lock.h is the main entry for the local_lock_t type and
provides wrappers around internal functions prefixed with __ in
local_lock_internal.h.

Move the this_cpu_ptr() dereference of the variable from the internal to
the main header. Since it is all macro implemented, this_cpu_ptr() will
still happen within the preempt/ IRQ disabled section.
This will free the internal implementation (__) to be used on
local_lock_t types which are local variables and must not be accessed
via this_cpu_ptr().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h          | 20 +++++++++----------
 include/linux/local_lock_internal.h | 30 ++++++++++++++---------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 16a2ee4f8310b..2ba8464195244 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -13,13 +13,13 @@
  * local_lock - Acquire a per CPU local lock
  * @lock:	The lock variable
  */
-#define local_lock(lock)		__local_lock(lock)
+#define local_lock(lock)		__local_lock(this_cpu_ptr(lock))
=20
 /**
  * local_lock_irq - Acquire a per CPU local lock and disable interrupts
  * @lock:	The lock variable
  */
-#define local_lock_irq(lock)		__local_lock_irq(lock)
+#define local_lock_irq(lock)		__local_lock_irq(this_cpu_ptr(lock))
=20
 /**
  * local_lock_irqsave - Acquire a per CPU local lock, save and disable
@@ -28,19 +28,19 @@
  * @flags:	Storage for interrupt flags
  */
 #define local_lock_irqsave(lock, flags)				\
-	__local_lock_irqsave(lock, flags)
+	__local_lock_irqsave(this_cpu_ptr(lock), flags)
=20
 /**
  * local_unlock - Release a per CPU local lock
  * @lock:	The lock variable
  */
-#define local_unlock(lock)		__local_unlock(lock)
+#define local_unlock(lock)		__local_unlock(this_cpu_ptr(lock))
=20
 /**
  * local_unlock_irq - Release a per CPU local lock and enable interrupts
  * @lock:	The lock variable
  */
-#define local_unlock_irq(lock)		__local_unlock_irq(lock)
+#define local_unlock_irq(lock)		__local_unlock_irq(this_cpu_ptr(lock))
=20
 /**
  * local_unlock_irqrestore - Release a per CPU local lock and restore
@@ -49,7 +49,7 @@
  * @flags:      Interrupt flags to restore
  */
 #define local_unlock_irqrestore(lock, flags)			\
-	__local_unlock_irqrestore(lock, flags)
+	__local_unlock_irqrestore(this_cpu_ptr(lock), flags)
=20
 /**
  * local_lock_init - Runtime initialize a lock instance
@@ -64,7 +64,7 @@
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define local_trylock(lock)		__local_trylock(lock)
+#define local_trylock(lock)		__local_trylock(this_cpu_ptr(lock))
=20
 /**
  * local_trylock_irqsave - Try to acquire a per CPU local lock, save and d=
isable
@@ -77,7 +77,7 @@
  * HARDIRQ context on PREEMPT_RT.
  */
 #define local_trylock_irqsave(lock, flags)			\
-	__local_trylock_irqsave(lock, flags)
+	__local_trylock_irqsave(this_cpu_ptr(lock), flags)
=20
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
@@ -91,10 +91,10 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __=
percpu,
 		    unsigned long flags)
=20
 #define local_lock_nested_bh(_lock)				\
-	__local_lock_nested_bh(_lock)
+	__local_lock_nested_bh(this_cpu_ptr(_lock))
=20
 #define local_unlock_nested_bh(_lock)				\
-	__local_unlock_nested_bh(_lock)
+	__local_unlock_nested_bh(this_cpu_ptr(_lock))
=20
 DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
 	     local_lock_nested_bh(_T),
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 8d5ac16a9b179..b4d7b24882835 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -99,14 +99,14 @@ do {								\
 		local_trylock_t *tl;					\
 		local_lock_t *l;					\
 									\
-		l =3D (local_lock_t *)this_cpu_ptr(lock);			\
+		l =3D (local_lock_t *)(lock);			\
 		tl =3D (local_trylock_t *)l;				\
 		_Generic((lock),					\
-			__percpu local_trylock_t *: ({			\
+			local_trylock_t *: ({			\
 				lockdep_assert(tl->acquired =3D=3D 0);	\
 				WRITE_ONCE(tl->acquired, 1);		\
 			}),						\
-			__percpu local_lock_t *: (void)0);		\
+			local_lock_t *: (void)0);		\
 		local_lock_acquire(l);					\
 	} while (0)
=20
@@ -133,7 +133,7 @@ do {								\
 		local_trylock_t *tl;				\
 								\
 		preempt_disable();				\
-		tl =3D this_cpu_ptr(lock);			\
+		tl =3D (lock);					\
 		if (READ_ONCE(tl->acquired)) {			\
 			preempt_enable();			\
 			tl =3D NULL;				\
@@ -150,7 +150,7 @@ do {								\
 		local_trylock_t *tl;				\
 								\
 		local_irq_save(flags);				\
-		tl =3D this_cpu_ptr(lock);			\
+		tl =3D (lock);					\
 		if (READ_ONCE(tl->acquired)) {			\
 			local_irq_restore(flags);		\
 			tl =3D NULL;				\
@@ -167,15 +167,15 @@ do {								\
 		local_trylock_t *tl;					\
 		local_lock_t *l;					\
 									\
-		l =3D (local_lock_t *)this_cpu_ptr(lock);			\
+		l =3D (local_lock_t *)(lock);				\
 		tl =3D (local_trylock_t *)l;				\
 		local_lock_release(l);					\
 		_Generic((lock),					\
-			__percpu local_trylock_t *: ({			\
+			local_trylock_t *: ({			\
 				lockdep_assert(tl->acquired =3D=3D 1);	\
 				WRITE_ONCE(tl->acquired, 0);		\
 			}),						\
-			__percpu local_lock_t *: (void)0);		\
+			local_lock_t *: (void)0);		\
 	} while (0)
=20
 #define __local_unlock(lock)					\
@@ -199,11 +199,11 @@ do {								\
 #define __local_lock_nested_bh(lock)				\
 	do {							\
 		lockdep_assert_in_softirq();			\
-		local_lock_acquire(this_cpu_ptr(lock));	\
+		local_lock_acquire((lock));			\
 	} while (0)
=20
 #define __local_unlock_nested_bh(lock)				\
-	local_lock_release(this_cpu_ptr(lock))
+	local_lock_release((lock))
=20
 #else /* !CONFIG_PREEMPT_RT */
=20
@@ -227,7 +227,7 @@ typedef spinlock_t local_trylock_t;
 #define __local_lock(__lock)					\
 	do {							\
 		migrate_disable();				\
-		spin_lock(this_cpu_ptr((__lock)));		\
+		spin_lock((__lock));				\
 	} while (0)
=20
 #define __local_lock_irq(lock)			__local_lock(lock)
@@ -241,7 +241,7 @@ typedef spinlock_t local_trylock_t;
=20
 #define __local_unlock(__lock)					\
 	do {							\
-		spin_unlock(this_cpu_ptr((__lock)));		\
+		spin_unlock((__lock));				\
 		migrate_enable();				\
 	} while (0)
=20
@@ -252,12 +252,12 @@ typedef spinlock_t local_trylock_t;
 #define __local_lock_nested_bh(lock)				\
 do {								\
 	lockdep_assert_in_softirq_func();			\
-	spin_lock(this_cpu_ptr(lock));				\
+	spin_lock((lock));					\
 } while (0)
=20
 #define __local_unlock_nested_bh(lock)				\
 do {								\
-	spin_unlock(this_cpu_ptr((lock)));			\
+	spin_unlock((lock));					\
 } while (0)
=20
 #define __local_trylock(lock)					\
@@ -268,7 +268,7 @@ do {								\
 			__locked =3D 0;				\
 		} else {					\
 			migrate_disable();			\
-			__locked =3D spin_trylock(this_cpu_ptr((lock)));	\
+			__locked =3D spin_trylock((lock));	\
 			if (!__locked)				\
 				migrate_enable();		\
 		}						\
--=20
2.49.0

