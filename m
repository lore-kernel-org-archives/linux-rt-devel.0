Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A13A4F59
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851656; cv=none; b=DLaMN/pDdqane2K9uzgzYT89QxgWsq4MKOOoo8DjRLEop8D+j/awCNfrHCC2+LSY257ZYdyZQ+FQDzQ/Iv7aDaMcKajtcc3NqU2CzC3uLZEl4ZjvOqaBRAFiWhlVCH8gkPgqH5nAUExhM5ROG3X1u6tRLlWTCGDypk8JhCpMa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851656; c=relaxed/simple;
	bh=sFOAnCZDwHdC19ns4aSgMCtOItVvq2/+tYcVxQatFt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCr2V/7GlzjlMyHnlB91Kk8VbJigaPPoiHMennl8T5BqxujCqmlOz2j+yv45CpY1+CMfNxBr6ope4P8aX0RA8Awy/W+aE5pChEviq9M+oSeFCBl2ZuBrJP/CLO276g8+VCHS+PVUajgT/wNxjYXnz18y1E5OU0CR5aso0mM3iug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=esMSQQEO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="esMSQQEO"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4759b4f0897so1159641f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783851653; x=1784456453; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cmEd88xf+2l2ruWrORJ5dbUfpxyjcxhWXUHf6Cknms=;
        b=esMSQQEOr+vQoNyn06RS2I/4GObYiSL3hti/18LfNr9P0ehdYxPHXInCvLKBz27AIF
         qlVsRIqF3LiYySq4fmgojI3aw76yf2CBeMDrMQ3SyMau0/ejZx1hQjh+c92BqX710zMo
         cX+nJ1BMjfcuPGk5SNsXSKByo6yPZSb+YZKb24TkfcIlit4GjazEyZC9H5rzYys0E57w
         woPRUQPhNdBV3aHVt6XKq+BT9/kUEm+I1nelZM4+Kit8e7BgTuveW3nnhb1BhT3lSCgt
         VG655e1bZ6cb1YInYkEqrAImYRH1rKE/7yZNoEkA8GDzcTHKsiyTgJzhwemMCfwIptei
         tuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783851653; x=1784456453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cmEd88xf+2l2ruWrORJ5dbUfpxyjcxhWXUHf6Cknms=;
        b=TqxZKiQ7RGVuzoNVLytGvIyY6YnUuzFN35xpptruQf6annohbEP7Sco6TPRIG0M5X4
         CJtyJgTFCj3dT1DwHyJwZDG+cifukeNL3al/YORi2T9OC6V0+oR9vv+Sb8pRtiuDfSej
         5Fmu4zdCha+SjCQs2Sohlra/20E+XQSdgGsROgS2MbZfAjvhHRvK7Vbqqa0zF+Mwxb0R
         WrhUQ6y4A1fuj4ajd341nl82Kr3tPQ9dAG/V9d32kcZZeXxLrbeWBQaZjKC0g0GcjKN1
         EK+bRMCLLhMnugvbMg1cWiRkzJA3S6bOb3Ew3e1+/jSNKV9hSsm+Fq5QDcRdLRFwYKcy
         mtrQ==
X-Forwarded-Encrypted: i=1; AHgh+RouuWN+/3UpzrXy9BO0dJPFVoVBnZjHAFqwBFHF45QlWraDsyDk15nqrhitC5y7YwOCFdf6S3CEU0ghVOwjcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxiq4mivqwGBvBq6GdBIl/36GAF8TYjH8HR4JsOXSqXsEhFylvV
	cW64qsH01wsTx/NqwjC40HEKego4quFqTVlHVb7wksfQiTtpC6LMunC8SzJzH3PZBPA=
X-Gm-Gg: AfdE7ck8Rbr8Eb7gZPumj7U8yYTItYJoC3vFtBSCNv89EIUcjmInQTr6ZkGCKpqf0/6
	xXm3gdVcM7xoOkKhLhqk+I9P1Bx3X1kzwmF8EfLfgX+9Q3JQk9mFpn1nlvms4T1vQBzFlkexypc
	c7UzYj55FzlIcbEjhKz+fr6jfXIfegAD+ns9FWoVWTJTJossc5JrOHl12R6VT496AC+skCN1Fz9
	U+JPVLWS2dREIaQU4XyD+PdLiIAX95XpScwaivQC6qR8D0xDEUr/6HhlDc4Vf3OaiMW9VcF3yDw
	//EANms5ujQ2rhT3mWI4zyHMh3NUcp37G3YlrNz43/nYYBe0wccpNrSql2lT0Kcr6WJFFeHk6d+
	GUsxax05VNIOtJLspEBWnD18xAcdCDH69FPe3QTWw9nEs57SbJHZvw3lQ6zPzg9Cw1ajhxgOo1D
	6aoVUT1lgK520cq901Wz+9fQmbjOSFb3YTHtWqkGqGuvwgFOaXZQC1yXWXC4r6cM/bBIzKAI2uu
	CtsV8ORg1Oq2gbDdmNUbI9eJlAw
X-Received: by 2002:a05:6000:26c7:b0:47f:250f:7210 with SMTP id ffacd0b85a97d-47f2dce6d0bmr5100042f8f.49.1783851652901;
        Sun, 12 Jul 2026 03:20:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm75005672f8f.20.2026.07.12.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:20:52 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 12 Jul 2026 11:20:34 +0100
Subject: [PATCH v3 3/6] printk: remove BOOT_PRINTK_DELAY config option
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-printkcleanup-v3-3-574547b8f71b@thegoodpenguin.co.uk>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
In-Reply-To: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783851647; l=3877;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=sFOAnCZDwHdC19ns4aSgMCtOItVvq2/+tYcVxQatFt0=;
 b=JKb1iOGr9kGtjxMDMvrvtANAc8vp0NlTGXG0rX2XOwciPJR5PpOP2CekRiXUGIAQ8Y8GlldxR
 Dq43rpx2y6RBA5c1bioF14CFC9NgxihKT+Osu3Zk9ZrVt16Z7X8I6Ch
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
are two distinct mechanisms for providing similar functionality which add a
delay prior to each printed printk message.

In preparation of combining them into a single configurable feature, let's
first remove the kconfig option BOOT_PRINTK_DELAY.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/arm/configs/bcm2835_defconfig              |  1 -
 kernel/printk/printk.c                          |  2 +-
 lib/Kconfig.debug                               | 18 ------------------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22812833308b22f2cc35b0a42e55b2..2884103b93bca7b76cd3a93946276074cf62d0a1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -651,7 +651,7 @@ Kernel parameters
 
 	boot_delay=	[KNL,EARLY]
 			Milliseconds to delay each printk during boot.
-			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
+			Only works if GENERIC_CALIBRATE_DELAY is enabled,
 			and you may also have to specify "lpj=".  Boot_delay
 			values larger than 10 seconds (10000) are assumed
 			erroneous and ignored.
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 4a8ac09843d73280cc42dbbf63fe3cc9f31dacd2..51a1e94d5aa6c22202778082b877a202a6b9c04d 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -174,7 +174,6 @@ CONFIG_NLS_UTF8=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-CONFIG_BOOT_PRINTK_DELAY=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8be562c9be277670ba3209ed1f810fc87175848a..28e6dff2faa7d4294c1b2ebe2844ce5d4dc0e05a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1289,7 +1289,7 @@ static bool suppress_message_printing(int level)
 	return (level >= console_loglevel && !ignore_loglevel);
 }
 
-#ifdef CONFIG_BOOT_PRINTK_DELAY
+#ifdef CONFIG_GENERIC_CALIBRATE_DELAY
 
 static unsigned int boot_delay; /* msecs delay after each printk during bootup */
 static unsigned long long loops_per_msec;	/* based on boot_delay */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294ad99fda37fa6767c9e76f16a4d14..b552ea51cd53b79cf5d58b8c4deff409b1982862 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -99,24 +99,6 @@ config MESSAGE_LOGLEVEL_DEFAULT
 	  by default. To change that, use loglevel=<x> in the kernel bootargs,
 	  or pick a different CONSOLE_LOGLEVEL_DEFAULT configuration value.
 
-config BOOT_PRINTK_DELAY
-	bool "Delay each boot printk message by N milliseconds"
-	depends on DEBUG_KERNEL && PRINTK && GENERIC_CALIBRATE_DELAY
-	help
-	  This build option allows you to read kernel boot messages
-	  by inserting a short delay after each one.  The delay is
-	  specified in milliseconds on the kernel command line,
-	  using "boot_delay=N".
-
-	  It is likely that you would also need to use "lpj=M" to preset
-	  the "loops per jiffy" value.
-	  See a previous boot log for the "lpj" value to use for your
-	  system, and then set "lpj=M" before setting "boot_delay=N".
-	  NOTE:  Using this option may adversely affect SMP systems.
-	  I.e., processors other than the first one may not boot up.
-	  BOOT_PRINTK_DELAY also may cause LOCKUP_DETECTOR to detect
-	  what it believes to be lockup conditions.
-
 config DYNAMIC_DEBUG
 	bool "Enable dynamic printk() support"
 	default n

-- 
2.34.1

