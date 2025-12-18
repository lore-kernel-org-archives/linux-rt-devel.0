Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C12DF3F2;
	Thu, 18 Dec 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050870; cv=none; b=YT8xS6SPtS7Nhn9P/VhR652MxzOoj2YXiLr9ShHUYZD7q9gtOWiXvQUQc8Jb/VEqvf0o95qBdUVI+Tj1jMyJZb1iWC90BN6CHXdkz9oqh/gOCjWASwRHizOo5umznveIvMNtWgWzjqBIok6TPVfr2xDMrf5Q3xLhou4C8Hv1bA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050870; c=relaxed/simple;
	bh=if8nrAy6nAbxo+OGx9VOp5NtyXp5P5yHGxKfTzzPn9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypf8HLWHSB9W5F7j8S5/IYhT5xsnyZlAi85zTeCVEwX1kEbK88mF8HsVnwQs+htq/iOWSphFN93cL1yxlyJ2caR5MhWOlP7RFjsSBC0HVX9BrOSdJPpWnlJKhBIzuNA0CabxkhMXsNy/fjMBHu8jofbNlmUz2Ikuif8X5b+Vjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTUGkN15; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTUGkN15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC698C113D0;
	Thu, 18 Dec 2025 09:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050869;
	bh=if8nrAy6nAbxo+OGx9VOp5NtyXp5P5yHGxKfTzzPn9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sTUGkN15hVBQGspVE7YdvHrKYR2//dG4FG+d8ncVQOEZlQ0gGYhRA3Ryzv7zZCB/p
	 nmhPE46v++wHIj2GIeVlCDEXSOMs5n6wmarzRS4nRlkOnD3M7qZMhvg+ZIlxYD+Pv+
	 y7uQKokQOtipCIo8tuTUTS6U5JYnmHXHVp4ODgqlVAzEE2E9STn4JiRdyTETSRAKhP
	 Dg+T9oaNLX4nIGdFhW80KMwB2cYP40+p2swGxya1AcvUhpkfp8ulDvtD2DoCTFcsn7
	 a0znI2GepBj5u/LsCRO3MtOIgQ35fPyHhJJOzDMPQV5Iq9FxWNqTSlbDUknAmYqwuR
	 6jc5cxTzXofhw==
Message-ID: <10ad7480-4e8a-43c1-9e18-db72e63dbe98@kernel.org>
Date: Thu, 18 Dec 2025 10:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, dev.jain@arm.com, yang@os.amperecomputing.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
 <aUL/zJlJFRz2/Ybt@e129823.arm.com>
 <72aaa252-6ee6-4353-84ee-b6e10e9920c6@arm.com>
 <aUO9M/oN+nx3nfW+@e129823.arm.com>
 <201d0fa3-2ebe-4df2-926c-9e11607a6f07@kernel.org>
 <aUPJ1N99LEVZ77co@e129823.arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUPJ1N99LEVZ77co@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 10:31, Yeoreum Yun wrote:
> Hi David,
> 
>> On 12/18/25 09:37, Yeoreum Yun wrote:
>>> [...]
>>>>> I think it would be better to use only __GFP_HIGH in here since
>>>>> when kpti_install_ng_mappings() is called, "kswpd" doesn't created yet.
>>>>> and to allocate page with assurance, It would be good to use
>>>>> min_reserved to.
>>>>>
>>>>> Am I missing something?
>>>>
>>>> Personally I think we should just use "GFP_KERNEL | __GFP_ZERO". Anything else
>>>> would make this allocation look special, which it is not. If we fail to allocate
>>>> at this point in boot, we have bigger problems.
>>>
>>> But I'm not sure *HOW effective* to use GFP_KERNEL in here.
>>> Since it's before the any filesystem inited.
>>> IOW, in this context, almost there would be no *page cache*
>>> and I think it seems meaningless to use "GFP_KERNEL" and "direct
>>> reclaim"
>>>
>>> So to get success for allocation, __GFP_HIGH | _GFP_ZERO seems much
>>> better.
>>
>> Unless there is a real reason to confuse readers why this is very special,
>> just go with "GFP_KERNEL | __GFP_ZERO", really.
>>
>> In particular if it doesn't matter in practice? Or does it and we are not
>> getting your point?
> 
> My worries was
>      - kpti_install_ng_mappings() is called while in "smp_init()" which is
>        before creating the kswapd thread via module_init().
>        Just wondered whether it allows to call wakeup_kswapd() before
>        kswapd is created.

The buddy should really be able to deal with that, no?

> 
>      - Similar reason kcompactd too.

Same as well.

We cannot expect alloc API users to know about these hidden details to 
work around them :)

> 
>      - Just wonder how much direct reclaim is effecitve since
>        when kpti_install_ng_mappings() called before each
>        filesystem initialised where not much of page cache in usage.

Right, but do you really think we would ever trigger that path?

The default should always be GFP_KERNEL unless we have for very good 
reason special demands.

So, do you think in practice there is real value in NOT using GFP_KERNEL? :)

-- 
Cheers

David
