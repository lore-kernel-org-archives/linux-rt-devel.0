Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA930EF92
	for <linux-rt-devel@lists.linux.dev>; Sat, 30 May 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780152869; cv=none; b=r1+xnerzGGpS+lcmBFstLYceKNxFTiYwL1gus+Mu3F7S6slWBKFhYIXKjDvZaoQKOzr3XAG0onKt3TM6UBcFJ2fRShu3mQelotiNPqMvq6c1yOB1GM459oaVQSarA9e0Tmg426W+Uo2mT2oQkJViFSxKNSSM+MPc57AWgbox1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780152869; c=relaxed/simple;
	bh=e9OgB3cKziRcIeud3sL5uUcp7JEnRHS6LgQScHdXw18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf1JdfELaPB0w39azHnLlbvbBc/MbEagM74hs4Vc6SXYS1KZR5XYFks/nmtpQt2XxA3k77PuHg88+lhZPZPxP9a7/SU2Rl6pV6aJKi0BguwXCYMg53azclUMxTJqJKdmhvyweo9Gcz17x+dKQ4/sL+2xTg481b5e4K2riZMti+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=hhResdCT; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="hhResdCT"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1523095eec.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 30 May 2026 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1780152867; x=1780757667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVelvg46s+KIhtR06bw6XwejyY6UiQ+q2yd6BbeS7vE=;
        b=hhResdCTDr5DbURbJ63chwDzf+BuNxQdkNu5pJV8+gC1y+Yw1lGlhAud8aIa2vjCX5
         ry0HnLzverlrY35gLAm39UJ1RHzR090ic1KrOlSDZ1woRq5P17xRv8amhmLPOquWqjq+
         ELzZOFBzMuKv4c/JNlEmehWH01/7eEckYo5HC1Z0atzCwJavP2IcmfL5ptDQpheRkLa1
         nFt1xH/ZUSXlY6lclO9tRLRx4a8xhb98+Xdmiq1p0LljFReaS5jwVfLVbhqUz/HmyemH
         4wCBZD7PfnmsKJIDwswB0ifur9A9b+pyr2p8I9Wyz4M9QDPohe1870lS+3Pqko5L5qPY
         TCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780152867; x=1780757667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVelvg46s+KIhtR06bw6XwejyY6UiQ+q2yd6BbeS7vE=;
        b=fm3YqZBdAqC2rVPBXuvpCQs9iN3NOOXidhC0wWxgxNTEXWvtXh2oQH8ZwLVHrbJKH/
         3fHfiYQH/6Ju3kQOePD+dRN03kIY19IdQ45zrSrug27bExyAEtZShoQ6vWS8uenXg2Fp
         LZ9A4iuBlBHRrXPQQQ+j7Pptkl9ANV3PZwIa6Um/D1KsrGDd2eEzABVEjFWDl/pBwJgh
         n95qeIkZAPVt8CaIRKe1bNP7oeo+0JYUAhLH0MLOZ6IYB3pBUqP3a5k7K/3JawTp1pKq
         8wtTDRgPQcm6FJeMh0DsFvrEhpTI3weCa35ynDvu9KU1xnNJjZuAQ4LFahX9L/9CQn6S
         s7Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/U49leIUOWKOcO4JN675k9HOBm2+wFeeiGpE+g0dZfz/1jW/+2VIzCF3Os0UDWkMBQDIZLy9OMcm5P7mU3wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyibUFWCGwn6V739+usy5UCNahXrk9najsmd/XRbBavLwaL7jsk
	jNw6ddt14F3AImO7hoj1TfUexBspGtqR+8WNUuNLDGdTeLbbhnz5HB8Aw5MhjRrW+hs=
X-Gm-Gg: Acq92OE0jU1bdVzesd4nIVUQcxaBsTB9sq5+HBpEI/PbZx1HI14DTKPAnnC3I5CTGgj
	IFkFVEJgWw8OtmoGTIEabMUh5uz0+hk0AMgova8GNdbherE2mBQMWbLcQDInZU/9LZBpXUTzvlT
	GOnkEzsh4zE3dmwUAZ2vlJbGlQucbJ3y4jbKdOtWz/+veLgGrno1/jIQ+YX3Sqc+xdhDWHyIfcw
	shQm/KPUvroCF5vg2a/Kx832dlpWiz1BJ9vMe34py0G2aD+oWjKUyte/WdN5XaFwl8qztkCMzP1
	97ooR2TjgQJvzqxr90UTcSnzOxBEFDpoNd3kIui1oslcBlZDZXgHp3YY3BXj9hAY6IqyEUhjj77
	LZDU4STtK9PN2Rg32lliKHboyFMOqPrfUrfM+TngoQbcnDHjqZMzAKPaF4BanNuHuHUfJp1lfv/
	8lFYgPFCvu0l0HD9PcxqCOgp7pvi6+uBQtrOM=
X-Received: by 2002:a05:7300:324a:b0:302:8cb5:af0b with SMTP id 5a478bee46e88-304eb1bc29amr3239498eec.13.1780152867209;
        Sat, 30 May 2026 07:54:27 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:5c5f:3906:b87:59dc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53d14fsm4113677eec.17.2026.05.30.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:54:26 -0700 (PDT)
Date: Sat, 30 May 2026 07:54:24 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pps: Don't try to wait for negative timeouts in PPS_FETCH
Message-ID: <ahr6IHpbRRlpTMbp@mozart.vkv.me>
References: <b5241c09ac0dfb82ee076d06367ac6319471c773.1780071212.git.calvin@wbinvd.org>
 <20ed84f3-14d9-4936-b6d1-915ab605b7fa@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20ed84f3-14d9-4936-b6d1-915ab605b7fa@enneenne.com>

On Saturday 05/30 at 11:50 +0200, Rodolfo Giometti wrote:
> On 29/05/2026 18:21, Calvin Owens wrote:
> > If userspace passes a negative timeout to PPS_FETCH, it triggers a
> > kernel splat from schedule_timeout():
> > 
> >      schedule_timeout: wrong timeout value fffffffffff0bfb4
> >      CPU: 17 UID: 0 PID: 4720 Comm: a.out Not tainted 7.1.0-rc5-x86-kvm-00150-g331d97e36b37 #1 PREEMPT_RT
> >      Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
> >      Call Trace:
> >       <TASK>
> >       dump_stack_lvl+0x4b/0x70
> >       schedule_timeout+0xb7/0xe0
> >       pps_cdev_pps_fetch.isra.0+0x93/0x150
> >       pps_cdev_ioctl+0x70/0x310
> >       __x64_sys_ioctl+0x7b/0xc0
> >       do_syscall_64+0xb6/0xfc0
> >       entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > 
> > Sashiko imagines this to be some sort of security problem, which is
> > obviously really silly. But I think it is still worth fixing, so buggy
> > userspace code can't trigger the splat.
> > 
> > Silence the splat by skipping the wait if the ticks count is negative.
> > The current behavior is to return -ETIMEDOUT in that case, so keep that
> > return value in case any userspace code might rely on it.
> > 
> > Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/cover.1779733602.git.calvin%40wbinvd.org?part=3
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Hi Rodolfo,

Thanks for taking a look at this and the others.

> > ---
> >   drivers/pps/pps.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > index de1122bb69ea..6755901fbdae 100644
> > --- a/drivers/pps/pps.c
> > +++ b/drivers/pps/pps.c
> > @@ -65,17 +65,19 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
> >   	if (fdata->timeout.flags & PPS_TIME_INVALID)
> >   		err = wait_event_interruptible(pps->queue,
> >   				ev != pps->last_ev);
> >   	else {
> > -		unsigned long ticks;
> > +		long ticks;
> >   		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
> >   				(long long) fdata->timeout.sec,
> >   				fdata->timeout.nsec);
> >   		ticks = fdata->timeout.sec * HZ;
> >   		ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
> > -		if (ticks != 0) {
> > +		if (ticks < 0) {
> > +			return -ETIMEDOUT;
> > +		} else if (ticks > 0) {
> >   			err = wait_event_interruptible_timeout(
> >   					pps->queue,
> >   					ev != pps->last_ev,
> >   					ticks);
> 
> Should the problem originate from user-space data, I deem it more
> appropriate to verify them directly, rather than relying on computed data.
> 
> 	unsigned long ticks;
> 
> 	if (fdata->timeout.sec < 0 || fdata->timeout.nsec < 0)
> 		return -ETIMEDOUT;

I agree your way is nicer to read.

Pedantically, it's a user visable behavior change: today, the user
can pass absurd values for sec and nsec, and everything works so long as
the math works out to positive ticks (e.g. sec=ULONG_MAX/HZ,
nsec=2*HZ*NSEC_PER_SEC).

If it was just that, it wouldn't really matter IMO, but...

> 	dev_dbg(&pps->dev, "timeout %lld.%09d\n",
> 			(long long) fdata->timeout.sec,
> 			fdata->timeout.nsec);
> 		
> 	ticks = fdata->timeout.sec * HZ;

...the multiplication by HZ could also overflow even if sec is positive,
so I think userspace would still be able to trigger the splat this way.

> 	ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
> 
> 	if (ticks > 0) {
> 
> Ciao,
> 
> Rodolfo
> 
> -- 
> GNU/Linux Solutions                  e-mail: giometti@enneenne.com
> Linux Device Driver                          giometti@linux.it
> Embedded Systems                     phone:  +39 349 2432127
> UNIX programming
