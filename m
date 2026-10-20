Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497495;
	b=nNnThG71OdYhcXg+auo5FNolKshVkdt8+EDvmPtVDU96GYk1OuHCW+sIUyrVzmaE3uAW
	 s7kUdv1K+3vj3uy/9PFwIiGLc9E7uIrU+5o/zSbowuIvvoqKcPqkn3IJMNzNXOM9qW0c3
	 yURGG2T3TYpeFRIcetKORZwGBz+sBnUFFFupskyD9Eh20A/bs04O3va6n/rzbjlzSgLWX
	 ZRrkJXsWEeH6snLp1GmAH6e3sVHgS1HurJ4rYAXy1+PYuBut1fIe+sQTFgGirWAFmX8UT
	 Nvc5sRO/eTtXt3Iub/1PMz0Ahp1vbM+kYIPIkqVVQRSktqNEe286jgVhDwjSAc7GrQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497495;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N5SQ/KnAN/P3YdcqF5GR7+EQ6sknDHr2tVK2ulo6pU0=;
	b=IBqA1dFz27hScJZPOLbNdlDJIG2m/2ln3YQQU2uv75qUbINOAou5BxauE9AEbuqHAsvP
	 rQV/Ucks3wwwPc4IiIAOgix/EUEBnrFuDlx2+fSGq8u/L3JhIqVoeAqSg0Er/k9OVW8vX
	 K9stYjYBrVREgV4m4V/sCN5z7xsbKafSLJQij9ULyE7eQp43+CyBOXXqQ1CTGfoEZMNnH
	 SjBaNUYOQ35QODJ5JkXOtUBL2Jr3tB8D6eXNEgVEsisLehXfDzSgA878HjNDOSNON06lu
	 s223t1HtA1dnDYz9EkCa4/4zasLTKbkL4HVr08NB7iBLzXIhJ0aiTt4/MRfzQuvfAmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6GwepX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F53606A327;
	Tue, 20 Oct 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6GwepX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCFA1F000C5;
	Tue, 20 Oct 2026 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497494;
	bh=N5SQ/KnAN/P3YdcqF5GR7+EQ6sknDHr2tVK2ulo6pU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d6GwepX3DTkOAWX1RW20wID4QIymqhqVsnx0A44I+LsetCRfpUEX6T06TXw4x+ZzX
	 hPq0cuAjK3U03pRypzivioAHrk7fQWCE+cOT5x/CnO1AIuiKaqz45g85wsMRfpd12R
	 zD+ER306Mv5oLEA0UtGhZSiCwPtyhxPj+KQtQTS2kN3CfQhE75p9KhOruiLemUegDx
	 HOVn3iHn/Q3CGG4MSG64R1BwEdQpo6cIzhe08DIBYYWVgAEGI7esw9XnY5E2rs7Gp8
	 BWbYXWblGwjgzFpbglfZWoY0VC0OwfaPy8r5c5Y50Pba57+56bYcqG0mhQiIr1n4Gg
	 aY5EZ21xNiaDA==
Subject:
 Re: [PATCH net-next v3 2/8] net: xilinx: tsn: add TSN endpoint wrapper driver
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:13 +0000
Message-ID: <179249749304.3135.18017691106528923366@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-2-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-2-e33d3960ca1e@amd.com>
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

- [Low] The XILINX_TSN Kconfig help text says "The three-port switch is
  supported by the companion DSA driver." That driver does not exist in…

--

net: xilinx: tsn: add TSN endpoint wrapper driver

This adds a thin platform driver for the AMD/Xilinx TSN Endpoint
Ethernet MAC IP node. It turns on the six IP-wide clocks and then calls
devm_of_platform_populate(), so each sub-node can bind to its own
driver.

> diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
> new file mode 100644
> index 0000000000000..b8939d8a92ef7
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
> @@ -0,0 +1,15 @@

[ ... ]

> +config XILINX_TSN
> +	tristate "Xilinx TSN Ethernet driver"
> +	depends on OF_ADDRESS
> +	help
> +	  This driver supports the AMD/Xilinx Time-Sensitive Networking
> +	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
> +	  and the endpoint MAC that connects the IP to the host CPU. The
> +	  three-port switch is supported by the companion DSA driver.

[Severity: Low]
Which DSA driver is this sentence about? I couldn't find one in the
tree, either at this commit or at the end of the series.

The binding in this series defines the "xlnx,tsn-switch" compatible for
the switch@ sub-node, and nothing under drivers/ matches it.
tsn_ip_probe() calls devm_of_platform_populate(), which creates a
platform device for switch@, but no driver ever binds to it.

The v2 changelog says the help text was reworded so it no longer points
at "a symbol that does not exist yet at this patch". The new wording
still names a driver that isn't in the tree and has no Kconfig symbol.

Could this sentence be dropped or reworded until the switch driver is
posted?

Two other claims do become true later in the series: "endpoint MAC" in
the help text, and "bind each sub-node to its own driver" in the commit
message. That happens when "net: xilinx: tsn: add endpoint MAC driver
skeleton" adds xlnx_tsn_ep_driver to tsn_drivers[]. Only the DSA driver
reference is still wrong once the whole series is applied.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
