Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB91BD9D0
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607217; cv=none; b=HF8jOvOai9ORJfrb+lwWnRFASdu4QSt0dk5nFqs6Up1vHxgJl6l1l60j7PakBzo+VVC+NAVCR/WvAtdA4iS/w/V1fPNNFj17/qnp1FqIXa+W2f1h0QhDYOVEYlx83dRZR/pJVV+9Zd57ip+bpcKgChNMx14ySZS8d5z08Md8Fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607217; c=relaxed/simple;
	bh=YI6Csvady8zUfpKj0TSyww8TUuACFjmAGkHdUe3RKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVGiYTLSG/1IRMQFnFsUwnwsII/GgaeNcOq2oYsQEZ1AjPjjikxyNkUAFUTDdgqIPgniXszXd/DT1p83uwiK9Tog9vipEzdtEb+x3Tl6kPOHTrKYPd7yU/k2FDUFAvUxIbIOvody0L57CupuZyQyHiisKft6eyfGfaSfvWcvYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EpgZW/ga; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EpgZW/ga"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ba701891so14498495e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783607213; x=1784212013; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgKeluas+jUY/8yJAiAEBG5t4/+qnuDSzD0+HGXJqIM=;
        b=EpgZW/gaYcqtRCRQXvt4iCXWeF+r0hUSrMd6JLxS+f+CkZ3J5sA9FUss+5E2sL2Oey
         IAqFDqZv2bIiyn9m1leRCwvN4K90fmH3XA7yX41XfnLtwiUsIUP/GWYUhXb2LRSaoXQ7
         mUcU/FPL3d1gMmYAFv3BoksBJyTbtCeWSU1giHL09RntL2uCRO7CdSJl5gmllaBK3bw5
         IK7LlGSsqp2O3wzVI222rFEZFgEpGW2TfC/4uAPs/Y7BTAbBcWtq16YGjvFG24Gv+CPb
         fFleBMJpDBdam07QLZ/ltS8DCPoNZkd1YTnAEBg90ISWoiy2uzc6TXSUMONRMhHyKTG+
         FedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607213; x=1784212013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgKeluas+jUY/8yJAiAEBG5t4/+qnuDSzD0+HGXJqIM=;
        b=mMJ3ByiX447WXlqsYZfjHKHwBGhBha1rb9yNVtRroN8NcCZgy6vxl64AGm3vD759Do
         HKQGo9X7raYUBsyZGrTVQdmWTv7Lfs1HoBTu3xV18lLUwQYui8Fi/NcVQNpqqG23PhP+
         2EBNPu1ZfIyEOYDtogeQGlKYY8gqTIE4Y2Obk4ueARwxLwNeoXHR5Qo0X6hQIYQ9Wf+F
         cicenIfiyRZ84OZuju1vJNpNeldmqFmjjcbvoRvfzWk3e9l5p88CushHUdgaOgXIEYj7
         q88uimYMRJ01HTA1KSaRczZvcpkkRW5q2i3VyabdQlOwlnd/1lXPmtR4Qp71IRdWfWmO
         DpQw==
X-Forwarded-Encrypted: i=1; AHgh+Rpeht3xVTaejaz/oHQm9nLRdFfoRBoucB9X6WEvQ0r6Sbyc5sxPXk2tsIxbQNRXd0fE9vb+YsHo/IhTzR67+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNeIjwlxQS5yrea5baBN4a5XRlr3Usl1Gm/aR4agLF9SXv6SRY
	JLYfoYbDdX34+6t/HgBpz6Rrd5dBbOrDDh/V2Or0vQxyoUqOGI9zhgObMBZ/T6IJSQw=
X-Gm-Gg: AfdE7ck5WTO8JpErez/qXDThTMwLHvdXrfZJB7O22hJTFCv95qj7+MbLnDVA0d0RXgC
	qLZ6CvgK3wUP4DppBYCDkDej4RPAuw8x64MiRtFdo7Ah8TsfxnJsc4RXOqQUutyxMbmIaNhtlBL
	yIdUkmO8Dj66sfT8e3Gng3Fu85ejK1d9sLW43KB2dOKuFeLMuW4CEm9pjXP1LFh4aNcRXtKI5Ls
	fMwwALmRw68U1qyRSX6thcDb6H+aV5VAWWgpCOGELnMP0zx9/yjnb5m3iw1yPgh+7N47Q8G0+jZ
	iz05J32Gu5SFB9AabkiffIzIwTu57RsG+xfe9cmCg6t1CnCRWzPhnZCu5efWAZOu5ezocorQHbt
	Sq0CVdVeykIe4mgkwHuSGXWQXRb49Dxm+EAoYGGZBMObkTYkypMXrJ08Hcv3hxerxMJCgxojRlJ
	am9hjwBYPKAnbRr/8=
X-Received: by 2002:a05:600c:34c3:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-493e689b37amr85711945e9.14.1783607213522;
        Thu, 09 Jul 2026 07:26:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb74835esm72452175e9.14.2026.07.09.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:26:53 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:26:50 +0200
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/4] printk: deprecate boot_delay in favour of
 printk_delay
Message-ID: <ak-vqrSr7NLCkGQw@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk>
 <ak5mPxUdp2pzCMt5@pathway.suse.cz>
 <CALqELGxjTZAXEp1C1CNO2tLbUpUChZW3DHcNgyhEu4Ma-ct2ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGxjTZAXEp1C1CNO2tLbUpUChZW3DHcNgyhEu4Ma-ct2ow@mail.gmail.com>

On Thu 2026-07-09 13:32:10, Andrew Murray wrote:
> Hi Petr,
> 
> On Wed, 8 Jul 2026 at 16:01, Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2026-06-30 17:35:58, Andrew Murray wrote:
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
> > > additionally configured via an early kernel parameter.
> > >
> > > Behavior change:
> > >
> > > The delay enabled by both "boot_delay" and "printk_delay" continues
> > > working even in SYSTEM_RUNNING state. It must be explicitly stopped
> > > by setting printk_delay=0 via sysctl.
> > >
> > > The delay is skipped when the message is suppressed in all system
> > > states. It used to skipped only for the boot_delay.
> > >
> > > Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
> >
> > Looks good to me:
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> >
> > Note that Sashiko AI warns about possible problems with negative
> > printk_delay values, see
> > https://sashiko.dev/#/patchset/20260630-deprecate_boot_delay-v2-0-f9883d36aa4b%40thegoodpenguin.co.uk
> >
> > But they should be handled in both the early parameter
> > and sysctl interface by the "10 * 1000" and "&ten_thousand"
> > limits.
> 
> Yes, that was my also view.
> 
> 
> >
> > The only potential problem might be a warning about possible
> > "sign" mismatch from the compiler. But I do not see any
> > even with make W=2.
> 
> I suspect this will come up everytime a change is made in this area,
> or perhaps some W=2 errors will pop up via kernelci or similar. I
> propose updating the patch as follows:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5278d9cb19e4..fbb67f10c21e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1338,10 +1338,13 @@ static inline void early_boot_delay_msec(void)
> 
>  static int __init printk_delay_setup(char *str)
>  {
> -       get_option(&str, &printk_delay_msec);
> -       if (printk_delay_msec > 10 * 1000)
> -               printk_delay_msec = 0;
> +       int printk_delay_val = 0;
> 
> +       get_option(&str, &printk_delay_val);
> +       if (printk_delay_val < 0 || printk_delay_val > 10 * 1000)
> +               return 0;
> +
> +       printk_delay_msec = (unsigned int)printk_delay_val;
>         printk_delay_calculate();
> 
>         return 0;
> diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> index f15732e93c2e..f256fc05faaf 100644
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -46,7 +46,7 @@ static const struct ctl_table printk_sysctls[] = {
>                 .data           = &printk_delay_msec,
>                 .maxlen         = sizeof(int),

I would change this to sizeof(unsigned int) as well.

>                 .mode           = 0644,
> -               .proc_handler   = proc_dointvec_minmax,
> +               .proc_handler   = proc_douintvec_minmax,
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = (void *)&ten_thousand,
>         },

Otherwise, it looks good to me.

> This makes the cast explict, verifies the range before casting

Yup.

> (I guess a range of negative values could result in a postive value
> within the 10,000 range) and also uses the correct proc_handler.

IMHO, this should not happen. I have never seen int smaller than 4
bytes. If I count it correctly, positive numbers should be up to 32767.


> This has the side effect of not showing the following pr_debug for the
> lpj calculation when a delay is not set. Though loops_per_msec is only
> used during boot, so I don't think there is any loss here.

I agree that it should not harm. But please mention this in
the commit message.

>         pr_debug("printk_delay: %u, preset_lpj: %ld, lpj: %lu, "
>                 "HZ: %d, loops_per_msec: %llu\n",
>                 printk_delay_msec, preset_lpj, lpj, HZ, loops_per_msec);
> 
> Can I keep your Reviewed-By with these changes?

Feel free to keep it. That said, please put at least the change
of the ctl_table into a separate patch. I would rather put both new
changes into separate file. It is never a good idea to hide
such changes in a complex patch which mostly reshuffles an existing
code.

Best Regards,
Petr
