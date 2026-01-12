Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D637F8BF
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240008; cv=none; b=L4pUwE0o9iuGoMgA2CzliuahB9GOeeMEZJwi4IX/OE0G7e/X9kCqMeuRnjslpRmmu76T1cRjjY17ouNY8VW7N5GYyfwgqMOe2Xf/FGZYmIQ42/OBZiOObEau8SBqklrbOwuF57FUHVIoY053CGIt4vSep1ftLn1lIsvWznPwQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240008; c=relaxed/simple;
	bh=7qsr8JjTXoeh5XTV7P8+rS/KrEgiIN4KUlQ4pOp7ys0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkfCDkApzMRqxwldhCU0tbY5FjwEtSpGGfwAXtxdUDqkK76YIPMLYd7tdDH574A2SBycnLIyNX/d1aKfWYYFHkOfprK8OSeN6nXPV7jPpNZ09aR4q3QCM+DzZlvO52XgPSMGcgXGP6zEL6/pBpZuf6oOmfSdUAmfvnzf23HBxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=k8wGEvuQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="k8wGEvuQ"
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id E21EC316;
	Mon, 12 Jan 2026 18:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768239971;
	bh=7qsr8JjTXoeh5XTV7P8+rS/KrEgiIN4KUlQ4pOp7ys0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8wGEvuQqoJRELaYNm9zFsMHA37Kcn/2Mix4fNYvVPNVqRCuF8Xcc2MxeijQafgrq
	 zMLyAFn6FlRXIDiAxaODuM40dQnGNDO0kDst7G6J++7WanWJVcPedc8mKFLrffF3Kv
	 iUZ6Lu5CHfUr0XCz9jsVDKw+bzATyxTjtP7clRqg=
Date: Mon, 12 Jan 2026 19:46:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH] genirq: Warn about using IRQF_ONESHOT without a threaded
 handler
Message-ID: <20260112174616.GB26365@pendragon.ideasonboard.com>
References: <20260112134013.eQWyReHR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112134013.eQWyReHR@linutronix.de>

Hi Sebastian,

Thank you for the patch.

On Mon, Jan 12, 2026 at 02:40:13PM +0100, Sebastian Andrzej Siewior wrote:
> IRQF_ONESHOT disables the interrupt source until after the threaded
> handler completed its work. This is needed to allow the threaded handler
> to run - otherwise the CPU will get back to the interrupt handler
> because the interrupt source remains active and the threaded handler
> will not able to do its work.
> 
> Specifying IRQF_ONESHOT without a threaded handler does not make sense.
> It could be a leftover if the handler _was_ threaded and changed back to
> primary and the flag was not removed. This can be problematic in the
> `threadirqs' case because the handler is exempt from forced-threading.
> This in turn can become a problem on a PREEMPT_RT system if the handler
> attempts to acquire sleeping locks.
> 
> Warn about missing threaded handlers with the IRQF_ONESHOT flag.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This popped up after Stefan Klug posted
>    https://lore.kernel.org/all/20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-3-65af34d04fd8@ideasonboard.com/

This patch would have saved us from trouble with the DW100 driver, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I wonder if some people would object due to panic_on_warn, but I think
the issue will be caught early when testing kernel updates way before it
should hit users.

> There are a few drivers in tree which will trigger this warning such as
> - arch/arm/mach-versatile/spc.c
> - drivers/char/tpm/tpm_tis_spi_cr50.c
> - drivers/edac/altera_edac.c
> - drivers/i2c/busses/i2c-k1.c
> - …
> 
> just to name a few. I *think* if IRQF_ONESHOT was on purpose and not
> driven by copy/paste then the they wanted to use IRQF_NO_THREAD.
> 
>  kernel/irq/manage.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 349ae7979da0e..18a8405cadb26 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1473,6 +1473,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  	if (!(new->flags & IRQF_TRIGGER_MASK))
>  		new->flags |= irqd_get_trigger_type(&desc->irq_data);
>  
> +	/*
> +	 * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
> +	 * masked until the threaded handled is done. If there is no thread
> +	 * handler then it makes no sense to have IRQF_ONESHOT.
> +	 */
> +	WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
> +
>  	/*
>  	 * Check whether the interrupt nests into another interrupt
>  	 * thread.

-- 
Regards,

Laurent Pinchart
