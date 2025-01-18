Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BD7DA62
	for <linux-rt-devel@lists.linux.dev>; Sat, 18 Jan 2025 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737179386; cv=none; b=jPvCAuff4Eppl9aNVdQK7aiI7BBp06WIRAyaSAYcs31VawAv0Q9sicP3t6R13Hoin5aDYyHMtPfcOeZHp8R3wzxjtW4lriMqnJJtDcUFeB1yVeDuq9UFFYXpFRRhVqkZHT1+mZ3i0ASOFQsLgbFQ/8Ug7QSYi+yPxnqL1VyQBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737179386; c=relaxed/simple;
	bh=zyEyWvRj1G+ViW1k4PuGWnk2ySjl5eQKZoxoXHW//30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t52C8vQ20aBwdZFHCYKeM0CqOSfX7t5khswmG929ae7eRjrnU2Lllid4svxtw8sxVBCcdKdJ/y2XxVLG26fib/i0uATCt/VvVo8Gh1+1UGURAL5+AJV4oCW5RQ4G1zUpi2DuqcYSAGb93ltJ2KB31AOCoOGyJn3n+4P1Ui47ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh3/CXy7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh3/CXy7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216281bc30fso66593545ad.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jan 2025 21:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737179384; x=1737784184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kH6ewzDAUNXsCE0JCxntis2zNVY+BVKDevpBejHbyGA=;
        b=dh3/CXy7+qHgSv54BqP+H3tYg81BGMW9F4nvjbxQ4xMnje9+FbsfuIgFkSV2GeXegv
         45i/87Mm/Sk2+6F7yej1gbHMRTTMIjQPyGantaOZ20AwPbKy+tTBkxYbKq9vwRSFuZ+b
         snMv4zLaFSv3Gl3qjjfIy4ISbQGd0A9/iw3osyjPnK6SRTRBdiMlqjs97LNaUnor35Uv
         uRdvrzBRYmNlwy0PcnQkUgEMhV67NGAKdbltyRTy/Dk3E5GDEto68vnDHVgTqAu0T8JJ
         W5WOlEQOUwAKZo5NmysLNfQD+jv1tVGqW6/LLM69xxDdLC7cP92G1zybBfhpMz7rLXhn
         ooaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737179384; x=1737784184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH6ewzDAUNXsCE0JCxntis2zNVY+BVKDevpBejHbyGA=;
        b=tZphtfMz6c5XpJ1snfObDdqhRZzlrObhL+7QvLryg8DArtm5l9SXp8nfwnnXJyE9iB
         v86qjO/v2yVEqckfc79hESjiWn89xKAGyD2gQhIcMfWyQADj6U9OTSP7yQgZYfxcDReb
         gkxppy6P7Q1ir2xNnRtkrIieMegOBdJRfdjzY+lbzqLXy+iToqL+GiXiscv+JlEDn/ZC
         1/Zzx1AQERpABJ01ca4PJn6NZJzrV67vrIjMHNiXSbUwBMAT5mmlvCMP/DBE46l8T5El
         wa41HfvEHFrKe+OYd2llMUo3sDefG7A3kA6LrWHozKKmo/Rsc3d+nACN6yFxCJozn99x
         tCng==
X-Forwarded-Encrypted: i=1; AJvYcCWfVjyH25ImCk+y1BfsEnKY4A+s69TKSUcmot9tURxOqr8xBuEPwvFf8Rsc8pGFJLqX6EWL1xaEcvY91Xw37g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLtraDOSD2kcgbHavCd2FMzQk1trsTMfhjJ7vch6CGttOJ6XD9
	y0Jpkf33VTE1U5pdGfbDmaPC8gwk1ZubXGofGkJALy8RRzwerQJY
X-Gm-Gg: ASbGncsbPuMzGZQNT0Q+73hMtss9nMKb6oADXVLNueLYTJ4hIflTscFD0inTI5asGOA
	mm9vrEXMnoKGSEc2mO+QFzGVTe5inv2ZyqBwt5THis8c8wgS6v0cCXkKf7pkKeUk/oraE2xQ/ZH
	86w8JZ4qMzi9AjsvPO/JX3IBHzhEFdzFCrtjj75/i3MC9DL0LdgyJhO1GccLFc+8F3o9BCH9ILT
	8BOc7G8IT+on5EqPrsAy2X9Pj6bKpSCJTuVaglB7IQWaR6Gx8OmO7rUkILXkLin01nnSkbV/6Gm
	eTd0tZZoua4S6xlhxwIBOq3Lit7mW2ajvjxvtSTjp9Otd9asKm8FRjvo42d3yg==
X-Google-Smtp-Source: AGHT+IGD6MQnkgsF9tp0/+8LDmiwyA7mbecUaP4uUH+qo+5/u9EHCLo76fnBYJvIuGK7goiVFCM7OA==
X-Received: by 2002:a17:902:d50d:b0:21a:8769:2fec with SMTP id d9443c01a7336-21c3553b336mr75890375ad.10.1737179384139;
        Fri, 17 Jan 2025 21:49:44 -0800 (PST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea076esm25345345ad.6.2025.01.17.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 21:49:43 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bigeasy@linutronix.de,
	boqun.feng@gmail.com,
	clrkwllms@kernel.org,
	llong@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	will@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Sat, 18 Jan 2025 14:49:00 +0900
Message-Id: <20250118054900.18639-1-ryotkkr98@gmail.com>
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

This version uses CONFIG_DEBUG_LOCK_ALLOC instead of CONFIG_LOCKDEP.
Thanks Waiman for the advise!

v1:
https://lore.kernel.org/lkml/20241202012017.14910-1-ryotkkr98@gmail.com/

v2:
https://lore.kernel.org/lkml/20241227040824.83626-1-ryotkkr98@gmail.com/

Boqun, let me know in case if I should add you as <suggested-by> tag.
(Please forgive me and ignore if not what the tag intends for... 
I thought its appropriate reading the document[0].)

Sincerely,
Ryo Takakura

[0] https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

---
 include/linux/bottom_half.h |  8 ++++++++
 kernel/softirq.c            | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad5..0640a147b 100644
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
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
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
index 8c4524ce6..f0edb0abc 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1012,3 +1012,15 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
 {
 	return from;
 }
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
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

