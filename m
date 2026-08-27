Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095E484220;
	Thu, 27 Aug 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843464; cv=none; b=j3AbSvGvxQnzWudw/uk84dx7DfP+l9SQUX2I4EGMNobhuC5eyh0WCxxliEQ0Hymz/TMOegxr0DunzWbQba3U3hFNvoKsrrp2GQfPUdiR8TPAzyyACWCPtWmdQyEW0qbFUr+uW9JpqN2GBBom/4SHPh5AxWLQaPNzC0yA/Km8iW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843464; c=relaxed/simple;
	bh=wypQmDHUmcBJmH1nhaLuSZ2cqQW4q1hP00xbJAXnlJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3YciWGf4YHRD/9z7YeBNVUWFFJeE1+2bJP9qjCPZn+nejTw/SnxfcaXKGi5qQ8nmSUXwOJEiQMSuN5QuFIhxjWN0+a5G9B1CuMkkXjFYrO9bfcpqTtOy+X9x464MRfgY+xOPM4oECTNwVFx7j4BaR13z8Prp/OXyJVRpSFMrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1pVnvi5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+IzuBO2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1pVnvi5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+IzuBO2"
Date: Thu, 27 Aug 2026 17:10:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787843457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wypQmDHUmcBJmH1nhaLuSZ2cqQW4q1hP00xbJAXnlJI=;
	b=M1pVnvi5/FOctF+AJQ3fJd4zoa9BaWw8XL/6bw+AYqZ7joQGG48ky2PIxfM/l8ARJk22T3
	zTzevqto632G7v66F5Cua0qZZFz5jmt1vIJ7iIe9MjfoCz3I/cbZRiEQy3WMhL2VBkRXAx
	oPBYk+3gQcuG510TbF8rkYPJHHMa86Ee/+gwrSJiz8SkdYjOPurf/nbQalO7pnXKG9aql8
	J6WXqKGsuYOOokapNZZk/LbO4hBWqZptYKqBH444tygtKQa75z6U61UlqFYRJPx027Av7Y
	w73RoaZBYmt/yfXsxevOKp4Bjt+49RgIR1uxxooqp0N8hFBgI4O2zNdGHHsfSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787843457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wypQmDHUmcBJmH1nhaLuSZ2cqQW4q1hP00xbJAXnlJI=;
	b=Z+IzuBO2jz4XIuRKpsm6Kra6CrM0Db+wSUt9ljjkuUb3ojtR1Vn9faOSPItXGTQW7uFiyx
	ohhUj+hn41Xcj+AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ju Nan <junan76@163.com>
Cc: antonio.borneo@foss.st.com, linusw@kernel.org,
	alexandre.torgue@foss.st.com, arnd@arndb.de, clrkwllms@kernel.org,
	lee@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
	mfd@lists.linux.dev, rostedt@goodmis.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] pinctrl: stm32: program the EXTI mux from .alloc
 instead of .activate
Message-ID: <20260827151056.QrjGOPuG@linutronix.de>
References: <20260803061718.43210-1-junan76@163.com>
 <20260804141402.86911-2-junan76@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260804141402.86911-2-junan76@163.com>

On 2026-08-04 22:14:03 [+0800], Ju Nan wrote:
=E2=80=A6
> Nothing requires the mux to be reprogrammed at interrupt startup time:
> the domain has no .deactivate, .free() only releases the irqmux_map bit
> without touching the registers, and the resume path reprograms the mux
> itself in stm32_pinctrl_restore_gpio_regs().

The deactivate was last removed in commit db0f032512443 ("pinctrl:
stm32: check for IRQ MUX validity during alloc()")

=E2=80=A6
> While moving the code, release the mux reservation when the hwspinlock
> cannot be taken, which the .activate callback had no way of doing.

It makes sense.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengu=
tronix.de/
> Signed-off-by: Ju Nan <junan76@163.com>

Sebastian
