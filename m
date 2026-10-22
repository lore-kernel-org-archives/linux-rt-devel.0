Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637245;
	b=uGlGgGo0cbe/E8zBK85k1aoBdV91zWgic0ukLpeXWA/ydx2lw8IHnczE66hX4TOtvtBI
	 cHX/TThT4GlPT205B2JZmWr+lRAaCTvoTAJSZTRIUrWZzr0+N7ge6USUZavhYB9VeG5EW
	 PSPd8HiTf57xvTmUCQD4RcqN4THpyAc7HvdiY3HmFdB7+cmkBWaCtf4UW3LyhGjUcgfNk
	 sj5bobewH+QVob8mkhZMvIeex6nQthGbmX0FAvufQha8Ko7G2wej7Exw1AzOblDeHH6wl
	 u37qZWith6jVh2WtNn8PgHQ/LXZ4rPaHdcAoFvMj0pd2sBDKLkrboa+FIhRZuh/mFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LDiCxQcjQAeD8OMkln84Ebe26iu3V9fzssX8qiug9B0=;
	b=NRboop/xwLnxTYNutvzQNZhY1PS5w9Tkvv1xlxydU/QZijgK7JI7twUF7CEVLlQzNffb
	 MSmF6Enf46A3FNVtlpt6T5daL5SsiHbKGPShlKuQGdEKrdyr13MLPQ1wKc9QjHhBRCRAv
	 JPAWejaSNw1TlTT2wScLxVCY5S7dTgQTjRZgmY8ELPmEMyMwBddeIUub6m0mmVDP3xmXf
	 IJUmIjIdE4p/wNYONg/j+/x0aJzxSwlfdbCdjJ4Tbn37g3gm2N8diFosj64c2Ji62e7Nv
	 bl0VhnDQ/CEhNAfko+tYb4gMK7uPay0TjKkv5v+k+W3GYTVFztfA/wEZEtsfFHdYrZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CIWJhvt1;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EF606A31E
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 02:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E9EF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CIWJhvt1
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1996469eec.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637244; x=1793242044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDiCxQcjQAeD8OMkln84Ebe26iu3V9fzssX8qiug9B0=;
        b=CIWJhvt1hvZ3xjiZrs+xflxjiM5Fo7g9azI3aGJD+obKSma1FFAtz+DGMLnMhzT7hq
         DNjxY1vrBKKF5IHfCO5IPKdQ4LzvYVY5Dy9JW2gvV1szeeKHSIURJwmYndmAThh1xYKB
         c5eeWibwaljjLVRGArtHn88BTombGWM32n5aCWKaRpYjqP9zemSpm4xglXxaeS1uLzcx
         D57j3uXoORax6rzBrYTyBQvyUXc2IVvnvYgRm8F1ODhUnmNZhH1zp8KNCJLssqBp+NmI
         eQFJRUuFus3QJw8jOEYRWluitH4DrGcNlotT61aKmn9XCLgtrLf+N+wvUsp+ZIu/FpDz
         9d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637244; x=1793242044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LDiCxQcjQAeD8OMkln84Ebe26iu3V9fzssX8qiug9B0=;
        b=MhtV12aCCpmepz1OsEFU4zaTn2hJL7zrm4vIAm1WUa5zz/QagbLcAn9JuGqfgq2Kyf
         CYEfhCYfpOwwajU94Yx8oHFSgnA1GH99Pp/OPL/9cKP7zesH7gBElX1lEDdGt3LEnJTR
         /D2jOiY/unTNTCN9+Bm1U26SuEnaQwUhZ8Bd3bsr2qEBNW5G8DUEaQmD+G5JCplTk/my
         J0ioxbYP0JHkM96oOD6Q7l1blDCHZBUjRWqrLsbHW48/HOdqscWwueqH5NOJqEDUv1K/
         HsX9NpqT5M9A7ekXmzjMn3ygNQGuJrHBHtCsnNqZxaA3UH2dAX/FhXpKSPO6PBuIA8Lc
         psDw==
X-Forwarded-Encrypted: i=1; AKwUvBzzUDqqtDGppw4xmUGPFFIapa9Ua3SzEVYWlDzF7qPWDapP5+TzbO6Tg7aUAeLj88Ls+gV6ozrEdvJH28ycig==@lists.linux.dev
X-Gm-Message-State: AFq9FYLCh1cWd5eAafuQTb+heFZd0qvEZHdOB5jHujN3YxgsBcr2r0CE
	ji8+7nxvbleSjhChv8BBWZwzxW7/fHQc8RtaGSoBmcSMVyvnLeiswR0Y
X-Gm-Gg: AYBFou1ypwtkWXeR8WNAG+mfVrpNk2zaqwu7Iy2Nx+18D1gBxdZrjECzJyHt46ECAEE
	UuSxY9mPVjPdtatpn5tUeSQQCutef/saBSZkcroPTHIFiWP7xvp3KubddRn8Vxni9yPqlDKJCom
	OjFTRcjJa5Fjx+MKlzJlbac0ycwqLfLZ3CGJY7WlQPq69eYPXMhLljKAuKWBJqv4Qo/mNoVHA7J
	3vrK+g3CearpaYRRqgRCUerorDGcJKNGf1haz2W3hXf6y5pTs72DNxZX6cixSuWDSaB2t892n3J
	AhatbyInwSsNnvOQBgPjQJ8TGTD/F1epsM74aT7gckCrxYDNR00vnXNdymU9F9Sk+zkI0ZsEgja
	Jf2fGsZjxq6gJy57JuBJVT+ya5XLp8DhqwWT1pbwrMroOb7Otnz1ZSxJ9DWOhFzwYP2isK/nLWv
	jwfkPvKVAnTjeQsxWuAlXhii4zyhLIeUhSD6KfgdiXHSy8ZWq7c2df7iE+vq28FramD60AOE74d
	RAGw+cueA/WcHX3AfzLL28Nl90cgpXEPP+L+87DS+PpJH32TP11aLrW6bRlUFUJZKFUmsvBNKNc
	fEZS3OXs4lcfSfwh3rIgR3DIvit0a5p6Rj0DmKAEdlG+GaXnZ69XMKQnVRH7MXMLYCMW8MDfkYo
	zyCL7mQY=
X-Received: by 2002:a05:7300:72d0:b0:35d:187c:72cc with SMTP id 5a478bee46e88-3674de4c834mr6921854eec.23.1792637244223;
        Wed, 21 Oct 2026 19:47:24 -0700 (PDT)
Received: from server1868-4.tail96fc24.ts.net ([199.188.91.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca914bb8sm2318629eec.5.2026.10.21.19.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:47:23 -0700 (PDT)
From: Austin Schuh <austin.linux@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Austin Schuh <austin.linux@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [RFC PATCH 1/2] io_uring: don't let a preempted task_work add hold back the wake up
Date: Wed, 21 Oct 2026 19:46:55 -0700
Message-ID: <20261022024701.1574811-2-austin.linux@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022024701.1574811-1-austin.linux@gmail.com>
References: <20261022024701.1574811-1-austin.linux@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only one local task_work add per wait cycle wakes the waiter: the one
that takes ->cq_wait_nr's credit.  Every later add sees the credit gone
and returns.  The credit is taken after the entry is queued and the
wake up comes after that, with nothing held in between, so an adder
preempted in that window leaves the waiter asleep with work queued.  A
lazy add preempted before it counts itself down does the same: the add
that would have reached zero stops one short.

The waiter stays asleep for as long as anything of higher priority runs
on the adder's CPU, whatever the waiter's own priority.  Nothing boosts
the adder, since it holds no lock.  This bites IORING_OP_MSG_RING into
a DEFER_TASKRUN ring in particular, where the adds come from other
tasks of any priority: a real-time sender's message waits for a
lower-priority sender that took the credit and was preempted.  On
PREEMPT_RT, where threaded interrupt handlers preempt everything below
them, that is routine.

Traced on a Jetson Orin Nano (6.18.39-rt), with a SCHED_FIFO 60 sender
posting to a SCHED_FIFO 60 receiver every 500us while lower-priority
processes post to the same ring from CPUs loaded with SCHED_FIFO 50
bursts: of the 17 wakeups over 100us late in 60s, 15 were delivered by
a lower-priority sender whose MSG_RING had been in flight since before
the real-time sender's returned, for 12 to 479us.

On for-7.4/io_uring with PREEMPT_RT, before and after this patch, the
real-time sender on CPU 4 posts a MSG_RING to the real-time receiver's
DEFER_TASKRUN ring on CPU 5 every 500us.  On CPUs 0 and 1,
lower-priority processes post to the same ring every 200us, alongside
SCHED_FIFO 50 threads running 20us to 1ms bursts and normal-priority
interrupt and system load.  Ten minutes a run, 1.2 million messages
each, timed from the send to the receiver handling it:

                              late by    late by
                     runs   over 100us  over 1ms   longest
  FIFO 40, before      3     889-1139   341-417   8.6-11.8ms
  FIFO 40, after       3        15-21         0   0.69-0.94ms
  FIFO 60, before      1         1058       438     8.3ms
  FIFO 60, after       1            0         0      71us

The three runs at FIFO 40 are that setup as is, plus a thread in each
real-time process mapping and unmapping memory on CPU 0 or 1, and with
no lower-priority processes starting or stopping.  What remains at FIFO
40 is the sender's own MSG_RING being slow, 44 to 60 sends over 100us a
run, before and after.  Traced on 6.18, its request allocation waits on
the slab node's list_lock, held by a lower-priority process that
inheritance only lifts to 40, under the FIFO 50 bursts.  At 60, nothing
is left.

Keep preemption disabled from queueing the entry to the wake up, as
mpscq_push() already does for the push itself.  That covers a few
atomics and try_to_wake_up().  eventfd_signal() takes a spinlock_t,
which sleeps on PREEMPT_RT, so signal the eventfd and wake ring pollers
after that instead of before.

Fixes: 8751d15426a3 ("io_uring: reduce scheduling due to tw")
Assisted-by: LLM
Signed-off-by: Austin Schuh <austin.linux@gmail.com>
---
 io_uring/tw.c | 80 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/io_uring/tw.c b/io_uring/tw.c
index 0b5066f97224..cfb591508662 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -179,37 +179,14 @@ static void io_local_work_wake_poll(struct io_ring_ctx *ctx, unsigned int flags)
 	call_rcu_hurry(&ctx->poll_wq_rcu, io_poll_wq_wake_rcu);
 }
 
-void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
+/*
+ * Issue the wake up of the waiter's cycle if this add is the one that takes
+ * ->cq_wait_nr's credit, see io_cq_wait_arm().
+ */
+static void io_local_work_wake(struct io_ring_ctx *ctx, unsigned int flags)
 {
-	struct io_ring_ctx *ctx = req->ctx;
 	int nr_wait;
 
-	/* pairs with synchronize_rcu() in io_ring_exit_work() */
-	guard(rcu)();
-
-	/*
-	 * We don't know how many requests there are in the link and whether
-	 * they can even be queued lazily, fall back to non-lazy.
-	 */
-	if (req->flags & IO_REQ_LINK_FLAGS)
-		flags &= ~IOU_F_TWQ_LAZY_WAKE;
-
-	/*
-	 * The xchg() in mpscq_push() implies a full barrier, which pairs with
-	 * the barrier in io_cq_wait_arm() on the io_cqring_wait() side. This
-	 * ensures that either we see the updated ->cq_wait_nr, or waiters going
-	 * to sleep will observe the work added to the list, which is similar to
-	 * the wait/wake task state sync.
-	 */
-	if (mpscq_push(&ctx->work_list, &req->io_task_work.node)) {
-		io_ctx_mark_taskrun(ctx);
-		if (data_race(ctx->int_flags) & IO_RING_F_HAS_EVFD)
-			io_eventfd_signal(ctx, false, flags & IOU_F_TWQ_IN_WAKE);
-		/* whoever sets the flag wakes ->poll_wq afterwards */
-		if (data_race(ctx->int_flags) & IO_RING_F_POLL_ACTIVATED)
-			io_local_work_wake_poll(ctx, flags);
-	}
-
 	/*
 	 * No one is waiting (IO_CQ_WAKE_INIT), or this cycle's wake up has
 	 * already been issued (zero or negative, see below).
@@ -239,6 +216,53 @@ void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 	wake_up_state(ctx->submitter_task, TASK_INTERRUPTIBLE);
 }
 
+void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	bool first;
+
+	/* pairs with synchronize_rcu() in io_ring_exit_work() */
+	guard(rcu)();
+
+	/*
+	 * We don't know how many requests there are in the link and whether
+	 * they can even be queued lazily, fall back to non-lazy.
+	 */
+	if (req->flags & IO_REQ_LINK_FLAGS)
+		flags &= ~IOU_F_TWQ_LAZY_WAKE;
+
+	/*
+	 * Only the add that takes the credit wakes the waiter, later ones
+	 * return early, and a lazy add that hasn't counted itself down yet
+	 * holds back the one that would. Neither may be preempted between
+	 * queueing its entry and the wake up: the waiter, whatever its
+	 * priority, sleeps with the entry queued for as long as anything of
+	 * higher priority runs on the adder's CPU, and nothing boosts the
+	 * adder, as it holds no lock.
+	 *
+	 * The xchg() in mpscq_push() implies a full barrier, which pairs with
+	 * the barrier in io_cq_wait_arm() on the io_cqring_wait() side. This
+	 * ensures that either we see the updated ->cq_wait_nr, or waiters going
+	 * to sleep will observe the work added to the list, which is similar to
+	 * the wait/wake task state sync.
+	 */
+	preempt_disable();
+	first = mpscq_push(&ctx->work_list, &req->io_task_work.node);
+	if (first)
+		io_ctx_mark_taskrun(ctx);
+	io_local_work_wake(ctx, flags);
+	preempt_enable();
+
+	/* eventfd_signal() takes a spinlock_t, not allowed above on PREEMPT_RT */
+	if (first) {
+		if (data_race(ctx->int_flags) & IO_RING_F_HAS_EVFD)
+			io_eventfd_signal(ctx, false, flags & IOU_F_TWQ_IN_WAKE);
+		/* whoever sets the flag wakes ->poll_wq afterwards */
+		if (data_race(ctx->int_flags) & IO_RING_F_POLL_ACTIVATED)
+			io_local_work_wake_poll(ctx, flags);
+	}
+}
+
 void io_req_normal_work_add(struct io_kiocb *req)
 {
 	struct io_uring_task *tctx = req->tctx;
-- 
2.47.3

