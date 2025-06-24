Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D15280CC8
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765050; cv=none; b=HharOKl0FOMWQuSYVP0JL0YtanJkjkZ4bqGPs1LyHPZpas31KNXFD2LmweEuaP/7nOmhjjp29MzW2nfP4HQJ5q/tzH+Tv77JGs4lYMVHfBzhy1vkE33gCDWuxnkHD9KqvFuayo6BGAOVBc46q/7yu5GHS2E2bdA3ZjLMXym2A6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765050; c=relaxed/simple;
	bh=xiCQ0j/wFlDxcAPPdnkKi8/i3QKVab07KRrRPwVR3jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZhpgLm6EQvIibKwYFzAk+w7Z2zx34/y/HctxgSNR43Z3biF9hZJs0w4NUmsc0qV198M6BEfBQPJQYtRmQA/vXkJWjIT5fZHCD5yYK1o24t7TnhQCwXbKrWNKoYKIHoUjGa9VpWKfgScRQ1dEKxPMCIW9j6GFyu8kYYA5CVEStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T1qPk4tn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T1qPk4tn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso4234798b3a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750765045; x=1751369845; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1BS57X/WG0jVySO8QMdoFZrcIzR1oh7Qce1t6ebg7Q=;
        b=T1qPk4tnqlvGkM41orfOJx61h8w5i0jKJQe8f3KXjPDjW+UsodngP6LOyBgv2STMSq
         UffxIW3CMqZFqNuTh03QSJQs1gbeDbxht/pkZr6ibPvM4kqfwfCshbVE9OG1QgzYfsyO
         ebb/PcG7o5T5nY+TE+SiRDpfyfFLUcy8GAppeHqRZPTz/63AoURpw/spTxQxZXL+EVQz
         PLE/uwSehwylafZT+YXP9Hzk3Jy37YFMkoepE89iDGSqgBWY9mZQChnpDlGV3H6ALL7O
         Xj8QuvbiFtJhWEWr6yoWpUgE0nCkEayUUhI3a8YP941zhGZPj7azq2suMdX5DCH5za6k
         AAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750765045; x=1751369845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1BS57X/WG0jVySO8QMdoFZrcIzR1oh7Qce1t6ebg7Q=;
        b=uB+ZZKPA0wY66QkiRCFvl/j0jpfUzajrz960d7rlkHlCaSj6OeMb56MTUt1tKPg2Ax
         1gUSixj+v+JGaEBb0O3NcmyZ+v2Eo8PaNHLmWg+NnqrJ+CcQ1S0ZRE/ZiWuQ+uVu4KrK
         hkF+yyG67lhSBgn0f/S5ZslxPXz1dOz0dg4fAg9Bpidc6/WFz3QnEif0DWHFjY8yWsBp
         lEGDUxAbAl0PjJmCVt/T6vz//cUg96/BHGViZn+J+nBtZK1+7GQtA+DGiKSZJCvDJVvc
         ZIZmvUNRkgEB45kSVZUrHMmClbmOJdGO7+wVEo9nX5L4PxDnyY6dXftGSM9SkuMIkFsZ
         J8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUAERZtwTm+V978UzewjY+eo92IDAIb6wv6IMUlKAOYay60xoXk0lAPGwYUpr+uU6BRQ3gT2g//m3riJCdMVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGLSBORm4FIzOtH+Dp8nWlcNRz2M6XVCqkW9JzNnp6lPjerr28
	cXk/UnJzOId2VKmNaWfph3Z9OjAcKFRh8fIs0is9hoUfBiyE5Fj7H8747eeMdz16ipc=
X-Gm-Gg: ASbGncvGkPI3JvfdbAv8BYsZqhNCO9Nbh/znn57mJz27O44fdpOyr/eoFpZ9MgUXhEI
	zqyITB0gXnPP4dLzmpHw6BcHAFad/ICPLD+aip5JFvnuRPZpgp7Cgbh2W7/BWmHmGp0luSni5cr
	GTQilIXeZDpBJCdt6csC+NqGUqD7BfhCAiv5JRM6fbWRu68zc5Z+gmuoiQmz7pMvE+OJcEMPtu1
	EOlDF7YJNAEfiu1Sy5dJSXX0QqRQSrAf2GufhM+Jo4rxtlwca9g86/2JSDk6t8RHhCqayFj9fPI
	O29ZI86V93fXot+eRAw/HQjPiIuhQL2Bqr9w0GG5lhO4CJEU/NCefpqrzXathAzkcph5La9Lncw
	5iVfhtqxVywaxOJSGiTp5kwfOvgtgMDQ=
X-Google-Smtp-Source: AGHT+IFNZ2hsCqwSWuixPSJ5R8AD8UK1jdLvj9vYQYk6LtP/Xb8JEeiD65LE64qqMpZvResIz21jAw==
X-Received: by 2002:a05:6a00:140f:b0:742:a111:ee6f with SMTP id d2e1a72fcca58-7490d6dc413mr17698045b3a.10.1750765044971;
        Tue, 24 Jun 2025 04:37:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8871954sm1651063b3a.149.2025.06.24.04.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:37:24 -0700 (PDT)
Message-ID: <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
Date: Tue, 24 Jun 2025 13:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: namcao@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/06/2025 04:09, Maciej W. Rozycki wrote:
> On Mon, 23 Jun 2025, Palmer Dabbelt wrote:
> 
>> I'm kind of split on a Fixes tag here.  One could argue it's a regression, as
>> having interrupts disabled during exceptions is going to cause all sorts of
>> performance issues for users.  Seems a bit risk to just backport, though...
>>
>> That said, if nobody noticed then it's probably a good sign nobody is really
>> paying attention and we should just backport it before anyone notices...
> 
>  Oh, someone did notice and it's not only performance, cf. 
> <https://lore.kernel.org/r/alpine.DEB.2.21.2501070143250.18889@angie.orcam.me.uk/>.

I also had a series which was doing so for misaligned accesses handling,
but after discussion, it was not ok to do so.:

https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/

So this series should probably be modified to only reenable interrupts
when explicitly needed, ie page faults and for force_sig_fault().

Thanks,

Clément

> 
>   Maciej
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

