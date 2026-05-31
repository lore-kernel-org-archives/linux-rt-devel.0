Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482363624C8
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780269480; cv=none; b=dhW9T2WCU4LKo1y19hnjTizZi2cna/eyQtHssMYl8xmJIhTcsfxKzzscA05GnViO2B1Aa8XYLuMCmqcnJXipieFiImF6yAeY8CCORshx9393OatyWUrhLWH/1Wou8//xU8SAmsReNv0x6led06oikfNFHI+e/yscxAGYdqxPfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780269480; c=relaxed/simple;
	bh=5TSr29LSwGDXLwLvDWzxI5WHv1bELD/GcXyz7uzulhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdttgA+OoGPOlXcBfkdsm7qolLN4oVqxe6w3w/UuggE4o/Eud3PuEetkIDYBVgG2eSbPKwxrhbPEjiQX1+URK4vy3R+D12gYcevGpc8+j250IiDBZmlX/dHLRhgPf5ZSIr0lZ+HjnOytgli4DJrcDFfKFpgPHdrwMgGTSo1//hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=EsdwYL/3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="EsdwYL/3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1255777f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1780269475; x=1780874275; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlnkV007FI48mXpf+dStqCmocIvL2i8BzMwzQ0j9H8A=;
        b=EsdwYL/3n48Vzvgpzou5Fzntmz+dR/QqRa1d34bW9UFlAXYHyV9NrZ3xaGQ2CwXTty
         PenPTcK/Qqp+qHAYFqSYCgNrYzrQ9mRH/l+UL5x+wGdELMZbrRYzt89S/ThJgtNzPCr8
         SssBx6mPYDnTY7SHZfzABSUW7MfcrskHMnGzeZye5Y/QrKgyjFsDILZQIR3q/wjuI+je
         1cnvZoTIlw3eFV0hRwIrzH19F8tlgaMI03o9KetLKAhLfHi60P5dMxkhCo7MChQtH+uq
         36mMeHTL+Cld0Y4f9Q8fR4UgU7xRLmFEcTWzecqcDTtsar7tI58oeyEF/qgggGFodW51
         86uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780269475; x=1780874275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlnkV007FI48mXpf+dStqCmocIvL2i8BzMwzQ0j9H8A=;
        b=Bo0QBr39imiQ3wH32AijPXYzzw/jdlMUAZbNZX0KArQwXTO3A89Y8WRhYOAiboby78
         q6ku+geo/0/2rzZSg0YViJV14aGHs84tr+AcinW0FLHDel2pAM47rN/+b8aBYOwE0WB/
         ptnprI3DNqnQjjkxx9CIeV11erNz/v6N8UrEx91z5XzqMCJC9CG4/pYTfLKLYskHzzDz
         aLUxmXI8KnmhbdfXyi7tHfG2zugIghTWsdCccXm3w8QQ4taWNJ5GL7aSltV/3nn0NvnW
         48kFJ4h7oLXyS1c3McUDLjN/TfNXLU9mtSQuTJo/V/tlQ25FcQlJGyacHpZRHP2RIADc
         ZbxA==
X-Forwarded-Encrypted: i=1; AFNElJ9pwR4YvidRkdDHCu2A9Sa25zAH0vwZDA3Jrm85UrJZrh4EHy/KcUKaGpBJuoi7NL6n4zSltrApnxi8l6m25A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz6cks2L1PG0a0YJB14cY3L/y4N9kHTJ4Ixp3VhxNvLkYITlvS
	mEcwis+ST1ugec4rWcx68+xdpHqck8NnRvxMmoHtCqsOnGishWj2RYm8Onp5QGfjh+4=
X-Gm-Gg: Acq92OHhCMa0I8EJfJZn7ECWUNpFtSg5TpiitUyDQs6rTr0YfEiwhpKPBI2RuTV45+/
	D4vITHICk4H9P1lFA6ADxMnZuOcsDqVAlIL/YmlZJkk0CLMaO9n3x5Lvmj/Y59nOeAj6sG0rf83
	d14jpyZ6B/+CACIhO9Yke2K+N4Y3MypQVCj/c7eYm/O3kv6wecVokBqi9cFWDLNW0Jr3TSU5cgl
	15ISJljA4v/opKGaUR+PSU2NxaDQOdLRtA3UHRQxH/eXIQjaWdRhfPjYYM67jxWrdYMGKz+5+HP
	ON9PZGUG/x/zViCJb6qX8FnNeO3AJePZCNoZtE8vYUdYHpHK+BYM1avyELybwmkHRzcYGympE+6
	nytuG1Mg8NafJD4fbjTHek56ta/keCKdVh+7PcoNwfLHlSc/+WnidUESJ9VTmGqe6JA6uFyPo+i
	LOpKTiWAPorbNu8RdHGcJZTxFTyLRQ3x/7Chf2I5Ov5xxQllkP2M4TGrlXfm+51SYVQWhQzQxD4
	hXsC/DmuRoIaRhtU6cbaKm5CchW8M32pJ7cTq8migIkJB/Dxg==
X-Received: by 2002:a5d:534c:0:b0:45e:73a5:e1ed with SMTP id ffacd0b85a97d-45ef6b5b858mr11489190f8f.27.1780269475497;
        Sun, 31 May 2026 16:17:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm20496544f8f.11.2026.05.31.16.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:17:53 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 01 Jun 2026 00:17:37 +0100
Subject: [PATCH RFC 1/4] printk: remove BOOT_PRINTK_DELAY config option
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-deprecate_boot_delay-v1-1-c34c187142a6@thegoodpenguin.co.uk>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
In-Reply-To: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
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
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780269471; l=3823;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=5TSr29LSwGDXLwLvDWzxI5WHv1bELD/GcXyz7uzulhE=;
 b=RpHQjnwPlCMM2VtepAdORdFkPWqzLeIfyeSmjtS5aPXoHK3GX0Pi3LUQVR56kW6L6eodrkBg2
 zCSx9+ttsm9BHv7/kQjLkxfOiOnRPICyMwRxfmblDJUyamhDHIP9DWi
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
are two distinct mechanisms for providing similar functionality which add a
delay prior to each printed printk message.

In preparation of combining them into a single configurable feature, let's
first remove the kconfig option BOOT_PRINTK_DELAY.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/arm/configs/bcm2835_defconfig              |  1 -
 kernel/printk/printk.c                          |  2 +-
 lib/Kconfig.debug                               | 18 ------------------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 97007f4f69d4e8f19acaff81c9af8421a09822bf..37b618d176f1c499f457f0d8b5679c29ee7ab177 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -656,7 +656,7 @@ Kernel parameters
 
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
index 0323149548f6a4dbcdd80029478b809d44de9b62..822fcdff7b21ac00cfa655c3d9b4de2698fcb7d8 100644
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
index 8ff5adcfe1e0a2f13893c92c3b95498fedb83855..fa82d76e7de45e05e5c0d578eaa2e5807bca39d1 100644
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

