Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EA31065A
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Sep 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349214; cv=none; b=KW7LL5SBXLjkQj8gDMc3ZdLBF+eJW2bY1f4+MsaCc4c9W+w0xygnEcUbUYlKhU37fNCWScDyd60H9rDxVWBtEKC2sqSsrR1Pmbqm+u2GAy1bJeDD55lc2DB7LKU02e2bB/xa1vTiOLwpigPKy65pv90/23ah96ndH3Sz6G1V0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349214; c=relaxed/simple;
	bh=jLpdT6WhrqJOu7UxXQ3Hw7vlyXP7mwFC0zwLQ6teygw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DoPmGX8nI1vsotNxrDkK6EwEjo8SM0La1EE/iXKikjkuf+7pfNY60LhDPkWoX4SPubbw+KR/+9Rw2jqLiI7d3zrOQ0zw+f1T9pxxEHLGupPVHvrp1ZH2tscr5jxfX0zOgyoEXID6AexkAvzaJSvgHjSCBo+WZ1f8O2IY13GU6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUBQT9Qu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BToK0sq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUBQT9Qu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BToK0sq"
Date: Mon, 8 Sep 2025 18:33:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757349210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ep5i7rSz1UshP4xuWvUvQui+mCdWbbcXdRKFs5OzApM=;
	b=OUBQT9QuaGZWK0SmFHDdgnYKwXAp34FSCfh5OdZYr0SIH3mEbHvccyISbmy3HUkIiydWRB
	r5fvO0/ZqB/SgeoY82u7zXPcGUcOLZsN0LCMb6YsvSl+tCLexfWGjblnZF5njbt6qs6DEh
	Aw9FROO61Ckdwy+yUOEutDLxDGCd1cUZXIoKi4HW1SuOOXGtzco8lmUI6GUIyyS1xegzuI
	/ZNVIzb8hY2EZYRVoVkrtIQIBJnUPKnShoxuMQVriqYyIHiFj/guwSfut7EcbzkbMKhBLV
	nGwZ6yDHWgWzOYZ7yTAIFp0jo/iRhfzGJ/QGOOOILdZWytyvIQAuHhkV+pFqdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757349210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ep5i7rSz1UshP4xuWvUvQui+mCdWbbcXdRKFs5OzApM=;
	b=2BToK0sqKeCAPx+1HbLZQAF3hGIjIi3620/fSmQNtit+1yNtXnX4hOjVn1X1mvUMUXG+JR
	So+KTDAC4DQReSDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: libc-alpha@sourceware.org
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] nptl: Use a PI-aware lock for internal pthread_cond-related
 locking
Message-ID: <20250908163329.Qq79ujq_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The pthread_cond_t structure provides an internal lock using the lower two bits
of __g1_orig_size. This lock is always used by the signaller. The waiter uses
it only in certain corner cases such as when canceling a wait due to a timeout.

Under contention, a thread attempting to acquire the lock invokes the futex
operation FUTEX_WAIT while waiting for the lock to become available. This
behavior can be problematic in real-time environments because the priority of
the waiting task is not considered. As a result, a lower-priority task may
become runnable while the lock owner remains preempted.

To address this, repurpose the unused member __unused_initialized_1 as a
priority-inheritance (PI) futex named __pi_lock. This is the futex word, not a
pthread_mutex_t.

__condvar_acquire_lock() performs an atomic transition from 0 to TID. If it
fails, it falls back to __futex_lock_pi64(), which acquires the lock via
FUTEX_LOCK_PI.
__condvar_release_lock() performs an atomic transition from TID to 0. If it
fails, it falls back to futex_unlock_pi(), which releases the lock and
wakes a potential waiter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

This is a follow-up to
	https://lore.kernel.org/all/20250829145659.KhM4kIoQ@linutronix.de/

This change expects that PI-FUTEX is supported by the kernel. This is
the case since a long time but it is possible to disable the FUTEX
subsystem or the FUTEX_PI part of it while building the kernel.
Is it okay to assume that PI-FUTEX is available or should there be a
check somewhere during startup and in case of -ENOSYS a fallback to
current implementation?

 nptl/pthread_cond_common.c              | 58 ++++++++++---------------
 sysdeps/nptl/bits/thread-shared-types.h |  2 +-
 2 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/nptl/pthread_cond_common.c b/nptl/pthread_cond_common.c
index 2708d262958f2..74010787b18de 100644
--- a/nptl/pthread_cond_common.c
+++ b/nptl/pthread_cond_common.c
@@ -106,41 +106,23 @@ __condvar_fetch_xor_wseq_release (pthread_cond_t *cond, unsigned int val)
 #endif /* !__HAVE_64B_ATOMICS */
 
 /* The lock that signalers use.  See pthread_cond_wait_common for uses.
-   The lock is our normal three-state lock: not acquired (0) / acquired (1) /
-   acquired-with-futex_wake-request (2).  However, we need to preserve the
-   other bits in the unsigned int used for the lock, and therefore it is a
-   little more complex.  */
+   The lock is the futex PI lock (PTHREAD_MUTEX_PI_NORMAL_NP) using just the
+   futex word. */
 static void __attribute__ ((unused))
 __condvar_acquire_lock (pthread_cond_t *cond, int private)
 {
-  unsigned int s = atomic_load_relaxed (&cond->__data.__g1_orig_size);
-  while ((s & 3) == 0)
+  int oldval, newval;
+
+  newval = THREAD_GETMEM (THREAD_SELF, tid);
+  oldval = atomic_compare_and_exchange_val_acq (&cond->__data.__pi_lock,
+                                                newval, 0);
+  if (oldval != 0)
     {
-      if (atomic_compare_exchange_weak_acquire (&cond->__data.__g1_orig_size,
-	  &s, s | 1))
-	return;
-      /* TODO Spinning and back-off.  */
-    }
-  /* We can't change from not acquired to acquired, so try to change to
-     acquired-with-futex-wake-request and do a futex wait if we cannot change
-     from not acquired.  */
-  while (1)
-    {
-      while ((s & 3) != 2)
-	{
-	  if (atomic_compare_exchange_weak_acquire
-	      (&cond->__data.__g1_orig_size, &s, (s & ~(unsigned int) 3) | 2))
-	    {
-	      if ((s & 3) == 0)
-		return;
-	      break;
-	    }
-	  /* TODO Back off.  */
-	}
-      futex_wait_simple (&cond->__data.__g1_orig_size,
-	  (s & ~(unsigned int) 3) | 2, private);
-      /* Reload so we see a recent value.  */
-      s = atomic_load_relaxed (&cond->__data.__g1_orig_size);
+      int e;
+
+      e = __futex_lock_pi64 (&cond->__data.__pi_lock, 0, NULL, private);
+      if (e != 0)
+        futex_fatal_error ();
     }
 }
 
@@ -148,10 +130,16 @@ __condvar_acquire_lock (pthread_cond_t *cond, int private)
 static void __attribute__ ((unused))
 __condvar_release_lock (pthread_cond_t *cond, int private)
 {
-  if ((atomic_fetch_and_release (&cond->__data.__g1_orig_size,
-				 ~(unsigned int) 3) & 3)
-      == 2)
-    futex_wake (&cond->__data.__g1_orig_size, 1, private);
+  pid_t id = THREAD_GETMEM (THREAD_SELF, tid);
+
+  if (!atomic_compare_exchange_weak_release (&cond->__data.__pi_lock, &id, 0))
+    {
+      int e;
+
+      e = futex_unlock_pi ((unsigned int *) &cond->__data.__pi_lock, private);
+      if (e != 0)
+	futex_fatal_error ();
+    }
 }
 
 /* Only use this when having acquired the lock.  */
diff --git a/sysdeps/nptl/bits/thread-shared-types.h b/sysdeps/nptl/bits/thread-shared-types.h
index e614c7f3c900e..9b362d5282cd9 100644
--- a/sysdeps/nptl/bits/thread-shared-types.h
+++ b/sysdeps/nptl/bits/thread-shared-types.h
@@ -99,7 +99,7 @@ struct __pthread_cond_s
   unsigned int __g1_orig_size;
   unsigned int __wrefs;
   unsigned int __g_signals[2];
-  unsigned int __unused_initialized_1;
+  int __pi_lock;
   unsigned int __unused_initialized_2;
 };
 
-- 
2.51.0

