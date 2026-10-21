Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552619;
	b=q8d0Rf5cIOAw/VkEw9imWSrLm70I5iMNo2J4zH7FiqoE0K65qyUCpbDYaI3RG4tTXP7T
	 Td3ShY46NYmG7kbnS0g6CUdaK5iqTdcy++8wI4QrQ2qntDghvGftWpvAL8AEXNaUXROKo
	 nvLMzDvk8xOtxGZJ8yM8azIbU3gtwk3FoMc0c0DnRg+/ClCAD8l9EwQoYx4JhsvBCyuAW
	 +1K4KrKtacMlTP5Of1Vsx+qmM9mfAddNDLb6wh9yQ+MxrBEVzTV5ZTgNFjzbjq6HCGK+a
	 IHYUTIBH7sscaZzHkOIUsW8qV/PdPV53wu5lYhG5wMp6kUNB+nIncCUAhI6RoYuX/Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552619;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=feCAkfcWxEXEVFUTa9GcuWE5XNs6AH6IndZ4hH748YE=;
	b=cl/0PMzonp7dyQKzpYwpSybaBQHS5VQqNOmRPF0dxZShObNRtq5NUOWbFXjNCZ90weY2
	 okZE4kXOibciMqVzcBgM8n8j6HQ5ArooGVxwfGHholFGEf9Qrs+SjaVhuqwxv0/YtPOFt
	 4wUZhj+3xP7N2vsumUJEnsdYeVfk+/InnMWWO1nxpPTcQLrMmZoXZcJoFN4q46nPu54TQ
	 JPe8az6NmEtMCfHlGf+dnayrq4Obtnxs2Y7b7DzK0lA0JxsRPu8aUgid4+h4ge2mWp8CG
	 qBLE6yFD2uxozl6bSqbBimqoUR4tzEa1yJU1g1GYHva34GsHmYiW014XS2tjgI3hgMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkYDBAwX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11D6072130;
	Wed, 21 Oct 2026 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkYDBAwX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B94A1F000CC;
	Wed, 21 Oct 2026 03:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792552618;
	bh=feCAkfcWxEXEVFUTa9GcuWE5XNs6AH6IndZ4hH748YE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mkYDBAwXINmVLVKYBlSQU8no5KvLsEk0UzJvaVHnaBM1aZzoQKY6w9BKF2J6WaEsv
	 twJmUfTGlOjM3fwHw7yDFh67+abZLgXzsaXwWsNthBuUGiUvpHGIhDVSsrTX76T14Z
	 uONsEA2Jr3Be6SL09vKtAtZSS8X9nbBZWU9oOJv2NfXP+G7doMGbquq33P3T1+b5uA
	 w0DlyaZb7GbTuPoORBqKjHjD3rY334ADRNfwtzKRC5Enpp25/U18jyg43dLpxVB67n
	 GMOJCJe/xTuh5o4SMkjGtfY6g5OcAuR3fGlTiRF5xmOvAnGhAPQ6oUTKsLNPlnYkBq
	 yZKSK2HJpl0og==
Date: Tue, 20 Oct 2026 22:16:57 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: srinivas.neeli@amd.com, nagadheeraj.rottela@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, michal.simek@amd.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	edumazet@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com,
	git@amd.com
Subject: Re: [PATCH net-next v3 1/8] dt-bindings: net: add Xilinx TSN
 Endpoint Ethernet MAC
Message-ID: <20261021031657.GA3867774-robh@kernel.org>
References: <20261016-patches_v2_external-v3-1-e33d3960ca1e@amd.com>
 <179249749105.3135.3116293825083161439@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179249749105.3135.3116293825083161439@kernel.org>

On Tue, Oct 20, 2026 at 11:58:11AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] In Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-
>   ethernet-mac.yaml, the ethernet@ node's dma-names (lines 81-96) does…
> - [Low] Concern: tx-queues-config only enforces a lower bound tied to
>   xlnx,num-priorities, and the rest of the checking is left to a driver…
> - [Low] The child compatibles in
>   Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-…
> 
> --
> 
> dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
> 
> This adds a YAML binding for the Xilinx TSN Endpoint Ethernet MAC IP in
> its Bridged Endpoint configuration. The wrapper node owns the shared
> clocks and xlnx,num-priorities. It has two children: an xlnx,tsn-ep-mac
> endpoint that holds the DMA channels, and an xlnx,tsn-switch three-port
> switch with its MDIO buses and ports.
> 
> > diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> > new file mode 100644
> > index 0000000000000..bca834120b3b1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> > @@ -0,0 +1,491 @@
> 
> [ ... ]
> 
> > +properties:
> > +  compatible:
> > +    const: xlnx,tsn-endpoint-ethernet-mac-3.0
> 
> [ ... ]
> 
> > +patternProperties:
> > +  "^ethernet@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/net/ethernet-controller.yaml#
> > +    unevaluatedProperties: false
> > +    description:
> > +      Endpoint MAC sub-node. Provides the host-side data path through the
> > +      DMA channels described by its dmas / dma-names.
> > +    properties:
> > +      compatible:
> > +        const: xlnx,tsn-ep-mac
> 
> [Severity: Low]
> The wrapper compatible is versioned (xlnx,tsn-endpoint-ethernet-mac-3.0).
> The child compatibles here and on the switch node (xlnx,tsn-switch) are
> generic and carry no version.
> 
> writing-bindings.rst asks for specific compatibles, with no device-family
> names. For sub-blocks of a bigger device, it asks for device-based
> compatibles.
> 
> If a later IP revision, or the planned Endpoint-only variant, changes the
> endpoint or switch register layout, how would these child nodes be told
> apart? The endpoint driver later in the series matches only on
> "xlnx,tsn-ep-mac" in xlnx_tsn_ep_of_match.
> 
> Should the child compatibles be tied to the device or version, the same
> way the wrapper compatible is?

It's fine. Being specific is less important given there's a specific 
parent compatible.

> 
> [ ... ]
> 
> > +      dma-names:
> > +        minItems: 2
> > +        maxItems: 16
> > +        items:
> > +          pattern: "^(tx|rx)_chan[0-7]$"
> > +        allOf:
> > +          - contains:
> > +              pattern: "^tx_chan[0-7]$"
> > +          - contains:
> > +              pattern: "^rx_chan[0-7]$"
> > +        description: |
> > +          Names matching the entries in 'dmas', one per DMA channel and in
> > +          the same order. TX channel names use "tx_chan<N>" and RX channel
> > +          names use "rx_chan<N>", where N is 0..7. At least one TX and one RX
> > +          channel are required. Example: "tx_chan0", "tx_chan1", ...,
> > +          "rx_chan0", "rx_chan1", ....
> 
> [Severity: Low]
> The description says the names are "one per DMA channel". The v3
> changelog says "Cap TX at 8 and RX at 8 channels". Does the schema
> enforce either of these?
> 
> Without uniqueItems: true, dt_binding_check appears to accept a 16-entry
> list of fifteen "tx_chan0" plus one "rx_chan0". It also appears to accept
> "tx_chan0".."tx_chan7", then "tx_chan0".."tx_chan6", then "rx_chan0".
> 
> dtschema doesn't add uniqueness to -names properties by itself. For
> example, renesas,drif.yaml lists "rx", "rx", while renesas,sdhi.yaml sets
> uniqueItems: true on its clock-names.
> 
> Could uniqueItems: true be added here? The pattern only allows eight
> names per direction, so that would also enforce the 8 TX / 8 RX limit.
> 
> Later in the series, ep_count_dma_channels() rejects duplicate TX and RX
> names at probe time. So the runtime result is a DT that passes schema
> validation and then fails probe.

IIRC, dma-names is the exception here. So yes, you should add 
'uniqueItems: true'.

> 
> [ ... ]
> 
> > +        patternProperties:
> > +          "^queue[0-7]$":
> > +            type: object
> > +            additionalProperties: false
> 
> [ ... ]
> 
> > +        required:
> > +          - queue0
> > +          - queue1
> 
> [ ... ]
> 
> > +allOf:
> > +  - if:
> > +      properties:
> > +        xlnx,num-priorities:
> > +          const: 3
> > +    then:
> > +      patternProperties:
> > +        "^ethernet@[0-9a-f]+$":
> > +          properties:
> > +            tx-queues-config:
> > +              required:
> > +                - queue0
> > +                - queue1
> > +                - queue2
> 
> [Severity: Low]
> With xlnx,num-priorities = <2>, can a tx-queues-config that contains
> queue0 through queue7 still pass dt_binding_check?
> 
> The ^queue[0-7]$ pattern accepts every index from 0 to 7. The if/then
> blocks for num-priorities 3..8 only add entries to required. So the
> schema has a lower bound tied to xlnx,num-priorities, but no upper bound.
> 
> Later in the series, ep_parse_tx_queue_config() rejects queueN with
> N >= num_tx_queues at probe time, so only schema validation is affected.
> 
> Could each if/then block also set queueK: false for K >= N, so the
> schema rejects these nodes too?

Shrug. Sounds too complicated.

Rob
