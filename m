Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D449362E
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330417; cv=none; b=LmjFEwepclGu2VcHhi5lusb5bYLkHpAqHMO7e0ve34mVDWNGjgb8xKMdN4WNnnfX1mwzXFuIupmOMCdMm2Q91yiO8fiLk+NTE8jID0pu/hRQRj+etDSbNa3C4H7U0bGA1LeKGjSruqrJzp8zEhBSaNjJh4xUClWPkcmZdGjEk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330417; c=relaxed/simple;
	bh=krIjNFDmwrJT5RrKvOhYmZtfUIaj4jTYxlDZuiXsTP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2MlOXwB4jUiioLafkJWEy+5wUrviwFPLG8+hK+Art1XWghnjaFdH4TUpFyD47f7D6XfWbuWz/pr9KzsfSy2VXhp34amS1RvaIdoR2DLuGIe9XCe5Hoi9ypLyXSioLDVVazeODiRnzEIS5ED6PBZZ3cRegMEl3qjoP8ZrhuWODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bMcd9dKv; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bMcd9dKv"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202608211640123b52fa834b000207fa
        for <linux-rt-devel@lists.linux.dev>;
        Fri, 21 Aug 2026 18:40:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6LdCN8NzDzrZlxlx10gtZoWk+7I60n+3MMYtlcuqxbk=;
 b=bMcd9dKvvOlWyh3WwT71xtjxR+P/Lc0WkdnLkmgoZtQfXT4UPhRHxsq1XchYkVkAebI4xA
 PI7gglJrp0TkXd8L8Ms1d3XNYYefC5qiSp1gCpRSTZ5bz9xzhqkmJNQiut4M30bneWJR9kS6
 yGLHzXxrYNvm+e6X0z1t10ppT5UQcwD8Mgp/SLs8DYfIdYICRYG6IxHas0cRajHaO1eqRPZX
 XsrebHGFTcs82AYj1Xhu34N/V8k20u0TUq7i2JOAVawUwtZmvsne3J5YXOkvXFN5VsIcoGqE
 8arcNlOglmxEvDdM3ZyaXdCONkpQWlcT20E6CVj0qeL24mWQQ3FQIXJw==;
Message-ID: <ade455ea48cbb0680945536dc8f05c8db64f41ba.camel@siemens.com>
Subject: Re: [PATCH RFC 3/3] net: stmmac: Migrate IRQ balancing to
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
Date: Fri, 21 Aug 2026 18:40:11 +0200
In-Reply-To: <aoX5wglLYYtLcE5J@yury>
References: 
	<20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
	 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-3-3f79a99cadaf@siemens.com>
	 <aoX5wglLYYtLcE5J@yury>
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

On Wed, 2026-08-19 at 14:45 -0400, Yury Norov wrote:
> On Wed, Aug 19, 2026 at 04:30:32PM +0200, Florian Bezdeka wrote:
> > The previous balancing mechanism was based on num_online_cpus(), which
> > is a problem for systems cpu-isolating workloads. IRQs were targeting
> > CPUs that were isolated for those sensitive workloads.
> >=20
> > With a migration to cpumask_local_spread() we
> >     - get NUMA locality
> >     - honor the default SMP affinity mask, which avoids targeting
> >       isolated CPUs.
> >=20
> > This also aligns with the pattern used by most network drivers dealing
> > with IRQ affinities / affinity hints.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++=
++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index a71f0df263785dd8badc45292ca3067ab33bda05..949ced7e46d2814b57c6bd8=
6b4886ac3bf33996c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3826,11 +3826,16 @@ static int stmmac_request_irq_multi_msi(struct =
net_device *dev)
> >  	struct stmmac_priv *priv =3D netdev_priv(dev);
> >  	struct stmmac_msi *msi =3D priv->msi;
> >  	enum request_irq_err irq_err;
> > +	cpumask_var_t affinity;
> >  	int irq_idx =3D 0;
> >  	char *int_name;
> > +	int node;
> >  	int ret;
> >  	int i;
> > =20
> > +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> >  	/* For common interrupt */
> >  	int_name =3D msi->int_name_mac;
> >  	sprintf(int_name, "%s:%s", dev->name, "mac");
> > @@ -3916,6 +3921,7 @@ static int stmmac_request_irq_multi_msi(struct ne=
t_device *dev)
> >  	}
> > =20
> >  	/* Request Rx MSI irq */
> > +	node =3D dev_to_node(&priv->dev->dev);
> >  	for (i =3D 0; i < priv->plat->rx_queues_to_use; i++) {
> >  		if (i >=3D MTL_MAX_RX_QUEUES)
> >  			break;
> > @@ -3935,8 +3941,10 @@ static int stmmac_request_irq_multi_msi(struct n=
et_device *dev)
> >  			irq_idx =3D i;
> >  			goto irq_error;
> >  		}
> > -		irq_set_affinity_hint(msi->rx_irq[i],
> > -				      cpumask_of(i % num_online_cpus()));
> > +
> > +		cpumask_clear(affinity);
> > +		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
> > +		irq_set_affinity_and_hint(msi->rx_irq[i], affinity);
>=20
> If you want to spread more than one IRQ, you'd better convert your
> loop into for_each_numa_hop_mask(). That way you don't need to
> introduce new function. See the comment on top of
> cpumask_local_spread():
>=20

I was knowingly ignoring this "optimization". As already noted the patch
1 thread: I'm currently trying to demonstrate the shortcomings,
optimizations will follow once we agree on a plan / vision.
