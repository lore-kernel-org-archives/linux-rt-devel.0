Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD641F7E9
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599931; cv=none; b=G6z+7EUN2UqTfuS6NoUcjblgeVqS1Dj20n6BH3dDPRBz8laaGzzt8Qb+lf8N+KjVQbbzdsTo5h129E5+G2lId4nJPZIuU1RNU6vTtOTUR593fhDNGu09OHcqKdjn9xlU8AghfH1me2o9G7xAkti0k3rml8LTU4mmzFAeZbFNoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599931; c=relaxed/simple;
	bh=2f84/nJZ2VgJabR+1a6ihDF3698u7R6LbS1dCMgWNUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6oxDQ76ZHPMCHnGKWZ5dv70ETTWmZj3/I8khb+4EsZDe5S0L0NpcAWbnnQUqfPgvActFY/Po3rGFIW/8Mn8VBMQ6aX73e4e+xjWygZGG4Grus4WCJOBwzMvHIMZRSI1rcKUvL/HTr7E9lGwpoCwL2FjBAgJaf18YLtX74bwa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGLVmEbl; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGLVmEbl"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cad1448ddcso15053675ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783599930; x=1784204730; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DjINX5M4wTaoTW4+GDvLh6TXbZ20xVVmAICykKIells=;
        b=MGLVmEblSZqJZJAh6rdyaJ1EqeTZTi4n+Gn2WLgErDprAGp9Zwk+Xm0eTLCITnczWR
         M06cFx3HFgv9x12SVsmwhhnV2aB93ZAj1Gt/FFe5BuY6wOHoYv8G4uKQjrx+fAxuBKgL
         QqtVlIbys+CPlvP8nMundc2qerRoehTNHAXsOp3jjxiUjw/T8vhf1eF/PdMwDrZnIirY
         q78tbcGfess9YeMb3kC1KyAEvmGoY7smmHY4Cm8CduiP3xm2Qq3Z6NabCfFckrvdC1Mu
         aW8/+85qwx9RW5vz2NxTwaSghLGQV8EZkonGp8jxuo5AAjZ/YiZr/mdFb9J3NE/5I/JP
         hMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783599930; x=1784204730;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjINX5M4wTaoTW4+GDvLh6TXbZ20xVVmAICykKIells=;
        b=iJlZIpnlbWJBcIbzsK3k80zMrnZPy/CRMON7DT9byurRGZEhyS3Iv+tI2yJduiIfQd
         0lInvgLazkHowWZW2LGjB3WTBS1LIX4tsgNrbOyuoBFfw1BqqacfsyV8X/Lltg/6VOsE
         fqqPrby142MJQgV0P9TJPfqA+nuVN0DWft4koK0wctySOTmdq9Nj/CjyQ5B2oCFx6IS2
         s0MgAc/peQPDan71zw8N24RIhXZKwrB+WjRM5y87ZZiS5jgRylhHbhkVHci4/TPj7mYC
         hhGBz2U5lr5RJP/yduCIFL0/N9Z0u2lVApsUFEAzn1jDXJBw0O+l+kjNbm+jI4OtLDpZ
         QSwg==
X-Forwarded-Encrypted: i=1; AHgh+RoKpeVQdmxRz3H18lUKTinPmDS9OFuK6l+hNDs/IEgzY6oZURf6RE7i4P6PPN0ws07Hlc2PAKoCCjT/2PVYcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZi5Gv37maMD0b4Tb2amQw9FO74DMwfm15G+WQqHP/e2a7UWs8
	M1+7BO7c18lvZp4/a0VDyK3+EnTZq1KVuqzToZzLJhcT0af2IcWrMzur
X-Gm-Gg: AfdE7ckJF5vmNhatsm2pImtoVPDAQ6WjRRKtdZdQe4NOPEJlx/dBTFD034OtVnMw5o0
	Qltdg1kye5w62vSRN/6e07fQLysL1illwsNi17A12LK66UNFdD7sefk8DRL8Ey82ixJ0KCLmO52
	a67LCTnsUJlwW7LmwJKiw5Q1p0/DahrGz1j3qYKtqbGgRsX41OtJIdfWuz1ln/JSYzMLFmMzvsJ
	Gb780AGMCUf4j7cBuBlc3Joko7V8N+F9Fj8RPH4CJ5mbRYr9BSyvzT9Ljwbh6/7rRCcJWnYqq+7
	QeG7KDAuHBmU27VUoUi/7EfYVHSz/BmpWVtlOMpoHb3NKDiS6aCUFVtVYhwppEfa+JpH/8sj62h
	W3EXLq9edwUwoiSEyZ5LyL9xOI5ZXneHwVwShbQpCe0a6pSur0ULS0cKB8VNO0XkTq1zs1mthQ6
	rwyWTmRXOJHv/CB4l1osIKL+wAdLMOlqI=
X-Received: by 2002:a17:903:1b0d:b0:2c9:97a7:3289 with SMTP id d9443c01a7336-2ccea47c30cmr71676685ad.43.1783599929924;
        Thu, 09 Jul 2026 05:25:29 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e1aesm44089605ad.39.2026.07.09.05.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 05:25:28 -0700 (PDT)
Message-ID: <6f2e6fe2-c8c0-450c-bedb-8b4fd68839ab@gmail.com>
Date: Thu, 9 Jul 2026 20:25:11 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, riel@surriel.com,
 liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com> <ak0OZKzapUefmA3v@lucifer>
 <20260709091316.TFgtBZlE@linutronix.de>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260709091316.TFgtBZlE@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 17:13, Sebastian Andrzej Siewior wrote:
> On 2026-07-07 15:54:57 [+0100], Lorenzo Stoakes wrote:
>> On Tue, Jul 07, 2026 at 08:59:25PM +0800, Wandun Chen wrote:
>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>
>>> The region covered by mlock[all] may contain CMA pages. cma_alloc installs
>>> migration entries in the page table, if a memory access occurs at this
>>> point, it must wait for the migration to complete, which may cause
>>> latency spikes on the RT kernels.
>>>
>>> Try to move the migration cost into the mlock[all] caller, which is
>>> typically a setup path. So reduce the chance of latency spikes on RT
>>> kernels by migrating the currently mapped CMA pages out of CMA region.
>>
>> 'reduce the chances of latency' so do you have any data to back this invasive
>> change or not?
> 
> The application gets pages assigned which belong a CMA area. If the
> pages are in need by the CMA then those pages are replaced with other
> pages during a migration phase. Since there is no guarantee how long
> this will take and is also subject to general scheduling in the system
> it will be measurable and painful once hit.
> 
>> And for RT, but nothing in here at all checks for RT? You're using this
>> compaction sysctl as an RT check somehow? That's gross.
> 
> The man-page for mlock says that it guarantees to stay in RAM and/ or
> preventing to be moved to swap area. I would however argue that
> replacing physical pages in the background should fall under this since
> the application can't access them and is blocked while trying. The notes
> section (in the man-page) lists "real-time applications" and
> "deterministic timing".  Therefore I think it makes sense to do this
> unconditionally for mlock areas regardless of the sysctl knob.
> Security related application probably only care that their memory does
> not hit the swap area and probably wouldn't mind 10ms delay.

Thanks for helping to explain, that helps a lot, Sebastian.
Wandun
> 
>> This doesn't feel like the right solution.
> 
> Sebastian

