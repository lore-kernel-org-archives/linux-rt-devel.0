Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAD271471
	for <linux-rt-devel@lists.linux.dev>; Wed, 13 May 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677463; cv=none; b=K/1EN+ALEPLHzkwfBQdARyQu1ouvkjpmwckdVTKRNMNOWJHNxDwL1FB3M6n8sh3AF28vaCiTg/7O/TclDzf4Jd8W4Zmzg/tnQn4e2rhlr5468eKxWWD8fuaLTRuFz60b38DvOtuazU+N9Oy5OodByCRap8IMv/lBWEajrAo9ULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677463; c=relaxed/simple;
	bh=+FxJG4kW9NjfhAdfAskdR39uG7HKd/rVabJUuHsVcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlH8D1gvP4YLKJUMuUgqyaQDecouGPCOFG92qoovIBYaQb09qpeBjLHrjahID/YZjWceQ5jc+t2NPu9L4uLvJNHq42MSUuA44bDmB7kpp73cg18hfehYwrEG7n88a6IDakVUxPJziHX/sqkCwN2q/SPYC4vfSEPUiwsd4ELZ5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=evMyfI9R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="evMyfI9R"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45562c41ec7so3232238f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 13 May 2026 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778677460; x=1779282260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a38+h9bWp3RlleTL1QjZzeIbioOA+x/4L20QS9dVRSE=;
        b=evMyfI9RFhjJwiLuChI5kzUgvk+tTX7N2WI5uSmExABtSjw/0CErirzGLEun+iJLyJ
         PsocVHdvQfSrOlm4tC5TEw01lKXPWsv4p3eCACr+yqYeS0gSU4z0tuzasn6nrZsnf16R
         bAkJ2Np2xJdo9vz+bYQmyfVVx6J5t0Ygv3jO2ZovCcvIpZQFFy/W6F6hwbJZNvYsT93r
         8j28upQUOLeG83ueSkYtheFVs9yNWpUFgtqaw9mWiO5COHpSGlfB5LWZ0UPwIxbnXH87
         oCDeQv0kwGbKxzA5t0NzKZpAfmPeSymBrXvY2tIEcVuARwhRxyha9imsDqjf87dtmYUB
         crag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677460; x=1779282260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a38+h9bWp3RlleTL1QjZzeIbioOA+x/4L20QS9dVRSE=;
        b=lFR6T5Va9pVBAr6hNSNsVbjJTz7qt3KozkOPlh0wl6VwUDsSc3LV0MzZYMyKi9sx9M
         nWvfcEc5aoK8IvMGhEn8M3l1hZWl0avBTdqh8p8pRDKoSkNvYi89IUmec7Uge7EA+bz8
         JQlNPr/eP44gcbcWAw3vgOnjoljOz9H/lSWZHfr9h7KYPmUmyM7c5/eVn5D783klAN2Y
         Mp0cXImq5GM0bywrS8f9Sy6Rl9WIk4d2u8Xsm0X6nG8lyXyfwOH7V3qfMD80/Sn887yF
         tXN2TT9k5RSAYutVcAP8zShET8CZ2N2Nw7mgaXwAxxCilcRJG3BqeTg+wy6EdGeWJRUo
         Mb9g==
X-Forwarded-Encrypted: i=1; AFNElJ/vT/v13ouL6AQZDTDZiIphaSwfKet2MZSu4Jp/z+VFS0mjiNDMBu0eCcBV5ofxUbgUU6Qs5lAXh4lGxVOVQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyydP2V2oGg8QQv4MdHVxbR59eXqksMi4ptjUxAPQNF/jJLqzyp
	EEBB3yLKz7JL6q04gaG3EHC/2KuOuCFptIXBf7u5jGLWLPtGIG7bm11HV53PpoWmHow=
X-Gm-Gg: Acq92OG8fDPOO5MKWTZl5wTZBu+Y9PDbUHH6I1QgE21AOEMeu59KzUBkoJ4r7/MCYwg
	m+uJGdBFxeh4TYt9Rnwr3L1+4yVpNfijWxQ1/ef0rSQN6lLAvQyNAg8AeqV/pSGKg9MSMlnJJ3R
	xrlGAsxFSQ7upK7luumEUCDzJCXsJBtbathaSfJVUYU+kNZI+v1HrVuDZofT37P3XjwNTpfRUv5
	ph9UTr+iXDiuQpkERMlreWICpHdKh0UonHi+3DPDUjALuGzhjFat3VtZS0ST802xnSNZiy2hhDy
	fhAKzuJbJ9SiuaVCUtxdssrHN0omzIvMRpg0cS8x165c1Nl2960JXjXv3h7yt20svJ85HRG195y
	4hiPt3qHmOc5Xu5I6cGOw46bQgdceDEs4lmUbt2mb9DX355tWLQxgIRZCrqiDe0BaXD/cWJfMA9
	fvGxJ4lvCYMG74VIfpheEeoU6VVVLvT/zr6mri
X-Received: by 2002:a05:6000:1acc:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-45c57de9e7emr5052075f8f.9.1778677459533;
        Wed, 13 May 2026 06:04:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ba2aaec3asm11115693f8f.15.2026.05.13.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:04:18 -0700 (PDT)
Date: Wed, 13 May 2026 15:04:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC] printk: remove BOOT_PRINTK_DELAY
Message-ID: <agR2z4r5sJvAjm1a@pathway.suse.cz>
References: <20260505-printk_delay-v1-1-5dba51d7f17c@thegoodpenguin.co.uk>
 <afn-H1EQJxnDs0BZ@pathway.suse.cz>
 <CALqELGxhXO=kzh9bpztd9=Ug9ykPL2NALo9Apq3=Oj6aeiEcKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGxhXO=kzh9bpztd9=Ug9ykPL2NALo9Apq3=Oj6aeiEcKg@mail.gmail.com>

On Wed 2026-05-06 23:37:01, Andrew Murray wrote:
> On Tue, 5 May 2026 at 15:26, Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2026-05-05 14:45:00, Andrew Murray wrote:
> > > The CONFIG_BOOT_PRINTK_DELAY option enables support for the boot_delay
> > > kernel parameter, this allows for a configurable delay to be added before
> > > each and every printk is emitted. This is DEBUG_KERNEL option that is
> > > helpful for debugging as kernel output can be slowed down during boot
> > > allowing messages to be seen before scrolling off the screen, or to
> > > correlate timing between some physical event and console output.
> > >
> > > However, since the introduction of nbcon and the legacy printer thread for
> > > PREEMPT_RT kernels, printk records are now emited to the console
> > > asynchronously to the caller of printk and its boot_delay. The delay added
> > > by boot_delay continues to slow down the calling process, but may not have
> > > any impact to the rate in which records are emited to the console. For
> > > example, if delay_use is set to 100ms, and the printer thread has a
> > > backlog of more than 100ms, perhaps due to a slow serial console, then the
> > > records will appear to be printed without any delay between them.
> > >
> > > It would be unhelpful to add a delay to the printer thread, and it would
> > > not be possible to disallow selection of CONFIG_BOOT_PRINTK_DELAY at build
> > > time as it's not possible to detect which consoles are nbcon enabled at
> > > build time. Therefore, let's remove this feature.
> >
> > Heh, Randy proposed to remove "boot_delay" few days ago.
> > This RFC goes even further and remove both "boot_delay" and
> > "printk_delay".
> 
> Apologies, I didn't see this. I'll co-ordinate with Randy.

No need to apologize.

> > Honestly, I do not feel comfortable by this. The delay seems to
> > be handy when there is only graphical console. I would suggest
> > to do:
> >
> >    1. Obsolete "boot_delay" with "printk_delay" as
> >       proposed in Randy's thread, see
> >       https://lore.kernel.org/all/afn2sYKKsqG4QBVX@pathway.suse.cz/
> 
> Your suggestion was:
> 
> " 1. Add "printk_delay" early_param() which would allow
>      to set "printk_delay_msec" via command line."
> 
> And I assume the intent is to replicate the functionality of
> boot_delay, by allowing printk_delay to be used to introduce delays
> from early_param time? Thus deprecating delay_use.

Exactly.

> 
> "  2. Modify boot_delay_setup() to set "printk_delay_msec" as well.
>      In addition, it might print a message that it has been
>      obsoleted by "printk_delay" and will be removed."
> 
> Given the intent may be to deprecate boot_delay, I'm not sure that
> setting printk_delay_msec as well would be beneficial, as this would
> extend its functionality to add delays beyond SYSTEM_RUNNING which is
> where boot_delay stops. Unless you mean to use boot_delay as an alias
> to an early_param hook for printk_delay?

I do not think that this is a big problem. As you write below, it is
a debug feature. IMHO, people debugging boot problems won't mind when
the delay continues beyond SYSTEM_RUNNING. And if anyone complains
than we would at least know that there are people using this feature ;-)

> It seems that there are also differences in behavior between
> printk_delay and boot_use, with printk_delay unconditionally adding
> delays to all printks, and delay_use which considers the loglevel.

The unconditional delay does not make much sense. I consider it a bug.

> >
> >    2. Move printk_delay() from vprintk_emit() to
> >       console_emit_next_record() and nbcon_emit_next_record().
> >
> >       For nbcon console, even better would be to use a sleeping
> >       wait in nbcon_kthread_func(). But it would need some
> >       changes to call it only when a record was really emitted.
> >       Also we would need to use the busy wait in
> >       __nbcon_atomic_flush_pending_con().
> 
> This makes sense.
> 
> If the use case (in a post kthread printk thread world), is only
> relevant for graphical consoles, then I do wonder if printk_delay and
> boot_delay can be replaced with a more specific solution? Now that we
> have printk threads, the time in which a printk is presented to the
> user may not relate to when it was created, and I fear people may
> continue to debug issues that rely on that assumption.
> 
> I think the most pragmatic solution for now is:
> - Move the printk delay to the point where the printk is actually
> printed (e.g. console_flush_one_record and descendants)
> - Add an early_param to allow for printk_delay_msec to be set
> - Deprecate boot_delay, by using it as an alias for setting
 > printk_delay_msec, and include a user mesage that it is being
> deprecated and that it now extends to beyond boot (which could impact
> performance on non PREEMPT_RT and non nbcon systems)

Sounds good.

> - Update printk_delay function to use the appropiate mechanism to
> delay based on stage of boot and using printk_delay_msec instead of
> boot_delay.

Good point! I thought that mdelay() can be used even for the early
messages because parse_early_param() is called right before
parse_args() in start_kernel() in init/main.c.

But parse_early_param() might be called even earlier, for example,
by setup_arch in arch/x86/kernel/setup.c. And it is called before

  + tsc_early_init()
    + tsc_enable_sched_clock()
      + loops_per_jiffy = get_loops_per_jiffy()

which seems to be used by

  + mdelay()
    + udelay()
      + __const_udelay()

Anyway, it has to be done before printk_delay_msec() can be set
via an early parameter.

> If that makes sense I can fashion a patchset.

That would be great.

Best Regards,
Petr

PS: Note that I am traveling the following week so my review might
    get delayed.
