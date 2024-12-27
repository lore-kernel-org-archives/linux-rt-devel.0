Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365C7080D
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Dec 2024 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735272519; cv=none; b=UJ5+T7GJAbn7DWofJgMqmBdMAc1WWc3JgHuzSl9VpH5VELm9EwUCfGr469SxzXc47Jjt16Qy7m2DCp9zAh5jr5mKsgTaECpbJEYGROqcU7mJrsv8W5MSLKK/YltsxoCkCRsXYY7lyYKxfKuXK27ctkdvYYYGRVzK7ydg1TuD26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735272519; c=relaxed/simple;
	bh=wqML3VQ0gwMYDsw/3NqJIoNvhc9bs6GaEiQJSKeRzU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p0dL2V5zh98v6CXZofikj7YsQsKvMWJ5ykg/tDi82XfOOcsOreYGcT/0LMqk8AcCPdS0lvjwKgGjCSJvzSPsfUPjt3GP/yMck9dlSVv/18IKrz7+6ix0MhQw/O+Fds9P9TFGh/gvxb4OtgNm/ZmVQ5IqXhjoYK706iKYI42K9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk/0TVoY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk/0TVoY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216281bc30fso96040775ad.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Dec 2024 20:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735272517; x=1735877317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGBPKZkVSwZ246MMQ8j/Faxxrn44L8Wku9zAKTR/iqM=;
        b=Xk/0TVoYLHyvaYSDtvXznxwuRoXxLl8XNakSaoFjLG1DqmP33Qyhf1ch7eCbw+nJ6k
         TnkCZNoSKrC6M8R7cX2ATdpToU3tQSq0YJNWV8ZmXrlR+KtNgSjMKgeqbU2RwAv1y2ye
         zdDljzWM9IFZwXtXQAjAbjpkybGbvI13xwBqrm0PfUsj3f+hfASAySIA4rSJxXaIE0/6
         +3KpnN8uvsKa30Y5MzmRKfZzMzt/O5wrrlDEcdnicR39Y9KGIgkcnb5nael2kp/bgEQj
         IEIhb5k6wkDjBkMJ3h/airB+dVbJTiufPyuwvvrb2ztqXo6HStY5KYI3ra4A3g7k5jd5
         WMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735272517; x=1735877317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGBPKZkVSwZ246MMQ8j/Faxxrn44L8Wku9zAKTR/iqM=;
        b=Ld7yI0Nrs+2wjS0hUaF4o/PIL8hAstmY6TeAPAHbYF8DZVXI5aC2/fdLO2n3FlKnN1
         W4hdj1BqZ+jugNNmEvsU4hYNimGVFJtZafeRtBF+KFsmJgx5gbgjy4fpaTpCqsupsdnH
         xH4+k8H+CUUwkQoXXvJTzqUkSLlU0evgvHxZ+dfUyuDAtDTXYp5BljsrA3sro7GT6b3N
         ouGAmSnvrJUCAIAaA22qjg5jAURiQauREBgNHCEUR93E1YLMNtladBBwMmUyouqboQsB
         EBDGpaAdCL18kyLPKxTO/9iN8F1P2roREpTf4jDBILOpyoEhgM/Isk5p7MbMZYm5cP3h
         MKmw==
X-Forwarded-Encrypted: i=1; AJvYcCXP67oOOwHn3wDUEIs1BTElVK2isD37epq+bzTUpSJ/32oq9a0PTpVhkrMsq5Yh5ZrwBqxZswp+AeY/XC/6MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLnb6Ndq+M8O8IUeTr+MzK3A3bEu+Rc8Vd8aYNfIDweOHYZCKb
	wMZnqlwUisWkKp6+Rvj6FN++JH+Gy3NLYnunPetT337eZOgE8GjM
X-Gm-Gg: ASbGncuyNLL0PqnWYlFKh7zdv0EVmttGcJsaG9S0XcvpoBjfuCDoxCtNwtQJqhEF3U6
	SJd5yManAPTEtMHV+W8WNURx/un1R2b3LGzzdOUn7d4tk3DL5LkJeFMVp0klvedvJbms2pqTzmd
	ybE8d77wsMETWx0L7IGQIfi7KMBt/fHLuxg9X+DaVqLqJMFehRvYTCZQkQZMzyu+7bHNrvvuj4g
	6PSj79ZhoSXmlLVfYxD4AKDtXvj+WRRJqJFzH0X16kIjyv8sHZZLB2oP20S5pj2v37nuSsNJxn2
	0/3fQo+rH6/lYYKc2lACQJkyKeY=
X-Google-Smtp-Source: AGHT+IGA91NZFQkp1zy0ot+57/lIY9AOTCKrgqdQ2t2BaMtyQmLjkBd7jza1FARcO2PmZ/7oc0yrfw==
X-Received: by 2002:a17:902:c411:b0:215:2f00:67b1 with SMTP id d9443c01a7336-219e6e8c79emr361222545ad.6.1735272516882;
        Thu, 26 Dec 2024 20:08:36 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e585sm127368035ad.70.2024.12.26.20.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 20:08:36 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bigeasy@linutronix.de,
	boqun.feng@gmail.com,
	clrkwllms@kernel.org,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	will@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v2] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Fri, 27 Dec 2024 13:08:24 +0900
Message-Id: <20241227040824.83626-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
PREEMPT_RT."), the wait context test for mutex usage within
"in softirq context" fails as it references @softirq_context.

[    0.184549]   | wait context tests |
[    0.184549]   --------------------------------------------------------------------------
[    0.184549]                                  | rcu  | raw  | spin |mutex |
[    0.184549]   --------------------------------------------------------------------------
[    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
[    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
[    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|

As a fix, add lockdep map for BH disabled section. This fixes the
issue by letting us catch cases when local_bh_disable() gets called
with preemption disabled where local_lock doesn't get acquired.
In the case of "in softirq context" selftest, local_bh_disable() was
being called with preemption disable as it's early in the boot.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
---

Hi! 

This version fixes the issue by adding lockdep map for BH disabled
section. Thanks Boqun for the suggestion!

Changes since v1:
https://lore.kernel.org/lkml/20241202012017.14910-1-ryotkkr98@gmail.com/

- Fix the issue by adding lockdep map for BH disabled section. 
  This let us catch mutex usage within "in softirq context" selftest
  as it disables BH section.

Also, may I add Boqun as <suggested-by> tag?

---
 include/linux/bottom_half.h |  8 ++++++++
 kernel/softirq.c            | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad5..f77dc746c 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,6 +4,7 @@
 
 #include <linux/instruction_pointer.h>
 #include <linux/preempt.h>
+#include <linux/lockdep.h>
 
 #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
@@ -15,8 +16,13 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 }
 #endif
 
+#ifdef CONFIG_LOCKDEP
+extern struct lockdep_map bh_lock_map;
+#endif
+
 static inline void local_bh_disable(void)
 {
+	lock_map_acquire_read(&bh_lock_map);
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
@@ -25,11 +31,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
 
 static inline void local_bh_enable_ip(unsigned long ip)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
 }
 
 static inline void local_bh_enable(void)
 {
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4dae6ac2e..a8211ba9a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1073,3 +1073,15 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+#ifdef CONFIG_LOCKDEP
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name = "local_bh",
+	.key = &bh_lock_key,
+	.wait_type_outer = LD_WAIT_FREE,
+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type = LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif
-- 
2.34.1

