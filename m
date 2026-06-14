Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF47263B
	for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441747; cv=pass; b=nqF/aYG4o8MYlZu+lobbij5Ul9PEJDIFMk89HvTcs4ZAsVsttrd5Pzi+lrOmhM17PI/xPF6MJSGVl5SAnzlpcDF32n0jyiZJq6l3xkIToQDMVYoA3ylNAzh9Crt1KYBtFTO4VMU3/krpJDWzUwRJxZP0FuOg8mTQ73jt2S2PzC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441747; c=relaxed/simple;
	bh=GDOnrWvp7Y+HFbU9Pe0p0Y8r9RbjMkfXMF0u1Hxcfbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efds5d6ac5G30QbJAH7/AA3+xBZQwftR+CjVr1aR83wjoE4x0ovJYGIy2BZIebJPiya0cSh4CrjP/IAiUQdTAAOR2tkfYgLGEpB/HByBa89dsADREo0LVBzNeS3gpNc0FlbIMfJnnUp3Bbg6Sjy1yUICK+jEuhMyIVwXJUl9ANM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=0aOQBedP; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="0aOQBedP"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-487135fd4f9so1000656b6e.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 05:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781441744; cv=none;
        d=google.com; s=arc-20240605;
        b=bLgGGxmVTk2NdTdATjKYXPtmVG3u1J0y/eNvJgQSsXEzluoN4d+qXYeQTOlBSVPqda
         LSowXPZhawIk4qiXJ0RsVbj9Q1Ho1P5nLvL9tyB3/cIXYwuFa7WyM6rCqIbD3TLG5p82
         HpXDgETCCB5/1MA2bLfDDk9ALDed13RYyQ78fhjka+3zrPwU9kt/AA/Hl43QyEkqPUZd
         xqeGpqSX7t0dp5Vc60LCz0zmEzH9YBE/O9w5QkvImbKY4H916Nmi4wMis5AdGCTtBzy6
         zTTUYzwjLU0Ou6gl2m8qaSVb2IJc7Jg43/Gb65Nc67QRPX9VPzjxzBg45yHBb0Pow2gb
         A2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WZeTyf1C0nn8STuLXoAYPKsgBtsVBb2BP7ZZv+Bey8Y=;
        fh=AGeGPPNVUupePCLLZgsHTZ/xmP60TjDhdqFW4YxFJU4=;
        b=M2fBw4IjrKwMILSUAEPQ0+2c6qbqt247gQj2mm8UCYZX2C2neT84RDhTHgOeEUyEpV
         LNdvKNWmFz0TSRPsX+0Eziatt3UFwfGomMOozzDIjgEKQlOZJy1rBO/wWfyDO1Wizcof
         PInGxANOvTY02IGYXGeTSr2pYMkToRBmNmkoKsH1GSxzCdiwOLAy3rdylhyGO/fsTT42
         QrFnungb7vC/DBtI1/hKBlf1+cpJgWOERoGjjPwoINi526Hm304JhokBqxrm05A65B6r
         SgE2q+5MRrlyrqkXTz7e3WPo1uUnDkGvjV7v1Bk38zkpzG6a60sssoVBvmC7rzu5bGA4
         FXew==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781441744; x=1782046544; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZeTyf1C0nn8STuLXoAYPKsgBtsVBb2BP7ZZv+Bey8Y=;
        b=0aOQBedP3OdGzmmFD30YaIVwnI0Dhqygspo8dzpx5G4ZV2lHdsJr7Qe1jyLjo9Mvv6
         hkAxcG24hcvBZOif6EfXV4wuX6NzwBfQWeJsX9flh33f1T0dqj+H1XR3Qxdkx/pXQaT2
         /SPC9iiQsW5+y6fqEgZbSLnNGiPnXX42n9fVjXer7FsXfybFVLv334Kfqe8jfrUs47jS
         DYSAs1nG3Zr1z46SYfpkUE+RvRgkJqNQau3jiLIEQz9/d+U1uScHgIR1LL+NEunXp1V6
         EgmLRyWw4kNxbH5Mn3fEopKCmBewIzO5QO16V3g9aJj+v+WT6fu3DJarZ+Ai4ll3RCBA
         TLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441744; x=1782046544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZeTyf1C0nn8STuLXoAYPKsgBtsVBb2BP7ZZv+Bey8Y=;
        b=SghcKLF5yTu8q22i7ADAPWih7389xpkdvOZAbSCF0eHtn8Ie6B/qwQdshNGkT5i4i2
         WD7jmdH7FwiC3AnziJbZ0fK+HZ+qBGBTy1WzFOYs1BpXffxbCSfwoRdfvkz3qzbms8ft
         tWRIkzHmGCp0o8BN7IHwL0NCthSqOyHezqkAkCCPXg0gu29Mdi1cEIkUUN5xM+z5W22t
         WhcATyGu8eIMP6X4OLgAR5gkjsOzg2yLXgdlA3TZ17BlG8qLxNriHyLGGc27SepVoWK4
         6QJ9vKkN34AAPvyBx5llLnLFw4jdJGxRUWBrsZ/OzANzhBW5F5a8L/GmMabQElICoTnK
         ZLBg==
X-Forwarded-Encrypted: i=1; AFNElJ+lRw+7G6WnE+hQC+Ruajw5kcn5f8hG5S8Opfm0rWSQjrPWtG+FdPT0eIB8mJSqPd8cO0YU2W0JC7aehOTfrA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0l51A/vbMTK9FKDiuxUPfb7Vt8qc4BAd2PPrQc25feOrqihdA
	qM8/qjrjQNJ+HkstNUXoUO1RDMpKzr68+niAQwr5jVccrIS0fnEiHDDY8KEDRbkeEYIopz/d7pA
	+fxK1+L3mOi4XdG/l9PWk/sz49JlGjqb6CuNAE7R3FA==
X-Gm-Gg: Acq92OGL/gqHmEJJMMkkvjuHCN3ziHcBBDXbX8gHBO0uWpzm/45w/r/WoEXE3Z8V/TL
	PQFe3jMEuYtl/jM1QT+CieLtj0nSBzYtEir4bTY+a+C90oe732DYx6sSKIuPEVNQfORS87zJWSp
	41NrHF4fuJDDg5jypRf7uhqV5xLqOqJtqMf8cJH+xf/U558oHB5BafbyJ4Es94QM0mR9DrL59HH
	5umCUdC+uOrYHR9Bg/llWmvv3pYK1xQgpa4uKK2mteEQS7IMmXAfXC81maFU9Z+OjFdpCmarrjL
	QV29v3m6ndkhHnhBKeIvE2ZqAeAMfPIS9frxlYOEm1owAmgc178ZAl8NXAkWFVOPN0C1ESp2+R/
	K8n4Wj9WGdXPby7qRyvTUuiIGLKFTUH2WOyv+rUI=
X-Received: by 2002:a05:6808:170a:b0:485:403d:9b78 with SMTP id
 5614622812f47-48741936d9dmr4143100b6e.3.1781441744013; Sun, 14 Jun 2026
 05:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-3-c34c187142a6@thegoodpenguin.co.uk> <aibe12WcrLxVWTez@pathway.suse.cz>
In-Reply-To: <aibe12WcrLxVWTez@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sun, 14 Jun 2026 13:55:31 +0100
X-Gm-Features: AVVi8CflUYPsTo9tQrMGcwZHbhm2kwfKfqeb77lT7O7OOqLaCglAj6vHQG53s8k
Message-ID: <CALqELGymunRD=ku6CpoZ6OMH9QOYvyPB-EMN24ez5WAeXFtCsg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] printk: nbcon: move printk_delay to console
 emiting code
To: Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 16:25, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2026-06-01 00:17:39, Andrew Murray wrote:
> > The printk_delay and boot_delay features are helpful for debugging
> > as kernel output can be slowed down during boot allowing messages to
> > be seen before scrolling off the screen, or to correlate timing between
> > some physical event and console output.
> >
> > However, since the introduction of nbcon and the legacy printer thread
> > for PREEMPT_RT kernels, printk records are now emited to the console
> > asynchronously to the caller of printk. Thus, any printk delay added by
> > boot_delay/printk_delay continues to slow down the calling process but
> > may not have any impact to the rate in which records are emited to the
> > console.
> >
> > Let's address this by moving the printk delay from the calling code
> > to the console emiting code instead. Whilst this ensures that delays
> > are still observed (especially for slower consoles), it doesn't improve
> > the use-case of using boot_delay/printk_delay to correlate timings
> > between physical events and console output.
> >
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
>
> The declaration is needed just inside kernel/printk/ directory.
> It should better be done via kernel/printk/internal.h

OK.


>
> > @@ -209,6 +209,7 @@ extern bool nbcon_device_try_acquire(struct console *con);
> >  extern void nbcon_device_release(struct console *con);
> >  void nbcon_atomic_flush_unsafe(void);
> >  bool pr_flush(int timeout_ms, bool reset_on_progress);
> > +void printk_delay(bool use_atomic);
> >  #else
> >  static inline __printf(1, 0)
> >  int vprintk(const char *s, va_list args)
> > @@ -326,6 +327,9 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
> >  {
> >       return true;
> >  }
> > +static inline void printk_delay(bool use_atomic)
> > +{
> > +}
> >
> >  #endif
> >
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index d7044a7a214bdd4537a5e20d876d99bc3ffe8b3a..a507a2fed5bf4366e24330f763b842a698ecf6f7 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1267,11 +1267,16 @@ static int nbcon_kthread_func(void *__console)
> >
> >               con_flags = console_srcu_read_flags(con);
> >
> > +             wctxt.len = 0;
> > +
> >               if (console_is_usable(con, con_flags, false))
> >                       backlog = nbcon_emit_one(&wctxt, false);
> >
> >               console_srcu_read_unlock(cookie);
> >
> > +             if (backlog && wctxt.len > 0)
>
> Heh, this is tricky. It might probably work but it is not guarantted
> by design.
>
> The "backlog" name is a bit misleading. The value is basically
> wctxt.ctxt.backlog. The real meaning is that printk_get_next_message()
> was able to read a message. It means that there _was_ a backlog.
> But it is not clear whether there are still pending messages or not.

Yes I found that to be the case (see my notes in the cover letter) -
backlog is only true if a record was successfully retrieved, though
that record may be one that is suppressed.


>
> Also it is not clear that whether the message was pushed to the
> console or not. It might have been supressed in which case
> (wctxt.len == 0). But it might also be emitted only partially
> when a higher priority context took over the console context
> ownership.

You say it might probably work but isn't guaranteed by design, I'm
struggling to see what I've missed...

As far as I could tell, nbcon_emit_next_record only returns true when
a record has been printed and it still has context. The only exception
to that is where pmsg.outbuf_len is zero (suppressed), in which case
it may return true. Thus if (nbcon_emit_next_record() &&
!pmsg.outbuf_len) then we can be sure a record was printed. In order
to apply this test from the various callers...

for nbcon_emit_one - this returns ctxt->backlog if
nbcon_emit_next_record returned true. But backlog is *always* true
when nbcon_emit_next_record returns true. Thus the test of (backlog &&
wctxt.len) is equivelant to (nbcon_emit_next_record() &&
!pmsg.outbuf_len).

So I still think this implementation is valid.


>
> I would prefer to explicitely set some flag when
> nbcon_emit_next_record() really called con->write*().
> See below.
>
> > +                     printk_delay(false);
> > +
> >               cond_resched();
> >
> >       } while (backlog);
> > @@ -1525,6 +1530,8 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> >       }
> >
> >       progress = nbcon_emit_one(&wctxt, use_atomic);
> > +     if (progress && wctxt.len > 0)
>
> Same here.
>
> > +             printk_delay(use_atomic);
> >
> >       if (use_atomic) {
> >               start_critical_timings();
> > @@ -1584,6 +1591,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> >                       if (!nbcon_context_try_acquire(ctxt, false))
> >                               return -EPERM;
> >
> > +                     wctxt.len = 0;
> > +
> >                       /*
> >                        * nbcon_emit_next_record() returns false when
> >                        * the console was handed over or taken over.
> > @@ -1595,7 +1604,9 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> >                       nbcon_context_release(ctxt);
> >               }
> >
> > -             if (!ctxt->backlog) {
> > +             if (ctxt->backlog && wctxt.len > 0) {
> > +                     printk_delay(true);
> > +             } else {
>
> This changes the semantic. The original code call this when
> no message was read. The new code would call this path also
> when the output was suppressed. It would probably work.
> But still.

Ah, good spot! I missed that.


>
> >                       /* Are there reserved but not yet finalized records? */
> >                       if (nbcon_seq_read(con) < stop_seq)
> >                               err = -ENOENT;
>
>
> As mentioned above, I would add a flag which would be set when
> con->write*() was called.

I'm not sure why I tried to avoid adding members to nbcon_context, but
I prefer your solution, it isn't so fragile, and makes it easier to
understand. I'll update for my next revision.


>
> It modifies the type of unsafe_takeover in struct nbcon_write_context.
> But it actually makes it more compatible with struct nbcon_state.

What is the intent of this change (bool to unsigned char)?


>
> My proposal (on top of this patch):
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 5520e4477ad7..5a86942e55ef 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -290,6 +290,7 @@ struct nbcon_context {
>   * @outbuf:            Pointer to the text buffer for output
>   * @len:               Length to write
>   * @unsafe_takeover:   If a hostile takeover in an unsafe state has occurred
> + * @emitted:           The write context tried to emit the message. Might be incomplete.
>   * @cpu:               CPU on which the message was generated
>   * @pid:               PID of the task that generated the message
>   * @comm:              Name of the task that generated the message
> @@ -298,7 +299,8 @@ struct nbcon_write_context {
>         struct nbcon_context    __private ctxt;
>         char                    *outbuf;
>         unsigned int            len;
> -       bool                    unsafe_takeover;
> +       unsigned char           unsafe_takeover :  1;
> +       unsigned char           emitted : 1
>  #ifdef CONFIG_PRINTK_EXECUTION_CTX
>         int                     cpu;
>         pid_t                   pid;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index a507a2fed5bf..060534becefc 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1069,6 +1069,9 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
>         else
>                 con->write_thread(con, wctxt);
>
> +       /* Tried to emit something. Might be incomplete. */
> +       wctxt.emitted = 1;
> +
>         if (!wctxt->outbuf) {
>                 /*
>                  * Ownership was lost and reacquired by the driver. Handle it
> @@ -1267,14 +1270,14 @@ static int nbcon_kthread_func(void *__console)
>
>                 con_flags = console_srcu_read_flags(con);
>
> -               wctxt.len = 0;
> +               wctxt.emitted = 0;
>
>                 if (console_is_usable(con, con_flags, false))
>                         backlog = nbcon_emit_one(&wctxt, false);
>
>                 console_srcu_read_unlock(cookie);
>
> -               if (backlog && wctxt.len > 0)
> +               if (wctxt.emitted)
>                         printk_delay(false);
>
>                 cond_resched();
> @@ -1530,7 +1533,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
>         }
>
>         progress = nbcon_emit_one(&wctxt, use_atomic);
> -       if (progress && wctxt.len > 0)
> +       if (wctxt.emitted)
>                 printk_delay(use_atomic);
>
>         if (use_atomic) {
> @@ -1591,7 +1594,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>                         if (!nbcon_context_try_acquire(ctxt, false))
>                                 return -EPERM;
>
> -                       wctxt.len = 0;
> +                       wctxt.emitted = 0;
>
>                         /*
>                          * nbcon_emit_next_record() returns false when
> @@ -1604,9 +1607,10 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>                         nbcon_context_release(ctxt);
>                 }
>
> -               if (ctxt->backlog && wctxt.len > 0) {
> +               if (wctxt.emitted)
>                         printk_delay(true);
> -               } else {
> +
> +               if (!ctxt->backlog) {
>                         /* Are there reserved but not yet finalized records? */
>                         if (nbcon_seq_read(con) < stop_seq)
>                                 err = -ENOENT;

Thanks,

Andrew Murray
