Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90134257ACF;
	Thu, 20 Aug 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236250; cv=none; b=ukmqV3SA1HUT8dtaB08zu1hl9QKo6cpusD/Bbb8NuLZ4ifnH6lb34sgkL69RSpLEkHHXh0X2Hyd1hypUKFOjCmT4LvqrZf22IJS282YBoe5TEx+eVXZ2vSjefE4U/EqJBsNgPZKciWxIEPGFSAwiufF+ZwCsTTd294LutDpxbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236250; c=relaxed/simple;
	bh=9aaxE97+oQRXrhjSM85FHx4njn95iqVdIPkEFYCm3pc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D5Xi7BiSJ3Fz0O6usCOPF2M2tIPRXWz0zbhzyNeAKAZHP3fEe9Gp5IQ3NrAOA+y7701Mm3Y4UXDSxg+LhXm3qkx2Wtk9llY65Z22Wptm2COShyNiJ4xehrj6uRgdmNryB1aSDvBjjUwq9SvQQ8wt8eg513jmlyvbqUEa2XU2mXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrIS9vdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrIS9vdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCB41F00A3D;
	Thu, 20 Aug 2026 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236248;
	bh=iv2BwpEqkq8xesVA2JI9pCA1ndLUgNjsOMjiQpTW+/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrIS9vdGCjRRQPW+ayn6bxj4rvIYj+JJ7qW6d3JizJB5sgmWJCE8Dcy1iIuSZXjlg
	 3SgBAJf3ok8JkgyOufspQZ49GOr/UhX4xQ6kuT2Q5TxKXieN6oKzQJNR1De0AAckUK
	 AMvaHMWWZ4aGS81E2/t3eF7t0XX5c6gLASDv6DUrXzcSVkE2VNmx17UBhQy/eYs0FL
	 jvuuxJaLpfRH4vv6JBYNVKI9A+W4wZncEgT3PiYbgv+MzGWsAjzx/q+kN9R7r0QjnI
	 BhqjFCZsDQTMj4aM/tQplZ9Df5GRR4SNemGAokx7T20YGdDJMaHrNYzxv0Kri7/SkD
	 +An32cf2HsxLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] net: stmmac: Migrate IRQ balancing to
 cpumask_local_spread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-3-3f79a99cadaf@siemens.com>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-3-3f79a99cadaf@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:30:47 +0000
Message-Id: <20260820143048.3DCB41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The dynamically allocated cpumask 'affinity' is stored as a po=
inter in all IRQ descriptors via irq_set_affinity_and_hint() and then immed=
iately freed, leading to a use-after-free when the affinity hint is read.
--

--- Patch [3]: [PATCH RFC 3/3] net: stmmac: Migrate IRQ balancing to cpumas=
k_local_spread() ---
commit 490c157da6154ac1da229e94e4e1cd92226addfa
Author: Florian Bezdeka <florian.bezdeka@siemens.com>

net: stmmac: Migrate IRQ balancing to cpumask_local_spread()

This commit migrates the IRQ balancing mechanism from num_online_cpus() to
cpumask_local_spread() to provide NUMA locality and honor the default SMP
affinity mask, avoiding isolated CPUs.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index a71f0df263785..949ced7e46d28 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3826,11 +3826,16 @@ static int stmmac_request_irq_multi_msi(struct ne=
t_device *dev)
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	struct stmmac_msi *msi =3D priv->msi;
>  	enum request_irq_err irq_err;
> +	cpumask_var_t affinity;
>  	int irq_idx =3D 0;
>  	char *int_name;
> +	int node;
>  	int ret;
>  	int i;
> =20
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> +		return -ENOMEM;
> +
[ ... ]
> @@ -3935,8 +3941,10 @@ static int stmmac_request_irq_multi_msi(struct net=
_device *dev)
>  			irq_idx =3D i;
>  			goto irq_error;
>  		}
> -		irq_set_affinity_hint(msi->rx_irq[i],
> -				      cpumask_of(i % num_online_cpus()));
> +
> +		cpumask_clear(affinity);
> +		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
> +		irq_set_affinity_and_hint(msi->rx_irq[i], affinity);
>  	}
> =20
>  	/* Request Tx MSI irq */
> @@ -3959,13 +3967,18 @@ static int stmmac_request_irq_multi_msi(struct ne=
t_device *dev)
>  			irq_idx =3D i;
>  			goto irq_error;
>  		}
> -		irq_set_affinity_hint(msi->tx_irq[i],
> -				      cpumask_of(i % num_online_cpus()));
> +
> +		cpumask_clear(affinity);
> +		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
> +		irq_set_affinity_and_hint(msi->tx_irq[i], affinity);
>  	}
> =20
> +	free_cpumask_var(affinity);

[Severity: Critical]
Does freeing this cpumask here leave dangling pointers in the IRQ
descriptors?

When calling irq_set_affinity_and_hint() in the loops above, it stores
the literal pointer to the local affinity mask in the descriptor,
rather than making a copy.

Since free_cpumask_var() is called unconditionally on the success path,
the mask memory is freed while the IRQ descriptor still points to it.

Could this lead to a use-after-free, for example, if a user reads the
affinity hint later?

kernel/irq/proc.c:irq_affinity_hint_proc_show() {
    ...
    cpumask_copy(mask, desc->affinity_hint);
    ...
}

> +
>  	return 0;
> =20
>  irq_error:
> +	free_cpumask_var(affinity);
>  	stmmac_free_irq(dev, irq_err, irq_idx);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-flo-net-7-=
2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com?part=3D3
