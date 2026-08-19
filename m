Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F85379966;
	Wed, 19 Aug 2026 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183723; cv=none; b=Vpa0zvS2ZVlVxDOzKWbPMSajAYfs+oFSnLTj+N9pV2g4cR4GVAY1rB9SBnT/9EnknRY+ezOyupwZshPp6yJ6NiYhfsl6mfSNsrsGtKasReo/snSVzRfBravpaGVOnzYO/dAKh9ij+qocoJQx9TjJySgjZFXEcgJsJrFugTrFv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183723; c=relaxed/simple;
	bh=ZvSwY/ESJu6HHgufvmFOKtaGocbvd8GFS/0KK+n1HcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id/QF0kRgCNWvi13Y8M/QU+QuyRQJ+EgF2mMXiow426KBaeVM9Q3FnBWmjVplKaB5ilQXwKpr3yfR8XVl3Ghk69lWMrkB8btxDUgkZFfzSNyyPzwTOZCpk86kFGa6oT+GoPt655TZ/Z3F3x+NY8tznq7qFiDAzUjyY9CU4vPdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f4NPHUNe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f4NPHUNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EdhVXUR+0KpkhVK+tZRcWte10LXPPnzPcT5smFSUy14=; b=f4NPHUNeiQyY5Od+U8FLfr0RrN
	ZkKrRm3Frs6Gv99IdtitR9asr1W75yPzvNICjHc1zGx/YVXHov92ps9ANnhIzTMV884k5O6GRdCSV
	UPtDzorDHguWopZR5z5noTkQ6CkbucMzgrg7RhhD6ZYX/7we1wYpL931eLdB2MJiTKH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwq7O-000gXa-JL; Thu, 20 Aug 2026 01:54:50 +0200
Date: Thu, 20 Aug 2026 01:54:50 +0200
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
Message-ID: <f9daddae-a1c3-4823-a4b0-733775e1ad15@lunn.ch>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>

> That raises the question why request_irq() is called on "link up" time,
> while the low level vector allocation takes place during device probing.

If the interface is admin down, the hardware should not be generating
any interrupts. So there is no need to request them.

> At least that seems to be the common pattern. Can someone tell me why
> this is done this way? Shouldn't we call request_irq() at the same time?

If you want to change anything, move the low level vector allocation
into open(). But you need to be careful of EPROBE_DEFER. If the
interrupt controller has not loaded yet, i _guess_ the low level
vector allocation will return EPROBE_DEFER, and the MAC driver will
try to probe again later. If you get EPROBE_DEFER in open(), there is
nothing you can do about it.

	Andrew
