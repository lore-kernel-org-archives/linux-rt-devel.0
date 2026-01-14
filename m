Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97D38A719
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Jan 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386578; cv=none; b=j8c9l66/hCKlc3NIOyq79NvfArgoKV3SVQU0Zd7SdX4aWWir8UOKUHDCEt+eEtnIkTgX2/I4aqH8yASvPTkzQ4pshJwPcKYMWb2UiZ82h+A63RUB1C4xQQ4grET4Y4i3319eS5o4HXJxAexyk7SpzV1+revfSRUsKIarDB5h9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386578; c=relaxed/simple;
	bh=tp1dg1tGdDVQpwTs0duVt2EFWfD8sffV41NoBpAH1Mo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=CUNoRUs+vZ7EWYRimZS9GY2dHrdclwsFM+p70uthVykE9k8eWlkUISqSXqrjaweRqX4G1N/F54EN0qcEqFKlvWdfsz0Dzk/SXAv5Ua12TGXfB3eYcueIX+vON4llM7ObEilZy/8qgHtPiFRZkiP3kKCVAjLYd0b2EAAk/NHe/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MHk++aOq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MHk++aOq"
Received: from ideasonboard.com (unknown [IPv6:2a00:6020:448c:6c00:b781:dff2:957:7831])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id F0B674BB;
	Wed, 14 Jan 2026 11:29:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768386547;
	bh=tp1dg1tGdDVQpwTs0duVt2EFWfD8sffV41NoBpAH1Mo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MHk++aOqJ6F2BKOnAmZV8wgcsmeabVICXX7HzKbmANBm26ThTcfQ6WBc3CA7iCgXv
	 1x+X3xWNxevSo1gSQ6eR33tEg/ltDtU2gRFnmMQ1Xi6i9OEkUxFKlG/ukd7wvmHZz4
	 w9WhvamFyC3M0qJd6+LRyBynEA2CobX2JpbJsBwQ=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260112174616.GB26365@pendragon.ideasonboard.com>
References: <20260112134013.eQWyReHR@linutronix.de> <20260112174616.GB26365@pendragon.ideasonboard.com>
Subject: Re: [PATCH] genirq: Warn about using IRQF_ONESHOT without a threaded handler
From: Stefan Klug <stefan.klug@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Clark Williams <clrkwllms@kernel.org>, Thomas Gleixner <tglx@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 14 Jan 2026 11:29:29 +0100
Message-ID: <176838656992.20276.7122537123495561033@localhost>
User-Agent: alot/0.12.dev8+g2c003385c862.d20250602

Hi Sebastian,

Quoting Laurent Pinchart (2026-01-12 18:46:16)
> Hi Sebastian,
>=20
> Thank you for the patch.
>=20
> On Mon, Jan 12, 2026 at 02:40:13PM +0100, Sebastian Andrzej Siewior wrote:
> > IRQF_ONESHOT disables the interrupt source until after the threaded
> > handler completed its work. This is needed to allow the threaded handler
> > to run - otherwise the CPU will get back to the interrupt handler
> > because the interrupt source remains active and the threaded handler
> > will not able to do its work.
> >=20
> > Specifying IRQF_ONESHOT without a threaded handler does not make sense.
> > It could be a leftover if the handler _was_ threaded and changed back to
> > primary and the flag was not removed. This can be problematic in the
> > `threadirqs' case because the handler is exempt from forced-threading.
> > This in turn can become a problem on a PREEMPT_RT system if the handler
> > attempts to acquire sleeping locks.
> >=20
> > Warn about missing threaded handlers with the IRQF_ONESHOT flag.
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >=20
> > This popped up after Stefan Klug posted
> >    https://lore.kernel.org/all/20260105-sklug-v6-16-topic-dw100-v3-1-de=
v-v1-3-65af34d04fd8@ideasonboard.com/
>=20
> This patch would have saved us from trouble with the DW100 driver, so

I can only agree here :-)

Reviewed-by: Stefan Klug <stefan.klug@ideasonboard.com>

Thanks,
Stefan

>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> I wonder if some people would object due to panic_on_warn, but I think
> the issue will be caught early when testing kernel updates way before it
> should hit users.
>=20
> > There are a few drivers in tree which will trigger this warning such as
> > - arch/arm/mach-versatile/spc.c
> > - drivers/char/tpm/tpm_tis_spi_cr50.c
> > - drivers/edac/altera_edac.c
> > - drivers/i2c/busses/i2c-k1.c
> > - =E2=80=A6
> >=20
> > just to name a few. I *think* if IRQF_ONESHOT was on purpose and not
> > driven by copy/paste then the they wanted to use IRQF_NO_THREAD.
> >=20
> >  kernel/irq/manage.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index 349ae7979da0e..18a8405cadb26 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -1473,6 +1473,13 @@ __setup_irq(unsigned int irq, struct irq_desc *d=
esc, struct irqaction *new)
> >       if (!(new->flags & IRQF_TRIGGER_MASK))
> >               new->flags |=3D irqd_get_trigger_type(&desc->irq_data);
> > =20
> > +     /*
> > +      * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
> > +      * masked until the threaded handled is done. If there is no thre=
ad
> > +      * handler then it makes no sense to have IRQF_ONESHOT.
> > +      */
> > +     WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
> > +
> >       /*
> >        * Check whether the interrupt nests into another interrupt
> >        * thread.
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
