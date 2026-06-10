Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257543D4ED
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Jun 2026 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106520; cv=none; b=ZYp5Uk3B+jaA7tRdDxcz6OQ+Ddu6A1+Zs6BuHfrJwGEg6sxtCiQpfXFgD7mgvPeIFRdeGxV1/zwu68mkKrgRUnbJxIJKgtp1UiS/eDACZCSpAT3F8HSPSZ+CBUNOtXnqO+vgUbw6wcVv8HehtlMVTeAYuI/ObYOf0FgJOWLcgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106520; c=relaxed/simple;
	bh=S3KAhpf4xujIbCA3wC4jg7ZR7gt0eH2uJ8Y7pXZd/vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzoI9Xvz1DCumbbuQu03jJBkwfl01eqsyE+uxk74Tb5ZWVQi8OxnOIzSQWOXiTZZOwq4uGmu/juVfu36R6qMenixirlCev9iHEHKE/JsZNLYszxhnu0arLRB6Liihjl2rPCbeJCgnnoS9rxsISQ+Tq1X6Lk/mSIugo2aOsaIoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=CGGEGqBD; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="CGGEGqBD"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3074adb8fcaso855699eec.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 10 Jun 2026 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1781106516; x=1781711316; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYvKr4nak3jtm5t4zlYpeWn3sAcIPq6YcBo6UMsGgP4=;
        b=CGGEGqBDbeYT8jcEiTtiFUUwd4oMr3rUVUM42UyPHmxd1i2cR9guxALAlB+MGKzPwy
         Etl1QSqGylZjFJ9AY/efh0uPjisYQaLxsoLljqDhpsx8gSH78ALsymN4mh0eaWW6uAO+
         ggnx5HIpQ2ZDukJWdGq3FumsZHAg5se//FWqqT/OwLWMIQPMW6M1XmONM/76iD4wxRoQ
         AwiXdnoWJAIMTc46hExbSIljVVK7HzlZGcyIOqWmdu1JYSktAPyw/3/d3Jrff2bYsRsa
         XfA51wt5V3nPATUbcYaOruHnnBtxUlg3spEUFnhtHwZ/qhli99Z5cnvEPLLJ1k43p9xC
         4gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106516; x=1781711316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYvKr4nak3jtm5t4zlYpeWn3sAcIPq6YcBo6UMsGgP4=;
        b=euNHcqgEOCVVxFBReeOucgCXgy1vB6Rb4/0do0L+qbQyJCgeY7DrtwgtIWCsskNV3Y
         d6azuk79pNl76rhu6jrddnUyYNoqqR2lMoWA2EckrboIxviiKLCM+FmEu4Frt96ofbZu
         MsNa8tKkFP/FwRUBL115Fqgt4gQJXB1Ce27nuzeKhVVUFzvA0KfBUpg+FHOJJfr9AcFx
         Z0c7ALp6SP57H1f8aMQq50J7RLAeOmdhE2esIpzYwsHckO+HZEBoTz+g2635dVY/WhY1
         4jAy/qLrQbcVTYzBR4kyQ5NH43QyAm9yR9BRAP6qtp//QcfyWwYQJYhbgdW1fKIGxzIX
         Q22g==
X-Forwarded-Encrypted: i=1; AFNElJ9qL4gfGa2NjJ3K4vj/W0aYazjP8X3RchzPCpZROta2j5M4Kj2U8aQCLHK0iR1aFYfP7AzlBTnHBklztmevSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwgM6PJhKKi8Ts+AK3qMCdkAgaNuDWCj6KeU6NQcBMhFbLvcy3
	d1Sx99mIp9mvV28xstO4ZDUHd5iUaNw8ZfhEEFnfuVxM+oMfXrr3Ztxygkxu21wTFYw=
X-Gm-Gg: Acq92OE2wAMU/2G15A6G0zFApS2Wcr6YlU4quv0UE3hubfRkuNWLN1et1e+ywIvpwy2
	f6s2GeHZws4wplkRcbowihrJov7YexGTa3tJ0ayeReu/fQSYylocvKzCW3MQm2l9nxKU8DfJ8pd
	QGdZl5+d+carxQmX/P+bYYJ9iFnF2SWrfUkC07F+gd2/21rU/6tnsuTsOWpd/HqVdDEdVSFh39A
	pGS09UaCsm7RVmrTOREoZ64mZbO7dWqwhlSJSGjNskOnYIAOt2tuyGTiVdxtcTGkD9wMR3jhygC
	J5dhttn4ocZze60jGQXrB8rjyl42ip/aiKtdVczhmIk5TorrESoLFFK9sp31Z0Kjv0HP94sqBeC
	JAOLuUr6w0UDczNKXvWkcitteC4iZB1gZwl0wzUVUBihtW2KVv/O1ejH7HNHQdTvJ7YhwxXCRx7
	gkx+2p6iUmPa66b1kIlcGU2Rk7eZ/5P/fHamA=
X-Received: by 2002:a05:7300:3250:b0:2f5:5dd3:1fd8 with SMTP id 5a478bee46e88-3077aea9ef1mr17051622eec.8.1781106516402;
        Wed, 10 Jun 2026 08:48:36 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:375a:a215:7d4e:6ae])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8708sm27747706eec.15.2026.06.10.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:48:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:48:33 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pps: Don't try to wait for negative timeouts in PPS_FETCH
Message-ID: <aimHUam6s3j147-A@mozart.vkv.me>
References: <b5241c09ac0dfb82ee076d06367ac6319471c773.1780071212.git.calvin@wbinvd.org>
 <20ed84f3-14d9-4936-b6d1-915ab605b7fa@enneenne.com>
 <ahr6IHpbRRlpTMbp@mozart.vkv.me>
 <ee1b67f4-1627-4999-be4e-e21ac2dff9dd@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee1b67f4-1627-4999-be4e-e21ac2dff9dd@enneenne.com>

On Monday 06/01 at 09:04 +0200, Rodolfo Giometti wrote:
> On 30/05/2026 16:54, Calvin Owens wrote:
> > On Saturday 05/30 at 11:50 +0200, Rodolfo Giometti wrote:
> > > On 29/05/2026 18:21, Calvin Owens wrote:
> > > > If userspace passes a negative timeout to PPS_FETCH, it triggers a
> > > > kernel splat from schedule_timeout():
> > > > 
> > > >       schedule_timeout: wrong timeout value fffffffffff0bfb4
> > > >       CPU: 17 UID: 0 PID: 4720 Comm: a.out Not tainted 7.1.0-rc5-x86-kvm-00150-g331d97e36b37 #1 PREEMPT_RT
> > > >       Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
> > > >       Call Trace:
> > > >        <TASK>
> > > >        dump_stack_lvl+0x4b/0x70
> > > >        schedule_timeout+0xb7/0xe0
> > > >        pps_cdev_pps_fetch.isra.0+0x93/0x150
> > > >        pps_cdev_ioctl+0x70/0x310
> > > >        __x64_sys_ioctl+0x7b/0xc0
> > > >        do_syscall_64+0xb6/0xfc0
> > > >        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > 
> > > > Sashiko imagines this to be some sort of security problem, which is
> > > > obviously really silly. But I think it is still worth fixing, so buggy
> > > > userspace code can't trigger the splat.
> > > > 
> > > > Silence the splat by skipping the wait if the ticks count is negative.
> > > > The current behavior is to return -ETIMEDOUT in that case, so keep that
> > > > return value in case any userspace code might rely on it.
> > > > 
> > > > Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
> > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > Closes: https://sashiko.dev/#/patchset/cover.1779733602.git.calvin%40wbinvd.org?part=3
> > > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > 
> > Hi Rodolfo,
> > 
> > Thanks for taking a look at this and the others.
> > 
> > > > ---
> > > >    drivers/pps/pps.c | 6 ++++--
> > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > > > index de1122bb69ea..6755901fbdae 100644
> > > > --- a/drivers/pps/pps.c
> > > > +++ b/drivers/pps/pps.c
> > > > @@ -65,17 +65,19 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
> > > >    	if (fdata->timeout.flags & PPS_TIME_INVALID)
> > > >    		err = wait_event_interruptible(pps->queue,
> > > >    				ev != pps->last_ev);
> > > >    	else {
> > > > -		unsigned long ticks;
> > > > +		long ticks;
> > > >    		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
> > > >    				(long long) fdata->timeout.sec,
> > > >    				fdata->timeout.nsec);
> > > >    		ticks = fdata->timeout.sec * HZ;
> > > >    		ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
> > > > -		if (ticks != 0) {
> > > > +		if (ticks < 0) {
> > > > +			return -ETIMEDOUT;
> > > > +		} else if (ticks > 0) {
> > > >    			err = wait_event_interruptible_timeout(
> > > >    					pps->queue,
> > > >    					ev != pps->last_ev,
> > > >    					ticks);
> > > 
> > > Should the problem originate from user-space data, I deem it more
> > > appropriate to verify them directly, rather than relying on computed data.
> > > 
> > > 	unsigned long ticks;
> > > 
> > > 	if (fdata->timeout.sec < 0 || fdata->timeout.nsec < 0)
> > > 		return -ETIMEDOUT;
> > 
> > I agree your way is nicer to read.
> 
> We can also do as follow:
> 
> 	/* Canonical validation of nanoseconds */
> 	if (fdata->timeout.nsec < 0 || fdata->timeout.nsec >= NSEC_PER_SEC)
> 		return -EINVAL;
> 
> 	/* Preserve historical API behavior for negative seconds */
> 	if (fdata->timeout.sec < 0)
> 		return -ETIMEDOUT;

Thinking about this a little more... code in the kernel generally doesn't
try to enforce tv_nsec < NSEC_PER_SEC from userspace today.

I think nobody cares: let's just not worry about tv_nsec unless you
really think a real user will care.

If it's worth fixing, it ought to be done more systematically throughout
the kernel, I feel like adding the check in random places makes the
situation more confusing overall.

But again... I seriously doubt any real user cares. I'll look into the
history around this a bit more, but I'm very disinclined to think it's
worth the reviewer time to try and push it more broadly...

This KC code also depends on CONFIG_HZ_PERIODIC, which no distro ships,
so any user must necessarily be building their own kernel.

> > Pedantically, it's a user visable behavior change: today, the user
> > can pass absurd values for sec and nsec, and everything works so long as
> > the math works out to positive ticks (e.g. sec=ULONG_MAX/HZ,
> > nsec=2*HZ*NSEC_PER_SEC).
> > 
> > If it was just that, it wouldn't really matter IMO, but...
> > 
> > > 	dev_dbg(&pps->dev, "timeout %lld.%09d\n",
> > > 			(long long) fdata->timeout.sec,
> > > 			fdata->timeout.nsec);
> > > 		
> > > 	ticks = fdata->timeout.sec * HZ;
> > 
> > ...the multiplication by HZ could also overflow even if sec is positive,
> > so I think userspace would still be able to trigger the splat this way.
> > 
> > > 	ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
> > > 
> > > 	if (ticks > 0) {
> 
> We can do as follow:
> 
> 	/* Safe conversion using standard kernel API */
> 	ts.tv_sec = fdata->timeout.sec;
> 	ts.tv_nsec = fdata->timeout.nsec;
> 	ticks = timespec64_to_jiffies(&ts);

Ah that helper is nicer, thanks.

This plus the (tv_sec < 0) change should be sufficient, I'll send that
along soon unless you reply that you want the tv_nsec check too.

> 	if (ticks > 0) {
> 		err = wait_event_interruptible_timeout(
> 				pps->queue,
> 				ev != pps->last_ev,
> 				ticks);
> 	}
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
