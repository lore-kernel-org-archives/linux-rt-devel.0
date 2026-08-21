Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D037CD5A
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332187; cv=none; b=Sg7vJOB9yZx8NogrBwpdAswaIaqvnPP+QnTlp+pryugfsjpjTq4Gw1BXGIcsmKq/pT8tnl5eSMPql3vksFW1gWfnbhCYtRsPx6Mqr3AQc2oOeHpf7VSf1uRtOjZMncrHxz0zRTo77EJH4dgO/fl4tGTYxMQSEBJaLnjYBX6HGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332187; c=relaxed/simple;
	bh=9jceV8GWg7QKoT2S9jzE2yIaRi4gCVIvVVvYYQ0T12s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sRyjlP5u9ixD58HfSBE1239cltWokjRL4UBiMXAq2LzCK176D/8cDGAJhb32TqaBLM2mHX+AjgZ7ImPiwrjuW9g7KHnARVXitFaMLmhz882wsmDmMN+vfkG1GIq43tD4nibOSf05P0mxB3l1ZwOXoITXwUOOsEGyF0B75rykqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cmDkdPV5; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cmDkdPV5"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202608211709393a9457f97700020738
        for <linux-rt-devel@lists.linux.dev>;
        Fri, 21 Aug 2026 19:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9jceV8GWg7QKoT2S9jzE2yIaRi4gCVIvVVvYYQ0T12s=;
 b=cmDkdPV5s72BdBlhhmdr6WXRAhPPbaucm/KAT541DBmUBJ5hs8lFnOAvSixOhFI6Pqm9sQ
 Ux6VtcMnZEfZgqk2sZAOIwdUfGtqcZCUW87MpGdHMXUoxeU0KLBLTKZuiWj4rphDXVnBd5P9
 S+f3P7LI7MIniBMc0RzDMrGCKq+OohE8DMSJuRlcxkaw2dfB4lIZZCjms05t8AcbJlGYhZcQ
 6HEh0oU9ZNsVL+5p8DEG43tW4baZ9cNBL2Wxh5spQj7oEIEoJwm/dRjx0D2PSucn2WeCg4tV
 Fqa5dtAsvONixCcnjkhR25tENl8V3yDLo2NyWKzW+lyc3GY+NdvyFrzg==;
Message-ID: <266e0284688fe0d5002cec50d7d18a575f20e4f3.camel@siemens.com>
Subject: Re: [PATCH RFC 0/3] genirq: Allow drivers to respect userspace IRQ
 affinities
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes	 <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner	 <tglx@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 netdev@vger.kernel.org, 	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Date: Fri, 21 Aug 2026 19:09:39 +0200
In-Reply-To: <20260820151257.PtSDccEP@linutronix.de>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <20260820151257.PtSDccEP@linutronix.de>
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

On Thu, 2026-08-20 at 17:12 +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-19 16:30:29 [+0200], Florian Bezdeka wrote:
> =E2=80=A6
> > The typical shortcoming of those implementations: They do not honor RT
> > relevant settings like the smp_default_affinity or isolated CPU cores.
>=20
> "irqaffinity" if you refer to the boot command argument.
> "default_smp_affinity" if you refer to the proc file.

The latter. Sorry.

All the system configuration has to happen during runtime, not during
boot time. There is no "fixed" or "static" configuration that is known
at boot time here.

>=20
> > Device IRQs are balanced over "all" or "all online CPUs".
> =E2=80=A6
> > That raises the question why request_irq() is called on "link up" time,
> > while the low level vector allocation takes place during device probing=
.
> > At least that seems to be the common pattern. Can someone tell me why
> > this is done this way? Shouldn't we call request_irq() at the same time=
?
>=20
> The IRQ vector is created while the system enumerates the IRQ-chips.
> Once the devices are enumerated (such as the NICs) the devices is linked
> with its IRQ. I think an exception are MSI-X devices which could ask for
> one or more interrupt and then (at device's probe time) the PCI core
> will link the requested amount of interrupts so their actual number
> could change.
> The driver _could_ request a "managed interrupt" which would be mapped
> to a specific CPU. The difference to a "regular interrupt" is that if
> that CPU goes down, the interrupt is not "moved" to another CPU. Instead
> is remains off and the driver needs to deal with this (this is common
> for NVME devices).

I can't see yet how managed interrupts could help here.=20

Those device IRQs can happily be migrated, co-located and of course we
want them to be configurable by userspace (/proc/irq/<n>/ interface),
which is also not possible for managed IRQs.

>=20
> If the device is not programmed (as in IP address has been assigned,
> link is up) then it should not create any interrupts. So it might be
> reasonable to not request an interrupt either.
> I *think* uarts do the same.
>=20

I'm fine with that - and thanks for explaining the current
implementation again, it matches my understanding. But: There must be a
way that userspace can configure affinities for "un-requested" IRQs
already.

As already mentioned the /proc/irq/<n> interface gets populated on
request_irq() time, which might be too late to be able to set an
affinity before the first IRQ arrives.

Please note that the default_smp_affinity can also change during
runtime, so that we have to honor the current value each time we do the
balancing / spreading.

Florian

