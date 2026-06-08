Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221F2F39B4
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924937; cv=none; b=Mnqbr4JCFBzryeDFlVFV579kcy/bQ/N1AAbF7YRLTfzPhGJdBHOlxdEUjW2ssx/eXTC3cdOYeG57lvEnJ0Vp+wB/sX4eY7rm+a0Ie2cFBe9k1eAX6vONoG4Z+hBpJFdai4crD5P0vpVcdyRxDNAjiFQV5G5E45UsjLgT51NNOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924937; c=relaxed/simple;
	bh=ZIApfaH7NuRnxk6bMvuZQfq4q8wrE8tUVpPJT96zo/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNxa2xaHUIUbMg8o/xrnWou5tsNokvZHX/EWDc6UjQZAvIPcsCw4407ymnHAY9heMSdfbx+dlC0o0try/KXQF6O/FE2l/+OSrpyq6P1KeNprVnUsMa/hu/46WujAJ/wmAmwQwYaLMKNKMzj+QCRmS2YnwR3HP38uMB/UO+kV6GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q409sS7C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q409sS7C"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so28181025e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Jun 2026 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780924935; x=1781529735; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUEnvDqz1SSyEKVvs1pgOac32s1g7LZkjL1zUnxDxK8=;
        b=Q409sS7Cs7ytQVM3eXM8V9zy4zARXRYHY+sMWlYPG25LcOq2mSYJ3xWCOrYghwHb+v
         w4XIhOP5KRkVtAKrR7ejXGP3yoxCF5jUYLNzV/ctgDm8ImAm0JJwiRf+LAtcaX4/G/8B
         9TgcAaRH0aaMsutiRI8N4f+b5t7www6xrjrMGz0+EWT5ocwQGweWcKatx+IZgGBP3Oqy
         AIfGS4hbGHhSFnR0mtZZQC+cevVpkdPMGtPWFiMLPfQhRREgNpIBcv15qhceKlSBsIqr
         Ysd0uuLggg5bR3SfUiwEQebfopPQ41bRTn1/f29Jcmpwc16vVt9YzRRLnFWQ3D4dynsn
         XwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924935; x=1781529735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUEnvDqz1SSyEKVvs1pgOac32s1g7LZkjL1zUnxDxK8=;
        b=B6l0L58ZRjje/j0D0v7GF3Gyfq1Yb+vovYdN5bVcilYxjGCdhes3zEeyScJErlIbSv
         +doRJUrjLC5VNqKwe9ymCIRIDAUO7eXV/HwKs94vTK0YenDrnmvHoZGaw4hoKWbxcaK8
         cavOkceADoEDx+xYXb3UwL1K6lRKdOW9CQowL9SZFKXD5hVzj7ueyYwnOBYMIkXolUbF
         YaokH81JbLVyVHBiaLV1xaYfUgYz1vef4hlmIztJ4Dro5DeehqqTd9yhBKVmAjqs96DT
         mfJTOjS330Bws0hmnNbCMbl8YHxfokJngGCkLW+rAgCu6S8Uw3OSLQHnJQoXZYnHEElH
         3Xhg==
X-Forwarded-Encrypted: i=1; AFNElJ+0lpPnCLtxH5/YQIXcWBtwm0W/V0CbEGAQgIho2ezmRvcDhoxCT/gcmTb+9m+L2PJgeITLzCS5d2Xn3lUrPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPHFOTwDXmXcCGpiT76AGzBeGFAhoohugPw0g27mUzvK/aXsRq
	bFz6H1S/hchaBYMf1ycP7UIxbw/gB2gEqNgUhpcTlaft5U2U/g0kkR8TLtZW00OzJTU=
X-Gm-Gg: Acq92OGXmU0d/lchme/dCIQ6UeOKN9iw4UfP+Jq5sZ8QSIW2YxlQVlncxPDwLpli5t6
	wy6VkQ7yCCypLGRCYKP4l+Fgtbshg0GhdK//yM7omO64FT0BR41HCtEs4cb5tHgm62Ha0YAv8EB
	knNfVNXDXriyFZbkUJMy07DDvaStfA9ednnTDzYUzzGKbHYJhK3ttMBF5WOutrm5e62rj77qD0s
	LJxQ7Mjw8qURYai2utBFRMTU6TN2hFzL/P19lgWx5IUxuRzcuElh7bU31q8i9DT5FbeZArrw2HG
	MFVgJ5b3DQpa0FGk+q0klssL+ZcLXfxu4meDKD7FzketdMgb7lnae5yOPmODYtSbCPTlKKr/4Pg
	a2+acIydWokhDdWS1ToQ9Ff3eNw7xemlJFcsmhAYpTuHbGuXknkxHnbqTPZUj5krBLuJU5TvM7h
	6Yzv4koX4uPiDuqFdmnUV9rOhYgAtgI73Zyktr
X-Received: by 2002:a05:600c:3f0e:b0:490:bb45:79ef with SMTP id 5b1f17b1804b1-490c2508a5emr287463765e9.0.1780924934875;
        Mon, 08 Jun 2026 06:22:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm428671945e9.8.2026.06.08.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:22:14 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:22:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 1/4] printk: remove BOOT_PRINTK_DELAY config option
Message-ID: <aibCBGjVk4yqtYyT@pathway.suse.cz>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-1-c34c187142a6@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-deprecate_boot_delay-v1-1-c34c187142a6@thegoodpenguin.co.uk>

On Mon 2026-06-01 00:17:37, Andrew Murray wrote:
> The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> are two distinct mechanisms for providing similar functionality which add a
> delay prior to each printed printk message.
> 
> In preparation of combining them into a single configurable feature, let's
> first remove the kconfig option BOOT_PRINTK_DELAY.
> 
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

The option allowed to reduce a bit the vmlinux size when people were
not interested into the functionality. I am not sure if it is worth
it though. I am personally fine with this change.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
