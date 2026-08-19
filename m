Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7743C7B4
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149849; cv=none; b=IDbXBx8t25F7iztzhQnpeY5wZT+fdjxCrW7x0TjgCNXw0mIMzP03aH4gQ6LXXYqIQJ2vTMmM+sa5DFtJZzN1OgaORcIz8t18O2xw3Neqq/RUFLRsNnyH2/wbTb9URlOQAJsm6ulg98bnuyWQy9ben1bbNUHUGc4ze8sWn6K+x8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149849; c=relaxed/simple;
	bh=hJGlbD08V5bAnxEZzKNlsO5pVSOIsE1Mfo6bzTFTbLc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IvSl4uR8n5bIfWkiKWw9nGIhCmgj7IGJNMACfJkw8aYL3bktR/lW+gEs10PYhBgD+9NMh96mI+4Hbg4VUxyk6Iy/lrbvFElZ/93ByshFkkG5DgQMPHno0vI9MsErBExb6Q76U/8ohhRnXC9JEsd3em80OyX93SFDdKySPj1SJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gWgRMMy+; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gWgRMMy+"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026081914303351531f506400020716
        for <linux-rt-devel@lists.linux.dev>;
        Wed, 19 Aug 2026 16:30:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=T8WkfQM1tDVw2lkM35NPqGVyDI8QletmxFw9B3FKiUQ=;
 b=gWgRMMy+C5iSzZsNMMtXSW4NJ+nq3LO8TPIBRLAx/JbrEhLC0J3Nnm7XBArhljqyzSW+u3
 Tu9KMbU2xB6trqXGd+9EFFVta9Uj7P5Ks0Y1011Y9Z5iGtfG6yAIeX56ROZPZfGwdwIceV7R
 6csKI6RJc+CAKjtzXn8HnaZh5OlLFF2adcNhETAnG8e7VrRkRXxril5+F1qFVneaFu1bsDh7
 knd19UbEnWRgzDHznVkTXUC7Cvdc9TVSKS1GN7BdFkLcBtELOWONJGHGiM82HNVFxOSXeRYA
 7vPAM7Fu/PlbH8yyx8NgP/kIeIPSXoeXJRRzAqWJ2A6SPpaCHkTCBBEQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC 0/3] genirq: Allow drivers to respect userspace IRQ
 affinities
Date: Wed, 19 Aug 2026 16:30:29 +0200
Message-Id: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAW+hWoC/x3NTQrCMBBA4auUWTuQhKjVreAB3IqLoZnRwSaVJ
 P5ReneDy2/z3gyFs3KBfTdD5pcWnVKDXXUw3ChdGTU0gzNuY3prUMYJE1fcosNId8ZSY6QBAws
 9x4okoknrF+lNmZGsX5PfeRt6gRZ9ZBb9/IdnOB0PcFmWH8+Pv22FAAAA
X-Change-ID: 20260810-flo-net-7-2-make-stmmac-default-affinity-aware-a145a4941d8f
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

I'm trying to demonstrate a real problem for PREEMPT_RT here, using the
stmmac driver as example. There are more drivers "affected" but let's
ignore that for one moment. Let's discuss the underlying problem first.

To achieve the best throughput most network devices are based on
multiple queues. Each queue (pair) is equipped with one device IRQ. To
reach the maximum throughput, spreading / balancing them between all the
available CPUs makes sense.

While some IRQ chips - and with that some architectures - implement the
necessary spreading (or balancing) at IRQ chip level others don't do that.
If a device driver wants to make sure that balancing happens as intended
it has to implement that on his own (again).

The typical shortcoming of those implementations: They do not honor RT
relevant settings like the smp_default_affinity or isolated CPU cores.
Device IRQs are balanced over "all" or "all online CPUs".

That's not a problem for "normal" systems, but for RT systems - or
systems running cpu-isolating workloads - it is.

IRQ affinities can be controlled via /proc/irq/<n>/smp_affinity{_list}
for existing IRQs and via /proc/irq/default_smp_affinity for "new" or 
"not yet registered" IRQs. Those settings - as written by user space - 
must be honored. Always.

In our case the settings were bypassed by the following sequence:

    - system boot (all CPUs available, no isolation yet)
    - deployment of the first RT application
        - writing a new default smp affinity (remove RT isolated cores)
        - migrating away all that were targeting the now isolated cores
        - creating a cgroup with RT cores as the only usable cores
    - RT application running fine for some time
    - stmmac network interface went up for the first time
        - driver balances IRQs over all CPUs, ignoring the existing
	  affinities
    - Too much IRQ traffic on RT cores

Even with series applied there is (at least) one problem remaining:

The /proc/irq/<n> interface is populated on the first request_irq() call. 
That means that we can not control affinities from userspace until the 
IRQ gets requested.

The problem for network interfaces: We have to bring up the interfaces
once, to be able to control such affinities.

That raises the question why request_irq() is called on "link up" time,
while the low level vector allocation takes place during device probing.
At least that seems to be the common pattern. Can someone tell me why
this is done this way? Shouldn't we call request_irq() at the same time?

So, let's hope that all of this was short enough that somebody reads it
and precise enough to make the problem clear. The idea behind this series
is not fixing or applying the series as is. I'm expecting a discussion
first. So, input welcome!

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      cpumask: Honor irq_default_affinity in cpumask_local_spread()
      genirq: Honor existing IRQ affinities when setting affinity hints
      net: stmmac: Migrate IRQ balancing to cpumask_local_spread()

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++----
 kernel/irq/manage.c                               | 10 ++++++++++
 lib/cpumask.c                                     | 10 ++++++----
 3 files changed, 33 insertions(+), 8 deletions(-)
---
base-commit: aa2e13ae8d3cbe2c15ef4f7e971b2de0832794aa
change-id: 20260810-flo-net-7-2-make-stmmac-default-affinity-aware-a145a4941d8f

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

