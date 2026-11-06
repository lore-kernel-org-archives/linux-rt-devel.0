Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953710;
	b=Lb5K5zzQTpPw52JrCPPQb/wU1d0XD3pRlzoh4g3AM9ce4r19SrCpVQfVeS+HvoQRJ+2P
	 oopRzq0LVwmE4XKsVZXu1lqprfsi6qn941EZLsWOCy2BwjE8YT4FlvNDmhVTrvec5IDE5
	 A2ofNEXV5Jy4kLhDzte4md7cnjzX1EY/rUxMHNFrqAjIK++4rWY8xYYZwDzaxFF7yRCM2
	 Qa7uHUxskZ+ZP/gu7tt0M0eHKoYig2NahzZFonOKc5YxuHbg28h6sR0TbS6sjbu0E3OQV
	 ++9g3DLalKPtttd4wAUtK0Dk6igLGobI8HKf1YtlyEZDfPvPuXtfeKULa4XZsHUX0WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2AtMfTadBLs8nEmS0BloOK+uIClG4rM4IDzYSAxjYFA=;
	b=rnTLjCRpImhAuYBpZA/kWEfZGFxzgfKo2L5WTjB1aXPyJv/Xe30eWWMqcEqr6gNzxmbB
	 3BY47aI+8G2jzKC0oRJaAEaM030NuhvzLMZxT5GGcX9tdb/zCc8bcx9voUz4jUVTyxRT2
	 iPjl8HbWyQrEWgE1NPSSmVbLNhPeXsukOc5dga6PUXyIAFDxkJwP/mlzhvfIKnsYHFln5
	 eGOdN+raSGbmLalslzoz2dhgu3eVHL4Cbb/kB94szSq4iLuzFFvfAiSg7v6jTYLciDnhY
	 u1SWTOjZ9LvqB6Yc/HAm/k+jR2pvhPkNY5g2qerK5tBuIicVLd01QFH5ZNxgC5Alhmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tc7YfIzY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94648606A326
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94648606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tc7YfIzY
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc81984fceso133764137.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 00:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793953709; cv=none;
        d=google.com; s=arc-20260327;
        b=Se2ajO1IYtK0JnpAMGIu+qjGHV979q3U2IDsaaH8YXJfuNqszqYCe6mm13DTgwm5S3
         0LXedAz8LfxoTA0GXj/G5nYaVNKXftqnwJTVLD6ExoGnxac3c8Dbb2vC5Y+ri0OZZa0f
         K43fAGh6S5KnvZmYgepqG/HkUIO+G4xbk4V7Rx4qTab3kbbCc4+w/x13Dw/Tf5wnSgn5
         9AYimcht06seBBbInNH3wLEuMG9VXAEF2680MH9g0AljOtkYxxAZBWZ20XY5XNzb6h1u
         emsDUE1WkV+n0jcuvbOh3ToIgpilFmif2R8ngvrosqjBEjKGhXb/qByxFRk6rtlx7ohZ
         R1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2AtMfTadBLs8nEmS0BloOK+uIClG4rM4IDzYSAxjYFA=;
        fh=hDoO1Dqc/L9hjnoJPhgjFmY6Agh8LaJ1SLW7bq7K6TY=;
        b=sGfN4v1zvBRpIQNzgmd7C9P+aJsW3ccxi1soLk9yh3qG2yoK6qAkuRm08OPwX+5+A3
         4+ZdBeG5qlgrmbu30MwAFYU5jLm3b1yFR0FsGfrp7dWn4T3v0zPKCaENAn4Culb1q5qK
         /RfJ9EMJDiFaEKFRLEBs8QTyrb9GZDSvfWIbtncDQfPBX6mHmkgi/KyD7SkWACmPvrLo
         5/oxH/REdHQkNu3Jx1ZP3CjtWAzLBABN2HX8WQWHIMl+DPOG+5pgpqSjesok89lvMbFB
         /+x6lTKW81nyhhLsB5F4SUhNpj6mW7i6HyO1CogdUwMivEJKccS4+1dyT2nbDZNRV8pg
         MGuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793953709; x=1794558509; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2AtMfTadBLs8nEmS0BloOK+uIClG4rM4IDzYSAxjYFA=;
        b=tc7YfIzYD1XzTkr+EeBKnsf1lnbe+laPbm198lXi885CCZ5AoYN8nQja8eZSn0fWmJ
         vrYIW6gxU2wBFeIkk3DSZXV5HlAlp/MUqq/ozdiMrtR1N4tr4o2XO8+lyfvnTKnfI1Vo
         yHSyDF2uDLYXNg7DF0aQSJQWSUFr8XwnxZSr/ElQ25UIJF7plxXdHAGQcpdvciTYvKsF
         PE47XTbco+cuwY3AcQaw0Pt7stVj8ixp8I1t0GqjKG8y0nnmLVs/6dd2Sx8OF83CtR6t
         6ekOQS+eS0dTikgb53kfGDhHdIEcmtaW0sVTHaohnJXgbMK2ED3zvkn8hmSWdHWoq+py
         JTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793953709; x=1794558509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AtMfTadBLs8nEmS0BloOK+uIClG4rM4IDzYSAxjYFA=;
        b=1C9zKPA7acfuqUUguQChRFE2uIIypsU7rWLyrhvi53Ye3+FnU24iI1IeHutGCCn76s
         nEC6nX5hmaDH/8ZueglFPwQVYBUfsF3QCuB2Al9aJbQBoVz+hAesG/TVYLqPmVZgw2lO
         11oZUnhjGwR24kF/KxhZ40VafTIkh64kid0i/1hlZr+6E1gWRycydsmRLjKjvYVP2MRs
         syf7uV4Cp63WZaycV7A9IPbI6PaMggAv+iJvUUc2DOmXlizUh+pAuLkzfFbu7R4uZK9M
         Bbcb+EA9w58xP2j7m67I/Ghf9LZoVptUBbESWZY00Ivay68amp8Ge5kCMc/5PQCp0JGl
         ggZA==
X-Forwarded-Encrypted: i=1; AKwUvBzfU5SmAhctOx5ndD9vLLHPKpPAw9iwLYA7DYBF8RggSmSl2nt0qQZopc+aEuNPPpRdqv1USgeDfP2NmhzrgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VkQqNxnB7QQLbQ+2B9zu9eGLba1OhDJuGs+rgmQm4jK6Rbkhn
	DkJVHeoVRs8CzPdrmYoXHsr+dSK/+YjYy+5hxGpAp+mvYjo4X0M47tf+oAzNis5ewMKvo3IRJej
	Igt/rSCB6VdXvjiwg3RQYlLtELeXYerg=
X-Gm-Gg: AYBFou18SPn6wKAai50KpjIaaNP5N5O0A05oPI7/bJJXYtJatGnJNhRP+X9eGHaKR/z
	d4D5O6Nbax6TP6eXtjZ6LBsWqmpbj5lQ+NznQlEMoUnf71x/vMnky+HytjuTGh8J+GtmX/15uH3
	tsNVisJMMtGh3NS39lqckezJ1n466tr3mCn+UlbckiEHBl3M1s0LRCvh7MpLDDC5O0zmv8QYy0k
	i6cxW768JjwNakWYpdVxC2BluhhEHvCHdApm0DMNDe2XLtTS7cXFttIn9xNmaRLcangIOuA/Kba
	F2YkPvZzxF6cCsoWOaRL8SzJ32vSaq/W3h6vKVoC786Lf3TjJag29EBAES/IUcHM4gD8uwAdL8J
	2RdRrSQH5B4IflF7bpqb0ZAjv09dpaGHzVG6bThgN9EoNQGMV0JbVf+rIN0GdbzaJj8z/ObYUpq
	rC8Xb5QgYWRrVRZKbrWxf+ao+GU2VAj1JZYxGIsQwy0zk5445C8q7Z6EZBUF8kUZCbL9ipGBbLi
	CCEOrl5eDyoaLMK9NIYLlIxWtCCXw==
X-Received: by 2002:a05:6102:4bca:b0:7c3:8150:83e7 with SMTP id
 ada2fe7eead31-7d2a154169emr1074240137.9.1793953709418; Fri, 06 Nov 2026
 00:28:29 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
 <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-20-dca1f6ed29a8@gmail.com>
 <20261106-crystal-flat-caracara-ac1b3c@quoll>
In-Reply-To: <20261106-crystal-flat-caracara-ac1b3c@quoll>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 6 Nov 2026 01:28:16 -0700
X-Gm-Features: AclHuK97Q_fmR3tCSb11vsNOkfJ9UktWDyo2C1YoKfEXjUnSy-Rv88kHCKF-O1Y
Message-ID: <CADvTj4rYG01pNxZS3FAKzHw9yOO79W-zMdBzaXvV_hrMs+sp2A@mail.gmail.com>
Subject: Re: [PATCH v10 20/26] dt-bindings: mtd: sunxi: require the H616 AHB reset
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:19=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Thu, Nov 05, 2026 at 11:55:36AM -0700, James Hilliard wrote:
> > The H616 NAND controller needs its AHB reset to stop internal DMA and
>
> So was the device working or not? Be explicit, because this is an ABI
> break.

Normal NAND reads and writes worked. The failure was in recovery after
aborting an active internal DMA transfer: the controller's soft reset
could leave the first subsequent read displaced, sometimes without an
ECC error. I reproduced this through fault injection, not ordinary I/O.

>
> Best regards,
> Krzysztof
>
