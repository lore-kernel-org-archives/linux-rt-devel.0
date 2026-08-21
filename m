Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41485386562
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333457; cv=none; b=MrbszOTTPGf977jIbMpNanpSl4o4XshJUcnPR6iGihC/tYXXmorUq1o0oHNL4S1tsHJfsxIO+B7GMgkcmlDrQEX4UG0YItaKBMRZQ3jv1AecmfOyzfVCUNxSyEnXGE9bdRc6VgeydzCj+uOKI1+e3O3yLJwTXCh95cwdhmPIRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333457; c=relaxed/simple;
	bh=Busq7bBd83wJI8JtXzPnJLO7cdNRm+myeGSGFtSRJng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUlVKSd9tn7OMtJCnvpw2ZOUu0gx6cetvugxY0ChJ94edxUdWZnGHP0bV0rnQE6Q7yutPF+fij/P4+uGdB2F7zFCkaJ1aFX70Wm7N5rzk7V9I4anJL2bf4EzXiKlXE609fghwLKr7453TpZMbJ+gycjy50fw1XF27/lnxkukKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PzM66+4O; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PzM66+4O"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026082117305154e0f3a66d00020772
        for <linux-rt-devel@lists.linux.dev>;
        Fri, 21 Aug 2026 19:30:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Busq7bBd83wJI8JtXzPnJLO7cdNRm+myeGSGFtSRJng=;
 b=PzM66+4OwB265jh6TgPYagsGzvQfPSfsDnBTN6kZ/k22GR0GNOM2Pp2i8P6nHviC9p7N0H
 M08MkMhK1U2pLnaV+WRAMbEQHI140i9NbytDRugVeMd03b6rCogUGXh0u6JOi77b/Q4upOms
 Md78DIwWIQERBcSQpHTGjDiG0Rfd8KSrUbwzii31PgHglklSa8nEwk42E1Ei5nqg3jkwf6c/
 E16hYqHAYWwTKQXBxzswEbSPuKEg9MRkZlWVijfRlZ5fnTRSxToJ5ObFrsKB7lSjjaQqUeXv
 vWgMxYeL0hFxjHKw6ZUNLvkFA3FOCNNOl3grNMX2F6xcXTpbhyw3JNgA==;
Message-ID: <6e82ad58a9d7148a3ed614037edd5150f84c0533.camel@siemens.com>
Subject: Re: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when
 setting affinity hints
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier	
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Yury Norov	 <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
 <akpm@linux-foundation.org>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt	 <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Fri, 21 Aug 2026 19:30:50 +0200
In-Reply-To: <20260821105310.ZRK2TO93@linutronix.de>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
	 <20260820094153.420202f6@kernel.org>
	 <11c2d3c4-ea05-46a2-8579-c5aba1bfa204@siemens.com>
	 <20260821105310.ZRK2TO93@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

[ Might be a resend, got some HTML warnings for unknown reasons...]

On Fri, 2026-08-21 at 12:53 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-21 12:38:52 [+0200], Jan Kiszka wrote:
> > Fully agree: drivers should not set affinities. They should just expres=
s
> > desires or additional constraints. The ultimately resulting affinity fo=
r
> > an IRQ should be the result of the various constraints that kernel and
> > userland may express via NUMA placements, isolcpus, some dynamic
> > isolation/grouping constraints, or you-name-it.
>=20
> You might want to look at irq_create_affinity_masks()/
> group_cpus_evenly() which attempts to spread irqs evenly across CPUs/
> NUMA nodes. This is used by storage is considered a bit by the
> isolcpus=3Dmanaged_irq option.

I'm aware of those functions but faced the following shortcomings
regarding timing:

1) irq_create_affinity_masks() is called on probe() time, which normally
is "boot time". Userspace is not up and running yet, so the
default_smp_affinity was not properly set up.

2) You can not overwrite the affinities set on probe() time until
request_irq() populates the affinities to /proc - and with that the
interface itself - at open()/"interface up for the first time" time.

If the default_smp_affinity changes until your interface comes up for
the first time, it might violate the current settings already. No chance
for a user to correct the current (device) settings.

>=20
> > I think we need a big picture how things should eventually look like an=
d
> > then develop a strategy how to step-wise convert existing code.
> >=20
> >=20

I just received the confirmation email that my abstract, which I
submitted to the Linux Plumbers Conference (Scheduler and Real-Time
micro-conference), has been accepted. There will be a session called
"PREEMPT_RT: How a simple interface up event might break your realtime".

Seems we have the chance to discuss this topic in person.

Florian
