Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6D3C108B
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837375; cv=none; b=gkuKoY2+9Ch5TQce+r4y3qij+HhXdztd93LGQLJSnyryooTR06FfjoG8iCXvkoNNpSgGDmqfSZQbBhdkGVP52dehS1N77ukNJPGHmecnUG9+Ve6z8u3RBAf656I8uQS9OBf6NR/7tYrdPnd9SeHdBI8iX0EkFYBRCKhg/YWmYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837375; c=relaxed/simple;
	bh=yYoOA2lmEA/zlY9ztKWvlJHJjmdn+UKneaZgldiSEqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MEACICcICEsRsshTNYCyNzHzQOFirZcqrM0F1DAGzxj4qFhinLo9RRb15+rBGX1NtEAXIKZvY/nTcPqiRIlEb29p70WixnKUgHmOGLN12m9VD2jjAsMYz1LHpWXZknBTE6UMfb2oVYnHItB+0rG8y/3eVoFC87kGYcV6M6Z7s0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=gtBfr52S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="gtBfr52S"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so9240285e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1782837368; x=1783442168; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXudV9Gg3kSdcIdzsisUUkPsE1uNKk24eiCajEsGRHQ=;
        b=gtBfr52SzLg8dz0YrF/IioKGNb9syL/DcS/Kg6/FxueFRWdUjnL6skXWmbVB6MQjDY
         UN7O3AvIXEQtY/msUS1aE7M0QMzC1vdYXjHTKekQeD+vhm2fqYTMziHbQjjcPgTREek3
         XoYlCCfygX1tpmDP0ODfv2UIntpuhY+X2O7C9dyrxsCpdW8nWZnrdL8UOoa/Ge5ZKIfE
         srEUgqV9uMpk9rVRy+xu4iEwgQbPrM4UWdMV4GcEcO24NkPj2dz3XF53ktJVnXQFFwdh
         mBKAX7W/Teq7SD/wXXHv/S98dgO6qh+q2KXsGb3zPP1N/3eoeTNIe+WnEyejIJro4vYK
         i1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837368; x=1783442168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZXudV9Gg3kSdcIdzsisUUkPsE1uNKk24eiCajEsGRHQ=;
        b=IevKR/aFd6PPw1Ue8Ovk/aFQW9OfnSofw/3/ERAjXsplosstbUVcxAyFfh8OF10Rxj
         uIkgmuph9uLldKL3eIQYn7nB+UqISpN1gvxnSCZyzTtIClVXCmSGexIlcDq4dBOvC3Ne
         e1UG5lf9SJna0MNqHXY5bDNYvErX48/1H7VU4XjlsPE+9IHHWphGa9/1tmL+c1eQJ5ja
         Ki2xmQyiD3Lz5sfWL609j5H82bk/QVK9UGscWdU1OLh4mWOjdbtZlz4jgUTfcWo031Sd
         nwm+N9DLkH8HIoBhS2Hbgiy4ojcixwFCAkIXkIBTeikIG65L1jr6mc71Jf77tf6rlu6s
         Bs0w==
X-Forwarded-Encrypted: i=1; AFNElJ9+Fe2OXXMjcf7kveyB4vvi/GxoLyZDphdHJwtyWuEyaFondZE6XNP3ZU5cGsJ61Q1I9WWxKKgbHwxXrhr1Kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHd+DEIA/ON4b9LptNyAwupcKSsejG2GYRRU5gtv/HqKz7Nl+3
	6Cnsw9rsqPda9PQSnUsWxbpynx/iO+fH/B36hygh+14B0coLM6byiiIuxhtdltmdj6I=
X-Gm-Gg: AfdE7cm0wDjpt9Yh4GEKiPD9r/6RgMczQEm+2V2ieY6Rii8203mKlJbXzkn1pJ0ANdz
	0fZolpzIXgxn5Y5PK8taxkw4rlqQC6tGCfikewq+AxN6r78qkd989g5Vxm/HTpDhiObuDkcKLKd
	ImtGjqGLA41ivPsQndSQEhAVrsY9Iz2LI9aPOF/CgxTC+DbQRIIcYFrb34byGn6AkKz3d+Jt60m
	JtnsxD5krJ07HK6HsYsyN2YdmlLEQAcPcQdNlHliKGmf2f5FXnuUQK7Em3sLuxvCZzZT8rPHqHe
	vgNGdZBsZj63TUPIAgMvNxxLvdiyZXEh6cS3mcbxPeL4mPTd34jVnssm1lu8wRrExfZClQq+KK9
	HGtILznP/wrfa3AbV8TM9hAXniRNEXXsXIbh7wHmptp6HEA+agghQShLcA/PI/eT8K6ZI54YKrl
	MhT5mn6OyF2BnclzPsS+Dtl8Nrr9wBI363MlIfs4fsx1ap7qC8F0/8M/uzWv1OVAzVTaPrTzNWh
	noqTSE8WBjeJq6E6jGyJeqksdKc
X-Received: by 2002:a05:600c:c491:b0:493:a43d:6a2e with SMTP id 5b1f17b1804b1-493bc53486emr32913265e9.8.1782837368312;
        Tue, 30 Jun 2026 09:36:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be486f52sm8452225e9.0.2026.06.30.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:36:07 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 30 Jun 2026 17:35:57 +0100
Subject: [PATCH v2 1/4] printk: remove BOOT_PRINTK_DELAY config option
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-deprecate_boot_delay-v2-1-f9883d36aa4b@thegoodpenguin.co.uk>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
In-Reply-To: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782837365; l=3868;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=yYoOA2lmEA/zlY9ztKWvlJHJjmdn+UKneaZgldiSEqY=;
 b=tIVy2D7qSph+SB/d2oZUbUbYo/M9aCbYpqRMKAajQJAv9Y4kMRiblxvshg3oHIsoMle9n8UXV
 3syb16Mbz+VC5jBPoJ59uagKLXQ8CWPlIC1wu/1BuvVQKicQDOc3t8k
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
index 2fe9a963c823a41e7df10c29939a2abb55462859..77f53eaed13216c6c3946adabc0c8fdba6401d91 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1289,7 +1289,7 @@ static bool suppress_message_printing(int level)
 	return (level >= console_loglevel && !ignore_loglevel);
 }
 
-#ifdef CONFIG_BOOT_PRINTK_DELAY
+#ifdef CONFIG_GENERIC_CALIBRATE_DELAY
 
 static int boot_delay; /* msecs delay after each printk during bootup */
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

