Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5930EF9A
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330229; cv=none; b=DdgY3aoEMaacd3pkuH4jPOcMhtlnSwz01lmOpdmgLknS9asr0A1Izn7ulb4jur2JxkxwGH9DxuA+j2nMcg4RQR8aX1fwAR90iFGicOq6hdJeOHJRyC6de4OSFo5dSJ8UemISALvOW1cifA1mMyr1w1d3K0S2Q8f+kyXpUoTRGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330229; c=relaxed/simple;
	bh=d1xveismnVoh+gsbppNRooB50xePOdQevQlDgtY8kjY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rcvrWD23R97s99TxG7e7uLwNEGhz8AzwJJj1Y6DuAibygQLhDQ5f00B79homtNe42jC9tMnMKxnzXXhtnV0bR1sygd0fg8czcL34m1Bjah0/EQ7jIVSzbzxy2OnRauZ8QaO2an7Xk0Ud/R/Ol/uypjYYFy343ht7923oBoS55vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GinLcmo4; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GinLcmo4"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202608211637003f3e08699d000207d1
        for <linux-rt-devel@lists.linux.dev>;
        Fri, 21 Aug 2026 18:37:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yfG+Ll5zHNYY65Is2tyZ/Rt+y2Qcmys112LwFNGQ7Hc=;
 b=GinLcmo4MqViQsY0YMOV0adGreQymPsYZc2Qh/MpRHeNgYABULfb19cIb6CCS9HcBGYDRb
 9VF7+4O5Cv9q5tspNribDKy6b9C8dNI6zHqVTYLQ/oYeJKsvud82ZupvoM5b/xL8t3l9aF63
 YcAg0YRcJZgCE8sxdGDND0KaARrf043x10kC+1fTlX28Aa31DberPTJismRInP7n87sapxrW
 TOrBBOsYemy5SxnCkCx4HaUhb0MqOZ2uULcY+ZMr5iftUwkItMJ6hClaRrcmFXAJage9WKhQ
 rWTuC4eNcR7JXqr8HXxUPDVZk6JPESugJwBrDw1Yvw1n0rrAvnLvcilw==;
Message-ID: <83c18ac5b726769c36b79dcd430198076b3da1a2.camel@siemens.com>
Subject: Re: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in
 cpumask_local_spread()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes	 <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>,  Sebastian Andrzej Siewior	
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt	 <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, Jan
 Kiszka	 <jan.kiszka@siemens.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Date: Fri, 21 Aug 2026 18:36:59 +0200
In-Reply-To: <aoX4HuUxL4tNWvpq@yury>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
	 <aoX4HuUxL4tNWvpq@yury>
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

Hi Yury,

On Wed, 2026-08-19 at 14:38 -0400, Yury Norov wrote:
> On Wed, Aug 19, 2026 at 04:30:30PM +0200, Florian Bezdeka wrote:
> > Many drivers call cpumask_local_spread() to spread IRQs to several
> > CPUs, mainly to get best performance and balance CPU load. For
> > realtime (PREEMPT_RT) and other cpu-isolating workloads the old
> > implementation was triggering an IRQ placement problem. IRQs were
> > targeting CPUs that were isolated for those sensitive workloads.
> >=20
> > Userland will tell the kernel about the desired IRQ configuration
> > for new interrupts by writing a proper cpumask to
> > /proc/irq/default_smp_affinity. This cpu mask has to be honored to
> > avoid IRQ noise on isolated cores.
> >=20
> > The default for irq_default_affinity is "all CPUs". So all CPUs will
> > be taken into account for spreading when userland did not configure
> > something special.
> > ---
> >  lib/cpumask.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > index 5adb9874fbd0f5a42ea8cd9e6c3729a70599781f..73e7b60a9201174f83df606=
7effbe7d1889dcdb9 100644
> > --- a/lib/cpumask.c
> > +++ b/lib/cpumask.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/export.h>
> >  #include <linux/memblock.h>
> >  #include <linux/numa.h>
> > +#include <linux/interrupt.h>
> > =20
> >  /* These are not inline because of header tangles. */
> >  #ifdef CONFIG_CPUMASK_OFFSTACK
> > @@ -81,8 +82,9 @@ void __init free_bootmem_cpumask_var(cpumask_var_t ma=
sk)
> >   * @i: index number
> >   * @node: local numa_node
> >   *
> > - * Return: online CPU according to a numa aware policy; local cpus are=
 returned
> > - * first, followed by non-local ones, then it wraps around.
> > + * Return: online CPU according to the default IRQ affinity and a numa=
 aware
> > + * policy; local cpus are returned first, followed by non-local ones, =
then it
> > + * wraps around.
> >   *
> >   * For those who wants to enumerate all CPUs based on their NUMA dista=
nces,
> >   * i.e. call this function in a loop, like:
> > @@ -110,9 +112,9 @@ unsigned int cpumask_local_spread(unsigned int i, i=
nt node)
>=20
> Please don't touch this function. There's ~40 users, and we don't want
> to inspect every caller for their intention.

Yes and no.

Yes: Your suggestions / concerns are valid. Noted.

No: I'm expecting a revisit of all those usages. All "affected" drivers
need to be fixed / addressed at the end, so we have to check all of them
and migrate them.

Sebastian also commented on this meanwhile. I'm fine with migrating
affected drivers one by one. Makes sense.

But before we start the migration process I'm still missing the "plan"
or "vision". Which way do we want to go? Let's see if there is more
input coming.

Should drivers really deal with those cpumasks? I don't think so - at
the moment.

Thanks, highly appreciated.

Florian

