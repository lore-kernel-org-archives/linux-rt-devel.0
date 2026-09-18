Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704551C325;
	Fri, 18 Sep 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755314; cv=none; b=ULqiyKu69VtqE6YE9im9AfGZK+A0QZII/+GxKxqAj2BzP6IACgj6JDlpGWOkx3HFAmVk4ZcS2u2cSCpuUICvYzATA19BFERbIHlFc0D7qEZ7/c+tUhEiE7fvRKYONcoQYgKzKSl+6ltsYcWnwkLHZpcpzkdwqcNHnnKA6x5wGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755314; c=relaxed/simple;
	bh=KesATRdhFDzUzoGKlmNPfiHB+MI42bRZAdGLQVkZ+RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyFO+XiOBuWgblaSUlqj6M5sV23WzCxhx5ndvLPkTfo05Q2M1F61NyYgLTBd0gWp+HCXhcNRMGcMEl3tfpj1aaLwkYZITj7tGkP7PbuKeS3ZuwWIXxuFRex4qQ4lIS14OJ+8vL7C+z/jyzyar+yTHZwhKLmaLglcz5p5nvCuSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktj/G0Wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktj/G0Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C71E1F000FF;
	Fri, 18 Sep 2026 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755312;
	bh=CbhXPRPJzPhnC7eGr+2poQlhUAHpaFK7HRpRDPeuPsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ktj/G0Wqt43Q8JVUKtdjIxDlECxpTb81j7LuFwY4MTGxTsji3X8jAIGFdYMZzuvIj
	 ztAD59fwFf5BXIdZ7RlnUUPYA/mcko7PcO280exjookUWqGxa6StWCAYvhUaAfURuB
	 HwvD4heR9IXqrZVolpO7TgFiOPm5ZHN7iBUZ3QT3pQTpoNjR9sERxPWiEVf4yLK3gi
	 vnmPh/URbMpnWMpHImcd9xjoL11mAFcErmviIk+2M+IKo4aAl4IBSfw3K/sibAa3sm
	 mBKeQrVEoUvivqKAY32Gypywqsvj0PYafjlQZvdQZTVSoM/F1G1nOuk8Up55dgyGly
	 4SModAFf5nk+A==
Date: Fri, 18 Sep 2026 13:15:10 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com,
	git@amd.com
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: add Xilinx TSN
 Endpoint Ethernet MAC
Message-ID: <20260918181510.GA1086854-robh@kernel.org>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
 <20260909-patches_v2_external-v2-1-3a40babaff4c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-patches_v2_external-v2-1-3a40babaff4c@amd.com>

On Wed, Sep 09, 2026 at 12:49:49AM +0530, Srinivas Neeli wrote:
> Add a binding for the Xilinx TSN Endpoint Ethernet MAC IP. The
> top-level node describes the IP wrapper, which owns the six shared
> IP clocks and the xlnx,num-priorities parameter, and has two
> children:
> 
>   - xlnx,tsn-ep-mac: the endpoint MAC, owning the host-side DMA
>     channels (dmas / dma-names / tx-queues-config).
> 
>   - xlnx,tsn-switch: the three-port Ethernet switch covering the
>     switch fabric and the two per-MAC register windows. The MDIO
>     controllers and PTP register blocks sit at fixed offsets inside
>     the per-MAC windows, accessed through the mdio-1 / mdio-2
>     children and per-MAC interrupt-names entries. Each external
>     port@N references its PHY through a phy-handle in the matching
>     mdio-<N> child.
> 
> Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
> Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> 
> ---
> Changes in v2:
> - Describe only the Bridged Endpoint configuration. The IP has so far been
>   simulated only as a bridged endpoint, so the binding and driver describe
>   that configuration alone. Support for an Endpoint-only design will be added
>   once that IP variant is simulated.
> - Rename ep-mac@ to ethernet@ and mdio-mac1/mdio-mac2 to mdio-1/mdio-2, and
>   anchor the node names (^ethernet@[0-9a-f]+$, ^switch@[0-9a-f]+$), per
>   ethernet-controller.yaml and mdio.yaml.
> - Cap TX at 8 and RX at 8 channels. The IP exposes 8 priorities, so it
>   drives at most 8 TX and 8 RX MCDMA channels. dma-names lists both
>   directions, so its combined maxItems is 16 (8 TX + 8 RX). V1 allowed up
>   to 16 per direction, which the hardware cannot use.
> - Set additionalProperties: false on tx-queues-config and its queue nodes.
> - Drop reg from the wrapper node. It has no registers of its own, ranges
>   already describes the child windows.
> - Add minItems: 7 to the switch interrupts to match interrupt-names.
> - Use a ^(ethernet-)?ports$ container with additionalProperties: false and its
>   own #address-cells/#size-cells, and require either ports or ethernet-ports.
> - Require ethernet on the CPU port@0.
> - Add reg (enum [1, 2]) on the external port@[1-2] ports and require reg,
>   phy-mode and phy-handle. MAC1 and MAC2 use gmii/rgmii/rgmii-id.
> - Require port@0, port@1 and port@2. The IP is a fixed three-port bridged
>   design (port@0 CPU, port@1 MAC1, port@2 MAC2), so a device tree missing
>   any of them cannot describe working hardware.
> - Add #address-cells and #size-cells (both const 1) on the wrapper node,
>   which the child ethernet@/switch@ windows need now that reg is dropped,
>   and set unevaluatedProperties: false on the endpoint node.
> ---
>  .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        | 364 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 371 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> new file mode 100644
> index 000000000000..4e65d1710da7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> @@ -0,0 +1,364 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/xlnx,tsn-endpoint-ethernet-mac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx TSN Endpoint Ethernet MAC
> +
> +description:
> +  TSN Endpoint Ethernet MAC IP implements IEEE 802.1 Time-Sensitive
> +  Networking (TSN) standards and provides low-latency network connectivity
> +  in the Bridged Endpoint configuration. The IP integrates a three-port
> +  switch, with two ports connected to the external network and one port
> +  connected to an internal endpoint. It also supports GMII/RGMII interfaces
> +  for connection to an external PHY, enabling full-duplex operation at
> +  100 Mb/s and 1 Gb/s speeds.
> +
> +maintainers:
> +  - Srinivas Neeli <srinivas.neeli@amd.com>
> +  - Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
> +
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
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  xlnx,num-priorities:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 8
> +    description:
> +      Number of traffic classes (priorities) configured in the IP.
> +      This is an IP configuration parameter that determines the number of
> +      priority queues available for QoS scheduling. Traffic classes map to
> +      IEEE 802.1Q priority levels (0-7).
> +
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
> +
> +      reg:
> +        maxItems: 1
> +
> +      dmas:
> +        minItems: 2
> +        maxItems: 16
> +
> +      dma-names:
> +        minItems: 2
> +        maxItems: 16
> +        items:
> +          pattern: "^(tx|rx)_chan[0-7]$"
> +        description: |
> +          Names matching the entries in 'dmas', one per DMA channel and in
> +          the same order. TX channel names use "tx_chan<N>" and RX channel
> +          names use "rx_chan<N>", where N is 0..7. Example: "tx_chan0",
> +          "tx_chan1", ..., "rx_chan0", "rx_chan1", ....
> +
> +      tx-queues-config:
> +        type: object
> +        additionalProperties: false
> +        description:
> +          TX queue configuration node that maps IP priority queues to
> +          DMA TX channels. The TSN IP supports multiple priority queues for
> +          QoS scheduling, and each queue can be connected to a specific DMA
> +          channel. This mapping defines which DMA TX channel is used to
> +          transmit packets for each priority queue. For example, queue0
> +          with xlnx,dma-channel-num set to 5 means priority queue 0 uses
> +          tx_chan5 for data transfer.
> +
> +        patternProperties:
> +          "^queue[0-7]$":
> +            type: object
> +            additionalProperties: false
> +
> +            description:
> +              Each subnode represents a priority queue. The
> +              xlnx,dma-channel-num property specifies which DMA TX channel
> +              (tx_chan0 to tx_chan7) is connected to this queue for
> +              transmitting packets.
> +            properties:
> +              xlnx,dma-channel-num:
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                description:
> +                  DMA channel that transmits this priority queue, given as
> +                  the N of the tx_chanN entry in dma-names.
> +                minimum: 0
> +                maximum: 7
> +
> +            required:
> +              - xlnx,dma-channel-num
> +
> +    required:
> +      - compatible
> +      - reg
> +      - dmas
> +      - dma-names
> +      - tx-queues-config
> +
> +  "^switch@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports
> +    description:
> +      Three-port Ethernet switch sub-node. Contains the switch fabric
> +      register window and the two per-MAC register windows. Each per-MAC
> +      window houses an MDIO controller and a PTP register block at fixed
> +      offsets. The IP's per-MAC and PTP-timer interrupts are exposed here.
> +
> +    properties:
> +      compatible:
> +        const: xlnx,tsn-switch
> +
> +      reg:
> +        items:
> +          - description: Switch fabric register window
> +          - description: MAC1 register window (includes MDIO and PTP)
> +          - description: MAC2 register window (includes MDIO and PTP)
> +
> +      reg-names:
> +        items:
> +          - const: switch
> +          - const: mac1
> +          - const: mac2
> +
> +      interrupts:
> +        minItems: 7
> +        maxItems: 7
> +
> +      interrupt-names:
> +        items:
> +          - const: ptp_rx_mac1
> +          - const: ptp_tx_mac1
> +          - const: mac_irq_mac1
> +          - const: ptp_timer
> +          - const: ptp_rx_mac2
> +          - const: ptp_tx_mac2
> +          - const: mac_irq_mac2
> +
> +      mdio-1:
> +        $ref: /schemas/net/mdio.yaml#
> +        description:
> +          MDIO bus controller for MAC1. Registers reside inside the mac1
> +          reg-names window.
> +        unevaluatedProperties: false
> +
> +      mdio-2:
> +        $ref: /schemas/net/mdio.yaml#
> +        description:
> +          MDIO bus controller for MAC2. Registers reside inside the mac2
> +          reg-names window.
> +        unevaluatedProperties: false
> +
> +    patternProperties:
> +      "^(ethernet-)?ports$":

'ethernet-' doesn't need to be optional for new bindings.

> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          '#address-cells':
> +            const: 1
> +
> +          '#size-cells':
> +            const: 0
> +
> +          port@0:

ethernet-port@0

> +            type: object
> +            unevaluatedProperties: true
> +            description:
> +              CPU port. Wired internally to the endpoint MAC sibling.
> +
> +            properties:
> +              reg:
> +                const: 0
> +
> +              phy-mode:
> +                const: internal
> +
> +            required:
> +              - ethernet
> +
> +        patternProperties:
> +          "^port@[1-2]$":

ethernet-port

Rob
