Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097309;
	b=dJmEJnrtkswQp2LEaSHB1nI6qZHEL2dON2AcBV36rS/81gRahL0IyxXZNYlk8Pt4aj9f
	 dVHz2KncE5q+ZaF9UpupsPM5qCRBCo2P/p/jLV0i7bONqng2e4cDdubpQF4hYn8dXXbyL
	 9byieqR82+BqWLaeZ8feTlaAZvE9ax8tGkMVKgSS6n8CN9ZLFCLk+fQcqz3/vm7TMcQk6
	 jmIqyr7Foa2ccxKw1T3bhe5J8AXFtn8IPvcY0zK+9w9yo2MiUMcNblGdZS96+MCBAsZz2
	 locfEa1iKf2on8BBx+M0BY8lQP/LTje0SvwmtJivwcDfePX/PvnoQ8rp1M4ODZUX+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oFRX7EDGxYruA4E85/FB1tAaAr136V//m9qXpueS7Bw=;
	b=W9+zOpkWuo8atzBc2/Srl5h2Pw9enL0hLnHs0oZrozXVS5d540qLrJG16SLxIr7tZiPx
	 TvDeXzCLtWCFN+lNHuQjbf0Vu+3oLGD/aZ0kvcqBFzyaKvskvXoATW84R9OL+hnRqPj+r
	 rcilxKnkEQClZLmO9e5lINP/W2gi7yAbnkkNPvnAaDvslvwgERAuAtBnNB7HYD1rBOl21
	 NGzD+ys9uPjVJvfGSRWyq8OmoYSI6YZTEgPx0vr9tLupsH830mZd/PdFpkAeeHbGvuolG
	 7nQUrhi03I2ZnOcuFR4Upaa4vn3fgMH6o3JFNjSRH9rBWE+lXMFOLa7jUveKiNNzTrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mi86u+NN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE56606A320;
	Thu, 19 Nov 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mi86u+NN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC01F000C5;
	Thu, 19 Nov 2026 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097309;
	bh=oFRX7EDGxYruA4E85/FB1tAaAr136V//m9qXpueS7Bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mi86u+NN/2lwlh8J8btAk72iAUEWZsxrLD1SQUAFmkoOnMviNclaIe+n25Qdf8wT+
	 tdpZL1zVjRwENHtoH94TaDN6FAFUSHjWhwyECvUw0KoU8xCETIkjKygqJmbqBBoFxv
	 DEJY+fGYfqYHz+TxzKkdvKjQ/NSo9JPZrHLMRAXFXVsWBUPHngR6X7BALeawyhxnG7
	 sj7p6NRKaRi3q2ir2DSFPWqHRju7FuBOw2bQMT60oniOutDkrqfM6DBxBgIms7a6zN
	 AvxnFAvxWxqhuspqaodEDWeKTPA31TqlK3vPF+VIK2E9YZQ95lA+Prh8dUo69hx98o
	 a6Oxa5eqcszsw==
Message-ID: <sashiko-outbox-223252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/17] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795092090.git.mathieu.desnoyers@efficios.com>
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795092090.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:08:28 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/deadline: dl_b->total_bw underflow in __dl_sub() on
  inactive CPUs
--

commit 020d8b15e9dbdf61a1582bcfb9d8b730079aa6d8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not divide by zero active CPUs of a root domain

This commit guards the __dl_update() calls in __dl_sub() and __dl_add()
against dividing by zero when a root domain has no active CPUs during CPU
hotplug.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index dfae08625342e..b614d5fc1a1ac 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -189,18 +189,25 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
>  	}
>  }
> =20
> +/*
> + * Spread a change of total_bw over the extra_bw of the active CPUs of t=
he
> + * root domain. @cpus is their number. With no active CPU, as can happen
> + * during CPU hotplug, change total_bw alone.
> + */
>  static inline
>  void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw -=3D tsk_bw;
> -	__dl_update(dl_b, (s32)tsk_bw / cpus);
> +	if (cpus)
> +		__dl_update(dl_b, (s32)tsk_bw / cpus);
>  }

[Severity: Medium]
Can updating dl_b->total_bw when the CPU is inactive underflow
def_root_domain.dl_bw.total_bw?

When a CPU is deactivated during hotplug, detach_destroy_domains() attaches
it to def_root_domain and dl_clear_root_domain() resets
def_root_domain.dl_bw.total_bw to 0, repopulating it only from active CPUs.
A SCHED_DEADLINE task on that CPU that exited or switched classes before
its 0-lag time is not accounted in def_root_domain, so when
inactive_task_timer() fires while task_cpu(p) is offline, __dl_sub()
subtracts p->dl.dl_bw from 0, wrapping the u64 total_bw counter and causing
__dl_overflow() and sched_dl_global_validate() on def_root_domain to reject
admissions with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795092090.gi=
t.mathieu.desnoyers@efficios.com?part=3D4
