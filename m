Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693515;
	b=nR3RmqOrK4aUkCivlStmr++at4aEQv0YQoOT3fiJ57LrNRZKVVZDfByJ83mwzDSJ4I28
	 7Tkj3Cn38SPl8uLobqlwHz98IVlazK8AYUnbTDTQDQ8SfE4opWPw7cl7CH/+pGRz+TlWF
	 jp9LFpj8+ILufIQIV8fJT+aZZnESvJgWnVmbU6Ia2pv18wQe3wZX6PBLJd0rbDh0dQtwO
	 S+o7jiHRzZ3+ooSTT70LXIHwkvBRYbANLTry7BVD1z7pr9jDBcHC7FyEisheNNimLMNqz
	 pP32YmMKHzzWLSH1Zx0KYpKkTE1GsyqN6jgPp5C5KNIAMVN6hVwq/qHEWAB796aj0Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693515;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HWHjCDaJOo5JyfbAzChFMw0H7Jj/ipterv1TFKU6BAI=;
	b=v5puMs/9bSfnKZ4cHnWkxHWRrXYKmL6IwwQi4x/jGjke+dqfMKqeKGNEn8OVB6iikJeq
	 GPIAIAlP6n4n1d/Sufrmbj0tQTsC1LaXQuVbv15VumgMQniyiI7XObzRDb1N26xQNrjU5
	 2ERGuI2qlgI5Itp7IWXsPbTZ7JEoI2iX9Tj7lXpXRdr23Ypar3SzXlmUfO5IHMpoNLfdK
	 sb2mwgjnWpVTtDMn2Dr2lKkrFxYjDR8MhJJa36ePkV2VndShD9lvyGdF/+5Jv5KmdaDun
	 zjxwTCk0jzHDfyEhV10biBI2S4DG43FpkLYJQjsJX82bJ+sCFxAzb2g51dn8RoR5iEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Se4uKvp5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z93SV010;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E1606A32D
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 08:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 536E1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Se4uKvp5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z93SV010
Date: Tue, 3 Nov 2026 09:11:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793693511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWHjCDaJOo5JyfbAzChFMw0H7Jj/ipterv1TFKU6BAI=;
	b=Se4uKvp5dOU5iN/zYf/bE4zWagFx8rgG4Qg6eWdYLqE5NrMjD0xZpWFCbM+9dGivi2Z+t0
	zsZzXIST9Ws+gdaQ/SIFPmSFcWYjkhBZgAhgpKEm5XA+WaSkqaqgH2CBHmq10s0oXtzD6a
	o7d5RGOApsp/zUz6rvzO4hds8gAOasac2UIGUDy9Z8Hvbe6Q8niwRsW9mMMLE2Kc/YBMLL
	mtqai9frPwai282tSm3wMJ66OaUxrVKF+8bxlKDXtshx67U02KTSi1l/Gi8dfK8L/+Iyns
	rnOQXkW8LnZ/Er2sZkUqmYddns0U/YYo4ePS4+SDxaOWUmx3fL1EqqT4dLeQIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793693511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWHjCDaJOo5JyfbAzChFMw0H7Jj/ipterv1TFKU6BAI=;
	b=z93SV010ZECHpJWbxZsrQ1aF2AVMp318MTR7S8Ueyme1UCECjKOZEZiKUZMULMSJTm9Xzj
	ef7cz/bQUY87aKBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix spurious -EPERM for
 migration-disabled tasks
Message-ID: <20261103081149.DuyWNhVe@linutronix.de>
References: <20261102135420.244745-1-parri.andrea@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261102135420.244745-1-parri.andrea@gmail.com>

On 2026-11-02 14:54:19 [+0100], Andrea Parri wrote:
> sched_setattr() can refuse to make a task SCHED_DEADLINE with -EPERM,
> even though the task's affinity covers the whole root domain. A retry
> can succeed, but the error blames an affinity the task does not have.

=E2=80=A6

> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -628,7 +628,7 @@ int __sched_setscheduler(struct task_struct *p,
>  			 * the entire root_domain to become SCHED_DEADLINE. We
>  			 * will also fail if there's no bandwidth available.
>  			 */
> -			if (!cpumask_subset(span, p->cpus_ptr) ||
> +			if (!cpumask_subset(span, &p->cpus_mask) ||

The task's cpus_ptr must share at least one CPU of cpus_mask. But it is
not a subset if more than one CPU is involved. So the problem is that
while it is in a migrate_disable() section after it has been scheduled
out, it will see only one CPU via ->cpus_ptr while span may have two.
That makes sense.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Looking at sched_setaffinity(), there is dl_task_check_affinity() which
makes the same check. It is skipped for !task_has_dl_policy(). This
looks time like there is a small window in sched_setscheduler() where
the affinity check passes, the task is not yet DL, and then
sched_setaffinity() makes the affinity smaller.

>  			    rq->rd->dl_bw.bw =3D=3D 0) {
>  				retval =3D -EPERM;
>  				goto unlock;

Sebastian
