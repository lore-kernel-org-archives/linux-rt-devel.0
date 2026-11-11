Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399482;
	b=OpvudmOeo3vhZBR2HOVSNEDPazN6Ct1b0iNWAwJ7Pbu7rkE3yQCbTRNHVFW8Dy5KzXrb
	 MmhezlR1ApgWgiZItwaAHPkePGq7ICQbxebdnfl9BzJhreJibjh2kwqeZcz1Kr2aw3hQ/
	 TZegSy6XJ2hA0E51fTNL0WsGFdSmHByIirmMOCHr7A1zMpA4gR7LuAggjIG4cr286Et/b
	 CSN+GyDNDfpZW8E47A8Eu0KqDgBoDX1iGZ9pZnevma8VVKodF1+UifR48Zj8W/4xMiVa1
	 RPc+7YV0o0Wm/tN7Dqo+E5gc934aSU00wbiRkidEnPiQOhPfAxihgSjGMFA9AIwueyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399482;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=twxWWdz/L84GLIkfOlZIXyjFtna9wieu1jiumFBv8x8=;
	b=N9Juh/HoI+zvIkLCYGVZVHdvnDR9HY2hkrIyTImtk+i/x/8HUQIDH6rGSFoFS1EKR/mV
	 WTw1SL41SVJ2pid0nstDPd5C12Fi29MTZLyaeUSDEl7PARplcKhHlRQsuIiJq8LR7MS42
	 xrYGNOKpM5ZLnkMH5VNyW2Jl29/0QG9IcUDOoE3JcDkWWc35H4a/KgcILd7cPGsj3eacR
	 jy4rr4xu7Gv+JmkJBzNRq4XmHk9A09XrFFkXJLPRbGcynorl+a0k9gsaa7PuHDeXUdyN6
	 0PSfLJM4D7M1uomZxcq5WrkQebkLRdq1J0dONCfDwo4etr1YOIuJjd/XAQEKk2Bx5RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OX+h45CA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UuhFVMyk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00E606A327
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 12:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B00E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OX+h45CA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UuhFVMyk
Date: Wed, 11 Nov 2026 13:17:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794399479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twxWWdz/L84GLIkfOlZIXyjFtna9wieu1jiumFBv8x8=;
	b=OX+h45CAhtBxpWJ6Dl1w/YTYPEN9A+IwrPeF2gJvtq7MOKI5YTLz1dZBRJs3dVqhtE5Btk
	dIHSmpFfKqBbz2vQy+ecDGYz9RQ6GHQoFdHQuMgkVRPrdBB2tsebGhY/k/vk01r6tp9CSv
	dFn2cTtQRwKyY1y15IFxUUAyvT13INgbH331fKDsP3qy+92NmzJmLsVtcW2SgTeYbcCRqt
	wPlLk3q5TD80e/EM1oyQ6rryNANlOed8W15i3iwIR6x4XMTotH/98CALd+mFTKksaWYLMy
	6n6qR+HiRSLo9EXkfk4YV5ycZs04a1nwtjN5PfMsYgaJziQY5oV3uKCm+QarwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794399479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twxWWdz/L84GLIkfOlZIXyjFtna9wieu1jiumFBv8x8=;
	b=UuhFVMyklXOaR+noxK6+6dtCrUiKb/OOI0hlJFUZjGXC9FndfepSHpZwT1/7VlLsL+VW6H
	z77A7WlPt90FdiDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v4] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Message-ID: <20261111121757.021rVvhs@linutronix.de>
References: <179241614797.5916.13928836073297916808@whr>
 <CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
 <20261109180748.33682-1-haoranwangsec@gmail.com>
 <20261109200332.52e2fc0e@pumpkin>
 <20261110165742.1204-1-haoranwangsec@gmail.com>
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
In-Reply-To: <20261110165742.1204-1-haoranwangsec@gmail.com>

On 2026-11-10 16:57:51 [+0800], Haoran Wang wrote:
> ppm_get_cpu_entries() must not acquire a sleeping lock while preemption
> is disabled: get_cpu() raises preempt_count and spin_lock_bh() may sleep

I would say "disables preemption" rather than "raises preempt_count".

> on PREEMPT_RT kernels.  Read the current CPU with raw_cpu_ptr() instead,
> which keeps the per-CPU accessor stable without disabling preemption.

That is not what is happening. raw_cpu_ptr() obtains the per-CPU
pointer of ppm->pool of the current CPU. I don't know what means
"accessor stable" and the following. Without disabled preemption the
scheduler can migrate the task to a different CPU. The access is still
stable but if the "locking" of the data structure is based on "the
data structure can only be accessed from the local CPU" then it is no
longer valid.

> Using the pool of a CPU the thread has since migrated away from is
> harmless: the per-CPU pools are shards of the global ppod index space,

ppod?

> and the free path ppm_unmark_entries() derives the owning pool from the
> index instead of from the running CPU, so any thread can service any
> shard.  Derive the global index base from pool->base so it always
> matches the pool that was locked.

The important part is that ppm_find_unused_entries() acquires slots
(read-modify-write operation on the structure) and it happens under the
lock therefore cross-CPU access does not matter. Does it always happen
under the lock? Then it is safe - otherwise it is not.

> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
> 
> 
> thanks for the comments.  v4 below:
> 
> - pr_debug() now labels the pool's owner as "pool cpu" and also prints
>   the running CPU, so a thread servicing a foreign shard is visible in
>   the log.

Was this asked for? The pool CPU might be interesting to know so you
have which CPU's pool is serving the request. But the current CPU is
probably less useful.

The changes below look reasonable and I *think* it is unchanged from the
last time I looked at them

Please look at Documentation/process/maintainer-netdev.rst for the
subject prefix, fixes tag and "Resending after review".

Sebastian
