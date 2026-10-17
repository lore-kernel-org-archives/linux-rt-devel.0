Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC43CF026;
	Sat, 17 Oct 2026 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229696; cv=none; b=K2pnPC5Ux1caqnMAsNU5NA4gov2V+HONR9BzZADUj9Rys7w00DqrMkfLXMnZp3BttM11eKW+xCaRXMxH3wWBSACcLssSclpXFl87dc5EojrixlazCajaxMfdsK81kRiQEOJpn34ppzLV96Uz7VCGPnBEZGaRVzZOGigA3mxIGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229696; c=relaxed/simple;
	bh=MFdk1zAHWJclenfouoynz2RRlH2ImJFnnDDvgfyFU7w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BEyIOnhslpg6DVqHLhW1WuSPvJnNLgz8vGye8/N8brgHtNTLdzMlmm8idBVPc7zEMqUV/u740vM1TfpexVcpFJJbrt7ByJvoFSknBHhH/AviINipAiIoafSe3ZPig/QXHqk8hK5FaMrHBBFghe4y86rTbVcSTr0mlY/KpMWLtjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+fD41Sh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+fD41Sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8C31F000C4;
	Sat, 17 Oct 2026 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792229694;
	bh=LSM3Ycg2ENryDMbfHdhdbf2JBrNnnpGrgv1aIWSlqgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+fD41ShrJppQFe7K1RK9tZk8PIsMZ3bQKaN1Js7b9/K5Wpv4tgH1SH87gnMXoIZS
	 HKj6Bxbyn5s1BEH1tF+/8NX+HjwzOFv3UQ5v+/qxQTvsPg6QVpNPAKokIgT8ZzGEvw
	 63YAbuOy8GRHc6HnaO8I8FXv5HInI7se7AKnKiqCpKRBwCuUNPA29a4mS0Tcr1BpFF
	 8FcicJF68by/5szEWZVFOvYMI7RrG9By6M3JIPya16ZqFlyGPTI7Giq+MMGEchn7OV
	 /uNoUhdgbGTImKxH0i2kuzVVVUbKooSEBWBsnT/GN+GOIsuW0fydff3kpHyyPs3Hg2
	 RSn56E8CME9Rg==
Message-ID: <sashiko-outbox-175444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 6/8] net: xilinx: tsn: add the endpoint RX
 data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com>
 <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 09:34:53 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: out-of-bounds read of DMA metadata due to missing meta_len =
check
--

commit 0ae3124fbc7145cd6d9f2c1314d8d1defc3b13e2
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: add the endpoint RX data path

This commit adds the RX data path for the endpoint to start receiving frame=
s.
It posts RX buffers to the channels and handles inbound frames in a complet=
ion
callback. It also serialises the RX refill process against the interface
teardown.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index ab3d6d8cb9440..0a13e04d40575 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
[ ... ]
> @@ -112,6 +135,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int=
 idx)
>  	return xchan->skb_ring[idx];
>  }
> =20
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
                 ^^^^^^^^^^^

[Severity: Medium]
Could this result in an out-of-bounds read if the metadata array is too sma=
ll?

The driver gets the metadata pointer and its length via meta_len, but it on=
ly
validates the pointer using IS_ERR_OR_NULL(). There isn't a check to see if
meta_len is large enough before accessing metadata[1].

If the DMA hardware or backend driver provides fewer than 8 bytes of metada=
ta,
reading from metadata[1] might result in an out-of-bounds access. Should
there be a check that meta_len is at least 2 * sizeof(u32) before accessing
the array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-patches_v2=
_external-v3-0-e33d3960ca1e@amd.com?part=3D6
