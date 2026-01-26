Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150833290E
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424796; cv=none; b=ifftOW6p4PNOJWUDh0Xqhuv8bD8n/xGn2Akr9O+iawJ7lv9Z434n9wvadgC/DjLC1nuLTB0tCbjv3R5b3O+9i+ounG1pw2Tifo8sfg4P4VvorssxKIYWMgtk2qDFxRMylVejl9CZjIRAZRU3kRXZIxb5ca7B6H5B1jilm/dFIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424796; c=relaxed/simple;
	bh=kxPtlEXFZ9lzbdFRuzXSQejeJO9JqTeeLPP+hygrZgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPWp1RpK/w5glVgH87yyiNjlbIYL9sH0plNhfy1OlhvK+oRcydPUZjvP/Y5zCTB7ZpDN1X3rpuFLYUALwvF4PJqKu9SNcXfSsefczhEL0Sj8Bj4K3m9TlRJfPX7TR6yx5rQqQE1+r6YsST6/EClgmdpGN/PM2YPHG+Kp1Ao7Lbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWPjXzTN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWPjXzTN"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-383122fbc9bso32139231fa.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424791; x=1770029591; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4K6ETBKLvIoiuBK+sPeSvqfE+sePiRFMG7yACoX51I=;
        b=bWPjXzTNV8/js/sa//ODX8Ofi0/IbbQwRsXjCseR0nUVCH92zp6fQ5v8Fg1G1ZeqOi
         +nWEQpMa+I3nu0PF0wBB0A0RALJHQZ6lh9pZYd9bPbQlg4s9bS2/k7SQKrLQb8dBih8/
         4Q7Efqfhf+knV25Mc/AMtTWhC6UbpqL3yXvzoX+raL1JMrQx2V6ZJ/FPCZcEcRkiJm3W
         fsz8ErF5Qpp5DugVaKjO6Kfo00byyzkh2BFBIG4RcJ7nI3Wc+mAKutLUnLkoP0p95E0h
         mKLVeS23FJO/Ude6ILN574gzh/IBA6LOTiFWcJU8t7wDJp9OrWl6zn6FKIS9Mzhf6TdC
         TtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424791; x=1770029591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4K6ETBKLvIoiuBK+sPeSvqfE+sePiRFMG7yACoX51I=;
        b=nze2+ARWGIrQGcteP9G1u0ORQzIJQBlq9MiQ9XpTJUm+B/uURT0k0wkHWrrBpvcwPw
         eAKI08jXK1hBAhX6eqtAojB2lhTSEVOQ0WVPhBixSAqq+Ljqbp11JYVv1GBz1mjPNuNc
         PhN0ztCrYQ4J3td3PwMddT/Hmy26u+Ogi0veSCYdqIqF9zoi6DFC4HpD4Vhdwtuc4L2J
         JzdqaAveGpLMxWxiJfpHQ1BjI8t+cItrTbBTTkljiYZIEzwmM1vkSsoNop3D1ntlneL/
         BhISrnR0sTikd/ETF/nb5ld0Z2kQzGvfkjXItRrFsLKZxMhWR+hTj8VmE5SckFz6rfeY
         ZaKA==
X-Forwarded-Encrypted: i=1; AJvYcCUBIVp4ldrkHWa8LJjK60ZasaLrtgjHWgLhX+qhv76wSXBYtjTh1pZWxW6WpBrPK0RUjnUht4vjj6Xm4rN2HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX1hJPorPdfjPF95ItDmBURcRwE3xqAgVervmCP7c++0sP7Gap
	i2u/cNvksd2TsDvNA+Hgql0CoanUbPgeBcDCvlVhRkdHgVuJ2h1ZZSJa
X-Gm-Gg: AZuq6aIyH8z2UUrJObmxfHhc2YVLGt0kjOHE+1fAq8K6mw5ZEnPz5JjwVJfOgpC4wv7
	e//yrVFb0yKp1OcdU94YRJOMj7E24RpiGbfOMfY0JqK0eBfeOIpCUDi9G0N1c23tY+hQ3GjcISm
	mgifm+Fsy8+2v0AQ7wZHsTtr9n4d8CTRJmB5b6vZbw8EBvxkBPIZ4MmCRNlOTVM1oVGJrntYHAN
	UoUpM10z66dJg2UsCFS+2Nhba/S+RQPsVDF/P8hKHDS0fuNmHhE+UFp0iJz4urTIevOlKw9/dXh
	gIPMxM8+TQs80j8VuVeaCCDqLo7z90RoU/2f7kbJ/Dm3WEdCH4jVnFg92r12xnWpY1cHHdfzX28
	y52VIGDKpaekqo2aDCwxaWZAoQMTkOBW7/AtzlhN32y5PMZ4gWWG9m8eS5+GphCJrql3iYoop0r
	Pljl1pTiZT4Pti+4I5t8VtQ6qeLzTiKim5BUWgEPnVWSWRW9d7
X-Received: by 2002:a2e:be08:0:b0:385:d0b6:6c44 with SMTP id 38308e7fff4ca-385fa0f5429mr12559791fa.18.1769424790834;
        Mon, 26 Jan 2026 02:53:10 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da170f70sm23745981fa.27.2026.01.26.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:53:09 -0800 (PST)
Date: Mon, 26 Jan 2026 11:53:07 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <aXdHk6qvotpHkILx@gmail.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S2Ed6By+aLORiQHU"
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-19-bigeasy@linutronix.de>


--S2Ed6By+aLORiQHU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:37:04PM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
>=20
> The intention here was probably not allowing forced-threading for
> handlers such as iio_trigger_generic_data_rdy_poll() will intends to
> invoke hard-interrupt handlers.
>=20
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=E1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> Cc: Kent Gustavsson <kent@minoris.se>
> Cc: Gustavo Silva <gustavograzs@gmail.com>
> Cc: Nishant Malpani <nish.malpani25@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

[...]

>  drivers/iio/adc/mcp3911.c              |  2 +-
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Best regards,
Marcus Folkesson


--S2Ed6By+aLORiQHU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAml3R4wACgkQiIBOb1ld
UjImrg//VoTe74He2xr9a7a4xXooL9varAfZBITrKKUbEhWNiXZYsrKwKYIFgayM
oiz76OxUT5o9+SL4XCXq+yTXfr+7bwd67uPCrUoZAiSAeNtrfbw3fvftierrKuqI
DZm7pXQ4pnsaUKqX+X+KpQ2YJsFM4CfaO3ueAG5wA+vSbiRHnp3gF45JTbo+Ic2K
A4nqV39QMG6tzUXy0Pe2SYoXkRU7nS7u7OUjrQj/YCICXL9jaTdPpbeYtBVZic45
8lu68gFEYN0f5SOPGgNXc0As+qfbbpghpwMSlJyv8zATlKYtj5qgrDHskKxuk3R1
kqTF5iZEUOir50yR/KCLMnO+fXjhMdiDrWnUMAmPhYuWVAOB8n5xSO0s/khVzpBH
rf8/ekFo5afL5bqwSQo3xK+ROk5SpgdLo/a0NIfLCMSdFna2PjIUsE5LOEZzleLG
zlezgO9dVZOCHYzZJ6nNw/ELI3s5h9Wr/WAcMFnGPkOttC+oKcL1RIlHITYRr/U9
3oFgssVbPffoyvQ3fKZ0xD7ur38AUJRGE1SctWW63MXd4rYxkt2PBpqRj9dOo/zx
LEiotKRG/skz9Dx+m83SLuJUugRCz9IU80x1WIgKLv5HMRzWOCNRmpxbZEwFpkWL
SRnZvXdjh1XMvuogBQ/DBIexesCxYIgD1wT1eOK84xzuFw0zyww=
=/+VT
-----END PGP SIGNATURE-----

--S2Ed6By+aLORiQHU--
