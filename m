Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18E21D3D2
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792818; cv=none; b=O0du5qybpqMorGjeRDRdDRWCl43JP8pUFZEMy6N1AUa9KCqZgK2EBLIWQh2ZWtoD2gk8P4lJNYhpF9F3mjBGV44WY6kstf1SongW/xirNx6p9/iC397KX8iJ1Yvk8WA5LmMS/JJ43radzLGQ1yy4iWJ7Tf0msFWC+RlrAZ4iOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792818; c=relaxed/simple;
	bh=/scXEeQaRN4B/NeF1PUsl2czhaClwcX6Cf0nOChKG7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsQ7m2EExC41gbGf+vyBg10tMnG3nq4VBNEe0ldsXgPAMoK3BHA8QFPRENqoLLIGMieLf05BAt5qRztOAKBdF53O6tn3prN6MrzkND8H2XfpCszQUTMLyFkYKEoawaw56VZBlRCh+xyqE1znfuBK8ihp8d88pcWviSJY2zC1Nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSy28Cjp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSy28Cjp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba922426c5cso286041766b.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792815; x=1777397615; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoCWrohdiik85XEdHlXUw0nj/jBXY1QzvkY+M7xyZZ4=;
        b=fSy28CjpHzlxoCo1p7XrNdNXZyytqp4dU6FEpX2twSYJME2/Ev8IHllpQqT7xDJmeG
         amC1IAZ+IGj/vuGIDfApWNTRacEMx3hDiobM+ErZxibI8mFNnpBXVTcQu24HtshDltOE
         wmSV2o5YcVBsJRQ4N+pcK+EohRifwenkN/gUTRYSi6NeQOwJ3I9RYrTRad5yL6Qike+Y
         XrgWTC7uByqs8f2k0f0xqNrqakBaFOnyC1SBJV853+gYR3CQogK3fW3IBjuZl2+Pxq9h
         T4JFJfZ7yKQb89WR2yqAhh/+Ou5ZRQZbAr/eX8j94W9eq9qhekR89Ik3LtlRXg4DMfD8
         gUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792815; x=1777397615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoCWrohdiik85XEdHlXUw0nj/jBXY1QzvkY+M7xyZZ4=;
        b=NgIdhY/l6dYYH38DjMdds2wQjS3RXqUlrxVNzLeyJTJTgAcQLOcUZgya2A45CTNJg+
         EAm0dk77dd/wuFzh4gZ/0yq1Tf5pkeXIzFvKKR0G3/qFEQSG8tHEtG0bZOdSvVrdPsXR
         xtWFkFVRdZEggyFcWBTebMjiUSAUCe0lJvlfMpnpeJsxFddGDs43i9a8wdsb2qpzpYz8
         fUxEL8YoVxVZaYrPkTLisAjNp2/27y18sXZdP0Hg2m7SWlb9IFUpOHozhrfm1/u0Zxjg
         ZZmiLmagI4uWLunqguURwW3vTCmfhvM9xexxlrQvoYWxzaMCUkdu+fY0K9pfz9ybLO0F
         rJ8A==
X-Forwarded-Encrypted: i=1; AFNElJ8bZbFEWlRSQX+3/BKV+CjDDDT8acjqU2E+aSZZG6hHh4ZhS+8P1neqYxrAGb+XgnxHhYhBHYOuxyoX/ucwLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJXbQorsyXRtUt678IU1hdHYIpdrWrPHL3hpXp/SKV1HiSRbPy
	yOcUkp6KgUO1j8b8K3LDruj5nXm7+HQVpXKI7vggpRJJMc706J7z3dxf
X-Gm-Gg: AeBDiev1tF6ldxFqO6FmmkAvaHZGJQg0W8UIZgxiq7jVKa5Q1rw+ssJokABqFPKt3OG
	3zQG+p9NduPhdcVKoXCNy+5mi5heiyReHBWnFQcN96TuIFzKHbK+ZcrxlL75bI5cnV+B7SqTHOb
	QK62jngZA/qwIBuv6GGQ02C38vTsuPRkcfOvRCnnvr65FoWupwVy7Fx8e9nxCfo5Hk0c6o0U/34
	4/oYcFX25V5Bd+bAGC1LbHJ/nPibhCulhZzFp9u6EkU/Ir2/y+hlwWfyP0lkjciUv/MoeZbfwpo
	EYjbL9HL/ssOvIm7+hU6TI5jFMiq+gdsNGW1/pH+53UkVbQBiFrVoeq+mZx/GoJUCKfCIKv0ITl
	Xey9RbSdUZWMhKuwe+xNL+y7NaBnuVAsjx2VTsxl27G7ivAfLBO//SDnY2touReAHpLdmf+YVVy
	F4NndQhlkYeQPI5fLaPrDXgf5lgRLj/uzneK526P3gNswQ4EPSAXyNV7GKO07ucwWYFwQJ9S45P
	3LE9fzHqgZ52rGrc5OkoDpPIyw=
X-Received: by 2002:a17:907:ea6:b0:b96:f6f1:e7af with SMTP id a640c23a62f3a-ba41916eb4dmr907537666b.9.1776792814542;
        Tue, 21 Apr 2026 10:33:34 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879? ([2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4519ee4adsm469401966b.19.2026.04.21.10.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:33:34 -0700 (PDT)
Message-ID: <8ce64ee4-dce1-4052-9558-61c97121cc37@gmail.com>
Date: Tue, 21 Apr 2026 19:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
To: Andrea Mayer <andrea.mayer@uniroma2.it>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 david.lebrun@uclouvain.be, alex.aring@gmail.com,
 stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 11:47, Andrea Mayer wrote:
> seg6_input_core() and rpl_input() call ip6_route_input() which sets a
> NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
> dst_hold() unconditionally.
> On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
> release the underlying pcpu_rt between the lookup and the caching
> through a concurrent FIB lookup on a shared nexthop.
> Simplified race sequence:
> 
>    ksoftirqd/X                       higher-prio task (same CPU X)
>    -----------                       --------------------------------
>    seg6_input_core(,skb)/rpl_input(skb)
>      dst_cache_get()
>        -> miss
>      ip6_route_input(skb)
>        -> ip6_pol_route(,skb,flags)
>           [RT6_LOOKUP_F_DST_NOREF in flags]
>          -> FIB lookup resolves fib6_nh
>             [nhid=N route]
>          -> rt6_make_pcpu_route()
>             [creates pcpu_rt, refcount=1]
>               pcpu_rt->sernum = fib6_sernum
>               [fib6_sernum=W]
>             -> cmpxchg(fib6_nh.rt6i_pcpu,
>                        NULL, pcpu_rt)
>                [slot was empty, store succeeds]
>        -> skb_dst_set_noref(skb, dst)
>           [dst is pcpu_rt, refcount still 1]
> 
>                                      rt_genid_bump_ipv6()
>                                        -> bumps fib6_sernum
>                                           [fib6_sernum from W to Z]
>                                      ip6_route_output()
>                                        -> ip6_pol_route()
>                                          -> FIB lookup resolves fib6_nh
>                                             [nhid=N]
>                                          -> rt6_get_pcpu_route()
>                                               pcpu_rt->sernum != fib6_sernum
>                                               [W <> Z, stale]
>                                            -> prev = xchg(rt6i_pcpu, NULL)
>                                            -> dst_release(prev)
>                                               [prev is pcpu_rt,
>                                                refcount 1->0, dead]
> 
>      dst = skb_dst(skb)
>      [dst is the dead pcpu_rt]
>      dst_cache_set_ip6(dst)
>        -> dst_hold() on dead dst
>        -> WARN / use-after-free
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
> ---
>   net/ipv6/rpl_iptunnel.c  | 9 +++++++++
>   net/ipv6/seg6_iptunnel.c | 9 +++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index c7942cf65567..4e10adcd70e8 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -287,7 +287,16 @@ static int rpl_input(struct sk_buff *skb)
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> +
> +		/* ip6_route_input() sets a NOREF dst; force a refcount on it
> +		 * before caching or further use.
> +		 */
> +		skb_dst_force(skb);
>   		dst = skb_dst(skb);
> +		if (unlikely(!dst)) {
> +			err = -ENETUNREACH;
> +			goto drop;
> +		}
>   
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 97b50d9b1365..94284b483be0 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -515,7 +515,16 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> +
> +		/* ip6_route_input() sets a NOREF dst; force a refcount on it
> +		 * before caching or further use.
> +		 */
> +		skb_dst_force(skb);
>   		dst = skb_dst(skb);
> +		if (unlikely(!dst)) {
> +			err = -ENETUNREACH;
> +			goto drop;
> +		}
>   
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {

Thanks for taking care of this, Andrea! LGTM.

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
