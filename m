Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0B2C0296
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201797; cv=none; b=B34jenAKJpxR0AhtFVES7+lyqae8YTnvs6H+VN4geCM149Ajhg45AZyxmH1q0RjGFue47PbQ6KUG4d3FeGZaTKHKJ2nBNGhCDRSIIUbbPHbYXcoRBxevoAxhSt/sfkwBIBUrThTAb3hWpH7Rylp9sY8GZQLSMHvps+yCW/MXt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201797; c=relaxed/simple;
	bh=GWCI8sC23CD6DEJIwzN+W/7LwJ5KltaH+8qw8iBLyU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwCOXf8VXDMxQKv3v9TZMispARXeF4iVxKntaweq9OvFMPAtFJBsNINHw5s0VpOw2crCMiomyfPTzmXvd8VIr24BjL5F48C+SI9SuNqF2lbaV5kTC4ptGGvEJKGFG9VfZZtRdtrJEhNzA3E0rfJHeqxquqZ/6rVUFV35HoWA4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kljVnAE3; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kljVnAE3"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c92df37fdso1263647b6e.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769201794; x=1769806594; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlVn1KZ/ohz8496QMrVjVa8IR7RgypRaR2xz6SXBEL8=;
        b=kljVnAE348KnyPMcoBqbs0St6F51Epfq6QK7+EInJa/Ojfi0ahc1r3ccyxBF13EVgk
         JlmOYMboQSoYr0XAPvobwW9qBYCvaFKs+K+0yMtNYVlwKAuyS8+26M9OgTpkxATMpHmN
         5/Lmo36tF1EewZPYSghRW0MkqF9vpuv1TWeTbxnk6XLCW2be7IFxS6BOhsWIE5Z2MBdQ
         RpzXagvMbFdt8CiZhC7IY1Tjg2iaJjQLybOH6d/brQpi4VZNsDqpqc4/Uh2Bojaw9ph0
         zz9k7KTLC8BgQtZ7EPhCeM5/Go/eswgQoZ+mlMIplBdssy1VMyBXAeQSBX+2i7RTsQnS
         zm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769201794; x=1769806594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlVn1KZ/ohz8496QMrVjVa8IR7RgypRaR2xz6SXBEL8=;
        b=G6BebdZOqkqfx+D/rOOLUTniTDR536E0YQSUNoRb8QIL5sERNSE/90SiqjpecDqUNC
         6NAw5Z7Iux61yfDZvthZfmpe5fg0JyPL2iFZ2YxMKr5pNEQw0mXo8Q3g/tqJy/fru2f0
         GqGOFR6diKtBQyLvhwMCajk7Mv43KdAzLI13RGdoEgAcgkNb+b5WALKJP7rKnO9ONkLz
         VfvPDvJCYO56p2Mo2y8mf49Bw3Z02WkYIl8TJGQGaX1wgN+oAECCXwZPWYumexhy2iPX
         W7eKGH0x9rLn47PtEFz6/MIz0Ey8IUDCVjKro3OiT1TFmzxMtG4JaG3lE04lEtZLPzuU
         IMjQ==
X-Gm-Message-State: AOJu0YxRUoyAyf6V0fbNhW0EJBCM9QaAbFy+U5dMKOx7NBc3rKScaZoo
	x3DbyJtEcS0JOj9S6kBVclSqbezQcKwSBcTv9TNaA4FVx0U1KDnyhk23zbq37FGPbpA=
X-Gm-Gg: AZuq6aJwfO9QRAkooAnaooHyYQzhaQpTCDEGm9UGqoadfXs7MJKZquwXsy6VTtcYMwP
	skTCoKXmOZBUeepfFjirRaKjWxeMya69HSNmGLZjv2KPe19irnzaoMSRINjeA1pU34oN7ICcwZp
	KNRwnLoxttTelUSDTq1kZNIZQcMUo0Tzjr4/svoMEM0lzK0TZD9rFuEWm1VSpTQgNnzEPdvVfZB
	3vgWyhhpyErrIp1KSwnPJJtve6M+Wo0FyP7eVcm6R47tUXhBAtUpVGG5MnoXahsmW8eIu4PczWE
	Mc62PyczMZfIWRCOi6jmO5IjatkJoN80nkDTOTku9IpqPNZ+/eEIOmxRn3tMYBDNHs4k5pERiiL
	Uy6C38lL9RxNv9gVFOWIXs11SK5JmW4niox4cwJbzjApTRYue2amAcwW3hRWgGJwxZBkW6e3X4o
	f8qhL/n1llPry2Z9ISCLaJjOcW132f85tVhAvFhfs1IZzsYhvEKz0kUBcZIw==
X-Received: by 2002:a05:6808:191e:b0:45e:a501:750c with SMTP id 5614622812f47-45ebb8964c9mr1030209b6e.62.1769201793939;
        Fri, 23 Jan 2026 12:56:33 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af7f940dsm2110331fac.3.2026.01.23.12.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:56:33 -0800 (PST)
Message-ID: <ac45bbeb-7a76-42f0-88d8-35dbf9742a0c@baylibre.com>
Date: Fri, 23 Jan 2026 14:56:32 -0600
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260123113708.416727-20-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 5:37 AM, Sebastian Andrzej Siewior wrote:
> The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
> other interrupt handler and this supposed to happen from within the
> hardirq.
> 
> Use IRQF_NO_THREAD to forbid forced-threading.
> 

...

> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 4d570383ef025..9e4a66477d2d0 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -184,12 +184,6 @@ static const struct iio_info ad7766_info = {
>  	.read_raw = &ad7766_read_raw,
>  };
>  
> -static irqreturn_t ad7766_irq(int irq, void *private)
> -{
> -	iio_trigger_poll(private);
> -	return IRQ_HANDLED;
> -}
> -

Replacing this with iio_trigger_generic_data_rdy_poll() seems like a
separate improvement that should be in a separate patch.

At a minimum, the commit message should explain this change. But I expect
the reason will make it obvious it should be a separate patch.

>  static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
>  {
>  	struct ad7766 *ad7766 = iio_trigger_get_drvdata(trig);
> @@ -260,8 +254,8 @@ static int ad7766_probe(struct spi_device *spi)
>  		 * Some platforms might not allow the option to power it down so
>  		 * don't enable the interrupt to avoid extra load on the system
>  		 */
> -		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> -				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
> +		ret = devm_request_irq(&spi->dev, spi->irq, iio_trigger_generic_data_rdy_poll,
> +				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
>  				       dev_name(&spi->dev),
>  				       ad7766->trig);
>  		if (ret < 0)
