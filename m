Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE9181334
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959996; cv=pass; b=GmV7/pTdQJ48ShES82W0evC6ZJFzuTPwHoeD7ij3zK6bNPLpB3S8MjN9V/84ymchPtJP/XOFELWVVIVpbsBtB2kk3t0c8Ia8vQm7pOXs2LHCaoZFUuHVnubbvFX6bSO+kWkTf0Yjwe3W9Vs5fTA+gSko4i8GgKjhkVr5HxBY43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959996; c=relaxed/simple;
	bh=y2LNCyBpMU/lcaKVn6KCGli+f8PCYoXHDNxznrsxfH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grI2MAZlCJlKkGUJkOfax/MdkvhpMyoHM39iIsVPw9+RotqveW/Ho9NOWsxel9PXO8htmEGUQU4mwcPvX4JCf4hcWS2+/IRzk4QpBYliVKS7mqOpJw+QaooFcN08/jlP4Ic4JIpOvBihOz4wCQmf7RF0gB6CsfeJtTVMJ7bbFQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPvbznFe; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPvbznFe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso18195e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 16:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787959993; cv=none;
        d=google.com; s=arc-20260327;
        b=S7kqWh/VDKH3dMjGozpuDdtxYpLtgyBfYPk7C6Q4vIIGXTq7z3l0+Qg711TachIiYV
         BDRxwMQy9OJ7NzhUNdRSLeFAuKlEQNuLQH0y5+Uqr5RIEQ3sLA1/uLmYUTIUynkanjW9
         EUvmTffh6DQINhWUpx0VH6AkD/wGsNVcnEXvE1RLrWVHiMma7W2t+9FIGx8DYkvPjwKg
         0maWDmcT8weJiHU30IhiqTR9nX6ly+sbVTwGp2QmAaE9SND7EVFWMyDc8svTm52u6shx
         2Ep2GHrOPAYaxNpDr1rUWB5StAI0V4sxabR27D44G5EQCS0R7aZq2uFW2jFiIo9xAeUD
         HSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vPbHw3SXRt8c1h9FzmacGhPD5cdWkOAwAK9dhsy7doU=;
        fh=KJksZ00NciZ9IcLgBFCd4PlH8a6PO6PJT1XjJVbf7iQ=;
        b=EFKD7BBw3L6ZfM9xdTGrxXfnNd5/Z45DE9/GMv7n/bqdrsJZlt4m6CHQNOHyDRqnIi
         P/YA8bNEyBvLyc7EQ2lpbR/zGlzmTDr0OHOO/jMqS6GIGPSvYha0Lyk45euRztwQDtNL
         sTcbm9QXr0nTy+beGEZG1SYI4r/K508dCO69F0ny2+rSONilRaGXXIUjjnryXtlpgsEa
         ggt2aTEqcfphEaOesHUidfy2f2Dg1VlaQzqeGEA09IFJoAX2j5EJVqNaPq/Y3jZkRc+f
         7bcMD0n/Ng4OtDHD3oxeyFJOLdGjdC/lnaxjoj+GMQDgoKfc9FcShduAogCxvbgxTC92
         6FHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787959993; x=1788564793; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vPbHw3SXRt8c1h9FzmacGhPD5cdWkOAwAK9dhsy7doU=;
        b=mPvbznFe40PI2U8MipaGsKhQVytJWaODPpFMzW4uyUByQ6qKKI3KNf+78bbEvD0C8l
         5Vc47PdnfYMFsSUgUDFbNX9Ub9g9U+S/xgL1yK1G+jZKJLB6kGEs8kgBf/Awu3XxuiGi
         vOL4IsMvLxsRTJQxNZBhaNPbIXHJPnW9U6cI1ETKDkz0LE3ATGEFKSE5hCqqtog9218d
         dBm/23K701H7tPBZZAddiuZewlMNKnztkhmfNzrlOaC9uYr8zr8BCMj3Zir4sJn3rULq
         m9h4a0Q8CXjcne6Ty+IOOZ30PJ/DOjOl3XIbEWLzZmcZxfMYCCxWBlxGXp3wmrDoHuHx
         TM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787959993; x=1788564793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPbHw3SXRt8c1h9FzmacGhPD5cdWkOAwAK9dhsy7doU=;
        b=g7Ux1GXsNoUURqaps9Egl970lK0Zoouy/K3I9T4Drfh2ZBAJ+IXBXuHxMuaqfaym7l
         Pv8SO3YTwKZM7GYpiL0j8MdT44SJtTmnIJDYMiF5atsBjTkfCPl5fJhFe8fGDktu41op
         yDFTLrX+p3x8y9iqv28VN79RhgaSWIoBojfGyGzvRLBtuF7EbHCs/xWFEzEEn5JPxIBb
         iWpdHfUs5S7Y/uL44M0lbrJp58MwiYTgTvz6/k0IJLbGtBJ9E0xAp2Cnco52ZdZ+KT7I
         V/p9HJZsNeZz/EEaKCrJJvGd+7nDFNORmR9+fRSeY17RmXIi588krmL4lrybTNeoMqee
         XZ+Q==
X-Forwarded-Encrypted: i=1; AHgh+RplE8Za8DYf8GkuEORmWdgda1E591Jv1tNEzqRkVpyaLPiiS2awDnz1QIo0nOLvNIuUV3zlRdVBiUID2nSWDQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lapmphKXvsyfld4ypFLznRkzKq55RZ1ayVc1eE2DdEPAB8vXxC
	KYXfdooqNq6rFcKNjdLtYYsRc62zhdQKsOu44dSywAbX/W1h82kV4Bj2d+cuDPbxcov4E1+n1E6
	HOoj4R9rXcWIFbNDG4wnYCK5fD7SE8U9JB74oCTS0
X-Gm-Gg: AR+sD13/8PIptDqOXg6J+GwDwepGf7KvYR6LqxR//UHqwlrvSOWYwnqNeRAvpBTvVOi
	9EgtTxkJzH5b6EzfT7Ndm/avv7QkOQB39wbI5XFHsN6OFaJ+yrzms2iuF5gzAIuxnyox7hX9XYc
	5zyQiAyhR+Cmop82Bw/LqsgWFkmYrJKIBhdh5eh9sm92YQmGelzawGnztNyseQnu2CNUJAnZ7BJ
	TfRvP+nm+baZ6AL/GBvmM51VFYkCHam8BQH+O4xygXsweqvk+T8H8pz5HTTW5L+dKpUFGpieo1v
	LxW9uhlVvMmrSRvXI6xgcMY9QSPRJe9Oo860hj4p7DEMBEb9lBfc9rHjtdUUUy6kMCYONCcokfs
	=
X-Received: by 2002:a05:600c:3794:b0:499:cb15:4511 with SMTP id
 5b1f17b1804b1-49ccbb61af8mr349255e9.8.1787959992396; Fri, 28 Aug 2026
 16:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260827232948.2520558-7-stevensd@google.com>
 <20260828125706.GQ687043@noisy.programming.kicks-ass.net>
In-Reply-To: <20260828125706.GQ687043@noisy.programming.kicks-ass.net>
From: David Stevens <stevensd@google.com>
Date: Fri, 28 Aug 2026 16:33:00 -0700
X-Gm-Features: AcwNN1X4mjRfDUQTmdB2Q8G8afN4YKn_2mHhFiMGwyOfarmpU5bToKMeymOANtE
Message-ID: <CAOiLmNG8XUKzy7uyodfDyuSBKJa4LujqSRKhgmOiRUSFEAEjFQ@mail.gmail.com>
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:57=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 27, 2026 at 04:29:44PM -0700, David Stevens wrote:
> > +DEFINE_CLASS(allow_stack_reclaim, bool,
> > +          ({
> > +             if (!_T)
> > +                     current->flags &=3D ~PF_RECLAIMABLE_STACK;
> > +           }),
> > +          ({
> > +             bool was_set =3D current->flags & PF_RECLAIMABLE_STACK;
> > +
> > +             current->flags |=3D PF_RECLAIMABLE_STACK;
> > +             was_set;
> > +           }),
> > +          void)
>
> > +     allow_stack_reclaim(prev);
>
> > +void __allow_stack_reclaim(struct task_struct *tsk)
> > +{
> > +     union stack_reclaim_state prev_state, target_state;
> > +
> > +     if (WARN_ON_ONCE(tsk->__state =3D=3D TASK_DEAD))
> > +             return;
> > +
> > +     prev_state.val =3D READ_ONCE(tsk->stack_reclaim_state.val);
> > +     do {
> > +             target_state.val =3D prev_state.val;
> > +
> > +             if (prev_state.stack_state !=3D STACK_PREPARE_RECLAIM) {
> > +                     WARN(prev_state.stack_state !=3D STACK_IN_USE,
> > +                          "Reclaimable state %x for previously running=
 task", prev_state.val);
> > +                     return;
> > +             }
> > +             target_state.stack_state =3D STACK_RECLAIMABLE;
> > +     } while (!try_cmpxchg(&tsk->stack_reclaim_state.val, &prev_state.=
val, target_state.val));
> > +
> > +     if (irq_work_queue(&tsk->stack_reclaim_work->irq_work)) {
> > +             /*
> > +              * Take a ref that gets released by do_reclaim_stack() so=
 we don't
> > +              * have to worry about races with remove_from_stack_shrin=
ker().
> > +              */
> > +             get_task_struct(tsk);
> > +     }
> > +}
>
> > +static inline void allow_stack_reclaim(struct task_struct *tsk)
> > +{
> > +     if (unlikely(tsk->flags & PF_RECLAIMABLE_STACK))
> > +             __allow_stack_reclaim(tsk);
> > +}
>
> So you have a guard with the same name as a function, but the function
> only functions when inside the guard of the same name. WTF ?!
>
> Anyway, it looks like you're sprinkling this guard around a few specific
> block sites. Which seems to suggest your PF_ flag *should* have been a
> TASK_ flag, no?

A TASK_ flag is definitely better. I was thinking in terms of defining
safe scopes, but that just complicates things for no real benefit.

-David
