Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908754;
	b=gvKDzyWphbg1tx48jES4R9Q+XjsTp3krIsH9bbZTvva8x7CPOXVQ3Wr0JPfMi+Kc+AyN
	 XFhUG53KLu5jWIBtBuwEEbmIzgyCtmUylqVVQTL32jAS50i+j3SZ3nCf1E6Mn39wr+0f+
	 KchTIjmiUHfF1+4QFdaTVTD7pi1v6ATMlQvvQrBZCKhJ5PMbeD4XKggRP3Jr7sh8nExWn
	 NNxqm9LJpJdUTIPhZGGrAnHoBqbW8s2FU3Zhwm6mdHMS17GWTHJ8nRQlWXs4U3Yd0EQyF
	 FqLqGxqXIr9HpnoNtYk07hB54cGNNXTg7HHcHBmy7EquIsAVOn2crD6nLADWtxqyaSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uIbqAv/iYnsPELgPkgkeXSFt290YGzExas5OGg+SYo4=;
	b=sfoZ44FrSxI/1ZVDlRCguI6FP/Y9AkXLmpw0VOBC8tcwyDjsOrR9HZH17LWBaVbf0EM2
	 zBDFUxCsHPLL7mESrkkl7UBLZRJXCmVNQnZFYWj4QrGmkMs9d8jZdIhvDtQXrndt0xvS4
	 VfkNpvdr6spi1CjrUExU3sF1BXv/v04hGT5egVYSogKzpNoMiBJ/mECxZFb/s9ch1B7b6
	 /sAF6M5Eb4iaC9OF2h/fXBNg9OI3JPWsR64BUA1jWVcA3JLpg47v/GdaretztRyxn5o8z
	 MScIOFWm3fA5nUqbybO+D3Y6ZAla8l2RKVUjapTm5rliVl97gb94O9y4dqvW7QiQNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX5epRQ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E77606A339;
	Thu,  5 Nov 2026 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX5epRQ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A0C1F008A1;
	Thu,  5 Nov 2026 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908754;
	bh=uIbqAv/iYnsPELgPkgkeXSFt290YGzExas5OGg+SYo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EX5epRQ64X6C9mWQ3RGrNSqerl5hh/b+ejtC/N6tEnHGXiOg32x98HHz/8X878Qc1
	 Y0wBbBkpQ9L9eFfX170t0nF2FVZD4YrTwD66wsnsbyyd7QsErFuqcosamT1hfs9nKj
	 LDtxmNQAp3uw2FLq+NLPFL/ELn6eh4J9pl7m51EtDpqt//0Rf/JMqh2mXWBZH/kRqp
	 DJVmQq0K5ZMOHlNA6ERG/w6yBUah5K5wPtUnhtddvR86e3w8XyfM/VB28GaF7svPLu
	 OYzU9L9chGh4UDpJI6h8HtbY6NmeWuVGYXsnqd1S/kYPpuKGs5XWSMK8Q1lpsUHR2v
	 vMTB4tfOq9Ptg==
Message-ID: <sashiko-outbox-200068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/24] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-5-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-5-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:59:13 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched/deadline: race in sched_server_write_common() with sched_c=
pu_activate()
--

commit 4111950ab95c5b8efd686d2867c9f080dc134211
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not divide by zero active CPUs of a root domain

This commit guards __dl_sub() and __dl_add() against dividing by zero when
a root domain has no active CPUs, and updates sched_server_write_common()
to reject debugfs writes when the target CPU is not active.

> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index e6a3b516c703b..a4ae092e0a684 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -410,7 +410,12 @@ static ssize_t sched_server_write_common(struct file=
 *filp, const char __user *u
>  			return  -EINVAL;
>  		}
> =20
> -		if (!cpu_online(cpu_of(rq)))
> +		/*
> +		 * Nor while it is inactive, going offline or coming online: the
> +		 * server's bandwidth is not counted in its root domain then,
> +		 * which has no active CPU to spread a change over.
> +		 */
> +		if (!cpu_active(cpu_of(rq)))
>  			return -EBUSY;

[Severity: Medium]
As reported by Sashiko on v2 [1], is checking cpu_active(cpu_of(rq)) under
rq_lock_irqsave without holding cpus_read_lock() sufficient to prevent
running dl_server_apply_params() while the CPU still sits in
def_root_domain with its server bandwidth unaccounted?

In sched_cpu_activate(), set_cpu_active(cpu, true) marks the CPU active
before cpuset_cpu_active() attaches rq to the active root domain and
rebuilds bandwidth accounting via dl_rebuild_rd_accounting():

kernel/sched/core.c:sched_cpu_activate() {
	sched_smt_present_inc(cpu);
	set_cpu_active(cpu, true);

	if (sched_smp_initialized) {
		sched_update_numa(cpu, true);
		sched_domains_numa_masks_set(cpu);
		cpuset_cpu_active();
	}
	...
}

If sched_server_write_common() runs in the window after
set_cpu_active(cpu, true) and before cpuset_cpu_active() attaches rq to
its active root domain, cpu_active(cpu_of(rq)) is already true, but
rq->rd is still def_root_domain (where total_bw was cleared to 0) and
rq->online is still 0.

When dl_server_apply_params() then operates on def_root_domain.dl_bw with
old_bw > 0:

kernel/sched/deadline.c:dl_server_apply_params() {
	...
	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
		return -EBUSY;

	if (init) {
		__add_rq_bw(new_bw, &rq->dl);
		__dl_add(dl_b, new_bw, cpus);
		dl_se->dl_bw_attached =3D 1;
	} else if (dl_se->dl_bw_attached) {
		__dl_sub(dl_b, dl_se->dl_bw, cpus);
		__dl_add(dl_b, new_bw, cpus);
	...
}

Wouldn't lowering the bandwidth (new_bw < old_bw) underflow the unsigned
calculation dl_b->total_bw - old_bw + new_bw in __dl_overflow() and fail
with -EBUSY, while raising the bandwidth (new_bw >=3D old_bw) underflows
def_root_domain.dl_bw.total_bw in __dl_sub() and bypasses the active root
domain's admission control before dl_rebuild_rd_accounting()
unconditionally adds new_bw into the active root domain?

Similarly, during sched_cpu_deactivate(), set_cpu_active(cpu, false) runs
without holding rq->__lock, so can sched_server_write_common() pass the
!cpu_active(cpu_of(rq)) check just before set_cpu_active(cpu, false)
clears the CPU from cpu_active_mask?

[1] https://lore.kernel.org/r/sashiko-outbox-198153@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D4
