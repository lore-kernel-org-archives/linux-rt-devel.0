Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DB3B95F2
	for <linux-rt-devel@lists.linux.dev>; Fri, 22 May 2026 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441627; cv=pass; b=bpoYL2Jqf67q21zz8d9F+6lZS9ZXu6JuRx5Itrl90NXwtUsDqbQXMpY7X+6BINoMhNEMl89f+oMg2KvRjM9a5BexOM2ibGZybM0iZv7OsF+gnAXMJguk04R53RaTE6LvocJffX3Jbbfj60pzCB1yTKVLvLcnGwna481rfazBuAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441627; c=relaxed/simple;
	bh=OEirToh+MwCYb1DaYfmows1iO3IlCn32okdonWMlk1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DW95vyke4SCajit/NP5JD56MfciENERPxAmK22cJ9c4T3QG9DRkuNqp7isnykfJjuRigvvuK10b/8BAYOwKowQifBb1+ZE918+fakOeliC+MuADv54A8J30URtCB32F/oB3zL0usTYjReSEPzt2RMfgLVQZqM9A7uxayJraE2VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VK5F3/VR; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VK5F3/VR"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so2611368a12.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 22 May 2026 02:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779441624; cv=none;
        d=google.com; s=arc-20240605;
        b=Pw2H8Oe7eZono7A8c+rSF4RS1dIdJoXvBLtgWbDbqzA2wEDVEZLC4UGWt38px+mXXX
         ovQTuuavJS+HDafh/OASNtmXXROBKr/jRpCnT5bwnzPFlq0wnvy5nTdvAcujzSx+WHkp
         hBgFU0jKQwfrrRmHGNuFwgWRTJcu1qn1Jnik8mFsqq77a6GrLXi1zpKbkM07A9IpLgXY
         oau1QTQr2CL+fOewCyDTe3QAqwLM1GkTEqLPaloqYK3oPPhfAAGkyE4nmln36Hi0OwhA
         MdqPCAftuOMZ3I5UYOmxISmyHd8YQTfLOoqUzSDUNO8xu1WwCJhJUXOj7mu9upUAz09I
         J+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OEirToh+MwCYb1DaYfmows1iO3IlCn32okdonWMlk1w=;
        fh=kN/0mOJ3kFCivGN0MWt1GAn6kia/4ffYPbKHlBdlqsI=;
        b=jWoG9yh6PRnWxaOr2BP0vRHrshE8nlwFyrRfVMle5RsKJVhjFlUFY4wO540UsgMeiq
         zNANO0JfV/0gXfq8+F/6OVBa53htGrtymtuh6ePnRCDq7coal6VTb8fbmkyMzMoqpZ1z
         lBLOhazR7Xoz5PsIeImr1GWVQxsB//7uHYJIYswKXYbFf/X3FMl1lLwd/7pxYM4AchQc
         wNkl7Y6ID971i7IqrpT3Q7QIwe9+g9l2nYQVzd1KKwN04FWHfB7NfSWNRxnm3BiolR5n
         H7SI2hT8HnmAleGHcCx37DvEEu3BMsHaXAm6KtpAc5eFHhR8sBz7cKsm6OhWPpaTZNy/
         OsZQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779441624; x=1780046424; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OEirToh+MwCYb1DaYfmows1iO3IlCn32okdonWMlk1w=;
        b=VK5F3/VRUcWNkl+5gglU6P4xGclVtHIbdFhd6Fhq9L6ZKEjsvIKQ469EFjLykIqFuk
         s9RVwOf/f0BU26jQaTL8yavSbL+VlHow/GQqoDN3FMBaGKnfHjupz5obh/El8nq1+I09
         r+JPG3TNG13vjaHBQO2eQFNLjuUMAosRkRgfx/SK7sJ/gKoBUS9Xfg64d/OgKP/djSX+
         TBzdIyCJTF8GXktSDiihGBwu9ruc+kLRyBbSdGBTeVU8qKIY+TnY7F2rD73A80HRvX0o
         vqdrpYCqwQ+eoDKgpGUoyw8jBTvWVhFQtMt0h1dUbPasCjQF9+oUEB/7GQ/oXAnWCVQ3
         txKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441624; x=1780046424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEirToh+MwCYb1DaYfmows1iO3IlCn32okdonWMlk1w=;
        b=Lj3m+tx0wzy16KvxkHG3UlUcRoCrxB0Rvkts75GHxd/wzipNH1hxH0/nfzxy5z2YQi
         Vu1Uu018SS/qD25AUe3Zu4dhuuGpYwmYAPLaI1NJQOVJcCqbJN5ukCOFJuq1ORR0khO6
         2q895vzCwJ8BZm+Pq416xtdi15gq8tPWgdOLoltV3fY7NEnD1FewU9ydpSTW/UzBx49/
         YmPeCiUuv75AWB2k6YpGPhKWe+Q3SkaA9qcS0M2A03kHje2mjfqY7obltaQBI/OHsQHq
         iQYWGmEt4GlaEh8WEb4zroxdQOgczvMKmj/+KOMMoVLfwNQ5P06vFsl/js8s6DDXQ90R
         xN9g==
X-Forwarded-Encrypted: i=1; AFNElJ+XUL6+6MKDwD/p1myD/7rNDVAvL2y4G8zuGwRwuMTW01WtjkZPGbF2eWCFOSR5nLv9hb5qB3MyRm9n86umXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZwJ6WpcX7n1o3Zb7guWzis4pTd4eoQ/a20cxTVfh7xwY6CkGT
	Si1XnaOe7mwC26hNL2tH4KpN5bevJTdgyla2uw0C9PpKtRkPmmzxFyUBah+qmoVjyUbjHcKpSGL
	0V2NeOt/WnT02EvrDWmfnmkjLNv5WxJp5y6PaoXNqUg==
X-Gm-Gg: Acq92OFW5JZ1cpewvz0c9Yvomf1iEUESBJomuqjL1JoRLP03QSPSpieoD9Yb46dvr2B
	uuoinlyEFLGRWEyjwCF8QBRvg/TS0tsuCI86n3ZGAmiX43SSPJJXSqLKxT3NNB7BJSJN6Lh81eT
	rBP6BvwZc18b0Dxh8WfxR9snL+/YizrmhqYyr7mof6rNzmyj/a6Z+dIc/iFwyBVYYTfqxVnyqJc
	WRpBgwZkH1+MmRCHYdnW7HUqXWCfpydsJLymB3dnQUa0QRn0m0Vu2o4apyYZRk9t50iP/MZBvYe
	WcDH/F1b16DOaLZPIUhHn9WQGfxAhMHGw13+X5U=
X-Received: by 2002:a05:6402:358e:b0:687:cfde:ddb3 with SMTP id
 4fb4d7f45d1cf-6889c420cc6mr1356687a12.5.1779441624077; Fri, 22 May 2026
 02:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20260522061030eucas1p15f61b7bc01f77a3d34d41472210ea662@eucas1p1.samsung.com>
 <20260522061012.2687122-1-m.szyprowski@samsung.com>
In-Reply-To: <20260522061012.2687122-1-m.szyprowski@samsung.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 22 May 2026 10:20:12 +0100
X-Gm-Features: AVHnY4KmsYofVZ6OtbI0hlOv_2b1wBOu2Rzf0xG7uc2W1dzbk8tXLU_FZLOZnh4
Message-ID: <CADrjBPqaVVCYzeG6OVtB1VqnQCLAAvefuZHv3=v86bRcaAv4Cg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/exynos-combiner: remove useless spinlock
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 07:14, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> irq_controller_lock doesn't protect anything, it must be some leftover
> from early development or copy/paste. Remove it completely.
>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/all/20260520220422.3522908-1-m.szyprowski@samsung.com/
> Fixes: 96031b31a4b3 ("irqchip/exynos-combiner: Switch to raw_spinlock")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
