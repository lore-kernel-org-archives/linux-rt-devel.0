Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07F3AE71C;
	Wed,  9 Sep 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981672; cv=none; b=T0Mrtk+irVH+CpNfLKE2oBsoAkw2PybxT+XGdHl88CGvDSewRsY7IgTo/RLLKDoNDu9+5u+4nLYWo2jHIysND99zxZSxecnVZhIJzMdZdv38pgG3kJMV1ClgHRJhwTUBLIsZcyMskcDu1jUYo1d/MTAKxnWNX5GfdDnrin7p4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981672; c=relaxed/simple;
	bh=UcwON2Jjs1JAqE69ngxdU/gqqYokCI4IVfd/TaNpJo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MbQ6/oirm7SNCaPjXQvr1WNxASTXqjz+dBnpk7EjB/9BHZ1ZMYKtNYF02IfW3YIHdlAPn2VyGoGPbmZ6kuS2bAgHpbFy17DVWtD5YsIwHIxkXILeOjFQX20IA7M7iFzVU853yk1zcJw5JdrK+rJCiIIuglAwV7eCPyCIRhkAs60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJY/AZK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJY/AZK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FCC1F00893;
	Wed,  9 Sep 2026 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981670;
	bh=vZRsoMy5sZDSGwmfwFzmzGW7OKU7M0ad8zGyq6BdVTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJY/AZK2NHBiA/zFx4fpwogV8uUb6WkaEpc1XHNJTfHndGkEwHT0GaMyi0C8MXvgq
	 9bjDX4kb6Ebh2HZvDlii4guwpjdTA3SChsjk82AjEK2IZFWRTCAVBEm7ht/42Fxz0K
	 WLcsi+REi+TJJDooEAMpMSxxbefCLb18VD2+PQ3Xd7lflQ8zIJ89I8o9RsaRFElc+6
	 Kw2A5vSfwgc0UYGg25/nVh790n95ahnVO+Kyk+pCLB+L/AECnjfaX+mNSycHii9Ib6
	 zjZVBxkSugMbq3rmFnLsOE3C0HriVzAJm3D8J0agK7q5Z0y4RcMYnDSI7PbAUpoYud
	 4uFPgesiLdlvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260909-patches_v2_external-v2-4-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
 <20260909-patches_v2_external-v2-4-3a40babaff4c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:21:09 +0000
Message-Id: <20260909192110.70FCC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Probe failure for standard-compliant DT nodes due to unit-addres=
s stripping.
--

commit ce208f79c4ab3c3d36c98c28fc4120175bc8c6d9
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: parse endpoint DMA channel configuration

This commit introduces device tree parsing for the endpoint DMA channels in
the Xilinx TSN driver. It counts the available TX and RX channels and maps=
=20
logical TX queues to their physical DMA channels based on child nodes.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 089f17a126f54..24025b1f6e66d 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> +/*
> + * Parse the "tx-queues-config" child of the EP node. The logical queue
> + * index is taken from the "queue<N>" node name, so the mapping does not
> + * depend on the order the child nodes appear in the device tree.
> + */
> +static int ep_parse_tx_queue_config(struct xlnx_tsn_ep *ep,
> +				    struct device_node *txcfg_np, u16 tx_present)
> +{
> +	DECLARE_BITMAP(queue_seen, TSN_MAX_TX_QUEUE) =3D {};
> +	DECLARE_BITMAP(chan_seen, TSN_MAX_TX_QUEUE) =3D {};
> +	unsigned int count =3D 0;
> +	int ret;
> +
> +	for_each_child_of_node_scoped(txcfg_np, qnode) {
> +		u32 chan, queue;
> +
> +		if (!str_has_prefix(qnode->name, "queue") ||
> +		    kstrtou32(qnode->name + strlen("queue"), 10, &queue) ||
> +		    queue >=3D ep->num_tx_queues)

[Severity: Medium]
Will this correctly parse standard device tree unit addresses?

The Open Firmware (OF) core strips the unit-address (the `@...` portion)=20
when assigning the `name` field during node initialization. This means=20
that for a standard-compliant node like `queue@0`, `qnode->name` will be=20
exactly `"queue"`.

If `qnode->name` is exactly `"queue"`, skipping the prefix length leaves an
empty string (`"\0"`). Calling kstrtou32() on an empty string returns=20
-EINVAL, which would erroneously abort the probe for compliant DTs.

Could this logic be adjusted to handle unit-address stripping, or perhaps
read the logical queue index from a standard DT property like `reg` instead
of relying on string parsing of the node name?

> +			return dev_err_probe(ep->dev, -EINVAL,
> +					     "tx-config: invalid queue node %pOFn (have %u queues)\n",
> +					     qnode, ep->num_tx_queues);
> +
> +		if (test_and_set_bit(queue, queue_seen))
> +			return dev_err_probe(ep->dev, -EINVAL,
> +					     "tx-config: queue %u described twice\n",
> +					     queue);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-patches_v2=
_external-v2-0-3a40babaff4c@amd.com?part=3D4
