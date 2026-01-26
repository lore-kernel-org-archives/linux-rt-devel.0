Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB472340DA4
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445299; cv=none; b=mA9nPi+3qhxX84hiR9M86EZuTOXbuqwjZvnoXbBc5k6QJkstiKs7icFCPyEYuRu4Tdss74vClB0/YeKAi29JcLGATD9xqzS+GDG2Fnr3VhfRbM+KuNv/fwzptJkv19KUtI//6Cd5pumjdlnLttFxC55AOebtIinh/IXOaft7UZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445299; c=relaxed/simple;
	bh=ZyeCEnRJjBRKG7NXS66982Tk6HBV6hiwXRGWLHqwKpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAuxgeZ0tBKFHJ3t3YuLTMQnfhlw1kw3smz/iOTqYPN7W3p/fPYlrvjqpnjDk3xbC1s3yQ6JpwDRq3y7xgEVjT9SpUwd3+PIeiGsY6/FcGZVuXF7gbQp5PEm9i/10G0OLNny0OE0STYgG1BG0sMnsXIawmC4gh/l5MwCCdJbmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SQZd5T7I; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SQZd5T7I"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d148db5fdcso1583691a34.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769445296; x=1770050096; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNGg+szk5GN7k1/fr737eGbbjOqTigabkUA45rZV/8A=;
        b=SQZd5T7Ia9NAVitRRXyZ/K77ryrDkddrUOVUsNk9uFUMXzyu3Lr7J3C7sevtdU5Onz
         psOyVNSIZwe2WsAEukPWa3+iTjJfRVIZYkeLS42yUIflkPl6lBo+2CsAY12BMIN4Br3t
         0yuk68/J+yzioWOofTxoU813JGbLiUt4rzaEB8GCsXVrIMWM8fceO7EjEoBB+PRBoTR0
         7qdVGJIKgKSbYFk7SHbyxqRICKugJnjqWrlxeUek/9ZI0NCaTRdJRvrCFmTKIy4Xv9+H
         J+YjrGMhPULh6Wum2ojFRmUV0p2uKWszLqTV897vPwm54LKiw83XOaN6g84hzGw0HblT
         BRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445296; x=1770050096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNGg+szk5GN7k1/fr737eGbbjOqTigabkUA45rZV/8A=;
        b=G+evhRNpYFNJCUFXb3NaNaDkfGjIMV1+eKYRMJXhfslZVjSjhNbjvT1U6A3Gbi7gP7
         RBP6BnXkL+wC+ZJ3hIhJn9Hwag7kCkAoj2iANUuULTrPQYF+lKOgsOwKaOvlGyHo2KB9
         ZG7LHN0IHDtieALgF8FK226/SNDQHTMTfcAXuXSR95w1hEEO/wSxQgBwK1TWtZop5sFg
         jJ07MkOURfToG0QAyHSgBtVlRvtJMagxEGG8eCa05GWucjCmbh81R6UFrThbf8t7BH3K
         9WSFY+Cb+VErsy76ovNhZYeYjCK76RFmuVkcXanegT6xpz8KKaRMiutTgMkSNqZXlq2/
         LUPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6WIPR4euZGPQIogHAyJDz0yXoCM1b1PnQNiduCEOOSGxtTZVyGvxQGiXaF5+xLjs7t6Vo2F2SX1gLQz+WRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyickMNDn/wTjImN8TcAV6zrhtlWhXuDIkVLrlLwYoiCc5LDl2w
	TDuhvM5xWQ+zXwWhI6oBxjPqXBe6bCTq5l/FggoN7CeQOoTJ30/UAdIsgnCMSO9bd9k=
X-Gm-Gg: AZuq6aLYqhpXQ296S7EY951f/QvGyx6SUliTiajTtuByxAAm3D0Xdn2QkkG4kbGs6Xs
	OtVdDRnUKUp996bCosIdFru6oQSHgcH/p/d26d++K/oeICVrvldEnalsvK/KkUoSXeFJsPyqDkk
	CZEA3qoxTmwSRzSSrJJLvnKEamyGy291uhwo2NcfZVqEJ+5piROz2MZ0ZiLNqn0yX4Ope5IKVE7
	K6TdfxrBWlFgg06mbbpRgEaOvlRwV5bT13RTHmypaSnW81lPsDjwat6IKWMixeg6K3KMhDk245n
	9Jj917HUffFPC7AbVDVTJNBTcJdM5eDB+wIlXl/T8iTW3OMjwJNcbQDSAw0ZjEJpU3lQTdiy+oC
	MKMkolTYUk419y9DsDgninxTjZeADjJfxZf3lNRwl9g2/mycSjLMrCEXOV9Zdj6ezQ3FXTIgmJA
	Z8o2oLX9LQFDpEzdd1G6zcQ9284UMa7cGxwLyy8petjNXBkuLXfDr0i4QgFlRC
X-Received: by 2002:a05:6830:2810:b0:7c7:6063:8e0f with SMTP id 46e09a7af769-7d17021ec7cmr2337382a34.15.1769445295763;
        Mon, 26 Jan 2026 08:34:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c6:d863:90ba:c4c5? ([2600:8803:e7e4:500:37c6:d863:90ba:c4c5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b36db91sm7936018a34.13.2026.01.26.08.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 08:34:55 -0800 (PST)
Message-ID: <8e560227-3596-4bf8-9fd8-b843a4738940@baylibre.com>
Date: Mon, 26 Jan 2026 10:34:54 -0600
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Thomas Gleixner <tglx@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
 <ac45bbeb-7a76-42f0-88d8-35dbf9742a0c@baylibre.com>
 <20260126080903.B0_vWRKy@linutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260126080903.B0_vWRKy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/26 2:09 AM, Sebastian Andrzej Siewior wrote:
> On 2026-01-23 14:56:32 [-0600], David Lechner wrote:
>>> -static irqreturn_t ad7766_irq(int irq, void *private)
>>> -{
>>> -	iio_trigger_poll(private);
>>> -	return IRQ_HANDLED;
>>> -}
>>> -
>>
>> Replacing this with iio_trigger_generic_data_rdy_poll() seems like a
>> separate improvement that should be in a separate patch.
>>
>> At a minimum, the commit message should explain this change. But I expect
>> the reason will make it obvious it should be a separate patch.
> 
> The other use iio_trigger_generic_data_rdy_poll() as the handler except
> this one. Which uses a wrapper around it. It looked to easier to add
> this hunk.
> What do you want (split or keep)?
> 
I would still expect a separate patch to replace the duplicate
function with iio_trigger_generic_data_rdy_poll(). That change
stands on it's own, so deserves a separate patch.


