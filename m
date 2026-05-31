Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7A375ADC
	for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780269483; cv=none; b=hES/r13hAY6p5PH8vLpTlThDT5/9w8tDbLP2c2Hd6CVwcNpqoj69ydZTWWNs17luKUvaZ3e+gnTFEh69yH7geub5kbvdpA/JbwnUXLF1H+3JtcfZWy0Jfq8QRMd35Rkr6YnqMJSkI1268s0Pdcl48KjLNFHGrV6sN9FK3341wNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780269483; c=relaxed/simple;
	bh=NzyYbeRmipVDUcVFnXEzhSA5L8Fjv+M/rg5sEJLce8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFS9W4/sS8VgtSfvR8L5Eq9bQ7ckMUTzB1HoPgcEVkpzXY3M2HplKaj06uFv0Bv1D3hllk22fPJdYLCdmRKJlNyR6ZC4X6QQfhdfzkJHq3647MA1SDogS/KO0xlVzWwR5yn3DNbHV2Rf4P4kF1nYO1BPyCPhlH3Z4ZLGKtJf/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=Le5bMycm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="Le5bMycm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4908b92904fso42697555e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 31 May 2026 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1780269477; x=1780874277; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw1fhfSYYqzCwDV1bdu9APNnKhaP1vTsxLW0x4AdDkE=;
        b=Le5bMycmbKchiLwAhQv6c3XhIKueEtwioOJ2Co3Ft0pADg9z7xNZPdU2EkhPOTdwCX
         cquWiY8imu+BbruugGv1j69Dy0rCNAeOnR3FoW+A17pBPlATRy6nqCDE1SCyCOPE0g3w
         MWT6JSi79nkuXyZ+VKHO6yJ4MEdYKUzcPIR8QrdUNwT4pMRXOYFFfWLzUABVe8LSZLg5
         GttCnu15G9ixl4evDliu3aerxsBeRgGv5CZaWF1zwfAHIMrFYdC783BxkKwg1ACKVxYK
         uXHKjwHhB97jU57XMsGx/qMObviXqBp3zC6R5MDJluQMH2sDbIbv+FC1B1cqegrdeQ0Z
         PpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780269477; x=1780874277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yw1fhfSYYqzCwDV1bdu9APNnKhaP1vTsxLW0x4AdDkE=;
        b=kqGiH9P6wpqgVfozVIMV4h/5q1Vs3gNVpWqC8YaBviz3qV9lI4NlHUm4gekDg73lNv
         2HhKUoNkLDacs1cass9cfNxtTa10XEUD3GbfotEnulNzRHAwgC+oyEwnrgpbYRiq4+c9
         vq0mgTdRfz5pLK8QefmvrsA1gEkVEJS196DGe2Zuvlu14XGefdnfBmaocKuuGP9hPtob
         eC5QyunBoo+NeW5ga1Bb8cyLCxb8qsPB9k7/lhpPUjFtiEzBTQciX1p26gMeivlWQm4A
         RBXE9VW9bWNJIAEMW5QaklqoVfxzYWcSAJVi7FwzeODJmm/VjnQ74yRgtUCkD8r+2sk8
         bQeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AdqqgHo6ChC00YmZ9uvB67ZhJH8PSXMHKM/kiPPOZ+2Ppv1TBIRsYBa/2Wb5TRHKMMI+7h3njebYu0otR1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKNIBlC2zn2qXt8Q9ovXfFt4kdGo8mGBiZ8gOfTX9NqiRalckD
	u4Rnqo+eDBuKueES0+i+s1xTpOXfDBHi+6RMcQEt0ceKSl3ZFn/At8yH2lmGn6b+StM=
X-Gm-Gg: Acq92OFBXLS1gdfDNJOMX+heLkKk+bRjd9PTHL0Tp1ck7A099g5gDq7xisX9Eq6d9of
	Y/CAK4v9uvshs9o/tV4xoR/vHWPpXRyAe2iD7o5FklneUdrNeUjdAGGsLtHMWaab154il6j8/SY
	eVW54SqDATIvAtgfX/nspqwJwGnetTWhJIFQdGA+s6IjFF+xr6sy8soD1FnxcEStdxGKZp4xSrP
	AHT0bau+HZVxvqTJbwJeKrmBeBiE55dnSn5BGqJrJmADb2jw7Pjjnp0w8L7TumsQ0LZ7umzOkYp
	S+SftKTbFcSyfCKDlcJkUY95ZF3keywUGIL9XvGfph443Db0z1g9/vEoiEQ4xtMNyuMA4jRVtmB
	jMf5jXtym3xc3LSpQP5mwGGSgmWr72E98IbxQcAamsOe3COKBPm2b0MmVtaIxIpZmQGtAO8wUxz
	iWF9/0nWmBRrMavakKWrHXfgbzfDDEnGh7Cvt6Av2pm+E4JgbPv94o6oDdXRy5ecI6zq1cXvMSk
	iMn39/bEn+dR8SWsgvACRKnd4nrqpKbCCZoCsqV0qs/SiKb5A==
X-Received: by 2002:a05:600c:6558:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-490a294b864mr118910765e9.28.1780269476864;
        Sun, 31 May 2026 16:17:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm20496544f8f.11.2026.05.31.16.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:17:56 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 01 Jun 2026 00:17:38 +0100
Subject: [PATCH RFC 2/4] printk: deprecate boot_delay in favour of
 printk_delay
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-deprecate_boot_delay-v1-2-c34c187142a6@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780269471; l=4252;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=NzyYbeRmipVDUcVFnXEzhSA5L8Fjv+M/rg5sEJLce8g=;
 b=i+GDn9CndzdObBjnvYG9EQGVKMlZ7e6Fy6BNLVupTvtxPnVqFEb/bVi2JyX2zv2+YUvaYE0j4
 OueQHamNr33BR1S1U4QUwBadcLGdUbhjHwzvBhiP9fMeOsqdMoVpSvg
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
are two distinct mechanisms for providing similar functionality which add a
delay prior to each printed printk message.

boot_delay provides a kernel parameter for delaying printk output from
kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
configurable only via sysctl and thus is only used post boot.

Let's deprecate the boot_delay feature in favour of printk_delay. In order
to preserve functionality, we'll also extend printk_delay such that it can
additionally configured via a kernel parameter.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 75 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 822fcdff7b21ac00cfa655c3d9b4de2698fcb7d8..ca510b9c76458f5c1e059200060d9d6be4c859b3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1291,40 +1291,28 @@ static bool suppress_message_printing(int level)
 
 #ifdef CONFIG_GENERIC_CALIBRATE_DELAY
 
-static int boot_delay; /* msecs delay after each printk during bootup */
 static unsigned long long loops_per_msec;	/* based on boot_delay */
 
-static int __init boot_delay_setup(char *str)
+static void __init printk_delay_calculate(void)
 {
 	unsigned long lpj;
 
 	lpj = preset_lpj ? preset_lpj : 1000000;	/* some guess */
 	loops_per_msec = (unsigned long long)lpj / 1000 * HZ;
 
-	get_option(&str, &boot_delay);
-	if (boot_delay > 10 * 1000)
-		boot_delay = 0;
-
-	pr_debug("boot_delay: %u, preset_lpj: %ld, lpj: %lu, "
+	pr_debug("printk_delay: %u, preset_lpj: %ld, lpj: %lu, "
 		"HZ: %d, loops_per_msec: %llu\n",
-		boot_delay, preset_lpj, lpj, HZ, loops_per_msec);
-	return 0;
+		printk_delay_msec, preset_lpj, lpj, HZ, loops_per_msec);
 }
-early_param("boot_delay", boot_delay_setup);
 
-static void boot_delay_msec(int level)
+static void early_boot_delay_msec(void)
 {
 	unsigned long long k;
 	unsigned long timeout;
-	bool suppress = !is_printk_force_console() &&
-			suppress_message_printing(level);
-
-	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING) || suppress)
-		return;
 
-	k = (unsigned long long)loops_per_msec * boot_delay;
+	k = (unsigned long long)loops_per_msec * printk_delay_msec;
 
-	timeout = jiffies + msecs_to_jiffies(boot_delay);
+	timeout = jiffies + msecs_to_jiffies(printk_delay_msec);
 	while (k) {
 		k--;
 		cpu_relax();
@@ -1339,11 +1327,34 @@ static void boot_delay_msec(int level)
 	}
 }
 #else
-static inline void boot_delay_msec(int level)
+static inline void __init printk_delay_calculate(void)
+{
+}
+
+static inline void early_boot_delay_msec(void)
 {
 }
 #endif
 
+static int __init printk_delay_setup(char *str)
+{
+	get_option(&str, &printk_delay_msec);
+	if (printk_delay_msec > 10 * 1000)
+		printk_delay_msec = 0;
+
+	printk_delay_calculate();
+
+	return 0;
+}
+early_param("printk_delay", printk_delay_setup);
+
+static int __init boot_delay_setup(char *str)
+{
+	pr_warn("boot_delay will soon be deprecated, please use printk_delay instead");
+	return printk_delay_setup(str);
+}
+early_param("boot_delay", boot_delay_setup);
+
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
@@ -2119,18 +2130,28 @@ static u8 *__printk_recursion_counter(void)
 
 int printk_delay_msec __read_mostly;
 
+static inline void late_boot_delay_msec(void)
+{
+	int m = printk_delay_msec;
+
+	while (m--) {
+		mdelay(1);
+		touch_nmi_watchdog();
+	}
+}
+
 static inline void printk_delay(int level)
 {
-	boot_delay_msec(level);
+	bool suppress = !is_printk_force_console() &&
+			suppress_message_printing(level);
 
-	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
+	if (likely(!printk_delay_msec) || suppress)
+		return;
 
-		while (m--) {
-			mdelay(1);
-			touch_nmi_watchdog();
-		}
-	}
+	if (system_state < SYSTEM_RUNNING)
+		early_boot_delay_msec();
+	else
+		late_boot_delay_msec();
 }
 
 #define CALLER_ID_MASK 0x80000000

-- 
2.34.1

