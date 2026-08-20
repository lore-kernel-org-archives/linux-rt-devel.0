Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809A257844;
	Thu, 20 Aug 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236249; cv=none; b=dqG1UtYWU2InN15CibBzGAqFP2Wq47J/vAkueu2aNL6RGnOP0k79mi35Xu8fo4I5OXJA8uxRSd6vt4S66iJeGrF1vCqsWD24tBKarSK3Hm/bLRsxVIr/yhuAeKEdnPsMKbdIlzE4fNt9dx1kx6im1jfibxOXs2BEZpf4QqhYdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236249; c=relaxed/simple;
	bh=PPN8E1Bz3z32P5SNvhxY97udZ88Iztj+fMi/3z8knKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYbVMyn6tJ6JpI58cIDNpEyf+LJMk2swzgONSfDTVV1EsraHrMF6vx5y2OtWO982hBoRwnEel7vMfhmc0cG4dRdqo56cA5FI/d/FpMH+cN+efgvLHcJNjORnAlrmAoHCHvVA85qXExpACugzJVNHlfPKEXg8OS+kihc97i9ioIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLQnVMGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLQnVMGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9381A1F00A3A;
	Thu, 20 Aug 2026 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236247;
	bh=d+Ahhs2OJwXBTrKKAIMFqrxvPwC/18iQvqhaeDM8o0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLQnVMGRE0SfSViHtfhaXYRrMfC7fe6Nbbd7HPWEnC8kcZpR/tcrsDWh2Wznl8kay
	 9KhLYA6za17heiws1QKv1pU7exeqENtMq3Akr0EPXcZLGCu8OMrcO2sylXkaK9vvx5
	 DN2Eg/0kTSSaD8W2KKmrx7RAxYWCtysEJQ9LtbrQhO30hnV92x5nzNI24LMhYpr/R/
	 YRPgRWIwA6KKKz4KcifWSqM8Sv6v12W63P1BHiWa4QOSk8HMIIfNu3zgnI+gVXHQxK
	 q4DbxVywLaq9U0CR8gyi2RWMtq+VwJwBxsTov5yLP4sDIs50zFhMaNXu5W0zO85G18
	 QDuX77biL+AxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when
 setting affinity hints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:30:47 +0000
Message-Id: <20260820143047.9381A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] irq_set_affinity_and_hint() permanently locks out subsequent affin=
ity updates by the driver itself, breaking dynamic IRQ rebalancing.
- [Medium] __irq_apply_affinity_hint checks IRQD_AFFINITY_SET inside a lock=
 but applies the affinity outside the lock, introducing a TOCTOU race that =
can overwrite user-defined affinities.
--

--- Patch [2]: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when s=
etting affinity hints ---
commit c1f8b98c1dbbe4fae2975bbf7872df3c7c3662b6
Author: Florian Bezdeka <florian.bezdeka@siemens.com>

genirq: Honor existing IRQ affinities when setting affinity hints

This commit modifies __irq_apply_affinity_hint to prevent overwriting an
already configured IRQ affinity. It checks if the affinity has been set
previously before allowing the affinity to be updated by a hint.

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 7eb07e3bdb4c2..3937ba24df6d6 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -503,11 +503,21 @@ EXPORT_SYMBOL_GPL(irq_force_affinity);
> =20
>  int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,=
 bool setaffinity)
>  {
> +	struct irq_data *irq_data;
>  	int ret =3D -EINVAL;
> =20
>  	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
>  		scoped_irqdesc->affinity_hint =3D m;
> +		irq_data =3D irq_desc_get_irq_data(scoped_irqdesc);
>  		ret =3D 0;
> +
> +		/*
> +		 * Do not overwrite the affinity in case an affinity for this
> +		 * IRQ has already been requested, e.g. by writing to
> +		 * /proc/irq/<n>/smp_affinity
> +		 */
> +		if (irqd_affinity_was_set(irq_data))
> +			setaffinity =3D false;

[Severity: High]
Will this prevent drivers from dynamically rebalancing their own IRQ
affinities after the initial setup?

If a driver calls irq_set_affinity_and_hint(), it inherently results in the
IRQD_AFFINITY_SET flag being set. On any subsequent call by the same driver
to update the affinity (for example, during CPU hotplug or queue
reconfiguration), the irqd_affinity_was_set() check will evaluate to true
and clear the setaffinity flag.

Does this unintentionally lock out future driver-initiated affinity updates,
leaving interrupts routed to suboptimal or offline CPUs?

>  	}
> =20
>  	if (!ret && m && setaffinity)

[Severity: Medium]
Could this introduce a time-of-check to time-of-use race condition?

The irqd_affinity_was_set() check happens inside the scoped block while the
lock is held. However, the lock is dropped when the scoped block ends, right
before the actual affinity update is performed.

If userspace writes to /proc/irq/<n>/smp_affinity exactly after the scoped
block drops the lock but before __irq_set_affinity() runs, won't the driver
blindly overwrite the newly configured user affinity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-flo-net-7-=
2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com?part=3D2
