Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6193DA5D5
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Aug 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366147; cv=pass; b=pqhDQeBQPK+K1DY1ThrcA/YxXCRoBO0e+9aFrSQvUt6xVhDZPEY4QqyQkw1wvf06O71PMYZJzQKE4vIRSSP91OrE60MmBCM6NhSDI12lZukH1PLD9wWkubdwlt9MI7fcUEHotLgmBpZe5YhhjO1nJKqLl/zrqlZoMrW7oa1AKCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366147; c=relaxed/simple;
	bh=N5Gsz6tNICsJOfdntkPkZdZjEdKtMimVkLRRn3KYv18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6UDS76vcTRS9LGqc9zeLia5uye1xNGS8Y5bEUuTwh/UKwcJ9tZ/4KODAVBj5EhGyexvcVdVtT48GUObUoO4erD1E65Hla8MyHxxaUfyeiQMaYfFsEojf6ENn1RCVpMVXMDR1EOWnupP5A9f5yst+bcYSPNMnaUnK/xP3BfRW1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbrUghtz; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbrUghtz"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so219192266b.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 10 Aug 2026 05:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366142; cv=none;
        d=google.com; s=arc-20260327;
        b=q0YqHPZUeBN0iBRTvlGae2PLaGq5d1s2HO3/8fdjV+qqcMtVdIHYRe1jSdVxrVhXte
         0Ls2wG6bTTDDaOVOz70QSpaAT+sBO2gASRY6rlqDDh68/nxeiTBmXD3n0NwIjF3nBlmK
         dKNjiyDBj6BaeIkQYpKKYbADsiY4n6MURpqmOrzr9CQXk0vjnB/6iD9wvR1JCSQYlKaY
         5SNEO5fvWWjRTtc5xwymkxgGuSbZovK/mdO4fJzPgCG5SoaasSTRIL8E9WZUUiQcv3vw
         0GYOPUbZfC8S0coR8aGmNwnFBHpnFahv0npjJZu5UyUbfv5FXjhzj65rQ7YvnO4wWGFE
         TjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFK0DpUmt1yzhhCt2rvujUuVSNjfSYNwcT83/Jpc5KM=;
        fh=ncKj2zUKJp6V3Yd9Euhbw2AP0c6j8UjtahzH6rfKQQs=;
        b=DY3/fbmtZGpqqgbbH2CpodGmB0vs3ZPfNWf8V6xC7CBQDcEzMnUFReAzedBcWHYl94
         A6axS3Ke1V+D5PKk7fMyZ1V5r1ZBoHbejQV8w+VPIk+jZ5QTybqga6LrjlZHvW8aJeLs
         a+9WhyQck+Q8Z7NUXTNgG5CCXuYhGLYOuoMWSUy0W5RpuwbJf2axtKHRb4Nu1dIrW4V+
         cnZnSxC3xryHVFiHtkEZLDl2q+/+nbkUsRh8FizMGjcWnuBlxf7MaaQJK/gsKAOG+Bcp
         szaWWQYKKwgZfow56aO8erkBzuXh8zA2HkXT03Q/KXUOxnqrvxTjvvMOo/9HpeK6QTsX
         dgfQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366142; x=1786970942; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFK0DpUmt1yzhhCt2rvujUuVSNjfSYNwcT83/Jpc5KM=;
        b=pbrUghtzXwNOiFBmzfFzkyDj1nt4lqi8835JRHYHe0kg+xiCAsLeguEKwouL/ZpMiw
         EVpnV7Rdj73r+fEdA/9wP52ztIK0vRtITo/aAwEqJY2VqqfOHuMyrWiuYiVaITTUwobV
         pFBbdgk/78dT3qUor1s85VeMDnpz4dS68pIliUg1PFYPyQ4N5EpGDujPD6vhl/7MrEoM
         zkP1jF4XnPVOTQ1Wa122z9m3LHMFGMzSyiwfwZzpIOAap0kFcs1ZMIiopyITU2yidEQq
         NV0w/6Byh50LC5EWxckCrmvV0u1E+DAUi0Nev9OorgoHTrTr+S5Nq2ExR020zuaa27em
         CKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366142; x=1786970942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFK0DpUmt1yzhhCt2rvujUuVSNjfSYNwcT83/Jpc5KM=;
        b=sX0yUxlwyPTIvIldRsTY2OGDMFaFOroIr+mPHhvqKvHuD+9aAQlBGrLICeFpTJU/Er
         TFwlqI7zkX5AbUVyplLoCWhqJl5TqaCgZ/4pV1Pkpa1bJ1ETPmasmCeLoEkBTOOLMZWx
         Ns8VT9Tt2v+RqoggN45d/78CZdNP7UPoJ9nLElGYql6880CsNJByL49b4FNHCCNmyunP
         djYoEJW/LeCwyvV23R/HLG6+8HkuMz6jTFKW/MZlnRSPYZNcCgUl6fgV8yk5puiXSIfk
         sp+q50RTZB2pdNwQlOi9yU1sLxCL2Ev7ovKGooIdQp3kw3wgsZOL/ePaaGvFqCZhvEyQ
         2usg==
X-Forwarded-Encrypted: i=1; AHgh+RrqL3s4OEuE7QN7ykH4u8D3YOcEjXtfzzT7MEa6OetEtT1bx3D9SF2neiEYXehZxoR3rVKvZ5tFufqPG0oyRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwndAdLAmzCGgJ/IDSHLfuwnfvor+EGgP2m/VbnBUYgRRco/jhU
	10MtfOOhw3fPfpYzgMk4de1ps8qFIVBv7oBR5luZLxhm6rCEMnr9diKaT8eJyzOOkVqI8Y4R7x5
	06sOWFrphzepOmAEX/ZGzEIydgqvOap0Au1G0niCn2Q==
X-Gm-Gg: AR+sD12asl9KvOqYHjukiz7gd6JqKAGoXQU+GyhRaajlMLVs5xpr5vGILoKGC9DroYP
	FxwGynZMOM0mzKQHxcoQ/RnsP5dWOcBeLjxbCqKHVOSGcpcowzZYvzvtuKq7j/mqx24YdmY5r0T
	ufUDpOr/qUgqV4VPzlGjIHSp1vrf/4ZX5vHj+cttbBbYS+jClD+56mtj7du4K8krv2T/sBwtQMm
	q8NAajvGaXAUld+8HTsdcTaIs+J052n4v2DZbYP8mgoINCVk+RM7lMTEtUnbvkK8caHqsab54vG
	dbQJFfdv7caEGlXEadwJp388IPux+3dSXyTvW9nIQUiutW2PLXEdD560tGMy
X-Received: by 2002:a17:907:ea8c:b0:c20:34dd:5ee3 with SMTP id
 a640c23a62f3a-c2039cad20dmr2174576166b.17.1786366141625; Mon, 10 Aug 2026
 05:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <20260810124351.390741F000E9@smtp.kernel.org>
In-Reply-To: <20260810124351.390741F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 13:48:47 +0100
X-Gm-Features: AUfX_my8sqCbiksSZhYl4zC9UNaWzsIB-eOG0kAP6PhpMFw0Lde39sGEMEU6ImI
Message-ID: <CANk7y0jbA7XDzNtKUFsYU4gcVZ+TRJUntc+tzmL6CKgFtpqaCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:43=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Deferred callbacks bypass `debug_rcu_head_queue()` check, causin=
g immediate list corruption on double `call_rcu()` and defeating `CONFIG_DE=
BUG_OBJECTS_RCU_HEAD`.
> --
>
> --- Patch [1]: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any =
context ---
> commit 5205f0afe602a3f93ee865a26d94981f93553b7d
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> rcu: Make call_rcu() safe to call from any context
>
> This patch defers call_rcu() via a per-CPU llist and irq_work when called
> with interrupts disabled. This avoids deadlocks or list corruption if
> call_rcu() is invoked from NMI or instrumentation.
>
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 96848fc1f02b8..ff9a2395c9e8e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
>
> [ ... ]
>
> > -static void
> > -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y_in)
> > +/*
> > + * Also called by __rcu_defer_drain() to re-issue a deferred callback,=
 so it
> > + * must not re-check the deferral condition.  Either caller may have i=
nterrupts
> > + * already disabled, and a drain of a remote CPU re-issues onto the dr=
aining
> > + * CPU.
> > + */
> > +static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func,=
 bool lazy_in)
> >  {
> >       static atomic_t doublefrees;
> >       unsigned long flags;
> >       bool lazy;
> >       struct rcu_data *rdp;
> >
> > -     /* Misaligned rcu_head! */
> > -     WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > -
> > -     /* Avoid NULL dereference if callback is NULL. */
> > -     if (WARN_ON_ONCE(!func))
> > -             return;
> > -
> >       if (debug_rcu_head_queue(head)) {
>
> [ ... ]
>
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
> > +
> > +     /*
> > +      * Instrumentation on the enqueue path can re-enter here from ins=
ide the
> > +      * drain.  Re-queuing would livelock it, so drop the callback; an=
 NMI
> > +      * cannot loop, so let it through.
> > +      */
> > +     if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> > +             WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> > +                       "call_rcu() re-entered during callback drain; l=
eaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rdp->defer_head))
> > +             irq_work_queue(&rdp->defer_work);
> > +}
>
> [ ... ]
>
> > +static void
> > +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool laz=
y_in)
> > +{
> > +     /* Misaligned rcu_head! */
> > +     WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > +
> > +     /* Avoid NULL dereference if callback is NULL. */
> > +     if (WARN_ON_ONCE(!func))
> > +             return;
> > +
> > +     /* Record the caller: the irq_work's stack says nothing about it.=
 */
> > +     kasan_record_aux_stack(head);
> > +
> > +     if (should_rcu_defer()) {
> > +             call_rcu_defer(head, func);
>
> [Severity: High]
> Does this bypass the debug check for double call_rcu(), potentially corru=
pting
> the callback list?
>
> By moving debug_rcu_head_queue() from __call_rcu_common() into rcu_do_enq=
ueue(),
> deferred callbacks are added to the defer_head list before being validate=
d.
>
> If a double call_rcu() occurs, llist_add() in call_rcu_defer() will overw=
rite
> head->next. If the callback was already in a normal cblist, its next poin=
ter is
> overwritten with defer_head->first, immediately splitting the cblist and
> splicing it into the deferred list.
>
> Could we check debug_rcu_head_queue() here before deferring, so that
> CONFIG_DEBUG_OBJECTS_RCU_HEAD can safely catch the bug without list corru=
ption?

No we can't debug_rcu_head_queue() can't be done from NMI and doubling
calling call_rcu() from NMI or interrupts disabled will result in
leaking some callbacks but it will not cause a deadlock (validated in
testing using a kernel module that does multiple call_rcu() from NMI).
