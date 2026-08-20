Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BD37A498
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238783; cv=none; b=G33UOanG/AbfVAUMQbE4K2cRHPDSe+3tReLIlKiJPjWDosfKuouHTBDZFpDYOEpseGyjyyIUCaRcUN6lCohwzs5pOvp1igk1MtvsCic5jPtsHnKW7HDbDiuZNHNlnSC7+CDEwWxpRnCQda/Q1NfLyoGTifKsRYwtZFI5h3fuS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238783; c=relaxed/simple;
	bh=cbqnG3DMyrwpxnsNWXHiZn9LCzAndIE7W5YifE88PDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvkasg0SgAtoEGqNMvy+AQX4VhQLqnVTr8RM7T1p/GKY0uZZQJtrm4T+32a6NGty5+TQUdBAVMtMkQkivWr1sTEGToRiLoQSZob7HysngzHoRyTRDqIuLD3HfA7D0QTyhi9LODzo3iBZJOl7xeu5PHCKo0/+EOXyl5sT97eaO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ebvlP+j6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0A0vBAJL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ebvlP+j6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0A0vBAJL"
Date: Thu, 20 Aug 2026 17:12:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787238779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbqnG3DMyrwpxnsNWXHiZn9LCzAndIE7W5YifE88PDY=;
	b=ebvlP+j6W3N3VZOYkqOXtyBjSDxTIkLWGo8hBYhqXMqO8RyvjYoztFkOeXPaTb63NTH7Yn
	xmE17shxKckpIdarz/KY4TQMei0BrJ76UDYynjcFcosT73SfxdDjx34XcWsRxnbGGmk+m/
	eRs7LN1UKEMf7WxwsV8OJsA8IoaEzcw47iULE2orQtPjdjp96Acn13EvRscEZQSdBDKsLf
	SH/4RYiVoKiWMj0QXsJNC0k1+1I7i4cb9CYql2Xq1lsULcVXY2I+oT3BQ2Ctn0zLEsh/DA
	vZe8HN4KGcV8dPJnwJ1BqNV3xis0yefjhnO+aaJdU88MbhQGPWE39r1uF2FazQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787238779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbqnG3DMyrwpxnsNWXHiZn9LCzAndIE7W5YifE88PDY=;
	b=0A0vBAJLYsxDfMa0hzZKbBIqFxDDFr8x8En/dsyxHUEBFmtlIsvduZX+/h1Fa+j46nSZFv
	MbD3+qRtpxXUGfCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 0/3] genirq: Allow drivers to respect userspace IRQ
 affinities
Message-ID: <20260820151257.PtSDccEP@linutronix.de>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>

On 2026-08-19 16:30:29 [+0200], Florian Bezdeka wrote:
=E2=80=A6
> The typical shortcoming of those implementations: They do not honor RT
> relevant settings like the smp_default_affinity or isolated CPU cores.

"irqaffinity" if you refer to the boot command argument.
"default_smp_affinity" if you refer to the proc file.

> Device IRQs are balanced over "all" or "all online CPUs".
=E2=80=A6
> That raises the question why request_irq() is called on "link up" time,
> while the low level vector allocation takes place during device probing.
> At least that seems to be the common pattern. Can someone tell me why
> this is done this way? Shouldn't we call request_irq() at the same time?

The IRQ vector is created while the system enumerates the IRQ-chips.
Once the devices are enumerated (such as the NICs) the devices is linked
with its IRQ. I think an exception are MSI-X devices which could ask for
one or more interrupt and then (at device's probe time) the PCI core
will link the requested amount of interrupts so their actual number
could change.
The driver _could_ request a "managed interrupt" which would be mapped
to a specific CPU. The difference to a "regular interrupt" is that if
that CPU goes down, the interrupt is not "moved" to another CPU. Instead
is remains off and the driver needs to deal with this (this is common
for NVME devices).

If the device is not programmed (as in IP address has been assigned,
link is up) then it should not create any interrupts. So it might be
reasonable to not request an interrupt either.
I *think* uarts do the same.

Sebastian
