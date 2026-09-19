Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DB33122A
	for <linux-rt-devel@lists.linux.dev>; Sat, 19 Sep 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838093; cv=none; b=FJPLGV2hjuysXQ00i6gwbuCB3EoQaEg7GIxQt1rgiaedxc8kd4+WAPig60RTZ0UHO0DYmGTbGcfUNYUh5E+cNugMHpLWDv5uikdMiYuh/WcYlr/pVCYn0ukVhSB7RrL4XORIs7Vu4gyCKAmmza325K4P9+nxULamIzEPO0rAuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838093; c=relaxed/simple;
	bh=PGZzHUHFHYTXrrUg2O+WQoA1hsv6kLUB3pqq1Y2X5Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyFxowXS2JRUTNGxHzKpgLTuFGBOBtJHeKDr3RoVSKgrmsb23KAs0rfOg37kXlw6Gy+7TW+Eq6w8zCNdLugVtXV54bBfNIzvXUmu7ylVOrgSzYaHZgGNM/xY6fqnh3NVbAebP/x/8NiLiPOKymBCxzktI1qDshiRSfaC8k2n3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHFgLEEX; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHFgLEEX"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so11766485e9.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 19 Sep 2026 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789838090; x=1790442890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PO9QkOcRvzbwAD+Es+kdxYQwQzMtVSQSyoVPRMtp9qc=;
        b=jHFgLEEXs0KzAOq49f9mM3XYNdiNh/mc+1mNJtCFQLD5PrKnLcLcMY6tIU4gBKYNFr
         P/PrKhJr/JapovmwqGX7v84kjWRsqAAEZM7Krltx/veuZ3iqENMwhX1UvogeRZkBRzLe
         AhQVmwPW1oMbkqHJ4vzFfbdQDnhi0+Hlg+pkDpVhwGOuEsptkvNLrE41HhchYI7Zefsm
         M0htKk0u2lS/Huyjy009j+jU5asiA0gYPlQPtQE40/asx2XCVebcypDTfrxwJbtNYRLo
         7LG9nWDvt5O0+PU/6fdjCThvmSV17N96numx13M/QOs6dbWybtgcE3fu0cNwOW0pvj/H
         DuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789838090; x=1790442890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PO9QkOcRvzbwAD+Es+kdxYQwQzMtVSQSyoVPRMtp9qc=;
        b=bh1b7L4VqmUsUo9SbR/6aLN61nuFbuf3ys7fyJP7rmR7KdDBzTqALqYmTqzURya+mY
         et0ZlzpOMUxcwSxHQlUf3lbsMGB+hAfaf5tq0sX41Mhgd0ESjilURJPhAbHw/avhNp1W
         3eME6Y+SJYGnWqNcU/M6I+yQOLIqeZQ9AHj92abIqPC2tH8/WijrFRPVoM49CI14fbXU
         2Xgiz/OWE64eoxwrJC/cDk+9eh5Zui8GoqVBm3IkoWIRQ9vtRuUmusdIvZQJjO3/2jBY
         b4pTfp4+6b3mujR1F37R3IAEfDR0jGBavgeNWyllbJr0k4ew4UN1ibL3RF/KmLDdn48i
         m2tg==
X-Forwarded-Encrypted: i=1; AKwUvBwSdqA8DcssyjUiPoyCIX6wLLvVipKtvq4qkk7aZXWJ9jihZpI8Nl8j4FqG1VXg62IfbKyWeSG6m64hZsSpGw==@lists.linux.dev
X-Gm-Message-State: AFuF++kg1iuvjKd51n1zXG1rTQ2g8RwDogxCBc5X1/DFKOp53IkZbvnK
	LfdSS3QNtIanadACKZEWFCGJqdKHd/YVgtCnRTf/p/MtwSaYlnMKcyLI
X-Gm-Gg: AYBFou3vwL2T8cdvZ+buREhgWBIrGGuegjQ//IYed5/n6OT05fT+gPQ4GOa8ItaiQFv
	EBhiHDYLEs1GaEtYKMLKpe7WAMYrR9RcvhvCQIJFVav4bDxqxLlAcX3MttIYkL4sHlc5zhDdR0n
	dBWSYO8SlBfJoqTwZ5jigvT5sQLZMi9y87B0F29jUwZuGyVQs1g5cQpM9q9oDJhfpB73cXJl4YH
	hiN4KSqU9jtigxjhJfM2NaqNI1BWwa964vlMbfa7hD3cH4UvG8Qon7sFjcHFjBdiYk/BDhscxS7
	SkRV1g6IV0RGC0pB/X8XGmyaaUDEgHnMmKeoDj3wVJCguVEymYF59+sLEoiHo80ZPcBbkQlyMCO
	N8tglsKvLElbUz9i82Wi1UPLGC+JRsawnxI5hfnEhBLx+EEUrubIUf2ylPrROkvwYQBlWPYE8m5
	fZO9+1KUbRAYL/ggxe/s+RmFhX1djkOMCUSycljOoxOW8QBgmqViSbOeNuE2+rwyJX9M3vF/naN
	68U81r8s1WJaMy7mX6NVPxw2YTf8nHMhjCF/6ySt5L5Gi85eZOIzea6QCbq8chvP0OXPsQQyGE+
	VvKkjEFXC0dBnfQbype4q30EErWqnw04rMsjKbZvh6qzjQXGhO3NiUT2C0bt2WSzfKh9zLiwZ19
	pqLHKJ6ns6V8Y9/Q=
X-Received: by 2002:a05:600c:468c:b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-49fc5671095mr87272955e9.7.1789838089820;
        Sat, 19 Sep 2026 10:14:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487244608e7sm8986486f8f.6.2026.09.19.10.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 10:14:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible context on PREEMPT_RT
Date: Sat, 19 Sep 2026 19:14:43 +0200
Message-Id: <20260919171443.90512-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT kmalloc_nolock() deadlocks the machine when the caller
holds a pi_lock. A BPF program which creates task local storage from
the sched_waking tracepoint is enough. With it mainline hangs in 10 of
10 boots on a Raspberry Pi 500+ and in 7 of 28 boots in a 4 CPU x86-64
QEMU guest. The CPUs spin on raw locks with interrupts disabled and
there is no output.

sched_waking fires in try_to_wake_up() with p->pi_lock held.
can_spin_trylock() refuses only NMI and hard interrupt context on
PREEMPT_RT, so kmalloc_nolock() does spin_trylock_irqsave() on
n->list_lock, which is a sleeping lock. Two things go wrong:

 - rt_spin_trylock() takes the rtmutex wait_lock under the pi_lock. A
   regular kmalloc() on another CPU holds wait_lock and takes a
   pi_lock in try_to_take_rt_mutex().

 - If the trylock succeeded and a waiter arrived, rt_spin_unlock() has
   to wake it. That is a try_to_wake_up() inside try_to_wake_up():

     try_to_wake_up               raw_spin_lock_irqsave(&p->pi_lock)
     rt_mutex_slowunlock
     rt_spin_unlock
     spin_unlock_irqrestore(&n->list_lock)
     get_from_partial_node
     ___slab_alloc
     __kmalloc_nolock_noprof
     bpf_local_storage_alloc
     ...
     bpf_trace_run1
     try_to_wake_up               sched_waking, a pi_lock is held

   The pi_lock held there belongs to the woken task, not to current.

Commit 99a3e3a1cfc9 ("slab: fix kmalloc_nolock() context check for
PREEMPT_RT") closed this for v6.19 with a !preemptible() check.
v7.0-rc1 relaxed it again, see the Fixes tag.

Allow preemptible context only, as v6.19 did. A held raw spinlock
implies !preemptible(), so the locks of the caller do not have to be
known. With this change both machines pass 10 of 10 boots.

The nolock allocations then fail on PREEMPT_RT from every context with
preemption or interrupts disabled, also where no scheduler lock is
held. Creation of BPF local storage from such a context fails, as it
did in v6.19.

Fixes: 073d5f156292 ("slab: simplify kmalloc_nolock()")
Assisted-by: LLM
---

Notes:
    RFC because I do not know if that last paragraph is acceptable for
    BPF. 073d5f156292 relaxed the check on purpose.
    
    Harry wrote that the _nolock() helpers can be called under pi_lock at
    least in theory, that it was tough to reproduce, and proposed a check
    of current's pi_lock:
    https://lore.kernel.org/r/apfwshahN_C6jBSn@nixos
    https://lore.kernel.org/r/apfyeYF8IE03aazT@nixos
    That check would not see the pi_lock in the stack above. Sebastian
    described the wait_lock and pi_lock order here:
    https://lore.kernel.org/r/20260831143500.x-saxdAs@linutronix.de
    
    Same config, program and load for all rows. x86-64 QEMU (TCG), 4 CPUs,
    PREEMPT_RT, no lockdep, 60 seconds of load per boot:
    
      v6.18                                  10 pass,  0 hang
      parent of f484f4a3e058                 10 pass,  0 hang
      f484f4a3e058                            0 pass, 10 hang
      v6.19                                  10 pass,  0 hang
      parent of 073d5f156292                 10 pass,  0 hang
      073d5f156292                            0 pass, 10 hang
      mainline 40288c9206c1 (v7.3-rc3)       21 pass,  7 hang
      mainline with this change              10 pass,  0 hang
    
    f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
    in local storage") made the path reachable.
    
    Raspberry Pi 500+, arm64 defconfig plus PREEMPT_RT, same mainline
    commit: the output stops 1 to 2 seconds after the load starts. 4 of the
    10 boots were then reset by the hardware watchdog. The other 6 made no
    more progress but still answered ping.
    
    The stacks are from gdb on the hung QEMU guests, I have none from the
    Pi. gdb does not unwind through the JITed program. The frames below it
    are from a raw dump of the stacks. In that capture three of four CPUs
    wait like this for the pi_lock of the same task. The first case looks
    like this, two CPUs from the BPF program against one regular kmalloc():
    
      rt_mutex_slowtrylock           raw_spin_lock(&lock->wait_lock)
      rt_spin_trylock
      spin_trylock_irqsave(&n->list_lock)
      get_from_partial_node
      ___slab_alloc
      __kmalloc_nolock_noprof
    
      try_to_take_rt_mutex           raw_spin_lock(&task->pi_lock)
      rtlock_slowlock_locked
      rtlock_slowlock
      rt_spin_lock
      spin_lock(&n->list_lock)
      get_from_partial_node
      ___slab_alloc
    
    With lockdep and DEBUG_RT_MUTEXES the same program gives "possible
    circular locking dependency detected" for wait_lock and pi_lock on the
    first event.
    
    The program:
    
      struct {
    	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
    	__uint(map_flags, BPF_F_NO_PREALLOC);
    	__type(key, int);
    	__type(value, long);
      } per_task SEC(".maps");
    
      SEC("tp_btf/sched_waking")
      int BPF_PROG(on_waking, struct task_struct *p)
      {
    	struct task_struct *cur = bpf_get_current_task_btf();
    	long *v;
    
    	v = bpf_task_storage_get(&per_task, cur, 0,
    				 BPF_LOCAL_STORAGE_GET_F_CREATE);
    	if (v)
    		bpf_task_storage_delete(&per_task, cur);
    	return 0;
      }
    
    The delete only makes every event allocate again. The load is a few
    loopback ping floods, tmpfs and block writes, /proc walks and fork/pipe
    loops, so that list_lock sees contention. The program is more
    aggressive than a real tool and the load is synthetic.
    
    can_spin_trylock() is also used by the page allocator. Its nolock free
    paths fall back to their deferred lists. I did not test those
    separately. Kernels before v7.3-rc1 have no can_spin_trylock() and need
    the check in kmalloc_nolock() instead.

 mm/internal.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 38b1165212c94..29646c4afb419 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1641,10 +1641,14 @@ static inline bool can_spin_trylock(void)
 	 * confuse PI logic, so return immediately if called from hard IRQ or
 	 * NMI.
 	 *
-	 * Note, irqs_disabled() case is ok. spin_trylock() can be called
-	 * from raw_spin_lock_irqsave region.
+	 * Task context with a raw spinlock held is not safe either. The
+	 * caller may hold a pi_lock, like a BPF program on a tracepoint in
+	 * try_to_wake_up(). rt_spin_trylock() takes the rtmutex wait_lock
+	 * and can take a pi_lock under it. rt_spin_unlock() wakes a waiter
+	 * if there is one, which takes a pi_lock again. The locks held by
+	 * the caller are not known here, so allow preemptible context only.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
 		return false;
 
 	/* On UP, spin_trylock() always succeeds even when it is locked */

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
-- 
2.53.0

