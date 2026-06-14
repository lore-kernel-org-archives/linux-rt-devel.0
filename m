Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F602DC789
	for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437560; cv=pass; b=oxPBaFEp7IHyZCJ5vgAC6Zj+QOHXvk/s59yF8JhLRRW7wAlWgQS0hzbQkOcSA8rB/rFx+iOXqVpm4TndQXJSNtzbCSe6u9xt4HnJ+Fp6Gc1IHjEOBlzsrvHU0WeTQLsZbuHvX1cW7G4axIdWdaWXjC524E0h9eWXwaPyiYapF1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437560; c=relaxed/simple;
	bh=R9cofiZnoOpIZjJmK6cRQ2P5rRFBhwuYTT6667zmO/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc8Fjei0cs5P3g5rEoAyOs4MfMV3x/hj/zSNy2vdEr3MLU5uwJf1rnc31J9a4SkT0WDGnA93KdZlRKKFDCzz4mB9Xn5NFCIp1OuokLfo/cAM3Ubwag2N4oBeUWooCUtstjUJJIAfpSNOKehwoWVxBBnmQ2NLDlS2olt+2+giXZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=Fy/oDMgz; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="Fy/oDMgz"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48662d16d08so941466b6e.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 04:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437558; cv=none;
        d=google.com; s=arc-20240605;
        b=BsiMzdmtE77fJdpxB0Tve85zPG9WB/TnqT3J6GPP0XLAY2k65QDb2de/QSprmGM04t
         WirbiaQGFbA7NDjMQDhfLIMu330ubw3VjNtRwDHWjWtIl4BfGvep/mIEdCy+fOeJHqrO
         VhuhADfP9bBotg0JSjL5Bpn9JpwD+M4k9HSLdE3Ws/8IHgAZAwzdN+nnJBnHHWaPWMMl
         pgEpD0OokaJ5h7ozVGwop4KbTAYW2aHrzvy3FFKVcZWBdKSexxh5qxGORec6vCaQ2KI8
         TjsG3LvsoeR3MVZMvxxfPAK+om6PFOjiVz7Gy/sjFARoZ1cHovcsfqZRgDyxaJrDfAwL
         UaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UYxOnpq9yBeiaN2mTbvYlWTQWFXGZfN7UV/tTv9hfZQ=;
        fh=4QorqODd8E88/7XyrHLyg03pv4hPvMMxtbEcOJlQAb0=;
        b=BoD8hnjAgUYmC+bVUekf+tiRwVGwrlOyZqRXwbVdDFlZklBePmHUghqkaWfHMJFq3W
         n9PVlelDfeF0g+y/9juvjZfn0VYAivLH0AZzc+Ew0bgXSDPbYFrIzUNmAq3NhdbV3nAc
         S5IaM3IHtdUsQdW/6TubupnmiqhcXf5SzQOTZohKHYdJk1GA7/TVgASEftm6O4CmZXL7
         e5Mr7q2pwZC+0nJLaUlCpEVv9UDLRjCeR0ULyOd0YR2m9LC4ZdG/N1TFx1Xm+U1D/zwc
         wZK16juqhJUYAP4PBZXr8UD4w/w0RIvNWduxMk8JI23V3AiNRYlyu4B3lTS1WmzOMxCe
         fhTA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781437558; x=1782042358; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UYxOnpq9yBeiaN2mTbvYlWTQWFXGZfN7UV/tTv9hfZQ=;
        b=Fy/oDMgzEp2VmUV5CdCs+FWhREJiUVT1nF1De6tD208JfAFKoZJr2FgKD8GjneY9KF
         +bLbY1xFyGaeQXEUONLcMO7k+CZdvJmYwGYX461zDwFk8UMziW0f/QeGpF7i7FD9raNu
         MJHl4hnp0IK+LOqqzGI7Z7a/sOnubkOJz879pcl5YVkvNRiYwCYhghyN1WMkLeL0YaJp
         wLBHCVm9v5FE+9Ma3GPuRBMYVCXKuHGW2480Jl7wGBfhlB0qW+EAAFsuXLO/dn9H3k5d
         Msepf07CmwZxY3QcDLJ5m0vxOIJjU2gNPgp6a58auUpq140hi3sLNyLzp40HS5R+1uf6
         PABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781437558; x=1782042358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYxOnpq9yBeiaN2mTbvYlWTQWFXGZfN7UV/tTv9hfZQ=;
        b=bvSQmnzFTT2DaM0+DK5KEXOlXC+hTLU7QXD69sJo1ujOXLzHJpleQuAG2XQ0GRis/r
         HLShLIHWfFUiACG6WOX3ZXUSWg40s8z6Y/Ix7kCsFVp0OfAkjcOUgjSr9+U8vTGYPvip
         vDC+/QGD3L6HtCCLII3JcRGdzzwQ0F1BsuhNYjnb33WhgK/v1eU4bRPbk6RE/fqf0xls
         ZetzwECwgGeKZQlCOF6vv0zILkYcP0FlZOf1YyMg12DAh2HrVpDuPkzioauFoRbxlyFs
         hkOUm+kLY8P8+uM3TaSFKByzq1p0Y8nGwvb06GB5UoMZZ/pmptvLtiRLpo3LsUIQ1Cbq
         tQ/w==
X-Forwarded-Encrypted: i=1; AFNElJ/02IObc93pY2DcFhYGzzQ6W+Mt1wcnWJrrm0NzpdTQ/t9qLtY8BvWOmLM2p1cBgbgcSceGU2QLM2MdsT5aLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzZUDPiFAH4MrFiw5OOEjf6AZq9gvra1le1+wzpF2fwSt5FCDo
	dFpBa8d2IWhr64DOdw1PxT41keTF+1H+8truEhOMH3mmKsiAfVsoZ6bt4vY5CyCPMh4v2vjKsT0
	EuTUnFgGo7qSxhLTmNcp6KDsS82WX7fTezAgztCD5QA==
X-Gm-Gg: Acq92OHBh2kTsfuUEH2uZo5lbSAToKYhBi9MhTt5pOZpGyzAIEIN0TKsIc9Fwe/Brhj
	ZUBlq/FTPpCd7fejTgZSn2dkBKdgPTq6T/0rZUiDql+KoQlnwEdhYum2W+CNO8H1YtWC3fYazTp
	dwMKeQtTuFelZus/33+9StU/w+g/NLd2gGDZ5gHoHQjw3OnEUeaSbi5EXsmBVnw5BLTg1+NEXok
	n49dMStPe4SntaEUbZMmCosOlCyFm0/YXgmAlEfjJKb02D/Kxjb1+CQhiHmohFAQB/EAHUu20mI
	bbXKX6wJl2c+vN7ufPAFXxmRMvfe1yC+ue/z9E3Bi9XOvWAaqs8E/qQ7pG8UwsWyiwU7wKWfKGp
	ZPshC+Dqpv7b3BNVoFQuC9SjmidbQ3+BUyN59h18=
X-Received: by 2002:a05:6808:4f21:b0:486:5275:8144 with SMTP id
 5614622812f47-4874194d5damr4572042b6e.2.1781437558100; Sun, 14 Jun 2026
 04:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-2-c34c187142a6@thegoodpenguin.co.uk> <aibMr16r55xE26rU@pathway.suse.cz>
In-Reply-To: <aibMr16r55xE26rU@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 14 Jun 2026 12:45:44 +0100
X-Gm-Features: AVVi8Cfqmzx5ANOaLYg4zATzHJIZn1Vg14oXTdjpHhDh_VtEe2JUNu4nQf-biNo
Message-ID: <CALqELGzTH8cTLVgX9CXuf_LFLgC97_yfqYJVHzU9ghPuev7SNA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] printk: deprecate boot_delay in favour of printk_delay
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 15:07, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2026-06-01 00:17:38, Andrew Murray wrote:
> > The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> > are two distinct mechanisms for providing similar functionality which add a
> > delay prior to each printed printk message.
> >
> > boot_delay provides a kernel parameter for delaying printk output from
> > kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
> > configurable only via sysctl and thus is only used post boot.
> >
> > Let's deprecate the boot_delay feature in favour of printk_delay. In order
> > to preserve functionality, we'll also extend printk_delay such that it can
> > additionally configured via a kernel parameter.
>
> I would make it clear and say: "via an early kernel parameter".
>
> Note that there are also kernel parameters which can be modified at runtime
> via /sys/module/kernel/paramters/<parameter>

OK thanks, I will update.


>
> Also I would make it clear that this changes the behavior, for
> example:
>
> <proposal>
> Behavior change:
>
> The delay enabled by both "boot_delay" and "printk_delay" continues
> working even in SYSTEM_RUNNING state. It must be explicitly stopped
> by setting printk_delay=0 via sysctl.
>
> The delay is skipped when the message is suppressed in all system
> states. It used to skipped only for the boot_delay.
> </proposal>

Yes, I'm happy to make that clearer.


>
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1339,11 +1327,34 @@ static void boot_delay_msec(int level)
> >       }
> >  }
> >  #else
> > -static inline void boot_delay_msec(int level)
> > +static inline void __init printk_delay_calculate(void)
> > +{
> > +}
> > +
> > +static inline void early_boot_delay_msec(void)
> >  {
>
> It would be nice to print a warning that the early boot delay
> does not work, something like:
>
>         pr_warn_once("Early boot delay does not work without CONFIG_GENERIC_CALIBRATE_DELAY enabled.\n");
>
> >  }
> >  #endif
> >
> > +static int __init printk_delay_setup(char *str)
> > +{
> > +     get_option(&str, &printk_delay_msec);
> > +     if (printk_delay_msec > 10 * 1000)
> > +             printk_delay_msec = 0;
>
> Sashiko AI warns that this code accepts negative values.
> It might cause long delays, see
> https://sashiko.dev/#/patchset/20260601-deprecate_boot_delay-v1-0-c34c187142a6%40thegoodpenguin.co.uk
>
> The problem has already been there even before. But it would be nice
> to fix it.

Thanks for pointing out Sashiko, I hadn't seen its review on my
patches. Are authors expected to get emails from it, as I didn't?

In any case, it's a good spot, so I'll address.


>
> > +
> > +     printk_delay_calculate();
> > +
> > +     return 0;
> > +}
> > +early_param("printk_delay", printk_delay_setup);
> > +
> > +static int __init boot_delay_setup(char *str)
> > +{
> > +     pr_warn("boot_delay will soon be deprecated, please use printk_delay instead");
> > +     return printk_delay_setup(str);
> > +}
> > +early_param("boot_delay", boot_delay_setup);
> > +
> >  static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
> >  module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
>
> Otherwise, it looks good to me.
>
> Best Regards,
> Petr

Thanks,

Andrew Murray
