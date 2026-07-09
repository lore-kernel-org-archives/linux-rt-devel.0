Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30621E098
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607282; cv=pass; b=VmptFoRiwcwa+dxKBo+zDZe8fiqFlGA87j6UzjGINcWn3wslfiKAkAAabFHvkyurT5b0mSWpCeTb9VnxvO5+LiL1CR2v05mJSCdHPeDq7sJwLumat1zfFHigdOlRywbWrSUsWWUE8dZRY5F8L0tRqH/pyBSzXdHhJt5++GHY7/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607282; c=relaxed/simple;
	bh=ew/ahYHt1PSqBy2HvgZ4gSry+8kYZ616VqSL2DoDe+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPtvfEie+YP/I09XyebsrNenh4ckPD8Jk3z0lE6pinsL4Ie7Lwd82iuSC2d5brkoXOAEse4T0RTgJnin2B858PE6iQKXi7sh5/uHuyrDqPifas3vGNp+HY9lRvxaUnZqHF/nPeu3wBVWdMIejdADV30BZ7/FFUWxraqdV1DuS5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=0b9lG4VL; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="0b9lG4VL"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so882393a34.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783607279; cv=none;
        d=google.com; s=arc-20260327;
        b=URr0YQRs4ShrJ4vrqb73/hmHG2R7I0DhjVHdUOFjZ5LnnwTR26Z4W/RJfKGo7tqANy
         bTmbjrrTGwNtBVKEg+KSmIpUiE/foQZZEyrv5+wpoBL/xp/iXZWv9zlFa3lNiubG7b6m
         18BurBaCAGhpTScYzMQY0FnGBIrK/feIyXGHyStzvfJYyumC/aBP8UaepPlp+EH6L983
         vZSfYupXFHY5n7oKtJQQhqFKF9z5IlUfSGEi9GbuYJWJzA2nOVrdtjqxCJZvxhfmK+kD
         +bnnAALDjgc2n/CtFhgmI65S0kjOTyQ3ns48bAuCB4CNDsRvGi3Foh8IsMxzdxVwsP6t
         L2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o/Aj/fQ0/cX0gUBelTJEVsUYvKgREoT3ILbqcgtsbZk=;
        fh=jbLPfTPONCsC3i969GbJZ03ThE4xD6Y7UwmZSkzpH+w=;
        b=nCim2dTx1oPP9otg8CvfzZITprnUIW/t7X2jdCXqrfxWgQMh9yx7j5pz2tBTtXJFPg
         TkkkIWQhVjVDQYE+alYzc3wN8wtQDdgoUUgjkWF0YNt9bKZSoDP5a0A8XcRQ3YMJ3xdt
         ZP2yDBoeMgXRr7iBxfwt+hOVOivIVLjBMseOJkPFJVY9fGdYlhqQSk1UbqUG5J3pYng2
         4kJcmcrH9YVHMSdOeOUrEwDBbxQp5OmGHib2u2AbnLrncilqDyHdqv7EUkram5lgWc//
         dvWKbLID7Hinm8IY4NK1kFzMLeqiB9Bx986Qjsg/FM6d26a5di7dEBlM5zHX22okPXdv
         AD7Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1783607279; x=1784212079; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/Aj/fQ0/cX0gUBelTJEVsUYvKgREoT3ILbqcgtsbZk=;
        b=0b9lG4VL4Kv67UC/mQUeTkO79/hc6k9300zviy0H9s5Mjrvs0ZrEY35TDWGKXhbw9b
         kOq7PwpSV8HQOF0IKW9bcwr0GIVnaTBEdE43WA3sEJe97w/XNMGj5z/laUnhau7bfACK
         MD7Wgb5JNZYYUF9hZ1eNjNPYAPOVB0wAj8jofFO1rwzZUw7FUK0oAciMfknVQL8+Rp9B
         JXaV84B48S9tFwkl7N8PRtD/o1BEx89TQqD/e8f31joyx11RoP4QrpLb02QStjRzQy1H
         8w1yL38v/U9huUmrdmIOuggScbEneu9IyCHLfSKwl2luz11cBe57oBty8gPuw6a0CZZn
         mEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607279; x=1784212079;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o/Aj/fQ0/cX0gUBelTJEVsUYvKgREoT3ILbqcgtsbZk=;
        b=ELu9DTCPMcNtCBXc4eNloCvfmaeuxbLD2lF8qaNYKrKkLM/LiYkngjbbCAhBlxAUqt
         /K6qMbOVKMJyqsb6jiP3uW6FV0vqF2UimcZYkH46BJN18f4HKxMGoPHq9EnjmulvMUcK
         3XkTMiB6In1iZxQhEUqET0jzm3sL+bt3kgKxcDhMEZnf7GalirWTSjCdCI82RyJqetLD
         A/+2+2adwgycPUL3fAKpFzbDdVPGgOkJ5uC9hqq0xu5JCfd2tdxnqBwn+Lj7dd9/KuQ/
         Z8xGlieaXM5JPnylTvIc7fOr9LvV6l4zlS3jbfL++qpT+DHoEcCdspd/G3JyZJbgMcMw
         FUaA==
X-Forwarded-Encrypted: i=1; AFNElJ81dZVFcVt9x56FJ9iqQu4LzKYgwmPuCuqkYN4sd6GrhaQyc5pUP2AbFpFu40RjUj9DpKNgPBl5F+DlTaP7Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq3KPrb4PnY1psVWR/7nZvnexf5kCxaAwFjeQbc16DJWJoUxOI
	mxcxhB295gH4hqTyqp4gq9ctfcY/bufcNGjb0ycQPizaXYExNsrUPSEmv/e5tC7qfahCI2Ra1YZ
	zMZ5G6p3+Ki3gFH8FTWvg2NqZ4Qw1K4PRCwFaRHPWYQ==
X-Gm-Gg: AfdE7ckrbwB6AzgPTzxsGytCc2vJNw/ssfpq3/PnQlU9DkdhguO04/T1YaVM5rgZ2Vh
	ztglP84IKE9XAuGIA4rR42PF+lmiEV/FTKtsflppyXzVfweAq5qYCN3u0X6DmfkazNGrrD2t4/B
	o7wxvmMjOAGxkKCiYuyD7TyqR6GI+xCTCCH5uIMdRy1mKzl4oyQfwbf1onY5RLZQ82FYpueNLYR
	QSNis4J4n8JtFlKOyE8lBjn0Y0l3fE9PYVlrMC61JvcSzne2KpP/TNJy06WxeIB9IZaV3JCtKAs
	cU+DZJ/KdVjMQVuWgojA/kiLUk7sciXSroiKU4k0b1rqfKUNkNF4El3C6RCQKtA5I0Onhg6V8wk
	fKbg7EaDdCO/YhPZdTlata0YyhvBf
X-Received: by 2002:a05:6820:210d:b0:6a1:87cb:c34e with SMTP id
 006d021491bc7-6a36da8c20amr5154700eaf.72.1783607279485; Thu, 09 Jul 2026
 07:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260703165654.71be8707@mitra> <CALqELGz-KSrGq5JYvLedZiO-p21pjpRKbceO+jiSfwZGyx+91Q@mail.gmail.com>
 <20260707145411.53a10893@mitra> <ak0VguIf-PxmbUOS@pathway.suse.cz> <87qzldvqpm.fsf@jogness.linutronix.de>
In-Reply-To: <87qzldvqpm.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 9 Jul 2026 15:27:47 +0100
X-Gm-Features: AUfX_mz4PcZ8QKTOvulicXteeeMZuJNGsMqSn_rhQXpmhC8-QWtUxRPj3PV0YiM
Message-ID: <CALqELGx+7RSKL0+kdOxu0TpXaOifYkzxmOTv+4gTSHqrbLEJ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Benedikt Spranger <b.spranger@linutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 8 Jul 2026 at 09:19, John Ogness <john.ogness@linutronix.de> wrote:
>
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

Is it possible to apply synchronous mode for both nbcon and legacy
consoles? For the debugging case Benedikt suggested (is this the main
use case for this feature?), it would be helpful if a developer could
indicate a preference for synchronous mode without first determining
the console type. Though I'm not sure what means you propose to
indicate such a preference.


>
> ---- BEGIN SYNC IDEA ----
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2fe9a963c823a..beb5bb3c037b5 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2456,6 +2456,8 @@ asmlinkage int vprintk_emit(int facility, int level,
>
>         if (ft.nbcon_atomic)
>                 nbcon_atomic_flush_pending();
> +       else if (have_nbcon_console_sync)
> +               nbcon_atomic_flush_sync_pending();
>
>         if (ft.nbcon_offload)
>                 nbcon_kthreads_wake();

My interest in misusing (not proposing that as a solution) the
emergency mode, is that the flush mode is nicely abstracted by
printk_get_console_flush_type. Depending on how you trigger the sync
mode, could printk_get_console_flush_type be expanded to look at a
flag and return ft.legacy_direct, ft.legacy_offload or
ft.nbcon_atomic_sync ? I.e. if a sync flag isn't set then
printk_get_console_flush_type returns based on NBCON_PRIO_type but if
it is, then it shortcuts to ft.legacy_direct, ft.legacy_offload or
ft.nbcon_atomic_sync?

I'm not familiar with this area of printk, so please forgive any
obvious issues with this. But as someone that happily uses printk to
debug the kernel, it would be nice to have an easy way to do this
without the friction of figuring out what console I have.


> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 4b03b019cd5ee..8f8f29f757614 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1200,7 +1200,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>         cookie = console_srcu_read_lock();
>
>         flags = console_srcu_read_flags(con);
> -       if (console_is_usable(con, flags, false)) {
> +       if (!(flags & CON_SYNC) &&  console_is_usable(con, flags, false)) {
>                 /* Bring the sequence in @ctxt up to date */
>                 ctxt->seq = nbcon_seq_read(con);
>
> @@ -1654,7 +1654,7 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
>   *                                     write_atomic() callback
>   * @stop_seq:                  Flush up until this record
>   */
> -static void __nbcon_atomic_flush_pending(u64 stop_seq)
> +static void __nbcon_atomic_flush_pending(u64 stop_seq, bool sync_only)
>  {
>         struct console *con;
>         int cookie;
> @@ -1666,6 +1666,9 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
>                 if (!(flags & CON_NBCON))
>                         continue;
>
> +               if (sync_only && !(flags & CON_SYNC))
> +                       continue;
> +
>                 if (!console_is_usable(con, flags, true))
>                         continue;
>
> @@ -1688,7 +1691,12 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
>   */
>  void nbcon_atomic_flush_pending(void)
>  {
> -       __nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
> +       __nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
> +}
> +
> +void nbcon_atomic_flush_sync_pending(void)
> +{
> +       __nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
>  }
>
>  /**
> @@ -1701,7 +1709,7 @@ void nbcon_atomic_flush_pending(void)
>  void nbcon_atomic_flush_unsafe(void)
>  {
>         panic_nbcon_allow_unsafe_takeover = true;
> -       __nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
> +       __nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), false);
>         panic_nbcon_allow_unsafe_takeover = false;
>  }
>
> ---- END SYNC IDEA ----
>
> BTW: The sync mode is the final piece so that PeterZ can start using
> mainline code for debugging by serial instead of his own workaround [0].
>
> John

Thanks,

Andrew Murray

>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=debug/experimental
