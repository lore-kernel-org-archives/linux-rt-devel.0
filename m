Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85247B3E1
	for <linux-rt-devel@lists.linux.dev>; Fri,  8 Nov 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068733; cv=none; b=lNxlltdvAMVDw8F8XENwa1r4RPRsTgeuar+3t1JaPC8GqioPf/c/Lng0R0ps+xsfs4vRBRRcQ3eMVGBrEFk/nX82+pRkR4GDe/Tv7tIu1h3Ld89rVHP/jnyQxyiAStIkM3RKP/MG+pxvrtPA5apyw9A+Y4OEM16xbWwFBfuPP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068733; c=relaxed/simple;
	bh=/DZIyIVNVYxQ0P5vmZWSgMgzwWj1SDhfncQTN2zzykc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwD2GTROmGqkt7h+2LxUE8ttd5lCHjmNEXrrUDMblBby9pqMpwoIxUA879UZ/EzrJGaONPGP3po/tNvknKsgxLZ8OFzMwgJT+vQC+444z1Y0494XVlBKbtwWAml5hiC1xRfrcDHnbjHdAzU8EII8i8MZU5z7UU6NiGBBgBdB5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3EXv151; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GShr2d71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3EXv151";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GShr2d71"
Date: Fri, 8 Nov 2024 13:25:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731068730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w96ZzVx/1wsAhdKhDW1BLgPsTJNeNxo6XW9E0Mn8uWc=;
	b=Q3EXv1514OJVDuww8nlNJNkBnFtcJZ4fFY1TqR52vc6Fh0c9bXlkelltlcjuGnHqHpr8RI
	e5U3Dxm80pQy9/EDiYluHwZQg5vhA3aGoIb5ncAfa+7yNreoGzRPWsO8Zb0FIM0aqls33W
	3xC9n5Bv6f6PhOAKeqyaflbiA9//eVcd1ETlU4hYH+aFtXq6REtsTI1ANTbS50O3o/k5S8
	4DF4v0t+JcJQy+8s0ZvvVLHZcKs8YaIjX86lkdweH255o2Ak+WVh/kocRdGLPjRYggm06l
	gsJzL4cHgOTV7RYjo3ZBTuF1KYIDd4DbsudU7foaW3gwve/j6aVsMmRkBtkKVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731068730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w96ZzVx/1wsAhdKhDW1BLgPsTJNeNxo6XW9E0Mn8uWc=;
	b=GShr2d71EHy+EZjqkNN4uUlIciV0hcjdzwllzH24gt5ejOQ4ZJwMbO2TmyuJbWA9rvgNVg
	xD/B7qFrkS5PvTCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v4 1/3] softirq: Allow raising SCHED_SOFTIRQ from
 SMP-call-function on RT kernel
Message-ID: <20241108122528.YV91-QWl@linutronix.de>
References: <20241030071557.1422-1-kprateek.nayak@amd.com>
 <20241030071557.1422-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241030071557.1422-2-kprateek.nayak@amd.com>

On 2024-10-30 07:15:55 [+0000], K Prateek Nayak wrote:
=E2=80=A6
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -280,17 +280,24 @@ static inline void invoke_softirq(void)
>  		wakeup_softirqd();
>  }
> =20
> +#define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
> +
>  /*
>   * flush_smp_call_function_queue() can raise a soft interrupt in a funct=
ion
> - * call. On RT kernels this is undesired and the only known functionality
> - * in the block layer which does this is disabled on RT. If soft interru=
pts
> - * get raised which haven't been raised before the flush, warn so it can=
 be
> + * call. On RT kernels this is undesired and the only known functionalit=
ies
> + * are in the block layer which is disabled on RT, and in the scheduler =
for
> + * idle load balancing. If soft interrupts get raised which haven't been
> + * raised before the flush, warn if it is not a SCHED_SOFTIRQ so it can =
be
>   * investigated.
>   */
>  void do_softirq_post_smp_call_flush(unsigned int was_pending)
>  {
> -	if (WARN_ON_ONCE(was_pending !=3D local_softirq_pending()))
> +	unsigned int is_pending =3D local_softirq_pending();
> +
> +	if (unlikely(was_pending !=3D is_pending)) {
> +		WARN_ON_ONCE(was_pending !=3D (is_pending & ~SCHED_SOFTIRQ_MASK));
>  		invoke_softirq();

This behaviour also happens with threadirqs on !PREEMPT_RT but without
the warning. I haven't checked it but I expect invoke_softirq() to wake
ksoftirqd here, too.
This only happens because of 2/3 in the series as far as I can tell.

Now I am curious to hear from the sched/ NOHZ folks if it makes sense to
invoke SCHED_SOFTIRQ from within ksoftirqd because unlike on an idle CPU
the CPU is now not seen as idle due to ksoftirqd running on the CPU.
There is code that checks rq->nr_running and/ or idle_cpu().

> +	}
>  }

Sebastian
