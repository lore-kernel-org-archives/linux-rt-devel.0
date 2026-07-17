Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44730390990
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279439; cv=none; b=lbITZ82EKqEhQJjKiI+RDwS96uxUyITa2rBq+BJLsZo3KYrc2uQ7PwD5xqIWHa0Pe9vXFqeK9T0mcmjHvudYXyTY89JCdT9ehtkvOKcurWZudsCrhDYUt7RRUX/EE+yHET4//rnttRmY4eOdJMIaFWhJOPqy80kcA3ICkIxEa6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279439; c=relaxed/simple;
	bh=xqT1ch9QXSr2Sh4KWiRd5vGUh3tKkxctBsod5h5U4Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzTP42N0ZXgjCKwKsnQIIi34fWGUP5vv17OLHQuDkIgZb/g+YwxensoLym2BOsr2jowPxw9GGfyxkLhTke/HuOwxl+e8AgzcflhziU1miX3cVcQVDxlom4ajSavAjlUZmAKEQjKct5k8hzfLYlG6Ls0Uvy4pAq6eddv8Fh2gXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ET9JUlrt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ET9JUlrt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso4647820f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784279435; x=1784884235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GvqX1BcEi2ll08wPBPPLJIyQRF13ih/MJcl5l+I3Gbk=;
        b=ET9JUlrt6vgJKvltSgQRYgMbKNq8b9VACRlmlMggVrftzBcfud1vS0H0mOFq9Dftip
         lgAmTP/C+AeRaJXroPWZ6k45hUETnq4ecy42xV3oW1FijuJ61uxNtGSly/Q+0V6HEQ3H
         5c+iQDh9UzW1evbmUICODLHtRd2rsGeyi5BJK7YAV12aSl/qLzb+dCcQRjIgHc9mRQL6
         3VNUm7heW9XWMVM3XlHYYzxphQU4fjKcW1CBt4PfadmMrFuEpBiuGZRCQaDFRhBEOm/O
         0ZuHb6Prah1hvPtZyshviUz3SOmB3TbhCtvAA3q4sryvexHAwwxv9g3M9xdBK9Kj+h4j
         VaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279435; x=1784884235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvqX1BcEi2ll08wPBPPLJIyQRF13ih/MJcl5l+I3Gbk=;
        b=VZ89f8Gg3u0nRkqbIc9ESJ8r5qcejZ0KbGO2uGTPmmkDthUmWMzmBVSKk/GC77ZwYv
         Cezq6C9vBla+YjTuUNGGDjQS4Mb5sHaFF/ngDTug5m/EtzZGBQT9Rz/94+IcBiq0/ij9
         5ERn677N8HGadb4MMQlI/AEoTz2ozJKfPFRklB1tWDmB0QrbPYnH3d4ODs0jzT4v10fv
         mWtoXuplbXSC+aiJeIozUaVJPMKNEpc8YD1fgeOAXUNPU/ZNnbbVfEQ+D4DutVDwU6yx
         VGM+bt5iIS3y9csWEjdsebv0L2XrCMORHpY5mBViIWBFWcvBoSAU/dbUmkUXrKlfSvIl
         AuQQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/PEUABLq56/iyo24CPMAjR7ztio3Hr2ooVoqYlnEjpXMPrlAAVJg8FEzay73wf6he+q48ib3L/LDBGNpmPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRADvHdkmbDCeSyuYvF16YvmI/NZBxFXEWO867dmHpfF2AKLhh
	Ikgu5YiCA2X79/6WOLhVYEElYLIlt1leL+OhirrndVZMjv5LkhoH6ZAVogO88HCO5tw=
X-Gm-Gg: AfdE7cnssvrbqVMFpD9mWm0U5ZkYJLjYNDRSU9xsmY+8nyHhI1V9iBDfHI0K3h+wFFP
	zAEUvj2MUQF/DMKkYoLxU1JVHmJUbbxKEf2hsanEGAR0ZmytH5tP5zhAuldO3/jQj6gjnA4R/T+
	RPTafmahJfYawa39wT3pAJiUVx0GQ+uRrGhav/PTgOaqvXkFrGkJ/zNL+UzebWILywNgfKzDEoJ
	KIch6mV6GXfKFiE/mnCPw3A/uoFj4MMqqlcEIg2gpXwd3XUaA8mkmK5KjaWBQUvEssziP35+yB6
	JwRIRZlmx+Ug8p1PDunWDBNopg/krqxQqAMmoNjlr90QOWf7U89s/vAH1Aoek9d0GSHZ1A0KDlo
	4JRWhgFvioxdfYfhu51CDMb0vtXXV6dXHKbG42hqu6hoXu6PYrNoJ/rnhcKsTFUVckI0xIdK46K
	tsIUAi
X-Received: by 2002:a05:6000:41c2:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-47f62316912mr2385289f8f.25.1784279435367;
        Fri, 17 Jul 2026 02:10:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e519f4sm2116892f8f.14.2026.07.17.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:10:34 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:10:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/6] Documentation/kernel-parameters: add/update
 printk_delay/boot_delay
Message-ID: <alnxiCmOWrdV5YjW@pathway.suse.cz>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-6-574547b8f71b@thegoodpenguin.co.uk>
 <20260714175131.1edfc880@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714175131.1edfc880@gandalf.local.home>

On Tue 2026-07-14 17:51:31, Steven Rostedt wrote:
> On Sun, 12 Jul 2026 11:20:37 +0100
> Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 2884103b93bca7b76cd3a93946276074cf62d0a1..1118feda87b1b04543b1da0bd52c090b1fddaeac 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -650,11 +650,19 @@ Kernel parameters
> >  			See Documentation/block/cmdline-partition.rst
> >  
> >  	boot_delay=	[KNL,EARLY]
> > -			Milliseconds to delay each printk during boot.
> > -			Only works if GENERIC_CALIBRATE_DELAY is enabled,
> > -			and you may also have to specify "lpj=".  Boot_delay
> > -			values larger than 10 seconds (10000) are assumed
> > -			erroneous and ignored.
> > +			Milliseconds to delay each printk during and post boot.
> > +			Boot time delays only work if GENERIC_CALIBRATE_DELAY
> > +			is enabled.
> > +
> > +			Once booted the delay can be removed or adjusted via
> > +			the printk_delay sysctl.
> > +
> > +			Please note that you may also have to specify "lpj=".
> > +			Boot_delay values larger than 10 seconds (10000) are
> > +			assumed erroneous and ignored.
> > +
> > +			This will soon be deprecated, please use printk_delay
> > +			instead.
> >  			Format: integer
> >  
> >  	bootconfig	[KNL,EARLY]
> > @@ -5468,6 +5476,19 @@ Kernel parameters
> >  	printk.time=	Show timing data prefixed to each printk message line
> >  			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
> >  
> > +	printk_delay=	[KNL,EARLY]
> > +			Milliseconds to delay each printk during and post boot.
> > +			Boot time delays only work if GENERIC_CALIBRATE_DELAY
> > +			is enabled.
> > +
> > +			Once booted the delay can be removed or adjusted via
> > +			the printk_delay sysctl.
> > +
> > +			Please note that you may also have to specify "lpj=".
> > +			printk_delay values larger than 10 seconds (10000) are
> > +			assumed erroneous and ignored.
> > +			Format: integer
> > +
> 
> The two parameters descriptions are identical. They should show something
> different. Is it just that the "boot_delay" name is getting deprecated?

Good point. We could remove all the details from the boot_delay
comment. Instead, we could say that it an obsolete alias to
printk_delay, will soon be drecated, ...

Best Regards,
Petr
