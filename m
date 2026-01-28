Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59330346FAD
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600317; cv=none; b=l4VE0MTVOwq/98SQQY6qwhjigkLEeDVoApf9Gr44VxDz47SiJw7NsFG+m1fLjuUEnUWmjHCg+/CoxCagNZr1g+SsZVxExh9n/g96nuRbOCFPtR0J5N26ZrJYQVT7frN8cHLSdlakbH8kqsr/20rgSw5W0JlHbyVfqWsIt/IiUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600317; c=relaxed/simple;
	bh=Va20b2/bvndKSsNijEO4trQF5II6HDXdxfQ+M89505k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVi0QFwiS0GV7soAh7KOhAZAfrR7rMubl40a25QoClBbw4SkrpJ3Q7CtkWDphHP3Eqo/sNuGd9WC1M9iU2pu7OjkY5+gXZO6AOfwI+sZgoToOs/FGqG6fnNzlz/1Oy0aFn7eXyjXIXieTmFg4F8GghD1UiuEs8BV/km4epBYIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHKcHRae; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHKcHRae"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a302794so4264680f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600314; x=1770205114; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dGTKFOwtLRLddCS+Lcm6JeAnR+5Y7TqOesIqD332lDc=;
        b=SHKcHRaerK345VklvqzDTEClW3OLuaPDW2Yo8m5YTkIyUVd2EqiC5hAcecU560IYJf
         eyedSAeBsdhOiGQ9zRoyVaASOHvuVEHHgnMBWRTDS80KtbO1DDAf3T0UjilX5dmpsmp8
         yt8P0K5XUHbT65CG/kQUFkcdcKGcZniMsR0V+5v1KVGqCCPGWJH00PuhQpH1sb9TQGx5
         i4F6qHbak07dt/zE3ikPZZ6pWvupK25t9W1VAIEJdcFiMIeFAwtSVrmaCQFn6uaHtyoE
         +rO3+oDT8sIBzieSJeHZKlaXv+rAXmxVobCmFBWuBwn/LIWVwwHtJ4HmpYnYWKY1MFu0
         Lxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600314; x=1770205114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGTKFOwtLRLddCS+Lcm6JeAnR+5Y7TqOesIqD332lDc=;
        b=ZbvNgPWtGiF6huhTjxBKiH8NXxZIVrg6dJFFs/DM2UYHpUjg2FIDK+gvrIE9MybM1D
         YmMh8DFS5MtpHD/FtvODsNQMIDsaaGMBcjnthNCq+rGLyYl7O0JdKN7lw+/7WuV8qCHP
         s9XRS9LDGI/qlx0kHOnEpEgeojLkIJyDtHvQRU7pujI3Micz5fp5XglM6OXZaCVpCphm
         PEdF1PbpD3Zfbjd0Cjm3QzQhGy7gzLlLiAoCRStiP93CHH4XeiEnc59DZS5FFTW7lQ++
         wSZe4f9sm3X6JJeHnCZrNEkXDfzSKbhV4wKAuJW9aDD0bEAGHalpdC+9nzh+gVICHrpa
         zx/g==
X-Gm-Message-State: AOJu0YynAkkq5hMAxR4poSyxn/1TEDeJBPdXh8ivcQx0QwlSIENV18Zd
	E0LlhVF0/w6y9h0SdvFNrNK+/Bse32sQdmuvIenKccPHg0xwlDfBwiju
X-Gm-Gg: AZuq6aKQSby9VzQSi6BCi7eW2X7m9UilGlePADPWYd3Zbx1oIL/j2hiZsiDYhCiuDxA
	Yr3pVYIjCKwxzqrXmCcXf5MhwrpsP5J5/9/p4c7zrdIwzskyCcmRMg+J2Izozg7Ay1tBacsMgXk
	hbjJtthsHoezmDq/p9KGeE5CWea3/8MJ1oXEQzvRhP3/E0wKAA8kwXNgHcFflWmzERUxFnKlWwj
	F7wKNb77bwG+rncgcA74ohYVDhxYZnoAbynu7RhgjTZ7U0jCxpfG4PoW4viKiwSDSigNvjZCcOk
	63fuLyAVqJqw7mZFK/7A5z7bhMIDQ1iFPXdZ0f0O53OA2oHYzg/meofuFKeNGjVJWuhRMVpiFBT
	zfuErE+fQC+WHukQVj38jV2A9chXIhq5k1wYwPiHAWCXeC3vl97rc9+i3ZetYmR+vkfC5Muj7MP
	U3psXF45BNkTmpnkyz92Y=
X-Received: by 2002:a05:6000:a8c:b0:435:bbd7:185f with SMTP id ffacd0b85a97d-435dd029a52mr4718065f8f.9.1769600313449;
        Wed, 28 Jan 2026 03:38:33 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132368csm5956202f8f.31.2026.01.28.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:38:33 -0800 (PST)
Message-ID: <0b48a4b08a6dbe34c017ed4ebb277e2082842101.camel@gmail.com>
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>, 
 Lars-Peter Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Puranjay Mohan <puranjay@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Marcelo Schmitt	 <marcelo.schmitt@analog.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>,  Kent Gustavsson	
 <kent@minoris.se>, Gustavo Silva <gustavograzs@gmail.com>, Nishant Malpani	
 <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Date: Wed, 28 Jan 2026 11:39:16 +0000
In-Reply-To: <20260123113708.416727-19-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	 <20260123113708.416727-19-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-23 at 12:37 +0100, Sebastian Andrzej Siewior wrote:
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
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> Cc: Kent Gustavsson <kent@minoris.se>
> Cc: Gustavo Silva <gustavograzs@gmail.com>
> Cc: Nishant Malpani <nish.malpani25@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl355_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 ++-
> =C2=A0drivers/iio/accel/adxl372.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++-----
> =C2=A0drivers/iio/accel/mxc4005.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++-------
> =C2=A0drivers/iio/accel/stk8ba50.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++++-------
> =C2=A0drivers/iio/adc/ad4170-4.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/iio/adc/ad7768-1.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++---
> =C2=A0drivers/iio/adc/ad7779.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/iio/adc/mcp3911.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/iio/adc/ti-ads131e08.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/iio/chemical/ens160_core.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
9 +++------
> =C2=A0drivers/iio/gyro/adxrs290.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/iio/health/afe4403.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++-----
> =C2=A0drivers/iio/health/afe4404.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++-----
> =C2=A0drivers/iio/magnetometer/bmc150_magn.c |=C2=A0 9 +++------
> =C2=A0drivers/iio/pressure/dlhl60d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0drivers/iio/temperature/tmp006.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++++------
> =C2=A016 files changed, 42 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355=
_core.c
> index 5fc7f814b9077..04caa493176d3 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -770,7 +770,8 @@ static int adxl355_probe_trigger(struct iio_dev *indi=
o_dev, int irq)
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(data->dev, irq,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_trigger_generic_data_r=
dy_poll,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONESHOT, "adxl355_irq", dat=
a->dready_trig);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "adxl355_irq", data->dready_trig=
);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 irq);
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 46d518a2a0291..2f6aa52aeba51 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1247,11 +1247,10 @@ int adxl372_probe(struct device *dev, struct regm=
ap *regmap,
> =C2=A0
> =C2=A0		indio_dev->trig =3D iio_trigger_get(st->dready_trig);
> =C2=A0
> -		ret =3D devm_request_threaded_irq(dev, st->irq,
> -					iio_trigger_generic_data_rdy_poll,
> -					NULL,
> -					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -					indio_dev->name, st->dready_trig);
> +		ret =3D devm_request_irq(dev, st->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_generic_data_rdy_po=
ll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_NO_T=
HREAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name, st->dready_tri=
g);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0	}
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index ac973d871c8bb..a2c3cf13d0981 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -486,13 +486,10 @@ static int mxc4005_probe(struct i2c_client *client)
> =C2=A0		if (!data->dready_trig)
> =C2=A0			return -ENOMEM;
> =C2=A0
> -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> -						iio_trigger_generic_data_rdy_poll,
> -						NULL,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> -						"mxc4005_event",
> -						data->dready_trig);
> +		ret =3D devm_request_irq(&client->dev, client->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_generic_data_rdy_po=
ll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_FALLING | IRQF_NO_=
THREAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mxc4005_event", data->dready_t=
rig);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(&client->dev,
> =C2=A0				"failed to init threaded irq\n");
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 384f1fbcbcb37..a9ff2a273fe1c 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -428,13 +428,10 @@ static int stk8ba50_probe(struct i2c_client *client=
)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (client->irq > 0) {
> -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> -						stk8ba50_data_rdy_trig_poll,
> -						NULL,
> -						IRQF_TRIGGER_RISING |
> -						IRQF_ONESHOT,
> -						"stk8ba50_event",
> -						indio_dev);
> +		ret =3D devm_request_irq(&client->dev, client->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stk8ba50_data_rdy_trig_poll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_NO_T=
HREAD,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "stk8ba50_event", indio_dev);
> =C2=A0		if (ret < 0) {
> =C2=A0			dev_err(&client->dev, "request irq %d failed\n",
> =C2=A0				client->irq);
> diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
> index efaed92191f1b..82205bfae531e 100644
> --- a/drivers/iio/adc/ad4170-4.c
> +++ b/drivers/iio/adc/ad4170-4.c
> @@ -2973,7 +2973,7 @@ static int ad4170_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	if (spi->irq) {
> =C2=A0		ret =3D devm_request_irq(dev, spi->irq, &ad4170_irq_handler,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONESHOT, indio_dev->name, =
indio_dev);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD, indio_dev->name=
, indio_dev);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index d96802b7847a6..84ce23c8e5782 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -1394,9 +1394,8 @@ static int ad7768_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_request_irq(&spi->dev, spi->irq,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad7768_interrupt,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_ONESH=
OT,
> +	ret =3D devm_request_irq(&spi->dev, spi->irq, &ad7768_interrupt,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_NO_TH=
READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name, indio_dev)=
;
> =C2=A0	if (ret)
> =C2=A0		return ret;
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index aac5049c9a07b..695cc79e78da5 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -840,7 +840,7 @@ static int ad7779_setup_without_backend(struct ad7779=
_state *st, struct
> iio_dev
> =C2=A0	iio_trigger_set_drvdata(st->trig, st);
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(dev, st->spi->irq, iio_trigger_generic_da=
ta_rdy_poll,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONESHOT | IRQF_NO_AUTOEN, i=
ndio_dev->name,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD | IRQF_NO_AUTOEN,=
 indio_dev->name,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->trig);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index a6f21791c6859..ddc3721f3f688 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -815,7 +815,7 @@ static int mcp3911_probe(struct spi_device *spi)
> =C2=A0		 * don't enable the interrupt to avoid extra load on the system.
> =C2=A0		 */
> =C2=A0		ret =3D devm_request_irq(dev, spi->irq, &iio_trigger_generic_data=
_rdy_poll,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_AUTOEN | IRQF_ONESHOT,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_AUTOEN | IRQF_NO_THREAD=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name, adc->trig=
);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e0=
8.c
> index c9a20024d6b11..a585621b0bc30 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -827,7 +827,7 @@ static int ads131e08_probe(struct spi_device *spi)
> =C2=A0	if (spi->irq) {
> =C2=A0		ret =3D devm_request_irq(&spi->dev, spi->irq,
> =C2=A0			ads131e08_interrupt,
> -			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
> =C2=A0			spi->dev.driver->name, indio_dev);
> =C2=A0		if (ret)
> =C2=A0			return dev_err_probe(&spi->dev, ret,
> diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/en=
s160_core.c
> index 86bde4a91bf7e..bbc96c4c62838 100644
> --- a/drivers/iio/chemical/ens160_core.c
> +++ b/drivers/iio/chemical/ens160_core.c
> @@ -316,12 +316,9 @@ static int ens160_setup_trigger(struct iio_dev *indi=
o_dev, int irq)
> =C2=A0
> =C2=A0	indio_dev->trig =3D iio_trigger_get(trig);
> =C2=A0
> -	ret =3D devm_request_threaded_irq(dev, irq,
> -					iio_trigger_generic_data_rdy_poll,
> -					NULL,
> -					IRQF_ONESHOT,
> -					indio_dev->name,
> -					indio_dev->trig);
> +	ret =3D devm_request_irq(dev, irq, iio_trigger_generic_data_rdy_poll,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD, indio_dev->name,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->trig);
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "failed to request irq\n");
> =C2=A0
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index 8fcb41f45baac..3efe385ebedc4 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -597,7 +597,7 @@ static int adxrs290_probe_trigger(struct iio_dev *ind=
io_dev)
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(&st->spi->dev, st->spi->irq,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &iio_trigger_generic_data_r=
dy_poll,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_ONESHOT, "adxrs290_irq", st=
->dready_trig);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD, "adxrs290_irq", =
st->dready_trig);
> =C2=A0	if (ret < 0)
> =C2=A0		return dev_err_probe(&st->spi->dev, ret,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "request irq %d failed\n", st->spi->ir=
q);
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 0e5a512e3bb8f..d358f4d5e5da8 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -540,11 +540,10 @@ static int afe4403_probe(struct spi_device *spi)
> =C2=A0			return ret;
> =C2=A0		}
> =C2=A0
> -		ret =3D devm_request_threaded_irq(dev, afe->irq,
> -						iio_trigger_generic_data_rdy_poll,
> -						NULL, IRQF_ONESHOT,
> -						AFE4403_DRIVER_NAME,
> -						afe->trig);
> +		ret =3D devm_request_irq(dev, afe->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_generic_data_rdy_po=
ll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD, AFE4403_DRIVER_=
NAME,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 afe->trig);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(dev, "Unable to request IRQ\n");
> =C2=A0			return ret;
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 768d794e574b9..032da52a96d0e 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -547,11 +547,10 @@ static int afe4404_probe(struct i2c_client *client)
> =C2=A0			return ret;
> =C2=A0		}
> =C2=A0
> -		ret =3D devm_request_threaded_irq(dev, afe->irq,
> -						iio_trigger_generic_data_rdy_poll,
> -						NULL, IRQF_ONESHOT,
> -						AFE4404_DRIVER_NAME,
> -						afe->trig);
> +		ret =3D devm_request_irq(dev, afe->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_generic_data_rdy_po=
ll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD, AFE4404_DRIVER_=
NAME,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 afe->trig);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(dev, "Unable to request IRQ\n");
> =C2=A0			return ret;
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magneto=
meter/bmc150_magn.c
> index 6a73f6e2f1f06..a022e1805dff7 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -906,12 +906,9 @@ int bmc150_magn_probe(struct device *dev, struct reg=
map *regmap,
> =C2=A0			goto err_poweroff;
> =C2=A0		}
> =C2=A0
> -		ret =3D request_threaded_irq(irq,
> -					=C2=A0=C2=A0 iio_trigger_generic_data_rdy_poll,
> -					=C2=A0=C2=A0 NULL,
> -					=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -					=C2=A0=C2=A0 "bmc150_magn_event",
> -					=C2=A0=C2=A0 data->dready_trig);
> +		ret =3D request_irq(irq, iio_trigger_generic_data_rdy_poll,
> +				=C2=A0 IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +				=C2=A0 "bmc150_magn_event", data->dready_trig);
> =C2=A0		if (ret < 0) {
> =C2=A0			dev_err(dev, "request irq %d failed\n", irq);
> =C2=A0			goto err_trigger_unregister;
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60=
d.c
> index 8bad7162fec64..e975b733ce0a1 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -306,9 +306,9 @@ static int dlh_probe(struct i2c_client *client)
> =C2=A0	indio_dev->num_channels =3D ARRAY_SIZE(dlh_channels);
> =C2=A0
> =C2=A0	if (client->irq > 0) {
> -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> -			dlh_interrupt, NULL,
> -			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +		ret =3D devm_request_irq(&client->dev, client->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dlh_interrupt,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_NO_T=
HREAD,
> =C2=A0			st->info->name, indio_dev);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(&client->dev, "failed to allocate threaded irq");
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/t=
mp006.c
> index 10bd3f221929d..d8d8c8936d177 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -356,12 +356,10 @@ static int tmp006_probe(struct i2c_client *client)
> =C2=A0
> =C2=A0		indio_dev->trig =3D iio_trigger_get(data->drdy_trig);
> =C2=A0
> -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> -						iio_trigger_generic_data_rdy_poll,
> -						NULL,
> -						IRQF_ONESHOT,
> -						"tmp006_irq",
> -						data->drdy_trig);
> +		ret =3D devm_request_irq(&client->dev, client->irq,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_generic_data_rdy_po=
ll,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_NO_THREAD, "tmp006_irq",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->drdy_trig);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0	}
