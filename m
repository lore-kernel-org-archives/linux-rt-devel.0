Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C94657E0
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520784; cv=none; b=RhTeQcjGyKWnD9LAu/WL3w85SBA38qM6EcrpbzcLuxFVxca9vyy2lLaAymlB9xATcAYvwUux1932fjIWrvXXTbPjS8JHzXIAcGYf9EApzeZ1HH01Jc9zkpQE1RATdfpk6HzDeuwe6/n9LJiIyaxc3b7AE/r8BQqzRTXDSrrugO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520784; c=relaxed/simple;
	bh=uuOvnq1jqJcyHqom7LOWBjJv/hTzGqurf6hJE/afojM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz0b/GRFJquRa/4cR8tXLFQks7OVlIfhrLdOTC8CBr3BPvUq53aNcZ+YMV4uMom83eHXfEwa9kaSABWKHYoE0OGQFbw3YDpD7nZz0T5+YXUjhD/uN37dHcRblY1sHM/bzA6k8dhLq1R95y7JpWk7MNVZuDIvciofcPsOhVVCCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hEWz8Wbl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hEWz8Wbl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b7612475so6536335e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 08 Jul 2026 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783520781; x=1784125581; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+2oxnA5/005eAPx9+D3ISlHqx+7lNA7OCwPVcy4+pQ=;
        b=hEWz8WblGH4dBWpujp7YbscsICNK1ZeVpl3c2Pcr3ShGWds19elifxEPPQ/+0nvA64
         ue9EYKBKzv1tgSlstZzgP0H0keKxK7pipZVG8D0yszOu6USVsz5lUSXEcawgjJZ3H3ej
         QyDblEuaemIc1uz9ePKZqlfVTQn5CT0LIAW8Lm4IblechBRUnumoYaigX56QOlC92fdq
         yu4Ph5BEDFfhOQT9PwiQZ+cZH1WLOEXr1wD/EqHCrno8swRjLsP/ZmTeXtcvDiik873w
         SorpWeaSls6vefaM104D2iStnfUg270f8EgvFOKenmgZJMfE74mY1xqNkBIxLmAZ+N0G
         iJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783520781; x=1784125581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+2oxnA5/005eAPx9+D3ISlHqx+7lNA7OCwPVcy4+pQ=;
        b=V0UYsQ23OTIgaTQB31z256S0/YX+qsIU71COpQvDB/DnYJGv3ztXpMN73HJKRRPDDQ
         39nPWHuxuxcEgm+mdXOZnoJfDI7IAHQpCOcZthVma+kzl9sc4bFymqVDy8lrv93ha88v
         69wM/Ro2uD2YcLy0+KtRctcYMeDrAPa8gVWTWcS3TylQUd3AaIpcvNXPIhusSMt5MarU
         l0b0KoE/03P2P6udHfJ6Jo3Kv/BHk9DwXMEo+tKZIOPvfQtQctHD68y0Hkafxz1Wnr2W
         KE6kCzVDRzfmD2ETTPURUE7x2G75/mT7rWeyYYdIjTDm5yaI1hHExdpGZQpALXiaXll0
         Ptkw==
X-Forwarded-Encrypted: i=1; AHgh+RpazZ8OLMC7DRbavJ8GZqgJHxhi4LXX/dLpVoIMLaEfefJEztjeNCQ2f66ioVnQpsPzj7p+0wPCpwr43NsfeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWxYblsMzCEJfUlwND2J1he44tSZQ0dnKKhMAWYxlhDajr45Za
	uuyoGWrxuzpwXCzchxjIfVOq1OJFhOampVu+PkpmeWXwGGt289WasnkdC6sfxDQCX4Y=
X-Gm-Gg: AfdE7clWKCPdSc9MNXRFDOEecVQDrvZYvebAA3ono33vod/HX0DrYcbk9rQRzWLRKyM
	0CtXEpajUwYXKL0DjmQXMTzeKDawJDvn0epiL4NNd8fuv/BxmBlPRJstG4k8RY34mCJySFhrggX
	VkcszxXmSQlLnapqZpk0keaWGmdnO/nX24u48Is57sBLygxkppCRHwdKEtUfVlJ3M0HWjHVnw6R
	fvcVSJ/vDy6kwtBlyUGfQDAgTZ1zOrGeq0TtDNpIcR79sHyrgAoE0vzISxnCPgQoyblIjbbyAsQ
	vLLiYuLmJFDunCAWckLy9q4NBeQuxrJ7pKojsmunuGPSk6YcYAm3wABoJDun0fZvhb++Be5qezR
	PGcPodLmBBFWNpg9l2mYXXyuaQEd1eJOqZOS8HijKMnORL4BtMQbMxqaWAGlEHGc90ROeok8SXh
	GNQJ+myxjJtE3HWDk=
X-Received: by 2002:a05:600c:4e93:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-493e67f7c3emr28578075e9.0.1783520781102;
        Wed, 08 Jul 2026 07:26:21 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5ca1fsm153295645e9.15.2026.07.08.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:26:20 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:26:18 +0200
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
Message-ID: <ak5eCp5qw9LYrnAH@pathway.suse.cz>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra>
 <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra>
 <ak0VguIf-PxmbUOS@pathway.suse.cz>
 <87qzldvqpm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzldvqpm.fsf@jogness.linutronix.de>

On Wed 2026-07-08 10:25:17, John Ogness wrote:
> On 2026-07-07, Petr Mladek <pmladek@suse.com> wrote:
> > To summarize this discussion:
> >
> >   + Benedikt would prefer to add the synchronous mode before
> >     moving the delay from the printk() caller to the console emit
> >     code path.
> >
> >   + The delay in the printk() caller code path did not guarantee
> >     the output but it increased the chance to see it.
> >
> >   + The synchronous mode will be even more reliable than the delay
> >     in printk() caller path.
> >
> > Please, let me know if I did not get it right,
> >
> > John, did you have any plan how to add the synchronous mode, please?
> > Does it look complicated?
> >
> > I guess that we would somehow need to "mis-use" the emergency
> > priority and force it everywhere by some global system setting.
> 
> The synchronous mode would rely on the driver being nbcon. I envision
> something like this:

Thanks for sharing the code.

> ---- BEGIN SYNC IDEA ----
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1200,7 +1200,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>  	cookie = console_srcu_read_lock();
>  
>  	flags = console_srcu_read_flags(con);
> -	if (console_is_usable(con, flags, false)) {
> +	if (!(flags & CON_SYNC) &&  console_is_usable(con, flags, false)) {

The dependency on con->flags means that the sync mode can be entered
only in task context where synchronize_srcu() can be called. It might
be good enough. But I am afraid that people are creative and would
like to have even atomic variant sooner or later.

Also it will do the flush in NORMAL_PRIO which is good. But it might
fail to get the context ownership when it is blocked, for example,
by uart_port_lock() which might be even sleepable context in
PREEMPT_RT kernel.

>  		/* Bring the sequence in @ctxt up to date */
>  		ctxt->seq = nbcon_seq_read(con);
>  
> ---- END SYNC IDEA ----
> 
> BTW: The sync mode is the final piece so that PeterZ can start using
> mainline code for debugging by serial instead of his own workaround [0].

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=debug/experimental

I see.

Best Regards,
Petr
