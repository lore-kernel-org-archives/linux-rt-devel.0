Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE19391512
	for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242970; cv=none; b=PKN0Cdkc8ahCgoE3dJJGN3GM9OKZiuYaxC/6trGnN6DkYuv8BRkmaEAFK9tIptwklTgiyDCOOSyCxvEVPz5wO3NI9Dkjnmib21oY0L/Ok9prkf83TvCgyOwFcm74WpCK+2k2dc3J81eizpI2O4+1L5EqBkYVmjrwYYKyAjNJ2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242970; c=relaxed/simple;
	bh=R7KzqYlc77nKhM8iwHaTEz7kvU3XedYSYPxeFsqKjG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j20OKiK0t49DgwVwKPa/DMNAsW5kFm4UsJ8c34usTSb6w81/qS0oQQ4NPtjhOyYZelDtKT8kmvNort9vHXMhiBqHe/2xoJ9CEI7TU/VRNmO6BCsR6++mWfKzQVIwcU1sATJol5RgqvTS9ZDz8yvlVgZoS1rv3jiFlN7vwrWVNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnxoghqy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnxoghqy"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49e6e69d528so6344825e9.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Sep 2026 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789242961; x=1789847761; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GysJsE8mePqJNLXM00GRKUzojaP5JqBAXeEHJ7TcA4=;
        b=dnxoghqyGZo/ie9hiRHkPvv2CuAAixuPdib/+UPeQXMYYFI1Czg4hF2QlKnJAqX0AS
         TfsqYnGKt7CNC1DHpxtDbujeZNndcxCpkXoPFmnTo7m/3wT22L6T320zJE94M7cZJbfu
         kOl1OKaUjGYgP8N7oqdkPRRpu3aTEf39LpsosopxrcGqGaxOQ0Cwp8l81RB84/VV3J41
         rsrmRjHmSzTpGoWPveDfccIjnDDDxSi2z5R0PxrnH0wUfS9ogYwxuU5vXcOmOE7alTWz
         JcHvctACX4Cdjjhg/N2AbiXFUvRN/Jzmpq5Dy8P9Ja/hMZJe+i8VwGvmxavxWShiNRiT
         j66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789242961; x=1789847761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GysJsE8mePqJNLXM00GRKUzojaP5JqBAXeEHJ7TcA4=;
        b=a953xB7zxpwuOOftf4WZYzshc0U51/1O4jHiA8UHFTrAtVcxDhIsNfGKeaJatAEPCw
         KTfkGWT53ioy8zV7J0iGrgxtjXSXL+7M5rWOmEkRViQ3/jqOrEu1qammAzvREzGJDkPf
         acGdZuHiIArFPAaAxhKq5DchXfP1HrID2HVgFi3qHHdgz10YYun/hxwzAZ8WVaHuqGZf
         iT5HWaEyJw1Pkh8thSuhuZSAU3OWFIm1vM+dxMXHbDBYWVw7Qk1TARikYjKn+MpKIQEL
         Ie6khu4XksuB5RqB2+KMdAsU8umSnHpO+BKyF+JfiOzpNcgZYRWKc61o7OkzjazTievp
         egYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRl5NtCA7UlYNzCGYvgw12on9pCLjNjWKXx46Q6XB0wV2cBQqBzslvlApizI0BlCKsd3pDVzMAck32X4yP9g==@lists.linux.dev
X-Gm-Message-State: AFuF++lsYoDWtn1ZVlZbZcHZdcnzbop/KTWWEDCH7tAY8cgZYUpfDUyl
	wFF+oi6HQjYbdWyrozFZ+v/pdF0+Sb4T9TsN04xhxe/PISAcb9kr4hRT
X-Gm-Gg: AYBFou2PdzzIzcHIGkZZMXi3fKrJG62flLPd9RkK73BmCXMYWssO7Qjud5iXjuPwlaS
	Jhtba4aDtx9sKoPnJhf69gyTxbNF1c99UsufFKIoF9rJE3aqo8ne4KtfZ+o8ca/JwAXEG5flfaO
	M8ef9kGmajsJIHC2b/0CmeBfbM5y0+rk6KYVv1nse2vDiZI1ZoQfRRQFzpfU7wS42EqSvOrssoY
	4X0zYDW3DKUevUYqf80gtPE1Gf8fkT/6VRmG3HzvjHsQz/VP3ocNjMGt/vPoSKLxJNdfL57paRa
	gSCdSA6JHau08dLQMGBuSGSVADUz9f9us7IXCxnufMo5WuBfeAMQusyy7SpSR0WsWIBfYpaGyTS
	H+RAC6wL6PE9oB8nVNU8jV1uGG81q3oBSN9XdSpDuM/XGOLUpn7w55fHLEO5fGZIQdJHhSWpFU/
	Bb9ovMD4drwp2Ul7PgbFq6IczmBi6q5qm/BpsxKjJQ+as/r73cyVb7iLcnaaSV79xL0ftAxblem
	MfOuBtsOu5VyDVx9/Jp6H/9eobiE+qJAEH1ZUzqiQzNhe2JH1iPNtQWOedNrZb4EVD/lcCToQrp
	ERhhpvoAEeEDbCCsYVxKDwH/fqfGeljer80LT5jEzHw5Imbgr9KztGCNoJTO9fPGY7IgAoVTTGW
	R43v+zFo=
X-Received: by 2002:a05:600c:3b18:b0:499:8704:242c with SMTP id 5b1f17b1804b1-49e61646becmr99559535e9.0.1789242960978;
        Sat, 12 Sep 2026 12:56:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm267089045e9.14.2026.09.12.12.55.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 12:56:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] ARM: cacheinfo: count external caches in early_cache_level()
Date: Sat, 12 Sep 2026 21:55:50 +0200
Message-Id: <20260912195552.76673-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

early_cache_level() counts only caches described by CLIDR. An external
PL310 is absent from CLIDR, and its arm,pl310-cache compatible is not
accepted by init_of_cache_level(), so early allocation falls back to
an incomplete count. init_cache_level() later adds the DT-described
L2, forcing reallocation on the secondary CPU with interrupts disabled.
This defeats early allocation on PREEMPT_RT.

Use init_cache_level() for early sizing too, so the initial allocation
includes external caches described by the device tree.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Without this patch, patch 4 keeps the warning on QEMU vexpress-a9
(4 Cortex-A9, PL310): the early size is 2 leaves, init_cache_level()
wants 3, and init_level_allocate_ci() reallocates on the secondary
CPU. With it the warning is gone and the cache sysfs tree is unchanged
(L1 data, L1 instruction, L2 unified shared by all CPUs).

 arch/arm/kernel/cacheinfo.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
index 860eeb03cfe5..31591c947254 100644
--- a/arch/arm/kernel/cacheinfo.c
+++ b/arch/arm/kernel/cacheinfo.c
@@ -111,13 +111,6 @@ static int detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
 	return 0;
 }
 
-int early_cache_level(unsigned int cpu)
-{
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	return detect_cache_level(&this_cpu_ci->num_levels, &this_cpu_ci->num_leaves);
-}
-
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int level, leaves;
@@ -146,6 +139,11 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
 
+int early_cache_level(unsigned int cpu)
+{
+	return init_cache_level(cpu);
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
-- 
2.53.0

