Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA34313E2B;
	Tue,  7 Jul 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432960; cv=none; b=bBq9VCCVfghHZMRHpTOYY7n2C/E6QG1b/h4k0CzBLXVBhXYXQk/AC+9aPVrzwwGsSy9PXiVJ9MjYEdB38lMiA5pCcGMkANglFZJRJEwxLpNaIp5jbdMTZWZIDr0URxoyqzYyeeTqfQ2B7w99iI5tnmGldc0VSYM2fm0dqo7Q5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432960; c=relaxed/simple;
	bh=fhLLGd+GSaPxCCuQIhz8YvcTK+wMssCPJbrVTMZJbXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C/PAeKCQc9KDyXSNHHtzv41Fr5g58WTysBkMHeg6xcCag91VLAj4UB2s5K36gv/n3SyLmyUf/NQIhY0YA/r0ZxsimoQO0zHfIHFHLTXkoo2VLhJBMuSlGrcA/gEddGgKwEXgsHsUDbAFGWmdK+czkpaDhrTelftVCgmrtEImAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsJWjq5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsJWjq5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF6F1F00A3A;
	Tue,  7 Jul 2026 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432958;
	bh=eypa1n4AGmb6PJDRSxQx2V9Sx7uErrNfms2i9P7CAOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsJWjq5QEysCXjRl6FmXbqsneu/oZ4zNUMbYStbs/ZsP5rLzZOoNE9NUVu27bsOXy
	 6YuvV6WPf+nxc5MDfwXuD75L8RkMKeR17Xhk/KZHfZGOtyFIF+75ZyafC5md5NA/qj
	 NfAx3kk2cydii1sUopIR0EPczwQoQtt27EqCg+iqGxGwicbKLLoYfU6TiP/qrSIhgC
	 lrDFEtahAi256DJ/+4ENXN3DU6K5jDtBhJ0hvINmAiqarqOtFNsp1IsCO3gHfOv4hb
	 U19ezAIXHefnXF2mSuD6/WbLzMverdeMfaKUXE9Wk9KgLgc4rd8RXA+lWLVDrUObAU
	 nKaNyfB3UABJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: macb: mask TXUBR during TX NAPI poll to
 prevent IRQ storms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Taedcke" <christian.taedcke@weidmueller.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-2-ab3115b5a13a@weidmueller.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:02:37 +0000
Message-Id: <20260707140238.5BF6F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete interrupt masking in the NAPI reschedule path leaves =
TXUBR unmasked, causing unnecessary hard interrupts.
- [Medium] Ad-hoc cross-CPU synchronization flag with mismatched memory bar=
riers causes a data race.
--

commit 8cade27ad39e331dd72cf96ffc689e581ab23335
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

net: macb: mask TXUBR during TX NAPI poll to prevent IRQ storms

This commit attempts to fix an interrupt storm caused by TXUBR remaining
unmasked while NAPI handles completions. It masks TXUBR alongside TCOMP
during NAPI scheduling and uses a flag to track pending TXUBR events.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1971,7 +1971,7 @@ static int macb_tx_poll(struct napi_struct *napi, i=
nt budget)
>  		    (unsigned int)(queue - bp->queues), work_done, budget);
> =20
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> -		queue_writel(queue, IER, MACB_BIT(TCOMP));
> +		queue_writel(queue, IER, MACB_BIT(TCOMP) | MACB_BIT(TXUBR));
> =20
>  		/* Packet completions only seem to propagate to raise
>  		 * interrupts when interrupts are enabled at the time, so if

[Severity: Medium]
In the reschedule path just below this change, does TXUBR also need to be
masked?

When packets are still pending, the code reschedules NAPI and masks TCOMP:

	if (macb_tx_complete_pending(queue)) {
		queue_writel(queue, IDR, MACB_BIT(TCOMP));
		macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
		...
		napi_schedule(napi);
	}

Since IER just unmasked both TCOMP and TXUBR in the lines above, failing to
mask TXUBR here leaves it unmasked while NAPI takes over. Under heavy TX lo=
ad,
does this cause unnecessary hard interrupts?

[ ... ]

> @@ -2161,7 +2161,8 @@ static irqreturn_t macb_interrupt(int irq, void *de=
v_id)
> =20
>  		if (status & (MACB_BIT(TCOMP) |
>  			      MACB_BIT(TXUBR))) {
> -			queue_writel(queue, IDR, MACB_BIT(TCOMP));
> +			queue_writel(queue, IDR, MACB_BIT(TCOMP) |
> +						 MACB_BIT(TXUBR));
>  			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
>  							MACB_BIT(TXUBR));
>  			if (status & MACB_BIT(TXUBR)) {

[Severity: Medium]
Is this use of a plain boolean and memory barriers sufficient for cross-CPU
synchronization here?

The commit message notes that pending TXUBR is recorded in
queue->txubr_pending, and the interrupt handler updates it like this:

		if (status & MACB_BIT(TXUBR)) {
			queue->txubr_pending =3D true;
			wmb(); // ensure softirq can see update
		}

Concurrently, macb_tx_poll() locklessly reads and clears it:

	rmb(); // ensure txubr_pending is up to date
	if (queue->txubr_pending) {
		queue->txubr_pending =3D false;

Using wmb() and rmb() enforces instruction ordering but does not flush
caches, which creates a data race on the plain boolean under the kernel
memory model. Could this lead to undefined behavior or lost wakeups if the
compiler caches or reorders the flag?

Could this be replaced with atomic bit operations like set_bit() and
test_and_clear_bit() instead to safely synchronize between the hardirq
and softirq contexts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-upstreamin=
g-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com?part=3D2
