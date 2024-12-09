Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A469136671
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Dec 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760590; cv=none; b=rk9Ae6hXyeL+DLZNewvmGZSq6h1z1uE535JsKsSwT49v9hM0tvKQt3omUE2B54qdnCe8Y6cW/qmk/G3kF7f3BHDWoFoU3eUjZQ59YJQ2nLPjSusjtPuD0WKC+uFNxn7y43Feo6sNKaCd3Hbm37xXBYPtHW1G7hdybCE4dE+Pg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760590; c=relaxed/simple;
	bh=C36zNPc/jbnuBcAYithGaYsubdt6UiWPUDVuWScR/bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkY/eYe/V+dZOQ6AvPltEBOVtzHap8VtkwQateaS2HhsPA/sS37OscrhC5rupeExwr+h1C6kdyu5ehQe/PHmts8Yo2fIo6ixs7vlvfeyp0mEkO6s4fuc5b6+HaWzPZRVwoUNvhSgV1XrvCdzUSDMIkyTm/9DAmcdeUhOTMVlsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUOULO3J; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUOULO3J"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725c24f3a89so2436792b3a.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Dec 2024 08:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760588; x=1734365388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNzOfGzLAseJibdxxhcMGoyOqJHa9JTOySWRlkmre7s=;
        b=hUOULO3JC1qSajz0XUgjO4D8tNF7LpD4F0+FEO/fZQaOiQjBv5uLvuiA+O5QBClI6v
         A3FqVeFtl5258YpXBHascGVsB5S42OgUyg+zObujlWzTdeO2nNtKWbi5IWOxr9rObLGA
         xuuNfxgrT8Q+ZdxGI80QwPauLQarhqG07xzHFPMjQLXhRNZxyXiwWVAKTGxHycVdwiRP
         UK9gbmDd54JMDnkGgDv8q8umy4aH96vKYtcknmxFUr0qbNgyuXzR69j6ajL1ibr7qwn+
         lHluXL1csuMBDl7zzqLPgmS9XGP23E1d/hTNDqETCJiYY8nEm9ONq5mgnHfNf/Z41X1d
         edSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760588; x=1734365388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNzOfGzLAseJibdxxhcMGoyOqJHa9JTOySWRlkmre7s=;
        b=tcrf6+Hm6mlk0xcZV/gRYbPSJrKdHA4xZzgpNTi24+/mmCoR42NUWLY1fkZSIlGhv/
         fAZtij1jBvdcWsme92XQzSNdPJ1U51q68tELuwltQWMks3wfko7VXafApePmqMH3ZTXG
         cusiCCtlyqWSk2RjOWUVVzwO8SHUj4pT4Kd+5Jomo7FmtvfA7FBXaMrQWnVvHtMMfio/
         zz8NKO78ca93P9gLeDqI16mmy+2Vt5m7ESS8yZFot0B//xOrZG8kV9foYBDRVXWESQxW
         DICWZEW89QFSNG3NA6Rc0iwO+6ZC47FsRhSWH/65iAM4R9SU+iL9o683STgH9Dkomqbr
         Q3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXPSCcZG/0LUL376QY1aSCWg86C01Fp0oC1m7FMhgS3lFN5CY17W/T3PhMCEKJ0JzOVmcsdqRokDP2d2uaMZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4eZNHx6y31YwNY66ZqrD/XU6OhtI/oLA86o9GATdG1l/kRhcZ
	I/K1e/m1HH8LZ3xgUH9Wtyh8gtEdqyetgUHSFlNJ8hDpL/nF8fvR
X-Gm-Gg: ASbGncup6J8ysduJs0LwefcZDaouY5q+VHIGYzccI88hkrmOMgo9pRVRSwY/ivMRJfx
	Ytlns1rKZPjsQFiQImgGv6gHOjx5UP3Rf5ROr4gfh4eKZQw2/oV2+wirTmHag3MQyfW+2spYXBE
	SadLWVf0Zp7bltT+lYfR0QxiN/uDhdzo9ZS0W3063J7lX6rYxbkue9mu49Bq/rn4bXROPJ5bEdB
	UG8zV+1wF/96XNxto7BOn3DDh9lborauMUKArkgckJFWwpWZfyK7321KbIzGB6oo85m8l04vluL
	1immG/HcLtjPgHlBUoZtcFm7HC9mEsXisg8rT+wWTeiwwIuUyDJ3
X-Google-Smtp-Source: AGHT+IGDgARAQ3C8rJb1gmNnhbeSqhembKboC+9YMymczxSCAjuRCR37JTa75SJFHELFYuLorlVsjA==
X-Received: by 2002:a05:6a00:1708:b0:725:f1ca:fd76 with SMTP id d2e1a72fcca58-725f1caffb6mr3781567b3a.0.1733760588406;
        Mon, 09 Dec 2024 08:09:48 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d3fc95fasm4207124b3a.177.2024.12.09.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:09:48 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: boqun.feng@gmail.com,
	peterz@infradead.org
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Tue, 10 Dec 2024 01:09:43 +0900
Message-Id: <20241209160943.254299-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z064BAsxrEe5zQV7@boqun-archlinux>
References: <Z064BAsxrEe5zQV7@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Sorry for being late on reply. I was trying to understand some 
of the selftest reports that came across...

On Mon, 2 Dec 2024 23:49:24 -0800, Boqun Feng wrote:
>Maybe the right way to fix this is adding a conceptual local_lock for
>BH disable like below.
>
>Regards,
>Boqun
>
>------------------------->8
>diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>index fc53e0ad56d9..d5b898588277 100644
>--- a/include/linux/bottom_half.h
>+++ b/include/linux/bottom_half.h
>@@ -4,6 +4,7 @@
> 
> #include <linux/instruction_pointer.h>
> #include <linux/preempt.h>
>+#include <linux/lockdep.h>
> 
> #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
> extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
>@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
> }
> #endif
> 
>+extern struct lockdep_map bh_lock_map;
>+
> static inline void local_bh_disable(void)
> {
> 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>+	lock_map_acquire(&bh_lock_map);
> }
> 
> extern void _local_bh_enable(void);
>@@ -25,6 +29,7 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> 
> static inline void local_bh_enable_ip(unsigned long ip)
> {
>+	lock_map_release(&bh_lock_map);
> 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> }

Maybe &bh_lock_map should be acquired at local_bh_enable()?

 static inline void local_bh_enable(void)
 {
+       lock_map_release(&bh_lock_map);
        __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }

On !CONFIG_PREEMPT_RT, I noticed that softirq related selftests
(e.g. lock-inversion) fails with recursive locking error

[    0.741422] ============================================
[    0.741447] WARNING: possible recursive locking detected
[    0.741471] 6.12.0-rc1-v8+ #25 Not tainted
[    0.741495] --------------------------------------------
[    0.741519] swapper/0/0 is trying to acquire lock:
[    0.741544] ffffffecd02e0160 (local_bh){+.+.}-{1:3}, at: irq_inversion_soft_spin_123+0x0/0x178
[    0.741621]
               but task is already holding lock:
[    0.741648] ffffffecd02e0160 (local_bh){+.+.}-{1:3}, at: irq_inversion_soft_spin_123+0x0/0x178
[    0.741721]
               other info that might help us debug this:
[    0.741750]  Possible unsafe locking scenario:

[    0.741776]        CPU0
[    0.741793]        ----
[    0.741810]   lock(local_bh);
[    0.741840]   lock(local_bh);
[    0.741868]
                *** DEADLOCK ***

where it does SOFTIRQ_ENTER()/EXIT() and SOFTIRQ_DISABLE()/ENABLE() 
as each enables BH with local_bh_enable().

But I was little confused that isn't recursively disabling BH allowed, 
especially if PREEMPT_RT doesn't disable preemption? (I was also 
wondering if disabling BH recursively is something that can happen 
on !PREEMPT_RT if it disables preemption...)
If so, wouldn't report for such case be false?

>diff --git a/kernel/softirq.c b/kernel/softirq.c
>index 8b41bd13cc3d..17d9bf6e0caf 100644
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
> {
> 	return from;
> }
>+
>+static struct lock_class_key bh_lock_key;
>+struct lockdep_map bh_lock_map = {
>+	.name = "local_bh",
>+	.key = &bh_lock_key,
>+	.wait_type_outer = LD_WAIT_FREE,
>+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>+	.lock_type = LD_LOCK_PERCPU,
>+};
>+EXPORT_SYMBOL_GPL(bh_lock_map);

Sincerely,
Ryo Takakura
