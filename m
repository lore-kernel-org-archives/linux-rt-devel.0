Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969427;
	b=U+oxMrrBjPVaomJmdADkK4k5ArrciRcG7djQgzukNMmrfEoxbEcGasmUc7qfnFLlZp9K
	 mj7ayThTYqUay8xt5gfVuXFjSJT6vPkk9i7U1BkjTQufHfbK1vqHgRn2yWubsJUDSVtp5
	 UOeiLza09ulX4++wLCIPZN+/rCiF6qQcr+CjLyPkRYCux/aB1JMb+fU0n/3CQ1x0DXW5R
	 1W5jEkFPdTYbWnKPjTrpNi/EKqMW3Y/85SIg5COkcgiqapiWkI2GXhc01YCYnir4NCTfD
	 cLHahE5XAwJfF8BZp39XknqzSWhAmPGh1iGHD50aWDEXrYrzpFniYoW6okRlE1abMwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zw5PLTisSNM1LdDGger9ez3C9BwJ3IBoJFd8oVYZeZw=;
	b=OpxmktGNMnP/V1Yu7aji371qjcvqUhx0gGkqySogeOGcrK7ZFHQ5aSfvYNgdUdZjPavA
	 nLNX8ruUnCdyZhRtCH3FAVL2enJD8dTFmYVpM1X71rARzkcYhxmDT0LIl2uPHRmnPnPlw
	 OkfxrdOJNBKbl6eQlRXob+46HY/dEJlxbVRwVuQYcHlcka1VV4SdF11Wv/svTbi1LNjkj
	 ly+phqtvyDvrJVuGiSCHvUZdZze0AeXBZqvOUNoHNmVknxnGOJTCkiqIlgUVZqjgKtn1v
	 fNd0qQ2kqYWWmt8I34nWzVjPBL94Fk5VYwTCu8EsirUUP9+p+IAiz9z3gfK8F6bZ2lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBhC5bpg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047A606A32D;
	Fri,  6 Nov 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBhC5bpg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6865E1F008A4;
	Fri,  6 Nov 2026 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969426;
	bh=zw5PLTisSNM1LdDGger9ez3C9BwJ3IBoJFd8oVYZeZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBhC5bpg2TJakqocAR9RVfUn0JdC9zF9uH5Z175bnnNz1tHBcjHJOV0zpmQeUD3FR
	 b5OLtJ+aiE/SCSY4I29aStwB+DOOg+zuPm3pOTzdpu8NEB3rVfYeWw+eMLXeKA9Qqk
	 /w4tVvD+ngJyfgyn0YFrkfQbDp/HACggalCuTb88HirZ9cYnurfY46asiI1bPGt1oi
	 562OARbiQWuIhaaTbYKSH+MebHiJ7ij+LzDA1cjp2qK/LV3nK1pCTbi89FX1N/ulsw
	 LZBes9be9Sg0F0sDdJxgQkyQMyj4RsMuzlLFvLbHN1sETZ39M2OsYRBsIC7gp5nnqh
	 SQybalK+EEyOw==
Message-ID: <sashiko-outbox-201421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 5/5] amt: harden relay authentication and
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Ramadan" <omar@blockcast.net>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105125010.1107546-6-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
 <20261105125010.1107546-6-omar@blockcast.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:50:26 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] amt: tunnel allocated before inner IGMP/MLD check in
  amt_update_handler()
- [Medium] amt: race with amt_tunnel_expire() drops valid Update in
  amt_update_handler()
- [Low] amt: redundant amt_update_relay_status() call in
  amt_update_handler()
--

commit f8d7b3a5dca8e65b55fc968b3708aa21bb6f8353
Author: Omar Ramadan <omar@blockcast.net>

amt: harden relay authentication and teardown

This commit makes AMT Request handling stateless by computing the Query MAC
from the endpoint address, port, nonce, and secret generations without
allocating tunnel state. Tunnel allocation is deferred to Membership Update
processing after MAC verification, keyed by source IP and source port with
global and per-source limits.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 26a942c2a1267..312b36b54ff8e 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -2586,16 +2610,107 @@ static bool amt_membership_query_handler(struct =
amt_dev *amt,
>  	return false;
>  }
> =20
> +/* The tunnel of the gateway endpoint @saddr:@sport, or NULL. */
> +static struct amt_tunnel_list *amt_tunnel_lookup(struct amt_dev *amt,
> +						 __be32 saddr, __be16 sport)
> +{
> +	struct amt_tunnel_list *tunnel;
> +
> +	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
> +		if (tunnel->ip4 =3D=3D saddr && tunnel->source_port =3D=3D sport)
> +			return tunnel;
> +	return NULL;
> +}
> +
> +/* Look up the tunnel for a source whose Membership Update has already b=
een
> + * authenticated, creating it on first contact.
> + *
> + * This is now the only place tunnel state is allocated, so amt->max_tun=
nels
> + * bounds the number of *verified* gateways rather than the number of
> + * unverified Requests anyone can send.  A fixed per-source cap addition=
ally
> + * stops one verified source address from monopolising the table.
> + */
> +static struct amt_tunnel_list *amt_tunnel_get_or_create(struct amt_dev *=
amt,
> +							__be32 saddr,
> +							__be16 sport)
> +{
> +	struct amt_tunnel_list *tunnel;
> +	int per_src =3D 0;
> +	int i;
> +
> +	tunnel =3D amt_tunnel_lookup(amt, saddr, sport);
> +	if (tunnel)
> +		return tunnel;

[Severity: Medium]
What happens in drivers/net/amt.c when amt_update_handler() calls
amt_tunnel_get_or_create() concurrently with amt_tunnel_expire() expiring t=
he
same tunnel?

In amt_tunnel_expire(), the work handler acquires amt->lock, checks
tunnel->last_seen against jiffies, marks the tunnel dead under tunnel->lock,
and removes it from amt->tunnel_list:

drivers/net/amt.c:amt_tunnel_expire() {
	spin_lock_bh(&amt->lock);
	...
	deadline =3D READ_ONCE(tunnel->last_seen);
	...
	if (time_before(jiffies, deadline)) {
		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - jiffies);
		spin_unlock_bh(&amt->lock);
		return;
	}
	spin_lock_bh(&tunnel->lock);
	WRITE_ONCE(tunnel->dead, true);
	spin_unlock_bh(&tunnel->lock);
	rcu_read_lock();
	list_del_rcu(&tunnel->list);
	...
}

Because amt_tunnel_lookup() walks amt->tunnel_list under RCU without holding
amt->lock or checking tunnel->dead, it can find and return a tunnel after
amt_tunnel_expire() has already passed the deadline check (and before
list_del_rcu() completes).

When that happens, amt_tunnel_get_or_create() returns the dying tunnel inst=
ead
of taking the amt->lock slow path to wait for removal and allocate a
replacement. amt_update_handler() then updates tunnel->last_seen too late to
stop expiry, sees READ_ONCE(tunnel->dead) under tunnel->lock, and drops the
valid Membership Update:

drivers/net/amt.c:amt_update_handler() {
	...
		spin_lock_bh(&tunnel->lock);
		if (READ_ONCE(tunnel->dead)) {
			spin_unlock_bh(&tunnel->lock);
			return true;
		}
}

Should amt_tunnel_lookup() or the caller handle a concurrently expiring tun=
nel
so the valid Membership Update is not dropped?

> +
> +	spin_lock_bh(&amt->lock);
> +
> +	/* Re-check under the lock in case a concurrent Update won the race, and
> +	 * count how many tunnels this source already holds on the same walk.
> +	 */
> +	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
> +		if (tunnel->ip4 !=3D saddr)
> +			continue;
> +		if (tunnel->source_port =3D=3D sport) {
> +			spin_unlock_bh(&amt->lock);
> +			return tunnel;
> +		}
> +		per_src++;
> +	}
> +
> +	if (amt->nr_tunnels >=3D amt->max_tunnels ||
> +	    per_src >=3D AMT_MAX_TUNNELS_PER_SRC) {
> +		spin_unlock_bh(&amt->lock);
> +		return NULL;
> +	}
> +
> +	if (!netif_running(amt->dev)) {
> +		spin_unlock_bh(&amt->lock);
> +		return NULL;
> +	}
> +
> +	tunnel =3D kzalloc(sizeof(*tunnel) +
> +			 (sizeof(struct hlist_head) * amt->hash_buckets),
> +			 GFP_ATOMIC);
> +	if (!tunnel) {
> +		spin_unlock_bh(&amt->lock);
> +		return NULL;
> +	}
> +
> +	tunnel->source_port =3D sport;
> +	tunnel->ip4 =3D saddr;
> +	tunnel->amt =3D amt;
> +	spin_lock_init(&tunnel->lock);
> +	for (i =3D 0; i < amt->hash_buckets; i++)
> +		INIT_HLIST_HEAD(&tunnel->groups[i]);
> +
> +	tunnel->last_seen =3D jiffies;
> +	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
> +	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE, false);

[Severity: Low]
In drivers/net/amt.c, amt_tunnel_get_or_create() initializes tunnel->status=
 to
AMT_STATUS_RECEIVED_UPDATE here via __amt_update_relay_status() with valida=
te
set to false.

Later in amt_update_handler(), when __netif_rx(skb) succeeds, the code calls
amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE, true):

drivers/net/amt.c:amt_update_handler() {
	...
	if (__netif_rx(skb) =3D=3D NET_RX_SUCCESS) {
		amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE,
					true);
		dev_sw_netstats_rx_add(amt->dev, len);
	}
}

Since __amt_update_relay_status() returns early when validate is true and
tunnel->status >=3D status:

drivers/net/amt.c:__amt_update_relay_status() {
	if (validate && tunnel->status >=3D status)
		return;
	...
}

and tunnel->status is already AMT_STATUS_RECEIVED_UPDATE from creation, does
the amt_update_relay_status() call in amt_update_handler() just take and dr=
op
tunnel->lock on every Membership Update as a no-op?

> +
> +	/* Publish only once the entry is fully initialised. */
> +	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
> +	amt->nr_tunnels++;
> +	mod_delayed_work(amt_wq, &tunnel->gc_wq,
> +			 msecs_to_jiffies(amt_gmi(amt)) * 3);
> +	spin_unlock_bh(&amt->lock);
> +
> +	return tunnel;
> +}

[ ... ]

> @@ -2609,34 +2724,52 @@ static bool amt_update_handler(struct amt_dev *am=
t, struct sk_buff *skb)

[ ... ]

> +	if (!verified) {
> +		netdev_dbg(amt->dev, "Invalid MAC\n");
> +		return true;
> +	}
> +
> +	tunnel =3D amt_tunnel_get_or_create(amt, saddr, sport);
> +	if (!tunnel)
> +		return true;
> +
> +	/* Refresh liveness only.  gc_wq is re-armed by amt_tunnel_expire()
> +	 * itself from last_seen, never from here, so this cannot re-queue the
> +	 * work of a tunnel that is being freed.
> +	 */
> +	WRITE_ONCE(tunnel->last_seen, jiffies);
> +
> +	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
> +		return true;
> =20
> -	return true;
> +	skb_reset_network_header(skb);
> =20
> -report:
>  	if (!pskb_may_pull(skb, sizeof(*iph)))
>  		return true;

[Severity: Medium]
In drivers/net/amt.c, amt_update_handler() calls amt_tunnel_get_or_create()
and updates tunnel->last_seen before decapsulating the packet and validating
the inner IGMP or MLD report:

drivers/net/amt.c:amt_update_handler() {
	...
	if (!pskb_may_pull(skb, sizeof(*iph)))
		return true;

	if (skb_cow_head(skb, 0))
		return true;

	iph =3D ip_hdr(skb);
	if (iph->version =3D=3D 4) {
		if (ip_mc_check_igmp(skb)) {
			netdev_dbg(amt->dev, "Invalid IGMP\n");
			return true;
		}
	...
	} else if (iph->version =3D=3D 6) {
		struct ipv6hdr *ip6h =3D ipv6_hdr(skb);

		if (ipv6_mc_check_mld(skb)) {
			netdev_dbg(amt->dev, "Invalid MLD\n");
			return true;
		}
	...
	} else {
		netdev_dbg(amt->dev, "Unsupported Protocol\n");
		return true;
	}
}

If a remote host completes a Request/Query exchange and sends a Membership
Update with a valid outer MAC, but the inner packet is truncated, uses an
unsupported protocol, or fails ip_mc_check_igmp() or ipv6_mc_check_mld(),
doesn't this still allocate a new tunnel entry in amt->tunnel_list (or refr=
esh
tunnel->last_seen on an existing tunnel) before dropping the packet?

Since saddr and sport are already snapshotted before iptunnel_pull_header(),
could amt_tunnel_get_or_create() and the tunnel->last_seen update be deferr=
ed
until after ip_mc_check_igmp() or ipv6_mc_check_mld() succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105125010.1107=
546-1-omar@blockcast.net?part=3D5
