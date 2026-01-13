Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA735B12B
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305321; cv=none; b=CMPAtuFIIsprxUh4VNAdzIXg9hwzvyEbnwqVJvmwQDiQPNHrV6d1m2GaQFHzu0d85sbv/r7BHDPXtoVy/HPMr+Qm7+KHqi7ye8nupqJn6n+X1YZliOeZhEneLuSqA/O+mV15IqKRRWP+Qvz95i2yYf+/iBWmqMX7XfzrwqASFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305321; c=relaxed/simple;
	bh=cutP4QSbJkKtU/3jRNqDgWpdh8LIDRO43lYA8yyVYZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLwYOwadgbojGyFDiy/B7pzTQVmZxyaP1ey2oPAhvgi5ITVQZwWKMHvX2I3NkK8+hsa9X/e2G+NKYCEMC2+gbcdsUPKVtlEpmT7/fR2PtElHmiew9Z+diWvJBuQkYFdpKnZdaj5fDqTH1kl0eTIGxVOCFYg+WJTRXzfu7fkp5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNUIsG7O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IR1pUfTN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNUIsG7O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IR1pUfTN"
Date: Tue, 13 Jan 2026 12:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768305316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t1TqJ/QytQ4pwnW0ti9Z6aH6KsPUuA9eSuB4Dv3RC0=;
	b=aNUIsG7ODXHBXQCF7fvbI53vWnCXJ7BjljV3qdn53vS+0hFdDKZCyxHxZId/nq+kwqrKGp
	mU8TRE2qBujeQzZswDXy1EFSLk0QKxnBbx+pwdp6D9+GIHN3o5G383gvOiQmcb1Lc+R+0a
	3DmkFkFThf7xlcTikmuVeGpGj+m7xb8DN8TbEtNVVPKghgimbwvH9U3tEXz0qC20XUVGpj
	mLC6/p+Y0rhJZUIih0pLIBLiR0ZMzYxdMoCJy4uE8u0xN+RT7cgVelg1IqgyhhW8mcTBdl
	M7MmhjEV4/VCQTTQVF5rnVnd3Ld6yeGUppFZm8xZTrAZyYxP4s8bEQTcvn4clQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768305316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t1TqJ/QytQ4pwnW0ti9Z6aH6KsPUuA9eSuB4Dv3RC0=;
	b=IR1pUfTN8KG8eSEJOvT2Nop/9mwi3jU1rVIWE0jaKQ7DjndFPE6lXIzZHIPqNs/IXVoBHv
	mncQ3oCkNt+WuyDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
Message-ID: <20260113115515.98Mc29Nm@linutronix.de>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org>
 <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org>
 <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com>
 <87cy3eg94y.ffs@tglx>
 <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com>

On 2026-01-12 12:14:30 [-0500], Waiman Long wrote:
> On 1/12/26 10:09 AM, Thomas Gleixner wrote:
> > They might be acquired though. Only alloc_pages_nolock() guarantees that
> > no lock is taken IIRC.
> 
> Thanks for the suggestion. I will look into using that for page allocation.
> I had actually attempt to use kmalloc_nolock() to replace kzalloc()
> initially. Even though it removed the call to rmqueue(), but there were
> other spinlocks in the slub code that were still being acquired like the
> local_lock() or the spinlock in the get_random() code. So I gave up using
> that. Anyway, kmalloc_nolock() doesn't seem to be fully working yet.

with kmalloc_nolock() you have to be able to deal with a NULL pointer.
Looking at kmalloc_nolock(), it has this (in_nmi() || in_hardirq())
check on PREEMPT_RT. The reasoning was unconditional raw_spinlock_t
locking and bad lock-owner recording for hardirq.
There was a trylock path for local_lock to make it work from atomic
context. But from what I can tell this goes
  kmalloc_nolock_noprof() -> __slab_alloc_node() -> __slab_alloc() ->
  ___slab_alloc() -> local_lock_cpu_slab()

The last one does local_lock_irqsave() on PREEMPT_RT which does a
spin_lock(). That means atomic context is not possible. Where did I make
a wrong turn? Or did this change recently? I do remember that Alexei
reworked parts of the allocator to make the local_lock based trylock
allocation work.

> Cheers,
> Longman

Sebastian
