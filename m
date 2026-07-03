Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC773D3CE4;
	Fri,  3 Jul 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083246; cv=none; b=EXj1aH3yz9CAWhNpTwekXnnv/svfrikhwX85a9J3blE4MkzyCZubyMoCM++SN3sYch+EMuriMQlLahsLhQ8xozy+7NykrV6i6oiH1ehn3fgSRghyi92B9ikf42nW7qCWQKKZiEGkzCwOc5g5JZceqRel8U4B8tGZo+153mmuej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083246; c=relaxed/simple;
	bh=I2s1+BdEaY7ClWplTaU/0/F7jeCt+XSUq7vTci3IUq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pTFTcHLQy5Ire4SQ43LQdhVGDVmSNZnFN/VLlzggfha5D6RvqKHrNDV4EswV27c+Uyzlg810A/13xnoAyfbBQIowgm7mDogv+m3/aZuF+46kzAlfyaEU1HMBsYHnQ+oj3RcRthHTDO7KaxtJgFukFZJmFTn9hbXi5w8ARvrgtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7d2Lc0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7d2Lc0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A451F00A3A;
	Fri,  3 Jul 2026 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783083242;
	bh=4/twTHUR42iBwV3cuMtVkVG6D7jVKHAK903m2lTYOgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7d2Lc0bpRWv+8sbztXvX6hkqtENVBLbp8ymayHniyd9s1p1jJ5d+KysgPBaDHqwa
	 ulzv2ZzbDoDMq5wDMobw/f2Z4X07EsyCS1q1StpSokddl+MMH95ND5KNznTUw2fdSM
	 E/APAUODqksEAJq7Nqw8Cx0zcywFWL2l0Xvycyop0VoTszhrTMT6CAzARnR/iH/chl
	 8EH8fzdJ84kCO0cQ2MT56cUJa+Unx/yC2FbJX2WYJ5dwqjiSDlVHlvTjDaE+yZmb+Q
	 oLyFRU6yLbnfe2f8HGlpdhgJWt50w5oXpjlqGbBzmw5d1XyZGgif084w+skV1YgJre
	 vjM+f9u1SzgBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/18] mm: Remove __alloc_pages_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260703-alloc-trylock-v5-13-c87b714e19d3@google.com>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-13-c87b714e19d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:54:01 +0000
Message-Id: <20260703125402.02A451F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch removes `__alloc_pages_node()` to fix CPU hotplug bu=
gs but completely misses the equivalent `__folio_alloc_node()` API, leaving=
 it exposed with the same `NUMA_NO_NODE` vulnerability.
--

commit 4b93237c4920d8046053a32bcd0656e3236e97c9
Author: Brendan Jackman <jackmanb@google.com>

mm: Remove __alloc_pages_node()

There were only a few users, which have been removed. The only advantage
of this API over alloc_pages_node() is avoiding a single conditional
branch.

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

[Severity: Critical]
This is a pre-existing issue, but does __folio_alloc_node_noprof() suffer
from the exact same NUMA_NO_NODE vulnerability that you're fixing here?

This function lacks the fallback safety check for NUMA_NO_NODE that
alloc_pages_node() provides.

For example, looking at svc_prepare_thread() in net/sunrpc/svc.c, it calls
__folio_alloc_node() using a node ID that can be derived from cpu_to_node():

net/sunrpc/svc.c:svc_prepare_thread() {
    ...
	rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
	if (!rqstp->rq_scratch_folio)
		goto out_enomem;
    ...
}

If a CPU hotplug event causes the node to be NUMA_NO_NODE, couldn't this
trigger the same out-of-bounds array access into NODE_DATA() and result in
the memory corruption mentioned in the commit message?

Should __folio_alloc_node() also be removed or replaced with a safe
folio_alloc_node() wrapper?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-alloc-tryl=
ock-v5-0-c87b714e19d3@google.com?part=3D13
