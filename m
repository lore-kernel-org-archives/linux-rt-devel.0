Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DF47D957
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708447; cv=none; b=G0qu0+2c93lIZVQGD8JTYbQrNVzQ5VHDh4LhTDq4GPePEyABrYNs3kzkuyDWDVXLO91huCKF74xebkIot+Xs7g82ORxrIW6bJxPiXTAGrYLSZAXU6aVtB+13JA2CQkYxakhAffJYyNDPeBw/cH7B1LF2XTin++0wOpzNB1321mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708447; c=relaxed/simple;
	bh=McQ+qO1hYfBNZThW7q+uEink7ZkGXzP0Q+QVRx1/9J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ9Wc4uxMPyLEN4q9QtdHqLKlGoWDhBKdsyIlK/65GFeBzlF4uAWiOzWtY6+9/FI+VsehSKKa4TaVXEds6Zcam+T2B4THONKk1yJJqyDB4391UFjxM+X2rhXcv6cxdrLp3ycXetmVhMh75lPUeZbZfswX04VPWh8xCPPvB1BhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TX4S0g6T; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TX4S0g6T"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso44699025e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781708440; x=1782313240; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1rkmuWuJXVzNvn1+c174indnosmtT4pQFumhbjNtd8=;
        b=TX4S0g6TZRebydOw8dlA8mFswNYBI9o6G0C5uf36+rCTJTb27l5k9TcSh9JLNgN5eh
         AxQVS+Gd69p5BPkiNFUOMvwRzGhyEIS7BSEd82x9wNlQ9yUR36f6xL6+xDfZmJprWw7L
         3GruNoTimUljBnXw0daJ2UyhH+JYFmDcBg/qti3eGPlaEW3KZeSAWIaVweOkhilQTFjl
         wVOjci0daZflkzVKyKOUKyd99Fwb0PY9uFVnhi+RJSkKYqiDIW7Jzb3LAxM3nuRclG+C
         RL3GRBJKhQBaCktkoOqsLjXSw9tYODroCyL6D1p4fTD9oUIPNM2kaQdeuPSDkNa1I1M0
         rk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708440; x=1782313240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1rkmuWuJXVzNvn1+c174indnosmtT4pQFumhbjNtd8=;
        b=hF7MCFavhhSCPNqiPBFRcjd9Czfy58x/bA97TxWYlwG4w7LsBrySzKmuHjUDmbt9Dw
         yGXIcK2pfLgcgzbSeXz/Nf/W2WO4EK4gA3SqXb9tQMgBG+dHdX5TbZJww5ZFlg+Iget/
         c7x4aHFNZvx9r6Rq0LDFrkcfJ68ocjjZyNDQ6omt3ay1/EqxK9T2AyM2Qx7O7AMD8cPO
         Qhw5VK5jLtLbmg/RF63pToHOv4jSJ7p+MUEukhh/NSfffCVRcEni2G/0J7GGQ7GXFMFx
         bT54yVFixq+UrwHVWXfJW0u8XYML/K+VqCaGEQhWBBoWtvdH682oT3LqLaxsTJwLfhV6
         ZQXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9g8wR4IJeyJoFk6Z+NIiEpcBLQcen44iBgj7N10N2MKuAfnP4BHxFs6KDlhJiGNFPVdIoVj58+PNWOQCKxRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPA7xth7faumQm9kRpDl43XZ6JvX5+inDOE940wgsr9047HDlf
	6uRIz37/ZLW1xHFR7RsTK6fXl79JipmRCvxtihQzTbG0DeFkJzhB+jEmAqZ+4YryvAo=
X-Gm-Gg: Acq92OFFjUay5WFDFgQVIxOzU5phO91XJIRQM78DGIl1V5Wh9yn6L9dk0YDxyutu9RK
	/V8DCwyqFd5ewJ3pgqLCWRde/uDYxqOWJwQ87E1B0ih2d8EUpSd/66oNh0lDnBl0u1JwcKKRHzz
	B8UdDvrVGpCSwSrA54AbW7FxmGwW2Qa0GnC0t6eeXmve3OOj1RXkPN6YkOhZS2BDHgcmKy9qrhX
	pit/lQlzkVi3TyvjbeI4EgshqNqX1RwtrnLqx8BcyGW1Lh19M8fuNVeTtrrAAuJilmIRiUIp+2e
	oF+Y9r3jGQOuehTNkHNBBROkSTX+JZC6Qhm1B2J9y0aYBCGhVnti6rQXO84tYs0rAM4XYGkavwJ
	kR1vJhiBAi0BD3l3Kofm/LHtx0XGNnWcD52q4eTk6GIBA/LslT3h45cYCk3FkjZWQeUM1OtKDRM
	BzpO4FTB+VzIVr0wusnDnmeTZLUQ==
X-Received: by 2002:a05:600c:19cf:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-492333e8d65mr67062435e9.6.1781708437706;
        Wed, 17 Jun 2026 08:00:37 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619fb12edbsm17636664f8f.17.2026.06.17.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:37 -0700 (PDT)
Date: Wed, 17 Jun 2026 17:00:34 +0200
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
Message-ID: <ajK2kpLbvpiKkKBI@pathway.suse.cz>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-2-c34c187142a6@thegoodpenguin.co.uk>
 <aibMr16r55xE26rU@pathway.suse.cz>
 <CALqELGzTH8cTLVgX9CXuf_LFLgC97_yfqYJVHzU9ghPuev7SNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGzTH8cTLVgX9CXuf_LFLgC97_yfqYJVHzU9ghPuev7SNA@mail.gmail.com>

On Sun 2026-06-14 12:45:44, Andrew Murray wrote:
> On Mon, 8 Jun 2026 at 15:07, Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2026-06-01 00:17:38, Andrew Murray wrote:
> > > The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
> > > are two distinct mechanisms for providing similar functionality which add a
> > > delay prior to each printed printk message.
> > >
> > > boot_delay provides a kernel parameter for delaying printk output from
> > > kernel start through to boot (SYSTEM_RUNNING), whereas printk_delay is
> > > configurable only via sysctl and thus is only used post boot.
> > >
> > > Let's deprecate the boot_delay feature in favour of printk_delay. In order
> > > to preserve functionality, we'll also extend printk_delay such that it can
> > > additionally configured via a kernel parameter.
> >
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -1339,11 +1327,34 @@ static void boot_delay_msec(int level)
> > >       }
> > >  }
> > >  #else
> > > -static inline void boot_delay_msec(int level)
> > > +static inline void __init printk_delay_calculate(void)
> > > +{
> > > +}
> > > +
> > > +static inline void early_boot_delay_msec(void)
> > >  {
> >
> > It would be nice to print a warning that the early boot delay
> > does not work, something like:
> >
> >         pr_warn_once("Early boot delay does not work without CONFIG_GENERIC_CALIBRATE_DELAY enabled.\n");
> >
> > >  }
> > >  #endif
> > >
> > > +static int __init printk_delay_setup(char *str)
> > > +{
> > > +     get_option(&str, &printk_delay_msec);
> > > +     if (printk_delay_msec > 10 * 1000)
> > > +             printk_delay_msec = 0;
> >
> > Sashiko AI warns that this code accepts negative values.
> > It might cause long delays, see
> > https://sashiko.dev/#/patchset/20260601-deprecate_boot_delay-v1-0-c34c187142a6%40thegoodpenguin.co.uk
> >
> > The problem has already been there even before. But it would be nice
> > to fix it.
> 
> Thanks for pointing out Sashiko, I hadn't seen its review on my
> patches. Are authors expected to get emails from it, as I didn't?

Sashiko is able to send mails but it is opt-in.

It might create too much noise because it has false positives, it
keeps reporting minor or nice-to-fix problems which will "never"
get fixed. Also it is not predictable so that you could not reliably
check the patchset before sending.

Anyway, I thought about enabling this for printk-related patches
because Sashiko also gives a lot of useful feedback. And it is easier
to discuss it as reply to a mail. But AFAIK, it can be done only
per-mailing list. And printk does not have any dedicated mailing list.

So, I "always" search for the feedback at https://sashiko.dev/

Best Regards,
Petr
