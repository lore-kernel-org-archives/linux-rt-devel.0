Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE120E31C
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Jan 2026 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639764; cv=none; b=kD/A92ZF8fyyg3RowKKCiaT+ouKMYarPF7vLh6GM8Yynb8GcdsUPUFJbMqSIQir8m6SFhLOWGH3zZvoy5RyzX29JkNU9ihl/JJ9FigOdfOuOcoDMXBHpBC6DmwBmIYllCeJ0l07nH0p/FwJ5i9zL7ADpQB4pXes17cTp4zNnE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639764; c=relaxed/simple;
	bh=6GF+eSef4reroedO/ULhcBZiCCCblDzpWr+3JiqD9kM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2sODNGdFjqiHm4OwY6y2q2Km7yPp0RSf+vTa5OGOr1Q7TcJWvxXvPqnA41trEwMyHrQfZ3htQFgkYn1FIVfgDy5GFoUAa70pk4z5/GSJp1WlMa8yElL9OWxyhy/ou+Avk4QJDCME0N8B/1yNLSdBiqDsy6/+39ErhYTNYsFNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=pDhDmRCo; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="pDhDmRCo"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b144ec3aa8so22754585a.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Jan 2026 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767639760; x=1768244560; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gA0VMJuSnU0pX+CCjUlZE4nvqKz/dcQOtvqUW9x/szM=;
        b=pDhDmRCowx69QfLhfW2sxgD9CUioDghgI0G0lqF3feDiU4G9Esz82kKy7SeNrHhJuU
         6+u5MBd9IrOiYAnEpKfw0ylW6lmwiU9Lr/Mjnqc5D3vLxzisDqkBO1m5VL47IRSSpUVM
         SLpTKzYmUrEUXAY1MXulxopaVSMIgPoipTeBRqP09KyPpq0cL0g8QLt9wphEFd7+6qTC
         AxPD9yW2B75EfigEw+a1u+4qJVFI83SQOzxCNUcFwgJRbRvvdAT7l7RbfLpLJYVqbK/f
         /sBWG7Uqa1m+L9gTnSa9/R4Lzahe9USDwlqUbwsDgHtr3dxnfJZQlSIgaRfc1xt+bUXL
         dYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639760; x=1768244560;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA0VMJuSnU0pX+CCjUlZE4nvqKz/dcQOtvqUW9x/szM=;
        b=AvdKfpP5sQfP50UQq7IBYkU/i0b4BAnsbg0EjMQjLCRVniAr4/vd8qxjBsgJT0KiKg
         8MS5s6IJ4+K6BPxu/hUN8lrCt5kVoYcJrYSdedtjN7BQP4b0mGa0r9np3Xczvi8U/+AD
         ++N6hdO15vENcTaZFrPnIQGeDGcPOG7ihoWIqjvnuX1H54enBetyaG6qZMV/jIAhItdH
         MzQdg4ycUuZYCkS2hpWvNbECVpAMknUEUH8pQgSzdQ+2sABFH3SZBfDncb9oo6L5eUmK
         IAdLNGydiX2U5KPei9XHJVih59hb4EY5JIOTIpCU/qxby44nCm9fxvLH3SSrGoYdM1ww
         NOXA==
X-Forwarded-Encrypted: i=1; AJvYcCXeUaJ1/FzBhApWPpulAVLipskUYaiNxq7cx27LqA9MMf8ADeYJ+99Xb0NfBE0kVLESnlT+Cf0OSYgdC0mEcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPz7ykKcI+JqkpBuIzjtCJM16AV4n2DGh5/rWnhK0usWEIJPA0
	zHOoDq/zwvYUeR2+OldFuMfommp+GMdFNLPN1Fk+TWPIvMGfs3v8XM/lw7I2ny6O7e8=
X-Gm-Gg: AY/fxX4clyhOfCb6t75GKdW1tJZAh+oCw0XICp2VzAKW7iBRGVv5kW9J549lGwgBnfX
	vhZN2Ft64s8zy36S0iGfSibtf0Jhkj+Vz4sSlcKOggnZesG0OZXa3BepYTpctTsvRL1XbqOBWQx
	l/HyjbtMb98H1x0tcjbyteBYPj72OMPZ9LaREVhiy/XzVVDY6FHegxT2ercA8QTofBgluWKSLOz
	QInXyLW+p1auFDcmGLA+/jN7Oq6gC4cx5l+AgtB8UpGk/1i9dgkXkVaY5a66BmaS9bFV2rWtNWe
	C/98WmN4gZRwYOjj1eyXorRkkaFrEoajkkht3SHXMPy4vsgE8SjpKTORl+AdG2nmQrwGsSA8goL
	XB6vgCkqCOqDPV77qvhaHk8RDTW2qDQ99e1VMQe00+VKz2GoxEczvYgVgAVowEPTwqMQGil4a3G
	BLjODvFHCwrAK5pYet
X-Google-Smtp-Source: AGHT+IGJf5nR2VtRNdDG0B+XVbulrpPI9aSHHZuWb6/beDKJdT3vUvNlExg9ujzf1PDLbcC4Nkrk1g==
X-Received: by 2002:a05:620a:4589:b0:8b2:d56a:f2f1 with SMTP id af79cd13be357-8c37eb5e0e2mr92934385a.12.1767639759742;
        Mon, 05 Jan 2026 11:02:39 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4ccdf8sm12115685a.23.2026.01.05.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:02:39 -0800 (PST)
Message-ID: <8a8ec84e5484d7a1a5e6fac9a5238f3cae66abc3.camel@ndufresne.ca>
Subject: Re: [PATCH 3/4] media: dw100: Fix kernel oops with PREEMPT_RT
 enabled
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Stefan Klug <stefan.klug@ideasonboard.com>, Xavier Roumegue	
 <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt	 <rostedt@goodmis.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Mon, 05 Jan 2026 14:02:38 -0500
In-Reply-To: <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-3-65af34d04fd8@ideasonboard.com>
References: 
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-3-65af34d04fd8@ideasonboard.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-kp8IPL/GQ8oar2rBFJK9"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-kp8IPL/GQ8oar2rBFJK9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 05 janvier 2026 =C3=A0 12:35 +0100, Stefan Klug a =C3=A9crit=C2=A0=
:
> On kernels with PREEMPT_RT enabled, a "BUG: scheduling while atomic"
> kernel oops occurs inside dw100_irq_handler -> vb2_buffer_done. This is
> because vb2_buffer_done takes a spinlock which is not allowed within
> interrupt context on PREEMPT_RT.
>=20
> Fix that by making the irq handler threaded. The threaded interrupt
> handling might cause the interrupt line to be disabled a little longer
> than before. As the line is not shared, this has no negative side
> effects.

That's interesting, do you plan to update more drivers ? There is a lot of =
m2m
using hard IRQ to minimize the idle time (save a context switch), but RT su=
pport
might be more worth then that.

>=20
> Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> =C2=A0drivers/media/platform/nxp/dw100/dw100.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/dw100/dw100.c
> b/drivers/media/platform/nxp/dw100/dw100.c
> index
> 8a421059a1c9b55f514a29d3c2c5a6ffb76e0a64..4f5ef70e5f4a052fb5f208e35f8785f=
9d30d
> c54e 100644
> --- a/drivers/media/platform/nxp/dw100/dw100.c
> +++ b/drivers/media/platform/nxp/dw100/dw100.c
> @@ -1600,8 +1600,9 @@ static int dw100_probe(struct platform_device *pdev=
)
> =C2=A0
> =C2=A0	pm_runtime_put_sync(&pdev->dev);
> =C2=A0
> -	ret =3D devm_request_irq(&pdev->dev, irq, dw100_irq_handler,
> IRQF_ONESHOT,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&pdev->dev), dw_dev);
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					dw100_irq_handler, IRQF_ONESHOT,
> +					dev_name(&pdev->dev), dw_dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
> =C2=A0		goto err_pm;

--=-kp8IPL/GQ8oar2rBFJK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaVwKzgAKCRDZQZRRKWBy
9H1CAP9C6Znn6Z4goZYAF6lQ10kG37AYaIkSgwXJGSCNM1k25wD/WJvjXOVKAg7w
ntMWFY479H+NK7I9m3RI4qug6vvItAs=
=6+Fg
-----END PGP SIGNATURE-----

--=-kp8IPL/GQ8oar2rBFJK9--
