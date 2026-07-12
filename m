Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96739D6FA
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851660; cv=none; b=L4rnJ6kHzw57TQAmd5A4cEe7ADhQLhxQx/La+qCu3Swe4s9Thq7JlWAE1Fefv07OBk360mQGadUYabPma3dDqgnQREzWvNK9PK3C8bJeMsVxvGDJWW8h9cst0o01uw6hvPQCHQS39GnHw4GpBN34RageuHVAJmxkh1cPLMpWciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851660; c=relaxed/simple;
	bh=utDuo2WNw3hePhQreU1zjsPiOgUN3XHnEKmrepDTN04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isBnoUTJM4C6Mb/8+otDDTmUWlrab9JBMUWJlOlqmGsxr/bymNUbzyUqAqWqsbzfVlxAjClJDiBmdXpcVUh1d8aol8muHgHkshl4q/ijvuIBfVbgV+lcJPYNEv72SIVrla1ioyzxQosvN0319/GjP4BjB2IS7Kmi9l8PgFUtETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=wS3y4O1f; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="wS3y4O1f"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so1454906f8f.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783851658; x=1784456458; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7KLFAdTdSyp3t1Mmt+Mvc6gEqh9A7/9JU0e4I8/G4k=;
        b=wS3y4O1fO5oyH4sp5cwezMZdfvjNK+5E9LICbtRS4tYdWTaCNFS4UyUpQxlBx/sI4r
         +Er9jfouOwHOuTpHQI6NIEdmQ4+hilSP3JwbLLQytojdKUCAnOzlaHjDrAaZZKa0pimk
         N1oFhMpA3GN8DtuZxzt5Q3IjK/Qt1YlscUtP6rUuXeuWOnPGbUyUKlHEVcFtyF//kQmn
         PLbtSpSr5BLQiL4X3ChMkF650JqBEWkRz2c+CK4M2UY2KVfD0FEQ3gNcWKTD9rbmYPIj
         CsAtsNfFN5Zd+hlBV8REy2wcb6Zu8dBvMhJb0qNv3PQwb2Ep5MY3FZ+2+biXqc1VEJaE
         Nn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783851658; x=1784456458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7KLFAdTdSyp3t1Mmt+Mvc6gEqh9A7/9JU0e4I8/G4k=;
        b=Hya6O9qVsVZVCy639GSMNN3XdYfZezIFNsfMjasmvcbPOAML5y1UMGJgiJwokly880
         XwZ+kNtv3VV3zpQr7PXl2nS6WwRIv0+h8XWPKw22+EvOvqRNWXaJiuEo+tA9XpnEwZk6
         Do/UVmsVBW7Lwkigwq5c0ObE7atg0hsdF5Z8ZXquF4tvEaD0BcKcY37BKGVVfEGi/l5+
         z8DiOdtyyVWnjW9Iw+Yi34/ObkWmlHHc6kpFEhf4vSN9moVDfyIb7wxd9QoIRgPdKy4S
         Uw+0w54XO/86ekzZW+8UUVYDdozoa2lJa5spWFlg1L7RF1hV/VBqvnLKO5eE7N7pu93X
         axlQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTxwiE6eor2NsaK8JQMlx+RqLmD0CnWbCGQrsNIFXp0ohWGIWH/r2G8IhW0iPF/jUJ9Kf6Wm9arXYqSuBfGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0VjagUI4YfBuiz/4WCUpjNS+JV5MXbPCB/7DTaGmyRYzhofkp
	OBLO9qWt8uDYXyD1bwPMFljTOjfM2Q+s9a5vC0DxXXcZlRRtajdpgJiuotdJDSfsaTs=
X-Gm-Gg: AfdE7clKEdjFEcVe+iGi7P2FqspgyH2I8pK/A3M8Hmzl2R6Fx1qR0F4Zsq8ndL35s1K
	m4fMaDU4hkKT0+8WB8NJNrbwVpjBD1gJVrbKNAJEM5O288FvCjQt7vqq0nKVmN/G/UsbfukbW46
	VoY2pwWVJaOZErUBJJCn2csMJVf1zVQTHGY8MdNuGr8ZpIu6Zut0tcDsvgs+Ck2R5eSIyNAInPU
	elagoJtUSmm5k48IeUnVWSgoLh7hxeEl8ck/5ZaIgcBCbZKJVNtfEXzG5rBypLg4w9qmkT9DUL2
	pZp6CVIeYx0tfprvIbuDuFdtFSKJ7UuELyrbSoBttli6T/HuXKCUvV//a1xjmPGV71ygnbn0Gb9
	jOCmK/haUqN/JjVzzkD16N896cHIsJMnOxS+eiMpXUZp7039z2du+pGY9E49Dk3Q+Xs2lsWCMoh
	WfSErxjkr/9iGDG7ByyQjD1iAlvzL4X9QbJF3+ChF3ZDvfsvgOtByayuUmsoXZ3X3mhL+Tvn92n
	IrHPI7y60TkjahuJjv8NI7PVu6ivT+PPWTpR3w=
X-Received: by 2002:a05:6000:2011:b0:470:2fb1:3dca with SMTP id ffacd0b85a97d-47f2dcd7487mr5749573f8f.30.1783851657812;
        Sun, 12 Jul 2026 03:20:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm75005672f8f.20.2026.07.12.03.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:20:57 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 12 Jul 2026 11:20:37 +0100
Subject: [PATCH v3 6/6] Documentation/kernel-parameters: add/update
 printk_delay/boot_delay
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-printkcleanup-v3-6-574547b8f71b@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783851647; l=2383;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=utDuo2WNw3hePhQreU1zjsPiOgUN3XHnEKmrepDTN04=;
 b=d2X0BHuJ1CQWytJ0SAMIIKCGulICkuSxHkoRz5VTU3oDIwlYsespo8YnKmxdQHRuNbprslaM8
 uR4zOBiuOBHAxYnf8z9WGG4RYEgwLfDBxKehgKZ57nyiym/LudtIjxS
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

boot_delay has been deprecated in favour of an extended printk_delay,
let's update kernel-parameters to reflect the addition of printk_delay
and the deprecation of boot_delay.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 Documentation/admin-guide/kernel-parameters.txt | 31 +++++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2884103b93bca7b76cd3a93946276074cf62d0a1..1118feda87b1b04543b1da0bd52c090b1fddaeac 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -650,11 +650,19 @@ Kernel parameters
 			See Documentation/block/cmdline-partition.rst
 
 	boot_delay=	[KNL,EARLY]
-			Milliseconds to delay each printk during boot.
-			Only works if GENERIC_CALIBRATE_DELAY is enabled,
-			and you may also have to specify "lpj=".  Boot_delay
-			values larger than 10 seconds (10000) are assumed
-			erroneous and ignored.
+			Milliseconds to delay each printk during and post boot.
+			Boot time delays only work if GENERIC_CALIBRATE_DELAY
+			is enabled.
+
+			Once booted the delay can be removed or adjusted via
+			the printk_delay sysctl.
+
+			Please note that you may also have to specify "lpj=".
+			Boot_delay values larger than 10 seconds (10000) are
+			assumed erroneous and ignored.
+
+			This will soon be deprecated, please use printk_delay
+			instead.
 			Format: integer
 
 	bootconfig	[KNL,EARLY]
@@ -5468,6 +5476,19 @@ Kernel parameters
 	printk.time=	Show timing data prefixed to each printk message line
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 
+	printk_delay=	[KNL,EARLY]
+			Milliseconds to delay each printk during and post boot.
+			Boot time delays only work if GENERIC_CALIBRATE_DELAY
+			is enabled.
+
+			Once booted the delay can be removed or adjusted via
+			the printk_delay sysctl.
+
+			Please note that you may also have to specify "lpj=".
+			printk_delay values larger than 10 seconds (10000) are
+			assumed erroneous and ignored.
+			Format: integer
+
 	proc_mem.force_override= [KNL]
 			Format: {always | ptrace | never}
 			Traditionally /proc/pid/mem allows memory permissions to be

-- 
2.34.1

