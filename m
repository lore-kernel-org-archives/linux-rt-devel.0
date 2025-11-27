Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843133439A
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254511; cv=none; b=trQE8rncNiEX4W8XY3cZT/Wl/Jyz7wx4EcJS2CeDNzvKWtXb5mTLWe4NWf3qNHOIT0gIPjk/9KgyNeGGr7Zfi5EU31wq+74m+sdgbwsPkGB87Go7SXHIbhm0JG/SThjvkbbgCjUm0JF0w3VbnhpWuvsRAzWLNEaUSK7QMv8UxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254511; c=relaxed/simple;
	bh=mBXFMyuA/+uvgg1e1tZTYz66SG6k1jXOm1aq3j/vPTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDcY9VZ7Jwz85+M0PCUK172QEo/f5hmSZ93kS64/tm2nTM1j8NUQQtIsPtQKSnytC3ymy2to8zVl81hbSyiASbNvTndM5QD2rnyDXLvYlEECVv44EZwBpSsCFXxGasO/nTy5/CxxMGzB9RrdjZLqMFGv9q34QJAmjizw2Cn91UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1e2XTZmM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4PnikXAq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1e2XTZmM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4PnikXAq"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764254507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqtXUCy4i2F0qVjrJBNNXMVce8pO9EjY//yGVt1pI3U=;
	b=1e2XTZmMc/TFWb4XfXCHp5HoBhQUyToTbPMC5UByXTs4IQa6UnLn2iW6Kq6CalPnUsDls+
	k7RgKucoA9mk4oUesjwqI4qZhceHKd4S1WcIC5XsG9S3405vJ0/3JyyMh3Qek7HQhoP7rn
	QI5sHmJZmKQ0Wbslp/FxrS7UUyhA0nPd927F2jOxT3FZocxuzrJ9lq9SvAs8oJH4xrcQ0P
	NiRI/yTrk1cBo6ucmF2Jfqc4Y3Ck6pAzwJjX+662BJuufD6IgrNhAZiM7KYRs52syiOBjV
	03CdUgA26I2XfZff6ZeWypT+zKF8UiA2haebUep/S0+nEVaqDbEk1WxR3EsQMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764254507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqtXUCy4i2F0qVjrJBNNXMVce8pO9EjY//yGVt1pI3U=;
	b=4PnikXAqV7Opac0syQA1PDNwFzAU4BBJ2U8xUBw2OKh7HxfoM/tVzednmnHhkOQa/xc+fn
	8f8aBhK2ooOUkHDw==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce risk of shadowing
Date: Thu, 27 Nov 2025 15:41:40 +0100
Message-ID: <20251127144140.215722-3-bigeasy@linutronix.de>
In-Reply-To: <20251127144140.215722-1-bigeasy@linutronix.de>
References: <20251127144140.215722-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vincent Mailhol <mailhol@kernel.org>

The Linux kernel coding style advises to avoid common variable
names in function-like macros to reduce the risk of collisions.

Throughout local_lock_internal.h, several macros use the rather common
variable names 'l' and 'tl'. This already resulted in an actual
collision: the __local_lock_acquire() function like macro is currently
shadowing the parameter 'l' of the:

  class_##_name##_t class_##_name##_constructor(_type *l)

function factory from linux/cleanup.h.

Rename the variable 'l' to '__l' and the variable 'tl' to '__tl'
throughout the file to fix the current name collision and to prevent
future ones.

[ bigeasy: Rebase, update all l and tl instances in macros ]

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock_internal.h | 62 ++++++++++++++---------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index a4dc479157b5c..8f82b4eb542f2 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -99,18 +99,18 @@ do {								\
=20
 #define __local_lock_acquire(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l =3D (local_lock_t *)(lock);				\
-		tl =3D (local_trylock_t *)l;				\
+		__l =3D (local_lock_t *)(lock);				\
+		__tl =3D (local_trylock_t *)__l;				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired =3D=3D 0);	\
-				WRITE_ONCE(tl->acquired, 1);		\
+				lockdep_assert(__tl->acquired =3D=3D 0);	\
+				WRITE_ONCE(__tl->acquired, 1);		\
 			}),						\
 			local_lock_t *: (void)0);			\
-		local_lock_acquire(l);					\
+		local_lock_acquire(__l);				\
 	} while (0)
=20
 #define __local_lock(lock)					\
@@ -133,36 +133,36 @@ do {								\
=20
 #define __local_trylock(lock)					\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		preempt_disable();				\
-		tl =3D (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl =3D (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			preempt_enable();			\
-			tl =3D NULL;				\
+			__tl =3D NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
=20
 #define __local_trylock_irqsave(lock, flags)			\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		local_irq_save(flags);				\
-		tl =3D (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl =3D (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			local_irq_restore(flags);		\
-			tl =3D NULL;				\
+			__tl =3D NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
=20
 /* preemption or migration must be disabled before calling __local_lock_is=
_locked */
@@ -170,16 +170,16 @@ do {								\
=20
 #define __local_lock_release(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l =3D (local_lock_t *)(lock);				\
-		tl =3D (local_trylock_t *)l;				\
-		local_lock_release(l);					\
+		__l =3D (local_lock_t *)(lock);				\
+		__tl =3D (local_trylock_t *)__l;				\
+		local_lock_release(__l);				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired =3D=3D 1);	\
-				WRITE_ONCE(tl->acquired, 0);		\
+				lockdep_assert(__tl->acquired =3D=3D 1);	\
+				WRITE_ONCE(__tl->acquired, 0);		\
 			}),						\
 			local_lock_t *: (void)0);			\
 	} while (0)
@@ -223,12 +223,12 @@ typedef spinlock_t local_trylock_t;
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 #define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
=20
-#define __local_lock_init(l)					\
+#define __local_lock_init(__l)					\
 	do {							\
-		local_spin_lock_init((l));			\
+		local_spin_lock_init((__l));			\
 	} while (0)
=20
-#define __local_trylock_init(l)			__local_lock_init(l)
+#define __local_trylock_init(__l)			__local_lock_init(__l)
=20
 #define __local_lock(__lock)					\
 	do {							\
--=20
2.51.0

