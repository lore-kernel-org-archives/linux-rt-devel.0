Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12793BED19
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837376; cv=none; b=ixPRZ2emAHZcHdGkMiuXwZONEQgwaJk8qpprveQ6MJFM/ZEG90uZCOAEOYg4bu0w+nPuFA5d1q8vRyfRekbthtb8W8/33HjsDUSDobfB5OUaesc7kvu6gmxiCHZp7Pe0wON/wfLENDDICpq3TyC88fIFGm4WF8eCuXTnQFnlrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837376; c=relaxed/simple;
	bh=utDuo2WNw3hePhQreU1zjsPiOgUN3XHnEKmrepDTN04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raJYAKJDayp6qYfHQfUFfgCjkyAe07xQytoU0alXkXXMvCmJX/ZPHbXM9fXEWoUTR5EEgNXjRTZQXHMfxW5OjkICbWlhsCCvcRE6UBBrljGzx7qG/S3hs5TYl6O1YPmnaoRj2TERiqYPBJdPHKs21UK19zwMzAel+8mV9ea9+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=pF2IA1v/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="pF2IA1v/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493a97fad2fso25120645e9.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1782837372; x=1783442172; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7KLFAdTdSyp3t1Mmt+Mvc6gEqh9A7/9JU0e4I8/G4k=;
        b=pF2IA1v//XIDW0d3yWfn3vae/D/n1d1Ml/SDIJfyTlbPMSmoiVvHNUBz9wZ8ROu88Z
         DLEhNCVHYOE77joNkRD5f7RGJIp8eb2s/yptafkZIG2WmxxZzutxfNlrYQ6F+6TgXsgc
         FxuUflPAHdR0lRWjNbhhzjQCiHllFW+7SgBd66iI9x/us/m4CJUTEAsp5AOqvgPMp9+E
         ANgG0FQ5PcOPdwKJizKhp5w8eqPcUrcSR5c7vqCx5F6eF4fmWkHA8TVahnbbBHaPjmDb
         TU3/o3MO1Ko7rjCvqR2/C3eCQITr4r1uc384ttRbIs6+EYQRaUYY9U1+iKybC6nAtl8p
         X7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837372; x=1783442172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A7KLFAdTdSyp3t1Mmt+Mvc6gEqh9A7/9JU0e4I8/G4k=;
        b=qCMwIdF8Dk5GC9s6GukD+lYGcaS/wR5cbWk6wB611OROf/xv4NUMufhDSEni9TSX8h
         F46btvWa9Gr6pN+RUSQLE0YzeViWbWlKa4E0jfEWvJjPVEMS15o8V6pnAtXrdH4WGFjx
         t2GEncyu+CYpJhDlgjd+vT6CGs+HkVYaOUJh8NeAhSQdPLkxcBmPg5HDZ4Xvo62IDAXX
         mwki+Bb8CDAY6Pe5QSdf3PwaNt+ewt9b/9sFTijLdpuhKNHp/g1o61/hAmxAWxHARU+B
         WByDypW+jj+aTG2/yuMb0G5k6Lc6iEpqWiG2PgGngsQkH62hxKjV9e+1Lt6oXC++o6X3
         PIZA==
X-Forwarded-Encrypted: i=1; AFNElJ8tMZUGx6oN20oPXDnAIS4xVJZcxzxCmw09qVahRiX0P/i0cdZRyPtZXd4MjAH3VoPXrXWWBV4ogP0/ZpCqcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJdJE0x87zPIlx77L6yOt1wCmGZnE6J94gWEH1AhpM9kMIFjP1
	bhaUOKJo2FJd94pUptQxHrR61Mr5mtbB0mOhNHbAQH90EObyKpswLp1jR5g+Ma1JSC4=
X-Gm-Gg: AfdE7clkgqYQF8nvLc8FDlS7udyNWpNejuuXCtI0H0B6ppGZPDltqIUYd6SAmEf+Gq/
	0u4e+x2YoWQm3W+153mgKcuwFQf11Ix0z2aiFzHSksjuwkbfFuEsn/ye4kZkxoA7Gq+VRNmfxM+
	2F+udDnX0BIqeVHYd4dR8d7HZcRDo57gFjN6QO6D7y3TFauTpCucIPLmnfeg2qwD/+RlG3T7kyC
	BCRUmnjVyXFb09j+sBPmqVhDrdeK6Oq/Cl73fkYVrO6gDxfbqcWKCGQ+FcpnrWihLxbN/VDtreX
	dzuj4ibkdzHAA2pW3sXFaxBNpUZWVF3aDdLaG7DLgTwIMI1xZODpDQKDoXP8cSepcGRKgZKPbes
	OHtBmeJ5G9fTBSo4BTc2c5L628egkZNoOjz8GD95jWUNizM58pjhXtojcyS6NuhHgwjeYldwxLm
	VSTuFyGufkRHYr76m3tpYAPOo5tvnSMD3vaaQNtvQ1VsxpKoeqMmir9HhJojiv5prH3/7jIwPG3
	j2TQwnXWAwPrAP5wyI5nM/k4IxA
X-Received: by 2002:a05:600c:3b0a:b0:493:bc92:ba9a with SMTP id 5b1f17b1804b1-493bc92bb20mr34808675e9.13.1782837371886;
        Tue, 30 Jun 2026 09:36:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be486f52sm8452225e9.0.2026.06.30.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:36:11 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 30 Jun 2026 17:36:00 +0100
Subject: [PATCH v2 4/4] Documentation/kernel-parameters: add/update
 printk_delay/boot_delay
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-deprecate_boot_delay-v2-4-f9883d36aa4b@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782837365; l=2383;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=utDuo2WNw3hePhQreU1zjsPiOgUN3XHnEKmrepDTN04=;
 b=sOnrvPsO84DB97ORuTR1juL7r2Scn8EpMF3I6l/RvF7EoCDpqEEMlFajIZ/HKJT/YwxAr/2XU
 BP0Ae4MruK0CtpsU9u95RIYdHBzLEQVUODBhCas0gDrC1e6LVEiZTQM
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

