Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3C1F75A6
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206077; cv=pass; b=Dc6lh2uSNIjFdJbloBrkkjbAmFGjid5M3lvhA5ZrrBwXLrNvgVE/C6d7iN1hk/dPrLbG9bYaX24n9jckbTU8lakcMNV/rEXeZzg5/fFw8j0QP8QSAFEs53OubbuV1Bk25Uw8LN8tx+u7HpAk0oxRovOI21SOyZujxomjtcv1Rm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206077; c=relaxed/simple;
	bh=ySZkIFAKYX9gx3ts41i5xZvDKWUGmTxZZYs/kw0YBA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0Rigul7LXnN/E1afWJ5zsrf+QDAQ3728llcZJqBTzlpoe3Q/N1s2F/iMaxpPVdmXn2EHLmvaijRGFXFaA/05OywavTUuNsEoHqd8A6dC6eKnbqZjAwmK2tBOsizVCc3bvaAYez8NaHzOzCMYVt946pSzu9gDm4u9Dn8hCn1/SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GN7r0yIp; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GN7r0yIp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b5d8551so136411cf.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 14:07:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769206074; cv=none;
        d=google.com; s=arc-20240605;
        b=W/hHJX1QlcN18J7GmBusfX0wl/KNecQYA+1NRktpiHosyXQ152g0drfmpkiJh1zrqq
         ZTD9tm50utlL9/kWAQHUDyoHzL/P/Cay5cjJjDM+qIUxy7/MRC5VdJb4yyDBwwVanJcI
         7iFphXgYMc6udFTKcDIl+1HrIo7qY0E+wTI2QbH0gUf4WzGp3UcBfWOkS/cpPh5fSSUT
         xgaTtEwnjdfKFKcWSFsyAPJCWsDI+8teorFKkHy/4dEBqaz35cwxHMk9LtkPVZiowEdB
         1//058ny+oihGhkD4y0rjdWU/IUjEmV9/eBoCIXzIXqtdcqfRiMDegVEUO4BbKB9LY9c
         A18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AZSAAHeHiUR5FnBeJkK8QZrK4YM4qpJPJNY1MlgLuKY=;
        fh=54Dxue/mFlvPaUmX5CiKWNjAWXpsyF7D1QgHc+ApZEQ=;
        b=GlU62bmdCcS7MQfq+xpr2kAd28gUh4YssC1Ilciy5Z0zTQ4Cd5T46Y7y3OgcNgunBB
         ivYzokPiPKCNR8bIDTCE38OV9Ux+5cnhn92VYeQaNPWH3SYyYyqEYfr0T22acgLcmw+H
         UStmXYc37kVcIooN981ya7TMFs7nUtaNqnVPhIcA8JH341QF1ewTA42QJ7nhugQQ19JL
         HP7F7gN0QZUPkdoHS4zylJFIH5gNmZNQEJJQqs/P9/pse1LN+2fZZXLPZaC8Dvj+XsNN
         7YyDw98tywTeikOtNpVT/bjmY8vykDzZf1nA4ZOE6FuWAsyl+DjQcVWRZMtmoNoST8DK
         /9Pw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769206074; x=1769810874; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZSAAHeHiUR5FnBeJkK8QZrK4YM4qpJPJNY1MlgLuKY=;
        b=GN7r0yIpSIvXjZv0MEeYH3sTbPxDbZNuL6KpUdxpCQW/IGtKIErKsnCHig2Rs3dRWj
         bSPBzY7naS8fwhd/oQ1PJUdKXkASZ5vMBKYYLNk1rjUdsVjvVGKDSxgrtL6deoLQvsw/
         CPqYuJDKr+ou0M/AuRP0Ieh73qlA4X02ab+aug7F4OWy2KSFozgAWnTCxuExl8llO/iW
         F6KA3T5/9j49MGoyrwE76wsNWKfcW/YkwrmmCg9obDRzVgRkLEO5ByGe7qqi8VXrpQt0
         iW2yHcSH43WtyIbfmCHtAwB33G7attGRQ1/Nul9cqwYBOBhA7+89gGwOlbeaaVfz4HQv
         nuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769206074; x=1769810874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZSAAHeHiUR5FnBeJkK8QZrK4YM4qpJPJNY1MlgLuKY=;
        b=OOOkY7Hx46JDuVVJyKORFJ2VpxwgOOVnmoh92w1lZUeoa7H2z+3TYkeG/Nj7xxFDby
         us47+PDsOlw/4WE8wIDBZpiYVONM6xSFhbYPSsLV1VTFsJIZgrdTPtI16MtcVX/ETIwp
         4Frh6fJM6DQXK5lyqzuC0PXqx4xxaSfvxMdByMmcyoUUC5OoQwaLl8yL3U7NalgR9iqM
         Vja9u94MTBalt16MXytKa5Pgr77d9QiVzfRgMoB09UfY0NWE5KNhZGa9eN6FtjE5T+mq
         s3jZ1GaWWM7s5aEdbK8cel6VfcXoiTSjSZm0wdEgSHEL9BsNY6uGqmD19dAAygx9cTVd
         1RBg==
X-Forwarded-Encrypted: i=1; AJvYcCVyc0CSMgMsYVl0Ktr6tWdP8CDvP3H2pcZ0CwzpcT5qtn5MbSuodkITrn+gQyaEfPxbm0XzXZnRRnGBIJIAMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzfa3DS1LGK6g1NkCOXSNL7WrXjttsrguVYlLJwlHVgFU3r1Bb7
	irhQ5Fd0AlvX9FhXWpdcjyEk16CZ/qCsTRmIu0KAZ7EzHw1xgct1CJdLNtktEi8KAhkAOgapd97
	S4ialHbsbUlGN9118LiQ+5KETjbQC8/GoBOqxUgOG
X-Gm-Gg: AZuq6aI/tt/OAPEMP4IAIg016gyenVdcBnBoc8l8qpUj6HFRKDXVpLPGoE/Pg8RB7v5
	7OUM4bIXvmS2eY9mrmhdLv+xfaxphjW5H3BahIzDb8wIVgu3x0EbYLA52adO9NS8Yuruoq1Lz4Y
	bHhzfDgN+qM9Nn2LOFZjCbcw3VXIzwzuB1gYcM4/5sccOhto8Jbvl55OmXajuXOwTZ2pn5G8NcN
	QKFfD4izn5GM5KH7dwHEwojJV8+XxuWJcU2p/8P67n8RX4tXuYAwWQ8OuUGExzjbKb/vw==
X-Received: by 2002:a05:622a:4d0:b0:4ff:c109:6a4 with SMTP id
 d75a77b69052e-50305143330mr2954461cf.4.1769206074080; Fri, 23 Jan 2026
 14:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4f95671feac6b6d4cea3c53426c875f3fd8a8855.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEULwMTxAzxUdzfpHe2=+umXL6HFMvydkqW=tP8mB2ewg@mail.gmail.com>
 <c7c8158d-e360-4a29-9e48-f2b45b9ca147@lucifer.local> <CAJuCfpFbsAHr76ZfUEaRLzdxQMDjPEP+bsLNC35X9t53G_uqAg@mail.gmail.com>
 <c4d64bde-831d-4f3e-9b92-68c1beb70599@lucifer.local>
In-Reply-To: <c4d64bde-831d-4f3e-9b92-68c1beb70599@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Jan 2026 14:07:43 -0800
X-Gm-Features: AZwV_QgjcSMn75D2UlaPVIofqLooCOJZrIcpFa1j2O9XtIxpcBLbSXHQEa8jXh8
Message-ID: <CAJuCfpE3D8XyR5wy+Zzq7TX5am=q3SrevarJaf6Z7-k-9CkmkA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 07/10] mm/vma: introduce helper struct + thread
 through exclusive lock fns
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:04=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Jan 23, 2026 at 11:34:25AM -0800, Suren Baghdasaryan wrote:
> > > > >  int __vma_start_write(struct vm_area_struct *vma, unsigned int m=
m_lock_seq,
> > > > >                 int state)
> > > > >  {
> > > > > -       int locked;
> > > > > +       int err;
> > > > > +       struct vma_exclude_readers_state ves =3D {
> > > > > +               .vma =3D vma,
> > > > > +               .state =3D state,
> > > > > +       };
> > > > >
> > > > > -       locked =3D __vma_enter_exclusive_locked(vma, false, state=
);
> > > > > -       if (locked < 0)
> > > > > -               return locked;
> > > > > +       err =3D __vma_enter_exclusive_locked(&ves);
> > > > > +       if (err) {
> > > > > +               WARN_ON_ONCE(ves.detached);
> > > >
> > > > I believe the above WARN_ON_ONCE() should stay inside of
> > > > __vma_enter_exclusive_locked(). Its correctness depends on the
> > > > implementation details of __vma_enter_exclusive_locked(). More
> > >
> > > Well this was kind of horrible in the original implementation, as you=
 are
> > > literally telling the function whether you are detaching or not, and =
only doing
> > > this assert if you were not.
> > >
> > > That kind of 'if the caller is X do A, if the caller is Y do B' is re=
ally a code
> > > smell, you should have X do the thing.
> > >
> > > > specifically, it is only correct because
> > > > __vma_enter_exclusive_locked() returns 0 if the VMA is detached, ev=
en
> > > > if there was a pending SIGKILL.
> > >
> > > Well it's a documented aspect of the function that we return 0 immedi=
ately on
> > > detached state so I'm not sure that is an implementation detail?
> > >
> > > I significantly prefer having that here vs. 'if not detaching then as=
sert if
> > > detached' for people to scratch their heads over in the function.
> > >
> > > I think this detail is incorrect anyway, because:
> > >
> > >         if (err) {
> > >                 if (__vma_exit_exclusive_locked(vma)) {
> > >                         /*
> > >                          * The wait failed, but the last reader went =
away
> > >                          * as well. Tell the caller the VMA is detach=
ed.
> > >                          */
> > >                          WARN_ON_ONCE(!detaching);
> > >                          err =3D 0;
> > >                 }
> > >                 ...
> > >         }
> > >
> > > Implies - hey we're fine with err not being zero AND detaching right?=
 In which
> > > case reset the error?
> > >
> > > Except when detaching we set TASK_UNINTERRUPTIBLE? Which surely means=
 we never
> > > seen an error?
> > >
> > > Or do we?
> > >
> > > Either way it's something we handle differently based on _caller_. So=
 it doesn't
> > > belong in the function at all.
> > >
> > > It's certainly logic that's highly confusing and needs to be handled
> > > differently.
> >
> > Just to be clear, I'm not defending the way it is done before your
> > change, however the old check for "if not detaching then assert if
>
> I mean you basically are since here I am trying to change it and you're
> telling me not to, so you are definitely defending this.
>
> > detached" makes more sense to me than "if
> > __vma_enter_exclusive_locked() failed assert that we VMA is still
> > attached". The latter one does not make logical sense to me. It's only
>
> I don't understand what you're quoting here?
>
> > correct because of the implementation detail of
> > __vma_enter_exclusive_locked().
>
> Except that implementation detail no longer exists?
>
>
> Before:
>
>          if (err) {
>                  if (__vma_exit_exclusive_locked(vma)) {
>                          /*
>                           * The wait failed, but the last reader went awa=
y
>                           * as well. Tell the caller the VMA is detached.
>                           */
>                           WARN_ON_ONCE(!detaching);
>                           err =3D 0;
>                  }
>                  ...
>          }
>
> After:
>
>         if (err) {
>                 __vma_end_exclude_readers(ves);
>                 return err;
>         }
>
> So now each caller receives an error _and decides what to do with it_.
>
> In __vma_exclude_readers_for_detach():
>
>
>         err =3D __vma_start_exclude_readers(&ves);
>         if (!err && ves.exclusive) {
>                 ...
>         }
>         /* If an error arose but we were detached anyway, we don't care. =
*/
>         WARN_ON_ONCE(!ves.detached);
>
> Right that's pretty clear? We expect to be detached no matter what, and t=
he
> comment points out that, yeah, err could result in detachment.
>
> In the __vma_start_write() path:
>
>         err =3D __vma_start_exclude_readers(&ves);
>         if (err) {
>                 WARN_ON_ONCE(ves.detached);
>                 return err;
>         }
>
> I mean, yes we don't expect to be detached when we're acquiring a write.
>
> Honestly I've spent the past 6 hours responding to review for a series I
> really didn't want to write in the first place, updating and testing
> etc. as I go, and I've essentially accepted every single point of feedbac=
k.
>
> So I'm a little frustrated at getting stuck on this issue.
>
> So I'm afraid I'm going to send the v4 out as-is and we can have a v5 (or
> ideally, a fix-patch) if we have to, but you definitely need to be more
> convincing about this.
>
> I might just be wrong and missing the point out of tiredness but, at this
> stage, I'm not going to hold up the respin over this.

Sorry, I didn't realize I was causing that much trouble and I
understand your frustration.
From your reply, it sounds like you made enough changes to the patch
that my concern might already be obsolete. I'll review the new
submission on Sunday and will provide my feedback.
Thanks,
Suren.

>
> Thanks, Lorenzo
