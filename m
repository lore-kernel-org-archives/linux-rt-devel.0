Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA11E5B9A
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931261; cv=none; b=YtHviNKp6viB36/eGP8PtT8XYVwzNwCRsQHzaaCcWNWU+4bFDDllz4WswU6dTbhMwbpLgDiCQ38ci2xkilIEm+UGhF72+RqsHqMeLW2V/cs3TvAXoLT4EZ/SitUAePdiog3HVQyqDm1Co05+30xNlx7QLbq2NhXY+5pimBsJvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931261; c=relaxed/simple;
	bh=3MoVpFbFeUx8s90sN+67YWz0tzIK1QHfqyZdBkPkkto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2zvInP3wEW2/kTLOlE0NBts8GWaBHG2m1vg9gJTT6Rmo5mHrdDGHGSDLWN11xwX68HofTC4ho4Qu7KRQfQK50rXAslk4o6wAP6Llg1ZvTfqWrqyPQH4nOghkDci5GCSbDBsq1sqCC0h9od+qKonDjzh+lN7Trp9wJKjN6DfeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/1/pHnX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=70mgCanu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/1/pHnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="70mgCanu"
Date: Thu, 23 Apr 2026 10:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776931257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QHhz/9T/OJSzUNvcLNt2BPNKqEWvsL+RnuXLOFLmCg=;
	b=X/1/pHnXryTqG5+FU0N+R447V7bgASn55vlxf48vrunygSA5uPaMl11d0FTcJ5/sVJnKoD
	OCorivR7WWpp7Ia2LkqWs075NQ8YkTtZClZiiNVrRSPLnzdmD6Lr9U4pjbZTYcDgWpY2NG
	6+x8P5rERTgrnGFJukgOodPhyMK7V0agMjNoF5B0bARB3JwAupKaT21t1l/bIsyMipOqXU
	V5+sfT7jbPh+zn/De6Fjs5U0eMGqTPfxCT1NdVNAAFa8PFZKqlQiI6gr5C5YijOnqCBB/n
	QIUyP5Tdgd/p7QSjLIEXJzhJSWLwu49YlWXNGMBkeLLisTOMDIZu+6pVTqz7rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776931257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QHhz/9T/OJSzUNvcLNt2BPNKqEWvsL+RnuXLOFLmCg=;
	b=70mgCanuAzHj1pzUlzuHVlkQewHCk9OddT90UEm7SFq30YCG2riQapHkjjTWyAHGKAp+hr
	yB8IHHvIee8twdDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	david.lebrun@uclouvain.be, alex.aring@gmail.com,
	stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
Message-ID: <20260423080056.KgHlh9Oa@linutronix.de>
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>

On 2026-04-21 11:47:35 [+0200], Andrea Mayer wrote:
> seg6_input_core() and rpl_input() call ip6_route_input() which sets a
> NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
> dst_hold() unconditionally.
> On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
> release the underlying pcpu_rt between the lookup and the caching
> through a concurrent FIB lookup on a shared nexthop.
> Simplified race sequence:
> 
>   ksoftirqd/X                       higher-prio task (same CPU X)
>   -----------                       --------------------------------
>   seg6_input_core(,skb)/rpl_input(skb)
>     dst_cache_get()
>       -> miss
>     ip6_route_input(skb)
>       -> ip6_pol_route(,skb,flags)
>          [RT6_LOOKUP_F_DST_NOREF in flags]
>         -> FIB lookup resolves fib6_nh
>            [nhid=N route]
>         -> rt6_make_pcpu_route()
>            [creates pcpu_rt, refcount=1]
>              pcpu_rt->sernum = fib6_sernum
>              [fib6_sernum=W]
>            -> cmpxchg(fib6_nh.rt6i_pcpu,
>                       NULL, pcpu_rt)
>               [slot was empty, store succeeds]
>       -> skb_dst_set_noref(skb, dst)
>          [dst is pcpu_rt, refcount still 1]
> 
>                                     rt_genid_bump_ipv6()
>                                       -> bumps fib6_sernum
>                                          [fib6_sernum from W to Z]
>                                     ip6_route_output()
>                                       -> ip6_pol_route()
>                                         -> FIB lookup resolves fib6_nh
>                                            [nhid=N]
>                                         -> rt6_get_pcpu_route()
>                                              pcpu_rt->sernum != fib6_sernum
>                                              [W <> Z, stale]
>                                           -> prev = xchg(rt6i_pcpu, NULL)
>                                           -> dst_release(prev)
>                                              [prev is pcpu_rt,
>                                               refcount 1->0, dead]
> 
>     dst = skb_dst(skb)
>     [dst is the dead pcpu_rt]
>     dst_cache_set_ip6(dst)
>       -> dst_hold() on dead dst
>       -> WARN / use-after-free

So the dst passed to skb_dst_set_noref() has no reference count. The fix
is to use skb_dst_force() to increment the refcount on it. But this
requires that we are in the same RCU section. And I guess we are since
none of the warnings are visible.

Doesn't this make ip6_route_input() on RT fragile in general due to the
RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
files that are patched?
Based on your explanation it all makes sense, I am just not sure if this
race is limited to those two are if there is more to it.

> For the race to occur, ksoftirqd must be preemptible (PREEMPT_RT without
> PREEMPT_RT_NEEDS_BH_LOCK) and a concurrent task must be able to release
> the pcpu_rt. Shared nexthop objects provide such a path, as two routes
> pointing to the same nhid share the same fib6_nh and its rt6i_pcpu
> entry.
> 
> Fix seg6_input_core() and rpl_input() by calling skb_dst_force() after
> ip6_route_input() to force the NOREF dst into a refcounted one before
> caching.
> The output path is not affected as ip6_route_output() already returns a
> refcounted dst.
> 
> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")

If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
right fixes: would be
Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

as prior this commit the race is not possible, right?

Does this mean that rpl_input() does a local_bh_disable() while
obtaining the dst but it never runs outside of bh-disabled section?
Because if it can run in preemptible context then it would not be to
PREEMPT_RT at which point the Fixes: tags from above would make sense
again.

> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Sebastian
