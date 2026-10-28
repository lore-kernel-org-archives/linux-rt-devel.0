Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219442;
	b=RBjHnGo8oJVbjRqZwcU0IJds/Q2RTcHN36zDptltz35maZoq7o7TMREg5VwEiZozJ2PR
	 USbyuM46+7XyTuO/Kc3zUHFOo0wmioKj1pw+njq07beadA6NAE63GhX9nXOAJpLz/qzCn
	 HQZ1t9qYJ4Y2yZo/osBO+TMXJEJwaYFhzYFHmlvMD5PzOSZmNplI0IiCbV/l4+UMsU2EM
	 FJG0mbIBTOX3gpFzU/rx+5KsUSJpeAHIJ1S1bRG34x7VFIRpxMatIAyJmIMJ8ahlVa2LO
	 pJpqZf2YqChig0AIB7NJfi0RqXBjMYgR9lkK8E+1OpWMglYJjzwSFKw17r1dbU/eltA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SagG7hnlNkBMWrHHVXZ8fa/+eusWUEksklF+xlNh03I=;
	b=KjKG1xNGeycOaq8rCIJEF6YtP5O48N3OUDtRUq+hcgdzdfZtmsb3U+hdBnvVtAI2zaxk
	 LbyjNXcGiiCreIL7219ZIxYTvI+lM/pMDIOGlVazwB2HT3JDoXzLFLlFmi/Sx1iYmRtRb
	 EgM2YQfO/0qzd3/+AhFvPloZk1W+Va1cl1M5XOjVc3WhYywue1xIFaD5MAxk7QcFWdbAR
	 Fxg7XGKhk/9Rh2+yj1YcHTwhniM2FgBTlgXJX6h8LbEYg8Agz6Zne7XO+aqHnTceVWs7M
	 MBlyj4Pt08rSJBrXoblVX/QHFz4JBHfInhomYiunMWtn8lVmWlIVhQ6SePBisyoCSXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XnG61BgV;
	arc=none smtp.remote-ip=74.125.231.128
Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B61606A31E
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 20:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B61606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XnG61BgV
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-84e8a9fae57so563686a34.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793219440; x=1793824240; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SagG7hnlNkBMWrHHVXZ8fa/+eusWUEksklF+xlNh03I=;
        b=XnG61BgVPJUeE+5vPSb+QwM42wDInGnowESkxUK27qSvDeiZ9M0n78e42BtLXk83/J
         dg4K7lV/UMsztTCvNzLeIzwfYNSaSLnYWikslAEfUlWRYycvpoaHqK6fOTWcdiGJ91J0
         S2xKYO5xt+2I9ZcPo+Bx7ezSlxAnGaFGY2EIL79Y1qmb+01eOpUETZMhadV5Dh6/dJdt
         6rh/gKPw2ZLKXMJGAtZZXCBohq3sQkXcy7Wx1yEKmTjJSz/Vor2XYXnBHaAr44bzo9M0
         qDCLLXKR1+17Bhpv7yUic7q6TBfIleOaFp/GWbj0bPuEd9xVCecqsmleGQtWZcgQVSst
         C/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219440; x=1793824240;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SagG7hnlNkBMWrHHVXZ8fa/+eusWUEksklF+xlNh03I=;
        b=TmvvcuRwT8MIdxNcKfohZJ8LT6jBlx/Q8gXB5fTPf2dp0NpSf8G0AlTNPSAa4CaKGP
         lzzC2Nf+7yBRZmVmyNgxOQ1Py+OZ9+eWVV2C4HN2CAUwFV4ceJ5t/ok9j+w3ybE+/tes
         JBZnuB4PkTB/kk86qO5LQIpcU91dUj7v+KTKiqi31p7tWastw5Mq7rRWh0tjygH01gqP
         DBhICSqYCxk202OFh26rzOJu1O93Y74VIqtMnTyhAL9IZfgYTZK/EFqQn0Gd++1K/dVv
         AnJSWNFKUNfbDnIYqykceUa4VSXKr2iia7qZun8RzYZ2mA6le7Aqjyf+whero+x9t5SE
         KO6w==
X-Forwarded-Encrypted: i=1; AKwUvBw0DVZotH9aVTtRmcN0vBznMyXTWtBcICdpffws+8vT6UPHDGIiLjyVP1iui6qHxvScBlxhtdl1uba4CAUwkg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJk4GBKtiQOWUr5RqxI4mUYIEnqbm6kVJLCEliMPyp/T/afFSP9
	Uql5byjCtJWZCtn/1XTWGm0o0s4XXzqYcRJykx7b55gfHlgnrMTTNUHG
X-Gm-Gg: AYBFou3WHegrRsztiUAHB2eOg9w1Tno6WKmp9JY1p/Jm/L0Gfh4BpbxqzRRMwxe72id
	1umLYD1ZWFCvTl5atESJ2NJtK9hFkERVDC1B6bfR5EQmtbMHYoPEGrIaBCZONgPy+ER3dqeXMys
	c1ddjtnXgWcG3s3pCE0BmBZmKDqYBfMyOIQM8kvKuKw6prgrzjX5hfeNWT41Cb4a3mY7181kixE
	x7S4qvcyLscWNAZo6Ohy8VBVcza/55fYLOr/cZDfCJRO8F2jk9RzPkIlgeNdUgZ5OmwJFkxTi2T
	Hf1AiSEIlJ6Ff2niiE+GZkzffhJ8COqw0z5I8yRooO4dNrPsRGranqQzBHVJYV2GBIAzUc/FFAl
	msIdo023lksDjcVpakieaetCF9o9Jnf2hs/P8PrJGr3CEBLg2Yid9COS8eNvYg29vn0tcNDWec+
	jvA0NdfY1Y/dy4k1bCOTpGsNibZyf4adCzDvFdx8rOUp1pCi84S84A+ZSXbW5CJ14WZj8cVTYYx
	byuPmSTx7zsSxYOWFTCTrpH9wGdOJ0EV8z9TKLcUblUl7VsmEDke4Y716waZJvG7Zs8I4VHEaGI
	8afQG6gHN4kE2VG3Yv9PvVQv+9hTKG1Jky1PbNWEV0aUEti7E9HvLYSPoRSrM6QYx12y5T9VzJj
	a+i1bovVXlw3wN/Ww5Oz9TQqmEPsP9FseED6ENW4Ifw==
X-Received: by 2002:a05:6830:680f:b0:81c:a8c5:633c with SMTP id 46e09a7af769-85ab7b0d6b0mr3330153a34.17.1793219440535;
        Wed, 28 Oct 2026 13:30:40 -0700 (PDT)
Received: from [10.10.121.179] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1d363390sm2618813a34.1.2026.10.28.13.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 13:30:39 -0700 (PDT)
Message-ID: <7981f7c6-c949-42e6-ad53-15e6530588cb@gmail.com>
Date: Wed, 28 Oct 2026 15:30:38 -0500
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: mediatek: common-v1: Use a raw spinlock for the
 pinctrl regmap
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Sean Wang <sean.wang@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Hongzhou Yang <hongzhou.yang@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, mfd@lists.linux.dev
References: <20260929-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com>
 <20260930080609.dnK1-Uta@linutronix.de>
 <CAGXv+5FssQL3Go3VDFbLAT6HP12RS3U3OgxhYOeapzs64QTdUw@mail.gmail.com>
 <d3d3e7b3-eb8b-456d-9a2c-116334e86c14@gmail.com>
 <20261020073236.dDVmd3BW@linutronix.de>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261020073236.dDVmd3BW@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 2:32 AM, Sebastian Andrzej Siewior wrote:
> bulk writes could be a concern. The 40us delay is within the lock
> acquired? If so, could this be done without the lock? I assume this is
> part of the init sequence so nothing should use the HW so the writes
> should not be interrupted by other writes to the device.

Yes, it's under the lock. regmap_multi_reg_write() holds the regmap lock 
for the whole sequence, and since an MMIO syscon's regmap can't sleep, 
the delays are udelay()s. The PLL's enable runs that sequence (13 
writes, 40 us of delays) whenever the PLL goes from off to on, retrying 
up to 10 times until it locks.

In practice it's init-time, though. The G12A USB3/PCIe PHY takes the PLL 
with devm_clk_get_enabled() at probe and keeps it on, so it runs only 
once. Nothing else writes the PLL then, but the lock is the HHI 
syscon's, so on RT the other clocks in that block would wait it out. 
Running it without the lock would mean changing how the meson PLL code 
writes its init sequence, which I wouldn't want to take on in a pinctrl 
fix (unless that were preferred).

> So it would be safe for now…
Yes, that's the trade-off with the second option, which relies on the 
DIN never being written in a multi-step sequence. Nothing enforces that 
though.

I'd like to send a v2 after -rc1, but I don't know the best option for 
the fix. Still waiting on Lee, Arnd, and Mark to pitch in if they have a 
preference, or any option I've missed.

Best regards,
Ryan Brue
