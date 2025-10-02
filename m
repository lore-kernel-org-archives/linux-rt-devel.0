Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938425B662
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425283; cv=none; b=o+LwJx19VrZfRO1O6Ze4NWyddJOEoLlY4qdQOhQj3JBlMMrhQISDUSMtitilH3nJoLKYCwRWK57GuqbbKFiVFtB379UZYgerr/w/ZYf8iBBrRt8EidjJzOYWbWPN6s91yLIPT0xwHbqBBoaygu24XoTs5rU5Gf4QFPYN+gk0Ggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425283; c=relaxed/simple;
	bh=PdMR2eXs8RPVLBGtWIlswMR7IDmtsOYvIQ4p+zqnFFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c88dVkeCs/wLlhzLeG6DgTsfRaTGr5yzY1452lGT4S5UJT53CBgA8qHV0mT3VDgAw4TRmX+NWoZrg3avFEtTFEOHU8nnx1IMypr40/2ta+y/IgUZ4punkM82cOHIOdrXkd4YNSSKy0YW582PgfGqfRFxbPJJwankcgNleDnuPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALlXocbQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALlXocbQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27edcbcd158so16026795ad.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759425281; x=1760030081; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dSS/bZVAi53nx7gSnHDBdozny8jZisgC0WMWJX21pw=;
        b=ALlXocbQ5LjKtNPHioPjOgLUBGV7PlUPts2zrntG9yl4/IHeQdxEfv3Nciy5wqPBGX
         UtpZNORAZm572Vlivg1A5i4pjAooZfsHSm6roKidxFD2L5JlnmGmzsPOApLw7/dCxGHs
         g5Yv4+vhnkMifvLnYptjCKZOnzSED+na5MJJ5zC32sB+hcWO2UaN+9AD0bS6U58KovM4
         P7iS1mP+mWs01H4PEgUyJmxtk3n/svb6Q4OlXITF5ashrjOgrLpLCmMt2SNDv+mvRQqY
         jgte2Wdh2E0RsjC/MWFwZjbAxAu3ffrZt8KERiummr93rwVGaWJuYfHTSzZW8WWKveJs
         t9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425281; x=1760030081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dSS/bZVAi53nx7gSnHDBdozny8jZisgC0WMWJX21pw=;
        b=RD9YDZR172bKnx40MH9httbX80mznd1FyOgKCpBlo/N0VRaD21AzNkQHLxVCKode8V
         a6SMFUa2guxRiajUdeu6zVSxxY3ueYXNAYCO4t3Hn/DFpW8VDJzen5B5J88CjPGj6cqq
         SSlRsdjxeyE6Hw/LfnZRoovnhxrzXKQq+uBLpikcqN/7cYscUZTBez4nf8ylSpAmsLiD
         /JjT3AD8HTtE7Mz0c57+2X7SOUbu06MhrXWzburv7eBgjWcM2E7a6hea+BWvN0hWVKx4
         6LcBk5QoHP92ZKMEYFntzBEHfQTVXAUSLGCriiLIXz0OJm9bcMjxfFJdIdSfx+4a6BxB
         Bu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtFW5Kuf9120nPYsXV8pDJbeFK3xLM05vNCDvkZRtY0EZIuA18MRxRhjB+NgCyFTTs0rR9Ncje5cYEq7h87g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk3t6c2h4DTAcMtCb34J1UOq+AXk7lbUxI8ooHJieravRPXoKF
	zJSgO/lvhgRqTaDtqlmxoeAeHQT6zGgSPpxJjNnTVMBIUNkEsCAU1F7M2AnY1C/3j767lNkF2lJ
	m6b0KMda2ORfAeRwueQb02+1H+6Yx4CtbmNNnHiry
X-Gm-Gg: ASbGncsqYv5Et1HiLaDRGWvEVk1LUyWu8Qwmkb01/ZbtHYSs7Z7pJW79vomNIcM+m2V
	PYZMGm9FG8+QF3viaS3HpP2fMGgGkPuEoHUtuy3Bwa/IsN9/YW03nO/dM6HkavyorK1hs5q53+9
	XA87CejgmBJFNqHFBWrCPm9KFtoDt99OL14q5a8k6GbeeZ6WBvCxycG4jmOoddh7esfgd/Kcrg8
	M4vbYqK0GMAt0tBVjgikybsztoojaXOWhtkBllGviqkzVGOACJrlSXoZI01dFu7uEF1FFs=
X-Google-Smtp-Source: AGHT+IHc05aSQyCBw6dhakriYJ2L2Wiy/hDAUqu1clJJuHsC8Udba2KlYPTUUDKNRMDIWvSTe1BcYdG7+CQRmdW8aC0=
X-Received: by 2002:a17:903:2f84:b0:270:ced4:911a with SMTP id
 d9443c01a7336-28e9a5133bbmr590985ad.9.1759425281248; Thu, 02 Oct 2025
 10:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251002052215.1433055-1-kuniyu@google.com> <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
 <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com> <20251002165510.KtY3IT--@linutronix.de>
In-Reply-To: <20251002165510.KtY3IT--@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Oct 2025 10:14:29 -0700
X-Gm-Features: AS18NWAFADYSoIBdjVr-Osgzyiuj__dj-h9zRXB09yfJjsY3fsSQEj2RRBzos1Y
Message-ID: <CAAVpQUBK41P0Z3VRcD6jGrRxhRe7-03srLAiV8eUaEcFu-HRSQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tiffany Yang <ynaffit@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:55=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-10-02 09:22:25 [-0700], Kuniyuki Iwashima wrote:
> > On Thu, Oct 2, 2025 at 1:28=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse=
.com> wrote:
> > >
> > > Hello.
> > >
> > > Thanks for looking into this Kuniyuki.
> > >
> > > On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> > > > The writer side is under spin_lock_irq(), but the section is still
> > > > preemptible with CONFIG_PREEMPT_RT=3Dy.
> > >
> > > I see similar construction in other places, e.g.
> > >         mems_allowed_seq in set_mems_allowed
> >
> > IIUC, local_irq_save() or local_irq_disable() is used
> > for the writer of mems_allowed_seq, so there should
> > be not preemptible.
>
> That local_irq_disable() looks odd.
> mems_allowed_seq is different, it is associated with
> task_struct::alloc_lock. This lock is acquired by set_mems_allowed() so
> it is enough. That local_irq_disable() is there because seqcount
> read side can be used from softirq.
>
> >
> > >         period_seqcount in ioc_start_period
> > >         pidmap_lock_seq in alloc_pid/pidfs_add_pid
> >
> > These two seem to have the same problem.
>
> Nope. period_seqcount is a seqcount_spinlock_t. So is pidmap_lock_seq.

Oh thanks, somehow I assumed all of them are seqcount,
-ENOCOFEE :p

>
> > > (where their outer lock becomes preemptible on PREEMPT_RT.)
> > >
> > > > Let's wrap the section with preempt_{disable,enable}_nested().
> > >
> > > Is it better to wrap them all (for CONFIG_PREEMPT_RT=3Dy) or should t=
hey
> > > become seqlock_t on CONFIG_PREEMPT_RT=3Dy?
> >
> > I think wrapping them would be better as the wrapper is just
> > an lockdep assertion when PREEMPT_RT=3Dn
>
> Now that I swap in in everything.
>
> If you have a "naked" seqcount_t then you need manually ensure that
> there can be only one writer. And then need to disable preemption on top
> of it in order to ensure that the writer makes always progress.
>
> In the freezer case, may I suggest the following instead:

Isn't it a bit redundant when PREEMPT_RT=3Dn as we take
spin_lock_irq() ?


>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 539c64eeef38f..933c4487a8462 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -435,7 +435,7 @@ struct cgroup_freezer_state {
>         int nr_frozen_tasks;
>
>         /* Freeze time data consistency protection */
> -       seqcount_t freeze_seq;
> +       seqcount_spinlock_t freeze_seq;
>
>         /*
>          * Most recent time the cgroup was requested to freeze.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index eb9fc7ae65b08..c0215e7de3666 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5813,7 +5813,7 @@ static struct cgroup *cgroup_create(struct cgroup *=
parent, const char *name,
>          * if the parent has to be frozen, the child has too.
>          */
>         cgrp->freezer.e_freeze =3D parent->freezer.e_freeze;
> -       seqcount_init(&cgrp->freezer.freeze_seq);
> +       seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
>         if (cgrp->freezer.e_freeze) {
>                 /*
>                  * Set the CGRP_FREEZE flag, so when a process will be
>
> While former works, too this is way nicer. Not sure if it compiles but
> it should.
>
> > Thanks!
>
> Sebastian
