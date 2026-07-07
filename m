Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A73750C9
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436682; cv=none; b=jSqExlZ5y5Pg/GcVUQkPGKwk96GgnS/KGsbQPuj8SXTBAtESBx550oolISxEkNgJ+dzzbj9FnH2+tWn1HDJdu8ZQxIQW/8TdkBxqyAUkb340ATVp81sxUn71mHTOtm21Z/Nmg1eeN1/4OJVrFuR+CCDoMxw98yYZm3jL4ARlgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436682; c=relaxed/simple;
	bh=JUuGK2lRAr3uDkonahalbTvpNXfJVpcw2TjZsADJ6CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T21XalnZBJESjqHQTrsPE9RidcHN/NSufelpKUPGXw+bbMi8Rtt7jn3xbPfJdlybE0w1J1WBm2O1Y+XdZMeok/nI78gtVcgKM5qXXqe0GIN6R31DIUPYajp/AZuK7qJwnSuj2m5U2T6hO8H53hUljB2V0QjFvZAU23YFkvUU3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/z0mjF9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/z0mjF9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c486f012so18474815e9.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783436679; x=1784041479; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNMm+K1n82gXoA0QCvJimYEIEGXjevfFGtDXgwHf6mU=;
        b=e/z0mjF9XYWGTdbiwtPEubAY4mtbV7VRy3+Emoq96IyFgrd+ACF4Z0QVmP3npEOwaq
         lHQhq3h8nh1kK3c+urP3JJ8rlvuhqmAUfF2n8S0yimgtfkAGsiK32azUonCRSYsdn31+
         Ht2t4TJ4MXBRVuc42qT/9mA6Of4VmX3Qoo/Ng166qKxHevuu3tgx+uns58b8QGj0UOWi
         wI1Qxah9ga/yuqXYsitLe4YrO6mIYJn72AaSGgDsmzVNHuWFAzwVdPrpG91/GKq3hPFS
         aCTVNiVMZZEv66ur4ia+a7FMlHEpken1FsCHQmGpz5EtWihXK+PaGR9Qerz4xG3k5Qxd
         6cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436679; x=1784041479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNMm+K1n82gXoA0QCvJimYEIEGXjevfFGtDXgwHf6mU=;
        b=jXW9CUdC+5okiRSG2+Pjo7Q+rg3GLekbQGruHxNDarcBqZRqtkscQxDnEy54IoE1IA
         kU142KgGwPX7GZO+u/o5SR2gJ7VW3945RAF1Ea1vOOClle2lm25K4IWcyaOxKmr3OkeW
         y3j9fE8WDB0fI+oFT5yIsKlpxLOizz4emGoE527XbdnmpqO53go6IWhz/jpLX9DcTLqL
         9GeS4Bv+C0816ADctxWQ81nt85yetctwc/hYPqPJRkMkJG5+NtxM+CjQSpliELskHt1r
         4Y2Fjwq80S5EXA6Va8Wg/72EuPd16NATQKnLf3cG5Vxx+ADRSqqllpRT22T2M0DWz4LR
         cJeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJgtpQ1HmTq5cffWEqtwj4U2qNVOHXQJFyiNNcoLvl1/oWsblVqlwq+085k1dKD4xsjS5Zjl/sPlve1GnUKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9n/RXtGXDsVksOUtn9iR3kxLNAvaCPCXLjw+nFrH6nyxJy8sk
	RCYL0wV2ND3CVFytvvZDwWnNFxCuuEUoQtidmI0UNW9EdV012IoThu8yF5d3klE42jE=
X-Gm-Gg: AfdE7ckXsW3SBMNE8JFhSJ/6PEU7Tn5Lt74xOtdbdz31pIAreNjJqgDtAdNRiwGVqGl
	+mtOrGM2T48EsNtpzSZJi/UGy/dhr3i8+WB1MWClvTEgMSeHy2sZse5TGvu+8paZYPfm7MrS3hs
	uP2EkfoitRrHBJZTzV/oiyMlmO3/jkvcuuvyinDqRLurHz8rzoM9sCZgW2Ku8MDnOkuJ6f0q2e4
	jkQOGAsgMzaiYAMwXmJKZfZVlzSq0pUdbH5NBEmfhIH/lpMYEgggmD/O7hm4sDOMRqj5MB+2CHh
	ujR9T6/NpNbRSJuyz5ybdHXkkUGiG3UjmK/+7tgt8eMj75E1qkOduSqRAAIct661cs09IY2EDI6
	acYCDA54KUsYg62hcGW2WkzQNG1Cwj6vXYzstYnWHvlf3RGXyf+NIAGzJf6wZ2yXRtLp4nqfuyI
	4DAz9UdtvxSx8f4so=
X-Received: by 2002:a05:600c:198e:b0:493:bed6:85e6 with SMTP id 5b1f17b1804b1-493df0711f9mr67136355e9.15.1783436677306;
        Tue, 07 Jul 2026 08:04:37 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294a6sm123915975e9.1.2026.07.07.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:04:36 -0700 (PDT)
Date: Tue, 7 Jul 2026 17:04:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
Message-ID: <ak0VguIf-PxmbUOS@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra>
 <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707145411.53a10893@mitra>

On Tue 2026-07-07 14:54:11, Benedikt Spranger wrote:
> On Mon, 6 Jul 2026 18:05:06 +0100
> Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> 
> Hi Andrew,
> 
> > On Fri, 3 Jul 2026 at 15:56, Benedikt Spranger
> > <b.spranger@linutronix.de> wrote:
> > > On Tue, 30 Jun 2026 17:35:59 +0100
> > > Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > > > The printk_delay and boot_delay features are helpful for debugging
> > > > as kernel output can be slowed down during boot allowing messages
> > > > to be seen before scrolling off the screen, or to correlate timing
> > > > between some physical event and console output.
> > > By now, it slows down the boot process, which is the handy part of
> > > that feature.
> > >
> > > > However, since the introduction of nbcon and the legacy printer
> > > > thread for PREEMPT_RT kernels, printk records are now emited to
> > > > the console asynchronously to the caller of printk. Thus, any
> > > > printk delay added by boot_delay/printk_delay continues to slow
> > > > down the calling process but may not have any impact to the rate
> > > > in which records are emited to the console.
> > > Using this feature to slow down the boot/suspend/resume process and
> > > implicit make printk() happen, is the usefull part of that feature.
> > > Imagine this sequence (which hit me on suspend/resume on i.MX after
> > > shutting down all secondary CPUs)
> > >
> > >   printk("A");
> > >   (do some stuff)
> > >   printk("B");
> > >   read from peripheral --> system got stuck here since peripheral
> > > was not clocked or powered or both any more.
> > >
> > > The delay (and later on a ugly patch to make printk() synchrounous)
> > > helped to locate where the failed access happend. JTAG did not help,
> > > since the CPU got stuck --> no JTAG communication to that CPU.

First, it is great to know that people are actually using the
boot_delay and printk_delay features.

> > I understand the use-case, you sprinkle printk's so you can find the
> > point where a read to a register causes the CPU to stop. This requires
> > that the printk happens before the read, and the output from the
> > printk is printed before the read.
> Enabling existing debug features in the kernel was a good start.
> 
> > > With your purposed change you *may* see "A", but never "B".
> > > Quite challenging... 
> > At present you may see 'A' and you may see 'B'.
> That's correct. 
> 
> > Prior to the changes in this patchset, and assuming an nbcon console
> iMX swtched over to nbcon, so your assumption is correct.
> 
> > (which may not be your usecase, but is perhaps representative of
> > future use-cases), then the printk delay will always happen within the
> > call to printk (and always before emitting).
> Which is quite good, but can be better. (See the missing sync feature
> mentioned in Johns reply)
> 
> > However, depending on the context, that printk call may return (and
> > proceed to your CPU halting register read), before the message is
> > actually emitted to the console. I.e. it's a race.
> I am aware of that.
> 
> > This series moves the delay to the emit side, as well as moving the
> > delay after the emit. Thus the calling code may make progress more
> > quickly, but depending on the context, it may also flush/emit before
> > returning from printk.
> Unfortunately it makes things worse.
> 
> > In my view, with or without this series, there are no guarantees that
> > you will see 'A' and 'B'. And in any case, achieving the functionality
> > for debugging required you to modify the printk anyway.
> The "sync" feature is on the TODO list as John mentioned. 
> 
> > > So please leave the delay on the calling side - it is helpfull
> > > there.
> > 
> > If you want to ensure printk is synchronous, perhaps you could call
> > nbcon_cpu_emergency_enter() prior to your printk, or perhaps there are
> > already printk wrappers that do somthing similar whilst debugging?
> As said I did an ugly hack and forced printk() to be synchronous.
> 
> > Would that provide a more reliable way to guarantee output?
> It does.

To summarize this discussion:

  + Benedikt would prefer to add the synchronous mode before
    moving the delay from the printk() caller to the console emit
    code path.

  + The delay in the printk() caller code path did not guarantee
    the output but it increased the chance to see it.

  + The synchronous mode will be even more reliable than the delay
    in printk() caller path.

Please, let me know if I did not get it right,

John, did you have any plan how to add the synchronous mode, please?
Does it look complicated?

I guess that we would somehow need to "mis-use" the emergency
priority and force it everywhere by some global system setting.

Best Regards,
Petr
