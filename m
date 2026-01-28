Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F6305E3B
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600417; cv=none; b=ujF3oHP2/7hRyGzkBvwSFeR10coLh3fJbRsvL420nSw7N5Y6UA4pNmSaGihGx8holarLObGIDMU8PglbeNDwJK7PdXIdr/xkl0Nb1vM+bKzg/rbTpfaDowQf1I8XZMUqBuI3nL0ExxMKWvNxkL/zek0SXm3xMtBpcpi+NsbzwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600417; c=relaxed/simple;
	bh=KB+cTTZ2B/upxhJNZQuf6e9ml0y2/4jWR+djJXUwpqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DcX0LiD+b+cnZoP77kQI1CcM0kFT8pmnAJcd/ceIhCzKFN2LYzauV9HkkpPWINDH1y8ra96K7NzwbovY5JPm2kskRZc4byg/00gHnzh8fdRyy6kSpi1wAlDou6ERsip1p/+ccQ9lrZXt6bfVqap/ozzCPI3djtI9KtYJrH5MoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT5+Difa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT5+Difa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso6998835e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769600413; x=1770205213; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqRfd2vfHh4nYKD1extyhWwNfCg5ToGGBeU/+CUnFPM=;
        b=eT5+Difa/Co094V/KjAEGJDxxgFuXdczcTiEI61M0T1rEtQD7PpQjmncazueW0+nfE
         7zAyL85x0uygbffYfdVUZwAG8pgIetZiHMbaWn9MQd2pluJMtDaWwE/kAKKk1zDaj6gn
         U0p6NZUWljBHcnWuvAfk2APVjUt/oJK8rDce4lWbw2r7rLiKNAbwKMIkwc1FQlL9OvcQ
         3ADyUiB6CUT3UY4jCNRHrmK4kI6LfYEamhziI7Sz/fX3ReBFiqAjaR86bTkIxfthOFwE
         WbVst8dAKJ5mQdORUPc+6yZcvOjxzqkZJ1Cy2DUkEiDZVzHXc+rolmVEvihWTUbqcE6u
         lpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600413; x=1770205213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqRfd2vfHh4nYKD1extyhWwNfCg5ToGGBeU/+CUnFPM=;
        b=gZ+uapATHumsoS6cQ93RHpcdx9hsEVUALwn4tSAIW46RBuIrdk6/VgU91DE/IoWPzG
         kjhPhPiZvBqz5Jt1kAwABuM2e5Osi0htllbyoopbeojkPr87Avib4fa5QKHi/6zxqUIp
         znBB/Qdi50bZdAO+PsTxXNWHr2NRXcH0WGRs3CAcy4P3P40aNh/CxdAEA+8ZW9EEcI7o
         2ByYCOCfgj+TGaIdNGesZdevk5eZxoxmO4h6dLeSFPX+GFyrN6537FCZP5hU8p4KSf4D
         DKyrXNGHIJIwzCisgwZkOAs33wKE1134Dbn9eyZgxYb/jjXL75v/epIfprkrLqSZPklT
         XquQ==
X-Gm-Message-State: AOJu0Yz2SFzZeOud7GsrIP48usLxYMm9AgJxzoXq6uCyOdRlJQMRmdsA
	KU9WJzdSJHWHOMgpfblUhsaBT+aBwixWRk0zukuUzDQtQ/DqdK+x91as
X-Gm-Gg: AZuq6aJaCZCqzJD9sMz6JYgZq8G5bGCVVR3T47rEjcOTkQcB61pMpHxwepVnU5wQIof
	6BcZjW0H5puKvkG13qyTymEKX5lVtJy6SNpPmsHJ94+6M8fs+r6mfUzDQLV5SjXmS+Df45hH/5o
	oKCUETx0eSq5kJ2pdRLSilGj4cVVQlcIMU1QoEK+r8xmn+9uvr4GkgY68M3VJXjjZa5/sKPpLiA
	Us37Pu6P4aotXeB8erhwJBNlHyHRKoz1ISo1uxIlUZ/MLOCgLn9bI/4BJ8Bs3Y/eW4GuK4lqIN+
	R3gcE8s7TWeO75eKAFRjeLTp96fubdw6g8ApgDruKTgEaEcHDSHT5kB2ojrlGy6UzMqhEYlXzVf
	44P0G//mamgIP+mbVNwPjRrTDTc8TzaiX9k7aPc8XInQRqlTIoRh9BQcfTD4rqBHxrHdJiBFTHM
	rgotstz5Z8k0tfQGTQ8ruyTAeRHkkKMw==
X-Received: by 2002:a05:600c:4448:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-48069e9b5dbmr70565845e9.17.1769600412962;
        Wed, 28 Jan 2026 03:40:12 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e2e50ccsm4732965e9.17.2026.01.28.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:40:12 -0800 (PST)
Message-ID: <91aafb3174ca943e240dd8164f27080eab085e29.camel@gmail.com>
Subject: Re: [PATCH 20/21] iio: magnetometer: Remove IRQF_ONESHOT
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org
Date: Wed, 28 Jan 2026 11:40:56 +0000
In-Reply-To: <20260123113708.416727-21-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
	 <20260123113708.416727-21-bigeasy@linutronix.de>
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
> The force-threading functionality is required on PREEMPT_RT because the
> handler is using locks with can sleep on PREEMPT_RT.
>=20
> Remove IRQF_ONESHOT from irqflags.
>=20
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 3fd0171e5d69b..d30315ad85ded 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -581,7 +581,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
> =C2=A0		irq =3D gpiod_to_irq(data->eoc_gpiod);
> =C2=A0
> =C2=A0	rc =3D devm_request_irq(&client->dev, irq, ak8975_irq_handler,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IRQF_TRIGGER_RISING,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&client->dev), data);
> =C2=A0	if (rc < 0) {
> =C2=A0		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
