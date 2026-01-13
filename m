Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE52321456
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327240; cv=none; b=DXfqVsBWeq7YWI8zimqAKmvhge3nriiD/65DIQE5SSQktpzD2VyqXQVfKn96jEPQt4IPRQb6cSVJJOKRdpeCOLB+NJv8MuVfDRYFe4Vw5BEsFkJa3sHwzv2+O++0C6NCravjjh0gG0lIImGQW2SA5y5cpxIZEcQYe5rNwffdPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327240; c=relaxed/simple;
	bh=vL+E19F0BroVZmBASmL+JhDdiCQ2vBwOBM03J4qXoY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGI5PCKbCLBz82c7WKD8ZagQtmrLifHxXs6J26S8Dehu4yDaKOny9hml7foYA3fR6qilbLizl1FN+6wkbk5KyPN28j0JfGbLoP9qipTMuSun7ouBJKp4PophWgiw9cDcu/o0JjTdYK53NKepXIzlqAZ5QJCr+EZqfW0u161sJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pI3ZQqtN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDnO6eOL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pI3ZQqtN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDnO6eOL"
Date: Tue, 13 Jan 2026 19:00:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768327238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFoJkjOAyFFmecghCApByGzs6pGushJZ1nfzPMOzgE=;
	b=pI3ZQqtNwhGVlf484c5AkD7qTRkHi/TUYAHB8Vh4Qt151WknNm4aoW36v9i4Mr30+TH8Ts
	v0EBmEP6gTwmVotqcEhNDBUAgK+8Lsj1JdlQnD+ndX9awpvu7sm4ljtKJJqHf7JgmD9zeF
	TdrKlt6OmpNCDI4nUrzVdvWEFn04Z9Dn6VH3O5SKgVDFbuiS8C9NVnEj5ACuxcjbGfUKXK
	yYjIQxUOPycO4s2pLf++uFohdMfyZgYx9EqtGi+c4h2Gcr17cwv3kRrRe6POVsXXCfujPK
	KUHtnB4iYRkcKEyxeJ0BEehxEY07pY/uHMxrQsKno10A8BIHAQ1tTmORywv6zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768327238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFFoJkjOAyFFmecghCApByGzs6pGushJZ1nfzPMOzgE=;
	b=dDnO6eOLuM0mK7DEU/yMAO+gD3P7qBwfrsWnBTOjaeSTV4mK8Ud5llvfE2uSaKoTAycLpf
	LmU3sS8Q2aF2rfCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] slab: fix kmalloc_nolock() context check for
 PREEMPT_RT
Message-ID: <20260113180036.Zl8j3vIY@linutronix.de>
References: <20260113150639.48407-1-swarajgaikwad1925@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113150639.48407-1-swarajgaikwad1925@gmail.com>

On 2026-01-13 20:36:39 [+0530], Swaraj Gaikwad wrote:
> On PREEMPT_RT kernels, local_lock becomes a sleeping lock. The current
> check in kmalloc_nolock() only verifies we're not in NMI or hard IRQ
> context, but misses the case where preemption is disabled.

The reasoning was different back then.

> When a BPF program runs from a tracepoint with preemption disabled
> (preempt_count > 0), kmalloc_nolock() proceeds to call
> local_lock_irqsave() which attempts to acquire a sleeping lock,
> triggering:
> 
>   BUG: sleeping function called from invalid context
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128
>   preempt_count: 2, expected: 0
> 
> Fix this by checking !preemptible() on PREEMPT_RT, which directly
> expresses the constraint that we cannot take a sleeping lock when
> preemption is disabled. This encompasses the previous checks for NMI
> and hard IRQ contexts while also catching cases where preemption is
> disabled.
> 
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> ---

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

for now.

> Changes in v2:
> - Simplified condition from (in_nmi() || in_hardirq() || preempt_count())
>   to !preemptible() as suggested by Luis Claudio R. Goncalves and agreed
>   by Vlastimil Babka
> - Updated comment to reflect the more descriptive check
> 
> Tested by building with syz config and running the syzbot
> reproducer - kernel no longer crashes.
> 
>  mm/slub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2acce22590f8..642f4744d5c6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5689,8 +5689,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  	if (unlikely(!size))
>  		return ZERO_SIZE_PTR;
> 
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> -		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> +		/*
> +		 * kmalloc_nolock() in PREEMPT_RT is not supported from
> +		 * non-preemptible context because local_lock becomes a
> +		 * sleeping lock on RT.

I would say that despite the _nolock() suffix a local_lock() is still
acquired. The !PREEMPT_RT does a trylock.

As I noticed this myself today while looking at other patches, was the
trylock removed on RT by accident, was it there only in an earlier
version which was never merged and will it ever come back so we can go
back to !nmi || !hardirq?

> +		 */
>  		return NULL;
>  retry:
>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> 

Sebastian
