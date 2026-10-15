Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A75013B9
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076964; cv=pass; b=TVM3Ix+1VpECDoc4PgH5Kem7uB9bgNQUWO0Igb29MWcC13jAxXklH+28YsBMUELvbHxXg0DsOv9syS2bdSulv3Whjz5aM7QF2fGmykqBvWqyHLkjAmQJkDXOL+KFXNPBJeoMbJ4v3kwlkPwgBJYjTozFt3G0DJep7WdqSp5N2PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076964; c=relaxed/simple;
	bh=MLiIS6oDDFsD34KL+G8e/3T/Al1HvZKZmMra2+d9nPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lde8+qjU+OL/6TmJrPFbtMFw9T8X60GgC/mX7BrPrcybPZyK3aFqzuGGkTDCXbZ/xQTd2uwvQENKU+IGX1EtLmFCGilmBJ7FvdEJe6XBd9WBG6lYCPAaYkJ+nELLNy9Ppw1PoaZ4lAvrWH+nGg4tlvxW8KQl++kq4yX5wnAVRTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7SwzdLw; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7SwzdLw"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-98a8c72a04cso2020717241.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 08:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792076962; cv=none;
        d=google.com; s=arc-20260327;
        b=TBKG9Ad/2TePdvhPlSLFfLRB0P0vw7rnIhov0alUt+TBIy2GRgLwkG25r8TFEXZABR
         LPMd75VFab2Q4TgGthSs07D1a7RBvuaR5SmHeQnHvJnuS0TtYwbzUAspyfyJ9QagM2x8
         knMbQFDgIK5YQIBePFBYFhgo6qWxDIt994tcsUPs37XQjPWs2C45ovvsPEOQ+5zERBYq
         l5Q4XsORe7fcWH8uZWALU6HLsMudvL/av7ELxYCzVH06FRve0V0XIK08ayOyndueAxV/
         ywS44HTggwv36auL5n8XX6wZnGW3+aIuvxABTbzX2C8C0muYXc1xE/Q12wqrcc5a8zLx
         pM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g+la5oRry/ejNEDlylEClTFnvYZE1MGV2kYV0bWmL7E=;
        fh=GP7BtER3/3OYWHa4XbOHT2yX7zie/8J2XuG0494BSY0=;
        b=OKux8iPdd5aLxqk1BMf2jWGIzcmrm0BZgx0PDE6OP/w3p9fx4ZbDeoKS4cSBxda946
         Ua3KshVrwqwt7f8ej78ZTiMsAOTSAoWSrwW6NlCiLzzcAHaii+PvXpqqlIXLNC5ia60L
         DXww+kk/aqxjahUcDCICY3xAKTiakxV5wA+QJTeT1X+MMjTJHyKbmBSY5DA2DIuDJfhV
         cWl2O2PEQmxcXJw4yDktj54q09JAAQIfmi5Bg81Ldbn6kyCgZlkU3Snm8nGHJRMEMzs3
         /pa+2LQ0oA1HVEflSx4vJqlhHPTRaraRB03ufKu/AGPYODXOmRRqsE/Q86sR9VPSGFNO
         iP7w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792076962; x=1792681762; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g+la5oRry/ejNEDlylEClTFnvYZE1MGV2kYV0bWmL7E=;
        b=F7SwzdLwUMdGfSFcfXclemFdUjP9WgCAkxDKhQ+9h7TaPN1pTJ+U10Rnc0U8OAcDqu
         eQnl5Tys71kryUj73gIR7+/DZv700SyiFaBQr+MzGCfjwg9BI0yIZIX0s+XgdxAi0PeS
         C0BtkDFfJI7HSiWDgZhpoLLnbc/8+P7gFpJ4t4Y/SudSkxWyB1UukSsAcMIYdqL/mf4l
         AezF1wJs/pboeMbDCgSqyJYZZSv4OOyk8VvC9dA0ohbRmmmu/npp+hm49A6Z1gfBByhD
         7swMqFqh7qdV3/W2GMn3GhFjErHlQt/r45IedfBBD0cumVeyvJ5OwRjuQExXy3V4Xt7O
         hpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792076962; x=1792681762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+la5oRry/ejNEDlylEClTFnvYZE1MGV2kYV0bWmL7E=;
        b=LQPhw3blt+4oxYtnCfrvtBuwC92WIp+uTYiqHij1h6LZPRajLPnUW7vcSjOopwuLE+
         LAd8enUfVQQexhs8DEb62zzfrFb34dxm5Q7KxoKcpGRd/lDUlqvM+nLaMjavfij03Flz
         ehbEczLOqp64a0tjinpCIp43u2Ja3I9Wfdrs2fsYKVSuCPN72bC8uCtqSxCNFcaRbrkf
         ipJOYxWECZVlsmnnFTrannu2oAGcsYPT2iBcT29yGwWdXxUsj59jUkjHoP7Ku8hyykOX
         f+ewTWh1PlrKj7VWcswG9l8cPt6NsO/Cy2eYKTF5JhRo3olDKpe1snbUm21T0LDYVaKR
         oBRw==
X-Forwarded-Encrypted: i=1; AKwUvByV9bWuQNqKJ5OXIl9rx+djpNmVJOm6WnAFHd3FpI57ui50ZZrukT9yX1eXqbjqknSS/vWdNM6HG0Vwip8NMQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJL53EyTfPep1xkjFIrz2dVF/NIR8JBQAKqcvH5zVSQow1SuuNW
	iZS+4u/heJkLpXuMFS7eKAvSebfsLSNN0kVM3nhFQo6uU18DPrMuObizJwtPl1LAc1wReKAgASM
	QxFfUkizEzzi/i6VEaLdMq9GcEV7TEvU=
X-Gm-Gg: AYBFou0iS3ZMFdKyMQVKvaI2vhYx2fdcyiXgbHMnbpJbZ3F7qWzgsv8PQNaXL6JSo4X
	v/0KLd5+FVVDpCzPCrBxA3FvkCQVgVud9+SfoiUcoHmdk/ZOg4jfanap+EQgsi9ifZg90LKNzMv
	DIvIMD8KkbS+AMs3W6EJyIktFjF+mPfc1jlr35y8kYO9PP5bDMJNJ6jb5QskJels2RqOdQwBZQt
	MumWAS9NBav6JWB/gXuyYmJw0itkEAuxR9tAizQ35E7yMK0ltTkd4Qw1Ug+hJb1gHypXnr1bQ7h
	QILvMRF7UV75oWIkQw2gPHf3+YfqsBsOVDF2W8Pmddh5PmQkhDY3LeaDDjGQVSfRCLPrOF02aSj
	B2yJQzwLd1OojUWyR7K1Q78GB/YMW47EOYm5qH6kNChGzHrWy6NTs47jwiIL0rn5K4AAA59gmpM
	LWH5szW7zMx/wmLzYuE43uYw06tysXY+CfvU9OybCF9qk3
X-Received: by 2002:a67:e713:0:b0:7b4:bdf5:9307 with SMTP id
 ada2fe7eead31-7cb3a17c668mr4997492137.30.1792076961441; Thu, 15 Oct 2026
 08:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
 <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-4-5d3fc6ad2da1@gmail.com> <20261015071943.7OihPadq@linutronix.de>
In-Reply-To: <20261015071943.7OihPadq@linutronix.de>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 15 Oct 2026 09:09:08 -0600
X-Gm-Features: AclHuK-qAIJ8Ws5pW7BZAdTu8Nckn4yY6BNzqqth23CDA7sDTjbDwYfiY-Jvt6s
Message-ID: <CADvTj4q9cqLY5fB=u+ZdS4K18V3T-AuQ=_6aMNOgcMyXC8yYeg@mail.gmail.com>
Subject: Re: [PATCH v7 04/16] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:19=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-10-14 19:33:51 [-0600], James Hilliard wrote:
> > --- a/drivers/mtd/nand/raw/sunxi_nand.c
> > +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> > @@ -454,16 +457,19 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc=
 *nfc, u32 events,
> >               timeout_ms =3D NFC_DEFAULT_TIMEOUT_MS;
> >
> >       if (!use_polling) {
> > -             init_completion(&nfc->complete);
> > +             reinit_completion(&nfc->complete);
> >
> >               writel(events, nfc->regs + NFC_REG_INT);
> >
> >               ret =3D wait_for_completion_timeout(&nfc->complete,
> >                                               msecs_to_jiffies(timeout_=
ms));
> > -             if (!ret)
> > +             if (!ret) {
> > +                     /* Drain the handler before it can restore an old=
 IRQ mask. */
> > +                     disable_irq(nfc->irq);
> >                       ret =3D -ETIMEDOUT;
> > -             else
> > +             } else {
> >                       ret =3D 0;
> > +             }
> >
> >               writel(0, nfc->regs + NFC_REG_INT);
> >       } else {
> > @@ -476,6 +482,12 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc =
*nfc, u32 events,
> >
> >       writel(events & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
> >
> > +     if (!use_polling && ret) {
> > +             /* Flush the mask and acknowledgment before re-enabling t=
he IRQ. */
> > +             readl(nfc->regs + NFC_REG_INT);
> > +             enable_irq(nfc->irq);
>
> Shouldn't you re-read NFC_REG_ST, checking if the event became true even
> in the case of a timeout?
> Say the interrupt wake the thread but the thread never had a chance
> to run. The timer (on another CPU) had a chance to run and did wake this
> thread. Checking the event in the timeout case would help to prevent
> that.

Yes. I've folded a recheck into the IRQ fix for v8, after draining the
handler but before masking and acknowledging the controller events.

One detail is that the handler acknowledges each event and removes it
from NFC_REG_INT. For transfers waiting for both command and DMA
completion, one event may therefore have been consumed already.
Checking status against the original event mask would miss that case.

The timeout path now checks only the remaining enabled events:

      if (!ret) {
              u32 pending, status;

              disable_irq(nfc->irq);
              irq_disabled =3D true;

              pending =3D readl(nfc->regs + NFC_REG_INT) & events;
              status =3D readl(nfc->regs + NFC_REG_ST);
              ret =3D (status & pending) =3D=3D pending ? 0 : -ETIMEDOUT;
      } else {
              ret =3D 0;
      }

An empty remaining mask also counts as success: it means the handler
processed all requested events while the timeout path was draining it.

irq_disabled is initialized to false at function entry. After masking
and acknowledging the events, cleanup uses that flag rather than ret:

      if (irq_disabled) {
              readl(nfc->regs + NFC_REG_INT);
              enable_irq(nfc->irq);
      }

That preserves the write flush and ensures the IRQ is re-enabled even
when the recheck changes the timeout result to success. Successful
waits and polling are otherwise unchanged.

>
> > +     }
> > +
> >       if (ret)
> >               dev_err(nfc->dev, "wait interrupt timedout\n");
> >
>
> Sebastian
