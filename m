Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921283;
	b=YEYlrCDy+irdWDbwnqEx7JD67KzOtj9FNxj/qoEK5p1kzvVZxaRrSiiTnR8UtNmEnz3j
	 SjM7Vg6wgmRec4agYUi84X8bcEl1EOyTE9/vfTqWlKxIvXs4iKIq8hFc/5+Eu3M6g/6a/
	 vdRnATL0yxXIwQh8HjVlREg0jWsxmiMlQuKFivGB95y7LTT7USgwcFbTW+ZT2ZMdvvicR
	 7qKEQlZg1LoQs8WkzV9q+wXIIf0+dkwZCx/4oasfqY2+zkjPLmWwdV2WqMtakphczbYVl
	 v3d0JFsNwQ1WTkk6b+gxFgDQhydbA9OeHg/9FhRmTXYwh9JyRzV57bBa4MbxLPS1rdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921283;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xyPkutf+7u4MBeQWcEZC0BYLhd811Pqb+vA5vUZ5q7U=;
	b=bWKjZBGFLG0QanCaNfaMkC904268UMO6QFetDqAILhA0zDzxupo//K5aqfGdkBpdLmZ/
	 GH9UbrEm9XEz61cvJI93w+QgDjzJWspp2l9AkphIW1Pcg12Z2vOZUO+zydE2vd5fbWgK/
	 gCse4S8Oi3KYa0rjw7+sA49jMnJ/i9QqbSXWXam0Iijvf3XdCBTjAKxzFsfNtDF6oX3x0
	 XZ83ksZu5MzHw6n9st59iBklm3t56dbi8S6OMnr98fB/fhQoUjIv/6Yvxa/fvm0dJgeSz
	 quH5FucfWmYpGH4lejJEX08SyhIMRJpX0iJEVugs4qS9fTVyw/mhjGpar8uM9S5lRsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVVA2TtO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22464606A323;
	Tue, 17 Nov 2026 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVVA2TtO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A131F000C6;
	Tue, 17 Nov 2026 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921283;
	bh=xyPkutf+7u4MBeQWcEZC0BYLhd811Pqb+vA5vUZ5q7U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GVVA2TtOKCATkUVgz44orb44F6ykiWv6QfYowOc81WmQ5JHbSJnuEIvtXX1eDP5x7
	 +eaxtRfiU4i1bPhGayTJ+jpfq5sHebMIW0mVYD39Vb1hZnQm2tGbfGE5kXdeExBOBi
	 UqQhcVTTS24CHnLWE7HVH6/WpFwwpCSG0W8i+X70EtBrNz1NPT3viafmBK5Xc6Ak+U
	 0lfpu0s0ua0zUNDS08vjQfBILohX79k1XcEVe8ua5Kh3r4J2XrTsMeIFGwcUlfCIkA
	 /XOvRGzAEIaBCoJ4TU1oF1KE2aZ9ayNraIrK9MPOPFBHgB6sNvnlAHYVnCO+pFop1D
	 nIdz+1F2ROIrA==
Subject: Re: [PATCH net-next v4 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, git@amd.com, neelisrinivas18@gmail.com
Date: Tue, 17 Nov 2026 13:14:41 +0000
Message-ID: <179492128136.3136.2884088710304095071@kernel.org>
In-Reply-To: <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>
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

- [Low] The top-level schema never requires the '^ethernet@[0-9a-f]+$'
  (xlnx,tsn-ep-mac) child or the '^switch@[0-9a-f]+$' (xlnx,tsn-switch)…
- [Low] The per-xlnx,num-priorities allOf branches force tx-queues-config
  to hold exactly queue0..queue(N-1).
- [Low] The wrapper compatible is IP-version-specific ('xlnx,tsn-
  endpoint-ethernet-mac-3.0').
- [Low] The commit message says 'Each external port@N references its PHY
  through a phy-handle in the matching mdio-<N> child.' Since v3, the…
- [Low] ethernet-port@1 and ethernet-port@2 restrict phy-mode to gmii,
  rgmii and rgmii-id, which excludes rgmii-txid and rgmii-rxid.
- [Low] clocks/clock-names is a fixed list of six required entries (gtx,
  gtx90, host_rxfifo, host_txfifo, ref, s_axi), with no conditional on…

--

dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC

This adds a YAML binding for the Xilinx TSN Endpoint Ethernet MAC IP in
its Bridged Endpoint configuration. The top-level wrapper node owns the
shared clocks and xlnx,num-priorities. It has an xlnx,tsn-ep-mac child for
the host-side DMA channels and an xlnx,tsn-switch child for the three-port
switch, its MDIO buses and its ports.

> children and per-MAC interrupt-names entries. Each external
> port@N references its PHY through a phy-handle in the matching
> mdio-<N> child.

[Severity: Low]
Is this sentence still accurate after the v3 rename? The binding now only
accepts ethernet-port@1 and ethernet-port@2 inside the ethernet-ports
container. That container has additionalProperties: false, so the schema
would reject a node named port@1.

Should this say ethernet-port@N instead?

> diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> new file mode 100644
> index 0000000000000..2fd22bc0d0357
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> @@ -0,0 +1,536 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: xlnx,tsn-endpoint-ethernet-mac-3.0
> +
> +  clocks:
> +    items:
> +      - description: GTX clock for transmitter logic and RTC
> +      - description: GTX 90-degree phase shifted clock for RGMII
> +      - description: Host RX FIFO clock
> +      - description: Host TX FIFO clock
> +      - description: Reference clock for IDELAY control
> +      - description: AXI-Lite register interface clock
> +
> +  clock-names:
> +    items:
> +      - const: gtx
> +      - const: gtx90
> +      - const: host_rxfifo
> +      - const: host_txfifo
> +      - const: ref
> +      - const: s_axi

[Severity: Low]
Does the IP still have all six clock inputs when both external ports are
GMII? The description says gtx90 is the phase shifted clock for RGMII.
The list does not depend on the ports' phy-mode, so a GMII-only design
still has to supply gtx90.

The example already feeds the same clock to both gtx and gtx90:

    clocks = <&misc_clk_2>, <&misc_clk_2>, <&misc_clk_1>, <&misc_clk_1>,

Later in the series, tsn_ip_probe() in xilinx_tsn_main.c requests all six
clocks as mandatory:

    ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);

A DT without gtx90 would therefore fail to probe. The binding does not say
which clock inputs exist in the GMII configuration. The ref (IDELAYCTRL)
clock may still be needed for GMII.

If the GMII configuration has no gtx90 input, should that clock depend on
the ports' phy-mode?

> +
> +  ranges: true

[ ... ]

> +patternProperties:
> +  "^ethernet@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/net/ethernet-controller.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Endpoint MAC sub-node. Provides the host-side data path through the
> +      DMA channels described by its dmas / dma-names.
> +    properties:
> +      compatible:
> +        const: xlnx,tsn-ep-mac

[Severity: Low]
The wrapper compatible is versioned (xlnx,tsn-endpoint-ethernet-mac-3.0).
This child and the switch child (xlnx,tsn-switch) use unversioned names
that cover the whole family.

Documentation/devicetree/bindings/writing-bindings.rst asks for specific
compatibles and says not to use device-family names. For sub-blocks of a
bigger device, it prefers a compatible derived from the parent device.

The MDIO and PTP blocks sit at fixed offsets in the per-MAC windows of
this IP version. How would these child compatibles distinguish a later TSN
IP revision with a different sub-block layout?

Should the child compatibles follow the parent IP version too? If not,
could the commit message explain why they are generic?

[ ... ]

> +      dma-names:
> +        minItems: 2
> +        maxItems: 16
> +        items:
> +          pattern: "^(tx|rx)_chan[0-7]$"
> +        allOf:
> +          - contains:
> +              pattern: "^tx_chan[0-7]$"
> +          - contains:
> +              pattern: "^rx_chan[0-7]$"

[ ... ]

> +      tx-queues-config:
> +        type: object
> +        additionalProperties: false
> +        description:
> +          TX queue configuration node that maps IP priority queues to
> +          DMA TX channels. The TSN IP supports multiple priority queues for
> +          QoS scheduling. Each priority queue must be described exactly
> +          once and map to a distinct TX channel listed in dma-names. Two
> +          queues must not use the same TX channel. The mapping need not
> +          follow the channel numbering. For example, queue0 with
> +          xlnx,dma-channel-num set to 5 means priority queue 0 uses tx_chan5
> +          for data transfer.

[Severity: Low]
Should dma-names be tied to xlnx,num-priorities in the same way as the
queueN children?

The per-N allOf branches force tx-queues-config to hold exactly queue0 to
queue(N-1). dma-names only needs one tx_chan entry and one rx_chan entry,
and it has no uniqueItems. As far as I can tell, this would validate:

    xlnx,num-priorities = <8>;
    dma-names = "tx_chan0", "rx_chan0";
    tx-queues-config {
        queue0 { xlnx,dma-channel-num = <0>; };
        ...
        queue7 { xlnx,dma-channel-num = <0>; };
    };

That contradicts the description above, which says each queue maps to a
distinct TX channel listed in dma-names.

The driver added later in the series ("net: xilinx: tsn: parse endpoint
DMA channel configuration") also requires an exact match in
xlnx_tsn_ep_probe():

    if (num_tx_dma_channels != num_prio)
        return dev_err_probe(dev, -EINVAL,
                     "TX channel count %u must equal num-priorities %u\n",

The binding does not document this rule. A DT with more tx_chan entries
than priorities passes dt_binding_check but fails probe. The driver
rejects all of these cases at probe time with an error message.

Could each per-N if/then block also limit the tx_chan entries to exactly
N (contains with minContains/maxContains), and could dma-names get
uniqueItems: true?

The MAINTAINERS entry here lists only the binding file. The driver
directory is added to it later in the series.

[ ... ]

> +          ethernet-port@1:
> +            type: object
> +            unevaluatedProperties: true
> +            description:
> +              External Ethernet port wired to MAC1, reached through the
> +              mdio-1 bus.
> +
> +            properties:
> +              reg:
> +                const: 1
> +
> +              phy-mode:
> +                enum:
> +                  - gmii
> +                  - rgmii
> +                  - rgmii-id

[Severity: Low]
Why are rgmii-txid and rgmii-rxid left out here and on ethernet-port@2?

phy-mode describes which RGMII delays the board does not provide. A board
whose PCB adds only one of the two delays needs one of those modes. With
this enum, the board author has to choose rgmii (one delay missing) or
rgmii-id (one delay applied twice).

The gtx90 clock is described as "GTX 90-degree phase shifted clock for
RGMII", which suggests the MAC may shift TXC itself. Does the MAC add the
TX delay? If it does, and the PHY also adds the TX delay for rgmii-id, the
delay would be applied twice.

Should the binding say whether the MAC applies this delay, or describe it
with a property such as tx-internal-delay-ps?

[ ... ]

> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - xlnx,num-priorities
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'

[Severity: Low]
Should the ethernet@ and switch@ children be required here?

The description and changelog say the binding covers only the fixed
Bridged Endpoint configuration. ethernet-port@0/1/2 are required because
a DT missing any of them "cannot describe working hardware". Even so, a
wrapper with no switch@ child, or with no children at all, still passes
dt_binding_check.

A node with only an ethernet@ child already validates under
xlnx,tsn-endpoint-ethernet-mac-3.0. That is the Endpoint-only layout the
changelog says is not supported yet.

If the two configurations are told apart later by which children are
present, shouldn't this schema state that requirement now?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-patches_v2_external-v4-0-56bb26f042a4%40amd.com
