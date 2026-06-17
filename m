Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9A492197
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711124; cv=none; b=BXjh4XPzn8eVjTXpotL45kXBWCWyqJNO0PwrRfyTc3E4eAk1JZnRM87CAttlMBOqxRo6CEOFewJEg38UqDmlRL+/JbuY5s/+E2aqLxfSi0guIwOs5xdY3y75CtKaGEXBnq2yY9Eh60Cd5BI21y8IisjHV95I77cTiFFmnHHcamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711124; c=relaxed/simple;
	bh=GbfcNUXLrVb9cXio6nORomeLd87EM5ftMxkfbJQ0WXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFSg2cauXLKk3szVzoOsMFHe4+E0sr4aS7Zuwvzv7DNkQP1c5WWSQ9ov7V7Yt/dqon9IxuRGQqrzsG72RckPuK1OKjJJT9/C9Gb4A6/cE3Tjbr+XvE4FjmGN/BGaiYTjU7URh3jSYCNXX2s9lMzwoYO9uMYDvLM5rlQIvRRU9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WcG0S2oi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WcG0S2oi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so38569365e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781711106; x=1782315906; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLlL5rZhYcrp7dhMr2Kz7P02hmD2dxwyOdUGGrHy7ew=;
        b=WcG0S2oidroh+xiNFOaxFmK5IaBqfYT6flwjfXk8tQu/at3N5aIlyJYGyzhT3vjAbU
         Fls3d3OLL9gC7vsHmy3T/uiPGLhFPe8gFN2lQEJthQZgMfwzISBsvKVwnFBxFIJ2EXKx
         qbzYVtSLE/QMAlfMvqGA6wmn81kfWxDKESjV84PdFmsMhXcbii9mAhuNbI9d11vCKB61
         SFFkmEhQCTTIguU4NbG9prKSDLXjIOcfmuYh4/MKv0/N461wo4sUTTca1aL/SXNH4MlL
         5jBv54U+XhovD4S/Yd3LJwC0itEi1/0WO1xAfK/0x0GmFbcftWCiNVJ0Yu3ATFjLEhYq
         4rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711106; x=1782315906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLlL5rZhYcrp7dhMr2Kz7P02hmD2dxwyOdUGGrHy7ew=;
        b=EWhtpuU7eiz6p3XN3q+Yr4RxuKnaM1Q4Tqh9ieXXQbDo8570yTVAFrGm4KF/rA/TI5
         iw4kmpIJPLv0EnkrLPWkg0SvBthuVxQZ+OAzuHvQ1mLeHqQ5XTn/9V6FlBjpRQ+awOJd
         X99uzu3JFRtE4q/YhLjvm+oGmyGjjALxAVe37kvqFayhsF+ZL/y44aNxZfK6V/YCvcx3
         yfF20g1xj5QLWXAqJEFAf9Wp30dWykw7gqaHhM39i/xvpqfzDxZZZQUHZ8X5VFb2MjD1
         aZJ1i7yhAOK81P6Ky97bfX45kwBc2eA7hfPkkIuvqUPumx1I4zhbzZGPBldII//qpE2A
         kfHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ryXLyLsH+ulIc0cTGJUdtBlDz9rLb6T7Ckv9N53Jw1yLDUhnQAP4uXM1vHcSKJl+v5FDvmycV66OP5CZT7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBBlUtkmmlx4QfedWYi3ASREdZKAVR/6G3Pex6DONs0NNx1Dtk
	v0E3vZ+f353KHaT3KNuStQdS2ildHwid6FwAK6Dkaox1Ua5C3W9rUqqojS3sJ/Wz8wE=
X-Gm-Gg: Acq92OFsFOFoweNPFVWwHF6BurHTmbWjNhidLlrXTRL6jfRtLWTG5Yu/30oldBFV7U2
	IbGmOCB3SzZIBDshT+cHTWNuVkRqS1k1HhyaqzGRAu5VCbfQ/LA6WubHv1bPq558ulFvYsM/Sg0
	xxoPa56BUVuqfKJEMx6t+edsR/UIEGCiXxH7OOiH26UfRBv8rwVmxS7lZHkJNJILRtg99yciqh6
	xPPLr0TD0jBWJVylqkTBhn8EmztuBQwqVFrzCdqREUp90Sr/Cf7fi3hm6RK5eJ75GmqlHuU9YQU
	mwJDyX7btIFtNAVg0f6Rewv7YMTU9M1LPOkpVYf6jixst1gIUDGitfkDv7YTJ0JZQlWVk+zL64P
	1zpyStGYHdF/Bljx+o5GooL27+sPppmIIMHtL4n0q2qYGAWSLbQh8aPIwB7NmvlAGjSHzPCyvzZ
	1IEnjkHrviw2tHMUg=
X-Received: by 2002:a05:600c:5287:b0:492:834:24a2 with SMTP id 5b1f17b1804b1-492333b1529mr81017605e9.16.1781711106011;
        Wed, 17 Jun 2026 08:45:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm189956735e9.12.2026.06.17.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:45:05 -0700 (PDT)
Date: Wed, 17 Jun 2026 17:45:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Jonathan Corbet <corbet@lwn.net>,
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
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 3/4] printk: nbcon: move printk_delay to console
 emiting code
Message-ID: <ajLA_yPOXPraCP6y@pathway.suse.cz>
References: <20260601-deprecate_boot_delay-v1-0-c34c187142a6@thegoodpenguin.co.uk>
 <20260601-deprecate_boot_delay-v1-3-c34c187142a6@thegoodpenguin.co.uk>
 <aibe12WcrLxVWTez@pathway.suse.cz>
 <CALqELGymunRD=ku6CpoZ6OMH9QOYvyPB-EMN24ez5WAeXFtCsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGymunRD=ku6CpoZ6OMH9QOYvyPB-EMN24ez5WAeXFtCsg@mail.gmail.com>

On Sun 2026-06-14 13:55:31, Andrew Murray wrote:
> On Mon, 8 Jun 2026 at 16:25, Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2026-06-01 00:17:39, Andrew Murray wrote:
> > > The printk_delay and boot_delay features are helpful for debugging
> > > as kernel output can be slowed down during boot allowing messages to
> > > be seen before scrolling off the screen, or to correlate timing between
> > > some physical event and console output.
> > >
> > > However, since the introduction of nbcon and the legacy printer thread
> > > for PREEMPT_RT kernels, printk records are now emited to the console
> > > asynchronously to the caller of printk. Thus, any printk delay added by
> > > boot_delay/printk_delay continues to slow down the calling process but
> > > may not have any impact to the rate in which records are emited to the
> > > console.
> > >
> > > Let's address this by moving the printk delay from the calling code
> > > to the console emiting code instead. Whilst this ensures that delays
> > > are still observed (especially for slower consoles), it doesn't improve
> > > the use-case of using boot_delay/printk_delay to correlate timings
> > > between physical events and console output.
> > >
> > > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > > index d7044a7a214bdd4537a5e20d876d99bc3ffe8b3a..a507a2fed5bf4366e24330f763b842a698ecf6f7 100644
> > > --- a/kernel/printk/nbcon.c
> > > +++ b/kernel/printk/nbcon.c
> > > @@ -1267,11 +1267,16 @@ static int nbcon_kthread_func(void *__console)
> > >
> > >               con_flags = console_srcu_read_flags(con);
> > >
> > > +             wctxt.len = 0;
> > > +
> > >               if (console_is_usable(con, con_flags, false))
> > >                       backlog = nbcon_emit_one(&wctxt, false);
> > >
> > >               console_srcu_read_unlock(cookie);
> > >
> > > +             if (backlog && wctxt.len > 0)
> >
> > Heh, this is tricky. It might probably work but it is not guarantted
> > by design.
> >
> > The "backlog" name is a bit misleading. The value is basically
> > wctxt.ctxt.backlog. The real meaning is that printk_get_next_message()
> > was able to read a message. It means that there _was_ a backlog.
> > But it is not clear whether there are still pending messages or not.
> 
> Yes I found that to be the case (see my notes in the cover letter) -
> backlog is only true if a record was successfully retrieved, though
> that record may be one that is suppressed.
> 
> 
> >
> > Also it is not clear that whether the message was pushed to the
> > console or not. It might have been supressed in which case
> > (wctxt.len == 0). But it might also be emitted only partially
> > when a higher priority context took over the console context
> > ownership.
> 
> You say it might probably work but isn't guaranteed by design, I'm
> struggling to see what I've missed...

Ah, I am sorry I was not clear enough, see below.

> As far as I could tell, nbcon_emit_next_record only returns true when
> a record has been printed and it still has context. The only exception
> to that is where pmsg.outbuf_len is zero (suppressed), in which case
> it may return true. Thus if (nbcon_emit_next_record() &&
> !pmsg.outbuf_len) then we can be sure a record was printed. In order
> to apply this test from the various callers...
> 
> for nbcon_emit_one - this returns ctxt->backlog if
> nbcon_emit_next_record returned true. But backlog is *always* true
> when nbcon_emit_next_record returns true. Thus the test of (backlog &&
> wctxt.len) is equivelant to (nbcon_emit_next_record() &&
> !pmsg.outbuf_len).
> 
> So I still think this implementation is valid.

You are right. Your change would work with the current code.

When I talked about the design I meant that we "did not expect"
that anyone would need to check whether nbcon_emit_next_record()
really emitted something.

Or better to say, the design has always been complicated.
And we had to review it when the callers needed anything.
For example, see see the commit ba00f7c4d0051e351e
("printk: console_flush_one_record() code cleanup").
We did it before commit 1bc9a28f076fa68736 ("printk:
Use console_flush_one_record for legacy printer kthread").

And the check if (backlog && wctxt.len > 0) is not a good design.
I would say that it depends on internal implementation details
which might change in the future. Also the variable name "backlog"
does not well describe the real behavior.

This is why I suggested to add the @emitted field into
struct nbcon_context instead. It might look like it adds some
complexity. But the semantic of this field will be clear and
simple. So, it should make the life easier in the long term.

> > I would prefer to explicitely set some flag when
> > nbcon_emit_next_record() really called con->write*().
> > See below.
> >
> > > +                     printk_delay(false);
> > > +
> > >               cond_resched();
> > >
> > >       } while (backlog);
> > > @@ -1595,7 +1604,9 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
> > >                       nbcon_context_release(ctxt);
> > >               }
> > >
> > > -             if (!ctxt->backlog) {
> > > +             if (ctxt->backlog && wctxt.len > 0) {
> > > +                     printk_delay(true);
> > > +             } else {
> >
> > This changes the semantic. The original code call this when
> > no message was read. The new code would call this path also
> > when the output was suppressed. It would probably work.
> > But still.
> 
> Ah, good spot! I missed that.
> 
> 
> >
> > >                       /* Are there reserved but not yet finalized records? */
> > >                       if (nbcon_seq_read(con) < stop_seq)
> > >                               err = -ENOENT;
> >
> >
> > As mentioned above, I would add a flag which would be set when
> > con->write*() was called.
> 
> I'm not sure why I tried to avoid adding members to nbcon_context, but
> I prefer your solution, it isn't so fragile, and makes it easier to
> understand. I'll update for my next revision.

Uff :-)

> >
> > It modifies the type of unsafe_takeover in struct nbcon_write_context.
> > But it actually makes it more compatible with struct nbcon_state.
> 
> What is the intent of this change (bool to unsigned char)?

I meant that my proposed change switched it from bool to 1 bit.
But I see that it will not be fully compatible anyway because it is

   unsigned int unsafe_takeover	: 1 in struct nbcon_state

vs
   unsigned char unsafe_takeover : 1 in struct struct nbcon_write_context.

Honestly, I am not sure what C standard says about bool vs. bit
and bit vs. bit operations. But I believe that compilers would
do the right thing in both cases. Anyway, bit vs. bit sounds cleaner.


> > My proposal (on top of this patch):
> >
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index 5520e4477ad7..5a86942e55ef 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -290,6 +290,7 @@ struct nbcon_context {
> >   * @outbuf:            Pointer to the text buffer for output
> >   * @len:               Length to write
> >   * @unsafe_takeover:   If a hostile takeover in an unsafe state has occurred
> > + * @emitted:           The write context tried to emit the message. Might be incomplete.
> >   * @cpu:               CPU on which the message was generated
> >   * @pid:               PID of the task that generated the message
> >   * @comm:              Name of the task that generated the message
> > @@ -298,7 +299,8 @@ struct nbcon_write_context {
> >         struct nbcon_context    __private ctxt;
> >         char                    *outbuf;
> >         unsigned int            len;
> > -       bool                    unsafe_takeover;
> > +       unsigned char           unsafe_takeover :  1;
> > +       unsigned char           emitted : 1
> >  #ifdef CONFIG_PRINTK_EXECUTION_CTX
> >         int                     cpu;
> >         pid_t                   pid;

Best Regards,
Petr
