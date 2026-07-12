Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97B3A4F3B
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851661; cv=none; b=LBEZCBjf9o7c9vd0UkRDTreqns60hm+4G0aDuY3dIt7u7Xb6sJjEaEnA3/lj1o6PXDUTXCvjuUvsjTyY7Es+ZkAt0OvyVieS7unFMsDbhhbhvnSwNXPie4fBC13VEnnNFvZritFx+EaHTb7X+3KE+u6Qu3pemfeGo/39lsTMa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851661; c=relaxed/simple;
	bh=LbQuTQZ0Pr0m3R7vmjHIVUKClw/nFOcuwqEj3p3Hj4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REM4Rl2UdR+ZwLJDiKJrwgKSLsTFmyV2lKkSafDp1xDY5NmpRFYZrTMFIRaNQEOki0KfrUjLrgL/xE7rEjXo8yMxAnKvPoG4fQ+or1ZR2aQIuDnsgM2yS10nErv3dSfcwiR/S9fYfbOSb+QWTT9xrGMsKV+XQLStR66pcDXl3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=uuRX5GO8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="uuRX5GO8"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso1271606f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783851655; x=1784456455; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/g3zYl79jgjqjNI27fNzLhdq4bY9YgKy83ASVS+p8JI=;
        b=uuRX5GO8I5MZp1ZC/7wV+/HtsDnPWbSGNz+lPwtmnFndJ0Dfzmv4tOUOCsLJ9ikHtr
         lkm7yOubVpGtj1IL7/2zrYrdJHuf9ZI/z8fjIKAURVCEBkcUBqwh//cv+Ow7/mTanO6i
         722514jDjYr8gQwUZ57aSwKqDzDKRtBol+3KHCL/uIMIrBHbsn0ki3A8SMQX4NsAVMNw
         XkKj0kjzLKfeoMXwhMiJsIQ8RiObkCyEx+XqGO8rHC3h01zSjwtbIOJCcN8qRbryvK97
         SeqDR4aYHXQdawrKbM6GaRuU9wigdazGR6Y2UdTiptkjke10zV6aWRUAMUvOKbmo4Gi3
         meIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783851655; x=1784456455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/g3zYl79jgjqjNI27fNzLhdq4bY9YgKy83ASVS+p8JI=;
        b=aBW9Wv0g02bIex72xuRXRPuns432eoR+ox6Va2jyBc8SoISvtnrwk/cMiZpc1RH/Ob
         ZlKBYwTo25+0oFcYMLQFiXSS7DwwaHFG2p4fUD76MxDR4s1pZUXaEeM+TtHxOHvdY/fu
         v37dXFFQu+GpZ40YFdnwIvi5J8Hl1GL6kjgU4gAUFFndFFjt7sJK5Yz81/RQr4u955E1
         ldlMbxbxHSijjQxVjV5Cg4LT0lOpSrZqcaoZM5wIRBzu1y3qySc5YakjdeKjVkBg+q07
         V8hLaF4ts75u4I20jy+6WJ3qxUIviCnExuhK7DVfqOvS18GTeIczfvvp5L5UCI6uZqSR
         iHDw==
X-Forwarded-Encrypted: i=1; AHgh+Rpd9ZjRYQ2dZ5nYGcJZU5rmNqDGOG0uOPvmpsMfdK2qkpu3c05zHWYYIJhvmp5BIcZmfFdNQnXB1ceacVGtWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi/EQNKXEmJPtooUNenxRJAhSx4M1w+QLv3eNxNIGK5nOKQPXf
	5bw0SGvx+GXu8Ix4WIez1HTpWErtoCwIMm4yxd+8aY1UZrqVx9HNYlW0bpVZdMd9VVY=
X-Gm-Gg: AfdE7ckvounfOrOn4tr+0UBGJXFrlOHy974+env0ECM6suOiqPgqlKSyeWQ9Z8KnoDb
	LDmEQpgKq6bsW+cmB3Cn96hmVfHkeZBExnlpwJnXQI+A1WLzr+0wbJ3JRxQzpnKtVBXPzwSTH+e
	NIsvvxAVRs70b0cqP+ak593jb1svxPC3828kOtVWbKJry3PbdiHwkdo8pKmpfZYJVl8dpK49yoe
	WI9hYcF2/9wAOfn0upiVpfVhtXKZ86NGVO2dFAifEVdgGpb/N2vwVvX+uZotUL/9j4iHVF7oxH0
	KDMUWJQdtzXMetRKWlLNmuezGqIpNdtvoGLdwizqmNu9m2VJ+gukwVOKyYtTnq1AvgqVtMACHdZ
	db7p1T7AA8/HU7Cd4qCHz8qj/8bj8DrxjGVbxvBnzpsTBGyY8ZF2kujznFzn+wcCAVn1Zg+oTq0
	BWHWApLl2sdGqCjNGiaqxsqYL9SsnO415l4WIJDJfRy+7Hb/FBNy3t2dsSJIHOxZ6RM7En6Y0Lo
	ixGtebaosoUji3ndS9J/p1zl5UN
X-Received: by 2002:adf:f3c7:0:b0:47f:2de3:b34d with SMTP id ffacd0b85a97d-47f2de3b435mr3662291f8f.46.1783851654747;
        Sun, 12 Jul 2026 03:20:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm75005672f8f.20.2026.07.12.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:20:53 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 12 Jul 2026 11:20:35 +0100
Subject: [PATCH v3 4/6] printk: deprecate boot_delay in favour of
 printk_delay
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-printkcleanup-v3-4-574547b8f71b@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783851647; l=4810;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=LbQuTQZ0Pr0m3R7vmjHIVUKClw/nFOcuwqEj3p3Hj4Y=;
 b=R41m4NO6PR52KYXcKNaMGQef3mF4qMXlCyOa+etGfe9PI3pHfH2n12uQ921q9TEyV5MQ7i1Ck
 /UOSQgcFAYlAbGVI6lYGPv+gPu/l+5sphbueqDTDmrG+ar9Raust9yH
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
additionally configured via an early kernel parameter.

Behavior change:

The delay enabled by both "boot_delay" and "printk_delay" continues
working even in SYSTEM_RUNNING state. It must be explicitly stopped
by setting printk_delay=0 via sysctl.

The delay is skipped when the message is suppressed in all system
states. It used to skipped only for the boot_delay.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 81 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 28e6dff2faa7d4294c1b2ebe2844ce5d4dc0e05a..4517266e9ca112e0dcb0163a99dd0e8d50931848 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1291,43 +1291,28 @@ static bool suppress_message_printing(int level)
 
 #ifdef CONFIG_GENERIC_CALIBRATE_DELAY
 
-static unsigned int boot_delay; /* msecs delay after each printk during bootup */
 static unsigned long long loops_per_msec;	/* based on boot_delay */
 
-static int __init boot_delay_setup(char *str)
+static void __init printk_delay_calculate(void)
 {
 	unsigned long lpj;
-	int boot_delay_val;
 
 	lpj = preset_lpj ? preset_lpj : 1000000;	/* some guess */
 	loops_per_msec = (unsigned long long)lpj / 1000 * HZ;
 
-	get_option(&str, &boot_delay_val);
-	if (boot_delay_val < 0 || boot_delay_val > 10 * 1000)
-		return 0;
-
-	boot_delay = (unsigned int)boot_delay_val;
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
@@ -1342,11 +1327,37 @@ static void boot_delay_msec(int level)
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
+	int printk_delay_val = 0;
+
+	get_option(&str, &printk_delay_val);
+	if (printk_delay_val < 0 || printk_delay_val > 10 * 1000)
+		return 0;
+
+	printk_delay_msec = (unsigned int)printk_delay_val;
+	printk_delay_calculate();
+
+	return 0;
+}
+early_param("printk_delay", printk_delay_setup);
+
+static int __init boot_delay_setup(char *str)
+{
+	pr_warn("boot_delay will soon be deprecated, please use printk_delay instead\n");
+	return printk_delay_setup(str);
+}
+early_param("boot_delay", boot_delay_setup);
+
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
@@ -2122,18 +2133,28 @@ static u8 *__printk_recursion_counter(void)
 
 unsigned int printk_delay_msec __read_mostly;
 
+static inline void late_boot_delay_msec(void)
+{
+	unsigned int m = printk_delay_msec;
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
-		unsigned int m = printk_delay_msec;
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

