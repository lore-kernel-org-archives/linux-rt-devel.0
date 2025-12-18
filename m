Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8128371;
	Thu, 18 Dec 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047577; cv=none; b=l1gzk9dJRkKoLCeABU6Ez6dM2UZqc0SoOtPO03BQhSS3J001pssyyOCJ5iTpAlTMF9zFhhxyENabXStCCIxVKqWwm8t/692Ummobl90IiWMfBGajKLJcZK8V8zDw2CW52priDI4e1ROQJTG3E1di1kX6HmPUtC96yWULNZV2cYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047577; c=relaxed/simple;
	bh=UNiqzBeSI2nfMbOFOdv2ipLYyeTA+tVV2F6tqqzV0DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZEfxzP4OEB69Fi8ElGyk+OptoKsollTRd/JKjDOnduNUKGLBRIGei3ELx+CxAppw5RWyC6lPkiqmvYFmyPFt9i4QoWULwKSF147MezMo+di5A90jMDPLxRWWgSe0NScDYjekzHQAfkq9a0/stMpjqhtlFLiO2jvwkmHQurbgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd6Eedr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd6Eedr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE86EC4CEFB;
	Thu, 18 Dec 2025 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766047577;
	bh=UNiqzBeSI2nfMbOFOdv2ipLYyeTA+tVV2F6tqqzV0DQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xd6Eedr4NTO1heTOZE9cI8yjjcd70DffYIFpvBE80ALbriM1qqCQSbY3inTwc8sKw
	 XPwv3tIm3QAoVloPLZyvJJVrRHQLzIehb9emMiI9/JZQ9YmMfqkTrpgRLGkQeXy44l
	 XUk1OsgjkUJ5DFjZt2Gi8s/ZVh2ETcPs7XW08g9eZXA7eeif7raLI9hxF+yn4Nv576
	 LfOP8Gh4oYhYmdjMswqq7IXw42waNsBGy7vS8EuRXa834kfZ3nFFrdGOe44HYvfknz
	 z+1LLQA4OL1+o9I6+uC+EVJHiGvsOdO2yE/zoao+3acy06Sk/UeUwJoNMNyAaUrxtE
	 d3/McnCb0Hlrw==
Message-ID: <201d0fa3-2ebe-4df2-926c-9e11607a6f07@kernel.org>
Date: Thu, 18 Dec 2025 09:46:10 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
To: Yeoreum Yun <yeoreum.yun@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
 <aUL/zJlJFRz2/Ybt@e129823.arm.com>
 <72aaa252-6ee6-4353-84ee-b6e10e9920c6@arm.com>
 <aUO9M/oN+nx3nfW+@e129823.arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aUO9M/oN+nx3nfW+@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 09:37, Yeoreum Yun wrote:
> [...]
>>> I think it would be better to use only __GFP_HIGH in here since
>>> when kpti_install_ng_mappings() is called, "kswpd" doesn't created yet.
>>> and to allocate page with assurance, It would be good to use
>>> min_reserved to.
>>>
>>> Am I missing something?
>>
>> Personally I think we should just use "GFP_KERNEL | __GFP_ZERO". Anything else
>> would make this allocation look special, which it is not. If we fail to allocate
>> at this point in boot, we have bigger problems.
> 
> But I'm not sure *HOW effective* to use GFP_KERNEL in here.
> Since it's before the any filesystem inited.
> IOW, in this context, almost there would be no *page cache*
> and I think it seems meaningless to use "GFP_KERNEL" and "direct
> reclaim"
> 
> So to get success for allocation, __GFP_HIGH | _GFP_ZERO seems much
> better.

Unless there is a real reason to confuse readers why this is very 
special, just go with "GFP_KERNEL | __GFP_ZERO", really.

In particular if it doesn't matter in practice? Or does it and we are 
not getting your point?

-- 
Cheers

David
