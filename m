Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF69305699;
	Tue, 15 Sep 2026 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433853; cv=none; b=rUlRJxW00exkt+q3MMbHiNo3o4b85tGHebh8IFnBUz2JdcequjoIyEKYyd6bfJQJKYImPK25gNjoSmPKv9w/ocpMHGtVxuZMI6j7PtkaLiRRCL3h15uE9eHmFXJW+tdODC7FZE0B6Y3JfmU2KiKGC/CNfCCzQU423KnCoxa3iUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433853; c=relaxed/simple;
	bh=B9ReJBzF3/yETU2E0VDo5568Bppa0c1pG18BLjNAVhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pd7ZG6kUJe+b7THi8pdfHOlwnckAGIMHDfhW67/tmGVzI7DNzpMZiNQ0PvrP5GWjT8R6HtQ/QRODC9AGLUa+YjB7XibPp9XBl/EmfJtXJuqQDK+N04Ocw8yAi10eVy0lgxHxQ1BRySMmh8HBohpdgCKe2Ti/sc43SNGrYtJX5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM+TBA7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM+TBA7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A61F000FF;
	Tue, 15 Sep 2026 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789433851;
	bh=G8Zh2atXS2FYkfFA45IuVL82KVdOyyiCQzAf8Owc8rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kM+TBA7sgEZ3Tl5eYns/z1GVkDRG1EDaU1+SUBV+6ZpH1uuYDnYd70f8JTdvcMHgx
	 tewvdUJdCdjpZOfkflyRbKNZjAypXa++y65hYkzpEoN6KlOqVoTPcNVICrnUfXI6k0
	 BZSCSwUOozXazkjM53haLdZS/kJUsuoKI2vrbCnoS3WVor6yjkcM3GuISNXkf+XQb1
	 zVu+Zh/6CEGtB1lOPvcfkhTnG5qr7/Qqnn9StnNOW/9KXTXo40svfa1LdM7L4pvvz3
	 X4LiDeclMJoC/maQtuO0CuGHFoEQNrY93dtykwvFJS5PyL0GnQ6vVXHmptj/zDoct7
	 OOja/Ekfus6zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip
 cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260915004406.115230-1-rosenp@gmail.com>
References: <20260915004406.115230-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:57:30 +0000
Message-Id: <20260915005731.023A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpio: mvebu: TOCTOU race in resume causes interrupt storm
--

commit 6b10f9bb173190e25a679e67f7992002ca12fe2f
Author: Rosen Penev <rosenp@gmail.com>

gpio: mvebu: keep resume masks within the irqchip cache

This commit fixes a resume hang in mvebu_gpio_resume by masking restored
values with the matching irqchip mask cache. It reads the caches under
gc->lock to keep them consistent with mask/unmask handlers.

> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 93b8a08b04b9f..a2796240fe14b 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c

[ ... ]

> @@ -1045,32 +1047,51 @@ static int mvebu_gpio_resume(struct platform_devi=
ce *pdev)
>  	regmap_write(mvchip->regs, GPIO_IN_POL_OFF + mvchip->offset,
>  		     mvchip->in_pol_reg);
> =20
> +	/*
> +	 * genirq skips mask_irq() for a line it already considers masked, so
> +	 * unmasking one behind its back leaves an asserted level line that
> +	 * nobody masks. Restore only bits the irqchip cache still has set.
> +	 *
> +	 * Snapshot the caches under the raw spinlock, but release it before
> +	 * the regmap writes below: regmap_write() takes a sleepable lock on
> +	 * PREEMPT_RT.
> +	 */
> +	if (mvchip->domain) {
> +		struct irq_chip_generic *gc;
> +
> +		gc =3D irq_get_domain_generic_chip(mvchip->domain, 0);
> +		raw_spin_lock_irqsave(&gc->lock, flags);
> +		level_cache =3D gc->chip_types[0].mask_cache_priv;
> +		edge_cache =3D gc->chip_types[1].mask_cache_priv;
> +		raw_spin_unlock_irqrestore(&gc->lock, flags);

[Severity: High]
Does releasing the lock here create a race window?

If a level-triggered interrupt fires immediately after the lock is released,
the IRQ handler runs. Genirq would acquire the lock, mask the hardware, and
clear the bit in mask_cache_priv.

> +	}
> +
>  	switch (mvchip->soc_variant) {
>  	case MVEBU_GPIO_SOC_VARIANT_ORION:
>  	case MVEBU_GPIO_SOC_VARIANT_A8K:
>  		regmap_write(mvchip->regs, GPIO_EDGE_MASK_OFF + mvchip->offset,
> -			     mvchip->edge_mask_regs[0]);
> +			     mvchip->edge_mask_regs[0] & edge_cache);

[Severity: High]
Could writing the stale snapshot here unmask an IRQ that genirq just masked?

If the race described above occurs, mvebu_gpio_resume() continues and writes
its stale snapshot (with the bit set) to the hardware mask register. This
would unmask the line in hardware while genirq's irq_data maintains the
IRQD_IRQ_MASKED flag.

When the interrupt inevitably fires again, could genirq skip masking it
because it is already marked masked, leading to an unhandled infinite
interrupt storm and kernel lockup?


[Severity: High]
This is a pre-existing issue, but does the bitwise AND permanently drop IRQs
that were unmasked during early resume?

If a driver disables an IRQ before suspend, the snapshot bit in
edge_mask_regs is 0. If the driver then calls enable_irq() during an early
resume phase (like .resume_noirq), genirq correctly unmasks the hardware and
sets the cache bit to 1.

When mvebu_gpio_resume() later executes in the .resume phase, it calculates
0 (snapshot) & 1 (cache) =3D 0 and writes 0 to the hardware. Does this leave
the hardware permanently masked while genirq considers it unmasked, silently
breaking the interrupt?

>  		regmap_write(mvchip->regs, GPIO_LEVEL_MASK_OFF + mvchip->offset,
> -			     mvchip->level_mask_regs[0]);
> +			     mvchip->level_mask_regs[0] & level_cache);
>  		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915004406.1152=
30-1-rosenp@gmail.com?part=3D1
