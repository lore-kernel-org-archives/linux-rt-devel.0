Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41F3C3789
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267252; cv=pass; b=eW5LtLcKuy7RFkQiOe2fuf7Iuz8eY8j6dKvcYjNg8QilgvfvJ0LWaG2u4AkZTYn0ljOl1khpD+tVOOd177sM2TYHt3/+yhJ8t09ddNIbmm1foeycQ6750/qO3KZyEBnuIUmpSUkOm7cOdbaMOq3G050zsv3jtn+iUzr3gb4LKJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267252; c=relaxed/simple;
	bh=5ox2ct2yboHyEver6vM5hxy9diHibI+8bx6OOjEZObc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilPq1ZwcMokzq8ErdCXkyMxKeDWl54gKcoJE2fwDXqd5HxznsxCT/wPbAKNW/x+YqJBV/k6DOeufEhcDn+cdWGP+iPJLKxp0yrCYPm2SJVJboF+1Gr3TZl7wyx52Iz6GFzUIebZF6zXxzRwSdNFSO1sle2pHM2aepLZTXlTKORY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG7nn2zH; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG7nn2zH"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so949210a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 05:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788267249; cv=none;
        d=google.com; s=arc-20260327;
        b=TSW2BTmU0A6k7Gg1VIaf53/zB3jMe79Dg8w75OCE3dNXPoZTcEPqHkpMKvfEhSwHDf
         9Uk1UqLM7jOe8q1iT5+lMsxMvRWrKDWrqW+WgLwrR/uFqMTlPQNCgp+82w/jtn60GDBc
         B7AHLsNMt86GmdtJA/XoGspxYnpk+vjy/7J3GTda5AELZXIfbAhk08K/8UGUQzbvgjyc
         jl5zK5YHNtRlkQykYYz2uMnQabOSoccLPIXPnPWzq6zvNg2Nus0zp5OiY7AMe50grgxh
         nTqYisLjNk8uUF/fwCFQHzHn02PW3wTfnpD/iBJsFAtT2IkB11UQQqKCDDzjUBahGfw6
         GJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPgzm55fAw2ptYf8Sl/ajhFPBiEwWjWRkzAJIcml568=;
        fh=I1+ijSOJNJ+uqwLhi8MRXwpYIh5i6PkNvzY/n+hkab8=;
        b=Mvv5ypM8aH9pWGdJ7TLFRm1Z0p5SFfeO5BSyQ9bskXx3DoNQGPVwp1HcBhS77zJ3Tx
         Utpkl7+e7JLsObeAMUdEtfDXYEIfdofIn3Cd+ZGJxrPa+DOwcxncyc5IDSwLPFAPg/Jx
         clRqsuBakbFIQAoVZ59+1QbH/9LI7Yl8fGno2ew1sy16UZikzLh3C/k0W1Qiu66TlP+Q
         lsP0xDfB+2/zCzGzQBLdbQbcQCIMAoYWRnoptCpPDGDFnlrRBZnMZ+WarwAvEGn0GfL/
         85nTiOGGHJ3IO1DbjUxdGjspPlVZWkD2ZkMdjZEJnDVfAcQpM7pLU7Cqw8oqhL85c9m1
         j6ZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267249; x=1788872049; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RPgzm55fAw2ptYf8Sl/ajhFPBiEwWjWRkzAJIcml568=;
        b=JG7nn2zHwYIehlJyl4VM2hYnBzzdtxz2ZCD7c8gUL5vko9hW/FAGpzxJJzbIx4HlXd
         LZCW1O38ggJNfIGuRaqwd186pM4cOY7BGIeqCH3ngCKVbugF4v/4pGCNUhw73gnelWw8
         H6Wqe4YZIX7lPbUtA1V6/r+pYmza17+Eeh7/PFn19zVSQRx+hdfWs2Wg4Rg3BE76Eih2
         VvuIxexL21GiOdmQd8QsS98YeIwvdq7NYErXGbwUVSjjEM1tlpqYZ13Tubyg7J4zEPP9
         Zr+5bPZ+Hu9MFO5VyMPpTp98YaZI7f4yv7OfFJuqaheBdX6ao1t7jm8lZDwuoQXjBwv7
         a5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267249; x=1788872049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPgzm55fAw2ptYf8Sl/ajhFPBiEwWjWRkzAJIcml568=;
        b=jyCgfcCzZDFzf13G8RDT8f73gVEYjWo7Vs7ztTp2/TEgS6KJJb0ZGAOZSLZBX0CXpK
         sJCaYOv/3YwmeDwg8hsBlSA1sx99bF+TfE4C+qZnQCrb9gpLHKSWDwK15+X87UMDNKH+
         NziD/A51mitSloJF2khSpvre7NihoPUleO42KA1T/O5dl2fEPfB1ej4XHDBtd4oDVLqh
         DZpKyJpDh4AcZ0fJiOkqZr0TtLeIrROZbM3RGFy54Q+KnRgBIu3TmcuSRGXrbeulO1AX
         XCfroDG4JG/BQVV8QXw9l2xcgKVhAyJ93v8OJ5GAwI/JdbZHs2TvFs7qA+bGjwLgMZio
         PecQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzduTDM0xbfU19c3wK1FaPdwoN6IUqorRPI3eKrXNIfA+o45UICSluscU7eJZL1TU18bMEmxcARjdCV0biTA==@lists.linux.dev
X-Gm-Message-State: AFuF++lF8nM+hkvtCM4giE+dexodyf2MXAXf7dxQOcvlL1c7yRQQPCG4
	dBqJ/MTYnC5fVL5hcjsI/TrKATubZs1h/ND7ThrZoFlscUka2Vdt/sNuOp+0OwTgnZNS1QukNj1
	w1k9EegGBZ2lP5WsGgwebrUCAjzT7l9Q=
X-Gm-Gg: AYBFou1rb+l2aueM3ZfxeWbTSjMpejzlzIeFgVugR46D4EsJZLGsZDpVo1l6TBcBL6a
	2bwPCVy2G60PgKFuVDmEZTze0xKqPlno4qsi9FOyfzPC7OspP7OfRSr5iQpA6eELb2NEKtA/uTz
	/L+7+rV47QSbsD7RQdTozMbv1DlrTOxVjL65HprxdAieQLIP/1p8Ph80FqcGKas6O7HEkbNkfP2
	yBgMqvJj9EHlk4amZaH/LAabOgjTT/3InAStfhOh+v5+4mH3oLhroSeOw0I6/P7IwYeX8ls5BiE
	dQykUMNrmbdGWmMaVJk9mIs79vi33loJkQ6KJ+Ky9QWTG8rIWgjEWXZCCLk=
X-Received: by 2002:a05:6402:24d9:b0:6a5:f9ab:bdfd with SMTP id
 4fb4d7f45d1cf-6a60d15f4c5mr16070508a12.0.1788267248852; Tue, 01 Sep 2026
 05:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-2-puranjay@kernel.org>
 <20260826144636.3IRUXeFV@linutronix.de>
In-Reply-To: <20260826144636.3IRUXeFV@linutronix.de>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 1 Sep 2026 14:53:56 +0200
X-Gm-Features: AcwNN1VMVsqA5TbOoGtCimTix5w0rFzm4VjPnSAE7cacecLqde7MaGCaDPITNHM
Message-ID: <CANk7y0hbwXL7nBDgjTgrneBejEgGrsZnc02RztG-aSBEEvAcwQ@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 3:46=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-08-10 05:27:50 [-0700], Puranjay Mohan wrote:
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -572,6 +572,17 @@ static inline void tasks_cblist_init_generic(void)=
 { }
> >  #define RCU_SCHEDULER_INIT   1
> >  #define RCU_SCHEDULER_RUNNING        2
> >
> > +/*
> > + * Defer whenever interrupts are disabled, since a callback-list opera=
tion may
> > + * be in flight on this CPU.  Not before the scheduler is up: irq_work=
 is not
> > + * usable that early, and rcu_init() itself calls call_rcu().
> > + */
> > +static inline bool should_rcu_defer(void)
> > +{
> > +     return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
> > +            rcu_scheduler_active !=3D RCU_SCHEDULER_INACTIVE;
> > +}
>
> Why does the description say that the defer part is for usage from NMI
> and the test here has irqs_disabled() instead of in_nmi()?

We defer for both irq disabled sections, hard irq, and in_nmi() and
checking for irqs_disabled() covers all three.

>
> > +
> >  enum rcutorture_type {
> >       RCU_FLAVOR,
> >       RCU_TASKS_FLAVOR,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 21b6ce1dffb63..3bf3a250f9de8 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_ca=
llback_t func, bool lazy_in)
> >       local_irq_restore(flags);
> >  }
> >
> > +/*
> > + * Re-issue deferred callbacks straight to the enqueue so they cannot =
defer
> > + * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
> > + * rcu_defer_flush() and rcutree_migrate_callbacks().
> > + */
> > +static void __rcu_defer_drain(struct rcu_data *rdp)
> > +{
> > +     struct llist_node *node, *next;
> > +     unsigned long flags;
> > +
> > +     if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&rdp->defer_lock, flags);
> > +     llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) =
{
> > +             struct rcu_head *head =3D (struct rcu_head *)node;
>
> Why do you need the lock. This is still not clear to me despite the
> comment. You can do llist_del_all() towards another list and then feed
> it into rcu_do_enqueue() one by one. And you use the LAZY part.

Because rcu_barrier() can call this for each cpu and at the same time
rcu_defer_drain() can call it too, so this would cause a race where
the irq work can remove the callbacks (llist_del_all) and before it
can enqueue them, rcu_barrier will see that the list is already empty
and will not wait for these callbacks. We want the llist_del_all() and
rcu_do_enqueue() to happen atomically so rcu_barrier() can work
correctly.

>
> > +
> > +             /* Bounds a node self-linked by a double call_rcu(). */
> > +             head->next =3D NULL;
> > +             rcu_do_enqueue(head, head->func, false);
> > +     }
> > +     raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
> > +}
> =E2=80=A6
> > @@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
> >       rdp->rcu_onl_gp_state =3D RCU_GP_CLEANED;
> >       rdp->last_sched_clock =3D jiffies;
> >       rdp->cpu =3D cpu;
> > +     init_llist_head(&rdp->defer_head);
> > +     raw_spin_lock_init(&rdp->defer_lock);
> > +     rdp->defer_work =3D IRQ_WORK_INIT_HARD(rcu_defer_drain);
>
> Why is this IRQ_WORK_INIT_HARD() instead, say, IRQ_WORK_INIT_LAZY()? Is
> there a requirement that the RCU callback needs to complete asap and not
> be delayed to the next tick? This would give kind of the LAZY part.
>

In discussions with Paul, we concluded that we need HARD because in
low memory situations delaying rcu callbacks can be problematic. Given
that we are already deferring the callbacks, it would be nice to have
them enqueued asap. But if there are downsides to this we may change
it later.

> >       rcu_boot_init_nocb_percpu_data(rdp);
> >  }
> >
>
> Sebastian
