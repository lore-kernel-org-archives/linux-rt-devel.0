Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C63A4267
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783851654; cv=none; b=eyQgsQlT3Qcfu5xK8JuZ4xpoJiPf2FbShUuqjJognAHF7qgSTdnhAfj8xj/6TBpf2uowFwnEP9VaijYMxYv1EG6Q241RenPcKbowDoMF+RKfu97De7E/QDvcLz9RYQalP9CgvysExTbzxZnaVHZ1TdS9b1qVQi60W0W4NIsmMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783851654; c=relaxed/simple;
	bh=P9s4hcVnWj9tTnGZZIC8g3yyXZe0SBB5hWMsufMT864=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fo2kDEVPPavYSGyhCpOzIII3Z5lGD3yQWw3tl15ZoBJG4CCom63EBb/z9skqvEy2+Ciay69iHEwmcxBIlR61MOtlmNx0GJBmqCVwoZ0gU5tSoxiSif5zAlKhHk+cAabVlwMvWNXKFsKb88HHutCzfYb+/KdA2UtxohtMnBR/lPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=fBKOVeMx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="fBKOVeMx"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so2756193f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783851651; x=1784456451; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEbITgTEpDZxe5ZFo5f4LGGlEUTcfS1MEeyafnuEbDQ=;
        b=fBKOVeMx63R7eCdJyQ4xXKoJpJp3bsOTphbesYLFSiWa1NVJufedJUjawXg5Sk36uN
         gGaEk/M5M+omTX76+RXlB4R3q/XOSLh4G50mCe7RT1hZmvPPH/LTnIRl/DUlbWAmupXj
         tZkvSLjvxvS4Deazr2uJhmaCTuwamJPSA1TiJ+z1V5ZtZxLxpdufIZAuYy/4sEOg9k/G
         1MnEDuKQdsYLGygSjSvk7uiq2AeTCqNlT8/ubHc4PLkOtafRCxC85YVO2UgjDNsaqiPE
         9r8RYjf9Qw6dm5blvGFeKs2wkUfeA6wXjw6a+/MRGJETdUg2yF81FVXRjzICBVywEDYo
         MDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783851651; x=1784456451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEbITgTEpDZxe5ZFo5f4LGGlEUTcfS1MEeyafnuEbDQ=;
        b=D6cOICDStFMHA4xEGZ2j3Df3Io9W1RTofV2wTcFxQYVKn7IsY93fkGp/LJ0XKsovu2
         FmYyOvYEkzfR5WTUDKOtG8xUGPp/lPsAqyCm+Nn8nVVBh2O9PitrLrFsmHgTzKnvv9wi
         wKIT1hbS+9qWkKworvZt2NXAJkvgO1/n5Minjk2w2Vz7Xti4tt8o99/P2vjw/ltro160
         mk+6eB7csRno6e3JQnRDPwMMRqFi9482O/Y4uNL9cmy2rRORrBVahqH+hhLwXEN1gnHt
         VRUj3TdrqhJe8/XgWylXumiHz5ZFmT8ojMrcXNzxj1P353rcuITyFQTTRYSJ5Or1EVss
         ne1g==
X-Forwarded-Encrypted: i=1; AHgh+RoKzzAbebUvoNS/AjkvquVCpAq+z3swv9rlv/x8GhssAUkTMEAT4qKaXcrdvnOeLEHkourvjU7YHZL68fK0lg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx56x05lhB4EIPw3VRQm1vvLQfvTs09wSNWGOozQuNeW+O8AC7N
	9UmmML17YEn7Te39UpGNfm7MNtLK7NSxtqGbNW9TM1suXR8MCqFemksUJR17lztBO0c=
X-Gm-Gg: AfdE7cnO9v7CTBm5ih9QjNPIx07jMgTXGVOcNY8UOupmexghZH03Q1LxQ7h6NygM7aM
	SeMTFCp3Oiss/WOwGWSfGXztnbhdGYmdRRBBVQxyh3mxZptqPrBVTF+RNiwAiIzGkbBx7UX7pSs
	1XNTQt++utVPe7RQdUWb4XfwT86+UsHocsQ3dqziXIUg0GpY2kOvcmFDJjsRwz+O5eiV+WI4xIS
	i3TDLueHI91+eyvdNDcURhGXBSGFUwK0ilFbgxmrVD/yIBBeLkvzGwT11MAa4ruuzaqnFtBVMqq
	ZDqCxO6b2yPgpG+pXNED7pPtcX5ijNhwKDR4/cGaj0zAIdppSXvqi7lXW+gD3peeqlgkmBtO+jr
	2+F1FeG4zxK1lte65jS4K+K+Mx0OKkyLyKgkPviuqtswPF8p9Er12HnUceuNY+wb4pR/lGGQb8F
	ZldPNytsmItBR2iWijKq7ttHpTAPcxZSulO73ctGWVu6pOQphAvmy3ZkYGEn7PRUJ+E+n9uaXFz
	DgvxrJclU64DhzzAiz8BcdYF+2r
X-Received: by 2002:a05:6000:381:b0:47e:4b05:2c8c with SMTP id ffacd0b85a97d-47f2dcdf16bmr5941928f8f.15.1783851651388;
        Sun, 12 Jul 2026 03:20:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm75005672f8f.20.2026.07.12.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:20:50 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 12 Jul 2026 11:20:33 +0100
Subject: [PATCH v3 2/6] printk: add bounds checking to boot_delay
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-printkcleanup-v3-2-574547b8f71b@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783851646; l=1714;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=P9s4hcVnWj9tTnGZZIC8g3yyXZe0SBB5hWMsufMT864=;
 b=C56SsQSM0G9++0Mvl1+EFh/6zQ8sQqd4MLbaB/EJJ10czH+MgpAwpdrT0cTcbOODbk+gvOJLF
 SMn+wTwDPCqArrjFNrKnXgbvdRhIhXUkCVLxl10G3JpSuARaONX7gZ2
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

As the boot_delay kernel parameter represents a duration in
milliseconds, let's set its type to be unsigned int and add
bounds checking.

Please note that the existing pr_debug will only be displayed
when boot_delay is non-zero:

 pr_debug("printk_delay: %u, preset_lpj: %ld, lpj: %lu, "
          "HZ: %d, loops_per_msec: %llu\n",
          printk_delay_msec, preset_lpj, lpj, HZ, loops_per_msec);

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
 kernel/printk/printk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 31aabdf8248cc39c54ee11685d4a37deac1c174c..8be562c9be277670ba3209ed1f810fc87175848a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1291,19 +1291,22 @@ static bool suppress_message_printing(int level)
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
 
-static int boot_delay; /* msecs delay after each printk during bootup */
+static unsigned int boot_delay; /* msecs delay after each printk during bootup */
 static unsigned long long loops_per_msec;	/* based on boot_delay */
 
 static int __init boot_delay_setup(char *str)
 {
 	unsigned long lpj;
+	int boot_delay_val;
 
 	lpj = preset_lpj ? preset_lpj : 1000000;	/* some guess */
 	loops_per_msec = (unsigned long long)lpj / 1000 * HZ;
 
-	get_option(&str, &boot_delay);
-	if (boot_delay > 10 * 1000)
-		boot_delay = 0;
+	get_option(&str, &boot_delay_val);
+	if (boot_delay_val < 0 || boot_delay_val > 10 * 1000)
+		return 0;
+
+	boot_delay = (unsigned int)boot_delay_val;
 
 	pr_debug("boot_delay: %u, preset_lpj: %ld, lpj: %lu, "
 		"HZ: %d, loops_per_msec: %llu\n",

-- 
2.34.1

