Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C238B7DE;
	Thu, 22 Jan 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102241; cv=none; b=iZWawFzGFW9F/eDUH4cHvPbvk8l2Xubu3JsbJC0tPB+lJ+n2Y8BXW6soG2RP7WuY5VlV75UF+Igeh/7zDBLO3iVxjhAU258AUBesFk2pnWoP+cCcp9y7Yj9DGKZJA/iYe3g76LE/PhUAz99Z/jAULXmwiRarK2qROVw/vUL2kwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102241; c=relaxed/simple;
	bh=A9cQRSLz8v2njv45CmUGC/ju5GGeQ9vPP+m1Rqf8v0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIS5crlrikx1LUL56AZyYk/jq6Ki24GBcdkghZvtO2H4W2YlK3GZgz6lEhhUnOtdDJ1QntOJUUro5x+HHuR/L36mHJ31WkvnuCQgUaWk9FBGqyPk03bm5HajMy96i6BQ4OG3Bn+PzNURa5d8L/KpteH8L8vjhHr6qEpv6+zAhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwNktGx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwNktGx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE757C116D0;
	Thu, 22 Jan 2026 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102240;
	bh=A9cQRSLz8v2njv45CmUGC/ju5GGeQ9vPP+m1Rqf8v0g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HwNktGx2wc5ES0Aj7U0G4a5y9BLRgWYSHcsQT3m8DkCleGR39McCiFdLfNYZjv/Ho
	 KgrESmjedNz6CmlHIOzobCAOzrF24N623Wr2m2LwzKmtKpGcu7y75F6owqVqzrvEfT
	 XditdUDtZqWsd/sp6D7kbGk1ncXUp80NG9cuyxjnsC3LkBGshvSjij/Ys8ebX+u4jc
	 0tDnKoCZyHNK68DN/QadDj9aodF5MoPaDIeNEbOFybaECD3TIP00QSpzkzOx6nrzv5
	 lsVkEkONqhS2sTWozRh01IvQ0h/KF1uRAOuhn8dV8kKMhqkuI8w2SW9ErsZfHFrZLy
	 1+AhAnvEkC39g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63F9BCE0B6E; Thu, 22 Jan 2026 09:17:20 -0800 (PST)
Date: Thu, 22 Jan 2026 09:17:20 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] mm/mm_init: Don't call cond_resched() in
 deferred_init_memmap_chunk() if rcu_preempt_depth() set
Message-ID: <61690638-e72d-4d8e-9687-9f4da3ede970@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> > > > > --- a/mm/mm_init.c
> > > > > +++ b/mm/mm_init.c
> > > > > @@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> > > > >   			spfn = chunk_end;
> > > > > -			if (irqs_disabled())
> > > > > +			/*
> > > > > +			 * pgdat_resize_lock() only disables irqs in non-RT
> > > > > +			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
> > > > > +			 * kernel.
> > > > > +			 */
> > > > > +			if (irqs_disabled() || rcu_preempt_depth())
> > > > >   				touch_nmi_watchdog();
> > > > rcu_preempt_depth() seems a fairly internal low-level thing - it's
> > > > rarely used.
> If you acquire a lock from time to time and you pass a bool the let the
> function below know whether scheduling is fine or not then it is
> obvious. If you choose to check for symptoms of an acquired lock then
> you have to use also the rarely used functions ;)

Agreed.

> > > That is true. Beside the scheduler, workqueue also use rcu_preempt_depth().
> > > This API is included in "include/linux/rcupdate.h" which is included
> > > directly or indirectly by many kernel files. So even though it is rarely
> > > used, but it is still a public API.
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

If touch_nmi_watchdog() is fast enough that calling it in a potentially
tight loop is OK, then agreed, this is not required.

But maybe I should redefine !PREEMPT rcu_preempt_depth() in terms of
preemptible() or some such.  Thoughts?

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

I will defer to the mm guys on this question.

							Thanx, Paul
