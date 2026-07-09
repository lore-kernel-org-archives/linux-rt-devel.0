Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B832E126
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609308; cv=pass; b=FX2VVJiUqMkDiZx3OLpEUaSl8JmFJuRvIwza4oCp0ZvhPBKnbpW8ZJEqO8ylh546DNBgEjSKbrZRWLrOfZ/VICD8EIV1NyMEJq5zcoPpU0KOXy9NkuGvjR2RXYvU5NSn3kwl3W5tQ2xzxP1kuAUN9pParC//55pJriSzycHpbnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609308; c=relaxed/simple;
	bh=4SZMuyVOXCpXxD5R6Zg7kloOZfZmtjVJIRVSodune7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+iKGCK2woVi9DE0schb+iyNpp/z3NClmyNxKMuhjzIGzMayu1GW09o5GBlwJYMWVxXiXY5xl1Lyaw31ZKrkm9EpK4w+RiYgqNk9xPhkrI0BHn0ZiAJb/8dGPR6xLQf4BB3HmyJUa9jos52pIWYw8GGZUjKiF9hdM1Mm0CIRp0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=o89aWz8E; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="o89aWz8E"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-491f5e6d564so1142660b6e.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 08:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783609306; cv=none;
        d=google.com; s=arc-20260327;
        b=a0/OKhlGvm8ESK0uejcwmVO8kKyNZvTLgGLSt854n3mCSQb9JGADg8DLe5AHUh0L9x
         doCDIhmnxewvugmj/uW2HI0sNuCDsGJlOg7fYURco75IylmzQ8ROuXn0pAGL3N6vRvSb
         vq8GeSJkLPlz7bffVWfhSF05Gs561mHmkULkOfcTF1uJ47fklh15R8gLKl39iWNPchZW
         TRXmWdt82Gc7N59S389WJnvIoect03vUTh4FInripqoVBE8WXzyfIrd8eFFSj0NlVjMl
         N3q0T/8hlMkdcl9kYjxDOb1oVQB409ro0DJcpc0mdCx/YvG9oFKIMp2ZxD0HnB9tK/Wc
         Up4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=54Dj02k3uul5TPtw9U5JIJjN3eOpWu3nQg9JkvEUFro=;
        fh=H5s1xDK0/8NuT/u1CxakeNhRnYxpkGVtPUlFDYII7y0=;
        b=ieI3IvMmdQhjgouaCkHrdPB4ms4q45RQFFsJBv0ttbR+8+keyK9Y5MeYFeFop8ECed
         HsTEYvmwFMmobTUOwOX+MgNsRneGcZbJaIvRgHGISjUndaS5j6oQylkEkuC7go1RnAjY
         xZ6MBZAGdQsVC+aYOUVa4Gtv+7Tt17vaiJygiSC9+etR4NjpVts7tfBLKk0wf/kuon2T
         xpLG6gDg5dXwUaU1Xj8uJmd16ByDz9hau3qlPuw6wrMqjkXz1tFinDVI2gPAev8Jmnlq
         N2eCrC6JeIMyyqpLoxQ4OtOy5n3JWkWjTQQwh/rPc2/VwudRbtaDXZjVXjjkIHwcS3BG
         JzEQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783609306; x=1784214106; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54Dj02k3uul5TPtw9U5JIJjN3eOpWu3nQg9JkvEUFro=;
        b=o89aWz8EFj2dicPZMcMHM08gHZSWKQ538soOhiODsRfnVKHXArgZ6NzxSBud60Z1la
         +ODbBq8sXwOmt0N/h8TAsYxGRckOS+DXmwmt8umbVY0vodfrKG6LHgmke7YJSXB+Uv2A
         of5uLSQREDJTyIa/RnduYcOutGwW6KQWZWeCccqIDMftpB+bwHKRaiaDjicnuqF56zio
         7Kc1E0mbpa3yEl8rBKxOy4Uge3g0XJ6qr52Eqcjm3vtdVUlAiW2vrF7TSh3FdCMz1O9j
         jXM1Ms89WNiy/u4bcLo9fdmKKaoBQT3e6tRAVBh4vVkq4N2uYQmuprYRXNxWi+nC/1R/
         69rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609306; x=1784214106;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=54Dj02k3uul5TPtw9U5JIJjN3eOpWu3nQg9JkvEUFro=;
        b=hzLZIir3DjNc/bsPWL/+hne0msBCUlRhhf293uc3E4nUpHJvx+aS/18tu8T6QeCoQ9
         YRKe5oO2DiNKm0mhRWqLwfqd5Pcx7lRKLmVBhEhNd0PMRE+Onq4i0mNlKt23SgD8aXOU
         tQD3vz9WlS7tMipxLhQ4aKK+gKS/XyOJ4mVFDxMqoH/sE6kZ1/VN07pEIeq5CyIUXFnC
         rsEoeNDP8EUltYBgTxIghx9Y4JucjsIfmiAbibFA1vu+sDDqY66QBM7XyBEEQsJM1Ou9
         xyDQq3GaxvgAuGcq4ffPrJkYNy5J7pLOa7174fBhoXbF4YGXLNsZKA6ONT9KlHR+t3ht
         GiFg==
X-Forwarded-Encrypted: i=1; AFNElJ/CPIRb8QCI/5mmmMqaYYQvbtm4lUPoh/WiaoF488XbHxHmLkirRBF/MtQBRX0XOM7bNnW2eRMI2cZTcXyB7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFrzA1oFyVlBi/fDYVppy/QhBos2LBbZLQDs1M3P7EO4yAGRZj
	iyiHstcW10OKwYbQTna+lFdqqGQ9c6msKUGPSZYV3HrGW7egaeEBv23GG4Ai2FIumi5rQaHi1+M
	S6cfBVaJe15hKBExq1iG0CZ2WoexayBSSxfNgeoDR3Q==
X-Gm-Gg: AfdE7cm1ZPxLXVremnKCbTEi5TUwnkeBr/FoXSmrmpCxpsLR79QvZbmx3U9by50nUAz
	HGa9VEuf7i7ro0xLiGTYI+MyMte6lDHWmuwpWIadmXMN98uDAZzgXv8TpycFu6LJXhY9Ibk2Urd
	6TmQWi0bL1yKM4rr1FjcDXXSDeY8hQswLs7GhNs3sepFIGY07J0XQdq+RqdlTfpVz6d4LjEEJb3
	p+mKmkiQORAOlKQFbhIjXC5hKPMA/xSATlzmmE0VUFp7eVYEkYt8R1j6Wu59LP6N1+kz2oRJPfO
	yEV42h5AeoYwf47RrRGbBkTzPDGiU9tbgSkcvxoGdZPV6KOBWFD8SP/5teR08THLZQFA1wo3Wz1
	idP3j1Rzb5okFby1D22wRIaVPBFo4
X-Received: by 2002:a05:6820:80c9:b0:6a1:7d5d:d55b with SMTP id
 006d021491bc7-6a36da40a78mr6610565eaf.63.1783609306048; Thu, 09 Jul 2026
 08:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk> <87zf08w7qo.fsf@jogness.linutronix.de>
In-Reply-To: <87zf08w7qo.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 9 Jul 2026 16:01:33 +0100
X-Gm-Features: AUfX_mzxAEUtA0gfeGBkNwUL4IfvDIIDWxjRLhkwrbukoka3ocYrFDWdq-jaaZM
Message-ID: <CALqELGxAXDF-cz-b=2G64TayXDU1U1vBzb_qBwcEJ2Bvw+fFjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
To: John Ogness <john.ogness@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 at 13:57, John Ogness <john.ogness@linutronix.de> wrote:
>
> Hi,
>
> Sorry I am so late to this party.
>
> On 2026-06-30, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index d624200cfc1708bf73925892a466efe0c95c5586..3478b556c0eb9579530409dc6fbb9b5a8bff581c 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -290,6 +290,8 @@ struct nbcon_context {
> >   * @outbuf:          Pointer to the text buffer for output
> >   * @len:             Length to write
> >   * @unsafe_takeover: If a hostile takeover in an unsafe state has occurred
> > + * @emitted:         The write context attempted to emit the message. Might
> > + *                   be incomplete.
> >   * @cpu:             CPU on which the message was generated
> >   * @pid:             PID of the task that generated the message
> >   * @comm:            Name of the task that generated the message
> > @@ -298,7 +300,8 @@ struct nbcon_write_context {
> >       struct nbcon_context    __private ctxt;
> >       char                    *outbuf;
> >       unsigned int            len;
> > -     bool                    unsafe_takeover;
> > +     unsigned char           unsafe_takeover : 1;
> > +     unsigned char           emitted         : 1;
>
> This is the wrong structure to add this flag. This structure is for
> the nbcon drivers.
>
> struct nbcon_context would be the correct structure.

That's no problem, I'll update on the next series.


>
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index 4b03b019cd5ee25d68e9ace84392045e91241a7f..ae45cb0589c0effafc66f1756bdaecd1c1e53ab9 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1525,6 +1532,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> >       }
> >
> >       progress = nbcon_emit_one(&wctxt, use_atomic);
> > +     if (progress && wctxt.emitted)
> > +             printk_delay(use_atomic);
> >
> >       if (use_atomic) {
> >               start_critical_timings();
>
> This is too deep (also pointed out by Sashiko) because it multiplies the
> delay times the number of consoles. For the legacy printing, it would be
> more appropriate to put the delay inside console_flush_all() and
> legacy_kthread_func().
>
> > @@ -1584,6 +1593,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> >                       if (!nbcon_context_try_acquire(ctxt, false))
> >                               return -EPERM;
> >
> > +                     wctxt.emitted = 0;
> > +
> >                       /*
> >                        * nbcon_emit_next_record() returns false when
> >                        * the console was handed over or taken over.
> > @@ -1600,6 +1611,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> >                       if (nbcon_seq_read(con) < stop_seq)
> >                               err = -ENOENT;
> >                       break;
> > +             } else if (wctxt.emitted > 0) {
> > +                     printk_delay(true);
>
> @emitted is a flag:
>
>                 } else if (wctxt.emitted) {
>

Good spot, that was sloppy of me. I'll fix.

Thanks,

Andrew Murray

> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index cc203327247aa4f81f55b907c66ac88f30ce6da8..5278d9cb19e4177a00998fba5c1438251e033578 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3211,6 +3208,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
> >               *handover = console_lock_spinning_disable_and_check(cookie);
> >               printk_safe_exit_irqrestore(flags);
> >       }
> > +     printk_delay(true);
> > +
>
> Again, too deep. Let console_flush_all() and legacy_kthread_func()
> perform the delay appropriately between each message.
>
> John Ogness
