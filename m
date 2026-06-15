Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D13BBFD4
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507784; cv=none; b=jfh3qfGp/X2CYP84sis1dN5MncVtCfuf/1AIbg2te8BzRWmZSGKKLNf4cjjwOaUBzk7Ytp0FrmM/Qwlkyz6RoYXZXo7OA/oIvmHbaVia+crCQsHFZd1OVNTHeDbBloC3HHIHPqYeIrUrv+fBeuWXKEVhYQ4UoCYuCO7e/iEGWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507784; c=relaxed/simple;
	bh=pMkVa6/D2V5ktOGrf4lKmOuLSpOlfMitckdfGHfEAXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDofxGiDYFfad4HhvjOHEIhqB6nJSMsyssNjoOf0BQDMns8whw40anxFDU/NsbW5svK+o3WbpTIJoVNubUN1yYaPubrqOeWgtwhuQKqxsHXNdSqFkpLtih0zuC/m4NjsGxE308vxjKrL/QlZF52tlp0hraTq9+n7xZNIlmoY0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEkBjfJa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEkBjfJa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso13601875e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 00:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507781; x=1782112581; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMkVa6/D2V5ktOGrf4lKmOuLSpOlfMitckdfGHfEAXs=;
        b=PEkBjfJa8PQxYxudgEPithObw/gQzj/+ZT1FfkuCtnB+jxJ4pneG0CegmHKsKsrJjj
         R4/QEqi6h9oLr2o/1qoHWG/AoJm16K9orI0uwNvpe2ad70g2hSrz85QPPcc1K0LjJp9u
         vWj5CD6Wil0R6oySGqm1TkIcHeJJV2iyOfXLk/NpgVoSX+0bBO1t86Yno+shKAnImdwu
         xrMczDN2ugwwTQZLIl5gQjpq2HfqgDUDab3HcmHsvphkC0JQA0Rl5SaV7an9QYXNPKp4
         Tv7/IaSYQS8P22Bat9+u9nvfB+0cRDQNHMJ4HiXQMYirOeMl8MAFKU/wdcAWj9Gr8Ou2
         tUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507781; x=1782112581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMkVa6/D2V5ktOGrf4lKmOuLSpOlfMitckdfGHfEAXs=;
        b=dfoNv4nbCn0OURA8gIMLdV+vylI34VhbGWuKioLjyUcZ4C9SCfR1xlJAprB2upv2iZ
         zo+fguwLBc1MibG8hsKzGMpQ37eRhGo60KV32QSCBss3CTJySsikFRq52LyWkiozV7uN
         iycQXzZOdnOLsYPfGSDT+wNT3obyyFzsfvMJO6/Tq7cfZS1hx1zBVMp4FsXP4eBJ1NrU
         6Tf3NDekeoyeiy0YuOYfL6k5DcCOruVMRIZwxSOp9/3ovo1VR6YyU+PXt2vpJaDBRjQQ
         Bcpc4JMtReEYtR2ZKPjanyidXllNxIpBHQ0F4O72YULNikuKTidMdbgj0VP9zTTotjOW
         gvXw==
X-Forwarded-Encrypted: i=1; AFNElJ/1ie0seiiHzT4FQ18QM1rEuJYP54zGU0Ydg2/Y0m29PN7/Nz4n4ONWV/w7Fw8l23HdNv2BmjbV6+C6/Fnn7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpVYfst2oR3/9ngWQUX5EvbjXUPipx1Pf+ijxfXOg2lDH2v+Zy
	JRMr9C2aFlbPggULm+rOrZvRvDJg64mjh8rpzmrwHfp3VuJrRTk00W0x
X-Gm-Gg: Acq92OHV0iFEYfmv+tQ6ZIToccGIh+tQeBWRsWrhDTsCMu23ySAXcwsoD+gEMppXqBg
	AzBbQbKLcazBGP77KIh9TtyqoH0imLA3VHwVDNRs8hm9Sh5fSdpbOO4ifdH0LC77r+BkXNXBIli
	0Ip3hT/0K9j30YZgZ1m1gyJg1+b3PSJEpnFhGB0ZZ96WI8QQNn/D3iJKK5XfGy2ZNKHhfgAIyEg
	Cvc3l0DQc0QGr0QJmlJuQRznLPIYlNXGhVnyl+De08TjHXixlD3O375R0wXvEiiAYDgmK+RSFov
	waWH1K0SM8Ktgp4EqFqnM/y2LVwMyo9xffontqt1mUKrkAIaCsXP1sQHVJmP4Ce0KWWwTU+BnHP
	LRwK3PvPtZqIMkbc+a3I2Gxhw7fZZgfLvFvcRtQtsd+AnLv6Fpbb8fLxFqUrjQ9czN3F83WEZvC
	rebELgdgDmCy7FPv6P4WunoPQWl4S0IEfa5fbw1WmrtVkIHLAC5/1eB/K1QN50pLyiyGZknzcLX
	O4nWNOO+HJF4Vt2M183DoH0aMyHZX/Cog6M
X-Received: by 2002:a05:600d:8653:20b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-490ec4a2984mr118495565e9.3.1781507780666;
        Mon, 15 Jun 2026 00:16:20 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922031b21dsm219645595e9.6.2026.06.15.00.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:16:20 -0700 (PDT)
Message-ID: <e9696d4d-7cd0-4d7f-af87-2b4631549475@gmail.com>
Date: Mon, 15 Jun 2026 09:16:19 +0200
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
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Huacai,

On 15.06.26 09:09, Huacai Chen wrote:
> On Mon, Jun 15, 2026 at 3:00 PM Jonas Jelonek <jelonek.jonas@gmail.com> wrote:
>> Hi Huacai,
>>
>> sorry for the reply delay.
>>
>> On 10.06.26 08:05, Huacai Chen wrote:
>>> [...]
>>> In theory LoongArch has the same problem, but I cannot reproduce,
>>> should I enable PREEMPT_RT? Or there are some special configurations?
>> Sadly I cannot help with that. For MIPS, this seems to be the default
>> behavior.
> This patch fixes 91840be8f710, and 91840be8f710 adds synchronize_rcu()
> in irq_work_sync(). Your problem is caused by this synchronize_rcu(),
> right?

Yes it is.

> However, synchronize_rcu() only gets called in the
> IS_ENABLED(CONFIG_PREEMPT_RT) case, so I think your configuration
> needs PREEMPT_RT, right?
>
> You said this is the default behavior, but PREEMPT_RT is not enabled by default.

The condition where this is added has two parts, see [1]. While PREEMPT_RT
isn't active for MIPS, arch_irq_work_has_interrupt gives false for MIPS (since
there is no implementation and it falls back to the generic one). This then
also calls synchronize_rcu.

> Huacai
>

Best,
Jonas

[1] https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/irq_work.c#L291-L302
