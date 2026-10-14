Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB432264DB;
	Wed, 14 Oct 2026 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011284; cv=none; b=VkBbdx1gV0IWrahQY7UuubKOu/qHmVCMiPtRItAyH4LuvGRf+X1lW7GFZPcuZwCg8TJJI0Cl9qUvX2JV3LHz44WKPtjkZNHWkqO7E+1CAjEi4EqiGR10KcuKgWrV6G8AbhFSyBcoFDNd3iC/7ep7Cjf0InvkxE6b6xURp0LGK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011284; c=relaxed/simple;
	bh=9e0mQsG/wEc0Zpu2eLdaADpGRem0UDrhmVItnw7pkx4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nr65JuiuWctu2/mllVoPvHpXdpnlwdw2eNtm671Ro9O9ZaBpQx0AtuYSheygthq8NRpi6dchvJA4bcolfSR/pwMz38jM9t11e4P+7VTEZjxsxd+8dUzg40ntuwe4W5eQCW1nilxG5GQjMjGAxxi2II0I4J0oAFfxqjJ+WZlF5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj1b+9y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj1b+9y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE831F000C4;
	Wed, 14 Oct 2026 20:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011283;
	bh=hOKvf2BuGgn2g83SjppeWyUUE9tZVIPioO/Q2LehBQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dj1b+9y8gSkJXfHZbS0gLpY44j944eUT8bjhVQSuY5FMOdt9ukLVCJ1E30ey/pUcU
	 T1GBXfnzHoZw9/8SP2jU2csSqekxiAu3E7C39kW4lfyA3lwMVywD/I2ialEKpBQ1Nj
	 G116zhrF27F9GgiWz4lREA4C4n5YI5qdt8KwsjU3jZf4LSpcVEtiYKwKDyYkq9DKsF
	 vVU5+yDlmlZKKaH6Fcf7PxIK1Cz7trUgrQzOMPQZJgsrooKi/Q+Os9kbaFVm+tO8rs
	 a8NFDPghqBNX3ISLETO7Tv2xFIRDvhdhq3jAElWiSo3mtyIfK47XGdJ1rwPXnFlQkP
	 dF2wtvG8YS2JA==
Message-ID: <sashiko-outbox-171911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net: do not let defer_count outlive an empty
 defer_list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Kain" <jkain@nuro.ai>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261013205416.3417296-1-jkain@nuro.ai>
References: <20261013205416.3417296-1-jkain@nuro.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:54:42 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: skb_attempt_defer_free() counter underflow permanently disabl=
es deferral
--

commit df0f58555dfa5a46b25a9ac548d9384905fe6da3
Author: Joseph Kain <jkain@nuro.ai>

net: do not let defer_count outlive an empty defer_list

This commit addresses an issue where the skb deferral counter could outlive
the items in the defer_list. It undoes the increment on the reject path
and reorders the clear and drain operations during a flush to prevent
transient over-counts.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..a5912b728ddd7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -6940,8 +6940,11 @@ static void __skb_defer_free_flush(struct skb_defe=
r_node *sdn, int budget)
> =20
>  	if (llist_empty(&sdn->defer_list))
>  		return;
> -	atomic_long_set(&sdn->defer_count, 0);
>  	free_list =3D llist_del_all(&sdn->defer_list);
> +	/* Racy on purpose, as in __dev_xmit_skb(): a producer landing between
> +	 * the del_all and this store stays queued but uncounted.
> +	 */
> +	atomic_long_set(&sdn->defer_count, 0);

[Severity: High]
Could this unconditional zeroing wipe out the increments of producers that=
=20
are currently delayed on the reject path?

> =20
>  	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
>  		prefetch(next);

[ ... ]

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 41beaf625421a..e45e15506283b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -7392,8 +7392,13 @@ nodefer:	kfree_skb_napi_cache(skb);
>  	defer_max =3D READ_ONCE(net_hotdata.sysctl_skb_defer_max);
>  	defer_count =3D atomic_long_inc_return(&sdn->defer_count);
> =20
> -	if (defer_count >=3D defer_max)
> +	if (defer_count >=3D defer_max) {
> +		/* Undo, or the count outlives the skbs it was counting: the
> +		 * reject path never reaches kick_defer_list_purge() below.
> +		 */
> +		atomic_long_dec(&sdn->defer_count);
>  		goto nodefer;
> +	}

[Severity: High]
Can this decrement race with the flush and permanently disable deferral due=
=20
to a counter underflow?

If multiple producers concurrently increment the counter past the maximum,=
=20
they will all prepare to decrement. If a flush operation then runs on the=20
target CPU, empties the list, and unconditionally sets the counter to zero=
=20
in __skb_defer_free_flush(), the delayed producers will then execute this=20
decrement.

Because the counter is an unsigned long, this drops the value below zero=20
and wraps it to a very large number. The next time a producer attempts to=20
defer an SKB, the incremented count will still be above the maximum, so it=
=20
will be rejected without queuing. Since no SKBs are ever queued again, the=
=20
empty list check in __skb_defer_free_flush() remains true, causing future=20
flushes to return early and never recover the wrapped counter.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013205416.3417=
296-1-jkain@nuro.ai?part=3D1
