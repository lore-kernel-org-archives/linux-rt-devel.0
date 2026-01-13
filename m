Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457F2E7186
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768346740; cv=none; b=YTRdVem6ffCDSWcJ0UFQp3XuNYfDURFDAh2OljSoVNC2c0W9tvxwSKQSeRy8scUwTArDv3+Xlou1GNauCmKqsuY5KzJGktdzQOkyIqBn0qVZBoZ6adI7cMW0t1U1jMoQcpnKo6kL9yMKKhscLeTNWGY5r795pgaAuYCYcKZxGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768346740; c=relaxed/simple;
	bh=fFxJAQHjLl3nfg1tIDWMSmd6vloHAmf0HKT0kzLD18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJWZX/PqvOt0apuV/lIQACh7+Kce2YgN50yiMuW0zZJUUjNsmaFx52n298DkMAMMeA0wx4dO/ghoark2UXdjcUguwImw55YUq8uoYzKTIfkXmB8ZJ1+qo3xMA0SvUXNbQOKE0l99gty26esrd4b+Zd3qBae2GZJsuWT3ye6lmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daNw3K9W; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daNw3K9W"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43277900fb4so121963f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 15:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768346737; x=1768951537; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHU+/HLwiitPDlXwom6qRitlX1fipBA+Q9yORBvMlwY=;
        b=daNw3K9WAS4q2yRk47iiYzUUf1gkOIHVguXn5PWs4RWYpjf/HbFSQ9bojpvUOjfTV9
         /Gkvj3itdUjkP5fWrOgBsVD9ps9Bg9H3t7zZGX5NkhhwjgScjSTGu2yVCGYh/Tq4XBiq
         u/wuHQaj2Rhwb0OQf9+HeelW6GwMEMLF8ek+/wj9OTkNfcQjhiO+DEHEeTFJzOP/B4mu
         QnUIVKuHYja+NmxbA4AvLNYCO0CqYNV1NXdOp2TBJNGQLnCzI1CTRlt5AvQq3h3FSDM2
         IZJHNSYQheVuaiuY+vONYwv8GX4fxO85xXExe3OVq9CI99ZDMFdeoUEepzHimBSV65OY
         tBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346737; x=1768951537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHU+/HLwiitPDlXwom6qRitlX1fipBA+Q9yORBvMlwY=;
        b=eDpQXfthjxYGb/8seGAAd3+RMZQSn+FrEIkqSetLComiYNyDNsmPBxx9XNUhoXp7fF
         Bgq84NZ443LdjsI8H0gsbdClwFOmSYBTHggKphrr2NR/sZglbkNW/5n52xoqZP8LFcpu
         YfGBLJDoPTUXaDxeFRXQidthyA1EabW16aDoM++fsuB5L7T5s/YK+Otp8qQu68cdVP5Z
         GHluWISkT4lEuJthcpxJfUPNZ9SoP7IHYOFZyPYNmv0TdLc0f812YsCdTZSVxiZMfxRz
         JjzJqq2u8pwWKDq3X1j3tzjdU7IULbqGKdWNL/DEsklMGNiL/5dyMQE4k0j1jart6Pjk
         1PqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7cZTSxKAmXqXbk+RKW92yCkD2LR/6HIMpwN0vlI1+ycZqgQdbVUv+1W9kD+thmXZhRiPnZ16CvWHUHBcshA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6d3SfnHug7VsXgNWUiliDcFTrc/7XyRORdyEwp8MNMv1At0uM
	KDOgj9Y8lf2eCwZV2xfugdT3DnGGtDrVzu9xPo9AxYoF4CB1fNH7lJsX1fnjhSw1fHs6SsVpMZM
	20yqUm6DlruMQsULpaDfh90t4bKm22jk=
X-Gm-Gg: AY/fxX5wdKp61RsXhLPAOXByaHJ3/yZ7PWPuV/llTV4phUII7bt4Hn1xK77wyMPw67b
	6tzEepPMYywIImkxYbsFqwqhTUAdmKsduY5QXAVsdvf2gYf7SrEhhbKgaCAOp8gEe/xV0+WKsTC
	4PS1CGrS2uXkI8nJI4q3XO5yY0mmw6Gf0T2eOt0MuiD+lyhpATS19P9M0FiQGPn8E0y+ndKY934
	QsUWjykshmFHrygTRDQrWhejjPJ4wdafQ1qxTesLY5DDRK9FThlDrO2cQSdnCYsn3kNXDGVgjug
	7APlo05qeRXKHLPccjF4PhKBZAgK
X-Received: by 2002:a05:6000:200d:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-4342c0e33fcmr746753f8f.21.1768346737371; Tue, 13 Jan 2026
 15:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107215353.75612-1-longman@redhat.com> <864iowmrx6.wl-maz@kernel.org>
 <87ms2nsqju.ffs@tglx> <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org> <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com>
 <87cy3eg94y.ffs@tglx> <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com> <20260113115515.98Mc29Nm@linutronix.de>
In-Reply-To: <20260113115515.98Mc29Nm@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 15:25:26 -0800
X-Gm-Features: AZwV_QgNIEr3g_107xkIOrrw3Ge4zQle_mq-J4yht-YAYcdNLGT_KWBNo0kRCyQ
Message-ID: <CAADnVQ+eQU+isNBXOJwQ=RYZUyO00e48ESHUhh8Kp7pgRgQu0Q@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in allocate_vpe_l1_table()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-devel@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:55=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-01-12 12:14:30 [-0500], Waiman Long wrote:
> > On 1/12/26 10:09 AM, Thomas Gleixner wrote:
> > > They might be acquired though. Only alloc_pages_nolock() guarantees t=
hat
> > > no lock is taken IIRC.
> >
> > Thanks for the suggestion. I will look into using that for page allocat=
ion.
> > I had actually attempt to use kmalloc_nolock() to replace kzalloc()
> > initially. Even though it removed the call to rmqueue(), but there were
> > other spinlocks in the slub code that were still being acquired like th=
e
> > local_lock() or the spinlock in the get_random() code. So I gave up usi=
ng
> > that. Anyway, kmalloc_nolock() doesn't seem to be fully working yet.
>
> with kmalloc_nolock() you have to be able to deal with a NULL pointer.
> Looking at kmalloc_nolock(), it has this (in_nmi() || in_hardirq())
> check on PREEMPT_RT. The reasoning was unconditional raw_spinlock_t
> locking and bad lock-owner recording for hardirq.
> There was a trylock path for local_lock to make it work from atomic
> context. But from what I can tell this goes
>   kmalloc_nolock_noprof() -> __slab_alloc_node() -> __slab_alloc() ->
>   ___slab_alloc() -> local_lock_cpu_slab()
>
> The last one does local_lock_irqsave() on PREEMPT_RT which does a
> spin_lock(). That means atomic context is not possible. Where did I make
> a wrong turn? Or did this change recently? I do remember that Alexei
> reworked parts of the allocator to make the local_lock based trylock
> allocation work.

Are you forgetting about local_lock_is_locked() in __slab_alloc() ?
With sheaves the whole thing will be very different.
