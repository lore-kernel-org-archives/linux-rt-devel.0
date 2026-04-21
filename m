Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBF3D8116;
	Tue, 21 Apr 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781544; cv=none; b=FMTpLdyehUD6Pq4gbD1UNHzRDgrYppElAyRc4K1W5lBSHWkJDyeoR4QkedmhYjbXOKZzULIlXoI8+TfS4XcM0h8pEbnlTABWcOqUNU0Xu6B2dJ80pDEWRe0Log3qOrhOr4thKxiHqDxABq0Et+9Ro/FETg8P61ac1HzlZ3hfiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781544; c=relaxed/simple;
	bh=YSxGlcQS3U1Wutb2J/VUv/2OSR9GifsEC+73SgTBQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuGpHPbNbIGvVRjm/8Tn8gzZ7Z2vmQnUHJZ7/Qf1Q2A6gZUf3NFxu64lvFK1XzgLLGAt3w9DVKE+AnVTLq4tdj/KebJOlOpd51GY5Up+Z/QyvdxNqMG4jUr5No8/cyAT5tgzjHYfoex7K2P+L9HrNr2KkP7xGIcQsHSWgtFBHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmlrW0kq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmlrW0kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE4FC2BCB0;
	Tue, 21 Apr 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781543;
	bh=YSxGlcQS3U1Wutb2J/VUv/2OSR9GifsEC+73SgTBQOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmlrW0kq2qwKedKZVYa/gk4R47bz9FuApozdzY47ikUR4EG5WBsqR24nn+3QlPz22
	 MYX/GbhHpcG+YBHmFTKqWS6WJJtrcdaEzkJPs8iuZF+Lo+8M/m1UKrv97flgD1CG7g
	 rVb8rrdru4bu50nPP9VcbZ+pIRDwHQX2umDcpn8Sxuk9MSk6pUwSBHMWOpp5GxiHOr
	 FCPiYhUwVHzKTHJ6LGghGgZMwNX/r1XXYxUgeWgqUipoHBHQAgkfFh7StLmmi6gZlj
	 G7CtG8nCmlScNlKdxDodyFPBQKBjUpw71v8nTW+aIm/NuOy/53ZMNuW0CFVgW4ZedC
	 +L9uL7HlJnMxA==
Date: Tue, 21 Apr 2026 15:25:32 +0100
From: Simon Horman <horms@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	david.lebrun@uclouvain.be, alex.aring@gmail.com,
	stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
Message-ID: <20260421142532.GD651125@horms.kernel.org>
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>

On Tue, Apr 21, 2026 at 11:47:35AM +0200, Andrea Mayer wrote:
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
> 
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Reviewed-by: Simon Horman <horms@kernel.org>

