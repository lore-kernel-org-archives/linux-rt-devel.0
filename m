Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43FA47DD59
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 May 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988714; cv=none; b=QIf6PG2ja47vbUvaXbT5TdO7r9YoyFEfh+vnFmlHsjT1UCVq5B0PuWljBYSmXJOTJSdYWGKlbGkodHv7Z+JLC6Mo+GSCM3enxV0WU3B67gEWGX5xTcjcxp+lP4i8wdT+3IKAKLckC4Ztqtl0b/TTyskH6HrUm2d0jR/NmetK20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988714; c=relaxed/simple;
	bh=OO2wnaK4mcEYjb+iiWNgPvHCYFazRH7X6rVJNuFlFgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F8QFtxn1uo+DqCjzAsRxUe8ZYKBHmZGEtEtkFZ3Z2GTIbcWQUeganvmljR5xIgFkcRjzkXLG0C9AugpexJm4RANP1bKb4+fRKfOrpFvPvAVgrtc6+a3OEFPa2cuJD/0pfck1eb/EyqFmRp+GoDorYvf5UVFfgsyUxLDDJrzoXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=bHVB8NMa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="bHVB8NMa"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7e23defbso2993783f8f.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 05 May 2026 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1777988711; x=1778593511; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYkIP1Kvmjl9SAF9O37JxjxuW1pir4kJK6yjtigDUqI=;
        b=bHVB8NMasuifuREgXh7vwWZH3qkEcmuObsioGtb9BpJdNZlm9R8C8bcBEjgTIXjZCk
         ciCYChXMVu5q0bx9Jq7/hxETBLK+BqfZMqURWtdfn/oDS5sCnM4cDpVLkmrar/oikU5D
         sN1KVLKj0S/UPgolF1mx9Q3QDIhm5NQMgd2VF1ygrEofzn1Y/EAXi37nvhg3RCqQwOk9
         7qR71qZU8gX/LlKE1mygNsEcPXPh1sWuJuH0Yu1iH4CU09lN094Vj5MepQVeRAPxvT6z
         wdCLXudba2gZ1OPIKsdVZ8VyUFlQLopIJMnycoI3uYNtfowZtO5+grW7JwGTs3wk8f57
         EUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988711; x=1778593511;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYkIP1Kvmjl9SAF9O37JxjxuW1pir4kJK6yjtigDUqI=;
        b=IF1heIGEcfpcPmWGG5tRbfslfrA6ahOnubz2daco07KQXK+2VBJbxFhLF+5zV5IrP6
         GkE34MNCe+oTSdDAGGSZ4raX3VwgQfvMmUfTg6Q+g2ZJSnDi8nj+ynCVX8SRfuvEwT1R
         6cS/BgQhrqBY1WBXazvv0f6mePKu2Z7V6R/wsUUNLE3XPlWLcpmOCZTT5icNhlF9vtFv
         WZGXqWyTa72CtWHlAsJmz6ArpMz9cUKVlWMpjM4NG8Gt02H7em883s5VVcS2yD6gPuua
         ft7DDUQZggwPaejewH3XPH6HattviY3aBkHdanVOGKnS4i+cf9wvxuHS3xydOtIeKguC
         PQkw==
X-Forwarded-Encrypted: i=1; AFNElJ/h0xHL+A3TrtLBwRrKA7VUjtCQ7z4R9btceyoCjcnqSTQHh7f3FG8criAG1aD57KOrYYICZsAVIx1xo+7IXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxqNHYiYlnS4Xxq0VIMm5vijxby/I1r+nLW++KW/OYHFxfJEc+
	Q45u4+tOKQ6N6YKxJKXsErhbdag6jl1Pq0KGGAN9MqmGRQ0dVqjZ2hY81VPLXT6LrXE=
X-Gm-Gg: AeBDieuGN4z/NMV5/qxatgJw7SfiTszIMZBO7JaimhqWZtYR4+7w/wiSb2bGMEBk8oU
	CV2DgyQWdztFpDIBuuLx+3/JAqHYbjvQirHLs9ToObxI4fzn2gATGjj9moooGRXXcGHphra8qTC
	Ajbw8in4dGrp+aZ6KEmgzIae2dZG8EdzAItF562zk2bfVvjMfX4qmg4VpTsG125NdE9Bsm+wmLJ
	aYa8PEVQt4Ky0wglgzZBT1xST6BoTxRvHnwz2llK7I3YpwfVy3blxFmA76SV8vXBWHNOQqaQtAb
	8RDbw+xDroKoHlzcJ/DoLjou7AbM/gqHUYX0r6ZI9Fu+laCQGWS4K8Gbyblc2jBgeaup0BqDLO2
	sKEGeYxcJk1/Dj9XLwYeKlznyRoxTkvP4BZh9UFD1ytfM3vknaqID2NBGntBxrRz5L0UJ5GNj7L
	jv1kBWw0G0GDC0e3g/Wc0175UzPuqesLfe0i6VEHRKeIjepaNhhPVU6QCzvZ5HoqmgUoRbT5nNf
	G35cvE4y460XwWbPc2RBS+n4mw+6pFWdWUIJjP6BPTFvjxiSw==
X-Received: by 2002:a05:6000:61e:b0:43d:7b90:fa23 with SMTP id ffacd0b85a97d-44bb65df7c8mr23463107f8f.29.1777988711101;
        Tue, 05 May 2026 06:45:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960aa2sm4573113f8f.29.2026.05.05.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:45:09 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 05 May 2026 14:45:00 +0100
Subject: [PATCH RFC] printk: remove BOOT_PRINTK_DELAY
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-printk_delay-v1-1-5dba51d7f17c@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAFv0+WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNT3YKizLyS7PiU1JzESl1zCwsLk5TERPPUJAsloJaCotS0zAqwcdF
 KQW7OSrG1tQA9efpKYwAAAA==
X-Change-ID: 20260505-printk_delay-78884daa7eb8
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777988708; l=9156;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=OO2wnaK4mcEYjb+iiWNgPvHCYFazRH7X6rVJNuFlFgk=;
 b=1mSO9+z1xZYnd2PD5ecHPzA8luCmG2iHBUBqwUQ5I3+cllJwsPhB1Y9WQns3lz8TMTmjpPXQv
 aiA/4aN1W1TD+b75eMJwqxoQxpqFNYYzZrL7z2rMU7VnG0f83XfVSBI
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The CONFIG_BOOT_PRINTK_DELAY option enables support for the boot_delay
kernel parameter, this allows for a configurable delay to be added before
each and every printk is emitted. This is DEBUG_KERNEL option that is
helpful for debugging as kernel output can be slowed down during boot
allowing messages to be seen before scrolling off the screen, or to
correlate timing between some physical event and console output.

However, since the introduction of nbcon and the legacy printer thread for
PREEMPT_RT kernels, printk records are now emited to the console
asynchronously to the caller of printk and its boot_delay. The delay added
by boot_delay continues to slow down the calling process, but may not have
any impact to the rate in which records are emited to the console. For
example, if delay_use is set to 100ms, and the printer thread has a
backlog of more than 100ms, perhaps due to a slow serial console, then the
records will appear to be printed without any delay between them.

It would be unhelpful to add a delay to the printer thread, and it would
not be possible to disallow selection of CONFIG_BOOT_PRINTK_DELAY at build
time as it's not possible to detect which consoles are nbcon enabled at
build time. Therefore, let's remove this feature.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ---
 Documentation/admin-guide/sysctl/kernel.rst     |  8 ---
 arch/arm/configs/bcm2835_defconfig              |  1 -
 include/linux/printk.h                          |  1 -
 kernel/printk/printk.c                          | 73 -------------------------
 kernel/printk/sysctl.c                          |  9 ---
 lib/Kconfig.debug                               | 18 ------
 7 files changed, 118 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec5a1750d9112a851deb8fd976d32d..afdf443094fc3d74c0220548357c000fafadcb19 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -654,14 +654,6 @@ Kernel parameters
 			embedded devices based on command line input.
 			See Documentation/block/cmdline-partition.rst
 
-	boot_delay=	[KNL,EARLY]
-			Milliseconds to delay each printk during boot.
-			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
-			and you may also have to specify "lpj=".  Boot_delay
-			values larger than 10 seconds (10000) are assumed
-			erroneous and ignored.
-			Format: integer
-
 	bootconfig	[KNL,EARLY]
 			Extended command line options can be added to an initrd
 			and this will cause the kernel to look for it.
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index c6994e55d1411b1a3b708b3e2439144bac814e6a..fa1ca90105ab58a2143c3b223c023eb429371474 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1125,14 +1125,6 @@ default_console_loglevel default value for console_loglevel
 ======================== =====================================
 
 
-printk_delay
-============
-
-Delay each printk message in ``printk_delay`` milliseconds
-
-Value from 0 - 10000 is allowed.
-
-
 printk_ratelimit
 ================
 
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
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd411f2238b45374e8a71222f0407c..8885e11367d50ea1cd7642249852d011e589adb4 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -188,7 +188,6 @@ extern int __printk_ratelimit(const char *func);
 extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
 				   unsigned int interval_msec);
 
-extern int printk_delay_msec;
 extern int dmesg_restrict;
 
 extern void wake_up_klogd(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0323149548f6a4dbcdd80029478b809d44de9b62..47c38575176c944b231f47c034a0c1ff899cbec8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1289,61 +1289,6 @@ static bool suppress_message_printing(int level)
 	return (level >= console_loglevel && !ignore_loglevel);
 }
 
-#ifdef CONFIG_BOOT_PRINTK_DELAY
-
-static int boot_delay; /* msecs delay after each printk during bootup */
-static unsigned long long loops_per_msec;	/* based on boot_delay */
-
-static int __init boot_delay_setup(char *str)
-{
-	unsigned long lpj;
-
-	lpj = preset_lpj ? preset_lpj : 1000000;	/* some guess */
-	loops_per_msec = (unsigned long long)lpj / 1000 * HZ;
-
-	get_option(&str, &boot_delay);
-	if (boot_delay > 10 * 1000)
-		boot_delay = 0;
-
-	pr_debug("boot_delay: %u, preset_lpj: %ld, lpj: %lu, "
-		"HZ: %d, loops_per_msec: %llu\n",
-		boot_delay, preset_lpj, lpj, HZ, loops_per_msec);
-	return 0;
-}
-early_param("boot_delay", boot_delay_setup);
-
-static void boot_delay_msec(int level)
-{
-	unsigned long long k;
-	unsigned long timeout;
-	bool suppress = !is_printk_force_console() &&
-			suppress_message_printing(level);
-
-	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING) || suppress)
-		return;
-
-	k = (unsigned long long)loops_per_msec * boot_delay;
-
-	timeout = jiffies + msecs_to_jiffies(boot_delay);
-	while (k) {
-		k--;
-		cpu_relax();
-		/*
-		 * use (volatile) jiffies to prevent
-		 * compiler reduction; loop termination via jiffies
-		 * is secondary and may or may not happen.
-		 */
-		if (time_after(jiffies, timeout))
-			break;
-		touch_nmi_watchdog();
-	}
-}
-#else
-static inline void boot_delay_msec(int level)
-{
-}
-#endif
-
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
@@ -2117,22 +2062,6 @@ static u8 *__printk_recursion_counter(void)
 		local_irq_restore(flags);		\
 	} while (0)
 
-int printk_delay_msec __read_mostly;
-
-static inline void printk_delay(int level)
-{
-	boot_delay_msec(level);
-
-	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
-
-		while (m--) {
-			mdelay(1);
-			touch_nmi_watchdog();
-		}
-	}
-}
-
 #define CALLER_ID_MASK 0x80000000
 
 static inline u32 printk_caller_id(void)
@@ -2450,8 +2379,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 		ft.legacy_direct = false;
 	}
 
-	printk_delay(level);
-
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	if (ft.nbcon_atomic)
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f15732e93c2e9c0865c42e4af9cb6458d4402c0a..5178540b2643d1b1a51dfef3f0444414889d7a3e 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -41,15 +41,6 @@ static const struct ctl_table printk_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "printk_delay",
-		.data		= &printk_delay_msec,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&ten_thousand,
-	},
 	{
 		.procname	= "printk_devkmsg",
 		.data		= devkmsg_log_str,
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

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260505-printk_delay-78884daa7eb8

Best regards,
-- 
Andrew Murray <amurray@thegoodpenguin.co.uk>

