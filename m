Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682A3B42ED
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509250; cv=none; b=gsDxzh601JuD+t3Eb8sY+IwabISEzXEadGnUrtAQDYRK8UGCaZAYr5h55neaSXjbuRQEXLJfdb9zmBvEdoXbdgub1Pn7c6Fm8Ch6wNBaszFldGFdfS6BZUByMevkMkuOpFES+614dyeenCg2M6dHZpq634y6NYqh+8BRKWPiW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509250; c=relaxed/simple;
	bh=7gTGoROcY88FIx0BKI9qz9m4P1KC5KNO+9LCkMExk6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epfk81Km/VWft3oq6bNIEMlYdTrCmg1ppBawAJ268fvgblZsVLcuZHjRfHLhZzSypRtltbSdMTfTcE6QKkF9oTc6ex9DauSpto5ekequ7s6obbE2vbRAEAe/+fh84Kaoqg5rZU054q6G4GOov6dtLARuMuctUMtQWQOqwW+8Sdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU/6C3x3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU/6C3x3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso562349966b.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509247; x=1782114047; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gTGoROcY88FIx0BKI9qz9m4P1KC5KNO+9LCkMExk6Q=;
        b=eU/6C3x3JpBCa4zR2pAK3QRB/AlFoMBEArxetVU41mZzVBws2sU3RW/cBjVHrMeYem
         DO4cT+dbJTM59bTM9hNEgLVS3c0dWYinIDWjKAlk0JRp1H0W5vvS9Y6HgTwsh1/3qsd8
         iQPW10rxxeHbCT1nTCrcC9dp14yNl81PUIRG8UcUoyM0rdA1ov57DVJHNhahnWGvhKNl
         1yAn34hCB61C8D0yCf3UkJaYlwCrOGBUpqwTQhBvgc6KJyMG+x2E7ylC9Mq2stovkvGl
         flvP8CDRJs6j7UCue3xD2Ga/j/1Wj3jtAHF/5qhq9gCttnwShjiIHSz6AiYE8d3vBzK9
         aAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509247; x=1782114047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gTGoROcY88FIx0BKI9qz9m4P1KC5KNO+9LCkMExk6Q=;
        b=OJRBbd3BKGebJvdpTCd6qKhAS9K7OrdWJ6p+98Ba1rpn5NT6HdhuH8aQMfu6Pkp9/w
         clWwR0lU5aXj97TnaBFBE7ZoncaW09AtQHAlUJOvFVthlkVHwWHJDi/NzNL8H9xrWzfQ
         MmwAPrWOlrdcJR5yN6vabl6oCL6uv8vHBaQ79b2gw1/yT7Vap5g5u1iwC+IEIwlnG1ac
         t/gaO4zSJZlMr19uSi0DpBqeb8K310+JFmqcttjOkmjoAoUKjPLitRat0W0bwGyBWsi5
         xf6aAJ1RmOgPbPq6cyxhJDOzuxU2eo7xV5xfnqhqUhuaX5zwMmK0bkO1b1Bthv+AMDBZ
         IUiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lkvJhGK9iJaQs5+6igN4TRPxxYghrdX6iSx0Zeo7Ani9DUp0ggjSSSoeXd7iXDk6GAmXqRuEdHmB0+2aGAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeKTGIJTflJIotsVkm7MPrZ/+eM6H5KO43FbrMfboqabOUEJNH
	La8CINXGfTTGUx7MOdIX2DlR0RI2TE5i2+gg4Bmo3J9UEzj0Zxe7ZgFo
X-Gm-Gg: Acq92OFopqD95M4O1PEt2ZBLg1r0H7mXHDDH9FlqsCvcAArlp+Duqh0oZxlGRf4snPF
	fmrsgX8LgFlXqnj6QsAMxRNqjgda89A0FT+H6RnkyiW+EvEgyoT+cE6foZMD1FH4uQA8idTSGpd
	/fqvlvu75493p/TiM/cizAJb+71TqL7nRM7T7Ppcg7mazq5c3EtKpxtpHEw/P9x/El4fMTVDXIF
	dMCxu4NO3wvGL6KBAhYcvFMgipG/wx5vdHqlTHGk6WD1xfHMTFdGHLr9RvERqwOdyIcjFWE2T9j
	t7BmxAhE7ckoBtLd7S5ZV7f9WjZMZ5lseXvWs6r70Pi2GolYuCGzRgTlWlUGRPtdad7hwmPW64v
	B63XeLeXCDOyOcxwo8ZhNdcFEbNcFBR4qf05eAXXWD6TTylhNZ2P9nY5cOUjb5KR5TASg8JQRwR
	hzgMmt3e0d1veNhyyp3ejz2q2rcKo9zljmURjooxQreythSn+uOfj4yTkpsbHxkJI4QdnBb5nDB
	WKe+4QJ9uFy+5WbCueEBiHo3Q==
X-Received: by 2002:a17:906:ef0d:b0:bee:d554:f332 with SMTP id a640c23a62f3a-bfe282fb76cmr579858166b.16.1781509247059;
        Mon, 15 Jun 2026 00:40:47 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b22544sm413400966b.14.2026.06.15.00.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:40:46 -0700 (PDT)
Message-ID: <9cd444b3-aeb0-46bb-a8a3-1526aa8f191a@gmail.com>
Date: Mon, 15 Jun 2026 09:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
 <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
 <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
 <e9696d4d-7cd0-4d7f-af87-2b4631549475@gmail.com>
 <CAAhV-H5psOJQey+frswdc5Q76UnhCkrHJ_jtqvxHsfmi-dskyw@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H5psOJQey+frswdc5Q76UnhCkrHJ_jtqvxHsfmi-dskyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.06.26 09:30, Huacai Chen wrote:
>> [...]
>>
>>> However, synchronize_rcu() only gets called in the
>>> IS_ENABLED(CONFIG_PREEMPT_RT) case, so I think your configuration
>>> needs PREEMPT_RT, right?
>>>
>>> You said this is the default behavior, but PREEMPT_RT is not enabled by default.
>> The condition where this is added has two parts, see [1]. While PREEMPT_RT
>> isn't active for MIPS, arch_irq_work_has_interrupt gives false for MIPS (since
>> there is no implementation and it falls back to the generic one). This then
>> also calls synchronize_rcu.
> Sorry, this is my mistake, then what's your preemption model? There
> are too many config files for MIPS now.

I'm using PREEMPT_NONE, apparently default for all targets in OpenWrt.

> Huacai
>
>>> Huacai
>>>
>> Best,
>> Jonas
>>
>> [1] https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/irq_work.c#L291-L302

Best,
Jonas
