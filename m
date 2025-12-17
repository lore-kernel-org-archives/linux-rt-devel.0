Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26A39BEAF;
	Wed, 17 Dec 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981846; cv=none; b=UAAodMSZ+yhz3cUTgMsBHPRK5VCbHjPdI6T4qtKM1bpzDHoyHhEyK8IWGbRo3x6A4/Dl/zHReqCL+xjCnD6H9RHwdAwhvptsM8Nw9WGUwIMF734EQ8qa94noDMR0nXLZt0KX+trBpzSilR+YztkM4D4psAvh1hizQDyaCjpzISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981846; c=relaxed/simple;
	bh=hPrViA/mDV5njR4QGkK0WGZBy9Y1e9ziNuDvAB7tbGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iP2LyLRLe6ktz5notjXVR4wsj6l/FReQZK4B7dM/1jQlF2m+BDCqayHv9yakqxcN63+6q/7DC01ZPEj0QB/1KTp2YKiK6a2+Bm6vV1RREBRMScl1tW5d5gBXRQMhcOFwOU2ulxyzxyoi5gkah3w0LdcJumENjk92Xt7QYqhPw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0B5RPAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0B5RPAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C2CC4CEF5;
	Wed, 17 Dec 2025 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765981845;
	bh=hPrViA/mDV5njR4QGkK0WGZBy9Y1e9ziNuDvAB7tbGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S0B5RPAATTBsHNL48b+HWLvopFBrpBJwOFKNEcPtsaGX1grspiH7IAJzGjSi3iATF
	 y0xdWPm3j4ZlypSsgEMNsLjoxb/5eULJr80saUSDlBpV9jEU+ch06a9WosL0SUQvUA
	 c0ag4ppBNZTe0+fp8CuF4TR4KXrIgs/SiA27Esu6e/94avgKAfozKlZgdresEGfDVD
	 jurR9Lg7A22UAHBjS8OOkBdU3BrfiCSs24Ug0nJiRvXTgc2GfO6QQIrILmDrk6PksW
	 syVOwTCT1/l1n6Tol3ZZJw5Rw8NNo7tzm0eeQlPs9Ufk89mrsD3Vvdfsk2WkO9/HCa
	 13VG3TtbDMiXw==
Message-ID: <07f8f657-8d9e-4310-ad9b-99fa6055eb5e@kernel.org>
Date: Wed, 17 Dec 2025 15:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] ASoC: dt-bindings: clarify areg-supply
 documentation
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
 Dan Murphy <dmurphy@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Lu <luminlong@139.com>, linux-rt-devel@lists.linux.dev,
 devicetree@vger.kernel.org, Emil-Juhl <emdj@bang-olufsen.dk>
References: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
 <20251217-sound-soc-codecs-tvl320adcx140-v1-8-293dea149d7b@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251217-sound-soc-codecs-tvl320adcx140-v1-8-293dea149d7b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 14:54, Sascha Hauer wrote:
> From: Emil-Juhl <emdj@bang-olufsen.dk>
> 
> The documentation for areg-supply could cause confusion mainly in terms
> of the relationship between AREG and AVDD.
> According to the datasheet[1] the AREG can be one of two cases:
> 
> 1) an external 1.8V supply
> 2) generated by an internal regulator (hence a 1.8V output)
> 
> [1] https://www.ti.com/lit/ds/symlink/tlv320adc5140.pdf
> 

Incomplete DCO chain.


> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
> index 0f043a51f1822f4d39214438818e3bc84d3e8681..0c550c04f5ef239f403bea668ffd8c6051d86821 100644
> --- a/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
> @@ -41,8 +41,8 @@ properties:
>  
>    areg-supply:
>      description: |
> -      Regulator with AVDD at 3.3V.  If not defined then the internal regulator
> -      is enabled.
> +      External supply of 1.8V. If not defined then the internal regulator is
> +      enabled instead.

Please re-order the patches. Fixes are always before new features and
you would solve yourself one review question...

Best regards,
Krzysztof
