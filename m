Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814216;
	b=L94JWXCQNjfgLXc1tDjnaLWOTHprN623zEBr4MBet/xofd/vhwWASI/ZySCXuclUkT43
	 DUfC9CqDRZwWbmTSAJ9BvUQ8l+4dhGOAoa9L4eBdgajKpLYkxoY696W5atYFn793Hf0b7
	 KDo/ginuYVJjUDy+ZH+deXGPqE1sbz3D+VLpoy0OD36rknLatfXlz5Ef4PeO+WXTlWD6G
	 yHz4/2/LV4Sd2/J/hnu28jir6MO/B6xmROQO26ZMpL/4YlLQ084U+rovtJw54wPpahb2/
	 flvuxO0Hcr4HsvSg53p9K5QGZ6TF4StRqARsJUpWKVR/OwQFiLCypxuEHzPH3Awg3DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814216;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nk2Mh+zI/TT/jjegJO9qYSlN1QKbBbjeWZjZ6ygv24I=;
	b=kx00L0cQZUiydWd91coCKxB/rJC7ZgJjLI6YnncDwPYDpxgQPDzDFp2U3Nc27nRqayDz
	 TjaBSmv99ErFE06G2pkkITMvm98W5Kr8hqvGZDB00+ZD5KB73Juy8dwIGsXQi3DbTw0o7
	 o3ER+3TjqKMRiE6XbPhM5UB16tBBvT8voylAC008D7/ojfe5oDFNTDroo5MpfuOi0fO7U
	 wvyxMz0M6Vc+LDchssCHJ7Czw+Px2nNDIsUtJCH+yUgNwb3nFox0bMezq2ziQZmKaBKvb
	 FbQZfn6Dy87gQenXg3Hd2RJJGKxgRQA4q/QW1pCprfCRIz9q+nvlxVrE50XYjURfgaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JkCiI8ip;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lTj5aVeu;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3815606A32F
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 07:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3815606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JkCiI8ip;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lTj5aVeu
Date: Mon, 16 Nov 2026 08:30:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794814210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nk2Mh+zI/TT/jjegJO9qYSlN1QKbBbjeWZjZ6ygv24I=;
	b=JkCiI8ipGs6D6X54MmmtBVhszwJGHWiTFC84HeS/VV8C/PgiPBHK5t7BPpaxFTeg3R1x0n
	9yn9xn8UMkVMDUfuAJJG8OGdcLkN/uYDRZFKLu16Z9GNr4a6/yFZrkl0tYc4K9rYgle2ex
	vsp+Gt3SARQ0UmE8nGemRa8ZQclcIHvSEbw1aQ+uqKOCP5ifFNuA3EXpW0HekIXkHQIG6H
	2YkNalcDW36KJFi54qN6UyLhXQF2tRjCw3AAqH7Ku9tc+w7U1OdXnF12LxsPKw6UEO9RHj
	g79eof3+Ej81SkfwshOZgZTVrV3aIvfehIJC41965sbXn0mP2uPi+LJ8auIaKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794814210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nk2Mh+zI/TT/jjegJO9qYSlN1QKbBbjeWZjZ6ygv24I=;
	b=lTj5aVeuk5Ex7GPn7C4kR6cw3R3/I5G9oHbZoa/gyGd9on3kFZgrEiNwkyco9iphji7HM0
	HxmJV3H6q6qQPYDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
	cl@gentwo.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, tim.c.chen@linux.intel.com,
	tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH] lib/percpu_counter: allow concurrent sums with an rwlock
Message-ID: <20261116073008.PvlRj7Tl@linutronix.de>
References: <20261116015655.2744577-1-jiebin.sun@intel.com>
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
In-Reply-To: <20261116015655.2744577-1-jiebin.sun@intel.com>

On 2026-11-16 09:56:55 [+0800], Jiebin Sun wrote:
> __percpu_counter_sum() holds a raw spinlock while reading the global
> count and per-CPU deltas, serializing concurrent sums of the same
> counter. Since a sum changes neither the global count nor the per-CPU
> deltas, use rwlock_t on !PREEMPT_RT to allow concurrent sums with a
> read lock. Global updates take the write lock. The per-CPU fast path
> remains lockless, so sums keep their existing snapshot semantics.
> 
> stress-ng dentry reaches this path through ext4_statfs():
> 
>   statfs -> ext4_statfs -> __percpu_counter_sum
>          -> native_queued_spin_lock_slowpath
> 
> Keep the raw spinlock on PREEMPT_RT, where rwlock_t can sleep.
> Global counter updates can run in atomic context and must not sleep.
> 
> stress-ng dentry test average throughput change:
> 
>   +------------------------+------------+--------------------+
>   | Case                   | Unit       | Average change (%) |
>   +------------------------+------------+--------------------+
>   | Dentry, 64 workers     | bogo ops/s |             +47.34 |
>   +------------------------+------------+--------------------+
> 
> Dentry ran on ext4 with 64 workers pinned to physical CPUs:
> 
>   stress-ng --dentry 64 --dentries 4096 --timeout 20s
> 
> Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

It looks okay from RT point of view. Is this limited to this benchmark
or is there a real workload behind this?

Sebastian
