Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FC411FB1
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Aug 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768050; cv=pass; b=kDIff45W35ub3272IX5GBFNgAjzaDPJ8YPKCnB/EmIkN4lu5n/SEqUKTCwIf9/HN/3lqkvE2iY7bl0leqvtQOSULklDKZ4GnpolXrbgC4sOkUyeHw5sAG6xWkueLglM/1v0CS74bRH0aSvslr5lxXP7TWxsUFHs9Bc2TyJtYtpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768050; c=relaxed/simple;
	bh=5kebS8pMZi+Qnu3Pne9n+Gcqlzlf9paHIC1+/HJAbOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOCNOq7bfihIGtIHsMKbSBTM5TJ8FTBKZNAZsAIuXLgqmUmqkOE2KFuPu0YApNjDmM2GaSbCUs6se0Wh0xgZyGY5y0jmSg//7khQALTsA4YJHHzyaYaSikUYmnSqxTbGVob+w5nE4O/KHBWlRoJR5DHfiirv+Ab2i1sEmfRjGsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQvjsF1X; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQvjsF1X"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1670dad7a8so492578866b.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Aug 2026 07:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785768047; cv=none;
        d=google.com; s=arc-20260327;
        b=rbhMUNP2XuswDJ+h5NfTMa9k3SvmE1zFZbJhLcklIlFatjA9zzZTHhytxcvPl5Zgbq
         2xAyvlP7SuHcJPD4AmOl28yVRxDVzBv7MFr5CXufjWidCVlLlMFD6jGI5iFfrzdtmhlI
         8/Jo2JoSjJVRTVwlUWhmdKUb5Yww3rvqaXjQUMjMiuAE3MTDKvXv5V/t4rmlOQIkLQx3
         s7kR0aSOu94TcSOTyDxKwBJpraUaGqsHiEMbp4mSaw/v+SnlLMeKto2JHFN7wXNucphg
         prcKUdxLHuzaCw/QJ3q9svlwsoW9Z1HvHTOh1Mx+hDAVgsmD8hzKDAIiuI3Kr9jIodaR
         W32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=43vcEMd1q8IU7lDqptyYtNca+YC1kL3gqmLuBjWx/68=;
        fh=v1SRQGbws4op/eV2q4RpVoENTCRoTS8DZN/HUO3PKzI=;
        b=kiB5ztprD/r7HbmFKgDrr/rZFno8bZVvX0oZ7M//d+G1llOvlhUNdLxD18ZDUzrHFP
         48LWX8Tn0WKLm3bGBNWAqinMUcgEe7c+kJFrHWbMR3Cz/O9Uoq6oVsdDmPqZ3Q/+8Xnv
         wWnKLg36/JkDVYesUa3LqybvelQwjNU9m0+j5pbX3he1siCu14PyvxKAzpOwY7oP6YcV
         zDfpXNWWs6j3Dl02d7iW7ybbO0paGx69AmBV49XNVR4zY3DAdfTSuWA6A96FlKE1HD0/
         nn7lxY9Wm+ozw/vGnPLguLej18eMoOblfLyqZbk0Pl/4ZZHiZv8eOQhV28WGOYE27tFc
         hyGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768047; x=1786372847; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43vcEMd1q8IU7lDqptyYtNca+YC1kL3gqmLuBjWx/68=;
        b=HQvjsF1XPR337+fO+N6mScJJE2w7/Ib7s2sG4vN5uTrwTJLcqDr++M6JZDSk9w8vQ8
         NgqK9G7uXgMrd6uyD8HnA6Pxo6tUcUYPaYJORCFNNgO2c6WhMPtVEFEGjNZaohcJl9o3
         YVDjg7c3KYomy4r55ploEOxFqESEkOnKuJgAO64jOBOfuRC4p91JIWnHnOBND2X7iLwf
         bVyLTC2ZY7UMx8zZiNHBzIXOMD9SBoXQjeivxP97vKeyLiRXfx3/o7RZ/bCmp1uSrcHn
         7wqpH2aF7PFI3v1OkVpzdJ+94b6JJ9czpG8oKRNoJdbzlPezkGznl7GiU6Rle7dEcmyb
         F4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768047; x=1786372847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43vcEMd1q8IU7lDqptyYtNca+YC1kL3gqmLuBjWx/68=;
        b=DEyLrMBybbsFhN6y+1N9J/EqaK0u/ZEZ/uuaJMvGD9pwi60DqnjqxZzJ/PkYRNex1i
         l8iopFVh8/mX2xtD8b8GY5sCJ7k6fdOc24MTr6GpdHCSXBeTpMvd/czE4w5sru2jxfRS
         8UEbBAE+2xNP/vxSAVVbnPhBMuq85CF/SV+ozQeCT9PgL3+x1u8Z2TFClVt7oxy1qRY8
         AbudMe4FevlE7DoOdSv2OlnmtsfZcHetwrsnTQuS71H3uiIMWNWNWiKtFf+t7PO/p/8s
         t0IKPOyJ9PXQLKACzTQ3g1OH4ZHIFZOiw1p9xU8F/aXLo/O78XQDxylTyKE35TqWeg9m
         XkJg==
X-Forwarded-Encrypted: i=1; AHgh+RqYT+k9prAEsJk9vxzeY9zwW9VcxpEK6TYsYHE48VJ1H2cw4HPGXt+ljkcENQmt4wgIosgt3I/hT6fWEhxwRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPIH4nMRMeSRo5/BcUtJfP1OiQ2MiikvU1U4gj0eYJzSxSKBeC
	RIBDa9QN3uakJsMgvaabpY0ynr8TT3OqJi/vHQYzHRhNMtVLiBtwuXPSTPOeEvt3l7DuYBksXdX
	atO23rRMkxNpuGdGw1iVUWv2iCPoKmeg=
X-Gm-Gg: AR+sD13aRLKnegdRcTDN4YkNthJZBhXj3T020LaBdREGlRuOUfwNZ7454nUH8ELnRq8
	bSkfW3dxX3mxNtA40Rs4XlOC8eLVBKatINCeLHp60jBED2wS35RoTEk7F+9Bmb2FTsaMbvSFKQt
	GxpJqy8aUWgZDKMw1RBfDssDE4j7HlkAP2YAzH6wAroHGR6uT0Z1RapqnLpnxe95+WzYWo0iagK
	jQ/3WXjTfdoqvPKZVNJL1wDLmiWQONlxL7SHOt0mnxVvCcG8f8A7VeYusDMr096K6PjQGsW+tE6
	pMPZCraNjfYW44F+PjfUCEiN5sAhkUyrIPePFbSeosAwp35HpcrGfU8tD3Bjifj4evB8mSw=
X-Received: by 2002:a17:906:7186:b0:c1c:2aa5:322b with SMTP id
 a640c23a62f3a-c1fe8168601mr589342466b.2.1785768046472; Mon, 03 Aug 2026
 07:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260803134839.2103051-1-puranjay@kernel.org> <20260803135329.2327280-2-puranjay@kernel.org>
 <20260803143505.2E3D21F00A3A@smtp.kernel.org>
In-Reply-To: <20260803143505.2E3D21F00A3A@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 3 Aug 2026 15:40:32 +0100
X-Gm-Features: AUfX_myg5FkRhhwJrWlROWqtotno0-Pomq3l_iqF2gTN_FLgC2KCpZALE0D3KSY
Message-ID: <CANk7y0g+Yf0Vy0jZCoD6NicDXdJ=wo4WpmiBLo3MPqKaNUXO-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 3:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Relocating `debug_rcu_head_queue()` into `rcu_do_enqueue()` bypa=
sses double-free detection for deferred callbacks, silently corrupting the =
lockless list and inducing a permanent hard livelock during `rcu_defer_drai=
n()`.
> - [Medium] Invalid `WARN_ON_ONCE` in `call_rcu()` falsely flags safe NMI =
executions due to a flawed concurrency assumption.
> --
>
> --- Patch [2]: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from=
 any context ---
> commit 866e1596ae5a7314657b9b0164dfabf922016c70
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> rcu: Make Tiny call_rcu() safe to call from any context
>
> Give Tiny call_rcu() the same treatment as Tree RCU.  When interrupts are
> disabled and the scheduler is up, stage the callback on a lockless list
> that an irq_work re-issues later.  One global list and irq_work suffice
> since Tiny RCU is uniprocessor, and there is no CPU-offline drain.
>
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index dccccd6be9411..5736b964d8ee1 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
>
> [ ... ]
>
> > @@ -42,8 +44,86 @@ static struct rcu_ctrlblk rcu_ctrlblk =3D {
>
> [ ... ]
>
> > +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +     /* A re-entrant call_rcu() during the drain would livelock it; dr=
op it. */
> > +     if (rcu_defer_draining && !in_nmi()) {
> > +             WARN_ONCE(1, "call_rcu() re-entered during callback drain=
; leaking callback\n");
> > +             return;
> > +     }
> > +     head->func =3D func;
> > +     if (llist_add((struct llist_node *)head, &rcu_defer_list))
>
> [Severity: High]
> Does moving the debug_rcu_head_queue() check into rcu_do_enqueue() bypass
> double-free detection for deferred callbacks?
>
> If a double-free occurs, llist_add() will be called twice on the same nod=
e here,
> corrupting the lockless list by creating a circular link (head->next =3D =
head).
>
> When the irq_work executes rcu_defer_drain(), won't the llist_for_each_sa=
fe()
> iteration infinitely hang on the circular list before the delayed debug c=
heck
> can prevent the livelock?
>
> > +             irq_work_queue(&rcu_defer_iw);
> > +}
>
> [ ... ]
>
> > @@ -157,29 +237,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -     static atomic_t doublefrees;
> > -     unsigned long flags;
>
> [ ... ]
>
> > +     if (should_rcu_defer()) {
> > +             call_rcu_defer(head, func);
> >               return;
> >       }
> >
> > -     head->func =3D func;
> > -     head->next =3D NULL;
> > -
> > -     local_irq_save(flags);
> > -     *rcu_ctrlblk.curtail =3D head;
> > -     rcu_ctrlblk.curtail =3D &head->next;
> > -     local_irq_restore(flags);
> > +     /* An NMI reaching here entered with irqs enabled, so the enqueue=
 can race. */
> > +     WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
>
> [Severity: Medium]
> Is this concurrency assumption backwards?
>
> If an NMI interrupted a context where IRQs were enabled, that interrupted
> context could not have been in the middle of rcu_do_enqueue() because
> rcu_do_enqueue() disables IRQs via local_irq_save().
>
> Since it's impossible for the NMI to race with rcu_do_enqueue() in this
> scenario, will this falsely trigger kernel warnings during safe NMI
> executions?

This code assumes that irqs_disabled() returns true in NMI handlers,
so the execution should not reach this warning in NMI handlers.
