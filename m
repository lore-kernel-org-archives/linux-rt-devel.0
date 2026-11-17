Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924398;
	b=0L6uy7H2ghaCaAHmZnZKQhhzLIyLteK4ARQbQDQXU4RwDYkwoKD9+svHOTP1JrRvX5JE
	 2rIot1rYs3QaF8AQeEUbHjMxmio3hM4i4bV3Vtu1SrcoqNig4km3tCHP6HAMVRGCdH5PJ
	 /uKQ0zzP3y6wg/DTGrf4ogM1i0N0ImXI15Z2sLKR4Zf5TRQAYV8GqFPtdw/qoWIizUVKu
	 v/KAuDwrX2IJXTp/0M/n3hFgroiq0uJfWxGpunktI4iPXxz0102vGsO09L8XiOoc9GzZl
	 btQ+yn1D0ZzW2a4aJTIMtRQY8GnieiyISGx31S+CFjseLT2wpTcDSqe++ffai3h36QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924398;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u4DWjIfT8KRVg4FASuV86OIAjU2csjxn1K0PicbuhrM=;
	b=WuaL8THRIxuNDH2KpOVYFEdmFYrvFQDP/oBQmIM4APNQg0yZfS2CRPNtMdvFJl2VUIii
	 fzIS3GTZfz4smyB6JKxhTIII96gdZzWTNj9RrMmg7H0+sRhg1Qgxdw+GmFF9KGE4Sd/H2
	 2eOCwaAslJ32e2r7cuj6qsSxVjigwhqHksTdQZ0hK2e8szm3kfdUYtNG+IcDOFlP8xCb4
	 kJvPcm4C7MYv06fiFH0pW3m8nlcZoI/zG6FJFHvla1VfZ8+GjT9ZJyKazMwShmif9+97f
	 1EwC74BRdmTjvDTdfjoaZlEqtj4oiDNnawFVkozjA2a0SRL5kuwD8jMW+u3po4vdRsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNhG4l0P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F0606A32A
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNhG4l0P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EDF1F000CD
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924398;
	bh=u4DWjIfT8KRVg4FASuV86OIAjU2csjxn1K0PicbuhrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZNhG4l0PhuvP8NHjII7K1OWgC7H4A0B/sgzCOiGt+BDXwLI/kJ8bbYUNQMD3TtaD4
	 KXAThsILUyBoFqmEDBtAPD1fiC8mr/9TOdfdOOzLIqJH3zMX24ermtwuE385kWqhm7
	 BD/bY0cgXnE1JbiJhwgVeevXQm8zzhsMJ9N5LQ7jLTkht26eH2gLOe10t9t9IXpakS
	 TxJ18PSLMVFfMloeF9YYRT6OhJC/rmQKBTVDc0NProVicUx/IFLavkefPZAepfz59t
	 7kx+Qk8w+HbcGwRtYV3c+Vs6u+Mz/OMhq6mJE352DF7vC2vXoEOkkpupAL/ko/yKMG
	 q4fk8CbQ7CwQg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c1479a959aso3793182e87.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 06:06:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFRRw9Cn7LY3Lmb2Ilui37ElyQQrj1yv8tOVHBUee3XZ30X71NARNRsFOO8Q0su0Jb0UfKJM9AHxbozuEgfNg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Dv/iy583W+mbcUkhHc8ASnvHYBt5bGAmwAXrJdlaP9xO6g7g7
	A3Pnjjrr4ZmPxu8o48UDlpAPHpVCQtLbV1ldDeCv8emyBBAK2O+wNyqX8L6ld3J76dAGoUMQ+5b
	i9OUhD+9j+ksynzb8D1MZQrmPPoekWm8=
X-Received: by 2002:a05:6512:668d:20b0:5c1:56f2:fdb0 with SMTP id
 2adb3069b0e04-5c1709ca3e4mr3590915e87.34.1794924397227; Tue, 17 Nov 2026
 06:06:37 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261109-ocelot-pinctrl-irqchip-fixes-v1-0-9d2d8fcd58f5@microchip.com>
In-Reply-To: <20261109-ocelot-pinctrl-irqchip-fixes-v1-0-9d2d8fcd58f5@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 15:06:24 +0100
X-Gmail-Original-Message-ID: <CAD++jL=i2_wrKNZ9tRJL+mRsXcAR3dJXVdGCNKe_AbT1McnP1A@mail.gmail.com>
X-Gm-Features: Aa3M54r_ZsB77NFXbqKooLbzXYFq-eAsg2wrDFxQdC2OMAqKX36xkKlww51lUws
Message-ID: <CAD++jL=i2_wrKNZ9tRJL+mRsXcAR3dJXVdGCNKe_AbT1McnP1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: ocelot: fix the GPIO irqchip context handling
To: =?UTF-8?Q?Jens_Emil_Schulz_=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Colin Foster <colin.foster@in-advantage.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Lee Jones <lee@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 2:50=E2=80=AFPM Jens Emil Schulz =C3=98stergaard
<jensemil.schulzostergaard@microchip.com> wrote:

> Two fixes for the GPIO irqchip of pinctrl-ocelot, where the irq_chip
> callbacks take locks that are not allowed in the calling context.

Patches applied for fixes, excellent work, thanks!

Yours,
Linus Walleij
