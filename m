Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794692606;
	b=NlmZA6AJB34vlqks9slZbSD+gxII44LVZ4s+WNdY1ecensAFPeHcuRFjzJ40TtzCWVgF
	 0/OgHXzzUQGZ02d5twpNU76s4vAFlQPIrAF5SYxGvRIvLeOrtnvQlp59fIMG4pIGPi7Nd
	 hbIjE+BljaSVrhyepr2yH6rCEB6KJeLGnfXqpY4nJKiTnCZbNE9DnoE8BProO1kWIreCk
	 Dx7HuAL13d+ECg0QrICY0dKFZ50i+TQfog5UvDVvFkgWJk4UCUZbV3lGekikdhcYN1tEB
	 GR30Up98ph8P47wM2l6GQqLU4dGE6bwrMPII6lKv+ehh9igK+vWhCROF3zKcvIipYeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794692606;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cH6JbwG5VdVbgmYxnv5oVF/9GrHOQI+8CfDJ0kv7PUA=;
	b=kHWpPkjJLU3gJZ5x9sl1Ll+14lmhu1i4qCgb3eRBowxotKzPdUK14QIZTe3x5y5Pb8iA
	 uMqQjFveN5G4ZA7w4DmfxGg3yQhyEmP63JXyYXEdhZ8cxq2/xS5KsSpqJUb8ueyLVlw8y
	 3WblMyZW87ncY/TYpYDizgE4TTTRlyr7ZM0ebRX1qZ4jeZ7Om/opVMoXI6W/hvehWFr8B
	 QS248SakbC5kd7Vozt4pTVDGKJyAiNP6b883IiwS7VFCdFqoknoj1n6PEX+yDFHQ2m5v3
	 kzgGIQiT6APUGL0oMg4S7pMigAoqa7AzEPKuML/FlhCNxjd1u/685kai/zTJE8qInsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xSx5SLpv;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3E606A327;
	Sat, 14 Nov 2026 21:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D3E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xSx5SLpv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cH6JbwG5VdVbgmYxnv5oVF/9GrHOQI+8CfDJ0kv7PUA=; b=xS
	x5SLpvGAqlh1hwZaJmIRl+4srILdtM9vk9LXzX9xFmbtBhtg2w/EVOdekoFG7M7lHkaczM8gY/Whh
	Bq/Uzntm7EL+Fy3IUijezIUy0cWXs5G/KB81U3+anUYS26P97QDiBldTIAo1ILh1HVntdfvXyKVWE
	u9V7HK9VF2yfhVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xSLWh-00GXUs-DW; Sat, 14 Nov 2026 22:43:11 +0100
Date: Sat, 14 Nov 2026 22:43:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Neeli, Srinivas" <srneeli@amd.com>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>,
	Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>,
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
Message-ID: <ff25f481-3ea3-441c-826e-75c22b47fac3@lunn.ch>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
 <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>
 <13864fbe-6cd1-4d70-afee-bd3d3be163f3@lunn.ch>
 <4254be1a-f80e-4389-b04d-9fd10c1b77b7@amd.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4254be1a-f80e-4389-b04d-9fd10c1b77b7@amd.com>

> > Is this a synthesis parameter? No other switch that i know of has it
> > in DT. The driver hard codes the value based on the compatible. Why
> > does that not work for you?

>   Yes, MAX_LEARNING_ENTRIES is a Vivado synthesis parameter of the IP
>   (256 to 1920), and no register reports it

I assume that will be fixed in the next version of the IP?

Are there many other synthesis parameter which are not exported in
registers? I just want to get an idea if this is a one off, or you are
going to add lots of DT parameters in the next set of patches.

>   The number of ports is fixed by the IP. The switch always has two
>   external MAC ports and one internal endpoint port, and no configuration
>   has more external MACs, so the binding never needs to grow another port.

And that is signed off by top management? The next switch you design
will be a fresh design, no reuse of the existing IP and will require a
whole new DSA driver?

>   The switch node follows the IP's register map. The switch fabric and the
>   two MAC blocks are separate register windows of the switch IP, and each
>   MAC window also holds that MAC's MDIO controller and PTP block. The PTP
>   timer interrupt is shared by the whole switch, not owned by one port.
> 
>   For these reasons I would prefer to keep the per-MAC resources on the
>   switch node
> 
> > 
> > > +        switch@38000 {
> > > +            compatible = "xlnx,tsn-switch";
> > > +            reg = <0x38000 0x8000>,
> > > +                  <0x00000 0x14000>,
> > > +                  <0x20000 0x14000>;
> > > +            reg-names = "switch", "mac1", "mac2";

I ask, because it would not be too hard to swap this address map
around, put the switch registers first, and then the port registers,
and you could have as many ports as you want.

Back to what you just said:

> each
> MAC window also holds that MAC's MDIO controller and PTP block.

So the MDIO controller and the PTP block are MAC properties, so should
be inside the MAC node.

> The PTP
> timer interrupt is shared by the whole switch

So that should be at the switch level.

	Andrew
