Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E55470EA7
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309596; cv=none; b=gTWLGnGWc1GRiIR9J3hIAf/4I8MaqX57cvWvTmlCx1hbEAIqPKR1/2MgQ4x16tWa0GS+RrCJeltMh+dn4HaAcbRuyQJA7ILfQcWDBMbZLLyNE6Y7n2VgsDWkfYXH0bPMkZD03O8fsjhkZCRD3KWVQU6doHyy75R72EUYfbnbgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309596; c=relaxed/simple;
	bh=db9tvE++slmSkBi47GlKRkGxKG6uu119fd5Trvcau+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNE/7OZaKCc+lqXbopTcmNE5uxzngPHCeuw0MNNatweARFhgA1mvYVlgnLn19gt8QoCfl5zfff1KNmEejTfgvtLKnrThW/CCdmjofCG4gAOsWnYEKBou8rhMKuQd2NvHl5pWt5HfAbrx2ow5O4UT/XqHBtf4RA2BuVLlOuiNLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sm+SplkN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4d50prHH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sm+SplkN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4d50prHH"
Date: Fri, 21 Aug 2026 12:53:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787309591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOfj9iWnujkJXGCKkSSLRpyruq4aYxWH0TC7ipj0KRA=;
	b=sm+SplkNZFrICX9Fb0x5cjvPTX1Nl43EIl5/jxIR8+H/Ke9ZRXCd+ZHXX2mFhfFV112VOR
	mIrG9UoLse0L+L/A4T5ZDTAhUY1olw0NBYiKXRCC1yQ6JVHChCsE1QtT3V92ABG3gwAX5B
	sHXuB/ytWthEyT+8WDmPoTsl2Y+mXBFhsA0BfKayGRBy1YP9s7X4mvflbzxC3Xw2KCSrpe
	xjOslBkfF2qeUfsFwTe2EsSUWIHs7gJSNOaP17sDQTVjfiQMvQ0X1DIKbXiREPzhEkgbZG
	5JGdMmYLXwNfEJy6EcfSVX5OcGVmwRXfISpLWyUHmxfQ+o4EaTZ881Wus2MmwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787309591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOfj9iWnujkJXGCKkSSLRpyruq4aYxWH0TC7ipj0KRA=;
	b=4d50prHHZbcMsOnjLv+aq7L6GtmqE62MkA8FN7P6Pd/xcbYtjFbFbWZZ4hi/ZD3dhty1Z/
	ixTUDOIrkQ46E0Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when
 setting affinity hints
Message-ID: <20260821105310.ZRK2TO93@linutronix.de>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
 <20260820094153.420202f6@kernel.org>
 <11c2d3c4-ea05-46a2-8579-c5aba1bfa204@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11c2d3c4-ea05-46a2-8579-c5aba1bfa204@siemens.com>

On 2026-08-21 12:38:52 [+0200], Jan Kiszka wrote:
> Fully agree: drivers should not set affinities. They should just express
> desires or additional constraints. The ultimately resulting affinity for
> an IRQ should be the result of the various constraints that kernel and
> userland may express via NUMA placements, isolcpus, some dynamic
> isolation/grouping constraints, or you-name-it.

You might want to look at irq_create_affinity_masks()/
group_cpus_evenly() which attempts to spread irqs evenly across CPUs/
NUMA nodes. This is used by storage is considered a bit by the
isolcpus=managed_irq option.

> I think we need a big picture how things should eventually look like and
> then develop a strategy how to step-wise convert existing code.
> 
> Jan

Sebastian
