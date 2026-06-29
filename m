Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CD3F65F9;
	Mon, 29 Jun 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743363; cv=none; b=QaQvb4HAks+RQcSoaqhZT5vYMRPMWSGD8O+YGkcRTZa4oj1Vfgd1zJqkWnoPLzonyxzb2HFADm0ddVkk8Hnt8tcq24wye9N+y4kuwmUXOWCQby45WF2AQ2NaR+2UxDsVmzwikacBBMUvb89EY7cFrp0rjcaIpTKVJmc42IASClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743363; c=relaxed/simple;
	bh=HbWU92cyjG+qiRS1BMKITAQ7lUuuT3+M8u3cw57ZP5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j8hs8D8+0V4aPlPFy9RB91y9NkdsD4EjL37ZiL5OsNuVxJarWr0/vYF8Q2hxv+H5lCpmdTNsQhi0CNuhrIsHySAVXcVH8i7HWixTMqEetog8ggN086KWZnl9eY16QQfIoZKB7Ca3TEY3TpWk1E1yVQIgu2AKXaLq1yyIZAguULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVVJt//m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVVJt//m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A05A1F000E9;
	Mon, 29 Jun 2026 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782743361;
	bh=5NpQqB4yWPI/PhniaTOgRTc1HIXcRhm2V/Yjt/cHFE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVVJt//m50V/RihkHcOCCJUQS/L8SasKiN7a2VGINOCCjGxKEIuHR1MONvvi7i0UO
	 X7/BSHPyGCkwq3+PuXbd6YEEwyeUL8Z6MuoIFAbOUEDhjbsJ1vq8umpDlSysa7ABfN
	 qA92O+CFvykUvUp2CowbVkNyRS7Em+wHXreLVP0nxHdXw8nLb44tDqh4+MEWvhdhbY
	 4zIHSRI1R+BlF4Mj2l+QnJeKfFqKoU5YlqWnd3iuiDL614xd+vJaDiHeh5BDw5banU
	 JLhqe7DwMLLY2TETCpHEPRz/xfb/asTb+RSbbC7KVp2Np43gc7EkM9WXG6dYtWNlmC
	 I7ITaXkr4/j6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:29:20 +0000
Message-Id: <20260629142921.9A05A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spurious allocation failures for ALLOC_NOLOCK on fragmented systems
--

commit e9001ddaf8c952ebe08e5042f720b09e0b4a5da8
Author: Brendan Jackman <jackmanb@google.com>

mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()

This commit unifies the core allocator entry points by pulling the ALLOC_NO=
LOCK
control up into __alloc_frozen_pages_noprof(). It turns the nolock variant
into a thin wrapper that just sets the ALLOC_NOLOCK flag and handles
NUMA_NO_NODE.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a3ba63c7f9199..8d409d075e3e9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c

[ ... ]

> @@ -5310,9 +5384,9 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp,=
 unsigned int order,
>  	fastpath_alloc_flags |=3D alloc_flags_nofragment(zonelist_zone(ac.prefe=
rred_zoneref), gfp);
>  	fastpath_alloc_flags |=3D alloc_flags_nonblocking(gfp, order) & ALLOC_H=
IGHATOMIC;
> =20
> -	/* First allocation attempt */
> +	/* First allocation attempt (or, for nolock, only attempt) */
>  	page =3D get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags,=
 &ac);
> -	if (likely(page))
> +	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
>  		goto out;

[Severity: High]
Could this lead to spurious allocation failures for ALLOC_NOLOCK requests
on fragmented systems?

In the pre-patch code, alloc_frozen_pages_nolock_noprof() bypassed
alloc_flags_nofragment(), allowing it to successfully steal pages from
other migratetypes when its preferred migratetype was empty.

The new unified __alloc_frozen_pages_noprof() fastpath unconditionally
applies the ALLOC_NOFRAGMENT policy to fastpath_alloc_flags. When the
requested migratetype is empty, __rmqueue() respects this flag by
skipping __rmqueue_steal() and returning NULL.

Since normal allocations fall back to the slowpath (which clears
ALLOC_NOFRAGMENT and retries), they succeed. However, ALLOC_NOLOCK
explicitly bails out after the first attempt here, permanently failing the
allocation. This might cause systems using bpf or tracing facilities under
memory fragmentation to silently drop allocations when hit from atomic
contexts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-alloc-tryl=
ock-v3-0-57bef0eadbc2@google.com?part=3D5
