Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576193;
	b=XY0yOZmELjcc5nIP4FVVMXz4/VEPbjsaGIKXa6te//XXEIQbznETOXsBo2rvPQNa3TzR
	 ZSZDoUsX6Y+dQXF/vtu9D+wF0ZBA48c8XlgmsWAh1uPrlMu78zNTVE80WvA9h8BhnmMWH
	 5fYPHEYia2cJ9wk/hLITnmoNMDOimhMsX1O8R235PBkAV3j7SKCaADspq+Fu3k7dC34aI
	 IK/Jc6ODEbwX5OjHczou/hqgMXAh3hpWaaS2v3xGMxelOLLM0M6Vtex4kSG9mADgzWUut
	 Zm6RoF7V/pYQ+g92McGNCsGAoAM+6lWaVhO4csJKxF2pylg4479y/qhgpPs0yMOU2fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576193;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=pgnL/CHFfqdgibA2xLO5Ol3JFtq2ELbceyHKqknut+A=;
	b=alt3NHJ8qMK7TA9VKsuNcWlU6SlN0l5+qSXldRBQlSzGEgeschW4JSulbBzXJQMH2F0m
	 WP2wTCCfmQofgH2efmLKtroNOXRtvVfs6adeSd+TQGtHrqH1YlihV04kmjhLvfYUInboA
	 kCzTXE2I0yD1BdX58Qx0cq/TX9692+fSQNWKcHTUFxonFAV/+tGLoDcz6fFH9+1EiGx74
	 blOLkYqaMc9iyTOcy4QkJbhJdmV3mjnYkiyNeeG2EKMvLT3BFPS2IclrEG4p8FJXnULVv
	 +MoK9dKp/ASOBw1uCZLo+BUhru4TF3t61xG+13lbhglZ/xnwIWtXgdY8+3ivw+en63w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=DXoAoXBd;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AC606CA97;
	Fri, 13 Nov 2026 13:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4AC606CA97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=DXoAoXBd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pgnL/CHFfqdgibA2xLO5Ol3JFtq2ELbceyHKqknut+A=; b=DXoAoXBdGfEwfE0rU4WH8aeFvk
	JgiK9eEoPm46AjX+lk1gLkj4j4S2HYcwMpdvUc8ljAF+fN0BUdId98qFliIeIXoi7cuSG/YQ0VF2L
	aNlIh9L3yhvoxqeDf3Lu/tZdDO1ITffT1GHxbyiKo7ebryk4iJflZGAqeIKxDtYtkfq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRrFA-00GHWM-Sv; Fri, 13 Nov 2026 14:23:04 +0100
Date: Fri, 13 Nov 2026 14:23:04 +0100
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
Message-ID: <8098f68a-bcc0-469c-be50-47403d3117ca@lunn.ch>
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

> +description:
> +  TSN Endpoint Ethernet MAC IP implements IEEE 802.1 Time-Sensitive
> +  Networking (TSN) standards and provides low-latency network connectivity
> +  in the Bridged Endpoint configuration. The IP integrates a three-port
> +  switch, with two ports connected to the external network and one port
> +  connected to an internal endpoint. It also supports GMII/RGMII interfaces
> +  for connection to an external PHY, enabling full-duplex operation at
> +  100 Mb/s and 1 Gb/s speeds.

Sorry, after reading that again, i realised i asked a wrong
question. All PHYs are external.

	  Andrew
