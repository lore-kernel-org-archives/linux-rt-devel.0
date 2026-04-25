Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BF390CA9
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Apr 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777126635; cv=none; b=PzBjYRAE/ESpE7Lztj/PrZvpGKI2OjCmcaAckxG/I+OK9Zat18XUDKRqx/hWladsaONp0AYlW6pr/69dI8JBMhfuy9Y5pAVlf8k9Eo0fI7FBmj1UKBC632j0CcE85CYX8gXFJ0V0ry9Wr5OvmT8JNbbWxdQD7sVNnod/NMpaIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777126635; c=relaxed/simple;
	bh=TxZqoT85JDPmKXuh8zVB/fRPqdIvtSCFStOtQuDrWpA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DjpwZ6LwKqLpDzh87l4EKNDL7NvQzMnRywopPnZgESIRvTW8vkdyi84cpz1fBlcELLnXdp3L9MAzy8YegsgQFeA7VXlV+N0U1ZhHD/xy779bnFSANbo5blI5EP+Zq5keLfCj5gIVd7AgR1ih0Bq9DiZe1cg+WiRl0eT23SwcciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=e7Fmzb+e; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=lsJKGQfK; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="e7Fmzb+e";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="lsJKGQfK"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 63PE90XG018980;
	Sat, 25 Apr 2026 16:09:06 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id C774D1205C5;
	Sat, 25 Apr 2026 16:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1777126137; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn62JA25Xh6EOuhuTsZJQ+z2T/z3lNqhbeg7hLlkCVI=;
	b=e7Fmzb+e43pjxv2Sey8A56NQNkuC4W1wnwPAOtTNO1X7VsYGxCfgS6z0QD4DtmahPlFJXu
	/Z0ooW/1qzUEbwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1777126137; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pn62JA25Xh6EOuhuTsZJQ+z2T/z3lNqhbeg7hLlkCVI=;
	b=lsJKGQfKww4g1QnhleU6LAAhfenpv3bPCVvOPc0z/Iy1XYA1Gb2h0e1xvA3Yvl/ZtEao1D
	Tjjca7WMJozVMxl+Z62eWBV7AvevWagAFBA+JHRQcvjwl8AXZcU3tep1MzqQPWsXZL+att
	jqQCK/13D6gDwn14/Lg21Zb9OIUFQs6sAq9H3k9BQ0IK2eqmK3voZjmhrZnVj8jzh8ZTkv
	p6hJTkLQucQoHcBCLcgT/pAd83aEt2nhHpxmej0h5ScNu+DT/D8eO0iHsbo9A7qlc7ItPG
	sIoammonGbp9o4VOGntFv/ohCqnjAbWeCjfrU+Y8/PHMy7FPzhaD5VuOhkX5IA==
Date: Sat, 25 Apr 2026 16:08:56 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        clrkwllms@kernel.org, rostedt@goodmis.org, david.lebrun@uclouvain.be,
        alex.aring@gmail.com, Justin Iurman <justin.iurman@gmail.com>,
        stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
Message-Id: <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
In-Reply-To: <20260423080056.KgHlh9Oa@linutronix.de>
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
	<20260423080056.KgHlh9Oa@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 23 Apr 2026 10:00:56 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

Hi Sebastian,

thanks for the review, and to Simon and Justin as well.


> On 2026-04-21 11:47:35 [+0200], Andrea Mayer wrote:
> >
> > [snip]
> 
> So the dst passed to skb_dst_set_noref() has no reference count. The fix
> is to use skb_dst_force() to increment the refcount on it. But this
> requires that we are in the same RCU section. And I guess we are since
> none of the warnings are visible.
 
Yes. lwtunnel_input() holds rcu_read_lock() around ops->input(), which is
where seg6_input_core()/rpl_input() execute. The skb_dst_force() is called
within that RCU section.
 

> Doesn't this make ip6_route_input() on RT fragile in general due to the
> RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
> files that are patched?
> Based on your explanation it all makes sense, I am just not sure if this
> race is limited to those two are if there is more to it.

seg6_input_core() and rpl_input() cache the dst via dst_cache_set_ip6(), which
invokes dst_hold(). The dst_hold() calls rcuref_get(), failing on a zero
refcount and triggering a WARN, but the pointer is still stored in the cache.
After the RCU grace period completes the dst is freed, and a subsequent
dst_cache_get() returns a dangling pointer.
 
The other callers of ip6_route_input() (e.g., ipv6_srh_rcv, ipv6_rpl_srh_rcv,
ip6_rcv_finish_core) consume the NOREF dst without caching it. Even if the
pcpu_rt's refcount is concurrently dropped to zero, the dst memory remains
valid because dst_release() defers the actual free via call_rcu_hurry() and the
caller is still inside the RCU read-side critical section.


> > [snip]
> >
> > Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> 
> If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
> right fixes: would be
> Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
> 
> as prior this commit the race is not possible, right?

I built and tested kernels at 3253cb49cbad and its parent fd4e876f59b7 (both
CONFIG_PREEMPT_RT=y, without the fix): no issues at fd4e876f59b7.
At 3253cb49cbad, a pcpu_rt cmpxchg contention in rt6_make_pcpu_route() shows
up, which was addressed in 1adaea51c61b. I also tested at 1adaea51c61b, and at
that point the dst_hold() race described in this patch appears.
 
The seg6/rpl code obtains a NOREF dst from ip6_route_input(), does not promote
it via skb_dst_force(), and passes it to dst_cache_set_ip6() which calls
dst_hold(). This pattern has been present since af4a2209b134 and a7a29f9c361f,
and the current Fixes: tags point to the commits where it was introduced.
Does that seem reasonable?


> Does this mean that rpl_input() does a local_bh_disable() while
> obtaining the dst but it never runs outside of bh-disabled section?
> Because if it can run in preemptible context then it would not be to
> PREEMPT_RT at which point the Fixes: tags from above would make sense
> again.
> 

rpl_input() and seg6_input_core() run in softirq context via lwtunnel_input().
They do local_bh_disable() around dst_cache_get() and dst_cache_set_ip6(), but
not around ip6_route_input(). The race window is between ip6_route_input()
returning and dst_cache_set_ip6().
 
> Sebastian

Ciao,
Andrea
