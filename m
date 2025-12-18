Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06A26FA57
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046849; cv=none; b=kTjZpx/UQ5Ey5revspOO8nFXzy6QOzsaI9dMMHM5LmT45W4ic+6Fs9uraYguhhwsNPo6iWkRJXmR99+VmK78DAZmDMfG2sbxH4MUkEnS2UnfSrDKcePpulCp5HgpXzfBZYk1heM+gU4ktWT1Ag9ShwEudCghJi3kwmB/TiIYiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046849; c=relaxed/simple;
	bh=PQEnCPkyXEiJJRG4Ll6CiTqnES116ztWogGt08zWoDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGTUtekFRi2/iLALREjanpa4dCfBFLCHZh8Ka33oLOWAQU2FDGknTcmJJMSYMWflva4zAo+SocgLrVkGu3R/2SSDF5tsfe0w527p5utPfITZN9a0HOMk2CO6Gd+pHyuQibpSQJdpd3LJHuzkAZTYFKoZfv6fH2bs/L6NOKJEc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FCDFEC;
	Thu, 18 Dec 2025 00:33:59 -0800 (PST)
Received: from [10.57.91.22] (unknown [10.57.91.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 608F33F5CA;
	Thu, 18 Dec 2025 00:34:03 -0800 (PST)
Message-ID: <72aaa252-6ee6-4353-84ee-b6e10e9920c6@arm.com>
Date: Thu, 18 Dec 2025 08:34:01 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 dev.jain@arm.com, yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
 <aUL/zJlJFRz2/Ybt@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aUL/zJlJFRz2/Ybt@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 19:09, Yeoreum Yun wrote:
> Hi Ryanc,
> 
> [...]
>>> -	if (!cpu) {
>>> -		free_pages(alloc, order);
>>> +	if (!cpu)
>>>  		arm64_use_ng_mappings = true;
>>> -	}
>>>
>>>  	return 0;
>>>  }
>>>
>>>  void __init kpti_install_ng_mappings(void)
>>>  {
>>> +	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
>>> +	u64 alloc;
>>> +
>>>  	/* Check whether KPTI is going to be used */
>>>  	if (!arm64_kernel_unmapped_at_el0())
>>>  		return;
>>> @@ -1436,8 +1434,14 @@ void __init kpti_install_ng_mappings(void)
>>>  	if (arm64_use_ng_mappings)
>>>  		return;
>>>
>>> +	alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
>>
>> I don't think this requires GFP_ATOMIC now?
>>
>> With that removed:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> I think it would be better to use only __GFP_HIGH in here since
> when kpti_install_ng_mappings() is called, "kswpd" doesn't created yet.
> and to allocate page with assurance, It would be good to use
> min_reserved to.
> 
> Am I missing something?

Personally I think we should just use "GFP_KERNEL | __GFP_ZERO". Anything else
would make this allocation look special, which it is not. If we fail to allocate
at this point in boot, we have bigger problems.

> 
> Thanks.
> 
> [...]
> 
> --
> Sincerely,
> Yeoreum Yun

