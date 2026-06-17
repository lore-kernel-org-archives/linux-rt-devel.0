Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2835295C;
	Wed, 17 Jun 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681287; cv=none; b=qcJlY98tSri47mPyTu15nDuXNPd13fFlhUI5SjuoRlgugak8ednS9s3Xxd0wsg+4ASFgoUmRqiV+8sicxS77bXojvsmk4C/VqOte54ZvxcDMVmh/Sj5v878gZMi122cXMbIquCdxGIDe6znyhGxjQvb7Ddk0TCILeb88czyFdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681287; c=relaxed/simple;
	bh=3j5n0ejf7a03T19gI+RDPIuFSbt3QK3B6hOypToqdRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O46cPG9JA5Rl6EyA5iFnstyTyhU+bBYwoNJir7pU2v+foNrG+Mpvmg3rXTvBkoPv5wHH1fcmSbSw9V0D37rYTibits7qTlVkSck/njqCTeoxy+FLE5WM97nIEwRL84XS9+fO0d9haJCcohqEmW0t4N0a60OWoczV+FaPEE11l+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opq4G/bO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opq4G/bO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487BD1F000E9;
	Wed, 17 Jun 2026 07:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781681286;
	bh=rzrb0WRGwgd681UDsSutWC7Q1WUEHbdQRMxdwIVVdiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Opq4G/bOZzJ4NF7cPpR/qnzWLWGFBS2HajSk4+TVYo7OFKvHBK9JMC9MN3l+d9f6w
	 HFNvxxOY/vDks3C96lNIqW9EI19OAQb9V9DJ3RYG0T115amp1kBwITpxSUGQ74Hi6V
	 nK/kmut738IDJuSs1k+wUFn02JOKO5941vdKh748DtJ392uQdcFxbbUc5pK2oS6kBX
	 RSn+Sc2Tjy5uHxWXDPQVt+nhSsRXQiDox4rvFDiHKg61P+ECKbc4aUtRodGPOC12ef
	 l2ke32KiaOvULesvWnGAjh5SfRP5+kU/7J/7/WgtCuWfXmCka2zXxO9QxyFY3Pe/Pc
	 FCrvicUq2mYPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: mvneta: free/request IRQ across suspend/resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260616072649.2514602-1-yun.zhou@windriver.com>
References: <20260616072649.2514602-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:28:05 +0000
Message-Id: <20260617072806.487BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing cleanup in `mvneta_resume()` error path causes CPU hotplug=
 deadlocks.
- [High] Inconsistent state on resume failure leads to hard deadlock and in=
valid IRQ free during device stop.
--

commit 888983e0bf18d7a13bd3110a9d378dd82a1883c0
Author: Yun Zhou <yun.zhou@windriver.com>

net: mvneta: free/request IRQ across suspend/resume

This commit frees the IRQ during suspend and requests it again during resum=
e.
This fixes an issue on PREEMPT_RT where forced-threaded IRQs could remain
masked on the MPIC after a suspend/resume cycle.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
[ ... ]
> @@ -5895,6 +5909,20 @@ static int mvneta_resume(struct device *device)
>  						 &pp->node_dead);
>  	}
> =20
> +	/* Re-request IRQ (see comment in mvneta_suspend) */
> +	if (pp->neta_armada3700) {
> +		err =3D request_irq(dev->irq, mvneta_isr, 0, dev->name, pp);
> +	} else {
> +		err =3D request_percpu_irq(dev->irq, mvneta_percpu_isr,
> +					dev->name, pp->ports);
> +		if (!err)
> +			on_each_cpu(mvneta_percpu_enable, pp, true);
> +	}
> +	if (err) {
> +		netdev_err(dev, "cannot request irq %d\n", dev->irq);
> +		return err;

[Severity: High]
Does this error path need to revert the earlier resume operations like the =
CPU
hotplug registrations and pp->is_stopped state?

If this returns early without reverting cpuhp_state_add_instance_nocalls() =
and
setting pp->is_stopped back to true, the device remains on the CPU hotplug
lists in an inconsistent state.

If a CPU is later taken offline, mvneta_cpu_dead() will run and uncondition=
ally
call napi_disable(). Since mvneta_resume() failed before calling
mvneta_start_dev(), the NAPI context is already disabled, which causes a ha=
rd
deadlock in napi_disable().

Additionally, does this leave the device logically up but with unrequested
IRQs?

If the interface is later brought down, mvneta_stop() will run and call
mvneta_stop_dev() followed by free_irq() or free_percpu_irq(). The
mvneta_stop_dev() call will also deadlock in napi_disable() because the NAPI
context was never re-enabled. The subsequent free_irq() will then trigger a
warning since the IRQ was never successfully requested during resume.

> +	}
> +
>  	rtnl_lock();
>  	mvneta_start_dev(pp);
>  	rtnl_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616072649.2514=
602-1-yun.zhou@windriver.com?part=3D1
