Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6A3A450F;
	Mon, 22 Jun 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123458; cv=none; b=AKzeggiK7EWtEZmECE+aIYvrlbYw6amgmPkgiydJt6SJGdWPqclae/myKh9Bx5LsaVpU2V71bm07Df6ZLnmLekZusUENPZJxrDHrfpvgoRMaZN7VrUOMBKhpIGTbBxDn+UozpQoZOLM9nWBARBRr/NDokbVkAuXLTCX64QZfu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123458; c=relaxed/simple;
	bh=Vw6BfeYyvf6eUwbT8igYPaCYmGPI2FlRoZCU9r3Pg40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBfmFl7qzfX6OqWqYDtZTSXjMFLmFY8xA7YFCuANezGxoiiu/3cXD98DEuBIiujBN8c7AE5M0BR3cOv9F8n3ZNi2SwkZ7Yw5uO9VCDXmWzdt+ylxAd+8Qq+jhLvWPlot0xfJLW/65DyZ4J5RVYY+XOiHCDPnWSDPMfP0f8TljoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxf2WCHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxf2WCHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F31F000E9;
	Mon, 22 Jun 2026 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123456;
	bh=PxVOFvaUNWSN8nJiXnsY6BoT/vVAVHqhABumdt4ajMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxf2WCHng+YB6jb9CRoMwEwCNpFUlxQQ+i1+Cf1ZzAgVLwCJGB5//ut3SH0z7i6Zu
	 iR75xJUVqZ6oQSbFmzEJi0nVHhlh763qcbo//qDjvQhBj8Y57eKK4zoAgzxdkWguaN
	 cMb8fMYwlH1a635L8GX7Zl3AseJ7QtRpjRZtVixBiltqsBI+HR/qOADyRBJHV9r2UR
	 p0+oSLFwLSdbJHBh71bwfG6MRktHJmyYR3XMxpzgmT7kFSRMMxColLmHHEOf/AtwJa
	 HjGa6vFxxEcjE//frvN9hB+s2UgODnqkgMr00PcvgXX5OaVAn+3W1WBpAPWRJqGqJL
	 m8YwMzxO7tMAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] mm: Remove __alloc_pages_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260622-alloc-trylock-v2-10-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-10-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:17:36 +0000
Message-Id: <20260622101736.961F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch leaves `__folio_alloc_node()` exposed to the exact same =
CPU hotplug out-of-bounds vulnerability that justified the removal of `__al=
loc_pages_node()`.
--

commit b690a6726aee701f88a87b35d2db8bfbfa39bc05
Author: Brendan Jackman <jackmanb@google.com>

mm: Remove __alloc_pages_node()

This patch removes __alloc_pages_node() because its usage with cpu_to_node()
can return NUMA_NO_NODE during CPU hotplug, bypassing validation and causing
out-of-bounds accesses on NODE_DATA().

> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index cdf95a9f0b87c..7edcc2e0be9ce 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -278,21 +278,6 @@ static inline void warn_if_node_offline(int this_nod=
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
This isn't a bug introduced by this patch, but does leaving
__folio_alloc_node_noprof() exposed maintain the exact same CPU hotplug
vulnerability that justified removing __alloc_pages_node()?

The commit message notes that passing the result of cpu_to_node() to the
allocator can yield NUMA_NO_NODE if the CPU is hotplugged out, which
bypasses validation and causes out-of-bounds accesses on NODE_DATA().

Can this still happen with __folio_alloc_node()? For example, in
net/sunrpc/svc.c, svc_prepare_thread() calls:

rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);

with a potentially invalid node ID originating from cpu_to_node(). Should
__folio_alloc_node() also be removed or updated to safely handle
NUMA_NO_NODE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D10
