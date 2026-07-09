Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8931328C
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608547; cv=pass; b=E5i3pYhOzhzta65WNe4LhdOI0b37pMe/lts6+UDGRxFtAgNqbgLWEAROtIUcFLY0ILwOIutHcI8o4GLQsDOfA+QX1Z93uqWA9pxGVHKjirtSPNHuuKNvZBqHLCfpEsuIqG49Bx03wq/k9XVRMn6ZMpdHD//dvvqLrxYpSp4zdaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608547; c=relaxed/simple;
	bh=Sk6RankvhH5IPrjCp/mMpqfpvlNX0Holpo+rbRThvlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdfbtBdv/8zRwJ9oyQV+kCTkjoCu9gzX6WqHu4iEFILbUfzUS8mW6p+CX5A9FeFNohPT+zZC8+oRyyJq/OgoLfe5+0hricz72fbPzJ7GpTHxmzdJvYvfOh475B05cchbuS82L3fVCgucoJ4YmomV6La72psCHHrSpBe52y+Snkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=tLeEg8LY; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="tLeEg8LY"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so1047064fac.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 07:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783608545; cv=none;
        d=google.com; s=arc-20260327;
        b=JuSqIM2l8WOqLAKYaw1eJqIVLd8b8O+SUpUToEcxats44boVqmn00Qt97Gv9cjkAAg
         uW3GJREtL35RAxoVMnV7Xkqibp5pQlhuaAHcaefwfE0U5fpW9wDzh12StT2R2rvvjb/i
         zXhLMbI7ifHNOWcdOi21GWcAPlG5V+hpTKzUgKmOHxC8SRYrJU6MrFkBMHK6g4D+9C3W
         /iwCraAe6dNB/28Xcnu3/d/ZDJ60LOo2nsHb0W7OXOhdAGmamcAUp0lClo9lmlvpb3ml
         jgKgIbVId1IPxV/zlMtm5k+hKpDQANpbIRG9nuvkfZ6sNHm8/oOxFyd5llX6S4ZalW/k
         oUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MYS2uTBqKgSrer77DXZbILY3qQ1j4rYV+efL09YAvE4=;
        fh=XrLAZQ8YmBGzuYjbs3J+/tURQmRHJfTXw2HhQbRdNjc=;
        b=NXA+lSS0ZfevYTSFGrnShA9ID1YOmfbH0OR+s3RFsmWophBo4CNcxRTEjTjl58CpEk
         VQyIja/ww3b0thDpLClRHsed660xzUIiMjXil71Pjru+mf1BegWKdqxswWS0I9OIn2bS
         Ay/Msnr3q5N8qXnu26krb5S2j5P5SMdPnqqgLJIooN0k4dWrTBZwJ07TTkaMKT1eLk5X
         jsBgvxPFNs5xTKdovMZ7f7DmShlQxNMg0Y+lG9gL3aH1kUYUBhhrDxSt1ijNSmYxqdiD
         05a3rpNmab1iF6V3jV9ApQV82loIdhnIKcaon00xLrIV5cAa+XlOGoo7g0fVvvT+y9vH
         nmig==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783608545; x=1784213345; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MYS2uTBqKgSrer77DXZbILY3qQ1j4rYV+efL09YAvE4=;
        b=tLeEg8LYBGbgojGLQ/PrW1PYyIvxFcvtb+naEWLwWWxudhj9Wop94okDCdWbcseWmg
         57jzvJbsLdxKDqkqBgFOXx6q+mCGT8sG/iaA2vLLaOyEpAVl7YaDfjUTihbQg5wsvhEV
         amATCa75PiDYQ7JoQIhJrVfJrpitnoeb9PBvFtZ0odjOI2W1NcmaZxv6PYx9LMWEcSUV
         n4Bq+NwOeamdWpFq1rrIg04Au69SY/sSL9H/vYxNEpRTyx0vxftX//HVPE3jlZHKWNrV
         D0E2rWgNCoMTd7uS3s7LefoHHshxYH09tPUnBALqSohi/ZSrn4JxfSK+bjV4B4In9zwJ
         TeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608545; x=1784213345;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MYS2uTBqKgSrer77DXZbILY3qQ1j4rYV+efL09YAvE4=;
        b=Aw7cBzE/Qrijks73PPLmQihQhniyaFCbDQY/tfG4N3B/ea+Kcje2mFwBcb5oYB4F/O
         WVeWK5D1CrGsMYyHIR3lyAJKflwyRgYcRzJFfaSKn3CAAty9Uri0GMg5R1J89qKPBjbt
         EJYKn8peYeJonRCAbV07lZ99MnnyLuRaBd04CsGEHfM7u/0G3Lm5st61livItrESvmZi
         iKkuXBAfxFFRVZRHHY4dvydWXGdfXO/gyiAeuJ55OEH6vYO+7neyj1aFmILiq3qgfeLA
         DVTkqIoIwsB2IMNpcWn+Emm/V95ZZgSiFArPgdTs+DTzjskEAAaX5aiYha9xG7oSwlq+
         TPow==
X-Forwarded-Encrypted: i=1; AFNElJ9XAka8hM1H0uj8o4Cd1EaOaGv8myPYredHJI6UIaYAEhXWqTc7FCuqmFZ2DodmmJlFEePMZcOFaqK4T/o1Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI+knOUhG9Oun8mJtO2NVKEdXXNprOXxsmg1ZdbXahBBYil1SO
	p4uHcDklQxuxPKeaRyxRaUJuE9L8+kJT4fgAi9GaGdJOO3Z6Cx9s4NhlnsUWBCeSWpPo6oh4lSx
	WDX9oYdIfaj1jpoq6iwC4A0gr+zUkgxyA+b3AHVGVrA==
X-Gm-Gg: AfdE7cmwG1h99rgkgVWx1gRsv15GJDpt6wtpAi+9c9Tzsd33/cW14hIDOVX2FTasX11
	or1/lIC+5jdIEOWvZD3ypPZopIxCHOvyIOTp9YA3as7EM4qQa7pRsGRr4gekd3AgJ9Q1YMXSqpu
	G//W0O6akXQbQNIQNA161fYPK1NLhNDGgLcqckPpSzOHj8JiEVq/X1UvIOiUwjbytxONedqWKmp
	E+HOcrTNyDMk/b4gUZVVMz6SU32G4ZL0uZ1MPou7/fPXngTACUX5DhDCeQl4p2VOu5+LqJp/JOo
	ghbUbSvwrI8AMm2zh44HvKfENqmz4VVOjeChvyJiADTpSy4wjGqspvMOCgZcoQXpG5LNMMR93rY
	yQVcL/AEW0KFSE2E+3xtsjjpJ4R0j
X-Received: by 2002:a05:6820:4b91:b0:6a1:87d1:402a with SMTP id
 006d021491bc7-6a36d8db604mr5711492eaf.20.1783608544960; Thu, 09 Jul 2026
 07:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk>
 <ak5mPxUdp2pzCMt5@pathway.suse.cz> <CALqELGxjTZAXEp1C1CNO2tLbUpUChZW3DHcNgyhEu4Ma-ct2ow@mail.gmail.com>
 <ak-vqrSr7NLCkGQw@pathway.suse.cz>
In-Reply-To: <ak-vqrSr7NLCkGQw@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 9 Jul 2026 15:48:53 +0100
X-Gm-Features: AUfX_mwJgx6F5Vn2HOCATKNy1ql8ixFyCz9Yy1yVyKHgtQVtX5Yb7ZaDGdYvvFI
Message-ID: <CALqELGyd0UQu2T=odSG6eavnzZ6bmJVd4VKo3oAVTyRpkkSRQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] printk: deprecate boot_delay in favour of printk_delay
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

>
> I would change this to sizeof(unsigned int) as well.
>
> >                 .mode           = 0644,
> > -               .proc_handler   = proc_dointvec_minmax,
> > +               .proc_handler   = proc_douintvec_minmax,
> >                 .extra1         = SYSCTL_ZERO,
> >                 .extra2         = (void *)&ten_thousand,
> >         },

OK.


>
> Otherwise, it looks good to me.
>
> > This makes the cast explict, verifies the range before casting
>
> Yup.
>
> > (I guess a range of negative values could result in a postive value
> > within the 10,000 range) and also uses the correct proc_handler.
>
> IMHO, this should not happen. I have never seen int smaller than 4
> bytes. If I count it correctly, positive numbers should be up to 32767.
>
>
> > This has the side effect of not showing the following pr_debug for the
> > lpj calculation when a delay is not set. Though loops_per_msec is only
> > used during boot, so I don't think there is any loss here.
>
> I agree that it should not harm. But please mention this in
> the commit message.

Yes, sure.


>
> >         pr_debug("printk_delay: %u, preset_lpj: %ld, lpj: %lu, "
> >                 "HZ: %d, loops_per_msec: %llu\n",
> >                 printk_delay_msec, preset_lpj, lpj, HZ, loops_per_msec);
> >
> > Can I keep your Reviewed-By with these changes?
>
> Feel free to keep it. That said, please put at least the change
> of the ctl_table into a separate patch. I would rather put both new
> changes into separate file. It is never a good idea to hide
> such changes in a complex patch which mostly reshuffles an existing
> code.

Yes, that's a fair point.

Thanks,

Andrew Murray


>
> Best Regards,
> Petr
