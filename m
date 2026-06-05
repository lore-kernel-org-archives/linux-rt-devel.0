Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D416F27F
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657964; cv=none; b=PajKTkCLHiSXsDIbFDHFHz3YjJ6UNBlAB+X5BiZChGXE0vJfW9i6QDs37k8oC7B/7T7cRtTeosThw+LBPrYDCymoGs9KDRImgBuag8iy6Zw90uehhnZKF4BRyRHrdrC8ZBEMnu9be4CrWpHLp+1XQFDY2MGDuim56vVluiPZ4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657964; c=relaxed/simple;
	bh=lmSjoIiFcS96WgGAMtkcg3q8ByAWa6wPJJAcgkb4idk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Arh3cyIKvFde0JJ/PFa8Rd7TRXjnL1StjUo54rJd0LH7pLEqr2SYRi3FfMJ3n/Hf7uk7lL9WAxvLsX4pHhV+9L999ga2hrgssuTSNikfHg1hWv6ejEpq1pbzC5j23N8dK3eyYbDvKT4itYg83FmrQaQNWosYa2GSeFO5Bverlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuEOYFns; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuEOYFns"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so14381015e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 05 Jun 2026 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780657960; x=1781262760; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XYJSNlNXjYunXNkaUPBK0YBkQKXFISip6sCHWbKA7U=;
        b=iuEOYFnsFHJ42hGfzLMNMm0SAXoF9K94B+FvtlhfwaSek1adEaK5uXpmaYGCg17ocK
         EXscGAD3cwuh1Usjq2RmFqrLxRXvLevNW2BL8FU2dUYLbM99OPspRzQw0lQD6rCZY5Rg
         vQg/oG5yiasGMcI+D47lWlSi/2ugVXVYc88lkhaIiwvK086CpUBpyb8ol9UTAJrKtS/t
         SdpSGoMQMbkbz3Q0Exn1z8tnTDqr6e6ob3htUx0n+rKnUiLMCokOkXWnogKl/5ozr7tN
         v0p48ItG0QQZ2fEUgY1+w4S9RzM9QLZ0tmmBCwn+bn7KRHVp8u3bajPG1wj2Tvt3Wj5H
         WnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780657960; x=1781262760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XYJSNlNXjYunXNkaUPBK0YBkQKXFISip6sCHWbKA7U=;
        b=Sp0iJW+DK9/1Y3DYmggdI5y3E0XyDRqhDPXr+v4+o3C04gjwPzKe0SX29l2mNeSlO9
         kKf/eRzBRrAWJlNckn6t0hoYzT45a9bSi6di2tDfzSxSpxoSezJSRlafIVhEt6B0IoLJ
         HXlMGMMdkIE/Ty9ZcUZ186r2hJ9YETv/CehHcwA/+azwkZPJ0Mi5UZINALBqEJs425YK
         7JdKYQKLdTteHME1ENE4K8DO5GFBH2slC4jxpWQOQmvZZrMqe+j2dlfsjbbu2CCLXSU3
         pU8iHptT/YGpz94WhVCkEbq/FyOBBTYVjXdWjljCCEtn/hcAillhs2MhgqwtgmWGRGWD
         ohqw==
X-Forwarded-Encrypted: i=1; AFNElJ/0xb4Zxi9P6akFqtiBfSkep7OGHhJinIeHR+C4ZVY8B4CuNSv+sd7R3thL0yNuGri8pm/mXE8zGspdwGh6bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcsL+36QgQDwH3jIv3+26+wrMQsRT7i+Luqt8Q7DRSorfHVnsw
	niEVBH3QGyA7kkT5GczGaSVcgMrQBSXIhLnmK+YkosuUNmw+uzVmXE8bVWtW3Q==
X-Gm-Gg: Acq92OHtYVOEJybGAb6O8rfZIHU5IzDfrgKopC+ateq/ZXBVZZNUxPjTT7lmyMzksMb
	QUbevHu2ik7OS05USFGNMPiPJIgjENr3uhofaN9Dc5abKKgDUXbQNARg6Q+d3CeAa8G+/o5H+jI
	8p5UkgWdnrTZC3R856wwTN1nlqiYpNCdP+/h0pdaqZZaGP0OP+9gWNOVfyATkKFTG9G8sy1qSeE
	V+HBueuX9YpWe1g7D3gS2Rgk4uz3kZnYxzE8Q2LA3Xa2Wa4pYZDjzCko4yJWMvR4SjsDGojpdMl
	m+wL05yATqINILmqvvL5Ivw9OHU+OsjPGMcUF/ZdUzCfMfuoEs7qotx7m4WfzvuEWWqxDjR5QAD
	dst8hQINReh5pqwo7bgKyIo/9XeYk7Z8Am8LdUL+H4YbuqymdbZeUn8PCsvKp9tSg6f1Rv3VEdB
	0EWp0ssIvRid7ZTDK7f7h7lsO8mjrh+uTDXOGc1T+n7Hg6QW3aw8zvdYJGDtzKz0FffvcwWoAc3
	ir4SjrNEU7IxSwulw==
X-Received: by 2002:a05:600c:674f:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490c25e2dc6mr46150295e9.20.1780657959652;
        Fri, 05 Jun 2026 04:12:39 -0700 (PDT)
Received: from [192.168.255.3] (211-11-142-46.pool.kielnet.net. [46.142.11.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm138026905e9.10.2026.06.05.04.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 04:12:39 -0700 (PDT)
Message-ID: <153b976e-ce36-44fe-899a-01fc5877e573@gmail.com>
Date: Fri, 5 Jun 2026 13:12:38 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
 <20260605064250.q0aRKkon@linutronix.de>
 <02b1e77e-5b7e-41cb-95b6-731ed00d9e74@gmail.com>
 <20260605103418.tH3rlwmO@linutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260605103418.tH3rlwmO@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 05.06.26 12:34, Sebastian Andrzej Siewior wrote:
> Does 
> 	echo 0 > /sys/devices/system/cpu/cpu1/online
>
> lead to the same problem?

Funny, my device doesn't have this 'online' file, neither for the
other CPUs. So it seems this CPU hotplug isn't supported/used here?
Or am I missing a Kconfig option for that?

I'm working on a Realtek RTL931x SoC here, it has MIPS interAptiv
cores. I can provide more information if needed.

> I missed that arm64 has also this but only if the online path fails kind
> of early, see
> 	04e613ded8c26 ("arm64: smp: Tell RCU about CPUs that fail to come online")
>
> so this not the "normal" case but an exception. Mips seems to be doing
> something different here. I am not sure if this is the only thing that
> is missing.
>
>> Best,
>> Jonas
> Sebastian

Best,
Jonas
