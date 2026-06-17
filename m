Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775123B9610;
	Wed, 17 Jun 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727665; cv=none; b=P6YvkpUCB1uto8xX0dNTNpCOWwgTHiaizIjZw8kBangdcYvVQ0zcglPRY4cuOA4L7yEMIQ0KizhPZAnEMjdUTObB/zwEPRZcRwpkimnPgC3KHFSKEMH3c58a98sLkCBat6b7YAqNagmzaKV8LhKt0f+VHzx7bfvkSP+YqMxokoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727665; c=relaxed/simple;
	bh=XKcJOas24Z5iwLS/pgoHM5ZyBbn1Z1yF2xzdsSVdkYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M/QiTxxfj29Jnt8/g6h8WGxwhagngQ72C+aOJ4CNkdYHzJAixe04vgm2Ay1Q0uDNb/FVO4bSLN2oxKuG+bdSuVaKTQMM4RDLR0/JdyuqCp8R7u8A0fQoiCCKGIgikdLU3JFyllGjZHZtiC2Ukk9SNRJxJ0J7syiYYuUhi/h5NwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxQ7lK3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxQ7lK3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFD71F000E9;
	Wed, 17 Jun 2026 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781727662;
	bh=96Gyn7ZtsdHOZpYLbdrmdB7f5RN+N3+kRt5/OHcS1hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TxQ7lK3jNnnLgkSFruqCyuvjRXvtvPSbThkg9GklCxwmL8CadcAVKSv3HXDJnDIMQ
	 txWCQ3oDw8fuMUANpbmkB1mV2QXTw1VKrYmuQADbYhnRXPnTwKb6/3lz3HUqIYmGhL
	 wO2u3twd4BSquS7eb6Np5XMeTw9Ef3eklu7MW7xk3B5Wjv+PWMVNoPuZTfohdyn22e
	 8m7lXunFo+FE//emoYhSzYEYT+qV/7PkO/iJW6og4nDKpvSf7hDBq4bDJv5a14n2UT
	 r4r2DMcjl6x+HUTg4vC/2Z8bAL3uIFaQEGctWOttdpwChsNrSfc/WKoC9EW/wKkh+u
	 jvknYxshBI2Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] gpio: sch: use raw_spinlock_t in the irq startup
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260617154035.1199948-2-runyu.xiao@seu.edu.cn>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
 <20260617154035.1199948-2-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:21:02 +0000
Message-Id: <20260617202102.ABFD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Read-Modify-Write cycle on the Write-1-to-Clear (W1C) status regis=
ter causes lost interrupts.
--

commit 088444fdf19ac3925d66a59ae9e74b003c72c066
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

gpio: sch: use raw_spinlock_t in the irq startup path

This patch converts the SCH controller lock from spinlock_t to
raw_spinlock_t to prevent a sleep-in-invalid-context bug on PREEMPT_RT.
The lock is acquired in the non-sleepable IRQ startup path.

> diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
> index 966d16a6d5157..5e361742a11ad 100644
> --- a/drivers/gpio/gpio-sch.c
> +++ b/drivers/gpio/gpio-sch.c

[ ... ]

> @@ -215,9 +215,9 @@ static void sch_irq_ack(struct irq_data *d)
>  	irq_hw_number_t gpio_num =3D irqd_to_hwirq(d);
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&sch->lock, flags);
> +	raw_spin_lock_irqsave(&sch->lock, flags);
>  	sch_gpio_reg_set(sch, gpio_num, GTS, 1);

[Severity: High]
This isn't a bug introduced by this patch, but does this cause lost
interrupts due to a read-modify-write on a write-1-to-clear register?

sch_irq_ack() acknowledges a GPIO interrupt by calling
sch_gpio_reg_set() for the GTS register.=20

Looking at sch_gpio_reg_set():

drivers/gpio/gpio-sch.c:sch_gpio_reg_set() {
    ...
    reg_val =3D ioread8(sch->regs + offset);

    if (val)
        reg_val |=3D BIT(bit);
    else
        reg_val &=3D ~BIT(bit);

    iowrite8(reg_val, sch->regs + offset);
}

And sch_gpio_gpe_handler() demonstrates that GTS returns the status of
pending interrupts when read:

drivers/gpio/gpio-sch.c:sch_gpio_gpe_handler() {
    ...
    core_status =3D ioread32(sch->regs + CORE_BANK_OFFSET + GTS);
    ...
}

Because GTS is a write-1-to-clear status register, the ioread8() in
sch_gpio_reg_set() returns 1s for all currently pending interrupts.

When those 1s are written back via iowrite8(), won't it inadvertently
clear all pending interrupts in that bank, instead of just the specific
gpio_num being acknowledged?

> -	spin_unlock_irqrestore(&sch->lock, flags);
> +	raw_spin_unlock_irqrestore(&sch->lock, flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617154035.1199=
948-1-runyu.xiao@seu.edu.cn?part=3D1
