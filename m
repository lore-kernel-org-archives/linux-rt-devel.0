Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7C18D62A
	for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257451; cv=none; b=FaW4uNXHJieurpv0cFq2YCYDTUufFroGK28YspYm9J348p/Yn2eZgG1rSBE0CZZcywnuSiWkR598Hmy3UWoH0GUaRlOFjP9/hOKKgDDjYYSmg+fetcZsbxkB0Z1oKORtYPY08EVSSsOx22SXqoQTGuWn+ACbQj6QPg7E2UFAicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257451; c=relaxed/simple;
	bh=+Xrjusm7uk8yi/68OHDDssqjCOfFWC3Jht37GD4VCAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwiDIFIQIymUbFK8qumZoFW8XVtUCObt8q9t0A5m318TAvTtz/CMZSbjuUf/jO3+TFRinn7YnhcaEJOXJJXSp1jlVWqoWx4oKBHN/qiu5m4aFkJGlW4FuwLefxmKrahnWJGSGlwQCn7m4vd3HCus9Tvxw6ikDKUbT5Yydcv5/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWv1ybZE; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWv1ybZE"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so1207908eec.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 17 Oct 2026 10:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792257449; x=1792862249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jLfEr+NgE09LwZV7PAwpKfzwycgTPnmE1PsuHXjQM58=;
        b=qWv1ybZEhdS3V1SrA2K5mVb35IZf9n0fqLQ2WpeCjhk45/8qzdxjOWEZlh89devKk9
         bNBL+VzgesFfb0t9xiHvVvqoIXvMJogRUbl3B2gkkhpCeWXIF8RFOED4IF2Bhhq7iNdm
         i64j74/UX79j2ujW3zrjC+uKs21oSXFELk5aoTdxMIZjKI9J59P8Iy1vgz5IRmflF7XY
         TYhAzmn3XW+yLOV/gSDp3AYrompdJznnE6td3XVa77LpSlcj2K6XQZCI9eDmmmgxfaHZ
         L+LUJbYb7ybCJEsANHzkuVFe5iD80zT/HFb4oW56ISbOmC/Cp8nMmh6PC+0eBkJzz5p1
         f7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257449; x=1792862249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLfEr+NgE09LwZV7PAwpKfzwycgTPnmE1PsuHXjQM58=;
        b=ZAkfvgmEw8Tb1XWMfsViDKcYdGUB5puLXzSUEi+xCBbpSJPeizJr85AaN+v+cvxGGs
         lzA3oiFlr0S83bFuwfdpJ2roGD+nss5ce4NJw+1mBhQ0KzP9effTBs750ESeZfvvdzO/
         ZTf5XgsyS988evIJOTyIe9gC0uogdiW8WJk8Sb025YrUHuQlbCCMK1wJzJNHPNfYUxhV
         C+4awkUSXY83uNWDP64RHnwcZbKOSVqE5o66lxEqgJEpkAr56fbGfaQ4n6JeT/rwbvtH
         XDAdAgO0trfQ563kqGfujKdZ7zANinwTwA0hgNK+gbCGlp94ZGVvue3A/3p1JTmQhxUu
         /9uw==
X-Forwarded-Encrypted: i=1; AKwUvBw1CHW+GLis2I3oGQHzD9mBQISt4e2j2Gwq/L60APsWgFNi7oyf5h09bwwWYwF1IcxQs3n5urJ/zqsibsHT3g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5K/Acl2aW85pkMmM+mxMT2Ta0wdhaIKy6C+BHFAIAf058FLOn
	WKg1IWK5dbA7zLZyi78Rxhm+n9iFrV5+4Nj0129IAQ220h6SeRtgrY9U
X-Gm-Gg: AYBFou0Cw+jBjbpcMNg/pQXF16JmzNbSdm9ottVGFJjQP6u9o0VhcrRjrgJF4nNYHog
	RRi/6AI6nvwDS+hvQ0d8YwmCYrwDYjb13IF5IGDSRp6gaq2uMVULvzeveickIhmrVxy3mRl8GSr
	MqB81AD36C2QckuYLxhMpO5H0JLNcyZlAkvjqvcBOOLUR6NJnOBYe8TJHsADHcfCR1gRz1iyzXg
	yObtqX4oTH9sqClaZYDHS5B5HSw1YIkjMnHLNKXVgNv8zVleZEuxMAoLFon4Vu2p+HQR4axD70r
	A+nSxuEkRsc1AdtVGMFw958pLllSOQfL6+Q1km36t5Ap/lAx5dwrpNNQ9bAdi5XKKX9YhhSLed0
	oCPzwmKYiAnOb0+sO9wAtDE12YQhEdti5uPd/IyzjUdgrLfrZ5SJYr1DBuyunHj5pxyX9XmAU5x
	aKjiMcpitx8gggryHpLzp2LygsW71rDnWX4SlOKnFu6JbmrHowYn56teHrAdb4P5tO8PvPQSeaL
	iXoLucZ0hMWgQPAuwj5HK5E3Er/YnhLloAa1L8lO4QZcc9dvOrp4cwKYtLGuS80+GuXTADR5c7R
	rbiXDEiG6tw3qW8z8Hch1JVJlA==
X-Received: by 2002:a05:7301:2a9b:b0:351:7f5c:dbe1 with SMTP id 5a478bee46e88-361a2b3e483mr4308818eec.28.1792257449303;
        Sat, 17 Oct 2026 10:17:29 -0700 (PDT)
Received: from server1868-4.tail96fc24.ts.net ([199.188.91.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0e5e6sm17762897eec.1.2026.10.17.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 10:17:28 -0700 (PDT)
From: Austin Schuh <austin.linux@gmail.com>
To: axboe@kernel.dk
Cc: bigeasy@linutronix.de,
	io-uring@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tglx@kernel.org,
	linux-kernel@vger.kernel.org,
	Austin Schuh <austin.linux@gmail.com>
Subject: [PATCH v2] io_uring/wait: wake real-time waiters from hard interrupt context
Date: Sat, 17 Oct 2026 10:17:26 -0700
Message-ID: <20261017171726.601443-1-austin.linux@gmail.com>
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
    v2:
    - Refer to __hrtimer_setup_sleeper() for the policy instead of restating
      it in the comment (Sebastian).
    
    Based on for-7.4/io_uring (89f193dc3ef4).  Built for arm64 with
    PREEMPT_RT and with PREEMPT, W=1, no new warnings.  The numbers above are
    from the same change on 6.18.39-rt (in 6.18 the code is still in
    io_uring.c); I haven't booted for-7.4 on the board.
    
    v1: https://lore.kernel.org/r/<v1 message-id>

 io_uring/wait.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/io_uring/wait.c b/io_uring/wait.c
index b7a0292767c7..fb1c082993a7 100644
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
@@ -120,23 +121,32 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	return io_cqring_timer_wakeup(timer);
 }
 
+/* Same policy as for hrtimer sleepers, see __hrtimer_setup_sleeper(). */
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

