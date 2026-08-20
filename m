Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8847CA98
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242196; cv=none; b=CIF2N8zj3bRJ3q6Gtxk01GLhC6InVQoT8ZuZN+80cuqhlhfBZ5GU6KTvaKkzDdRGcZrlvQVTkpJmOCjeUL3r+RUStPMx/r5QGDz8sMX4k1EFNZOXj3m1wPifDBri6IZYxpnmY+TiJuUgPMxmo+pJbwmcTMXw+L+EbHtwCniEDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242196; c=relaxed/simple;
	bh=5aRGU9vWPER+b5x/MCisqe628w8uYw23N5FQg7fQ1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwahqcJjHawPrxUymlhTZ2X986IKpTVoCckyG+tu6rsiBHOGvd3aEzfAYKRT1jPcaBnzTsHxPzErVkkPw9Zuy5D/RjRUOnR8FYuVW4q56UpY8GluWSxVbfUFPXmCTsA0HIPz425lWL3aF3eKuWVBKuoVm0BvE13xd6stn8bjSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2F0JLV9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2SFSveA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2F0JLV9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2SFSveA"
Date: Thu, 20 Aug 2026 18:09:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787242189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNc95hCETK4CO1l/jXeVB1uxPt8EvO+gdfuwmtQcpo4=;
	b=2F0JLV9j+HGy00kK79fVfiCqoBAsyUzEEyHd3YsfJINiGfA/SUr3zJQ6P7spxpXAOmBSZy
	4X07nXe4Oeh2P0pOsNEwh9THqBYaTbbNOqIiVs2BK/CaF61gOB3XeGhx9igTFP264BylYz
	GrOuyXSYuolOV0ZHjds4/v95mXrdbs85LffijwDvTjVQGnyGii7uZoLnraXX73vOUNLWjR
	Sz3jkfWIGycPDbi9552i07r0MEPdWtcuY3B+H/A3Y2S5cMjX1K9rZBQo2zXb4D/zRVzAkx
	9QWLr/LHqkfpsq6ks+gcBdGdOCfeBZYg7trdp7tcG+C4TM4Tg/JfKB/QnaS79g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787242189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNc95hCETK4CO1l/jXeVB1uxPt8EvO+gdfuwmtQcpo4=;
	b=G2SFSveA3vHYyq3ELy6PjB9JFohOWIrbAVZ2upl8tWLLL39V1/V84+/ODLc1BIcuWr/KCF
	ovlSFT7RLDRJkbBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yury Norov <ynorov@nvidia.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in
 cpumask_local_spread()
Message-ID: <20260820160947.GZ5F-O0o@linutronix.de>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
 <aoX4HuUxL4tNWvpq@yury>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoX4HuUxL4tNWvpq@yury>

On 2026-08-19 14:38:22 [-0400], Yury Norov wrote:
> > --- a/lib/cpumask.c
> > +++ b/lib/cpumask.c
> > @@ -81,8 +82,9 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
> >   * @i: index number
> >   * @node: local numa_node
> >   *
> > - * Return: online CPU according to a numa aware policy; local cpus are returned
> > - * first, followed by non-local ones, then it wraps around.
> > + * Return: online CPU according to the default IRQ affinity and a numa aware
> > + * policy; local cpus are returned first, followed by non-local ones, then it
> > + * wraps around.
> >   *
> >   * For those who wants to enumerate all CPUs based on their NUMA distances,
> >   * i.e. call this function in a loop, like:
> > @@ -110,9 +112,9 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
> 
> Please don't touch this function. There's ~40 users, and we don't want
> to inspect every caller for their intention.

While this might be okay for the NICs, the usage of PMUs shouldn't be
changed. So yes, Yury's suggestion to create your own function and then
move the drivers one by one makes sense.
You might also want to verify that your setup/ design works on some
"newer" multi queue NICs even after the number of queues is reconfigured
at runtime.

There is also netif_set_affinity_auto().

Sebastian
