Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E32DCBE6
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202022; cv=none; b=mN1V/900ssUCM/vxETnlqyf3xslrOBTrnoGaKmnE1Wr8BNz/HbIT886vExwpbDAl7VKEhRm77WHYPS3jsYA7nmoL6YI1efxQPDD0QfeNe2wIE7e1Morx5a/6SR1F/GbYqyCHk9KXbC7RjzpdQFUCuH6OMc3RA/i7wgh+N5uqgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202022; c=relaxed/simple;
	bh=1r2rhfIfNAgeLhcVd3Fth5KFSw3s1U6wlg1lx3h0/WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWbfOdluAC3FzbaMTeCjzZOANZX9Tv3muSYgbwOI7p2jpbR2LhX84t3BBab9Ss5PzLXOJAkEXeLHhQ1L1RVERzoJbkObzir7RywJNc5HnTjQZTFFElJi3VBV9c8GWBBufzZL80Ki++EaIG+REuyYYKa/VJXRkf8xZPLSHGmBmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s5gjhTrG; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s5gjhTrG"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662b6d1e081so1301731eaf.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769202020; x=1769806820; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uNYqV1avZyh+foZ5DUAwLH7I+zAmKYfxKTdgaxSmkU=;
        b=s5gjhTrGSeFj68azt+x/oj1wiEFZN5lmB2hcsrV20h6H52FOX+ok03E+yB4uXogquK
         8/Hp6n9EX1DAj2N/sZO+Q6b+Cfv7nxMbgARqR9xZwKryNKHksVXnFrZTIZo75mbDM7qn
         tbrHIBTA/0YzXZhkCrUJt2XYiUX+iOg7KJTjHGVa7UdQmQSBwGPBc+bxAtQk1T7TG8zo
         7yh2AoyUbHt2J0UxlkibwQ1ou/g2+/qcpbQdyC22x2ZondmPfVfN9D+GX+WJCAC5NCnZ
         Vjobfr9/kwfugZWgUh3Z9JpCXBEne9F8Ez6mPlpbOjgcL4GPcKAuFtWIrZKukwd8ItF/
         V9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202020; x=1769806820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uNYqV1avZyh+foZ5DUAwLH7I+zAmKYfxKTdgaxSmkU=;
        b=h8qOsSdztPZRPh62cJYpxcHZ0zuToqXIbXcnrjwPgcQf0viaHl6H6SlMRaWwfkBe2n
         Qdlye+X4PO3V6NiPjbDhq5tIqRcKCUlXQaRJmiBNZg+mUhN5euVwJ/oRbvXPZks+yYY1
         u4V8+QgjDm8/A4m4m3g+I4163kDXSQr52hNzJn9bg2c63xSwDBDFCXnw0j148xD5fekv
         On5wsXjs2l7VRzB1w37FSKjoF5IyNmOT98qpGRClcXAcD/eZk82SRCr3sj8PBkZMFiQQ
         D9R6UXBrqRk6qr70vloALpWWW/Sta5EusXKHBeU9DEj3CJ+xU9hzyvnjwnDrl5LzsHF5
         ddJw==
X-Forwarded-Encrypted: i=1; AJvYcCXLIUS0NU5ObgqgNS9wroPP3p/05feUhIZNtAo1u47NuT+74P4yM3V7hvzTgiQHfqvHodLw5DlMft4ZCiHtMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRMUvQe/fDNqB53GC4h+Rssnsz/8CE5cyg+29Rkdj2IduKMHII
	miegCTO2ueh2xIIs2aT5LSg9kFWIvMqhWztiyo12v0CAPP6KJ4FQN9EK49lY+FiJJzQ=
X-Gm-Gg: AZuq6aJ0XhkcBNqWi4iSlRCOgvPd3F8K6kH7PYd4TmIUE6+J5lfA74dWiamDzRZZKCn
	iRUC5GYcTNWJ6U/lBunESx08theToWavuTc4lxsYCmCD86zbAoA2+0cm3VHWUO+hiIdJtS6hS4H
	lW/gwL01FRsCvlA86Omu6GwNwxkFtvAqkGrg7vufFwNUJyP3WwefI5614bxDwS9ZDaEDazfboeh
	1emjZifawQXv7mnDJnvbZaHOjfrlr2ZGyeGUllSOtrpjYKZJz34FWhB/dwZlZSUXN2gEPShERDN
	fApgg07rerrq3IL14NgYnNH99MEnRzaJUlC3UzUbrJJeQDuXBD3/RODkbimYhJNdfhpihGRiRA+
	Xmixi3frF3c2E4Hbimf2QG/96TM8FU9ZQv3wsQIxAhplbgjjUJpS+ggAi0IWrKXtNQQpo2RRt/g
	fj8tV5QDqipOe3Sv2eCrUztNGnyY8oZsf8nFMOhuyWr9G5ucqqt9qkLUlSpQ==
X-Received: by 2002:a05:6820:160b:b0:662:b9f0:175a with SMTP id 006d021491bc7-662cab7d3a9mr1810028eaf.59.1769202020243;
        Fri, 23 Jan 2026 13:00:20 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408afba74bfsm2239703fac.13.2026.01.23.13.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 13:00:19 -0800 (PST)
Message-ID: <7126e6f2-c116-40c6-8657-1cddc36903dc@baylibre.com>
Date: Fri, 23 Jan 2026 15:00:18 -0600
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Thomas Gleixner <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Gustavo Silva <gustavograzs@gmail.com>,
 Nishant Malpani <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com> <20260123164711.0000379c@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260123164711.0000379c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/26 10:47 AM, Jonathan Cameron wrote:
> 
>>> +++ b/drivers/iio/accel/adxl372.c  
>>
>>> +		ret = devm_request_irq(dev, st->irq,
>>> +				       iio_trigger_generic_data_rdy_poll,
>>> +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
>>> +				       indio_dev->name, st->dready_trig);
>>>  		if (ret < 0)
>>>  			return ret;  
>>
>> Interestingly that this driver ignores the flags from firmware... Seems to me
>> like a bug (not in your patch, obviously). Ditto for other drivers doing similar
>> things.
>>
> 
> It's indeed a bug but one of those historic ones we can't fix without
> high risk of regressions :(
> 
> 
Sounds like we should add a "don't copy this because ..." comment while we
are touching this.
