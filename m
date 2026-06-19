Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993233AD8A
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855606; cv=none; b=Wa0bzLxg3SzgiDxwl+b6VMVkhVpzVUQtXBw+EJkRKS9vCfbkiuEUA8ldQh7j9mtSnzRetsVhzU2XmaQoz4C8qLCAaMviHl2762Geu89/a07Ta9827YUSGlGSqWHt8kSRpao51YO9MqXVq5zv2CwZmwxHx8DtHysgGu/W3Tt4joY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855606; c=relaxed/simple;
	bh=pX91VZCWjtVn5XntwhIUKqRT2u2/AIqeQRmuIFxuWiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rnt7VwG6DVAPNVmOyg+jDDSdao+k8LIrxuaGbNApHa94UV9Uu+GX0jb+pLCUlRQhvCewK/FwnWMEXuiyMqVHdkBRWtApv9a9sM9Qz2C1sF/sQ04LIVgT3s2zXKOjReQJ2CxGfhfXydNW/EDu5WJMuqCZ3x3kAcRkHLMA9qddz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8k+iVuM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8k+iVuM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4624a44e152so1485244f8f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781855604; x=1782460404; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX91VZCWjtVn5XntwhIUKqRT2u2/AIqeQRmuIFxuWiE=;
        b=R8k+iVuMXyZJm5vGGrlh3bZo6jzjJC3wWtWqxJ09b1PCkHP7qqvNxoXsSkagK+GRIi
         ncnGpDjgUvT2Mi3Eh9I9w3m1ev5BSNxmUBysWgebPPefki7xQc89qg6O7eE2zEu+UQA0
         TP/6LVa8CsCPwfEVXu0cyK3A4elozpKUIm8SOCljywKGQdELhmb9ae1gqTXPwZga5BpF
         eZZGnVkDt1bF9QbcbcXw7qJB2dNDIIsw6p2F+8M/RtPLcbN5Uq1+LznCztEyO6Rd3eqZ
         IpFClGPi9EVXLuTEemT2mIjg7gWELnoxEY2dWHnfmXv5eKG1WaX4ger001b5WHKzjsBi
         7qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781855604; x=1782460404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX91VZCWjtVn5XntwhIUKqRT2u2/AIqeQRmuIFxuWiE=;
        b=oWr7c9gpDCGiPf2W8UKKrn4f8ubi8nYXTcFA1xIJ6G8Y4F1VzAsXas+iywMCtK3pa2
         coc5FO74nIFbQ8Nzm1HxeAuLHzzBnHv4ZP9vT1kxMQuRL7MaDHgKCQthT7KXLvToiPa1
         PZ0SK1+Qv760PWamYngz+DO2/80UTl66ZlbD4JElWOsINkZ4gJDJPGQ0o7DSHZbpTkT5
         ChYd0FHhh44gPVa72tnAk81Uj+pWe4oSz6QAoyv9aj5vdOulrLs+GDeNxalkLR/Uyq2G
         1Ox/m9N1xSgPEKCLE8HgrtxVIvigqXbCmD7yr6Y52Mpk/+ZgcdlQs5ABK1REkUfY+c+E
         tF8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/6vMg42HbzLdN/ITHmRwnE1vhpruzB1VX03ZPu8jfOQXq5KjU/CAoqsfmAMhIguXxeVveqSC/GdAIRZJ8OtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxRIQ51GFA8H9BDRYaartkuMnTBgsz3qZacwcjc3grYfQ2+TWL
	8TTJfTTM0cOvCnT7KGtXxRlyUgMJJglcVD9bQhir9AbKf5W6uwNbCw+1
X-Gm-Gg: AfdE7cnMSJ9sqMK1prlDv9h3i4lNnMCTSCSjpBsdDbdUKHa1T3RlxprMarMQeCDhMRs
	/smq1CKzdy3d77Kdl+YdRhUUm4oss6iEJJpquic9egKM4p2iU5pzjAm5lrXZKJyk4dbYBj/35tq
	4cxVT2lC4ROS9nz1/4ptPvFDyg7eIP956D4T4WFQ/FJ400GRVygXRUyMuDkj/56qtRqL7wQYeaB
	1pD+fyxhKZs6lhatU3sVjZe4PYyBPvEJNuf9JRquqGcd6x/QihFSbglDzhEefdphfAsUujnSZks
	bZ3us6ygdR1EuGx8zjeCbdqHQcTtl/dkA4bS24T+7VQ9KtCRx6Xsw5zb+iT2SNeSEf7i/NxIhol
	sbFjghXxUX0AIks798VAxlc+UUxBC8AaKfkx1j8ZxZsmKazd+SZmWC+n5iyKb0G4v7UoJdb6yKO
	GSQWFYeBE9vYHVkjExO3TOWz/3wi2z61Za3fFe/Mb8MA9cFZHh3vq3RTEzre9K9NfPq8CYqVq+w
	MDB8CqmzaSodGs=
X-Received: by 2002:adf:e5d0:0:b0:460:6a8f:5d36 with SMTP id ffacd0b85a97d-465085353bfmr3214856f8f.22.1781855603755;
        Fri, 19 Jun 2026 00:53:23 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f106:a001:409c:b132:5c19:42ef? ([2001:9e8:f106:a001:409c:b132:5c19:42ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04b55sm5915595f8f.5.2026.06.19.00.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 00:53:22 -0700 (PDT)
Message-ID: <7130ff1c-7c6e-4a82-868b-7f6c60c98e7d@gmail.com>
Date: Fri, 19 Jun 2026 09:53:20 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <20260619074323.IIq-0qan@linutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260619074323.IIq-0qan@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 19.06.26 09:43, Sebastian Andrzej Siewior wrote:
> On 2026-06-08 09:37:29 [+0000], Jonas Jelonek wrote:
>> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
>> marks the CPU offline for the scheduler via set_cpu_online(false) but
>> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
>> that are now spinning forever with interrupts disabled.
> …
>> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Sorry for being late.
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> Sebastian

Thanks to both of you. The patch has been accepted and merged already
(silently) [1]. But I appreciate your reviews a lot.

Best,
Jonas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?id=9f3f3bdc6d9dac1a5a8262ee7ad0f2ff1527a7e7
