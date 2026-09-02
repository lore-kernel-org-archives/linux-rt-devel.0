Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9044A0F14
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Sep 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358478; cv=pass; b=E2TCuceuByJSzt1QXiUQt01H2tpoSoUTzJmJ2dFBSTtQeoxZfDiK5IZQg8hvcYOZ9xlL9mJYUI5ALdEwpefGRFsArVXvFpycyCvFQCsYU9CKSgaCTZdb4Su1d8g6F19Mk/7UGl6cKRc9mFa1pjl/ENmXMMPXFNJxJtbwyKoF+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358478; c=relaxed/simple;
	bh=cdAE1a6vG9C5ULJiRkOdqZgP3psLeL7eFGyxPIwl2S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUbpPSP8dA9ma34unPDs+Zk+jquHnd1pxMzM5z8NigBtnb0BW/TIxbbofv61IZKeo1bQ1lxS6lSfBo2/d0ixYiSQb4VeKVVic+ZE3ZfEHBO9j2jFaeijHVZOOldz6rg7aMD8Q4Ns0zLBv39wdRFTNr7OGMPUXR8jmpIh1GmJLyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JknZOCBh; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JknZOCBh"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so2028638a12.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 02 Sep 2026 07:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788358474; cv=none;
        d=google.com; s=arc-20260327;
        b=Iely8adk4gkkRrfJgydypLCfK6AfSzMetnwvHHK4l0QsbqqYzpWIjVp5w6ej0l0X/d
         UmrEC7xMAGbrBA1VqoEBzQBpwwb0FXDrWhy9Dy2tYvm+se8AsQ6i3CGfomkaIb9yEpzn
         YG+mdZjo3qldlA6+78eC2jo79gVVoEE8Qbd4j/DDZcYjyHgSIoIA/r9q/QMyF9p92T5W
         sxPJcSrotnOuvNgRvlmOVUkNcEs28f4iHi7kGZVY7zjgzj09XuOksCFZMEXx5N4Reqfq
         bWqqTAqcvHKo5CnqVyBmYb+Z3nWF33abgmDk4qkUsgXx+YLvbhQKkzi6nmAYdPaLZ+7t
         pnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z1Gb9svefZexXgI3MSllPyHbPKRof4ikpCQHMZNBOag=;
        fh=d1U2BIc7WW/sNXE6IyZFAqez7KExhF7aDZWSwUxPb20=;
        b=Bfm8JEQE3htnIm1oBEQ10UJybIFbn4p+s/Cxj8C9g63OzJ3BegOsyrnDkIeQcnpqen
         EJmGJ1RvAIAFr6Pske9dO535cl5MsSISZ9V+p05mjwXMlM8QlgEx8UmKt+lgkzcPgu1R
         abxRCUQEmfzKkI4g8aN2mNH/UwOrJCE2Vy97wTOdq5cIovSnx49BkgAr3C9B3kzeZGcN
         oZSGOXifFAT6J5PY5Mj+r1OcDJ33gi6cJRNTB0LEcfdxqUJBhj+X6aFQx4rZplakEEuf
         LDvMRwpAKH0qMW9errHJsSZh1ldW7bkbPNZPxOJIH9CfGHvfIWOwYn/c2bZhpHGUdoUH
         nmkw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788358474; x=1788963274; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z1Gb9svefZexXgI3MSllPyHbPKRof4ikpCQHMZNBOag=;
        b=JknZOCBhTZe3ZJtFDiTum+hxk0+eGbmMiCR0E9WV+epe0aPmOG/AB8XgT4RB4QsqgS
         bIeoPH7K9bJ9nc8ITLtHW5mDcCOdOrWNg+mxnMMqXR81pZCNIGYvVHWpJfwtbOqKYuEU
         LQJN0UKIXqNaalCxQy45mFwk7eq5Kr+tM2rOo0dccExOGyNORwH/1MdhbD+sO+8jQ7ic
         6mfRjzk0NH/Fdhg1uxmRtLpSIgEjkzcb4cJMR8u3vydUjkB8tLXKw5Dl16GRm274I1k6
         38QQ1Z/BYhXpeJ2hnpDubG04qOWpGZZ+ROch1ta4kp99jrdFeaTOzQNsGWG0B4txKj/j
         TZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788358474; x=1788963274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1Gb9svefZexXgI3MSllPyHbPKRof4ikpCQHMZNBOag=;
        b=RwuEZVZXSYfRpgcG++6RG7OM1ML5ING5DHCZGVw4msaIQAbIDuaE57OWRX22N6miZq
         XL4gDt+SbFk0uXRR0nlGBIssvUS42Iw9u+AHxkMOJMBdOnsd/uoz0O/idKEe05sDfMh2
         LPfqrbyuUAfsN+dxEWQDkJl4l5bbM7N/RQDl7rBfeCjTweUIsTVAzkNsqaIyaJI1J199
         fool7s/TGzk5MOxGebBYL4WLkEM9ma+mi9QZPq6zRE4yEmRVfvZyZzvTUmuNIMTDX905
         7ntG68V5zRIpiil0hUYMb1F63v5qqpnb0rFYPkpVdW5ZuI3FV1Y3a4ii8l0W9+s68D7x
         JRGA==
X-Forwarded-Encrypted: i=1; AKwUvBzwt2xqSIcnQ9eIxOwDNWea+e8L00gVPQY2n7i8aCswSlFXNb/AOMz+SpVrJN+dtTtMFUzUVBM5IJdgtj2KXQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kSD34b1LQP3JWxe2TVSv6SyPWb7XJhPSRn/XY5H/Cg2Y3cx5EH
	4TE9ygB5lfaRaKgvfy+5YGk1ml6u1sXpervylXRFPbM8WcLR94MDe7V0B5wzRnWGbljz8CJFoPg
	gY3aHfuPHX7HIW1YTGbh9ci3XgldWbyY=
X-Gm-Gg: AYBFou0AMkSWhsFGQ+WV9JFgi4YpxIzhUGsurjCWu6KYWSjbK31tYwC6FZoV9VAEa0E
	R/RpC+cZHMMPD8HYQST1mPqR9cBkRndebHXgr/epAVWg9I+2sG+L0L1V+DbKj8AJoUmQkmTURQA
	J7SEEXWq+3p3+5kw2iZc3OvWbDFGDMSxAq8udVWLGb4gEEjHLTbdzoyn/utBmCjSCnuilKRfI+5
	gL4Ond1U9oP0DIlnG5phKo+BVBJCivyNgkJYcCRsJb5lurVng7No35wF/heWolA5zZ/mpKSPqdw
	jFQZaj3bTa0zTSZwb4h8lx7jafrGGyu+ce4qVuwr0zKVkC8ylboe0QfxPeZ7
X-Received: by 2002:a05:6402:20c6:20b0:6a6:8b46:4973 with SMTP id
 4fb4d7f45d1cf-6a68b464ac4mr1842114a12.7.1788358473392; Wed, 02 Sep 2026
 07:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <20260826144636.3IRUXeFV@linutronix.de> <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>
 <20260902082657.yPEhNFlo@linutronix.de>
In-Reply-To: <20260902082657.yPEhNFlo@linutronix.de>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 2 Sep 2026 15:14:20 +0100
X-Gm-Features: AcwNN1VcZ0Pb1fdH9gP2Tb1Pv8VYUhDajHrWJ9SzT4ipxs3lXYiu2AFNy3-3ems
Message-ID: <CANk7y0gMh6McuLnFwxGO-nH_g3TnstwTK2rtT5pq=b8qq9ykKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Zqiang <qiang.zhang@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Fleming <mfleming@cloudflare.com>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:26=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-09-01 14:53:56 [+0200], Puranjay Mohan wrote:
> > On Wed, Aug 26, 2026 at 3:46=E2=80=AFPM Sebastian Andrzej Siewior
> > > > +/*
> > > > + * Defer whenever interrupts are disabled, since a callback-list o=
peration may
> > > > + * be in flight on this CPU.  Not before the scheduler is up: irq_=
work is not
> > > > + * usable that early, and rcu_init() itself calls call_rcu().
> > > > + */
> > > > +static inline bool should_rcu_defer(void)
> > > > +{
> > > > +     return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
> > > > +            rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
> > > > +}
> > >
> > > Why does the description say that the defer part is for usage from NM=
I
> > > and the test here has irqs_disabled() instead of in_nmi()?
> >
> > We defer for both irq disabled sections, hard irq, and in_nmi() and
> > checking for irqs_disabled() covers all three.
>
> But it is wrong to talk about NMI and do this for other reasons not
> mentioning why this was needed/ made sense.
> Can this be fixed?
> Also what is the reasoning for doing it from any IRQ disabled region?

So, the main reason for this patchset is to make call_(s)rcu() work
from BPF programs, and these BPF programs can run from any context
like an NMI perf event interrupt or maybe attached to a function
through ftrace which is in the call chain of call_rcu() itself.
call_rcu() takes locks with irqs disabled or it modifies lists
non-atomically with irqs disabled. This means that a BPF program that
runs from NMI with the lock already taken will deadlock, or if it runs
between these non-atomic list modifications, it will corrupt the
lists. A BPF program can also synchronously re-enter call_rcu() if it
is attached to a function in the call chain of call_rcu() that is
called with a lock taken. So, all these cases are detected with
irqs_disabled() and on detection we do stuff that doesn't require
taking any locks and is safe even if re-entered.

> > >
> > > > +
> > > >  enum rcutorture_type {
> > > >       RCU_FLAVOR,
> > > >       RCU_TASKS_FLAVOR,
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 21b6ce1dffb63..3bf3a250f9de8 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rc=
u_callback_t func, bool lazy_in)
> > > >       local_irq_restore(flags);
> > > >  }
> > > >
> > > > +/*
> > > > + * Re-issue deferred callbacks straight to the enqueue so they can=
not defer
> > > > + * again.  ->defer_lock serializes the drainers: this CPU's irq_wo=
rk,
> > > > + * rcu_defer_flush() and rcutree_migrate_callbacks().
> > > > + */
> > > > +static void __rcu_defer_drain(struct rcu_data *rdp)
> > > > +{
> > > > +     struct llist_node *node, *next;
> > > > +     unsigned long flags;
> > > > +
> > > > +     if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > > > +             return;
> > > > +
> > > > +     raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > > > +     llist_for_each_safe(node, next, llist_del_all(&rdp->defer_hea=
d)) {
> > > > +             struct rcu_head *head =3D (struct rcu_head *)node;
> > >
> > > Why do you need the lock. This is still not clear to me despite the
> > > comment. You can do llist_del_all() towards another list and then fee=
d
> > > it into rcu_do_enqueue() one by one. And you use the LAZY part.
> >
> > Because rcu_barrier() can call this for each cpu and at the same time
> > rcu_defer_drain() can call it too, so this would cause a race where
> > the irq work can remove the callbacks (llist_del_all) and before it
> > can enqueue them, rcu_barrier will see that the list is already empty
> > and will not wait for these callbacks. We want the llist_del_all() and
> > rcu_do_enqueue() to happen atomically so rcu_barrier() can work
> > correctly.
>
> So you collect a bunch of callbacks and spent time re-arranging
> everything with irqs off.
> What is wrong with keeping it in the llist and consuming it like the
> regular rcu_segcblist?

I don't understand your last point, all the collection and delayed
addition into rcu_segcblist is because it is not safe to do it
directly as I explained above.

>
> > >
> > > > +
> > > > +             /* Bounds a node self-linked by a double call_rcu(). =
*/
> > > > +             head->next =3D NULL;
> > > > +             rcu_do_enqueue(head, head->func, false);
> > > > +     }
> > > > +     raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> > > > +}
> > > =E2=80=A6
> > > > @@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
> > > >       rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
> > > >       rdp->last_sched_clock =3D jiffies;
> > > >       rdp->cpu =3D cpu;
> > > > +     init_llist_head(&rdp->defer_head);
> > > > +     raw_spin_lock_init(&rdp->defer_lock);
> > > > +     rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
> > >
> > > Why is this IRQ_WORK_INIT_HARD() instead, say, IRQ_WORK_INIT_LAZY()? =
Is
> > > there a requirement that the RCU callback needs to complete asap and =
not
> > > be delayed to the next tick? This would give kind of the LAZY part.
> > >
> >
> > In discussions with Paul, we concluded that we need HARD because in
> > low memory situations delaying rcu callbacks can be problematic. Given
> > that we are already deferring the callbacks, it would be nice to have
> > them enqueued asap. But if there are downsides to this we may change
> > it later.
>
> It does not look like you defer them for long at all. Every callback
> enqueued in an IRQ-off region will be immediately re-enqueued to the
> regular list the moment interrupts are enabled again.
> Except on architectures which don't implement irq-work interrupts where
> it will be delayed to the next HZ tick. And the next HZ tick does not
> sound like a long time either.

Yeah, I get your point, and when a CPU goes offline will its LAZY irq
works be drained or left in the queue? Because we want to make sure
this irq work is executed before a CPU goes offline.
