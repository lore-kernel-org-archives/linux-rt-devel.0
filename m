Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DF2CCC5;
	Thu, 20 Aug 2026 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184627; cv=none; b=APs9lOpL2lfpXJDbusJR8PvsklCPxBY/jRXOy3dhrb/5JmiMqPYfoGl4MzisaL3qFiEqjHbhowl7+kQhHi7sru6E2Q1EUqP0cANbZM6wiq4cxHrLFIYTqYMtV8ndObdAKYX24pguu+Iemz4IdG/HHdRe6Fazf5wdeIj9jDkX5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184627; c=relaxed/simple;
	bh=44dklYvNwahrk/8pWUk3I8bYISLwXbQOG/Uz8rGurpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8mP3QdogYiopGmcX9p9mBTzwEFFla2iqUSHacCRNsb1utqMfbZlmDeZSmxZgRx53HMcrXyaBGCBFZQ83MxeRX3tMMU/x++IW1EbvsvaTcCfhv+YNPwhYpvG+LOd6q+8mXVj31RfMDBHKzxCRES8PJevQI54pF9gh/OwzRAZvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WMzYWbaJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WMzYWbaJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h+6YnfbtFXq+5phCL6kCmC7VMexSnRSAnihIp2uj5mM=; b=WMzYWbaJarzzuCbNAvQFy1az0K
	+6KIQJLumJHELEx/vana17eKjjcNti5/SqdDo8XQqP6Aj2jUfArCN6moCuCXhywCtdMak+euoT5l9
	qlyF27dOMFc+pO5cS4hzXMAMSMFuspS1hx/yPZUgCpMhluxm2ZhoDKrS5pXRTBx5YZa0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwqMB-000gd3-L2; Thu, 20 Aug 2026 02:10:07 +0200
Date: Thu, 20 Aug 2026 02:10:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 0/3] genirq: Allow drivers to respect userspace IRQ
 affinities
Message-ID: <babe3284-1813-4190-8478-4777a28af13e@lunn.ch>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <f9daddae-a1c3-4823-a4b0-733775e1ad15@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9daddae-a1c3-4823-a4b0-733775e1ad15@lunn.ch>

The problem with using stmmac as an example is that it is very old. It
was added to Linux in 2009. I guess most of the SoCs at that time were
single or dual core. CPU affinity was not something developers thought
about for that class of SoC.

Over time the number of cores has gone up and stmmac has got faster
link speeds. But is the architecture correct? Is the driver following
best practices?

I would suggest you look at more modern MAC drivers and see how they
do CPU affinity, etc. Is there anything which can be learned from them
and implemented in stmmac?

    Andrew
