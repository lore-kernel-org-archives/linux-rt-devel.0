Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334042C51C
	for <linux-rt-devel@lists.linux.dev>; Fri, 31 Jul 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507985; cv=pass; b=NxvLs7oPRu0MVwKaySdAV/qu0rb7/CVng75FSRWReGPffjAeZxO9BYI2W53I523fgcR4/sRIQJL8yq5LNJpbELMSUN9KO3AQr4TAi4AFW3tQTZUWFpZuGuBoOYdoAZ698F6TmS+/ZCVTgZQpap8wLee1bE79XaS/qliQmM1YllY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507985; c=relaxed/simple;
	bh=OJEjYqZXR6D8o5i1tKss18NEHMG/oQmxzQk/ihg2t8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA//8pQ1YPhoojdqwNbdjUTGgef6F4E+Aqq6Oc7t+jDgE+bI67e3YHRsN0j2E6HQTEiQguhtt5k0fKPFg4NdFxmI2GMsdPwxO+KAosGSH6LUUxq0pRNSMNJOrSbPv6PDB+lH8JId3gCCMcICw4uij9434BYLta4Oxl8J5c3Jv5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwhjrllQ; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwhjrllQ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1f5208b38dso191379066b.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 31 Jul 2026 07:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785507981; cv=none;
        d=google.com; s=arc-20260327;
        b=bZ63WRZDPDle0hebaVcXQc7QoHK+iWo2ycMXqBiXIYPVZ3LYnnPQSgAnlxc6JT9z1y
         RE9m4ESqYrU7DHbgHU/msnd02Ys8MFHqBymp/KQPzj29F0ONN5H1aBvZDmaTIZKRxqjd
         55JRC6W9i67LWCjfN+9DowiOuZps7UFzv6nsHaHIaprn7EIOoEAywd1W7KtL5GNLutCU
         mhDdhjuIcZfuIsxlCzq0AEOiXXhat9AA/DfzHrNZvFYvg3mDr85NtW/sKQ7brgZ96aOu
         ydcuo1JYgYD0RfOavbTjWWDydXH+okGVjBF9+CnXSNeHpLE1HVIIyxA71ghfIRkWpD2z
         UyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2yZkXeMTFenp1C/Q3jIxXtZxx8SXWBO8BbuefERWdA=;
        fh=1HPorbDprh4xJ0DAf0Inqr+e9RnWnI845HoSp9VgC30=;
        b=ImrzOfg90AX8e/9EFztzVLJ21LFTWnapWsXyI4NQ8ENGGGpJBA/DbOUKL2xW9FiDqp
         Pzsq+3jYc6eXECbfCU2FLk4uMU45T/lL9CLmqtHbJPxDs27SDMMJyvxqPylVvJE942/f
         hsV6Zl5Cf016V+mmKaKLzKQL377HS4aJBkLbdl5/atXNbzGgb9mjqMgzLrJzJKpGISn+
         N+ghOnY3dI3Yri2LynZUtus8Z9l2D7WhWb/U1Lj3gSFowu3Bk370BYz/JvP31Yxowz4a
         bCH/fAIwyUrhtiZoesQzt9ZdcCPSjF+OBxNfBSrvXf7BaiLAKEdJP55Q6JuiNuUTtBSk
         75Mg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507981; x=1786112781; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W2yZkXeMTFenp1C/Q3jIxXtZxx8SXWBO8BbuefERWdA=;
        b=PwhjrllQnZGk/ncOdASgrr9e8SD8ofVtgiW5h0NpvKK30tDeg4QjWAXd4RH6un1mJO
         2BDDhGt0KLlsVt5AknHMhDA+XY0q+NkVtyvxb/qKXAN0tDfG1XYXMLedv43ahkuRRrrS
         2430AC2ytvT2oScCUxM8E6G7u+cILKmAFAazdwNg/NvAHRDMXed1cnxt5bmvzhim/M65
         pI6DfjrPfjgWJXbxRvjH2Q4CDHZQwviHyUXK7DQ4/N0O+1CikKYXZZzbvqbJJnzTZOJG
         0A06oHdaUGLe2mAiQKsSFn6QJvacjYgbLBCHDcnE4NDffx531xNv3G3tzr0rM/bz0BGQ
         rwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507981; x=1786112781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2yZkXeMTFenp1C/Q3jIxXtZxx8SXWBO8BbuefERWdA=;
        b=dmFYH3d7pmmu++PbuKZdkIAriQjtvIrBU5hBIAyi1wF7OTA8n+ptIkYT+tiCZmmHpX
         1oGs0ZtVx9NDuPOOQtBXveRO721Gu67bDsR/cHSY3S02kY9pfCU+NHM+FS8LY3tuN83Z
         QnnbVKwPY+blZ6ws0WGLOXjOWv29kBdv1yfEPa0P2YyhOpAPkSm0msTBVSjtKAJ1bHEd
         5V4J+1z+pg7mCDxWiEhGhJxvylfyWKhA7YgsWKsyFH/8726KbHI2zQQLvcppvX691hhS
         CY6e7NIVbHc79lWDmKEfsXwOOWnZGfU37Hw3qiW0zR8O2NXe8Vp/rHzqL2gy4MUzrrrH
         0dZg==
X-Forwarded-Encrypted: i=1; AHgh+RrovgfpVPNrRNieUjsZhhmO2zx6F6hx3gGND6eTEx5eOnTNHsY/kLCWVBRmUzEZjBnt7dRPqxE/EoBGoy9hwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw39yxtZYYaFfBKZHaHQ28vbzu3toI2OuHV6c1FUi1XRqomA27S
	m5fHeVIjdn9pqKgR7nO97/kIjZQmsf6ivmO4FSLjTAdRpE56CTKmtciT9Aksbyyu1ddMvvyMXKE
	fAaJxBCWNDl59ytOIO8C19W8+O4o3+kA=
X-Gm-Gg: AR+sD10M259lxyuMdW00aJORDu8JKoY+83CcLju7/1n2iqBeVyXwVx/CcV6diWGzqUO
	Vtj890WZQI+KTF92lC8UaYaaGfks6EB4acywTYjH7qMKSTi/uB9aC7FBM2Aju++MmodIkOWI/pR
	+oembVRD7DIa/cSJmalMsnq2OaAYSK7TBXWq02CihbRLL8X6bwTjrp/h/wNaIJUrDufdVe8nj4b
	weJ5T/lvHNNVvWfxOOfDIjdkdh5fi1FzJbg14q5HqFnVkwYJXqByleI47xmJcsc8Y3Tor3koAde
	MSfybTDoy/6uA+sixBhh+Xdsu/sCN7WR/m5zExpWEZcWtVUEzgNgwkRkQ80R
X-Received: by 2002:a17:907:3f8f:b0:c12:4cb8:a826 with SMTP id
 a640c23a62f3a-c1fd238bfb3mr118334566b.6.1785507980912; Fri, 31 Jul 2026
 07:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260729162207.1567770-1-puranjay@kernel.org> <20260729162207.1567770-4-puranjay@kernel.org>
 <96a07fd8d37018b005de85a0eac6045fa426e892@linux.dev>
In-Reply-To: <96a07fd8d37018b005de85a0eac6045fa426e892@linux.dev>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 31 Jul 2026 15:26:07 +0100
X-Gm-Features: AUfX_myqCfx8h0yHc581WwWjTLagnsHorHWGgwfxqIRoqW5qkV1Oj9THSsqRF-8
Message-ID: <CANk7y0g3tE7YJMV4nokqjiaMVeENVKxSv3zjLinXWF4GD4zzxw@mail.gmail.com>
Subject: Re: [PATCH 3/6] srcu: Make call_srcu() safe to call from any context
To: Zqiang <qiang.zhang@linux.dev>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Fleming <mfleming@cloudflare.com>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:03=E2=80=AFPM Zqiang <qiang.zhang@linux.dev> wrot=
e:
>
> >
> > call_srcu() has the same constraint as call_rcu(): its callback list an=
d
> > locks are only touched with interrupts disabled. srcu_gp_start_if_neede=
d()
> > enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,
> > and callback invocation and grace-period work do likewise. So a
> > call_srcu() with interrupts disabled may be racing a list operation in
> > flight on this CPU, and enqueuing directly could corrupt the list or
> > deadlock.
> >
> > Defer as call_rcu() does: stage the callback on the srcu_data's
> > ->defer_cbs, chain that srcu_data onto a per-CPU list, and kick a per-C=
PU
> > irq_work that re-issues it straight to the enqueue helper -- never back
> > through __call_srcu(), so it cannot defer again.
> >
> > The irq_work is global (per CPU, not per srcu_struct) and statically
> > initialized, so the deferral never runs check_init_srcu_struct(). It is
> > IRQ_WORK_INIT_HARD to re-issue promptly, as for call_rcu(). srcu_barrie=
r()
> > and cleanup_srcu_struct() flush it first, and rcutree_migrate_callbacks=
()
> > calls srcu_offline_drain() to drain an outgoing CPU's deferred callback=
s.
> > Gated by CONFIG_RCU_DEFER, as for call_rcu().
> >
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  include/linux/srcutree.h | 4 ++
> >  kernel/rcu/rcu.h | 3 +
> >  kernel/rcu/srcutree.c | 138 ++++++++++++++++++++++++++++++++++++++-
> >  kernel/rcu/tree.c | 2 +
> >  4 files changed, 144 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 75e54e4f963fa..1ce759fb70948 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -13,6 +13,8 @@
> >
> >  #include <linux/rcu_node_tree.h>
> >  #include <linux/completion.h>
> > +#include <linux/irq_work_types.h>
> > +#include <linux/llist.h>
> >
> >  struct srcu_node;
> >  struct srcu_struct;
> > @@ -41,6 +43,8 @@ struct srcu_data {
> >  bool srcu_cblist_invoking; /* Invoking these CBs? */
> >  struct timer_list delay_work; /* Delay for CB invoking */
> >  struct work_struct work; /* Context for CB invoking. */
> > + struct llist_head defer_cbs; /* Callbacks deferred on re-entry. */
> > + struct llist_node defer_link; /* Links onto the per-CPU deferral drai=
n list */
> >  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
> >  struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
> >  int srcu_ec_state; /* State for srcu_expedite_current(). */
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index ed6604445f2ac..036d28516e92d 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -587,6 +587,9 @@ static inline bool should_rcu_defer(void)
> >  return irqs_disabled() && rcu_scheduler_active !=3D RCU_SCHEDULER_INAC=
TIVE;
> >  }
> >
> > +/* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrat=
e_callbacks(). */
> > +void srcu_offline_drain(int cpu);
> > +
> >  enum rcutorture_type {
> >  RCU_FLAVOR,
> >  RCU_TASKS_FLAVOR,
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 304112674e8a2..b9fe57ff91000 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/preempt.h>
> >  #include <linux/irq_work.h>
> > +#include <linux/llist.h>
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/sched.h>
> >  #include <linux/smp.h>
> > @@ -79,6 +80,46 @@ static void process_srcu(struct work_struct *work);
> >  static void srcu_irq_work(struct irq_work *work);
> >  static void srcu_delay_timer(struct timer_list *t);
> >
> > +static void srcu_defer_drain(struct irq_work *iw);
> > +
> > +/*
> > + * Per-CPU call_srcu() deferral state. The irq_work is global (shared =
by every
> > + * srcu_struct), so it must find which srcu_structs deferred callbacks=
: a
> > + * callback is staged on its srcu_data's ->defer_cbs, and that srcu_da=
ta is
> > + * chained (->defer_link) onto this per-CPU ->list that the irq_work w=
alks.
> > + */
> > +struct srcu_defer {
> > + struct llist_head list;
> > + struct irq_work iw;
> > + raw_spinlock_t lock;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct srcu_defer, srcu_defer) =3D {
> > + .lock =3D __RAW_SPIN_LOCK_UNLOCKED(srcu_defer.lock),
> > + .iw =3D IRQ_WORK_INIT_HARD(srcu_defer_drain),
> > +};
> > +
> > +/*
> > + * Register pending deferred call_srcu() callbacks so a following srcu=
_barrier()
> > + * waits for them. An online CPU's own irq_work re-issues its callback=
s, so wait
> > + * it out; an offline CPU's irq_work may never run again, so drain its=
 list
> > + * directly onto this CPU instead.
> > + */
> > +static void srcu_defer_flush(void)
> > +{
> > + int cpu;
> > +
> > + if (!IS_ENABLED(CONFIG_RCU_DEFER))
> > + return;
> > +
> > + for_each_possible_cpu(cpu) {
> > + if (cpu_online(cpu))
> > + irq_work_sync(&per_cpu(srcu_defer, cpu).iw);
> > + else
> > + srcu_defer_drain(&per_cpu(srcu_defer, cpu).iw);
> > + }
> > +}
> > +
> >  /*
> >  * Initialize SRCU per-CPU data. Note that statically allocated
> >  * srcu_struct structures might already have srcu_read_lock() and
> > @@ -107,6 +148,11 @@ static void init_srcu_struct_data(struct srcu_stru=
ct *ssp)
> >  sdp->cpu =3D cpu;
> >  INIT_WORK(&sdp->work, srcu_invoke_callbacks);
> >  timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
> > + /*
> > + * ->defer_cbs and ->defer_link are valid when zeroed and are not
> > + * reinitialized here, lest we clobber callbacks a reentrant
> > + * call_srcu() already staged. See __call_srcu().
> > + */
> >  sdp->ssp =3D ssp;
> >  }
> >  }
> > @@ -697,6 +743,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> >  return; /* Just leak it! */
> >  /* Wait for irq_work to finish first as it may queue a new work. */
> >  irq_work_sync(&sup->irq_work);
> > + /* Drain any deferred callbacks (shared irq_work) before freeing ->sd=
a. */
> > + srcu_defer_flush();
>
> 1. Should we move srcu_defer_flush() before irq_work_sync(&sup->irq_work)=
 ?

Will fix it in next version.

>
> 2. Will the following scenario trigger soft/hard_lockup ?
>
>     In irq_work context, irq disbaled:
>     srcu_defer_drain
>     ->srcu_do_enqueue
>       ->srcu_gp_start_if_needed
>         ->rcu_segcblist_enqueue
>           fentry ebpf prog
>              call_rcu_tasks_trace()
>              ->__call_srcu()
>                ->should_rcu_defer() =3D true
>                  ->llist_add() + irq_work_queue()
>                    the ipi send and irq_work run again -> srcu_defer_drai=
n()->srcu_do_enqueue
>
> Did I miss something?

BPF programs don't allow recursion on the same CPU for the same BPF
program, but your scenario can still occur because here the BPF
program doesn't recurse rather it keeps enqueueing and firing IPIs.
Before this patch it would have been a deadlock.

So, this is expected behaviour and to fix it we have following options:

1. Make stuff under call_srcu() notrace or keep the normal enqueue
traceable (so the outer reentry still happens once and the deadlock
fix is still exercised), but have srcu_defer_drain() re-issue through
a notrace copy of the enqueue chain so the prog can't fire during
  the drain.
2. Accept it and document it, and correct BPF programs like the
selftest in last patch will work because they detect reently.
3. Have a per-cpu in-drain flag set in srcu_defer_drain() and if in
call_srcu should_rcu_defer() returns true and this flag is set +
in_nmi() returns false, this means we are in this refeeding loop, so
we can just leak that callback with a warning.

I prefer option 3 but let's wait for Paul for his feedback.

Thanks,
Puranjay
