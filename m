Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF20346E58
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068672; cv=none; b=P2SmluocDaAeTyBOgv2y5Wjyfz8pmU+V2h7xcfUrSr6izbZfe6IH6Jyn13jDi/Fb1ZC8VmNE5DS7ECRRhAc1wja0bLI0q0dYL5krvAHrNZVsJ+OC1VI4THZ94+DPHOLGJUwrd3FBI8C8dqmpg+1gFF6w4uHJFgOlXT78kzCeOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068672; c=relaxed/simple;
	bh=zWRysFUTymfAhHZpA/b+xJ6qE34sFtTvwSKI2yanEEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaeeaf4ZxCCx+UQFRdRzSkewTHocjsaUG5Wug+nCby0y7qAXc38C6rL3cVfSGdaYRnDm0JZ+3pTgmJPTaF6R+440GSk+AK9j1Ptn7+PhSW0wsX6Ckv2KJoPHSMgCG9zrtrLq0Y+tgK9F9mofpj0JHWzvaZq9iKqoQFt5626xg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2xoVN3s8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DYaD3ey; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2xoVN3s8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DYaD3ey"
Date: Thu, 22 Jan 2026 08:57:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769068668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MypdZdzoYDN+43tzngLVqabik36CdSqEt94qP7vPfsY=;
	b=2xoVN3s8I1jE/1uegEX6ChsSmnLcKEkxfCRTZD8aDwrSPdkhkVcwVarUTK4LAhsDcmLG4n
	3HVo1yK1PdLXU9Net5S2Z7NLJBJ5n3oW+0QHpV20NwU3L3rcJF9D4cJUhjFKQCuzxAjOcK
	3AL4CGPQuaDH6fqGhOPnAhXrvqknB0u/eUism/E5mX+o1x/Fqm4MsjrAfVhfM6aPKVD5bx
	yUj21iib96XbJSYJonKPC8iGCAvxd5/k6oZR0rCZ8h5KLlj6rincrCBuJITE59/huFIfqH
	s2AZVnLWumQ8luJWgbfJXhYeoNz2Z2gfOYWAk7X70ZvbvBhE6+oC08FM7FQpDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769068668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MypdZdzoYDN+43tzngLVqabik36CdSqEt94qP7vPfsY=;
	b=3DYaD3ey9CwD8bGmkZZKuggP2Wasq5Y/BI39C/lfTzka24QgGR84pXqcyxLlAK6vg43rim
	hzgrKCVob0W47wDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20260122075747.uSLrSJez@linutronix.de>
References: <20260121191036.461389-1-longman@redhat.com>
 <20260121114330.6cd34b4732c7803f1720f0ba@linux-foundation.org>
 <0e385146-67a3-4fdd-b119-059caba8c5f0@redhat.com>
 <13d0b8b5-1ba7-4a3e-a686-13a7b993d471@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13d0b8b5-1ba7-4a3e-a686-13a7b993d471@paulmck-laptop>

On 2026-01-21 13:27:32 [-0800], Paul E. McKenney wrote:
> > > > --- a/mm/mm_init.c
> > > > +++ b/mm/mm_init.c
> > > > @@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> > > >   			spfn = chunk_end;
> > > > -			if (irqs_disabled())
> > > > +			/*
> > > > +			 * pgdat_resize_lock() only disables irqs in non-RT
> > > > +			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
> > > > +			 * kernel.
> > > > +			 */
> > > > +			if (irqs_disabled() || rcu_preempt_depth())
> > > >   				touch_nmi_watchdog();
> > > rcu_preempt_depth() seems a fairly internal low-level thing - it's
> > > rarely used.
If you acquire a lock from time to time and you pass a bool the let the
function below know whether scheduling is fine or not then it is
obvious. If you choose to check for symptoms of an acquired lock then
you have to use also the rarely used functions ;)

> > That is true. Beside the scheduler, workqueue also use rcu_preempt_depth().
> > This API is included in "include/linux/rcupdate.h" which is included
> > directly or indirectly by many kernel files. So even though it is rarely
> > used, but it is still a public API.
> 
> It is a bit tricky, for example, given a kernel built with both
> CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_DYNAMIC=y, it will never
> invoke touch_nmi_watchdog(), even if it really is in an RCU read-side
> critical section.  This is because it was intended for lockdep-like use,
> where (for example) you don't want to complain about sleeping in an RCU
> read-side critical section unless you are 100% sure that you are in fact
> in an RCU read-side critical section.
> 
> Maybe something like this?
> 
> 	if (irqs_disabled() || !IS_ENABLED(CONFIG_PREEMPT_RCU) || rcu_preempt_depth())
> 		touch_nmi_watchdog();

I don't understand the PREEMPT_NONE+DYNAMIC reasoning. irqs_disabled()
should not be affected by this and rcu_preempt_depth() will be 0 for
!CONFIG_PREEMPT_RCU so I don't think this is required. 

> This would *always* invoke touch_nmi_watchdog() for such kernels, which
> might or might not be OK.
> 
> I freely confesss that I am not sure which of these is appropriate in
> this setting.

What about a more straight forward and obvious approach?

diff --git a/mm/mm_init.c b/mm/mm_init.c
index fc2a6f1e518f1..0b283fd48b282 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2059,7 +2059,7 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
  */
 static unsigned long __init
 deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
-			   struct zone *zone)
+			   struct zone *zone, bool may_schedule)
 {
 	int nid = zone_to_nid(zone);
 	unsigned long nr_pages = 0;
@@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 
 			spfn = chunk_end;
 
-			if (irqs_disabled())
-				touch_nmi_watchdog();
-			else
+			if (may_schedule)
 				cond_resched();
+			else
+				touch_nmi_watchdog();
 		}
 	}
 
@@ -2101,7 +2101,7 @@ deferred_init_memmap_job(unsigned long start_pfn, unsigned long end_pfn,
 {
 	struct zone *zone = arg;
 
-	deferred_init_memmap_chunk(start_pfn, end_pfn, zone);
+	deferred_init_memmap_chunk(start_pfn, end_pfn, zone, true);
 }
 
 static unsigned int __init
@@ -2216,7 +2216,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
 	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
 	     spfn = epfn, epfn += PAGES_PER_SECTION) {
-		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
+		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone, false);
 	}
 
 	/*

Wouldn't this work?

> 							Thanx, Paul

Sebastian
