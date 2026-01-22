Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF93803F0;
	Thu, 22 Jan 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075259; cv=none; b=Tfy4Pnrpev0RX+WBXiET10MZ2eqjAuoYLL2XYI66Gckum4+8KsmnDni6q9upv6V/mTD5kSwPxBrdBuuoFS0BFqFcZQYU376O+s6vckgk4nk3HDKuK97hBZJ6zl+dEAXBxmqPs8auVtoCqTZjaWzjp7refuI5hxxS0mqdcvcjohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075259; c=relaxed/simple;
	bh=LrI1u7CBAl4uC3y+gyT24+udVnx13tOxw8kLKpBQ7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGFTwP0QiwGqtsm9hlPQ2dk5OtgzXMhA3STB7O2qg0hLQK2uW6nqrRasO9Yowr9S0yRvBmDM7hyhEr0NRn7bsfnCqsdpxQ53ddpFTySJQmeL9XSmjT7Z17fwLIjuU1MQUSVjWTrd+ScWhSjrJGVQSIJ3hQBzKAZ3yiLpqRngSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpbNi5sR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpbNi5sR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B71BC116C6;
	Thu, 22 Jan 2026 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769075259;
	bh=LrI1u7CBAl4uC3y+gyT24+udVnx13tOxw8kLKpBQ7qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpbNi5sRXEKWS9gQTfzVJ8nPQSDQBsjTw9s+5TrpTIiQf10jjOgW79ftF4I+pXBUq
	 c/eYJbZD/jTXgEanhZSsuenErpzwOnqKWrY1kRo/FT+EgLulk6pR+aTGf+Xmt4r+rJ
	 rjba0YySrfbn1E6vlnHRYh9xxeHpI60CZcNjSd7r3I1BIS2aRdeT3KZDiQk4FnoRHp
	 Oi2GL3TQdHTUxgYnagHd4ietmPWZVoBAwPFCtYwMKwC6cy7opdYNHtWNcCkiFW5oAJ
	 FKex9n193pKNiHwQtqLesOKxVWMfGQ4mAPP3vC7YYGzaKT+rsrTYu/T3OkGdY0a+mf
	 TW1cGoZmfBcbg==
Date: Thu, 22 Jan 2026 11:47:31 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <llong@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] mm/mm_init: Don't call cond_resched() in
 deferred_init_memmap_chunk() if rcu_preempt_depth() set
Message-ID: <aXHyM1R18GI7-gSD@kernel.org>
References: <20260121191036.461389-1-longman@redhat.com>
 <20260121114330.6cd34b4732c7803f1720f0ba@linux-foundation.org>
 <0e385146-67a3-4fdd-b119-059caba8c5f0@redhat.com>
 <13d0b8b5-1ba7-4a3e-a686-13a7b993d471@paulmck-laptop>
 <20260122075747.uSLrSJez@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122075747.uSLrSJez@linutronix.de>

On Thu, Jan 22, 2026 at 08:57:47AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-21 13:27:32 [-0800], Paul E. McKenney wrote:
> > 
> > It is a bit tricky, for example, given a kernel built with both
> > CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_DYNAMIC=y, it will never
> > invoke touch_nmi_watchdog(), even if it really is in an RCU read-side
> > critical section.  This is because it was intended for lockdep-like use,
> > where (for example) you don't want to complain about sleeping in an RCU
> > read-side critical section unless you are 100% sure that you are in fact
> > in an RCU read-side critical section.
> > 
> > Maybe something like this?
> > 
> > 	if (irqs_disabled() || !IS_ENABLED(CONFIG_PREEMPT_RCU) || rcu_preempt_depth())
> > 		touch_nmi_watchdog();
> 
> I don't understand the PREEMPT_NONE+DYNAMIC reasoning. irqs_disabled()
> should not be affected by this and rcu_preempt_depth() will be 0 for
> !CONFIG_PREEMPT_RCU so I don't think this is required. 
> 
> > This would *always* invoke touch_nmi_watchdog() for such kernels, which
> > might or might not be OK.
> > 
> > I freely confesss that I am not sure which of these is appropriate in
> > this setting.
> 
> What about a more straight forward and obvious approach?
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index fc2a6f1e518f1..0b283fd48b282 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2059,7 +2059,7 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
>   */
>  static unsigned long __init
>  deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> -			   struct zone *zone)
> +			   struct zone *zone, bool may_schedule)
>  {
>  	int nid = zone_to_nid(zone);
>  	unsigned long nr_pages = 0;
> @@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  
>  			spfn = chunk_end;
>  
> -			if (irqs_disabled())
> -				touch_nmi_watchdog();
> -			else
> +			if (may_schedule)
>  				cond_resched();
> +			else
> +				touch_nmi_watchdog();
>  		}
>  	}
>  
> @@ -2101,7 +2101,7 @@ deferred_init_memmap_job(unsigned long start_pfn, unsigned long end_pfn,
>  {
>  	struct zone *zone = arg;
>  
> -	deferred_init_memmap_chunk(start_pfn, end_pfn, zone);
> +	deferred_init_memmap_chunk(start_pfn, end_pfn, zone, true);
>  }
>  
>  static unsigned int __init
> @@ -2216,7 +2216,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
>  	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
>  	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
>  	     spfn = epfn, epfn += PAGES_PER_SECTION) {
> -		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
> +		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone, false);
>  	}
>  
>  	/*
> 
> Wouldn't this work?

Yes, it will. And I think this is less fragile and clearer.
 
> Sebastian
> 

-- 
Sincerely yours,
Mike.
