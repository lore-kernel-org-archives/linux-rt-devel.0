Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E142D97A6
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Jan 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639842; cv=none; b=SGLzDU/kRQMDDBcFw5G6/cPHwUY13z+8Sdpamshb30poGlErcpxkKBRW5M+h2cUfc84oSdr/hePcW+7tPELrtBakp9ovuMg0w/wybhHVWcf/peLBViiQNKYobWcy0q85lrsT+Zac8I4ZRxb89Ds1i1YfYZMJWQyo1KmlBySTxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639842; c=relaxed/simple;
	bh=I3tXSvAiTdiWGgkSi6+ecYZmDAG3V4d+Vdb3BWNisHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yeb7jChWgnT+h6UOWLFyClFmjLDfJo7hrr3vMKGUHQj2GNWlBOnoh9lY0QMPgZD4ZeeceLss3kO/SOnRSjc6PT4SCV84rmFJYlpoYlNORMTxKkSyrax56bxHCWXITmzsI2DYj288yBiEUZoVxuPnV3aokNv9n26VxEgcAbQXDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=ZiqisDZS; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="ZiqisDZS"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee05b2b1beso2029191cf.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Jan 2026 11:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767639840; x=1768244640; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FeKtBDsJt1gX24SqhD7ZSBYL+NzR9qHzMlaESQhyeis=;
        b=ZiqisDZSpkn/1b+6KcKmlKy7XKtD5xEjT+jjBsNSRxh/Odazl4kWrCadFe2qyjtDGE
         OdiaYPBmL/hDE/Qsv7ungkxMCnei8H0jngDI5+p0KF9WbKZ30QUAX8UumdazN2OJ1Lyp
         Yo+zlBDSA2oxrehvblcoyaTPzR7bt8GvkEJaozJC/rS1FZ00Yzbb9DqN2zZ8tkbpTxDq
         0BtkYul4azVDRbmvCLEV/yfNnOOWHD1jkkT0OMbYulp88D4DZlA4uMQX5qrN+GmlWkeH
         TR6o3VR2KKBqYP3EG7qeq/7ZFcvCj3Ut3M2Fl0F4HLL/Kj+0P7EPAwUvt4QRSuUkbbFv
         AYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639840; x=1768244640;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeKtBDsJt1gX24SqhD7ZSBYL+NzR9qHzMlaESQhyeis=;
        b=liw2G/GVStwDgnh+VQ8R99UvA1yr6TPfjtwX9JVBMD7ESk0axEYwyIXKdC1OMut44k
         On4LKCG0jPQgE6iv9TtPHuvUYlPG331/887QcidSi073jRt/LpurW85DVy38dWm5plBK
         zyOJeVnlgNmi7e+fMZJ+4kghabEA+tmiaG9MBWXQGg5oc2uV7AjvQYhbRFyru94cXY21
         zHYilqRxpMPXzGD2a29QJyGXgtFpx4jZ50q1M4eP0BCWIOh6YInZddSFkWhWkqIR4Auk
         4zNIzSIeSfnNN07H3n3OY4QHOzT5msJN4JKSpcqfuy+/Q4mN1m5qOz4DCfRgAg1cp94f
         ZeFg==
X-Forwarded-Encrypted: i=1; AJvYcCWxkVLkadmMl4xtXDOYl+AK/I/VWfE126qY9rZ7y3a0FBRU05C07hVjARRHr01XPT3sRkKdI+NT3bOKFqjyOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvUA38ZqGsf/55MFihDdPZlPrf9Kceva2zgbwvU4N5dftc70zx
	IC2P+3N5pKMhd4mTfc5I8SXJ2uGshukentRFMABUUxBd6wmkQAG6ADIZoWXqMz+rh4U=
X-Gm-Gg: AY/fxX5ahDHg/aFXLnqirMjLgAO5twHQyJazgS2ikBFQq84onRW72TJYwPwsMqOCq11
	a/HCAl7qdkA6mp5cmgy2KKd8t1ptEg+x5g5FPPeRqyJqDIPQOeCjaWdxYuB3C6ch2aGxP4i70Ps
	hBK+22vR/e6QNkVtUoGRZ2sSEGmtC+1kCovryT/FiMVZv3eWg87eK75vmBbMAhbIe1zI60Y7nm9
	oV/ld/KvNasA+BEXTmtagAEts94+uXeknaIdATu94+CqoGC3Ck3fDsaQVgIfUEzHi5yth0YjOCY
	RGJEzBBrjeBg84Y3mpBxYhfYtd93pVw5z5v4pLM8tuTc+LpCHrhsLq3ZfdPOYqJIqCVQPzb6c0Z
	2QA0WTfSe1y7G6broJe2Ixa/Qcj95aL7x2Cs8mjNj7qKPLixJ/T+sn5Y2PakAr7AY4Ze53J4be1
	0fBjWDrIqKcTgzPA+Y
X-Google-Smtp-Source: AGHT+IEnEgzIDnY39n5gQuZja4vjNZ3BfPuYzRbiRzQouli3RfXg1JXmGP7KEZbAr7NNftQ95LCl0g==
X-Received: by 2002:a05:622a:130d:b0:4ee:1676:faa6 with SMTP id d75a77b69052e-4ffa76bd600mr8775391cf.20.1767639840109;
        Mon, 05 Jan 2026 11:04:00 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa71987casm3827561cf.18.2026.01.05.11.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:03:59 -0800 (PST)
Message-ID: <1c04d8cd1a6cf29f45d7ea9422dd3fe0a633a957.camel@ndufresne.ca>
Subject: Re: [PATCH 4/4] media: dw100: Split interrupt handler to fix
 timeout error
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Stefan Klug <stefan.klug@ideasonboard.com>, Xavier Roumegue	
 <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt	 <rostedt@goodmis.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Mon, 05 Jan 2026 14:03:58 -0500
In-Reply-To: <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-4-65af34d04fd8@ideasonboard.com>
References: 
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-4-65af34d04fd8@ideasonboard.com>
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
	protocol="application/pgp-signature"; boundary="=-fNdR0Jihn8NMZ/VEQhEe"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-fNdR0Jihn8NMZ/VEQhEe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 05 janvier 2026 =C3=A0 12:35 +0100, Stefan Klug a =C3=A9crit=C2=A0=
:
> In the previous commit, the interrupt handler was changed to threaded.
> This sometimes leads to DW100_INTERRUPT_STATUS_INT_ERR_TIME_OUT being
> set after changing the vertex map. This can be seen by repeated error
> outputs in dmesg:
>=20
> dw100 32e30000.dwe: Interrupt error: 0x1
>=20
> As there is no documentation available, it is unclear why that happens
> and if this condition can simply be ignored. By splitting the interrupt
> handling into two parts and only handling the dw100_job_finish() within
> the threaded part, the error does not occur anymore.
>=20
> Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>

Ok, but arguably, this could be squashed.

Nicolas

>=20
> ---
>=20
> As noted on the cover letter, this patch still is intended to start the
> discussion for a proper fix.
>=20
> While writing this I noted that when
> DW100_INTERRUPT_STATUS_INT_FRAME_DONE is set, the job gets finished
> without error even when err_irqs !=3D 0. Is that on purpose?
> ---
> =C2=A0drivers/media/platform/nxp/dw100/dw100.c | 20 +++++++++++++++-----
> =C2=A01 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/dw100/dw100.c
> b/drivers/media/platform/nxp/dw100/dw100.c
> index
> 4f5ef70e5f4a052fb5f208e35f8785f9d30dc54e..67d941bdf768398edc611c94896cc42=
a70b8
> 8225 100644
> --- a/drivers/media/platform/nxp/dw100/dw100.c
> +++ b/drivers/media/platform/nxp/dw100/dw100.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/debugfs.h>
> =C2=A0#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/minmax.h>
> =C2=A0#include <linux/module.h>
> @@ -74,6 +75,7 @@ struct dw100_device {
> =C2=A0	struct clk_bulk_data		*clks;
> =C2=A0	int				num_clks;
> =C2=A0	struct dentry			*debugfs_root;
> +	bool				frame_failed;
> =C2=A0};
> =C2=A0
> =C2=A0struct dw100_q_data {
> @@ -1411,7 +1413,8 @@ static irqreturn_t dw100_irq_handler(int irq, void
> *dev_id)
> =C2=A0{
> =C2=A0	struct dw100_device *dw_dev =3D dev_id;
> =C2=A0	u32 pending_irqs, err_irqs, frame_done_irq;
> -	bool with_error =3D true;
> +
> +	dw_dev->frame_failed =3D true;
> =C2=A0
> =C2=A0	pending_irqs =3D dw_hw_get_pending_irqs(dw_dev);
> =C2=A0	frame_done_irq =3D pending_irqs &
> DW100_INTERRUPT_STATUS_INT_FRAME_DONE;
> @@ -1419,7 +1422,7 @@ static irqreturn_t dw100_irq_handler(int irq, void
> *dev_id)
> =C2=A0
> =C2=A0	if (frame_done_irq) {
> =C2=A0		dev_dbg(&dw_dev->pdev->dev, "Frame done interrupt\n");
> -		with_error =3D false;
> +		dw_dev->frame_failed =3D false;
> =C2=A0		err_irqs &=3D ~DW100_INTERRUPT_STATUS_INT_ERR_STATUS
> =C2=A0			(DW100_INTERRUPT_STATUS_INT_ERR_FRAME_DONE);
> =C2=A0	}
> @@ -1432,7 +1435,14 @@ static irqreturn_t dw100_irq_handler(int irq, void
> *dev_id)
> =C2=A0	dw100_hw_clear_irq(dw_dev, pending_irqs |
> =C2=A0			=C2=A0=C2=A0 DW100_INTERRUPT_STATUS_INT_ERR_TIME_OUT);
> =C2=A0
> -	dw100_job_finish(dw_dev, with_error);
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t dw100_irq_thread_fn(int irq, void *dev_id)
> +{
> +	struct dw100_device *dw_dev =3D dev_id;
> +
> +	dw100_job_finish(dw_dev, dw_dev->frame_failed);
> =C2=A0
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> @@ -1600,8 +1610,8 @@ static int dw100_probe(struct platform_device *pdev=
)
> =C2=A0
> =C2=A0	pm_runtime_put_sync(&pdev->dev);
> =C2=A0
> -	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -					dw100_irq_handler, IRQF_ONESHOT,
> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, dw100_irq_handler,
> +					dw100_irq_thread_fn, IRQF_ONESHOT,
> =C2=A0					dev_name(&pdev->dev), dw_dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);

--=-fNdR0Jihn8NMZ/VEQhEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaVwLHgAKCRDZQZRRKWBy
9CK7AP9nU4xsk5uJ9qTIjT9aqkUElBbvCfqnzaDZlty2zYi1jgEApKwo6EeVrFsd
lBcXpgMgMqOznz8YaGI+BF2mZDHIpQI=
=jqzk
-----END PGP SIGNATURE-----

--=-fNdR0Jihn8NMZ/VEQhEe--
