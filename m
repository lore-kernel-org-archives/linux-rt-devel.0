Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB547C0FD;
	Mon, 19 Oct 2026 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392620; cv=none; b=DKzO3nKIQDxy753CrR1D9+pJriuC0aGDkiTc6TLjSzLtDNSc6jhYcs/frF9RS96B8Gfnjg5aR+U+5ELQpMUpRm183O7QYs5LXLwhrITFH8nW9rNFVa0QpC5mZAK5y87jdelauMx/8sT8Camlz4bFyv+xPDTSNq0Jia6xAFoNx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392620; c=relaxed/simple;
	bh=7RXQrDUrcYRxC+nYKERwwQDN6vNmNu1R5hI0Y19kG6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KViTxtUoTy9dJytQ7KsMXGOoxvziY0CVXvgagZOvFPuk06XBRhR0Uwax3XsssMe9UGo9hRXzxT7O4Qz+9DYjtAilYk0H94C11Jn25vDvGI1EUuJM0ef7DIHFx6BGDWk0xeu1tuCEip2esOEdJYchvZ+9e1k8fscnXXCPEmvAE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+jIjzxX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N0nc2AwP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+jIjzxX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N0nc2AwP"
Date: Mon, 19 Oct 2026 08:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792392615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emrArgPAsqjY08ePzydEuGzwJRc8mfRvNdYNfd+oT14=;
	b=A+jIjzxXNlwnaYRh3MCvTCxo+i9IXaPhGLvG2oH466t1wTayWoBberbLAa2GuRB/wHQgTC
	da2tJmZEYQOBdTmUpl+dQDW/kbTi+6wuwI07icPzElp34f7sgapAxeSU028PxHEAfjbzsR
	0Hw81pH3Tf39waNxC2ODPVF0kgQpH29elyjev+0uCfBpDrmis2ZCz92in7o6+VkKiqkzSl
	GZkKEgGxy0VAVBDGX4vTtulhRD7wbW0gcCwP5kQG1fHjuUE9BVU9w2xmyfkJke6LrYsNX/
	pOBOu0P59WVHGR1DGkdep5xRghY6FyD/+HgUN7MK66WEGNBihMDovhjLGbLhxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792392615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=emrArgPAsqjY08ePzydEuGzwJRc8mfRvNdYNfd+oT14=;
	b=N0nc2AwPluQ0WZBDwpFX2oxBUxd7FztoVVAORN9RA8l+QPlwEeWSIu1c/c+AuEx+nY1D5I
	CZgehYvF36e2EEAg==
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
	linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v9 05/18] mtd: rawnand: sunxi: drain interrupts before
 reusing the completion
Message-ID: <20261019065013.QUQYpnz-@linutronix.de>
References: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-0-b624c09e3ee5@gmail.com>
 <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-5-b624c09e3ee5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017-submit-sunxi-nand-vendor-oob-layout-v1-v9-5-b624c09e3ee5@gmail.com>

On 2026-10-17 13:46:00 [-0600], James Hilliard wrote:
> 
> This keeps additional synchronization on the timeout path, without a
> driver lock in every interrupt and wait. The caller can sleep, this IRQ
> is not registered as shared, and the handler does not acquire the
> controller mutex held by the caller. The tradeoff is unbounded cleanup
> latency and no priority inheritance: a starved IRQ thread can prevent
> timeout cleanup from returning and block other operations on the
> controller. This is a handler-lifetime boundary, not an RT
> recovery-latency guarantee.
> 
> Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260909085434.C8F201F00A3A@smtp.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
