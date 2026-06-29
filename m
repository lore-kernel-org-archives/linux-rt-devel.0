Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AB37AA72;
	Mon, 29 Jun 2026 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746842; cv=none; b=aqBXPzIacwmJUpYa40TwqGmxsWLaTyXcHlol3oO3VI/JS3N8YJlGJmx+M1n/Xg2O2xf2i5b9zC7i7urYtj99JQk/EEuNAlaJnSGVRNCfCyxjHyO6/J13qKZNwcaLxbijz4/bGDt0IaD4fwlOowfw5ThbQua28UpCbEGiwapFgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746842; c=relaxed/simple;
	bh=2hQNGj1aXGW/OCEc98XkM0gjOh4Bb2gQ0EDQwD9T1SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s/gDnywGRLoB4wuUKtYrK5PHdNIFUMnQMsypC0kyTVx8BGRKyf/JZdPZ51NL9XWJcw9qgCo47yo/P1AaB9Z+ipQQsDUyyQR0TQsp1gAkss/H3ChhSqswZW++JJENE/kicLnzkPqHM8paZIW/bO5vYW4ZksyLMXAhU4raBmPU+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDV3CALz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDV3CALz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAA61F000E9;
	Mon, 29 Jun 2026 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782746840;
	bh=wxMOiv9hsdjOpHZZ8xpEKynGCH46gFbfAVdgAlzGNfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDV3CALzPaIGtTnKhKNQlXRHr3bXWf/ds8PjUk1H/XF0LeLPFlvkKNALlGodsY1YU
	 9xgXikBFkUG7Kso5e1bN/93a/SB2w8pVjvT6/gaXNXVYUdW4+l/SGAQvJX2tYzBvm8
	 cO/p78QAwZKLiySf5T1r9/ECzEdo2ct28oLJVtV/EoVWRGxEn89dB41N58Ry7Uljja
	 UyGKr6DQeT3AplrO2jercdy/BXJG9ScnftlqMRIQRu8z3NVJvPAdXsGUvsTCvyfirq
	 k7Z0bOXA3jhPdVl00Uy2y3TMSjK7RciJpZm2AFnt6nY4fvyXGBXBgLuVv/F0AWRT3t
	 Bupb4JrVp3ZZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/16] mm: Remove __alloc_pages_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260629-alloc-trylock-v3-13-57bef0eadbc2@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-13-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:27:20 +0000
Message-Id: <20260629152720.8FAA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete API refactoring leaves `__folio_alloc_node()` and its e=
xternal callers vulnerable to the CPU hotplug hazard the patch intends to f=
ix.
--

commit 1c3f10897a9f9fbcd231ced2981c00e238f22315
Author: Brendan Jackman <jackmanb@google.com>

mm: Remove __alloc_pages_node()

This commit removes the __alloc_pages_node() API to reduce the API
surface and prevent issues where callers using cpu_to_node() pass
NUMA_NO_NODE during CPU hotplug, leading to memory corruption or panics.

> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 01d6d2591f49e..3bf55a5f9143e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
[ ... ]
> @@ -256,21 +256,6 @@ static inline void warn_if_node_offline(int this_nod=
e, gfp_t gfp_mask)
>  	dump_stack();
>  }
> =20
> -/*
> - * Allocate pages, preferring the node given as nid. The node must be va=
lid and
> - * online. For more general interface, see alloc_pages_node().
> - */
> -static inline struct page *
> -__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
> -{
> -	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> -	warn_if_node_offline(nid, gfp_mask);
> -
> -	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> -}
> -
> -#define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_noprof(=
__VA_ARGS__))
> -
>  static inline
>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, i=
nt nid)
>  {

[Severity: High]
This is a pre-existing issue, but does __folio_alloc_node_noprof() and its=
=20
wrappers need the same treatment?

I noticed it still lacks the NUMA_NO_NODE fallback, which can be triggered =
by=20
existing external callers. For instance, in net/sunrpc/svc.c,=20
svc_pool_map_get_node() uses cpu_to_node(), which can return NUMA_NO_NODE (=
-1)=20
during CPU hotplug:

net/sunrpc/svc.c:svc_pool_map_get_node() {
    ...
    if (m->mode =3D=3D SVC_POOL_PERCPU)
        return cpu_to_node(m->pool_to[pidx]);
    ...
}

This returned node ID is then passed directly to __folio_alloc_node() in=20
svc_prepare_thread():

net/sunrpc/svc.c:svc_prepare_thread() {
    ...
    rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
    if (!rqstp->rq_scratch_folio)
        goto out_enomem;
    ...
}

Could this trigger the same VM_BUG_ON(nid < 0) or out-of-bounds array acces=
s=20
that this commit aims to resolve?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-alloc-tryl=
ock-v3-0-57bef0eadbc2@google.com?part=3D13
