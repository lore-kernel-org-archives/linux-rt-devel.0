Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF813644D1
	for <linux-rt-devel@lists.linux.dev>; Wed,  6 May 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107036; cv=pass; b=r4yfVgUZ3KoCtcxH5M/DruEU6GFug4scfPUVcSvZ4zKQn0O8cCJScAm3vPwKF7mObb6AsvOg2PEP2R01JVQ4O1PtUmiKEU2eFoPTNRM7rQMAM+44HQqDJp5TEI0kmHHY9YL0t3EudN3/7MaBoNxGw3wEDfW8FsvXJyXPYAIkk1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107036; c=relaxed/simple;
	bh=H2wod2e50JqMFLrm5v7kdKyN3x98IfEqxeoiWm4eVfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW+0eGY2pXO2ynV9oIWUkk1g6aQoXVHUryIgL50s5w3epKVb7KL1aP1b9zMkIppXPvveEWrUmrZWnTdT6nvmx9RVt6Yece58Iz+ovBSIsbszZX2W0ZGiOs8NBifkElJtVjlfOxC5Y82YbpfX7RmlULG1sv0uRQFhmxaeNW6v/Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=erHdjvjS; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="erHdjvjS"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6948fb494a0so109846eaf.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 06 May 2026 15:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778107034; cv=none;
        d=google.com; s=arc-20240605;
        b=RdQA2ABlUKsTN6x5IEed7R86exHw9po2EHR93XSnH7bWR54v3HsLZcn6g1g4SadrfH
         k8t/IWnRanDs2YIjs2JxnruusfDotdzwOPnHrDbHVJtmWfPimIAZUpNMouzzau2X4C/I
         xExElroBcXIHQhBlHuiGwH3u5FcDnN81G6axT4WTbz/51ivk2jyl5xYF2giJSVdukHya
         dQtxvCKmRRky49nu9V5d98w+8T7tM6OYMNKjWamW7/LWXbrHsUL3b6x/lQ234KuJAMVE
         DkI3ijjOvxHPHaIAGRlaXY6scIyY9404Ic0feD6c4afvG7xnP/VLs5GBgCSCLXfRutUK
         Re0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O2M9x4aX4d7Rz8hjq9oGfdKv/HBHH7LxpobCw3rVI4o=;
        fh=iwfhbY3yslkL8AkIR/Z+qB9EVJIYAk6id3GviGO0k4s=;
        b=iNNKi2ZsQHbVCiHmSG0/aKo3EtfrGrssMtVbg4aul9hqprd3pEjhWrk8Qi6VGSnazY
         nBq3TV+J0L/AvUw/+quW8uqq1hdDfOetApS93vZU/7b+Dr5F4ODIrxRIfrHhPwF7bt2T
         uLeRf2uuJf3SRbgTNSk8awnEIE1tRDf9YuKVNWjnoEbgbEJolttkC20DMfvO45pLNamK
         humCqQ5YuoBpi0c5CUOEI0OyRmE4iA38UV6oEIar5ygxkcRAYrNtSXYQjGXaZ63YGxrA
         whp+YSJqFXGMepLa9VWTdAQJYFz1IHYbgdNbUSxLfkUBqLn8gPLrJ5mOXu04zetaUTtg
         JfdA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1778107034; x=1778711834; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O2M9x4aX4d7Rz8hjq9oGfdKv/HBHH7LxpobCw3rVI4o=;
        b=erHdjvjSncRmJvkvtbNaHalm9JXUqvoUqGBbgRpVyLKWt7QNt5S0Jv/cZihAyStG+1
         aG/dmrk5PMEsi47tIMSADcoMx490cKurNDylsKKIm+m4uIfpPmswU7rTMBvnGfIXB4+a
         QuWru5SsxF238SPvimNRSlKXQgV1uT0oDFjL7PS6hkP04p1aYNHmBkcTP3NkzP3hVieH
         wrJiRAuOOxicMtxaUJwetQEhaXOkRXaLHrwSEOjf6Z7s+AZC5hZvSZVrPZP0e/0tH3dF
         BUb5ZTZy1xEeCaCuwbaUdUXIQ6CX01PegcZjM9qrcAuP/tpXSfpSM4Y7ayEE4+rU+clc
         vx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107034; x=1778711834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2M9x4aX4d7Rz8hjq9oGfdKv/HBHH7LxpobCw3rVI4o=;
        b=CX4Ql7q4Qn0XGZq8fygfGaLnNXfTfavYt/tja89R5yDDWfWwMvr0sWC1NyHD9+E3kb
         mxC+11Cywjp3hv0p2MdnsQ5Mpomyb5xY2yOeQnOUoIXCF8aZcVndnFERRox3adJsC4Pz
         j6tntfB1z4JC/2tjM5YodO/Ts+55fkgHejvvPASNqavsx39Ru0kEBBPDRpNYES1ljRWI
         4zb9+00jeBmnZ7TBt1WPyUOSiWqmQ/IbE8OPlDVNTm82vNZvKVIQ9BoTSRE2XZP4djCf
         6UX3ylU/NxWdpUWxS9FG0yOJhq1p9BFZa2P5xPvtlnSpTn6tQHZf+kPrEiBAdCfPZvvD
         izsw==
X-Forwarded-Encrypted: i=1; AFNElJ+7ttmR+vQNS+Zt4pWcOTMyt4EouelD51nXKbkhbSI3Ebg4Q/A+wHxhTWq9HfKVuIzGtAFXwe48DFZCUvUXZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqVyK/RIZ1Wwhg/DXbOUMQTYxMx+M0wT2EsvKCpnr++IvbKjtE
	rkgkIvgtzIDpXgBXyanMn1Wid27oUSfFlrQp5BWqC8pdX03PHRAqNj8716bCctK+4wX1kuRpLI/
	W7JriVguDDg+0Z+WiYBpBd/Nj5Y0uZEJb9PpkonSh8w==
X-Gm-Gg: AeBDievB0P4MSH4OEDSI7mnjO2rjwB5mZR6XpGzhtnXQrWnK6Wlvtqd28eJKZgbvO0Z
	MKaHCIgK0V8kXbEzUwqzQMcb558EVA5RFBv+KFizHt4F6hNHunKoeqd966v6f5sV3X0PjTV6UG3
	gV+Zvn9JJ7Gf6AKArpS1z/yGCDHqZXPBJvMpMIsObEnuse6SjBspw5t6kYwQAwk4xpwNQKyh4zd
	DcZf8GIy94l7HBtIGOneIYeWyrCTM0/o9Up6YwYP9ID4R+x5kneKI+5gG13255Hr4ztTEQhvFwW
	Y6zKnRg49Z8DTw0/gX1BcIh/yxc5JwSN+btamV9eyMJ/uiXx++RRHO9GlM4/+eAtGF9AL2W/G+x
	mVljSxi3GAf2IBqjPkbWhyUMg6UEJ6ihu0QlvXEdLl6doupD29A==
X-Received: by 2002:a05:6820:4c08:b0:68a:e01a:9b99 with SMTP id
 006d021491bc7-69998d4fdfdmr2825460eaf.50.1778107033777; Wed, 06 May 2026
 15:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260505-printk_delay-v1-1-5dba51d7f17c@thegoodpenguin.co.uk> <afn-H1EQJxnDs0BZ@pathway.suse.cz>
In-Reply-To: <afn-H1EQJxnDs0BZ@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Wed, 6 May 2026 23:37:01 +0100
X-Gm-Features: AVHnY4Ja58VfipZT-8soAZYnzo0HXiglj_UpI9Yp8PzxiCF3zB-23LSxITGGZYE
Message-ID: <CALqELGxhXO=kzh9bpztd9=Ug9ykPL2NALo9Apq3=Oj6aeiEcKg@mail.gmail.com>
Subject: Re: [PATCH RFC] printk: remove BOOT_PRINTK_DELAY
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Clark Williams <clrkwllms@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 15:26, Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2026-05-05 14:45:00, Andrew Murray wrote:
> > The CONFIG_BOOT_PRINTK_DELAY option enables support for the boot_delay
> > kernel parameter, this allows for a configurable delay to be added before
> > each and every printk is emitted. This is DEBUG_KERNEL option that is
> > helpful for debugging as kernel output can be slowed down during boot
> > allowing messages to be seen before scrolling off the screen, or to
> > correlate timing between some physical event and console output.
> >
> > However, since the introduction of nbcon and the legacy printer thread for
> > PREEMPT_RT kernels, printk records are now emited to the console
> > asynchronously to the caller of printk and its boot_delay. The delay added
> > by boot_delay continues to slow down the calling process, but may not have
> > any impact to the rate in which records are emited to the console. For
> > example, if delay_use is set to 100ms, and the printer thread has a
> > backlog of more than 100ms, perhaps due to a slow serial console, then the
> > records will appear to be printed without any delay between them.
> >
> > It would be unhelpful to add a delay to the printer thread, and it would
> > not be possible to disallow selection of CONFIG_BOOT_PRINTK_DELAY at build
> > time as it's not possible to detect which consoles are nbcon enabled at
> > build time. Therefore, let's remove this feature.
>
> Heh, Randy proposed to remove "boot_delay" few days ago.
> This RFC goes even further and remove both "boot_delay" and
> "printk_delay".

Apologies, I didn't see this. I'll co-ordinate with Randy.


>
> Honestly, I do not feel comfortable by this. The delay seems to
> be handy when there is only graphical console. I would suggest
> to do:
>
>    1. Obsolete "boot_delay" with "printk_delay" as
>       proposed in Randy's thread, see
>       https://lore.kernel.org/all/afn2sYKKsqG4QBVX@pathway.suse.cz/

Your suggestion was:

" 1. Add "printk_delay" early_param() which would allow
     to set "printk_delay_msec" via command line."

And I assume the intent is to replicate the functionality of
boot_delay, by allowing printk_delay to be used to introduce delays
from early_param time? Thus deprecating delay_use.


"  2. Modify boot_delay_setup() to set "printk_delay_msec" as well.
     In addition, it might print a message that it has been
     obsoleted by "printk_delay" and will be removed."

Given the intent may be to deprecate boot_delay, I'm not sure that
setting printk_delay_msec as well would be beneficial, as this would
extend its functionality to add delays beyond SYSTEM_RUNNING which is
where boot_delay stops. Unless you mean to use boot_delay as an alias
to an early_param hook for printk_delay?

It seems that there are also differences in behavior between
printk_delay and boot_use, with printk_delay unconditionally adding
delays to all printks, and delay_use which considers the loglevel.

With this approach, existing delay_use users will have the
inconvenience of having printk delays post SYSTEM_RUNNING. However, as
this is a DEBUG_KERNEL feature, maybe we don't need to preserve
behavior. Additionally, with the proposed changes for moving the
delays from printk time to console_flush_one_record time, the impact
for an uninformed user isn't as drastic.


>
>    2. Move printk_delay() from vprintk_emit() to
>       console_emit_next_record() and nbcon_emit_next_record().
>
>       For nbcon console, even better would be to use a sleeping
>       wait in nbcon_kthread_func(). But it would need some
>       changes to call it only when a record was really emitted.
>       Also we would need to use the busy wait in
>       __nbcon_atomic_flush_pending_con().

This makes sense.

If the use case (in a post kthread printk thread world), is only
relevant for graphical consoles, then I do wonder if printk_delay and
boot_delay can be replaced with a more specific solution? Now that we
have printk threads, the time in which a printk is presented to the
user may not relate to when it was created, and I fear people may
continue to debug issues that rely on that assumption.

I think the most pragmatic solution for now is:
- Move the printk delay to the point where the printk is actually
printed (e.g. console_flush_one_record and descendants)
- Add an early_param to allow for printk_delay_msec to be set
- Deprecate boot_delay, by using it as an alias for setting
printk_delay_msec, and include a user mesage that it is being
deprecated and that it now extends to beyond boot (which could impact
performance on non PREEMPT_RT and non nbcon systems)
- Update printk_delay function to use the appropiate mechanism to
delay based on stage of boot and using printk_delay_msec instead of
boot_delay.

If that makes sense I can fashion a patchset.

>
> IMHO, the only drawback might be that the delay might be multiplied
> when more consoles are registered. But I would ignore it. People
> would use this option only when the graphical console is the only
> one. It does not make sense for serial or network consoles.
>
> Best Regards,
> Petr

Thanks,

Andrew Murray
