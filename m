Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBF524AF4
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058177; cv=none; b=k53vxLCOW+hsy0D0eJ4EjJShMVQngmeOgNWakfkrt/W/NkPFQNrTdAuV+2jZkvmnzla8AB2SutBb26pBQNlZzaaYBif6B0mLhif6+cCFga/J+pw2DFLLfOr5eRnOQ2pQ8qn9wYeBLXSBelkW8ZGp56q2zHS00+5BoegYLnx9QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058177; c=relaxed/simple;
	bh=WFEg5rBy11tyNBNdIuvVomtgQF/QuAip/Xj+WCkUSmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SilHfndu4ytzAPspeW9cgjTjW35eP4FTeljcRJTA1dlOrzOJq3tMinRZ2cbyqUAS5vKO7wAWIuGOhyOjxS3+G1B1tzOjWBoQuITVIYK+JWd3kdjgrslLoK5Kc5acRbslll3hoiHz9KFW+imPSBb9BSFCTRSIFM269M0X84w6pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRmqjzV1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wqc1csHQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRmqjzV1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wqc1csHQ"
Date: Thu, 15 Oct 2026 11:56:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792058167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFEg5rBy11tyNBNdIuvVomtgQF/QuAip/Xj+WCkUSmo=;
	b=XRmqjzV18wuoqXRgtigU+fhfMIjgiNIQ3iewlkI98Nlj9+p8+YerN+bdrrAeHLOqfbFEND
	8YHpTWE/exAN3kDfGBz5QEtqz2nODKSTbiQZemTeosnT8klcPbks9EYSWIqhnrhrAQ7nAu
	5qzEqp6bCMpI2cZqIQ5xv8oGruE+k+UXX//e515ZF9FwP2EYcoG6Qky/8VITSM217MnsrQ
	kzJhriC77K7N4i2AmMwCEwWe4yfmU3od4i7TKfgr35cSMT3CuC/tdn90S3wEXPuSz4vedM
	rs83CRLJKT/E9KBCXdIHasLJvgmacIY/D22A7dmU0ZnvCry9Gpt2peQugKpcZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792058167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFEg5rBy11tyNBNdIuvVomtgQF/QuAip/Xj+WCkUSmo=;
	b=Wqc1csHQ5AUTcgoWYY++Pje58rEo92XZN0S5XXlUOsYd/XU1uIyY80XLzsWr2q1jwJ1p6J
	b6d+2IxgF8PJAzBg==
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
Message-ID: <20261015095605.pIRkhzUR@linutronix.de>
References: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
 <20261013152727.2cUDX3l0@linutronix.de>
 <5a8048ef-a241-4486-adc1-440721d3606a@mobileye.com>
 <20261014105312.xNkvgkGg@linutronix.de>
 <46eaa0f0-ff72-4a72-91c8-b610be2d893a@mobileye.com>
 <20261015063227.GBjyN6LZ@linutronix.de>
 <9bb6f315-c668-4f90-9fee-920f115a3dcd@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bb6f315-c668-4f90-9fee-920f115a3dcd@mobileye.com>

On 2026-10-15 11:11:24 [+0300], Vladimir Kondratiev wrote:
> On 10/15/26 09:32, Sebastian Andrzej Siewior wrote:
> > The driver providing MSI capabilities (the MSI domain for this device)
> > must a module. This is the requirement so that _this_ driver returns
> > EPROBE_DEFER and *then* once the MSI domain driver is loaded as a module
> > (after boot) this driver is probed again and succeeds.
> Why module? for "riscv-aplic", "msi-parent" shall be "riscv-imsic" and
> it is "builtin_platform_driver", see
> drivers/irqchip/irq-riscv-imsic-platform.c

But _how_ do you want to make deferred probing happen that will change
aplic_syscore_registered after init without using modules?

> Thanks, Vladimir

Sebastian
