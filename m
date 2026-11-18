Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986000;
	b=rVEX19d0aXYC6TKN+BN7soN7ZQWgMqlhrz2wh2vBOg5sYYUZ2IR+Jn0qsx+zDG3qYfOX
	 OIXhv0jTXW0cWG+JdrRhrnC4ductvEWZVHjXs+mrFQhrzhaOZ2CRGHUKIXhVLJu0oiw3m
	 /g85qIWKTfQYUwZL/fvklGVH0VoxOiysKcb58MS7hdS9OVW4XlAiI7+fFsjm+D6pQ6oio
	 flsaVWEZvWbKrjQT5G5jbOEGHjh9vhAjVdzVG4oRJXtQ/vnjPLFSfYRihAMExgD+4KTou
	 IVa0RGXfm3kUpTd3glNADN3Aw5KWoL+M2a895f/aZz+ZrRT6IflzyYzL9it9j1esDfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986000;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8pB+MXPNtH9n1jK/JmpiYpmW0motvJ1fOUd08yC+k48=;
	b=Ua30aKrS2w5Zuq+8YQPhsU7uGTWhi2cUr0w4LGM95kJeqStLdxGuFkzW5x6gL9m6CR5y
	 15ZzNjaDM+Q5Dfm5ZfU6K0bqgjlJAHv+AQ0prCe1ZfEueZkEIkzndVCy438fFUtTtc2zk
	 XbPBrrwHHx3/an+i8pCmTmoZtynuh1O13+/BxAcL9vX4Mwe5tTPYkZCgoe6fjQDFu5ycA
	 Z2PszdvzxiKnVYhP659UU0kHw6vAxeUdDgdRM0BktPrqezDXXKzG2We9TilYRMm6t5HtU
	 SrIPT+kHa6HoGMxtzqlOe2/4fiHarI+d5BcMdx4T3RCCR9nGJIMZnB+fx6n5yMOUXug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLzpbgMd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=i7OvvaGZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3B606A325
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 07:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE3B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLzpbgMd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=i7OvvaGZ
Date: Wed, 18 Nov 2026 08:13:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794985997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8pB+MXPNtH9n1jK/JmpiYpmW0motvJ1fOUd08yC+k48=;
	b=wLzpbgMdmN1snhABK51fJE0hhG87MbcpKkOXh8RBHFftRMW2bTofPHTFD4FNmaEpkOG84N
	tOyICaCBvc+wl88K1KiwhCyg9W4NOpxL81mmWTnYhJOExB8rWr7Dvv4nOTpLc5JspN9xaq
	0UTXkvQ+VT3PgET8DALpawp+ef/JQ4YuJZQK8sNXJAd+Z+qjL4B2Um6pWU3gg7q6CAFOOw
	A6eo+E4PXAjgTbmsh5Hr1EitsrL13B1q6aSfTQ5pINc36L8qfSGIOCUj31MbKrh271VGdn
	bgRi2Cu907bpMvs6yZt+7Om5P/Dytc/UCbmsWFLsllwI2TsN+rmxa7cBq7xZhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794985997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8pB+MXPNtH9n1jK/JmpiYpmW0motvJ1fOUd08yC+k48=;
	b=i7OvvaGZhMMfJFYOaboeajhrsvueAErjBNBKv+3b9msb0fwcQnWLXZ2yUaOa1lHyP9M3/I
	8Jr+H67IMA0LulAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Koichiro Den <den@valinux.co.jp>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] RISC-V: KVM: Run vCPU timer callbacks in hardirq context
 on RT
Message-ID: <20261118071314.NJWhnli-@linutronix.de>
References: <20261118062104.2912910-1-den@valinux.co.jp>
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
In-Reply-To: <20261118062104.2912910-1-den@valinux.co.jp>

On 2026-11-18 15:21:04 [+0900], Koichiro Den wrote:
> On hosts with Sstc, kvm_arch_vcpu_load() cancels the vCPU wakeup hrtimer
> with preemption disabled, including when called from sched-in preemption
> notifier. The vCPU reset path also cancels the timer under get_cpu(),
> with or without Sstc.
> 
> On PREEMPT_RT, these callbacks run in softirq thread context, so
> hrtimer_cancel() may sleep waiting for a running callback, which is
> invalid with preemption disabled.
> 
> Let the callbacks run in hardirq context on -RT. They only rearm the
> timer, update interrupt state under a raw spinlock, and kick the vCPU.
> Similar to commit 9090825fa997 ("KVM: arm/arm64: Let the timer expire in
> hardirq context on RT").
> 
> Cc: stable@vger.kernel.org
> Fixes: 3e1d86569c21 ("RISC-V: KVM: Add SBI HSM extension in KVM")
> Fixes: 8f5cb44b1bae ("RISC-V: KVM: Support sstc extension")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
