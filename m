Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052F25A347
	for <linux-rt-devel@lists.linux.dev>; Fri,  7 Mar 2025 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390127; cv=none; b=mQVvzwq6DZuDT0/5uUGboFnLXjOIi99d41cJn/pNEO1dhpkrSgP6+cLVwNU8/w6q2OodMo14bAwoYARGlkYVsAWowjK0A9n5ojKnFOeI5fB1dSdqCcrJ5uDcF7uXhtYmTPo2S0zZuNGj3Mc5yikXCa4jI4LB2O3LFK9yExCHw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390127; c=relaxed/simple;
	bh=51MZLzXkS/gAmyurVHEUuvnawFcO89opK6dXX3LX/B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXOwQiwj/IW9Dmz3F4tgt1nMolm5r+dt+PFJ6pTxHWVFIYjtmksiDSuoPfssltyXHx17HjVVNDoNS1mLryvucxD9dXvUl1C7oO/IOX4t0/uGzqjyaKXlT8rNXTN5EKWBfXMoNT1hy56kPbHPAQjyrtDBL3DEtc4TTQHzU3otnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTPbAcST; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTPbAcST"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c2303a56d6so269348785a.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 07 Mar 2025 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390125; x=1741994925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cUiFX8pTShZ5Z5nSz7FJsuU+rZ7PTZP7Um1B6Q+rnpc=;
        b=BTPbAcSTHqYlZMkvasuODXfCjWIF5yBO1a7fg98L8NIFwtZojG6qY7eKRUSexBULFd
         nz7ucluMWPZ6YMH5YknbJ5YT+ZtEmDAmzApA2wTxzY1Y+V0rI1zUuP1NbixfZGmOfKoQ
         qapdBo6T34YC6Ni605NRJZ+G199hcJlmTRMMN3w0/cnjGE+fL+J6gpctPEbotKcF3gU1
         HZ8iyxN0L5nv435JgANHwd3uo1+m+NbyGzm0G7trANUDYrzeCVItl4MwKTFLBnTBsJ2M
         +U3dNZ+UlEX7PZd32e74RAArT7gCiy1ZGhXAXv8AQGzzRERiesiKWiSxzvXmUvclCnRe
         y2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390125; x=1741994925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUiFX8pTShZ5Z5nSz7FJsuU+rZ7PTZP7Um1B6Q+rnpc=;
        b=MpOabfs41ij4dgKDtH23orydBqf/Wuwdz58NHHf+YC73RYEzqnv1KvH5vsyJLaVcyw
         QjTemu9XksE3qdT9vFRAiOyxobccCj8MfIt+nas6Oszv8+EW7UoOPpYdEd+h6nQdENA2
         GMt9GDcPT93WFa//nfPHJh+DI1sWRNowUj6IxoZSGrH7GRFPwtKMoXR0k8UPxIPUK9IF
         YaRdxTTuWLwddJ2n6V4sqSxr4I7Dw7Fv6x8yq0dileB/5xuKETBHHZsYhuibCWkXEHQ5
         HKVCnrJipnQRa2vXhnOeJY62zmF55mcSxjM4Pcj704rxAvDaF5ytcwAszzXAAQlr6azp
         DElQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjhmnLFnW3/Q2XvfGwrSh0hcn+TCBAdrUiash+W1edViEU2+cq3BU2XiAdYGO36PR4jA6ttfNytAR1p1nIUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2u3b/nj3AsnmC+UhXTnvm+XqD3ZEJ+l5K9y0ijcZW3rbomLbj
	W75bgw84/gLWOuSCTYm5xW9/lfBRhTphXSPuYaNxc132KJPAedwb
X-Gm-Gg: ASbGnctuBfm+hW5YNoTVxPftdkZ1Ra5k5vemqGNwa1/rZgfu1wUWtMXGOys6N2eXi0x
	AxE+tkGcsGx5dqyO154XptxwS1liRqSrwILQsmBEbd+7pSFL07vq3uK8RIR+ChWNLFBkLrQqAiZ
	DNbOSdqbaMznvSWxta29+RYL2uO/rqmy7zmjvxkal25Vp2VqX9ArGoXOXIlvoha8e+TnCfzgtPk
	KbhJk9nlapsNACGyccK3nIZNJrkm6g3No45LMLj8tO9B43m3WZs9LxXQDltJcmXozT7bsuH6Sqg
	Dn+VHR47aAvRo9onBl+KhvguHRHNga6FutKe8n/33rONN8/Anw6tA+J7iqdFhjJh1txRZXhCGno
	7TOs31AaA6SdSjaaec6JWFhN/qS7NUbpiTI8=
X-Google-Smtp-Source: AGHT+IHuhEDsVS6PpbJiWQoNhXqLd6dP41mFNik4w0hbc1MxTAzVESDNoU2wQmZU3Iq2nn/VRxKxGw==
X-Received: by 2002:a05:620a:2814:b0:7c0:9fb1:683d with SMTP id af79cd13be357-7c4e61122c3mr709955585a.34.1741390123430;
        Fri, 07 Mar 2025 15:28:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e54ff881sm302599785a.68.2025.03.07.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:28:43 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9A785120006A;
	Fri,  7 Mar 2025 18:28:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 07 Mar 2025 18:28:42 -0500
X-ME-Sender: <xms:KoHLZxigqGl5pj9oLtpedyIkMyEyviQhtLhBTNkSlVhrtapRhqCMfA>
    <xme:KoHLZ2DWtypl060MwaxFk6EQvr7OdBp53MR6a7ASuZPMb2qG3kSFzIfm3s90yfwvd
    qpm8THoC4SUMiXSgg>
X-ME-Received: <xmr:KoHLZxHfwDIccgYHUmPFy5b-sC2aFjfGtb3WchfPkBS1kXBP37cGzimVOcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhnghhosehr
    vgguhhgrthdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtoheptghlrhhkfihllhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KoHLZ2SsF4uOs56qewi1EluO02O4EdcYxfTNoY24gNlEOefK6P-j0Q>
    <xmx:KoHLZ-wCal69hVppPOOyWb_WdsFrGR8Y-ifeWkjTByvlytxFSDJiKA>
    <xmx:KoHLZ87iOUylkxOf24lxH785RHomsiLMCqFaoRiDsDdf7ZQg_YXQEw>
    <xmx:KoHLZzw38KKVxCWylTLEZydtw3iSNXtIrYh3zgn5ngtCxgEHR9O5vg>
    <xmx:KoHLZ2g56C26w2wJx7IKX8E4uHUkhkPDEileuFuyFwOEL1Ag7KBTlH91>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:28:42 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Subject: [PATCH locking 02/11] locking/semaphore: Use wake_q to wake up processes outside lock critical section
Date: Fri,  7 Mar 2025 15:26:52 -0800
Message-ID: <20250307232717.1759087-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

A circular lock dependency splat has been seen involving down_trylock().

[ 4011.795602] ======================================================
[ 4011.795603] WARNING: possible circular locking dependency detected
[ 4011.795607] 6.12.0-41.el10.s390x+debug
[ 4011.795612] ------------------------------------------------------
[ 4011.795613] dd/32479 is trying to acquire lock:
[ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
[ 4011.795636]
[ 4011.795636] but task is already holding lock:
[ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0

  the existing dependency chain (in reverse order) is:
  -> #4 (&zone->lock){-.-.}-{2:2}:
  -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
  -> #2 (&rq->__lock){-.-.}-{2:2}:
  -> #1 (&p->pi_lock){-.-.}-{2:2}:
  -> #0 ((console_sem).lock){-.-.}-{2:2}:

The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
while holding the console.sem raw_spinlock. This dependency can be broken
by using wake_q to do the wakeup instead of calling try_to_wake_up()
under the console_sem lock. This will also make the semaphore's
raw_spinlock become a terminal lock without taking any further locks
underneath it.

The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
the debug_objects_fill_pool() helper function in the debugobjects code.

[ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
[ 4011.795650]        __lock_acquire+0xe86/0x1cc0
[ 4011.795655]        lock_acquire.part.0+0x258/0x630
[ 4011.795657]        lock_acquire+0xb8/0xe0
[ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
[ 4011.795663]        rmqueue_bulk+0xac/0x8f0
[ 4011.795665]        __rmqueue_pcplist+0x580/0x830
[ 4011.795667]        rmqueue_pcplist+0xfc/0x470
[ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
[ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
[ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
[ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
[ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
[ 4011.795684]        allocate_slab+0x320/0x460
[ 4011.795686]        ___slab_alloc+0xa58/0x12b0
[ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
[ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
[ 4011.795692]        fill_pool+0xf6/0x450
[ 4011.795697]        debug_object_activate+0xfe/0x360
[ 4011.795700]        enqueue_hrtimer+0x34/0x190
[ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
[ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
[ 4011.795707]        hrtimer_interrupt+0x316/0x760
[ 4011.795709]        do_IRQ+0x9a/0xe0
[ 4011.795712]        do_irq_async+0xf6/0x160

Normally raw_spinlock to spinlock dependency is not legit
and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
but debug_objects_fill_pool() is an exception as it explicitly
allows this dependency for non-PREEMPT_RT kernel without causing
PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
legit and not a bug.

Anyway, semaphore is the only locking primitive left that is still
using try_to_wake_up() to do wakeup inside critical section, all the
other locking primitives had been migrated to use wake_q to do wakeup
outside of the critical section. It is also possible that there are
other circular locking dependencies involving printk/console_sem or
other existing/new semaphores lurking somewhere which may show up in
the future. Let just do the migration now to wake_q to avoid headache
like this.

Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250127013127.3913153-1-longman@redhat.com
---
 kernel/locking/semaphore.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 34bfae72f295..de9117c0e671 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/wake_q.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
@@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
 static noinline int __down_interruptible(struct semaphore *sem);
 static noinline int __down_killable(struct semaphore *sem);
 static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
 
 /**
  * down - acquire the semaphore
@@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
 void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(list_empty(&sem->wait_list)))
 		sem->count++;
 	else
-		__up(sem);
+		__up(sem, &wake_q);
 	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	if (!wake_q_empty(&wake_q))
+		wake_up_q(&wake_q);
 }
 EXPORT_SYMBOL(up);
 
@@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
 	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 
-static noinline void __sched __up(struct semaphore *sem)
+static noinline void __sched __up(struct semaphore *sem,
+				  struct wake_q_head *wake_q)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
 	list_del(&waiter->list);
 	waiter->up = true;
-	wake_up_process(waiter->task);
+	wake_q_add(wake_q, waiter->task);
 }
-- 
2.47.1

