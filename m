Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24909439349
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523356; cv=none; b=WwP9a5FkxwwgYzaeU19pNJuGE4XxuHZ09x0uqsl37Wb2Oc03iazqr8fP2TSJpu4tnMhD0JBr3+Vyol1aqz0ebONaU5CkzUJmjPgIU3FxVp+uxTAS4F4gPE4UkB7bIo1ZE7O4ZK6j4nD1tp/lQFQmDgrgcA1uLYtZNVx/hZ9ZHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523356; c=relaxed/simple;
	bh=z/N7Kqy4VoN7rjklbVEOz2uDR/SzdIzcOligfSMXm24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzIi054yDVEmdhpa3Yxm1hH5CUH2EiYSDLBzNNJWORI4lhgm5mFsrp92MTJsw4Akmx68VHoKG8UNZ5QzKZp+E2M86kIv/hkk3nloIsUeASN1l3Cb9Ac01Q/YihAJHMY0pVU2XtXmn4v1PxEQV1y8/jU49khuWanps2WWCayFcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YC6LC+VR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YC6LC+VR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so6225605e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 08 Jul 2026 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783523353; x=1784128153; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y2V4c6FXtAmxv+8d6AOr3BYyTP+hfZgC/AR0Ye5xNZs=;
        b=YC6LC+VRx9MdCyfimU7m9eMaOkWDRA3Hjt3ruAOuh+5NTIQUGCW7w0fdCG2/3nPmP1
         vCff3LMc/mLQso6pdDZ5+G92k6OV0M+nLFIrieYExb8fgy2tuLI+scGyxl/jkqtmo2Ug
         8qMv9UwJmBUCoezNXaUwFEj4GJ/AH3qP6wODLfvtGvtiK81Z4MG0gsPIlpIWciCJlfZE
         qRUogPw8WSxySObc/XN7a3GDi+z6Pnl5eJ7+RYKLbi5eYzmmLXdOx/ld76q5uasB1jrB
         dnG+MRrb9qdOg7PMwextV86B+/5AU2nSFXiuEy7RtxsT1wm9BzUiO0I+7HA8UzCb60Ke
         qNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523353; x=1784128153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2V4c6FXtAmxv+8d6AOr3BYyTP+hfZgC/AR0Ye5xNZs=;
        b=f/4kdzpL22pnrXw3FrYxTvToakpfLiU58ajCNZXvka5vqXSXjj6ClAbKKxEzq7drYA
         iPk+hjHEcnv/Cy6mEWdX40wg3x87WzsRp1h5cppXh/9TD3mQq4Finl4bs82Hy4zmpDcd
         wd0CCamXc59mO8QIjikWBjI95UuFVxgJel0JvTxa7ql1LzkKPrbkeLXe6zHxcSq8TDeg
         lm827J8mMUjv3wmnWjXI2Lm6by34Xu4y8wfFJSMJxrmRdiXBHKN1NfjAmwNItVbm+1Z4
         KY/HF5OCHDVnpws+T/eGVPMCMO49XZI0lC35FHUxBMHCI5feDH831d7QeVKDH9zTTwCe
         NfJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9qZIoml55eGAp+7Ao+tBpvh78jwKEu4LZmQdJPZJM3x3zR/AMoTr0vWssRiEeY1fe1VHWFlsy5nFOlBKWhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYti7XsGhCOgXO3fGek7hutc/jCtKb0ZYi5iCyjcXV2ynxpISx
	sDYkl+yj/eG8mYqqj9sFzojbyU7lETFzNjq1m0LNL2DLYnDBF2LGhEUaPv6ZK6KbI0A=
X-Gm-Gg: AfdE7clmfIF/ELqmYpNqQiKtqrqEw72hKFXQaHTJtP5ny9W7VvIDi2FbDjbBa6L82Jy
	Io9knc8l7k5P3qpaRFtIAgfs4sHpU7VbTT8hAOEv5vrQxD+V0AFMaJzO2tOEf9i+e3/MJmKoft0
	W1S9ob8VazqNiL70KnO4QpyUxObRNcX9Dbpm7P96mKjF9UJkDMTvD/ChqpURX4KzKQK54NJ46Hb
	zOhGwHu00kv0bcl1zUM/I7ZB4CMhx1L3WsYIWMgvXfTruDXXZLQUUw49Rqemh3nNZOHuI8nxsCe
	Yrbnzrdra24NmEX1DE9qEuSUdNHmVAD6PPytS9P6ExzLzEe1XZQufkij3cJdlE/E3pf44Y4Aj2E
	wXwqoHbphov9XzxRaehV6/B87gRJtGUcvNCUHFP0U2LtHRnMuonMreWqLHWJc0R7WDmBEWk7lE0
	UCmm/6Zdg1qlr0OUM=
X-Received: by 2002:a05:600c:34d3:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-493e68c699bmr33093525e9.16.1783523353384;
        Wed, 08 Jul 2026 08:09:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm238538095e9.13.2026.07.08.08.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:09:12 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:09:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Benedikt Spranger <b.spranger@linutronix.de>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
Message-ID: <ak5oFk3Snnt9Wr95@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra>
 <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra>
 <ak0VguIf-PxmbUOS@pathway.suse.cz>
 <87qzldvqpm.fsf@jogness.linutronix.de>
 <ak5eCp5qw9LYrnAH@pathway.suse.cz>
 <87zf01ttve.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf01ttve.fsf@jogness.linutronix.de>

On Wed 2026-07-08 16:59:57, John Ogness wrote:
> On 2026-07-08, Petr Mladek <pmladek@suse.com> wrote:
> >> The synchronous mode would rely on the driver being nbcon. I envision
> >> something like this:
> >>
> >> ---- BEGIN SYNC IDEA ----
> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> @@ -1200,7 +1200,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
> >>  	cookie = console_srcu_read_lock();
> >>  
> >>  	flags = console_srcu_read_flags(con);
> >> -	if (console_is_usable(con, flags, false)) {
> >> +	if (!(flags & CON_SYNC) &&  console_is_usable(con, flags, false)) {
> >
> > The dependency on con->flags means that the sync mode can be entered
> > only in task context where synchronize_srcu() can be called. It might
> > be good enough. But I am afraid that people are creative and would
> > like to have even atomic variant sooner or later.
> 
> You mean it can only be _modified_ in task context. Yes. I expect it is
> either specified as a boot arg or modified via some sysfs interface.

Makes sense.

> > Also it will do the flush in NORMAL_PRIO which is good. But it might
> > fail to get the context ownership when it is blocked, for example,
> > by uart_port_lock() which might be even sleepable context in
> > PREEMPT_RT kernel.
> 
> Indeed. This is the same limitation of the atomic printing in
> general. But I do not think this can be worked around during normal
> operation. Ignoring locks is not an option.

Let's see how it works in practice. But it might work pretty well.

Now, the question is how to move forward. It would be nice to
have the sync mode available before we add this boot/printk_delay
clean up.

Would you have time to prepare and send a patch anytime soon, please?

Or I wonder whether Andrew Murray might try to create a patch
based on your "SYNC IDEA".

Best Regards,
Petr
