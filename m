Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E1417BFE
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Sep 2026 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543279; cv=none; b=Pq7haDDeIaLjCGv5W4omHRe6bm9+sFo3/MS3ifA/rCorU1U7HmUhcCyhUZcFZkiHA/3vsV34OmzMsCODVggaORxjJp1xuLI8E3JewLmTY38FjRodi6yexoewiusIc+P+ZtnbGKGbf3CiBz9KHq+PsLu2NZ4yDcCn+zIzKkXq5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543279; c=relaxed/simple;
	bh=5315Qxyq0JSBtaykg+mkjDBCGmxc9qkZXgeHBlB2cDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Use0jUcOb4nxRgha9PWXgjGFwszeM6eDo2PKOTkXIJVgjI/MiFGP7PG8x+NIyZgzKDumnhILkZxj8O3s34L/LEpAuZfNIEQ2vLlIrl92c4lBjqcH9rCJbY4L9/Pe5Qhly5Zvd4lR8DP0EYJLOy6nVuXhVGXs00RRa77z2teMUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+4jAHBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dh4Al5Yd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+4jAHBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dh4Al5Yd"
Date: Wed, 16 Sep 2026 09:20:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789543258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yN5GnEzqr4pxp32nRIlflPr/wwu80hDMDshxyC9+c8k=;
	b=u+4jAHBzlElxL52YTj10a8qVGG1nF2AeLvbpoyqOc83AeI3rK8Ia6+438zfh0VqurZ3fWF
	4LMHxVi0KePnWRU9hCZ1RMK/HLsdgPjc+a0xRzdjZz8XYV9DSV9CTD3GZkiFHlFuDYgVT3
	It75w+qGNLp55OZyJshAlySI1ltpyr/VJy6qRB4lIg5YMIerTsEEDkQf0uoK3OB2UWqVnw
	m+RdTI/e1Jj+pwJ8u/6pxksSZ17p8wW35Zx+6V2TuF+kw1ZhmQMJGNY7yk4WpdlRsqbRHK
	jjbLYyNJFWgOVwR73zlAnt0QvVecPU78ttzzRQJXS+4petsIBTh6uHZGfI7iFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789543258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yN5GnEzqr4pxp32nRIlflPr/wwu80hDMDshxyC9+c8k=;
	b=dh4Al5YdyJgoTe2/lLtkUC9aOxQnmtKfPiVXm5ougI5bK4Rx7uujpHS48bZ8SwLjnQo6EH
	lfi0wcYJxHeeBlBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] gpio: mvebu: use raw spinlock for MMIO regmaps
Message-ID: <20260916072057.HeaSg_Ya@linutronix.de>
References: <20260915222609.194216-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915222609.194216-1-rosenp@gmail.com>

On 2026-09-15 15:26:09 [-0700], Rosen Penev wrote:
> The mask/unmask handlers run with the generic irqchip's raw spinlock
> held and call regmap_read()/regmap_write() on the GPIO regmaps. By
> default regmap protects itself with a plain spinlock, which becomes a
> sleeping rt_mutex on CONFIG_PREEMPT_RT; taking it while holding the raw
  sleeping lock

> irqchip lock trips might_sleep(), and PROVE_RAW_LOCK_NESTING flags the
> same nesting on non-RT builds.
> 
> Configure both GPIO regmaps with .use_raw_spinlock = true so the MMIO
> accesses stay atomic in hardirq and raw-locked context.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

other than the comments,

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

>  drivers/gpio/gpio-mvebu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 03e977c2a629..674feeb31774 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -598,11 +598,18 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +/*
> + * These regmaps are accessed from the mask/unmask handlers while the
> + * irqchip's raw spinlock is held, so they must use a raw spinlock
> + * internally. A plain spinlock becomes a sleeping rt_mutex on
> + * CONFIG_PREEMPT_RT and would trip might_sleep() from that context.
> + */

IRQ delivery path must hold raw_spinlock_t. This is not special to this
driver but must be done in every gpio chip. I wouldn't add this comment.

>  static const struct regmap_config mvebu_gpio_regmap_config = {
>  	.name = "gpio",
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> +	.use_raw_spinlock = true,
>  };
>  
>  static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
> @@ -610,6 +617,7 @@ static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> +	.use_raw_spinlock = true,
>  };
>  
>  static const struct regmap_config mvebu_pwm_regmap_config = {
> -- 
> 2.55.0

Sebastian
