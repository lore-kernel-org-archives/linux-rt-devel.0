Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528343C1410;
	Thu, 18 Jun 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774502; cv=none; b=PACBMqPkC9oYpHp8ZcX7dnzO6llCTgrTusJOY3m+zi6PlNfaPC6uliGJihuX+vuLzYMfp8buE8YTRc8UN6zwH6pUNOTWMaBl6EQRTXojzdRq2ZFppCirzCpZfpiH0sN14El1P2qY9Pq4WGvX3dK3/A7OfAxIlrz+I1/BQxEcuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774502; c=relaxed/simple;
	bh=5bsvLFSE+LyozNnX4XO1zS1eMSoGE9OFOIg+otIxVxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3Sp8migLEjFXfMGyxaCkdp68eQQ8PQzWfm6wZewWKkguamp1ZN9eS0YTsnrl9tgQy4EiVlw//RzwM+FOJbCFQli0GYjWuc0+OY4qvPduUpWYtNr6JaQpQjeSR9TnOdHoH9KBebs21YODxKhrq2tqN3SfTlAoh/AyIvlVH/XV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd21FTDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd21FTDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCB21F00A3A;
	Thu, 18 Jun 2026 09:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781774501;
	bh=VOhq/stw26pHLtwlJoCo8n2mfEk6cJ6OhYF8RgKZG3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xd21FTDRBb0TMTdQPAPqTTrY1EhTEf0r/84H1oOf3tQXSqdfzhKL5YYuVdKaByHk5
	 Y7vdB7MYssEfHpN0wJHKYpC70B93ng3CsZ0QHCk61f87GqAmdb3DNiaY4DqNDsd+ty
	 uquxfbsEAovNdBPr118QFJFpXpHCL4dnKheVK/mabFRv54T2fWUTWcS4s3p5e9Nh+V
	 BHeZvae3gTDciTI3icQ3D6IGvFEYQejrdrB15uJBWU90jfbJjw3NeaP6Vu57G8ClEe
	 kTy/TzAd9AE/6KbcK5dTpIEAw7h2FdDdLOfCJB0DVDxqPWtPZ+SOniaHH9I9sr6b2D
	 Js67zrtOd98Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Zhou" <yun.zhou@windriver.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260617092028.1722407-1-yun.zhou@windriver.com>
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:21:40 +0000
Message-Id: <20260618092140.DBCB21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing rollback in `mvneta_resume()` error path causes kernel pan=
ic and deadlock on subsequent teardown.
--

commit 3e974147b6189ed308e9434d784dbcd4c3ed5e87
Author: Yun Zhou <yun.zhou@windriver.com>

net: mvneta: free/request IRQ across suspend/resume

This commit fixes an issue on PREEMPT_RT where the mvneta IRQ handler is
left masked during suspend, causing interrupt delivery to be permanently
disabled upon resume. It addresses this by explicitly freeing the IRQ
during suspend and re-requesting it during resume.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
[ ... ]
> @@ -5885,6 +5899,21 @@ static int mvneta_resume(struct device *device)
>  		mvneta_txq_hw_init(pp, txq);
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
> +		netif_device_detach(dev);
> +		return err;
> +	}
> +

[Severity: High]
Does this error path leave the device in an inconsistent state that will
cause a crash during teardown?

If request_irq() fails, this returns early without updating pp->is_stopped
and without re-adding the CPU hotplug instances. However, the interface
remains logically UP.

If the interface is subsequently brought down (e.g., via ip link set down),
mvneta_stop() will be called. This leads to mvneta_stop_dev(), which
invokes napi_disable(). Since NAPI was already disabled in
mvneta_suspend() and never re-enabled here, will this cause a deadlock
waiting for NAPIF_STATE_SCHED to clear?

Additionally, for non-Armada3700 devices, mvneta_stop() will call:

mvneta_stop() {
    ...
    cpuhp_state_remove_instance_nocalls(online_hpstate,
                                        &pp->node_online);
    ...
}

Since the nodes were already removed during suspend and never re-added,
could this invoke hlist_del() on a poisoned pointer and cause an immediate
kernel panic?

Finally, since the IRQ was never acquired, will the subsequent free_irq()
or free_percpu_irq() in mvneta_stop() trigger a kernel WARNING?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617092028.1722=
407-1-yun.zhou@windriver.com?part=3D1
