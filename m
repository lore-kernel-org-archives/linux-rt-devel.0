Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481560;
	b=Jd0/4mCUQDw2JN28DgeOiieFmppGOdIYi/fygkbngV4DRxHAfgiy9qgQSv8vAmBaLupE
	 I7iOIUY58+K3lHjon4IJy8ZFt2uOM7Fqu29LwsnLGAG8OmlNtVGjNaxYorFhBkIxXZa/K
	 3DIjg1/YL+N6xDTIX7k9mVnM6xdkDxpekJvuMTtlMMVMLrInQI1SmS1GsL2iUhLTYpIpq
	 ogTtkLm3Y2ofzMfadDYJ79a52DJysqQ9ZXt14PNo7OO7UZMiH/DQgDuBfJyxdCBECm+B8
	 SLX0cf8NZqFvIa0KGPldKiIGlLMpJJ3MgviRFZpNoufX+BFYM6d83Y+/NcQjSeGFGXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481560;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=AbbG2Q6j4Hecrtu/PulD9TnwIM8oYREi3XENRG9e+T0=;
	b=yzz6v+5Dqsl6YQbQ4wblrZ4K8bl5IYvMAiD+VLeK0bOBqp85Vb7DWjXsCT3evDK90lfp
	 pofALtTo3+i9qfY3C2eNp+jd3VMGkZGvyiezNDmxrLMKqvJ7AkUpe4OoD/wr6oy2AOPAa
	 JFidhk+6P5OI0DVlZuJs6j/4uEt15m01m+psFLlU7fPfws1eQMw7hXgt4FBL1JvLqmRLk
	 PuG0Lhcbu5mEPC8Is4XaljZDPp6b7sF3wkQVTg9wZChjpHINmyLoKlHz5v7wkDuYbnOw0
	 PSQYXok0GwK5AeBz0ow4kG9zluoIslHe9UessFuhGWs/pvAh2VWf9Izo8sTJh4NPkcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=K477aKgm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CY4xOlG9;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAB606A31C;
	Tue, 20 Oct 2026 07:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFAB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=K477aKgm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=CY4xOlG9
Date: Tue, 20 Oct 2026 09:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792481557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbbG2Q6j4Hecrtu/PulD9TnwIM8oYREi3XENRG9e+T0=;
	b=K477aKgmkz+L+RRd+uucEpbLJ0f0xKJRbJMfRt+6Ovxjrea0w0kLPKBE5pAcVCIEDbo1l5
	mT0KYpEsopt8ZkoUShMmn45KL4YIHT3PvAwNfUPHN73uzIG1rdp4RQlRpVNduOaSunwJ1I
	fFI6AZFYjFCqqDkshKZ1oSh6lyYxhQjWWrNKyyZv5s6IxcBDyREqjG6ss/H7Ouja4XWYig
	3nGe9jgw5DNxc0PaBrFMUPvEEG8JbQXAUsnIQXEW40UkFvqcvoS7nhV+9dO4VdiACU7tLX
	9FrRFppKhgnJvIikvN2imkbISyzdfwGDbZvSYQUBa0dC2Ff13nHAYlrzkWZ4hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792481557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbbG2Q6j4Hecrtu/PulD9TnwIM8oYREi3XENRG9e+T0=;
	b=CY4xOlG9QFW8DCbV7CCf/a69uJonoMF1BH+tVAs9yDlMABxmZbFtFiTlS0+2B5nu9/U1+T
	INrARMRaDy1GEgBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sean Wang <sean.wang@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Hongzhou Yang <hongzhou.yang@mediatek.com>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, mfd@lists.linux.dev
Subject: Re: [PATCH] pinctrl: mediatek: common-v1: Use a raw spinlock for the
 pinctrl regmap
Message-ID: <20261020073236.dDVmd3BW@linutronix.de>
References: <20260929-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com>
 <20260930080609.dnK1-Uta@linutronix.de>
 <CAGXv+5FssQL3Go3VDFbLAT6HP12RS3U3OgxhYOeapzs64QTdUw@mail.gmail.com>
 <d3d3e7b3-eb8b-456d-9a2c-116334e86c14@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d3d3e7b3-eb8b-456d-9a2c-116334e86c14@gmail.com>

On 2026-10-06 19:57:01 [-0500], Ryan Brue wrote:
> Hi Chen-Yu and Sebastian,
>=20
> Thanks for looking at this.
>=20
> On 9/30/26 3:17 AM, Chen-Yu Tsai wrote:
> > The syscon node is the provider of the regmap. You need to fix it there,
> > not duplicate it in the consumer.
>=20
> Unless I'm misunderstanding, no driver binds to that node, so its regmap
> comes from the generic syscon code, and changing it there would affect ev=
ery
> syscon. Lee, Arnd, Mark, would that be acceptable?
>=20
> These are the options I see. Please let me know if there's a better one:
>=20
> - Do what Sebastian suggested and make syscon use a raw spinlock, except
> when the node has a clock, since regmap-mmio calls clk_enable() under the
> lock. Off PREEMPT_RT, nothing changes. On RT the lock would no longer be
> preemptible for most syscons, including across bulk writes. Most syscon
> users that do bulk writes only write a few registers, but enabling the
> Amlogic G12A PCIe PLL writes a sequence with 40 us of udelay() under the
> lock.

bulk writes could be a concern. The 40us delay is within the lock
acquired? If so, could this be done without the lock? I assume this is
part of the init sequence so nothing should use the HW so the writes
should not be interrupted by other writes to the device.

> - Have the pinctrl ioremap() the node a second time alongside syscon's
> mapping and read the input register (DIN) with readl(). That read is the
> only access the EINT code makes in raw context. This would go around the
> syscon, and it requires that DIN never be written in a multi-step sequenc=
e,
> which is currently the case.

So it would be safe for now=E2=80=A6

> I'd like to know the best approach before sending out a v2.
>=20
> Best regards,
> Ryan Brue

Sebastian
