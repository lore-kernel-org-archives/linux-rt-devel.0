Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576037;
	b=fhKLOpyu2y2TDA3LhidQ+YvYIxYrtET6jToENoQVfUv2lxc9i5uH6yfUsv6ETAJEXmym
	 2xxFfaNvCzhIshaMtwkXUlBUQi7wQq/1xExpHcEhNPepW7sPn0+RNr4hwBp0+ZdlSNXym
	 en3HtSKD71khjT/rm/Vv5aVMzaORU4aS7O09pQf/+gwcm+sou6XYptk/hsGAqGLTxaMYb
	 JEeN2EffQfqKOLcs28xmT/fhNp7IcA9DaX2X410cSiTyJR8XKfqgKcmCNuLwgh0mrZmwS
	 tSaBuJlMTdrwhkN8Xii8NSY/tQ48OWuCH6NrSBXb4Mlq4sYiulfPYKoQo1o8n4l9Q4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576037;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=j0OFUyWGFsnHOx/jru7yE6httZZaLm6I3BJksdA09jw=;
	b=sSAuAuctM7Z2SzyIlC2skSupohZK8rtUFyZhfN3t84Y3P/bARta6DA30gCfgbNCyN0ie
	 qoO5LydJx96e99FEJXPGTPJfeooN4gHYmCilmRrTkzn4g8qAEGyRDt0wm6YInsmx9+xif
	 rd8O3rkmX8ysfc4zFHq4wA/m0J4f/7YfynzRHCiIEJaUptPs5dAg6HA8Orde5yumIXsly
	 vUbVXB7ruxXdV1bGmA4eDJ2AUwrnS0fgQPJ47DHyRLuPmWaktd8ZjQ+Z9oF7cJzQiNfDw
	 JrelyBhE0LsIKVO4on0dLyFnOXkbzLD4vwYHp5OcHlA87DzfeopVreQyXXbdiMzzckg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KX4t3g0e;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F9606A8A3;
	Fri, 13 Nov 2026 13:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D18F9606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KX4t3g0e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j0OFUyWGFsnHOx/jru7yE6httZZaLm6I3BJksdA09jw=; b=KX4t3g0eJVWmTu/lZOhr4WiZLw
	eBCvGBf9DJXjnXkHFtAmz0vu18yN+3KV/Se0HIulgfV06weLz1jv7ZUHlf2oDwl9J5A49sy5d9kYk
	wg7lMUpxFrBxFhcq2GNdITdVQdaX47/esrDXL42b/tHRDOJoxFpOj4ja46nxokezBufI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRrCW-00GHU2-1L; Fri, 13 Nov 2026 14:20:20 +0100
Date: Fri, 13 Nov 2026 14:20:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, git@amd.com,
	neelisrinivas18@gmail.com
Subject: Re: [PATCH net-next v4 1/8] dt-bindings: net: add Xilinx TSN
 Endpoint Ethernet MAC
Message-ID: <13864fbe-6cd1-4d70-afee-bd3d3be163f3@lunn.ch>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
 <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>

> +      xlnx,max-learning-entries:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 256
> +        maximum: 1920
> +        default: 1920
> +        description:
> +          Maximum number of addresses the hardware address learning engine
> +          can learn on each network port (MAC1 and MAC2). This is the
> +          MAX_LEARNING_ENTRIES IP configuration parameter, and no register
> +          reports it. The endpoint port does not take part in hardware
> +          address learning.

Is this a synthesis parameter? No other switch that i know of has it
in DT. The driver hard codes the value based on the compatible. Why
does that not work for you?

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

How hard coded into the design is the number of ports? The way the DT
is structured, it does not seem easy to add another port. It is more
normal to put all port properties within one node, so you just need to
cookie cutter that node, not add new nodes all other the place.

> +        switch@38000 {
> +            compatible = "xlnx,tsn-switch";
> +            reg = <0x38000 0x8000>,
> +                  <0x00000 0x14000>,
> +                  <0x20000 0x14000>;
> +            reg-names = "switch", "mac1", "mac2";

> +            mdio-1 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                phy0: ethernet-phy@0 {
> +                    reg = <0>;
> +                };
> +            };
> +
> +            mdio-2 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                phy1: ethernet-phy@1 {
> +                    reg = <1>;
> +                };
> +            };

Interesting that this is address 1, where as the other is address 0.
Just to be sure, there are two fully independent MDIO bus masters?

This 


> +
> +            ethernet-ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                ethernet-port@0 {
> +                    reg = <0>;
> +                    ethernet = <&ep_mac>;
> +                    phy-mode = "internal";
> +
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                    };
> +                };
> +
> +                ethernet-port@1 {
> +                    reg = <1>;
> +                    phy-handle = <&phy0>;
> +                    phy-mode = "rgmii-id";
> +                };
> +
> +                ethernet-port@2 {
> +                    reg = <2>;
> +                    phy-handle = <&phy1>;
> +                    phy-mode = "rgmii-id";

Are these two PHY internal or external? Using rgmii internally is O.K,
but odd. Normally 'GMII' or 'internal' would be used.

    Andrew
