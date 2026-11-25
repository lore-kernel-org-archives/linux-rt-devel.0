Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624070;
	b=NpwSz1X4eANog29Zj0Y65rejObRhzGnb8Fl+c7sWKzTgg7/igavrBWIg9ei6+rEdDMdR
	 nc4yPzkcMvD6nps/xH1CEOEMJALJg2Xe75Zat4giNIunOYTdP2FNit3kR3CX/+MdeC9LV
	 ehKB5oYGqT3hgd2K7umq9tscLUrvYIt2hApj+RjjMeqQBschpl2tmfoIdeahvAxGQdnVC
	 /ffHKkYwKUzaPuo+3cjmefMhIdqKua0SNH4vsOeEDQS55t+qI9/L9C9RRr9O7EJaw84q/
	 vJ5AOQgchLo6/n0+dsN/YHZ0xA3OLPoFHmCjp9GOzsrvbBzZMWxi9YtxjhkRVqyH7ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Xq8OeDOZHssKoiCadVgvlbF6CHN6aUwkH9nd/7x/mQ=;
	b=4uAQ0v5fojfTf8jSZxKXHY7BJLnLq/1fOCwS41O9tlW6z1eAKVai1nQjbVemFFmmQaqN
	 wKWWnj110nRQgtIgXKjNFUobNf1X/x8bKgkx3p2HcoCyAU3s/lJWuSC8HoaO2Six2iWXZ
	 9IQ4M8fBBTAaTSwr1UZE2LJPaVQrBpsLDU8iM3spomV/K2sFBq5YBBRPeVUUWLP2emVWl
	 imdKVcSlhDt6k2goj05MBUWHc97VFf+0zGOJInbog2APdvw9B/cJA+IU/jn1/0OPLxvL2
	 nfvNyV8H4VpfxqBm8kp70hR/vMSbn7WLb6nNWn/mLNegLO2GojRrpV9U3kzxLkCKjoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HLKC/G75";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30446606A31E;
	Wed, 25 Nov 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLKC/G75
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D432E1F000C6;
	Wed, 25 Nov 2026 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624070;
	bh=6Xq8OeDOZHssKoiCadVgvlbF6CHN6aUwkH9nd/7x/mQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HLKC/G75fi9sy0J6WPDfd1XuHL+jH5hQ864LYO8hJxRKsP9itojTpV+DomEB+ziOL
	 AG6Oz9gZpyd+TThtXLRWvrUcz+HR6Suy1cgyDe0bhZmXKQZQjZg7AXK02i0JR4SKC1
	 yQuRiE09olqXbbovD1ae6pIyID2ibNt26E8w1rKS2C8lMbJLM9gwdJSwZ3RJ5n7LF+
	 ONDT/EcHgKDankLsMjRA7bgELL8ZBsEdlP53tsy4ezqK+KzaeLqVd+piwgACZVPnMn
	 bAoA9THmx5raQv3LuOrLrMCyNdKz+gIMCq3rexG6c7tnz1LPrQY1Qpbx0iuflVjxz0
	 lX08+8vmILrDQ==
Message-ID: <sashiko-outbox-233749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 4/4] ipv6: validate dsts against the state
 their lookup found
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ralf Lici" <ralf@mandelbit.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <4b2bf5de6c9837fee8db88d639db0e27e6d687b9.1795537128.git.ralf@mandelbit.com>
References: <cover.1795537128.git.ralf@mandelbit.com>
 <4b2bf5de6c9837fee8db88d639db0e27e6d687b9.1795537128.git.ralf@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:27:49 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] ipv6: deleted nexthop-object pcpu dsts stay valid in
  ip6_dst_check()
- [Medium] ipv6: PREEMPT_RT race killing or returning dead pcpu dsts in
  route.c
--

commit 4fc9718ac0ef513c19b112ac560ff9d40fa15b7c
Author: Ralf Lici <ralf@mandelbit.com>

ipv6: validate dsts against the state their lookup found

This commit validates IPv6 dst entries in ip6_dst_check() and reuses or
replaces cached per-CPU dsts based on the lookup stamp recorded when the
dst was built rather than the cookie passed by the holder.

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 8b98ee945c583..be9bf7a4e7808 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1501,7 +1501,7 @@ static struct rt6_info *ip6_rt_pcpu_alloc(const str=
uct fib6_result *res)
>  	pcpu_rt->rt6i_flags |=3D RTF_PCPU;
> =20
>  	if (f6i->nh)
> -		pcpu_rt->sernum =3D rt_genid_ipv6(dev_net(dev));
> +		pcpu_rt->sernum =3D res->gen;
> =20
>  	return pcpu_rt;
>  }
> @@ -1511,6 +1511,33 @@ static bool rt6_is_valid(const struct rt6_info *rt=
6)
>  	return rt6->sernum =3D=3D rt_genid_ipv6(dev_net(rt6->dst.dev));
>  }
> =20
> +static bool rt6_stamp_matches(const struct rt6_info *rt,
> +			      const struct fib6_result *res)
> +{
> +	if (rt->sernum || res->f6i->nh)
> +		return res->gen && rt->sernum =3D=3D res->gen;
> +
> +	return res->cookie && rt->cookie =3D=3D res->cookie;
> +}
> +
> +static void rt6_pcpu_release_rcu(struct rcu_head *head)
> +{
> +	struct dst_entry *dst =3D container_of(head, struct dst_entry, rcu_head=
);
> +
> +	dst_release(dst);
> +}
> +
> +/* Release a pcpu dst taken out of its slot. Lookups may have read the s=
lot
> + * without taking a reference, so drop the slot's own only after a grace
> + * period: an xfrm bundle holding the dst as its child releases its
> + * reference without waiting for one.
> + */
> +static void rt6_pcpu_release(struct rt6_info *rt)
> +{
> +	dst_dev_put(&rt->dst);
> +	call_rcu(&rt->dst.rcu_head, rt6_pcpu_release_rcu);
> +}
> +
>  /* It should be called with rcu_read_lock() acquired */
>  static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
>  {
> @@ -1518,16 +1545,19 @@ static struct rt6_info *rt6_get_pcpu_route(const =
struct fib6_result *res)
> =20
>  	pcpu_rt =3D this_cpu_read(*res->nh->rt6i_pcpu);
> =20
> -	if (pcpu_rt && pcpu_rt->sernum && !rt6_is_valid(pcpu_rt)) {
> +	/* A pcpu dst is shared by all its holders, so it is never re-stamped.
> +	 * Reuse it only if it was built under the state this lookup found,
> +	 * otherwise replace it: a dst rebuilt by another lookup after a FIB
> +	 * change must not be returned to a lookup that selected before it.
> +	 */
> +	if (pcpu_rt && !rt6_stamp_matches(pcpu_rt, res)) {
>  		struct rt6_info *prev, **p;
> =20
>  		p =3D this_cpu_ptr(res->nh->rt6i_pcpu);
>  		/* Paired with READ_ONCE() in __fib6_drop_pcpu_from() */
>  		prev =3D xchg(p, NULL);
> -		if (prev) {
> -			dst_dev_put(&prev->dst);
> -			dst_release(&prev->dst);
> -		}
> +		if (prev)
> +			rt6_pcpu_release(prev);
> =20
>  		pcpu_rt =3D NULL;
>  	}
> @@ -1550,13 +1580,21 @@ static struct rt6_info *rt6_make_pcpu_route(struc=
t net *net,
>  		/*
>  		 * Another task on this CPU already installed a pcpu_rt.
>  		 * This can happen on PREEMPT_RT where preemption is possible.
> -		 * Free our allocation and return the existing one.
> +		 * Free our allocation and return the existing one if it was
> +		 * built under the state this lookup found, otherwise replace
> +		 * it as rt6_get_pcpu_route does.
>  		 */
>  		WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT));
> =20
> -		dst_dev_put(&pcpu_rt->dst);
> -		dst_release(&pcpu_rt->dst);
> -		return prev;
> +		if (rt6_stamp_matches(prev, res)) {
> +			dst_dev_put(&pcpu_rt->dst);
> +			dst_release(&pcpu_rt->dst);
> +			return prev;
> +		}
> +
> +		prev =3D xchg(p, pcpu_rt);
> +		if (prev)
> +			rt6_pcpu_release(prev);
>  	}

[Severity: Medium]
On CONFIG_PREEMPT_RT, can concurrent lookups on the same CPU kill a live
pcpu_rt or return one that has already been released?

local_bh_disable() in ip6_pol_route() pins the task to the CPU, but tasks
on the same CPU can still preempt one another inside rt6_get_pcpu_route()
and rt6_make_pcpu_route():

rt6_get_pcpu_route() [task A]
  pcpu_rt =3D this_cpu_read(*p)
  !rt6_stamp_matches(pcpu_rt, res)
  <preempted by task B on same CPU>
    rt6_get_pcpu_route()
      xchg(p, NULL)
    rt6_make_pcpu_route()
      cmpxchg(p, NULL, new_rt)
    return new_rt
  <task A resumes>
  prev =3D xchg(p, NULL)
  rt6_pcpu_release(prev)
    dst_dev_put(&new_rt->dst)  <-- kills live new_rt held by task B

The same unconditional xchg(p, pcpu_rt) overwrite exists in
rt6_make_pcpu_route() when !rt6_stamp_matches(prev, res).  Conversely, if
task A gets prev from cmpxchg(p, NULL, pcpu_rt) in rt6_make_pcpu_route()
and is preempted before returning it, task B can replace prev and call
rt6_pcpu_release(prev).  Because rt6_pcpu_release() leaves prev->cookie
and prev->sernum intact and defers dst_release() via call_rcu(), task A
resumes, sees rt6_stamp_matches(prev, res), and returns the dead dst
(which still passes ip6_hold_safe() before the grace period elapses).

> @@ -2864,11 +2902,16 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst=
_check(struct dst_entry *dst,
>  	struct dst_entry *dst_ret;
>  	struct fib6_info *from;
>  	struct rt6_info *rt;
> +	bool exception;
> =20
>  	rt =3D dst_rt6_info(dst);
> =20
> +	/* a nexthop-object pcpu dst replaced by another lookup has been
> +	 * released with dst_dev_put and must fail even if its stamp is current
> +	 */
>  	if (rt->sernum)
> -		return rt6_is_valid(rt) ? dst : NULL;
> +		return (READ_ONCE(rt->dst.obsolete) =3D=3D DST_OBSOLETE_FORCE_CHK &&
> +			rt6_is_valid(rt)) ? dst : NULL;

[Severity: High]
Does a nexthop-object pcpu dst stay valid in ip6_dst_check() and
rt6_stamp_matches() after its route is deleted?

Deleting a route via fib6_del() -> fib6_del_route() -> fib6_purge_rt()
does not call fib6_new_sernum(), so rt_genid_ipv6() is unchanged.
Instead, __fib6_drop_pcpu_from() (and the fib6_destroying path in
rt6_make_pcpu_route()) invalidates the cached per-CPU dst only by
clearing pcpu_rt->from to NULL, leaving pcpu_rt in res->nh->rt6i_pcpu
with dst.obsolete =3D=3D DST_OBSOLETE_FORCE_CHK and its non-zero sernum:

net/ipv6/ip6_fib.c:__fib6_drop_pcpu_from() {
	...
		if (pcpu_rt && rcu_access_pointer(pcpu_rt->from) =3D=3D match) {
			struct fib6_info *from;

			from =3D unrcu_pointer(xchg(&pcpu_rt->from, NULL));
			fib6_info_release(from);
		}
	...
}

Because ip6_dst_check() returns early when rt->sernum is non-zero before
checking rcu_dereference(rt->from), holders keep validating and sending
through the deleted route's dst.  In addition, because rt6_stamp_matches()
checks rt->sernum =3D=3D res->gen without checking rcu_access_pointer(rt->f=
rom),
later lookups on the same CPU matching another route that shares the
nexthop object reuse the pcpu_rt whose from is NULL, causing
inet6_rtm_getroute() to fail with -ENETUNREACH and PMTU updates in
__ip6_rt_update_pmtu() to silently abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795537128.gi=
t.ralf@mandelbit.com?part=3D4
