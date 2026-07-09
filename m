Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864636B06A
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610881; cv=pass; b=Lz4+lyj5G5XmapTpUa67R5BTcKg+mqkjyC1E0h0FBE/e23KoQsmftm5gXhvTMsWffR2Pv1CNaxvnvFygEgvMEOUIyhZL2Gh3mByNHIFnLidYzbSWZD6qSuLjOlRvVmfF93tXIsN6BkDUvj+1hTJIW641/VC2acgHDagSWPBpPN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610881; c=relaxed/simple;
	bh=21RPxRc4cmI9WN0jYw1wxAhXRKd+dQO6mAAvwxMOeQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5YNgOrLuW6hJmWDLdzl25+rxa7rDrYsJWvuWLXAMWD2QNgVWAvFiuk3jTTSey2kwzK2a3tNsn0AQtVVA/LEmdGYaygmFK8kT5bUSaScud1K6lHOCYqBBKJN3qh5unAZNUpXLKc1fU7EtdZuwF4OXw00wNxLFqkqXUfS2h+JMXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=dCzRQ/fW; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="dCzRQ/fW"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4472500e25fso1069624fac.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 08:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610879; cv=none;
        d=google.com; s=arc-20260327;
        b=qkq409jQ4BcKaytfPtWPohl+7TwJXnZJqzz5yxni4crVTgM5UidI1U8Ptti9hJia9i
         KmpNd9GrWEM3Kow8iRQSuKploynTwIVXWyuRI77b68obloDi1BrfUOesNBqaXYqzuEq3
         40So8oFuj/blv5ErXm4dzbMUmNL/hXVqiWIoegB+iFTHyqBzUNN3fwWatZ+Mce8gtBgB
         a2CDAM4ahxubzIFzb7pNheLjZM3iHq7MJPQ51HfvuEns4z7UXuflwxpXoHz3+GD+zmDp
         oTU1DNrz8ucb2EaGpdorjGLlzn8TY5sraF4+YRyM3qe1+tbdB3nwULk+hlsooMT31N56
         WP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3ETsmdmb+3cHXN08EH+iCV/ETN1CcrQj41jPmLj5YZI=;
        fh=FyDly6jnTMp3mWZJVIkthxSU7sn3pAoRtth1AA4o5m0=;
        b=D5NPqVcfiiE2KYtVZi1n+pLPDgVW/vjDCKrEQYFQmSl7GPybeWUxdnLGI5AEfnBhgx
         f6kO9DNt8SI/uEiNWRKPO0qguoRSXJBLZSJXt0bNUQVrOCuSZwKvFcvTbW1W5K97WN4R
         p4Ac6rHbOxIs+6ppJCTh7KCWs3O1g1itzT7lpehPajeSA2ZCp5MjOjunFw5BsDTBGGDa
         zu7FaRzWZC+VEp/4A+ov+z89WKkeX27jq3DkJHfRO758lDMHAK8bM2LBxDi5hlNexcVh
         0hqUUtEd2IraLOKBNdPLO9A/lKYEDlZZ87ug9NUqwz0pzk1biG28r52EceairDOIRXQX
         GPbg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783610879; x=1784215679; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ETsmdmb+3cHXN08EH+iCV/ETN1CcrQj41jPmLj5YZI=;
        b=dCzRQ/fWDhbAR9i/Cks9cKkKqt9h8xRc2q17geDcS5o4f82eQcOHPUU04t/Ex74IWh
         B1q9gOAmP5DnX4e8FwCLEisrH48NLeujdXBg/pYhT22MWOrsMZfi71ZCVK5+IR2FZbti
         y3toaFt5TtjQjCrY9wZiQ8d3BMFWO/r5l+OklPdszWI4YYZDzu6MGiB5HbSCLUlkZ7td
         uMe5VCo0NcplsN1fYGF4OMLNX7FRDofhUVMwvFMIwdUYYM/wx3VeT5u3d5KiOwTq5V6e
         VWeq9gaawKBDKyqaL9E9x4AAVCe+RNr6w0vaCMJqNgEJBtHf42r2bvcGldbNG5DoKrlf
         Q/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610879; x=1784215679;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ETsmdmb+3cHXN08EH+iCV/ETN1CcrQj41jPmLj5YZI=;
        b=rWEUkT/oAKbIsNGzxNMUIJAY/1iKxyMyLFYb5m4clSNVo61+eusTI20Mb4TJv4xJKA
         Am6uTN5DzihPVMndxLEz+olFnuBS5/sHXl/EQLSJfjdgKtj9Dpr9f00J5AwH1CJ9jzHU
         j+dPeHymKeVypKEubD7cPTUR/uehJMgPmSPO8RluoTnEzPekZyb9snSq2KPj1pIzmlhJ
         Tua1QlKP34cQ6igKP9YqXNhTRsRR9ICGL/Tx16BXgX2E41Afiw8ufWMOa5DHsgR6WZni
         zvVY+msR3suMsISBNvbX0ZGdei5VXtZam+ylLGAb90kKDox2K8U47TB3gsXcksMfsHzm
         AJ+A==
X-Forwarded-Encrypted: i=1; AFNElJ/eYKffv4eZdBd1h/ndRXlJR9/mQU9FWmTk7OT0uqYKJM6gMVrMYJz3Qi/nd+fCDpgQZjuu2psUcdCcKX4XSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywpKRQEree0N04PIvBVb/0PDPBS8WvXoDMoS5r4MToSmyt2sEG
	axEyi8VmxU0CEmJXtMmvUV+Tocod9mR59/xUuiaNEsdtKDsAH4o8jaTkOTgSmDbFrzu5PT//WfG
	sdlLbhWXJGx+bf8UTslTCSx8nZ8wNcxQwJp9Cc/6WVA==
X-Gm-Gg: AfdE7cnRH7XIyhOvHboAIo+LkC9KGEiui01nDoJ1ZBKNPqC9X4kitiZg5hpWDazNUin
	kd9TTDZonOulP9ChJO4QgtPjT8aPi5lQwU4jPVG+G/j3/m0a7VTW8Xud9IVI/VXFlEGFWYSthEV
	8Xfc/o5B0sDI//v6/B3DI4+U/taDfDB7zKnHA+fnUJjU5W8YNCCap1Gq5bl0M7B7686shTqJ2CD
	B0H6lsYzF8grHV23b2XByE7nH3QmGzbBmVFncLjbB+T4V/vGmlRKH1MUfmC3ummkLxw675MTV/s
	Rj/fin9T5sZANlEVM/KQ10qNYw6Exf/uBHRcmLpE/2g+XbA2TGtzTMxJ0fJNBQ3w8ZN7Khua/AT
	/FFlu7NGb9zBw/Wvc8uu+CVwWGee2
X-Received: by 2002:a05:6820:4dc6:b0:6a3:c14:c985 with SMTP id
 006d021491bc7-6a36da6566dmr5303668eaf.72.1783610879362; Thu, 09 Jul 2026
 08:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <87zf08w7qo.fsf@jogness.linutronix.de> <ak0b2S9jjYy49a8V@pathway.suse.cz>
 <87echdvkd5.fsf@jogness.linutronix.de> <ak5X718OcOi8OeT4@pathway.suse.cz>
In-Reply-To: <ak5X718OcOi8OeT4@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 9 Jul 2026 16:27:47 +0100
X-Gm-Features: AUfX_mzqUqAOJpVXS1zSrcgE0KUX94znIqSV83ZukwijZLhjWKW1vacbJxvZC-s
Message-ID: <CALqELGwMa8N8VRQeDWK=vWX+YGpa66HNMSA1VmvSvu1-adbh3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 15:00, Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2026-07-08 12:42:22, John Ogness wrote:
> > On 2026-07-07, Petr Mladek <pmladek@suse.com> wrote:
> > >> This is too deep (also pointed out by Sashiko) because it multiplies the
> > >> delay times the number of consoles. For the legacy printing, it would be
> > >> more appropriate to put the delay inside console_flush_all() and
> > >> legacy_kthread_func().
> > >
> > > True. The question is if the proper solution is worth the complexity.
> > > We would need to pass the information down two level of the API.
> > > It would require adding a new (output) parameter to console_flush_one_record(),
> > > nbcon_legacy_emit_next_record(), and console_emit_next_record().
> > >
> > > It is not that complicated but these functions are already hairy
> > > enough so we should be careful.

Indeed - It would have been nice to put the delay in
console_flush_one_record, but nbcon_legacy_emit_next_record and
console_emit_next_record don't provide an easy way of knowing if the
record was actually printed.


> >
> > Fair enough. But then it should be consistent and
> > console_emit_next_record() should perform the delay before allowing the
> > handover. Something like this:
>
> Great catch!

I'll update the series to reflect this.


>
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 2fe9a963c823a..62fd6a5ebef66 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3161,6 +3161,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
> >                */
> >
> >               con->write(con, outbuf, pmsg.outbuf_len);
> > +             printk_delay(false);
> > +
> >               con->seq = pmsg.seq + 1;
> >       } else {
> >               /*
> > @@ -3182,6 +3184,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
> >               printk_legacy_allow_spinlock_enter();
> >               con->write(con, outbuf, pmsg.outbuf_len);
> >               printk_legacy_allow_spinlock_exit();
> > +             printk_delay(true);
>
> It is pity that this is inside printk_safe context with IRQs
> disabled. A solution might be to call it before the write.

I tried to be consistent about always performing the delay before or
after the emit. As part of this series I moved the delay so it now
occurs after the emit. This made it easier to know if the message was
actually emitted (rather than delaying, and then a handover occurring
before actually emitting).


>
> But maybe, this is good enough. This code path is called from
> vprintk_emit() and it might be in an atomic context anyway.
> Also it increases the chance of successful handover which
> might help as well.
>
> Anyway, it would be nice to mention these pitfalls into commit message.

Sure.

Thanks for the feedback Petr, John, Benedikt!

Andrew Murray

>
> >
> >               start_critical_timings();
> >
> >
> > John
