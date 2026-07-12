Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858838E106
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851652; cv=none; b=ayN1kDM/Z7n3CsylGFkXjnawXVXEs4MnEb+SHFzqiaPjBLYQBk88Tb9t6eoTY49LNUG4orEL3ecUvxXe/RxgVR+AOsJ/KsZ2HIyxU3Z8Dz/N89Sn/M1tleUhJbF74OpBbx2X5VQjwv/yQV25OT9xt7x0Wm7tVNmOeccSGMqDUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851652; c=relaxed/simple;
	bh=oSSXLP7Jw1rIzHEsyC+huk83PWweBjE2sp/igTikZ4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdE9ZhrqCiSc+yI7erF7W/eN6rYKzcnA5UOr47N2vkEcBq5FAA8cv/qImMtU5Z27WTOPmrjWAqTFNLUFTYnnBgwH6QR9nyhkYLjvFDLQ+n25MnYQc60XW+xf4nVDME+HiPwzYPXqztKZOehCPg1C5I2dqcTp57QizMFmVVmEQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=wDyr5psc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="wDyr5psc"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1559889f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783851649; x=1784456449; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QsBZuNbKBWzgjiOqQ12i1N0POi8kQELijizTKDd75sE=;
        b=wDyr5pscP967/jQREgPkr9gHq3GUG0bA8w/Ok8NVwNpIVo2zPkV4+JM+q0WVziZqAR
         lvXfHcFZCRbDqhrsUAnkQc4VRtrAPCYezry5+cg7jYswzknUgP4+FX3XSZ8npPh0XtUA
         DdFt8E58mShwMfYoOoWDgp0oj2JMLwII8MAoBmACzYAEt/ShBFYjGhN4hpqho6yIg80u
         /HjN3ybVFb9I8rtQg0R/9hVU+wJasIeLyIHOG6QUaxPzwqBIsOrWgDVMqQbp+Pp5+MYk
         WgkBZbYfT2fRs1GX6UtjZ3Yg2Md7fkPMobQOJWj8l22+e/KzrNHmPej7wOhI4ZlrojSP
         ggWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783851649; x=1784456449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsBZuNbKBWzgjiOqQ12i1N0POi8kQELijizTKDd75sE=;
        b=S67i3HXI63JNv3jeTI37f24fk1DmA8jQRlymBcuoTZ87B+N+/Dwy2aX7P56s0Lo4BR
         RWB0e1En6NGaDBAsXgETh+/FkgcjGEAl8PfCfiDxCAiVKShrDKAnKq1z1Yi8M8c+8JOS
         vts8qb1cyOlrSpFrxt3BRP1ZbljoxKtmNxl0IswCviJ1ciFpjE0X638RxKbVtZ/kJIrb
         eWE7jSqxEZ4wndxyEOWwIFYbLDU5ITCzESqLAvRU9Z7uoETOlz8CKS63lASi7Gu8KyS0
         kv2rNyEKBdJCOngInPrCz3clj/8bBy8nfcZSb5JSkZ5L422F74RFJmhW/fxlQxJDh6yc
         KsXA==
X-Forwarded-Encrypted: i=1; AHgh+Rqmq/7IfDIbVyxSujPVqpGO4gaVwXMF3tvuR6qmXl8/9YH0C3IW+Iy6DRct0sd6/KeRQ2U/3o1kAMRHxpAbCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeKIWuzbjsPzmkkpMOXhKAnCMRSnJ/xfTVXwR8gHDDF+a/xeh8
	b/jxHM2QVS4qiP/yzVnV6dnJhz77TbnoG3mv8X4cgOi2KpFkhhkzmmpGs7alCORYTf8=
X-Gm-Gg: AfdE7cnSm0klt0Esy/MjMau8P6Atsfj8OuOcpeCttNCS+TUwA8cuyr1mA0IsmWNlgjj
	cfmHB19OW8bPIG67uqd465FCtpjcR4cb8cxntat7djYWxdgScFrCTpvFM1Cd3Nwx7sYz5zJEE2W
	j5mOzDjTTG2JK2zlavuqCTXdcMlyyRj9bI+G9tAUDeAyhm5e6cOv0lf702shlzQA0+dCX5qgg/s
	R0/FCwdTdvnHM1rbrY1kVn8KjFuFDlu3GDBfDI0ru6HOi3n3oSEVwltWPSsryjOCgACn55g0HRF
	bJLN4BptWCJVShXcUYBKTCs6N720nLG0hW/nQWi+3PNPZonlJc7I/+xSF2BWgBbt61l3T7jjKrs
	ZQE2zG/qVLklopwJBDfzl63XSPdFHFPMTjae9YioRE47J6VLJkSvzMdF/6OM6iBQZK8yA6QRA2M
	reU7LhRvDx1YntKoxBAwIMwwWuFM7PAOwIuqalSKylarTLdaWo3gCypfKv3wjdzOVbtSzYGw/7h
	+Ebkz6oUG2inZrk2ic3EKtrZSC0
X-Received: by 2002:a05:6000:4713:b0:473:41c6:f1b9 with SMTP id ffacd0b85a97d-47f2dc863cdmr5646096f8f.11.1783851649453;
        Sun, 12 Jul 2026 03:20:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm75005672f8f.20.2026.07.12.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:20:48 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 12 Jul 2026 11:20:32 +0100
Subject: [PATCH v3 1/6] printk: sysctl: use unsigned int for printk_delay
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-printkcleanup-v3-1-574547b8f71b@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783851646; l=2135;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=oSSXLP7Jw1rIzHEsyC+huk83PWweBjE2sp/igTikZ4M=;
 b=x8nBiQHIvIKnAVgonaWo+uUY7v5twNS6bzsYUhVo0lss1zOJ5+lit0Q0af5u1hiyoIPREE9jR
 atWY6ieG3qeCEcg54Bgrfwiek8JNG5zWx6/EqttQlWhO1E78dykv/4H
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

As the printk_delay sysctl represents a duration in milliseconds,
let's set its type to be unsigned int.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 include/linux/printk.h | 2 +-
 kernel/printk/printk.c | 4 ++--
 kernel/printk/sysctl.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd411f2238b45374e8a71222f0407c..ea52dc72b73b64898f82a0319b01c27323b18dee 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -188,7 +188,7 @@ extern int __printk_ratelimit(const char *func);
 extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
 				   unsigned int interval_msec);
 
-extern int printk_delay_msec;
+extern unsigned int printk_delay_msec;
 extern int dmesg_restrict;
 
 extern void wake_up_klogd(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2fe9a963c823a41e7df10c29939a2abb55462859..31aabdf8248cc39c54ee11685d4a37deac1c174c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2117,14 +2117,14 @@ static u8 *__printk_recursion_counter(void)
 		local_irq_restore(flags);		\
 	} while (0)
 
-int printk_delay_msec __read_mostly;
+unsigned int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(int level)
 {
 	boot_delay_msec(level);
 
 	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
+		unsigned int m = printk_delay_msec;
 
 		while (m--) {
 			mdelay(1);
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f15732e93c2e9c0865c42e4af9cb6458d4402c0a..56c3db63b3f8c6c5fddc4e4de1f41c6102f0f4b1 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -44,9 +44,9 @@ static const struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk_delay",
 		.data		= &printk_delay_msec,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_douintvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&ten_thousand,
 	},

-- 
2.34.1

