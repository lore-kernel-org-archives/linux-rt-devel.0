Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB03B8945;
	Wed,  9 Sep 2026 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981671; cv=none; b=QJtc7ATnyea8ggcFUHH+6UKwEcXi0TqGb2eNLkAFCbhVQRUV34K5ML4AWRUqybQOWx9LgbaxnWRxW1WsJCKTA6ffVfDnJ02II1DlHJx/xKXgFzgtdUqK42aWsFXWRts7/c2eMCsqcdCcafIqVbU22kYijedK+I5GqA1dFJcFEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981671; c=relaxed/simple;
	bh=VKUdjhGaBjpAa67ef1Uo4yhXuN8XeSzLQkiKiMjWsHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WSnh8g5+p0XZNZYsEeID3n4HmWuNZArb8OySeUBwwNQXF8y2E9xFuA4w46wSMigAMKGyk3VbptFlaDayuPY/o6Tm8tKZUMwmMajI1og0UitiDWnlQhKG+OdmFiXha0RkZU6yhhF6lkgmoANDxUwyZXLvTenUTnaxksWS12bZvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz655EUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz655EUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294661F000FF;
	Wed,  9 Sep 2026 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981669;
	bh=M2nswE3qSbG9TCkaxssyQdz0iLobRd4wbX0aL90sGYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kz655EUagB+8c6/LMhj9HwtRvqdaSqblRUuPbZkIEa+fRUJXpcjT1Y6+oNfUjU83+
	 rMv7+F35dBG/HhfbW4sd1dHWpMPvV+9TqupO85MLLHt2aWCgwch4J5lTil8WC9nlTF
	 AjE+3ctHy4ngo5VnzjGcaG0OJqiyOnFZTJjhZSQx48Ay05wj4pTHVVyjitzuJNEpLL
	 7nSvaGp5Rw07hc4ie6k0BJs725w+p0AzaTbQ+DLa+oMkoh0+VFjDxvq07DOLHThVIR
	 TYdocJAk7xgRcdl6Ls3tbjuG4UNrRe848q9ymU5f4dR7ekDOi1lRNkbG7yIhhQQd3E
	 pe5zsO+8TS8QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/8] net: xilinx: tsn: add the endpoint RX
 data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
 <20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:21:08 +0000
Message-Id: <20260909192109.294661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The return value of dmaengine_submit() is ignored in the RX path, =
leading to permanent RX ring desynchronization and data corruption if submi=
ssion fails.
- [Medium] Out-of-bounds read of DMA descriptor metadata due to missing len=
gth validation.
--

commit 5fd8b30c57440a41e4ad90bda57e202d89a1aa7b
Author: Srinivas Neeli <srinivas.neeli@amd.com>
Subject: net: xilinx: tsn: add the endpoint RX data path

This commit adds the RX data path for the Xilinx TSN endpoint, allowing it =
to
receive frames. It posts RX buffers to each channel upon opening and reaps
them via a completion callback, serializing the refill against teardown.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 23a15df71baad..9ed1170794e03 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -113,6 +132,174 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int=
 idx)
>  	return xchan->skb_ring[idx];
>  }
> =20
> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *resu=
lt);
> +
> +static int ep_rx_submit_desc(struct xlnx_tsn_ep_dma_chan *xchan)
> +{

[ ... ]

> +	skbuf_dma->skb =3D skb;
> +	skbuf_dma->dma_address =3D sg_dma_address(skbuf_dma->sgl);
> +	skbuf_dma->desc =3D dma_rx_desc;
> +	dma_rx_desc->callback_param =3D xchan;
> +	dma_rx_desc->callback_result =3D ep_dma_rx_cb;
> +	xchan->ring_head++;
> +	dmaengine_submit(dma_rx_desc);
> +
> +	return 0;

[Severity: High]
Does this code ignore the return value of dmaengine_submit() in the RX path?

If dmaengine_submit() fails and returns an error cookie (e.g., due to an
exhausted DMA descriptor pool), the hardware will not receive the descripto=
r.
However, because the software pre-increments xchan->ring_head and ignores
the error, it assumes the descriptor is safely armed.

When the next successful descriptor completes, the software will read from
xchan->ring_tail, mistakenly unmapping and passing the SKB of the failed
descriptor to the network stack. Could this lead to passing uninitialized
kernel memory up the network stack and shifting all subsequent packet paylo=
ads
by one descriptor?

[ ... ]

> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *resu=
lt)
> +{

[ ... ]

> +	metadata =3D dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
> +						   &meta_len,
> +						   &meta_max_len);
> +	if (IS_ERR_OR_NULL(metadata)) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		DEV_STATS_INC(ndev, rx_errors);
> +		goto submit_new;
> +	}
> +
> +	/* MCDMA metadata: [0] =3D status, [1] =3D sideband (TID/TDEST/TUSER), =
[2..] =3D app */
> +	tuser =3D metadata[1] & TSN_TUSER_MASK;

[Severity: Medium]
Is it possible for the DMA driver to return a valid metadata pointer with a
short payload where meta_len is less than 8 bytes (2 words)?

If meta_len does not cover metadata[1], this access could result in an
out-of-bounds memory read. Does this code need to verify that meta_len is
large enough before accessing metadata[1]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-patches_v2=
_external-v2-0-3a40babaff4c@amd.com?part=3D6
