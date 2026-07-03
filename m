Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092B204C3B;
	Fri,  3 Jul 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083187; cv=none; b=OVEp6Adv002gDgdHMjt7Qx2P8PGPbm4O61JKkxyPibVHm0GkDKbUCLBUaqth2XPIZ5+f4ck5tycYrFksWicPZyKUMKRQ8//fa5y4c6Sa8zLxXLw9+sL1B+E9vvunlWuOo6xgyNSr1GpuTWWBpH1dTyxANb14YeqZZWgBS3T6N38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083187; c=relaxed/simple;
	bh=BYljrirWnURvUjBiKOB04kccUuxtwuupinsqjTSgbfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3XQC1k9VgJKtb8ZXuoQQZPrCdUEceGUogw3DyPWVS7p8ZwR4CiZqLTWwrfRSYyER1Lr6mYvDksXLJ0PQ1w6uwQu6xRwseJBjmjhqOaJAL2YKuCgXAloE09r6Ek7IOUcy0DzwwP2mJKjc67xJ/PGA3xMshcX/COAqiRMnzNUACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhj33sD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhj33sD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E21F000E9;
	Fri,  3 Jul 2026 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783083185;
	bh=wpuvbnT6EDj0E59O0GtyDHhHOp/2JrQfxJX1YeEjI2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xhj33sD/pNQ1hCQK2BCS68EvtLMTDsPzobx6g3HwSev5tkNkqaOQ5xLhDTylRn025
	 yuVVdimUC49eyvEl5k2vgAdNewTqSySkHbqxBfbcQ+GjLbUkkeOqfvlmLzT5rvYwg9
	 TbdW9hdCTipM/usaZAGWRheQts1aOTxSDTGABkq/pYl7hugib8XjMwfiT9Dv/sLEoL
	 Dt6umVfk/voFu1JKJ02PXWoUSUzFJwFB9JnUvt98jqZh525uHmnbgvy/9qWosqqUh8
	 cKbOFX3+BLmpKnqihYMPLapBOtQMOKO6+fpRldHNX2ASfdzP7LzdTDgpj3TMUUkRV1
	 1EIgt+Fuh4YNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/18] net/funeth: Switch to higher-level allocator
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260703-alloc-trylock-v5-12-c87b714e19d3@google.com>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-12-c87b714e19d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:53:05 +0000
Message-Id: <20260703125305.7B7E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Untrusted packet length from hardware CQE leads to stack buffe=
r overflow and OOB memory corruption.
--

commit fd0faaa7ff432d936af6fe6e5da6c09cbf2f16eb
Author: Brendan Jackman <jackmanb@google.com>

net/funeth: Switch to higher-level allocator API

This commit replaces the deprecated __alloc_pages_node() with
alloc_pages_node(). The new API supports passing NUMA_NO_NODE. No functional
changes are intended by this switch.

> diff --git a/drivers/net/ethernet/fungible/funeth/funeth_rx.c b/drivers/n=
et/ethernet/fungible/funeth/funeth_rx.c
> index 7e2584895de39..d7000017ac2bd 100644
> --- a/drivers/net/ethernet/fungible/funeth/funeth_rx.c
> +++ b/drivers/net/ethernet/fungible/funeth/funeth_rx.c
> @@ -103,7 +103,7 @@ static int funeth_alloc_page(struct funeth_rxq *q, st=
ruct funeth_rxbuf *rb,
>  	if (cache_get(q, rb))
>  		return 0;
> =20
> -	p =3D __alloc_pages_node(node, gfp | __GFP_NOWARN, 0);
> +	p =3D alloc_pages_node(node, gfp | __GFP_NOWARN, 0);

[Severity: Critical]
This is a pre-existing issue, but while reviewing this file I noticed a
potential stack buffer overflow when handling untrusted packet lengths
from the hardware CQE.

In fun_handle_cqe_pkt(), the untrusted packet length and fragment count
are read from the CQE:

    unsigned int i, tot_len, pkt_len =3D be32_to_cpu(rxreq->pkt_len);
    ...
    tot_len =3D pkt_len;
    ...
    ref_ok =3D fun_gather_pkt(q, tot_len, frags);
    ...
    skb =3D napi_build_skb(va, ALIGN(tot_len, FUN_EPRQ_PKT_ALIGN));
    ...
    si->nr_frags =3D rxreq->nsgl;
    for (i =3D 0; i < si->nr_frags; i++)
        si->frags[i] =3D frags[i];

Does the loop in fun_gather_pkt() iterate until tot_len is exhausted without
validating the size?

    for (;;) {
        ...
        skb_frag_fill_page_desc(frags++, buf->page, q->buf_offset, frag_len=
);
        tot_len -=3D frag_len;
        if (!tot_len)
            break;
    }

If rxreq->pkt_len is maliciously large, could this increment the frags array
pointer past the bounds of the stack-allocated frags array (size 4),
resulting in a stack buffer overflow?

Furthermore, could napi_build_skb() use this untrusted length to place
skb_shared_info at an out-of-bounds offset, corrupting unrelated memory?

>  	if (unlikely(!p))
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-alloc-tryl=
ock-v5-0-c87b714e19d3@google.com?part=3D12
