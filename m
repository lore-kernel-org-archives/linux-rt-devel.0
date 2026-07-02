Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41F357CE1;
	Thu,  2 Jul 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990665; cv=none; b=ns5FI0wl4AAwwC0nXzsJe0X9moKMsTGm0G/V1Hvpl7IuUL46REzdPYoUDy5c8Kixkwg/pC9rQG+iL2woHjkFQWEGZVzZDXVz3eTxkTwvTzUKdkVDXqb0crPb3jtAXKHr5ZkwLYgISeBJu/DmhSQtbS9vK8xhEANdj1HcyYBkG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990665; c=relaxed/simple;
	bh=9KX6d/K9WySjZ0HUxbJNcvfWHbUezYJzIZlOQex6LpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZYJGtGFL2zeqrjyau6oORiRnxYHA+XfNuig+/n9ceZbqvBg3gi7E6sEOkSZZ7rtIjFmwkjOKzXDUQ3xQbgmcmURLLzYKqVAk9SZcSvF2B8qjMJDs5XD1uuTUtAQWEI9CN0qxtRsjbqFrCeUhQ6ASJMFacUibCyQ4MSYgv5eQt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUvcQzLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUvcQzLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2B41F000E9;
	Thu,  2 Jul 2026 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782990664;
	bh=Xex+nNy3u5ryRLr2RWPR4ACFzZVdPc5n0VbsFZnJa+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUvcQzLeY180uCdMpiAh9e/xvpcEdR5cVbqpchn4nS018SAuwk4egyWX0vw15dFiR
	 mSzQQmgkuUDNehxQq86kBDh5djG5DlpqWEB2mq6LdeRM4BeHDwh2cdG8VN6sFI+q3w
	 vYLqeeOXn8R/mXDjQKEjqQowR8GmT7sd3hE9GuQ9KfDWdb65heHJ1UdAJB+XgDwW5l
	 og9MyWDJOjwirSuXJ3ESnDpIq+IZmQqPm5HN2XLCGetonoZ8bfHwCPlsgwbksD0ZvP
	 qM4mR/ChWU/lXDRqaO8iQmIu1y4kdc12MdVGJDuxzUoYekcTuEJf2SyfL0KwCJ6ZfV
	 JPFSy0+IbZ0Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/18] mm: Remove __alloc_pages_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260702-alloc-trylock-v4-13-0af8ff387e80@google.com>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-13-0af8ff387e80@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 11:11:03 +0000
Message-Id: <20260702111103.DD2B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch removes `__alloc_pages_node` because it is unsafe to use=
 with `cpu_to_node()`, which can return `NUMA_NO_NODE` (-1) during CPU hotp=
lug, but leaves the equivalent `__folio_alloc_node` untouched, which suffer=
s from the exact same vulnerability.
--

commit 584eaae6f16d0eb43140d0b202665ffc9212c61e
Author: Brendan Jackman <jackmanb@google.com>

mm: Remove __alloc_pages_node()

This commit removes __alloc_pages_node() since it is prone to memory
corruption on CPU hotplug if callers pass NUMA_NO_NODE from cpu_to_node().
Removing it leaves the __* variants strictly for internal memory management.

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
This isn't a bug introduced by this patch, but does __folio_alloc_node_nopr=
of()
suffer from the exact same vulnerability that motivated removing
__alloc_pages_node_noprof()?

If NUMA_NO_NODE (-1) is passed here, it triggers VM_BUG_ON(nid < 0) or bypa=
sses
it in non-debug builds, leading to out-of-bounds array accesses when evalua=
ting
warn_if_node_offline() and NODE_DATA(-1).

Looking at net/sunrpc/svc.c, there is a path that passes the result of
cpu_to_node() directly to __folio_alloc_node() without checking for
NUMA_NO_NODE:

net/sunrpc/svc.c:svc_prepare_thread() {
    ...
    node =3D svc_pool_map_get_node(pool->sp_id);
    rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
    ...
}

During concurrent CPU hotplug, svc_pool_map_get_node() can return NUMA_NO_N=
ODE.
Should __folio_alloc_node() be removed or fixed in this patch as well to fu=
lly
eliminate this class of bug?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-alloc-tryl=
ock-v4-0-0af8ff387e80@google.com?part=3D13
