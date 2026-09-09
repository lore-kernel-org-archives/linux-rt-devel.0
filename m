Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA03B774B;
	Wed,  9 Sep 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981673; cv=none; b=lQwEYuOnAQ1/MbT11Brf8aTgZEtqWSr3XN92CY7kAo93HBRmqHAxUskzi6TgiefeQuvEj3bM6QRj6oJthX2fao2DbbSoKC4qiB+ML1CKZnr6xPBqR8DBkd77JJS/1B5gffRNQABP//5Z3+6xB7NaktVnlVvHykZqXN2Ht5y0JAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981673; c=relaxed/simple;
	bh=FnOmKp8lWp4Nwz5Our/7BQIbTjDwUHB6OqKZnUeKN8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F4OZEAg/g2YsLBTV7RzJ9P2R1UKQAyg7jGSTu/Q8UblgOa0hVXj4aJaAhPnyEAG9Zco4KYtJimoY1zYlhQH58Fqskrh+8LFlKGUvyh+ogblCH1jr1Poc9w5CMJNcc9h9QoE1KkxO5B5oumSO0ml3RbI2Hs28msxgqlEUy7e0128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICA4k5Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICA4k5Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542A81F000FF;
	Wed,  9 Sep 2026 19:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981671;
	bh=GGxKEZTqr82EcGuC2dWFD6B1GTuAj4Hlrhe/WtwmRK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ICA4k5ZaQ/OI54YJnC+tFzFATlfJ5w0E4dKZp8KEnwYNywLbkPt3hBHnVBiz48KXw
	 gbxcT+dqOtHTiSOKAqjX3eRJazUUpuKeoa58vla+iUv0yHdkScr7dpWe4GQyIYz75c
	 fvDuyM8nKMU/bZwztEd93o7OwM/i669ifXWoZxszRg6+JHBY9YFHzd0BRfYEN/dkYP
	 ZK+ASyoz1Nqsvnh6esU3cqrIROEmkNqYEHFFr5hwfT/CDEhSCk+D46k0aTP3g0xDwJ
	 bjHp2zCvQjwwNv7j7aDiFBPofXKX+Zg3v1nlfu93AdsIcvI+E8L0kYnWeorr4xjOp5
	 /tWUN2UAr8FqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 7/8] net: xilinx: tsn: add the endpoint TX
 data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260909-patches_v2_external-v2-7-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
 <20260909-patches_v2_external-v2-7-3a40babaff4c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:21:10 +0000
Message-Id: <20260909192111.542A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect SKB free function used for dropped packets on DMA erro=
r.
--

commit dba43ed8ae5a63ef3cc1b455fd12d3567126babd
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: add the endpoint TX data path

Add the transmit path so the endpoint can send frames. Look up the physical
DMA channel for the frame's queue through the map built at probe, map the
frame and submit it to that channel. Stop the queue when the ring runs out
of space, and wake it from the completion callback once a slot frees up.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 9ed1170794e03..9e9a45169681f 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
[ ... ]
> @@ -300,8 +304,147 @@ static void ep_dma_rx_cb(void *data, const struct d=
maengine_result *result)
[ ... ]
> +static void ep_dma_tx_cb(void *data, const struct dmaengine_result *resu=
lt)
> +{
[ ... ]
> +	if (unlikely(result->result !=3D DMA_TRANS_NOERROR)) {
> +		DEV_STATS_INC(ndev, tx_errors);
> +	} else {
> +		DEV_STATS_INC(ndev, tx_packets);
> +		DEV_STATS_ADD(ndev, tx_bytes, len);
> +	}
> +
> +	dev_consume_skb_any(skb);

[Severity: Medium]
Does this code use the correct SKB free function on the error path?

When the DMA transmission fails (result->result !=3D DMA_TRANS_NOERROR) in
ep_dma_tx_cb() inside drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c, the
packet is effectively dropped. However, dev_consume_skb_any() is used here
unconditionally.

Tracing tools like dropwatch rely on dev_kfree_skb_any() to distinguish
dropped packets from successfully transmitted ones (which use
dev_consume_skb_any()). Calling dev_consume_skb_any() on the error path
will cause these drops to be incorrectly reported as successful transmissio=
ns.

Should the error path use dev_kfree_skb_any() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-patches_v2=
_external-v2-0-3a40babaff4c@amd.com?part=3D7
