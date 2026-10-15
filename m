Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E054349BA;
	Thu, 15 Oct 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048801; cv=none; b=ZfZ6yoywzDviJ6PoVAX/vniuLcY4gr3ZppqaC/9zrTfn4EGwA6y8nkpj+YlkGYlWGX5GaBuJrFAIZkOH53s7OIFuofJnnpckFzvPhGTrcp3wF7Fb3/6O0HB5IdCOXHrHUeXhT+Xpihm38P7zMr900yTJyFrF7A5uBArEY9s7KIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048801; c=relaxed/simple;
	bh=qolKMPgaE8eWxeIr/0flsIM3PsJ+ucbodpca0yrAjUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r648+tDn+cBdlzn6ZCPHUZ+NEevOmRqYMLSSlNQFxAwJWMZFNrbFxApP0u8FaAZjRsEf9gqM57Wi/X0sEip8seRM9wX6Nr8UbZ1Xb51ckZcZ+VBbZQKEj0ml0mHos4w8OOYZFHwLMntzn6HXdCUMLUfHyHQ7Ar4P/RJ9nRcnF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dhabvrm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkUw+EUC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dhabvrm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkUw+EUC"
Date: Thu, 15 Oct 2026 09:19:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792048785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMYu6XVNal0AJcS3PUZBVy2r/rGrO8ylXWPO84VbQeo=;
	b=2dhabvrmaiB4B2VAEeswkB7yZk+pT6F/neoH/LS31NDI2EasvjB3yVv4534B6du3DDiMSw
	gMrc965fNvSGCVlP87f6uNl3leecQv3nIZRDmwfmb8S2h/cJW559zsz1m+2w3dBJKq/Ruc
	CwYvgSTmAKPw18wco3hfv5EYFXB0cfCf1E5PBGBQET2HTHFjkzd2aEsSZKUubuexi86NZu
	9JjQ++YpNiWDfm8w5sPlbjl7kAfi5zXU47N+ESy5a776vyVgUcr93gLbDSCiqK1Q+sWEDr
	PfqofcDMr1vdOjhET3/jJZnJZC2gee+wkLn2s1LESxe+zvqTtxnEuGerbM2Mdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792048785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMYu6XVNal0AJcS3PUZBVy2r/rGrO8ylXWPO84VbQeo=;
	b=AkUw+EUCmsaDH+sGC2dLGo8hwRAJMoyzJ70p9vgVLsV/6hgT9AkOw03tMby+l6jzeW5i4D
	mP6nSW669f2bkfAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Brian Norris <computersforpeace@gmail.com>,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 04/16] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
Message-ID: <20261015071943.7OihPadq@linutronix.de>
References: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
 <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-4-5d3fc6ad2da1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-4-5d3fc6ad2da1@gmail.com>

On 2026-10-14 19:33:51 [-0600], James Hilliard wrote:
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -454,16 +457,19 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
>  		timeout_ms = NFC_DEFAULT_TIMEOUT_MS;
>  
>  	if (!use_polling) {
> -		init_completion(&nfc->complete);
> +		reinit_completion(&nfc->complete);
>  
>  		writel(events, nfc->regs + NFC_REG_INT);
>  
>  		ret = wait_for_completion_timeout(&nfc->complete,
>  						msecs_to_jiffies(timeout_ms));
> -		if (!ret)
> +		if (!ret) {
> +			/* Drain the handler before it can restore an old IRQ mask. */
> +			disable_irq(nfc->irq);
>  			ret = -ETIMEDOUT;
> -		else
> +		} else {
>  			ret = 0;
> +		}
>  
>  		writel(0, nfc->regs + NFC_REG_INT);
>  	} else {
> @@ -476,6 +482,12 @@ static int sunxi_nfc_wait_events(struct sunxi_nfc *nfc, u32 events,
>  
>  	writel(events & NFC_INT_MASK, nfc->regs + NFC_REG_ST);
>  
> +	if (!use_polling && ret) {
> +		/* Flush the mask and acknowledgment before re-enabling the IRQ. */
> +		readl(nfc->regs + NFC_REG_INT);
> +		enable_irq(nfc->irq);

Shouldn't you re-read NFC_REG_ST, checking if the event became true even
in the case of a timeout?
Say the interrupt wake the thread but the thread never had a chance
to run. The timer (on another CPU) had a chance to run and did wake this
thread. Checking the event in the timeout case would help to prevent
that.

> +	}
> +
>  	if (ret)
>  		dev_err(nfc->dev, "wait interrupt timedout\n");
>  

Sebastian
