Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D861E0E14;
	Wed, 12 Aug 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514590; cv=none; b=lNcRNr20OlfW5kmjRrk5w6akW+j9jZAkmPWJRKCKX4gmfRxoSbVTH/VTd9TyTAlhLROnvJN71qkkk1zdRSE33Yf+VNOK7kOzuwbrQFnRYvwWPfvhSCuQj40tFd26WZnjDJQuDbvSHHlFSm+5O+4b1pkcn1A8pGgzvIK90PL4OdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514590; c=relaxed/simple;
	bh=3Qpz/OLTgoKSefOmBB3gy+WVoOTIi0nuW8tHhyG4rqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vjumu1CbzSKNXpOFB6qDPDn2NcuRu9dKnqox2yOVriZdVISqSUpRyM9aSzvZzyIWmJmrIKh/bcdwPdTkxa2A08LQ3DaONr2+pUzMdgjEtrynjv42WDD7NozkUPs19jkZwa5HUzg2WR3qfZPq8PnsCIalP/HBmDiIjjENxMhYhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7GWdmRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7GWdmRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21341F000E9;
	Wed, 12 Aug 2026 06:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514589;
	bh=JVeJP1P7BtzvlcCQeSZPowPFCMBrxr7KsusjFiTSJJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e7GWdmRG6QVzZo27856oHmZpzkDBTD4HHCJiReznpyr/G+3JpqeOmndG50mWdxlOQ
	 +SvHlZxRxZT4ry93loOjRpu561DLY42u/9GXLklo+9EYPqhIgs48a9pLV1+VN1I0Hd
	 mkfpnBQK5TJzu3xJ+lDqTIlzI1XeO78QwbgLoi6HPpjdgus1wHblZW97s0qJE+Oa1v
	 5/6eQCtU9PeFA8Hx4EoWBf95F8u0ePozCcFFU1puJ4MIbLvV21KprAi417yLunhxyV
	 L0NXb9mWmYH8hkDhcfx7580b76mes7UnP1705MCdQuRYQIR7uKlZsOiKli70gjjJmj
	 uJ0gA4W++VJNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] EDAC/aspeed: Replace regmap with direct register
 access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Chen" <ryan_chen@aspeedtech.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260812-edac-v1-5-03992edea297@aspeedtech.com>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
 <20260812-edac-v1-5-03992edea297@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:03:07 +0000
Message-Id: <20260812060308.B21341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Deadlock and lockdep splat due to acquiring the global `aspeed_loc=
k` in process context without disabling interrupts.
- [High] Writing back a stale cached register value restores previously cle=
ared interrupt counters, risking an interrupt storm.
- [Medium] Unbounded scheduling latency caused by calling `dev_dbg()` withi=
n a `raw_spinlock` critical section.
- [Medium] Bypassed lock annotation and unguarded hardware access via local=
 pointer alias.

Pre-existing issues:
- [High] Missing IRQ synchronization in `aspeed_remove()` leads to a Use-Af=
ter-Free of the `mci` structure.
--

--- Patch [5]: [PATCH 5/7] EDAC/aspeed: Replace regmap with direct register=
 access ---
commit 4694a0001d51ca262e162c7af74ae2a61ea5c379
Author: Ryan Chen <ryan_chen@aspeedtech.com>
Date:   Wed Aug 12 05:48:29 2026 +0000

    EDAC/aspeed: Replace regmap with direct register access
   =20
    The driver instantiates its own regmap purely as an MMIO wrapper: it has
    no register cache, uses custom reg_read/reg_write callbacks, and is not
    shared as a syscon with other drivers. So it brings nothing here beyond
    the spinlock that regmap takes around each access when fast_io is set.
   =20
    Drop the regmap and access the registers directly with readl()/writel()
    under an explicit raw spinlock, held across the whole read-modify-write=
 so
    the controller is unlocked once around the grouped writes rather than on
    every register write. The lock is a raw_spinlock_t because the ECC
    interrupt handler runs in hardirq context, where under PREEMPT_RT a
    sleeping spinlock could not be acquired.

> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index 8bfeb21d3204a..7bd552ee9a612 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c

[ ... ]

> @@ -147,12 +100,24 @@ static irqreturn_t mcr_isr(int irq, void *arg)
>  {
>  	struct mem_ctl_info *mci =3D arg;
>  	u32 rec_addr, un_rec_addr;
> -	u32 reg50, reg5c, reg58;
> -	u8  rec_cnt, un_rec_cnt;
> -
> -	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
> -	dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n",
> -		reg50);
> +	u8 rec_cnt, un_rec_cnt;
> +	u32 reg50;
> +
> +	scoped_guard(raw_spinlock, &aspeed_lock) {
> +		reg50 =3D readl(aspeed_regs + ASPEED_MCR_INTR_CTRL);
> +		dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n=
",
> +			reg50);

[Severity: Medium]
Is it safe to call dev_dbg() while holding a raw_spinlock?

Printk-family functions can take complex internal locks or cause heavy cons=
ole
I/O. Since the lock was changed to a raw_spinlock_t to allow the handler to
run in hardirq context under PREEMPT_RT, could calling dev_dbg() here cause
massive latency spikes?

> +		un_rec_addr =3D readl(aspeed_regs + ASPEED_MCR_ADDR_UNREC);
> +		rec_addr =3D readl(aspeed_regs + ASPEED_MCR_ADDR_REC);
> +
> +		/* clearing the counters needs a set-then-clear of CLEAR */
> +		writel(ASPEED_MCR_PROT_PASSWD, aspeed_regs + ASPEED_MCR_PROT);
> +		writel(reg50 | ASPEED_MCR_INTR_CTRL_CLEAR,
> +		       aspeed_regs + ASPEED_MCR_INTR_CTRL);
> +		writel(reg50 & ~ASPEED_MCR_INTR_CTRL_CLEAR,
> +		       aspeed_regs + ASPEED_MCR_INTR_CTRL);

[Severity: High]
Will this second write restore the previously cleared error counters?

The hardware clears error counters when the CLEAR bit is written to 1. The
original regmap sequence read the hardware twice, so it correctly wrote bac=
k 0
for the counters.

Here, we reuse the initial cached read (reg50), which contains the non-zero
counters. If the counter bits are R/W, does writing back (reg50 & ~CLEAR)
restore the counters to their previous non-zero values and immediately
retrigger the interrupt?

[ ... ]

> @@ -246,7 +213,8 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	nr_pages =3D resource_size(&r) >> PAGE_SHIFT;
>  	csrow->last_page =3D csrow->first_page + nr_pages - 1;
> =20
> -	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> +	scoped_guard(raw_spinlock, &aspeed_lock)
> +		reg04 =3D readl(aspeed_regs + ASPEED_MCR_CONF);

[Severity: High]
Can this cause a deadlock and lockdep splat when the interrupt fires?

The global aspeed_lock is acquired in hardirq context by mcr_isr(). However,
init_csrows() acquires this lock in process context using
scoped_guard(raw_spinlock), which leaves local interrupts enabled.

If an interrupt fires while the process is holding the lock, wouldn't the
ISR spin forever waiting for the lock on the same CPU? Should this use the
irqsave variant instead?

[ ... ]

> @@ -274,13 +241,11 @@ static int aspeed_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
> =20
> -	aspeed_regmap =3D devm_regmap_init(dev, NULL, (__force void *)regs,
> -					 &aspeed_regmap_config);
> -	if (IS_ERR(aspeed_regmap))
> -		return PTR_ERR(aspeed_regmap);
> +	scoped_guard(raw_spinlock, &aspeed_lock)
> +		aspeed_regs =3D regs;

[Severity: High]
Similar to init_csrows() above, does this need to use the irqsave variant to
avoid deadlocking if the interrupt fires?

> =20
>  	/* bail out if ECC mode is not configured */
> -	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> +	reg04 =3D readl(regs + ASPEED_MCR_CONF);

[Severity: Medium]
Does this bypass the lock annotation and unguarded hardware access checks?

The commit introduces a __guarded_by(&aspeed_lock) annotation on aspeed_reg=
s.
However, accessing ASPEED_MCR_CONF using the unannotated local regs pointer
without holding the lock circumvents the intended static analysis safety ch=
eck
and drops the synchronization.

[ ... ]

> @@ -346,8 +311,7 @@ static void aspeed_remove(struct platform_device *pde=
v)
>  	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
> =20
>  	/* disable interrupts */
> -	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
> -			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
> +	aspeed_set_irq(false);
> =20
>  	/* free resources */
>  	edac_mc_del_mc(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but does missing IRQ synchronization in
aspeed_remove() lead to a use-after-free of the mci structure?

The driver uses devm_request_irq(), meaning the interrupt is unregistered
and synchronized automatically by devres only after aspeed_remove() returns.
Although aspeed_set_irq(false) disables interrupts at the hardware level,
it does not wait for an already-running ISR to complete.

Could edac_mc_free(mci) (called immediately after edac_mc_del_mc) free the
structure while mcr_isr() is concurrently executing on another CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-edac-v1-0-=
03992edea297@aspeedtech.com?part=3D5
