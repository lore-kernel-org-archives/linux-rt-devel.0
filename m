Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787171;
	b=EPRs+x7VVwz5vjWbJo/2G36kbEK3nFpY2UEHr3ThfTexL7Nd4NtSgV0taXt1IrKH6ctD
	 UvVc6HYW7lIWmTmzhm524puhEC0Ck3aG4TWbDl4v87xoIxgDVnOj5N9H0aCU+jICdZQjU
	 aijPnKappYNag50SwSpv01XIOhiM7cgz0/qAvbWeP7zLopdunC31XZGiywD/YBWRBGJhg
	 +8KejFSQHLNbbCZogqex1Hue5EsXwWicQ/7o7D047iU6hzjeRgWS2/ApX/ff1Uh7IHMra
	 1MWrwMZUnulusg9anpBuriGAMpjURSPR49k1UK4tBqGPJDQSY7TzgUA72J4aSAB8M1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787171;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xrboHXR9k3R5ZTIl0xnqUJBd88EpV7GBQtig56U+XN4=;
	b=mDj8+oIGpDYi6mwKxd4NO5qDv/NT7nlsRXaefe93tNDIbK0IcEx5qW5JakG3OnX1eCJf
	 J5ydZJCFfNHepGbFJ+8hfdbcR5XkxViF0VhOiogsSpygG06xx0/MwKgwWusre0nV0ykjY
	 5c6qiw91kKt2WC1694dhWIXQC4OgKBokUkYR/BbaAGU/QjTLMd4ZR/9+i4zkbQSxXCo13
	 JgSyU/59nei5Z3ZKkIdfHRiR2aUXg/bDm0aUwvsnX3HR3fSRKjb9CwRJ28kXuebFLgSDd
	 4zWZ1PmDtuU7crbdFQL5N24S4r1ghJWQzXpesAy26Hnmdv0RnngvfHa6LEBV8KSsN1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EuaFTw/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE917606A330;
	Fri, 27 Nov 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuaFTw/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C741F008A0;
	Fri, 27 Nov 2026 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787171;
	bh=xrboHXR9k3R5ZTIl0xnqUJBd88EpV7GBQtig56U+XN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EuaFTw/mGYQL2/05CbrkWyRgMBbiDWj9UOiQvddq3AJ4j7Hl5+Q47lP7dYEZ03YOx
	 NDSKg8yNY2xKeasTib39XKFEklavOkRFFfTbopUMPrttMM6QtuAOnFdRdTkqn2P9is
	 JP0I/KuMDAz/xJ5VePVHbwi7K1+7tdlSf/bmCbItxElk48g5JMziDEQaTGXMGCu06j
	 JcquGad4zOc1T+F8Cpgll0uA7Ww0dZgzUzJL4+VpSMJd6RTl0HBrBCXQ1/u3flZSRb
	 Fz08WMV9praCyjq8ScPS4/K5Ok05p6+e7r1dqUGvXVzXe0El9IX8/E63wiUVmoKpKM
	 unSZA90TldV8A==
Message-ID: <sashiko-outbox-237513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] mm/vmstat: decay pcp->high of isolated CPUs
 from vmstat_shepherd
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SW9udXQgTmVjaGl0YSAoV2luZCBSaXZlcik=?= <ionut.nechita@windriver.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Suren Baghdasaryan" <surenb@google.com>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Zi Yan" <ziy@nvidia.com>, "David
 Hildenbrand" <david@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Huang Ying" <ying.huang@linux.alibaba.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, "Frederic Weisbecker" <frederic@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev, ionut_n2001@yahoo.com, sunlightlinux@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261126134410.17447-2-ionut.nechita@windriver.com>
References: <20261126134410.17447-1-ionut.nechita@windriver.com>
 <20261126134410.17447-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:46:09 +0000
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
- [Medium] mm: stale drain count and extra lock bounce in
  decay_pcp_high()
- [Low] mm: data race on pcp->high_min and pcp->batch in
  decay_pcp_high()
--

commit d20e26af9bbff82ca7f7d0c2d4fea5dc5d2bd609
Author: Ionut Nechita <ionut.nechita@windriver.com>

mm/vmstat: decay pcp->high of isolated CPUs from vmstat_shepherd

This commit makes vmstat_shepherd() remotely decay pcp->high and drain
excess per-CPU pages for isolated CPUs, acquiring pcp->lock while
adjusting pcp->high in decay_pcp_high().

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ce44b8fc45aaf..aa9904eaf6e62 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2586,8 +2586,13 @@ bool decay_pcp_high(struct zone *zone, struct per_=
cpu_pages *pcp)
>  	int high_min, to_drain, to_drain_batched, batch;
>  	bool todo =3D false;
> =20
> -	high_min =3D READ_ONCE(pcp->high_min);
> -	batch =3D READ_ONCE(pcp->batch);
> +	/*
> +	 * pcp->lock is taken because the pageset may belong to a remote CPU,
> +	 * see decay_pcp_high_cpu().
> +	 */
> +	pcp_spin_lock_nopin(pcp);
> +	high_min =3D pcp->high_min;
> +	batch =3D pcp->batch;

[Severity: Low]
Should pcp->high_min and pcp->batch still be read with READ_ONCE() here?

pageset_update() updates pcp->batch and pcp->high_min with WRITE_ONCE()
under pcp_batch_high_lock without taking pcp->lock, so plain loads can
data race and allow the compiler to reload them across the comparisons
and max3() / min() calls below.

>  	/*
>  	 * Decrease pcp->high periodically to try to free possible
>  	 * idle PCP pages.  And, avoid to free too many pages to
> @@ -2601,6 +2606,7 @@ bool decay_pcp_high(struct zone *zone, struct per_c=
pu_pages *pcp)
>  	}
> =20
>  	to_drain =3D pcp->count - pcp->high;
> +	pcp_spin_unlock_nopin(pcp);
>  	while (to_drain > 0) {
>  		to_drain_batched =3D min(to_drain, batch);
>  		pcp_spin_lock_nopin(pcp);

[Severity: Medium]
Can dropping pcp->lock before and between drain batches without
rechecking pcp->count - pcp->high over-drain the remote PCP list and
spin on pcp->lock and zone->lock?

When decay_pcp_high() runs remotely from vmstat_shepherd(), the isolated
CPU can allocate from PCP or drain its own PCP list in
free_frozen_page_commit() while pcp->lock is dropped.  Because the loop
keeps draining the stale to_drain count rather than re-evaluating
pcp->count - pcp->high under pcp->lock, it can drain the isolated CPU's
PCP cache down to 0, well below pcp->high:

CPU0 (vmstat_shepherd)            CPU1 (isolated)
decay_pcp_high_cpu(1)
  decay_pcp_high(zone, pcp)
    pcp_spin_lock_nopin(pcp)
    pcp->high =3D ...
    to_drain =3D pcp->count - pcp->high
    pcp_spin_unlock_nopin(pcp)
                                  rmqueue_pcplist() / free_frozen_page_comm=
it()
                                    /* lowers pcp->count to <=3D pcp->high =
*/
    while (to_drain > 0)
      pcp_spin_lock_nopin(pcp)
      free_pcppages_bulk(...)     <-- drains below pcp->high, down to 0
      pcp_spin_unlock_nopin(pcp)

Once pcp->count reaches 0 with to_drain > 0 remaining, the loop keeps
running every remaining batch iteration, taking the remote pcp->lock and
calling free_pcppages_bulk(), which unconditionally disables IRQs and
takes zone->lock even when count is clamped to 0.  Also, unlocking
pcp->lock right before the loop and immediately re-locking it for the
first batch adds an extra remote lock bounce when to_drain > 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126134410.1744=
7-1-ionut.nechita@windriver.com?part=3D1
