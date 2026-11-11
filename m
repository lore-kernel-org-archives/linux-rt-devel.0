Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401962;
	b=q9Vxgmc/b8nT9fnScDxLxsDgXZ0O+8RVzQoDOHKHvtQ2ZOt6v0ea7vhp2nq1STgnfgfs
	 dWUsJD/aCHWXfUEK7yWxnB4ANcZEQxZET8PR0RYQxNTE/Lepl4acrbL4M/5jcyvcrr04Q
	 6u96s96p2WAhxwvo21H/g7KDeX0ChUP58xWjrlBjPGqdmunzK7JxWtowrFbIiB/WmCOy+
	 jcVs5SPHb3bg948JVY2y56dxlBX2LoyG1oMC/EFZMDa+DGWnwiNzQeOuuY9BRDuHfW48a
	 YmfkZmoNRI4oqQasreff1Fnht0l4onbMBT5YHcZZA2GhSsyvn2cbihnyw8tXumZKJeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401962;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=Sfjm76wcFaYplzSjvgbZRL4nEIoICacZtL8Z7ioFei4=;
	b=D1XMCSTWjRmFTK/AkXF+VO7CpKr1yMCz0a8txk/YLdTrJIjlTYKwSzXNdiyMVcT54kl+
	 zbqSi5M5knLBej2x9VAeRPnlEw6/Cmjc25jLcsfEQ7VUJu6d/DsjxmXmj+kJkH/e/W7Ir
	 Ve4w2+mAys2wp9fOPTMfBMwjgzoXILuldJIUQuvBjO+GmMDaw7nrqnHgwPRZGrhz8E6KU
	 3N/bFZ2DOaYuZNA+Mv70d3ARzoZR2ac6GxkQmWhUS22i6hwWPFt8JHTGJ6dmU4x0rTAxk
	 BBn4H1TVAkgqgg3iOZsr8vrBZ67+KaRMP6+XPgiMAyGbPANfYOabKi41BKuFboZnR2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Smiccc5X;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9E606A887
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 12:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC9E606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Smiccc5X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794401960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sfjm76wcFaYplzSjvgbZRL4nEIoICacZtL8Z7ioFei4=;
	b=Smiccc5XO49PMyUug1kF3pjsPszfftMnVBpgNlav+pQkype24Nk9GhCQZQfZ33DpJguM2D
	xlq52biitAoXbC+sEieXvnqjVAmE9jOfLRpq7tFCBErIySuHFQy6ZRe5Ojhux9HUPLhO6G
	CcKh0UEQCF6IU3sJbiqkImdrE57HOT0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-oBMxFdHHMCqqsXRsJC-_Pw-1; Wed, 11 Nov 2026 07:59:19 -0500
X-MC-Unique: oBMxFdHHMCqqsXRsJC-_Pw-1
X-Mimecast-MFC-AGG-ID: oBMxFdHHMCqqsXRsJC-_Pw_1794401958
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490c69dc02bso2669644f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 04:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401958; x=1795006758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sfjm76wcFaYplzSjvgbZRL4nEIoICacZtL8Z7ioFei4=;
        b=fgKzTgBtyPU6wit8pcnebrb3CeD4PUKVcEc60exgQ4Q2hEi68RP+ZTi1LZRByVVYZz
         thcQMvdRn8KTliQfV0ZIKo+P6JgqcTCDLKevtEnEjmT6axyBBMTR/x81pJp2I+E4oipG
         bL0XtkkkbFaIzo5NaBMmuy6W+5QmDjSbZybe1eaenWIpRiNBRiiqLOL7fMAtdQJYlQnn
         JIDxHw5UpWidlxZwXJ8OhA2pOdnoLTGVbd+MiXM3fR9VtypUV21Nks7E5+0NXkLL28h1
         RhPRfx9XWiTDrWSE88OIHgsu2kBwAB7JNMiEZAPLYgCBlYExp5+PPREHO8R7jYMVtZbf
         Optg==
X-Forwarded-Encrypted: i=1; AL+hErGxFFL9dHFfTKhWHG44ynx62r9at6EAWrCnRBibue8Xg3BnsYIFpQeO0RZ8Y7MlMrajCYmYty0kdL17bZ/32w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/PQHckL3lnJmcqpRRm74znKYAkq/+P3FM04Q4AmM0WWofA294e
	e+gSjh7wDcLQBuPrNTmanSNQx8FsyrSx/Cx7KXHhunwv1nObVHQKIB8TwWYePDSgNgHRxOEDkk8
	CmlPKlk4CyIJ6x5fOFh3LKsMYrBXiWdCbIww4/TzOa8IBYp+1TmI4ozPGL7QrRzP8VMGr
X-Gm-Gg: AYBFou3bg/iiLgEtU1ZZMuZcU4WMDQ10uougC3MBAaM5idJujCTjUrdHWQWyPgqy0JP
	gyVqCPGGlODeLRZQvdVNPTWaP6TDueSkLOtipeKxHOuXzS8cOmFtppescIBQuWhlErfmuGILRfS
	Ori7/DLDYJW5WrZPaIrGdzCo7GIWDc3N2fuXlcfokxWpA12VQBMg9y45IqXdHhgBWdnwmxTjsjP
	5V+wWbi/41JvCvAq6ejRywP2+Y2ypBSfKW8Pg7t8ZuTJOc7aElLy0K1vRdLbrYIhA6HVwZPkxiE
	OgRLLWol5aiJi9jT2SHj+mIt0nJb2wO54rk1BjC6qHTvhbvVDkE/2TEgE+1HYSu5N5QFz6+2iAZ
	qcNyzzoW+iuFxe2J+uE2npjlvItF99kaUlt7PzZsISE5GLewZIdyHDg3k9dFNFEqwsmth5ZMLDD
	5+ZYk=
X-Received: by 2002:a05:6000:2502:b0:491:1e11:9ffe with SMTP id ffacd0b85a97d-499c48154f6mr4396737f8f.2.1794401957776;
        Wed, 11 Nov 2026 04:59:17 -0800 (PST)
X-Received: by 2002:a05:6000:2502:b0:491:1e11:9ffe with SMTP id ffacd0b85a97d-499c48154f6mr4396705f8f.2.1794401957282;
        Wed, 11 Nov 2026 04:59:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49842f2a1f9sm11424324f8f.15.2026.11.11.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:59:15 -0800 (PST)
Date: Wed, 11 Nov 2026 13:59:12 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 13/29] sched/deadline: Keep departing bandwidth across
 a root domain rebuild
Message-ID: <avRmoK08LoIeySBL@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-14-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-14-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gTD3W2ijHQ-BJ-O9EC57HyaAXoIkNrR0XkpEbbjO6jI_1794401958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A task that leaves SCHED_DEADLINE, or dies, keeps its bandwidth in
> total_bw until its 0-lag time. This keeps admission control on the safe
> side. Then inactive_task_timer() removes it from the root domain of the
> task's CPU. Two things break this:
> 
>  - A rebuild of the accounting clears every root domain, then adds back
>    the deadline tasks of the cpusets. It misses a task out of the
>    class, or a dead one. Their bandwidth is dropped, and the timer
>    removes it again.
>  - A task out of the class can also move to another root domain. The
>    timer then takes total_bw from that one, which never had it.
> 
> Either way, a root domain admits deadline tasks beyond its capacity
> until the next rebuild.
> 
> Fix this with dl_departed_list. A departing task goes on it with the
> CPU it is on. A rebuild puts its bandwidth back in that CPU's root
> domain. The timer removes it from there, and so does
> sched_dl_overflow() for a task back in the class.
> 
> A rebuild still drops the bandwidth of a task whose CPU is inactive, or
> that dies during the rebuild. Each task records a count of the
> rebuilds, dl_bw_gen, with its bandwidth. The timer removes nothing if a
> rebuild came since.
> 
> Make dl_cookie and dl_bw_visited() static: only deadline.c uses them.
> 
> deadline_rebuild_test, added later in this series, fails every time on
> v7.3 and v7.4-rc1 kernels. A one-CPU partition root admits two tasks of
> 600ms every second there, where it has room for one. It passes with
> this patch.
> 
> Fixes: 387e31300b57 ("sched/deadline: Fix the update of the total -deadline utilization")
> Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

...

> +/*
> + * A task that leaves SCHED_DEADLINE, or dies, before its 0-lag time keeps
> + * its bandwidth in total_bw until that time. Then the inactive timer
> + * removes it. Meanwhile the task may run anywhere, under another policy.
> + * The timer holds a reference to it.
> + *
> + * A rebuild of the root domains' accounting (dl_clear_root_domains() and
> + * dl_add_task_root_domain()) does not find such a task among the deadline
> + * tasks of the cpusets. So dl_departed_list holds these tasks, from their
> + * departure to their timer. The rebuild puts their bandwidth back in the
> + * root domain of the CPU each one was on when it left.
> + *
> + * dl_bw_gen counts the rebuilds. Each task records its value when its
> + * bandwidth is counted. If a rebuild dropped the bandwidth since, there
> + * is nothing to remove. A rebuild drops it when the CPU recorded is no
> + * longer active. It also drops the bandwidth of a task that dies while
> + * the rebuild runs. The cpuset walk skips that task, and it was not dead
> + * yet when the list was put back.

It took me a bit of staring to (hopefully) understand better how
dl_bw_gen works, maybe the following can help others?

 /*
  * dl_bw_gen numbers the rebuilds of the accounting: how many times the
  * root domains were wiped and reconstructed (dl_clear_root_domain
  * increments it). A task records the number of its last definite
  * state, counted or settled. That number dates the state:
  *
  *  - Current: the bandwidth is counted, or a release settled it since
  *    the rebuild began. A release subtracts; the walk of the cpusets
  *    skips.
  *  - One behind: the clear that just ran wiped it. The rebuild puts
  *    it back.
  *  - Older: an earlier rebuild dropped it. Leave it out; its release
  *    removes nothing.
  *
  * Only equalities are compared, so the wrap of the counter is
  * harmless.
  */

> + *
> + * dl_departed_lock protects the list and both counts. Take it with
> + * interrupts disabled, under the task's rq lock or pi_lock or in the
> + * rebuild, and before any dl_bw lock.
> + */
> +static LIST_HEAD(dl_departed_list);
> +static DEFINE_RAW_SPINLOCK(dl_departed_lock);
> +static unsigned int dl_bw_gen;

...

> +/*
> + * Clear every root domain before a rebuild of their accounting, and count
> + * the rebuild in dl_bw_gen. Put back the bandwidth of their servers. Put
> + * back the bandwidth of the tasks on dl_departed_list, which no cpuset
> + * holds as deadline tasks. Put each in the root domain of the CPU
> + * recorded for it, or drop it if that CPU is not active.
> + * dl_add_task_root_domain() then adds the deadline tasks of the cpusets.
> + */
> +void dl_clear_root_domains(void)
>  {
> -	dl_clear_root_domain(cpu_rq(cpu)->rd);
> +	struct sched_dl_entity *dl_se;
> +	u64 cookie = ++dl_cookie;
> +	struct dl_bw *dl_b;
> +	int cpu;
> +
> +	guard(raw_spinlock_irqsave)(&dl_departed_lock);
> +	dl_bw_gen++;
> +	for_each_possible_cpu(cpu) {
> +		if (!dl_bw_visited(cpu, cookie))
> +			dl_clear_root_domain(cpu_rq(cpu)->rd);
> +	}
> +	list_for_each_entry(dl_se, &dl_departed_list, dl_departed_node) {
> +		cpu = dl_se->dl_departed_cpu;
> +		/*
> +		 * Skip bandwidth that an earlier rebuild dropped. It is not
> +		 * counted now, and its release removes nothing
> +		 * (dl_task_release_bw()).
> +		 */
> +		if (dl_se->dl_bw_gen != dl_bw_gen - 1)
> +			continue;
> +		if (!cpu_active(cpu))
> +			continue;

Maybe additional info can again help (before the above)?

 /*
  * Drop the bandwidth of a task whose CPU is inactive.
  * That CPU no longer identifies the root domain that
  * counts it: a CPU going offline sits in the default root
  * domain by then, and the old one cannot be found back
  * from the recorded number. The release then removes
  * nothing, and no later rebuild restores it.
  */

> +		dl_b = dl_bw_of(cpu);
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_add(dl_b, dl_se->dl_bw, dl_bw_cpus(cpu));
> +		raw_spin_unlock(&dl_b->lock);
> +		dl_se->dl_bw_gen = dl_bw_gen;
> +	}
>  }

...

>  static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  {
>  	cancel_inactive_timer(&p->dl);
> +	/*
> +	 * A task on the departed list gets here when priority inheritance
> +	 * boosts it back into the class before its 0-lag time. (A policy change
> +	 * took it off the list in sched_dl_overflow().) The inactive timer no
> +	 * longer removes its bandwidth: the task does when it leaves the class
> +	 * again. So take it off the list. If the task moved to another root
> +	 * domain meanwhile, it then takes the bandwidth from that root domain
> +	 * instead.
> +	 */
> +	if (p->dl.dl_departed_cpu >= 0)
> +		dl_task_undepart(p);

Can something like the following happen? And do we actually have a test
for it?

1. T departs. A SCHED_DEADLINE task with bandwidth X leaves the class
asleep, 0-lag still ahead. Per the design, X stays counted in rd(A)'s
total_bw; T goes on dl_departed_list with dl_departed_cpu = A, and the
inactive timer is armed as the designated releaser. So far so good — the
record says "rd( A) owes X on T's behalf."

2. T migrates. T is now a fair task; it wakes and gets placed on a CPU
in a different root domain, rd(B). task_cpu(T) = B.

3. T is PI-boosted back. A deadline waiter blocks on a mutex T holds ->
rt_mutex_setprio -> class change -> switched_to_dl():
   - cancel_inactive_timer() — the designated releaser is cancelled;
   - dl_task_undepart() — T is delisted and dl_departed_cpu is reset to −1.

   X is still sitting in rd(A)'s total_bw, but nothing anywhere
   remembers that. T runs in rd(B) on its donor's reservation.

4. The boost ends. T is deboosted out of the class -> switched_from_dl()
-> task_non_contending() -> dl_task_release_bw(p, task_cpu(p)). T is not on
the departed list, so the passed-in CPU is used: X is subtracted from
rd(B).

...

Apart from the above, the proposed approach looks alright. I now wonder,
though, if an overall different scheme might make more sense. The
half-baked solution we have today for rebuilding bandwidth information
after domain changes is based on cpusets keeping track of DEADLINE tasks
(with the indirect cpu <-> rd association complicating things further).
With dl_departed_list, we now have one half of a per-domain membership
structure; the accounted current tasks are the other half. Wouldn't it
be better to move to a single list of accounted tasks (current and
departed alike), keyed by their recorded home CPU, which turns the
rebuild from a reconstruction into a re-partition? The dl_bw_gen
machinery and the cpuset walk would both go away. I understand this
would require some major restructuring of a number of patches in this
set, so maybe we can think of doing it after this set lands (or the
majority of the patches in here). Unless you are open to trying the idea
(if it makes any sense) and see if it simplifies things?

Thanks,
Juri

