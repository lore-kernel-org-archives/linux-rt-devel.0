Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71C10A3E
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Dec 2024 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102473; cv=none; b=mivgY6yjgc7oGLgdTT5YTB/D1ug59NSg8E+F4ClCdXZjzOIK1GY3kvLqCyqYEzUPDpmm/NQJIczATJQA7yr8+2VYxUGcin6PHK/tn8x0GKj23qe8X84pFZ9GHBZbYKpGCSfEHdPNO9udPEvlWnvD0lADDGlIiVSqRRLZulPSKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102473; c=relaxed/simple;
	bh=/wZTI3UiahNixfklRx/WvDzLUzuChm2QRLE3nAmDEhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goD04ApVO9vgCKjRGW043Rlzx8f9Kk4f+YJ3hFODxHD2nq94m1ZsU+f99WxcM+aS9gU9sZa6JgMsancdJd5WiK1SBvDHMN7R86W2wR9Bc9sUApxUEq2D1SB+TeqsahyETLLkxZgRXJGp8Z+yvB7+sRhG0hqUO/Msc/mWbM6VqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e31cBu/9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e31cBu/9"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso3157600a12.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 01 Dec 2024 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733102471; x=1733707271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lypOr0RHny0xPV7z1/09rSMaYkYRgv7f2VuEbcmtql4=;
        b=e31cBu/9znOoOrehPCKJrdGEGB321UOkcHFWP3tUDTnWXuSGUoPX5MtHlxxJEcTmhk
         1eFPi8jWRfHRQgNqDzuLT2dloV7TsFZpAK562YXslhmeQDr0Sj49KNuOSP5jPHGLKFu9
         F7zobAD6RJSGIJYX2j+a0LhAv2b/n44bJ5ij8UYuO0rPlJtqnEliItqyj05WcB5JAgbp
         f7+4b9b1u9x7dsO6vLBOrH6IOtBCT/5nKoyT156uOYTkWjmWS7Jpk+QQAJq5O8RsPmrW
         6QX4ZDoN5Mduuk+WaE7AaGBcjGf2ZR4JXOZuC0jgmWQzYBG+QJIhfeMABvQWxQ5gIZlU
         5IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733102471; x=1733707271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lypOr0RHny0xPV7z1/09rSMaYkYRgv7f2VuEbcmtql4=;
        b=oQ+fwhljeSPmJNOERltuWmPkIyfId3vbHgZPOJOFA+Ta27OAKysVkvMyjKwQUeoqWY
         3bGSSerjgE70106lHQvUxTLy1ndJFJQiKhD3E0P8YPr8UIgG/Fb/3vZC1MEn4u6aFjlT
         AzGpYmLe8X7zS3aAMPDLe11AlSC8Y99i7oGYiJ98lYC3hES0Q/s8uG6fA2DskmVJ6OxY
         50+xr4whCN4q3mr3OoBHmBWZiAgVvxnd3laeHkPRjy4gjbEZWSSlwAc3Pth5GSTSLloa
         l8SXolfLZTrE5/cP2sRMEywd2hEKLz481mrj3X0J204iRtt9AABOFrnWREnrfHGqlmPZ
         py8A==
X-Forwarded-Encrypted: i=1; AJvYcCXroJhVH109ljRfYXBNEokPC/40QEclEGX3m3HVOwrEprXg7Ue8Ic6Wp4XpYVxg+w/GB1P7gR4bbuspAZ7pDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGwFgBuOBbJxgeh21uHaPYjBiBU6bx6EanU2RsHHKGF+JQ4E3L
	ntQHab4OK4Dug2y3gb/uKOQHtfnwsM8dpJ2CNXFpY7rnbDvt6ee8
X-Gm-Gg: ASbGncuvUCKOWgZStMMSKZI7j0n06H+LOjV/66AeSUKXlvRzpRa5/gokty166mWAKxT
	0rONI2LXZV/ZqPKgF2Vc1SU2PHqg7LSdcmLtWNdzvUqZQBoRkdi61ofHTJe2uV7ouK+5hYQznXU
	+sFmd53JoSFjUzgv3N9htiP7FUiGy0oAnsfO6ZNLo+5o5hCuUrHzaCDKeKOH//oYDgnlEqVG664
	OMwYg1VZ3g1ZKw4BKri65Y3f2BJaMNKcUBB5dOTvxe2xFOFyDZzG3zlbf9sAYqYj/Apaewpy/+h
	5M8JiA9IFBYNUSDVVlDw
X-Google-Smtp-Source: AGHT+IEi0VPrm1wGAXpYwSHtca8YBzh0DEi/Zh1m3Q7ntEwm+BoWtWGwA9rCV5n5tIdW1z/j+dV1QQ==
X-Received: by 2002:a05:6a20:734b:b0:1e0:c713:9a92 with SMTP id adf61e73a8af0-1e0ec7fcc77mr29014881637.6.1733102471341;
        Sun, 01 Dec 2024 17:21:11 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c305637sm6632872a12.32.2024.12.01.17.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 17:21:11 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Mon,  2 Dec 2024 10:20:17 +0900
Message-Id: <20241202012017.14910-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
PREEMPT_RT.") stopped updating @softirq_context on PREEMPT_RT
to ignore "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage"
as the report accounts softirq context which PREEMPT_RT doesn't
have to.

However, wait context check still needs to report mutex usage
within softirq, even when its threaded on PREEMPT_RT. The check
is failing to report the usage as task_wait_context() checks if
its in softirq by referencing @softirq_context, ending up not 
assigning the correct wait type of LD_WAIT_CONFIG for PREEMPT_RT's
softirq.

[    0.184549]   | wait context tests |
[    0.184549]   --------------------------------------------------------------------------
[    0.184549]                                  | rcu  | raw  | spin |mutex |
[    0.184549]   --------------------------------------------------------------------------
[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|

Account softirq context but only when !PREEMPT_RT so that
task_wait_context() returns LD_WAIT_CONFIG as intended.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>


---

Hi! 

I wasn't able come up with a way to fix the wait context test while 
keeping the commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting 
on PREEMPT_RT.") without referencing @softirq_context...
Hoping to get a feedback on it!

Also I wonder if the test can be skipped as I believe its taken care 
by spinlock wait context test since the PREEMPT_RT's softirq context is 
protected by local_lock which is mapped to rt_spinlock.

Thanks!
Ryo Takakura

---
 include/linux/irqflags.h |  2 +-
 kernel/locking/lockdep.c | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3f003d5fd..c33c3bbd8 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -121,7 +121,7 @@ do {						\
 # define lockdep_irq_work_exit(__work)		do { } while (0)
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && !defined(CONFIG_PREEMPT_RT)
+#if defined(CONFIG_TRACE_IRQFLAGS)
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 536bd4715..2a508d6a6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4602,7 +4602,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_HARDIRQ_READ))
 					return 0;
-			if (curr->softirq_context)
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && curr->softirq_context)
 				if (!mark_lock(curr, hlock,
 						LOCK_USED_IN_SOFTIRQ_READ))
 					return 0;
@@ -4610,7 +4610,7 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 			if (lockdep_hardirq_context())
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
 					return 0;
-			if (curr->softirq_context)
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && curr->softirq_context)
 				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ))
 					return 0;
 		}
@@ -4651,8 +4651,11 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context() +
-	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context();
+	else
+		return LOCK_CHAIN_HARDIRQ_CONTEXT * !!lockdep_hardirq_context() +
+		       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
 static int separate_irq_context(struct task_struct *curr,
-- 
2.34.1

