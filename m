Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D03A9615
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045953; cv=none; b=QY/T2MRhiwua9SnC/cGFpX3lfAhoAwPuIeGAeTvKTR+Le9FRRAR3qGGJ9FynO+AQa6x6In9oybqzGqIz4VuTXC+RKEULhJk/rXILov1EWy77bCtNXZpl36MCpCicgNEDIacfQzxCTPBfQR0bDwNsbX6TSV6De45JHpRiQh0uHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045953; c=relaxed/simple;
	bh=DpaE7NVxdPPCV1X8GRilId81ScbPzZdCbZ/13H6BkSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2DFOKRfUPanwm32xThi/Uykc1PK5Uy1oRoIkoLq22y3TiOT6eVK5RSnPTK15hKS66iKA8e4OOT7KrYZmytmy8HP0L9pmSz4gBjs0uXwMuvWoAAaWuWMgbgPx5rYyjTV+neyJS8caG2GSnZq6ffuN3/AqlTZ21gbJudO6SrKI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avscnrmr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOQpfsAc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avscnrmr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOQpfsAc"
Date: Thu, 15 Oct 2026 08:32:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792045950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rlb5hQ3oMGtjIZB0mG1VIBGlNWQ+sMhpm0CKuyKp/8=;
	b=avscnrmr0x0jBlODANIotKUcpY8WwO+T1SFbC7RG4QbS/jgsRiAsaHYT1o4oYIoDp3HvaM
	BQCHkuKaQM4iCSMO281pgmUhbPCbftgJrLpWXlgrYp3tkvBkMB2MxGPWh7oFbR1SwTgi6L
	K1SrGTiUVAIMBl1MmNDwCHlgBu6AVld+oQO+aUtOUK32juXQ/QMlQzgeU8i0r5Zl3ox4EC
	/BhObAkMh0uxO5r4SKmdXIIzMDfok2j+zkvSMz3xoM9ltxjcdiTKnu33m+XeQrW5uo7+iS
	7UY4Y9McC0xsN+vszWDgeNWZWl1b8wyL9iJbWLBD58E5O7WiMJ6Cu/bTvgsY7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792045950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Rlb5hQ3oMGtjIZB0mG1VIBGlNWQ+sMhpm0CKuyKp/8=;
	b=pOQpfsAcK+CdgMDJgnsXbnvyLXTHb6qpjLg+lmR04PhVu61Q4dLM51aPBNbWYSBYWR8bGl
	BRi5V8el3x5KZ+Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jessica Liu <liu.xuemei1@zte.com.cn>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] irqchip/riscv-aplic: fix asynchronous probing
Message-ID: <20261015063227.GBjyN6LZ@linutronix.de>
References: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
 <20261013152727.2cUDX3l0@linutronix.de>
 <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>
 <20261014105312.xNkvgkGg@linutronix.de>
 <46eaa0f0-ff72-4a72-91c8-b610be2d893a@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46eaa0f0-ff72-4a72-91c8-b610be2d893a@mobileye.com>

On 2026-10-15 09:19:26 [+0300], Vladimir Kondratiev wrote:
> Not exactly, "driver_async_probe=*" in bootargs request only drivers that has
> PROBE_DEFAULT_STRATEGY to be probed asynchronously.

okay.

> > I would not expect the MSI domain to be probed after kernel booting via
> > a module. This is the scenario where this would explode.
> > And if you consider this a problem you should address it and denote it
> > in the commit description as such and not silently changing it as part
> > of another change without any explanation.
> 
> OK, will add explanation for this.
> This driver can't be a module, it is "builtin_platform_driver(aplic_driver);"
> but still probe may be deferred if of node has "msi-parent", see
> aplic_msi_setup() - it can return -EPROBE_DEFER;

The driver providing MSI capabilities (the MSI domain for this device)
must a module. This is the requirement so that _this_ driver returns
EPROBE_DEFER and *then* once the MSI domain driver is loaded as a module
(after boot) this driver is probed again and succeeds.

> Thanks, Vladimir

Sebastian
