Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C312C534
	for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464645; cv=pass; b=pJHvin64FBxEuK5xImClcU9VC6aRnsA0IhDSt2a9YgEgQFnq3mOivQoiZ4lWRH4cHc1HQsNWL1X41p+rhXpClcu8nhFXeHxdP/FvlQwjKQUbrxpsM32kDZaWIDvk5is+DMzgVsIWiGWqWgZOIltyRT4j7rB37VpeJja8Fr4jGAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464645; c=relaxed/simple;
	bh=Cbv16bWSb7bD54u+omNlQ0fSl7jXbF+CDFxO+mNEHU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5WS+zgc0O6SgnwVUVf7jHHuSR0nzacA973eMIbRGM3whSw6DrgQawxXc9Lw4QPCWg5KVoBYxNBaGg9Ji7ko42SH7xmBdabqfMD/rb9qb72RtAZAkgLaVNFN0HDbgkM8ul1ZFifVMiBVSwepZfinRu7t+0eAVF4cMzXVw/mxLkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=nnJGuYkm; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="nnJGuYkm"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6da33a561so2439306a34.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 14 Jun 2026 12:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781464643; cv=none;
        d=google.com; s=arc-20240605;
        b=SIPQuxVU5dj9ajbodayROrcZ3rCUKN2bogGfYADXMASRlH4NvsnHjDOUClLW9ZjCUV
         bCKJgnmxSg6GHbeyLbrTISwNtrF355A5PBBNML8GyAJKM0RZ8S5Qs4MIFd4MrN89RxDi
         6i4FlDVjaK1PSR4KtBgVpBQr4MmB8tf97gbCsY0e2Uag5BKFtHTnpebglU8bVehfldkL
         t5llqTI85ocQP1/rkppIguPaClF4fbSYaZYbeGNAI7e2T6TT0+NwPv0w79yfSM5cyjL1
         GhMFklZiuPMjis24cJAhaKdSirScpvVeEIiUVurCMg8RM5jpDIc0RTpv+ihPku0tx17n
         URhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F4UrwTTSzIsxsEoiq28kNYEE7Qb/E3lbhaeDgdQ4yrs=;
        fh=VUm455sOP+LgfEtg35Nn/GyLBDkdIgs4lKjeVQUoGfs=;
        b=SMKmNUDNH6eJnOJJhgJIeXbL9KFuxrTZlF2miYL1MESFuNo0k5m4RDtLWhQ7uiztEo
         Gz7KY/7wK0zzu4spPMCIUz1p3te01Z3zpSt3ratO4sgPYLjcnBVAqNd4q3CuBEhAHN68
         6nfZmZPH0LzBQjzBzwbKFjunD+HyEVUI0PG1fHJZ4u9xuVawYUG/YytFrwZ+eptCFD4G
         LU1kdbUH1jbrwdK8ANhkqC3VE9/BCa0aw6pcjnDBc7Bu59LKWnQ5nJpam6s6AuNUq1xJ
         OVYs8FOjfmkAh4SyrKEVYKfw3JTe0hwA/yutZHBKlr8lxBMW5c1K8Dh4CNHdLnHyILe/
         VKvw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781464643; x=1782069443; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UrwTTSzIsxsEoiq28kNYEE7Qb/E3lbhaeDgdQ4yrs=;
        b=nnJGuYkmDIiucs4lCTfQctV+l8GUT6zGH9thZYrzIFjJTpNAnogJc+S6U6HVwlofnk
         PGaLK+wBRwsFuVcjJo9ZUB10qSsZIghlQndo1flBbfM7H/DRwabSMN5hyFcpNDNR2C2K
         xEy9pgQy5u+vwwLuLgxnsnqbe/Mov6o7eDDFf4eUAZFqZTxfz2u9+kLCaVsHA/tEM1my
         EDTLFoLDLvKH8p4LQtS7m0+tjHx+SwQpt5BNMFRdZsJFZYrUBumXkYrzwziggNxYKYJv
         tvgCAqqNmx1C3j8dYRICBBp1ahecuamH05zfyfvjm3NrmHfzKovoW/Q5viKAznajMD8f
         Xbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464643; x=1782069443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4UrwTTSzIsxsEoiq28kNYEE7Qb/E3lbhaeDgdQ4yrs=;
        b=dzNT6YMWzVBgAvf7T73bcVKFK6z+4OCqHaEecRfXZxtBnfPggpCBlQV6+CE9pmQPTQ
         Pj5tNgby28J8sZW5vCWJk4a1O2/seWZOI7piiAR9pNWX3dHhVrZO5ujfLrC6LJUg+1qk
         jLQdVujWVNOJLgmgEDx1Tb60nfHVMFjabLuYo+g4ibuCr2WR9f6W5SlgqUbop71YPA0f
         ARX19jDkfr6Gfc6yOpBicCrVha1tuw/4hbM3/b/SMiZTUOfYALwDRrYRThrXv2Y9O+w5
         3BglWVkoC1ZfnB+6uPa8s3j3rFdQPv7VnVsX39jCXl+08luyIGdWJnEBtnv/fzv8gEdu
         ZOgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SXFH9ZjA3MFbL/fX33ce74bN3KARu4GeJUvYqJsJL8OyhGpNzpaFUg5A+URTeXGlyKJ3Raly6/OyYjQljoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxtsslZJEhKl4h4yRG76RC+Q+50SBYlUxLM2ZRg4rDml+AMQ/z
	SJTmlU5gg4BflYs89ENQw3N3kH02BqoP3xm8mE5MQPZ/Lkdpbifwe94/trUHXAZk92BXSPyPkau
	Jd0+XN/YGfyFOotQUkqm0SG7/ajY/wxyPc1DMjJqu2Q==
X-Gm-Gg: Acq92OHtCYp3d4wLLZt5Gq2Z6rUsMHPdiulyRDUwd3L3dg4tR3k+JGqR58gQly1WaFp
	b2Ifg58SnVi3ja/MhvfqjrQ5SV/vPgkvh56j+JsnOnrsSMxf0V1lOR3Jd+7ufwOM7SI3i4AzN6t
	58febluFn+rb7+g/jTaWTb2x1vpQipcM/g48dsLZLpXMceKM3hlgMkei5IEoqgCmfchg/ukGzRw
	mPeYPu9JW21R92BkYLz96OaPCOwRb/rg+yXVKqhY3fHBktWkXl1I4Ke9k3moLGG3nsn1JjuwudN
	m2erXFyp28yu08JDzXgeyomNjQIehQStrivdEDEX9xDOHSOKAXlhF+LQh96k9TE7hcphF5Z4WSz
	jT0gXcM2rK4bWbcDPVXEGaXeKBYLM4G/p4Pn1AAc=
X-Received: by 2002:a05:6808:178e:b0:485:41fc:71e1 with SMTP id
 5614622812f47-4872f4a0776mr6926903b6e.21.1781464642824; Sun, 14 Jun 2026
 12:17:22 -0700 (PDT)
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
Date: Sun, 14 Jun 2026 20:17:10 +0100
X-Gm-Features: AVVi8Cd_wDbpoenWa3p5Qu6vcK4mwMkoHo9_Ly4qYzGijYT1qiw-VX-9B0ykX4w
Message-ID: <CALqELGxjUGFgpo6sf3689RgSEQg3+owZkk4TZKwV=dSJxxka_Q@mail.gmail.com>
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
>
> Also it is not clear that whether the message was pushed to the
> console or not. It might have been supressed in which case
> (wctxt.len == 0). But it might also be emitted only partially
> when a higher priority context took over the console context
> ownership.
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
>
> >                       /* Are there reserved but not yet finalized records? */
> >                       if (nbcon_seq_read(con) < stop_seq)
> >                               err = -ENOENT;
>
>
> As mentioned above, I would add a flag which would be set when
> con->write*() was called.
>
> It modifies the type of unsafe_takeover in struct nbcon_write_context.
> But it actually makes it more compatible with struct nbcon_state.
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


I think this (and the others) should be:

if (backlog && wctxt.emitted)

Otherwise you may delay in instances where con->write_* was called but
ownership is lost, for example if write_thread calls
nbcon_enter_unsafe which returns false and doesn't write anything. I
assume that when ownership is lost, the record will be reattempted in
the future, thus it would presumably make sense to delay upon
successful emit, rather than each/any partial attempt? Is that
understanding correct?

Thanks,

Andrew Murray

>
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
