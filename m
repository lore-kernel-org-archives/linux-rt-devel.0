Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921285;
	b=mzRqgTqmGmjaDQufVhmNZOEvaJp1UAQigY15R7ebD1jd0qagjn/RtbWkht0FeSD9/uI3
	 BT8n76JpQtt1YGDsgtPNAOtOsUeN8HwKVpU3lHEk6LH1l33NQ9Q9G85KVI8rPcB87WhCt
	 aHFcm3cskVp0O2v06C4nFahdoEmCtKMDAeD/pKhcM7RUAt/YrsdqarfdTH+RRvsifX0pJ
	 rIpMiFtLS+GgG/BjqIH56Hx9EUlrexK7D9N812Oej/pqalEi19X/CjWxRLJx9MOE+SRyH
	 aq2PODMilKbOXOtypiTwfpKZdV7N8+ofyb7Sa4GlCFcrrkAqfflQH7vSPajEkebRqDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921285;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WiJQPmwMj9lPV0x+js9zTselq+a+J+B7UkEyyQHkr5U=;
	b=YbTqYweqac4KNZ7JM+7Kr5r+6BHAcO66QvhaWHSPKwXdODrTujFwJ7Rmy2HtyoJFrqUM
	 egHulYKfax/+Q/c3i0Ly0UNtw0RQi9jonV6o+DoBwpUNXTks3oBaxDmpduKxrXaqoym1y
	 Puy9ydpyoUCv/U49zyvZ2Hwj0JCp8n/pfzzRHsLKE8oQFTOLjRqirzvq3yXZvmY/pDH4i
	 uj7vqHlenijLr9iDOCzDCkZOFVR1nO+M7F4bLH7RVx5nKstsiIfej7t6Dje95dcu7EMWW
	 +WUKXVEF12Ka21Uzuc7OMcxLFsoQsKGlWXl3zvkEQAkU4GtkCfKa6fHOMui6qTtYavg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtzrMrcc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7A606A33D;
	Tue, 17 Nov 2026 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtzrMrcc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906F51F000C8;
	Tue, 17 Nov 2026 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921284;
	bh=WiJQPmwMj9lPV0x+js9zTselq+a+J+B7UkEyyQHkr5U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gtzrMrccC3oQfOVm3dUCPrbxSJru3b8t5gKFG3Q62WvalqHWbPGKbIORD1j1eXmTg
	 RGIIul8hSN3N+PTaPXmylurfOTThxtKYHIZ0+sBTrcre1ZCAnQYbKndfXhoo72G+y9
	 04nre5WdJW//RNqBJDKc9Krc3lz5nr54I/VQ8J+XRxoJMmEjNd42Wr2ZEruXDwx+Md
	 vXQdDYnqQhQ0LkAXijMYf8TpudTTfbCiMWgM+vD6qfRtUkmMgYEzxPWJqVKYGD3/J8
	 VZvAxMG2WXjuWaqqoBJd9Qumw5zlJulMjMU10lf974d5g1y8ykfuivgpB1MLeDu3vH
	 M33rQ5//fC8YQ==
Subject:
 Re: [PATCH net-next v4 2/8] net: xilinx: tsn: add TSN endpoint wrapper driver
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, git@amd.com, neelisrinivas18@gmail.com
Date: Tue, 17 Nov 2026 13:14:43 +0000
Message-ID: <179492128316.3136.9240121203954125694@kernel.org>
In-Reply-To: <20261113-patches_v2_external-v4-2-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-2-56bb26f042a4@amd.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] net: xilinx: tsn: use devm_clk_bulk_get_enable() in
  tsn_ip_probe()

--

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Time Sensitive Networking (TSN) Ethernet MAC wrapper driver.
> + *
> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#define TSN_NUM_CLOCKS		6
> +
> +/**
> + * struct xlnx_tsn_ip - wrapper-private IP state
> + * @clks: bulk-managed IP clocks
> + */
> +struct xlnx_tsn_ip {
> +	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
> +};
> +
> +static const char * const tsn_clk_names[TSN_NUM_CLOCKS] = {
> +	"gtx",
> +	"gtx90",
> +	"host_rxfifo",
> +	"host_txfifo",
> +	"ref",
> +	"s_axi",
> +};
> +
> +static void tsn_clk_bulk_disable(void *data)
> +{
> +	struct xlnx_tsn_ip *w = data;
> +
> +	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, w->clks);
> +}
> +
> +static int tsn_ip_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct xlnx_tsn_ip *w;
> +	int ret;
> +
> +	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < TSN_NUM_CLOCKS; i++)
> +		w->clks[i].id = tsn_clk_names[i];
> +
> +	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> +
> +	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
> +
> +	ret = devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_platform_populate(dev);
> +}
> +
> +static const struct of_device_id tsn_of_match[] = {
> +	{ .compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tsn_of_match);
> +
> +static struct platform_driver tsn_driver = {
> +	.probe = tsn_ip_probe,
> +	.driver = {
> +		.name = "xilinx-tsn",
> +		.of_match_table = tsn_of_match,
> +	},
> +};
> +
> +static struct platform_driver * const tsn_drivers[] = {
> +	&tsn_driver,
> +};
> +
> +static int __init xlnx_tsn_init(void)
> +{
> +	return platform_register_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
> +}
> +module_init(xlnx_tsn_init);
> +
> +static void __exit xlnx_tsn_exit(void)
> +{
> +	platform_unregister_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
> +}
> +module_exit(xlnx_tsn_exit);
> +
> +MODULE_AUTHOR("Srinivas Neeli <srinivas.neeli@amd.com>");
> +MODULE_DESCRIPTION("AMD/Xilinx TSN Endpoint Ethernet MAC wrapper driver");
> +MODULE_LICENSE("GPL");
>

[Severity: Low]
This open-codes what devm_clk_bulk_get_enable() already provides.
That helper in drivers/clk/clk-devres.c gets the bulk clocks, prepares
and enables them, and registers a devres release that disables,
unprepares and puts them on probe failure or unbind.

That means three steps can collapse into a single
devm_clk_bulk_get_enable(dev, TSN_NUM_CLOCKS, w->clks) call followed
by one dev_err_probe():

  - devm_clk_bulk_get()
  - clk_bulk_prepare_enable()
  - devm_add_action_or_reset()

The tsn_clk_bulk_disable() callback can then be dropped entirely.

The current code is not functionally wrong. It is just extra
boilerplate in tsn_ip_probe() that the clk framework already
handles. Is there a reason the get and enable steps need to stay
split here, e.g. something planned between them in a later patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-patches_v2_external-v4-0-56bb26f042a4%40amd.com
