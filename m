Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01D3C3458
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927669; cv=none; b=rsAzQY6Mpc4udMSbu8Pt+0jsxk5lVOFPjUiF2i9v537WP43H/uB0zM4oYDK60at17Ehd/0UAmmDkrwQnY7rKMnDzioNKSi4O/hb7pcTspmZXcrPfQqNSYOiPpgm/MDJYybgT/9NICLeu35D9kA+PMpTeLJUSPvvoxFyt1ys0TnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927669; c=relaxed/simple;
	bh=lqMFDHllkO2XGzqQx/s0qGBo/R3HqgN5eR0I71keFzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR2D3wYJ9OXy/EUBiowfPHFAEum1uwkwICudv2xNrmpbAhGwZfdiFY6tk9MaMeBncBACQrh5NfHL6/DKEu+t2quS8avgMK1ogMd2e+TFQJwMDwfbLW9R1aJBDprN2lxH0l7x1hGuI2YyB3OZbGbPNRdCtZZKEYTd2kRi71AIdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3oZ+nXZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3oZ+nXZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so47708085e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 08 Jun 2026 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780927666; x=1781532466; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7NWfcHA0wjAt4NBRQYEf+KO3ie3ZCCu2Li2S83po9c=;
        b=X3oZ+nXZIxmSK2p52wKJ/9smguyPtBl3YHeZdHK4nPIAv/R38tPEeeOPPtZ8z1wJal
         +6ZuQgaAMnFMXepmZ7Scw8z6BiuxyQp+2R/x49tgbdwwXsEX4FqfDZNan6VqKSeOuAiY
         LFSjm4erB5MUHnzB7Z4eD5d3fvAFS9VCWZRbdum7QL3eEnpRk09sxcRFhtlNsq0KGnOp
         D+lPYrJiL7/F+uje+anqok0zg58qeu0P5cr0u7pCgOTiP0grEM8YONqtYi6+e3LsHT8g
         5qNjKwMmcZv7mrOvjNeXYqjRex11YcigceJWEkma5bGYVEuFQckZ6aHorlI3YEgg3YjR
         zDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927666; x=1781532466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7NWfcHA0wjAt4NBRQYEf+KO3ie3ZCCu2Li2S83po9c=;
        b=sA7gmzq9kARxv5EmdpwlTgxbRk6IzY9IPqGNTjukL2HVTKH0LjgLBodfC93CXhF4Xs
         MCcxd51tp+WvtnM0nvYC6rEGcEiN0O0s2SOE20XLFIbgsTNX2u3RfJi5klioB7wON7gh
         XlZnaRRD5wcbFPwmsYpgonqvFBKOLTQhXRtYkJrDhhCbcKZYHF8CvHWrGIlREaoqHZgC
         de2AQbaRS18ya08Zf6gfA6uNuVkwBhnQ+ePAuLwsQWI9o5D56oF78q63eafXqP2XPsCU
         gL/KTa2q/m34Vfrg3nkNpFbuoM6g+zrwSg7W11/Mwt9YQiviSjT7UjTKRv8CRZPF0S+U
         +xSg==
X-Forwarded-Encrypted: i=1; AFNElJ88h/Doe12yUsKsIRLkXBX588wXhopoDGzXOCCozOQx3oWHs/BOqWNMb+ITFwlXu/Pg64BJmcaBCzCfZGAM7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaygiHo8uzgxsRYXhqLz0qBGoxlJ7AwV/gcZnR+V189uBYN/PK
	3pgzls9NObblq9secGZdvPeC4/jUm9dcvV57cNL3GGAqVnszH0SBw0O4CjBdkeTxXnM=
X-Gm-Gg: Acq92OE3IKa3yMfL9NaaeUQLFgBBiUQEWVy1kifrglnq6ewDDNG3euL11mCleRYP5vr
	ywuUGP3K0Qps+bXwpCNn1mRyutXX/PIoh5QvjSkmpDz20riX8RKGWNeUcXvBZ/2jdZmnE9iRJ0Y
	/MXRDfJyvOtoE8bwZGFjkiLQoxwXBrEH4eDHWyxZ6cPlZB4ateTXu8qD0JCSlPW8I9PNR8Qawvu
	82QLbxluhpVFRDGTsVOGLwNcsrKj0D3ImQiKH3IrL6j202fqD5oFHhgY8AzkdTXTazlXSn41XHY
	wTaI483BJCAwpcDXX9lddakwsNWsjBWEjDbrLNfkSrnDGqGIX9JN/jyfoqB7d4CpjhzgHfHnBHK
	cDyF/JOOd5qrQ409mi3hC8GzH6e6QfyyVEJqo6WUCEZ8gHmsgilWSETIQLkbktakwrgm8KPUT4m
	QDDPTUeC01UFXgeZzst814/864044VdJCbJXvthSMK6AdB7Tg=
X-Received: by 2002:a05:600c:154c:b0:490:9ea0:c11f with SMTP id 5b1f17b1804b1-490c25afa50mr262456145e9.5.1780927666052;
        Mon, 08 Jun 2026 07:07:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm475559525e9.9.2026.06.08.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:07:45 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:07:43 +0200
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
Subject: Re: [PATCH RFC 2/4] printk: deprecate boot_delay in favour of
 printk_delay
Message-ID: <aibMr16r55xE26rU@pathway.suse.cz>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-2-c34c187142a6@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601-deprecate_boot_delay-v1-2-c34c187142a6@thegoodpenguin.co.uk>

On Mon 2026-06-01 00:17:38, Andrew Murray wrote:
> The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> are two distinct mechanisms for providing similar functionality which add a
> delay prior to each printed printk message.
> 
> boot_delay provides a kernel parameter for delaying printk output from
> kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
> configurable only via sysctl and thus is only used post boot.
> 
> Let's deprecate the boot_delay feature in favour of printk_delay. In order
> to preserve functionality, we'll also extend printk_delay such that it can
> additionally configured via a kernel parameter.

I would make it clear and say: "via an early kernel parameter".

Note that there are also kernel parameters which can be modified at runtime
via /sys/module/kernel/paramters/<parameter>

Also I would make it clear that this changes the behavior, for
example:

<proposal>
Behavior change:

The delay enabled by both "boot_delay" and "printk_delay" continues
working even in SYSTEM_RUNNING state. It must be explicitly stopped
by setting printk_delay=0 via sysctl.

The delay is skipped when the message is suppressed in all system
states. It used to skipped only for the boot_delay.
</proposal>

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1339,11 +1327,34 @@ static void boot_delay_msec(int level)
>  	}
>  }
>  #else
> -static inline void boot_delay_msec(int level)
> +static inline void __init printk_delay_calculate(void)
> +{
> +}
> +
> +static inline void early_boot_delay_msec(void)
>  {

It would be nice to print a warning that the early boot delay
does not work, something like:

	pr_warn_once("Early boot delay does not work without CONFIG_GENERIC_CALIBRATE_DELAY enabled.\n");

>  }
>  #endif
>  
> +static int __init printk_delay_setup(char *str)
> +{
> +	get_option(&str, &printk_delay_msec);
> +	if (printk_delay_msec > 10 * 1000)
> +		printk_delay_msec = 0;

Sashiko AI warns that this code accepts negative values.
It might cause long delays, see
https://sashiko.dev/#/patchset/20260601-deprecate_boot_delay-v1-0-c34c187142a6%40thegoodpenguin.co.uk

The problem has already been there even before. But it would be nice
to fix it.

> +
> +	printk_delay_calculate();
> +
> +	return 0;
> +}
> +early_param("printk_delay", printk_delay_setup);
> +
> +static int __init boot_delay_setup(char *str)
> +{
> +	pr_warn("boot_delay will soon be deprecated, please use printk_delay instead");
> +	return printk_delay_setup(str);
> +}
> +early_param("boot_delay", boot_delay_setup);
> +
>  static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
>  module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);

Otherwise, it looks good to me.

Best Regards,
Petr
