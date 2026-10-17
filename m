Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCD36F91F
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200800; cv=none; b=ti7dmLMPKhG5r2olXn7j7fztxaAcjCSs7N5JgwkRUw92XdcJEgTi5u+9ipcw8a4b6sX297m0y9byXS5W9t3ziSrOBfH55Ipj4DtttyhNZXSC1DhjhfjuK/Nj5/VW8uvw0283UZQmzoq5jZYSZzQw8dvc3Ytmh/YuFlK/n5tAJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200800; c=relaxed/simple;
	bh=Q0OVgxmRG3Mb1iEUhHgWM/JD7gZywVlYcymBliEC/uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFWS3NhzD2EccIJC5+vVM5iH00mdmnjY/aRk8QHCsQhq4i4jM+hC15SJ6qz0I9L9Zb5JbSOJIGFoxvWwznTdEQ0a4LW38s/+2/tTJGuhdsOr88gMuF9pYWNgP03PtnSArGaA2VWgJICZkt0QfEPLyW7gXtPtAHAcMUwMls/J1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITQ0C6uq; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITQ0C6uq"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35ef6b49813so871814eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200796; x=1792805596; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/BMbVAoUESCQf7TQMH9otLhUC/2dV1sy9hX9s5qH9w=;
        b=ITQ0C6uqFmqgnZGoh8CnzIOfCHrAGhxfxsi67uDZ2RlAXgqzp/7YID3aZwZ8mrDlES
         DrRoAh4G0XpBoDsU7OHIpXoxv/7UBM5iV/AuKQZGOHkwBWwESc3I1uXptcewqHycvOCp
         FR+v0rL9FCD1NOFKkEDpQPe8IR+ncvvNKqzJoqI1NdhWEnqwRoXS3MqoadJ0HPRuMyE8
         /2M9NhVpixdhjgiFu1vU/48R/0+rS2jGUIGmj0OmhOZFqP+Vd4Vs3rQF3A6Klm7lm5qM
         h8KaK5b6E+zZ/KA6xxRAvgq5omBUMIMe2ihWCb+GHgniYqnu58A6JhwveW1QFOinUZEr
         oCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200796; x=1792805596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/BMbVAoUESCQf7TQMH9otLhUC/2dV1sy9hX9s5qH9w=;
        b=L5T4j/XGwM90BED7i+DTq0BfBGFEWXpC64mjbdvsOLzSVHDFYLXQxmCz5IJEjMrOps
         W5oUn3hNvfOwDl83QRF3ulfAKqbAr3pGeJq7BvP0IjdDUSFs7GrKwiuAOQNVWiWRbq8j
         FlHAyDlCFBXjtQqfPdtnot0aUFOZGTe0CAP5qSfFp4zpTLSnk/nzwket+7zvxJaFqZga
         B+GCq5nXdb2Z+i8torW7+Spdm20KC0976XxQoHJfNqThpX4s1Pdl1uaP9NNg6s1BPxp2
         vqxfUZPpufxIDMhaQjOOBaRJa/0HJ6ur1S9x7/BSAH+EUbkx4zNk/WNAZjK2DdL5fm+j
         hMDw==
X-Forwarded-Encrypted: i=1; AKwUvBzQcKXlUhP0Rjct+yYLkPjt/Q7UsOny8tOAQ/jl4UwiUcsXgSzyLitj32VYhkbcSBsLEFxERzfzNHJ6DMB2hw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK7GYx6SEsTV9IcMz8myYsKjdcQuNLW5BfJSv60flWqMjVRZ77D
	+HhpyikgCXROwCZle6m5wXRzsgxPYxFSVY5CCY80zFge1dR5kcBoCTPP
X-Gm-Gg: AYBFou0fxy8n0s4bp8ObicHHNULnjLt17N2oGa2Q0DPto+a+FX5MgWp5o7990U8Ub6J
	bj8x95RkTq1EBitBzlmn0xPnAjCwi1DbBAsgjsEzvRKB4UEfX6AMOE8fsNLr9Nsmzfiq5RgoZNU
	8iuhQ0HDAszpNwW9aKCRR7lXr0Op+qRyEB4M/MoiT+IQDa3fdcipicN2zycXBsQ9QscXErI+dbw
	zmklgneldEm7aptyEDR4riMPIA+GejwDxkc59h/9e3JwFMyZlBirjj1NayW23FLRzwQEZVVtS8x
	R7Ng/54SF4A3vr/0rORlLpmit2G47KVZSYaVqNDpzQjvwOt2ouz/L9bjG8LhmxKfsht3NDqTpTM
	TElGdGMEzHXiMN9+1K+gRlt6kOWdT6ttJlv5koS78ak2Vjj6aykbFQTfcspxH4RoL2eSoAJXGoD
	MKDRNcIerAVGlp7O0AaqQfBbCmCDZ6U5CjGCpNg8yDTPEXDPHTUVuxgO2ReQYEHBQuzkB3epmLj
	Y/GtGcTxSlBeCwB2JfbKivM93j4pN7y5dLhFKLM0E29Qi2dL0b4w6aypkntifq4mB0PYhASM8nD
	p9TyLCTKq9QcfSCAMFP3rGmJmQ==
X-Received: by 2002:a05:7022:ea8b:b0:16c:6459:35b1 with SMTP id a92af1059eb24-1851310977dmr1987494c88.28.1792200796321;
        Fri, 16 Oct 2026 18:33:16 -0700 (PDT)
Received: from server1868-4.tail96fc24.ts.net ([199.188.91.198])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm13878785c88.11.2026.10.16.18.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:33:15 -0700 (PDT)
From: Austin Schuh <austin.linux@gmail.com>
To: axboe@kernel.dk
Cc: io-uring@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	Austin Schuh <austin.linux@gmail.com>
Subject: [PATCH] io_uring/wait: wake real-time waiters from hard interrupt context
Date: Fri, 16 Oct 2026 18:33:03 -0700
Message-ID: <20261017013303.3919170-1-austin.linux@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit cebf123c634a ("io_uring: implement our own schedule timeout
handling"), a CQ wait with a timeout sleeps on io_uring's own hrtimer
instead of an hrtimer sleeper.  On PREEMPT_RT, an hrtimer that isn't
marked for hard interrupt expiry expires in the per-CPU ktimers thread,
which runs at SCHED_FIFO 1.  A real-time task waiting in io_uring_enter()
is therefore not woken at its deadline while any other real-time task is
runnable on its CPU: the wakeup waits until every one of them has blocked.

hrtimer sleepers, which schedule_hrtimeout_range_clock() used to give
io_uring, don't have this problem: __hrtimer_setup_sleeper() marks the
timer hard when the sleeping task is in a real-time or deadline class.
Both of io_uring's callbacks are fine in hard interrupt context:
io_cqring_timer_wakeup() sets a flag and calls wake_up_process(), and
io_cqring_min_timer_wakeup() only reads ring state, under RCU, before
doing the same or re-arming the timer.  Apply the sleeper rule to them.

Measured on a Jetson Orin Nano running 6.18.39-rt with this change
backported: a SCHED_FIFO 40 task waits in io_uring_enter() for 40,000
deadlines 500us apart, while a SCHED_FIFO 20 task runs bursts of up to
1ms on the same CPU.  Before, 6,647 wakeups were more than 100us late,
the latest by 1,040us, and 2,758 deadlines passed without a wakeup at
all.  After, none were more than 100us late and the latest was 18us.

This mirrors epoll: epoll_pwait2() waits on an hrtimer sleeper, so its
timeout is already hard for real-time tasks, and on the same setup it
was never more than 17us late.

Fixes: cebf123c634a ("io_uring: implement our own schedule timeout handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Austin Schuh <austin.linux@gmail.com>
---

Notes:
    Based on for-7.4/io_uring (89f193dc3ef4).  Built for arm64 with
    PREEMPT_RT and with PREEMPT, W=1, no new warnings.  The numbers above are
    from the same change on 6.18.39-rt (in 6.18 the code is still in
    io_uring.c). I haven't booted for-7.4 on the board.  The test program is
    a small C file, which I can post if it's useful.

 io_uring/wait.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/io_uring/wait.c b/io_uring/wait.c
index b7a0292767c7..ef4b89d3c66e 100644
--- a/io_uring/wait.c
+++ b/io_uring/wait.c
@@ -3,6 +3,7 @@
  * Waiting for completion events
  */
 #include <linux/kernel.h>
+#include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/io_uring.h>
 #include <linux/time_namespace.h>
@@ -120,23 +121,39 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	return io_cqring_timer_wakeup(timer);
 }
 
+/*
+ * On PREEMPT_RT, hrtimers not marked for hard interrupt expiry expire in the
+ * ktimers thread, at the lowest real-time priority, so a real-time waiter
+ * isn't woken until every runnable real-time task on its CPU has blocked.
+ * Like hrtimer sleepers (see __hrtimer_setup_sleeper()), expire the timer in
+ * hard interrupt context if the waiter is a real-time task. Both callbacks
+ * only look at the ring and wake the task, which is safe there.
+ */
+static enum hrtimer_mode io_cqring_timer_mode(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && rt_or_dl_task_policy(current))
+		return HRTIMER_MODE_ABS_HARD;
+	return HRTIMER_MODE_ABS;
+}
+
 static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 				      clockid_t clock_id, ktime_t start_time)
 {
+	enum hrtimer_mode mode = io_cqring_timer_mode();
 	ktime_t timeout;
 
 	if (iowq->min_timeout) {
 		timeout = ktime_add_ns(iowq->min_timeout, start_time);
 		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
-				       HRTIMER_MODE_ABS);
+				       mode);
 	} else {
 		timeout = iowq->timeout;
 		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
-				       HRTIMER_MODE_ABS);
+				       mode);
 	}
 
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);
-	hrtimer_start_expires(&iowq->t, HRTIMER_MODE_ABS);
+	hrtimer_start_expires(&iowq->t, mode);
 
 	if (!READ_ONCE(iowq->hit_timeout))
 		schedule();

base-commit: 89f193dc3ef462059387e9691bf6af4b1808379a
-- 
2.47.3

