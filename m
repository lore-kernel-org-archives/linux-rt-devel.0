Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6725A357;
	Tue, 26 May 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803716; cv=none; b=O2Ar0XQLXxLXw1EU7eb6IzxA0boXx9kL6CzdW11WrznOLjCdF+4YqviFhnx7kEWhYxdeBRPhfouXHra+dCMoDRWE4C7lnnmY2bOcR1fnJfpfmtssOyYgdksj56X1QJTERh47QmqnoM6XladZz7jPzvTjTHsFSRH+bbSPiO+Uqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803716; c=relaxed/simple;
	bh=D4ON1k11ZwSHqI9DTnyZ1p6KH5TDaAc4b8yPb1UFCd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHcjf3+2SsHR7JhB4pkeVmTabSKcKCdVhouL4mXAVIbbbaP0SI+a29q6URxwwnqA4a0ZKH6PcL4XMQkdWngIYggpjYxZDpBJEfBO6bTYl+0IUmJe2kIyIS/qvde8dhDHW72vX8D6tRZkT1ZKtQ4tCa9RxFNRsDtcemmcSwvywmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An1vJ5FK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An1vJ5FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2265A1F000E9;
	Tue, 26 May 2026 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803715;
	bh=TOZga64l4+qEI0ExolVv1Na0jB0MzxUaNAe9iBNorjE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=An1vJ5FKeLsmfAD5GsMF3Z1DGYPftLx702IeF3mDxSfjO7o+ThuhicLgk51gET/2n
	 m0hgHMmcjFUh27X2n/yhXO8JK7CyvjnGNDgPGwbKNf2qz3kushFkfmZJp+h+DJ8x3H
	 i4lgzUz3fg1vJ26Icd1Naiz9sxry0wHmRx03wVDcqLdpsteWuSms45vFlbQoVR7SAU
	 v6Yw4NzeDxNXkxlwqp4JmQbARFmbFq++EHRnlRSt0twEgbTHQ2995HNlWauY1PS6/m
	 YCyv0BY5QXI7f+Ete1wlB2R4FJF+SzdYJHIVjefIiOopVzgmKHZ/SWURG093Jguiog
	 MoJqPSkx+uHsA==
Message-ID: <16b36b01-7da2-4ec4-aefa-f06216ec218a@kernel.org>
Date: Tue, 26 May 2026 15:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
To: Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
References: <20260520204628.933654-1-longman@redhat.com>
 <ahQLVgj8zV4xQRh9@tiehlicka>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <ahQLVgj8zV4xQRh9@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/26 10:41 AM, Michal Hocko wrote:
> On Wed 20-05-26 16:46:27, Waiman Long wrote:
>> The GFP_ATOMIC flag is to be used in atomic context where user cannot
>> sleep and need the allocation to succeed. However, it does not support
>> contexts where preemption or interrupt is disabled under PREEMPT_RT
>> like raw_spin_lock_irqsave() or plain preempt_disable().
>>
>> With the advance of the ALLOC_TRYLOCK allocation flag in the v7.1
>> kernel, it is possible to allocate memory under such contexts by using
>> spin_trylock to acquire the spinlock in the memory allocation path. This
>> does increase the chance that the allocation can fail due to the presence
>> of concurrent memory allocation requests. So its users must be able to
>> handle such memory allocation failure gracefully.
>>
>> The ALLOC_TRYLOCK flag will only be enabled if none of the
>> ___GFP_DIRECT_RECLAIM and ___GFP_KSWAPD_RECLAIM flags are set.
>>
>> Introduce a new GFP_ATOMIC_RT gfp flag for those PREEMPT_RT
>> atomic contexts.  This new flag will fall back to GFP_ATOMIC in
>> non-PREEMPT_RT kernel. GFP_ATOMIC can continue to be used in contexts
>> where preemption and interrupt are not disabled in PREEMPT_RT kernel
>> like spin_lock_irqsave().
> 
> Before we go this way we need to really be clear we do want to support
> raw_spinlock (aka RT) contexts. This is a big commitment because it
> dictates internal allocator locking that would have potentially a much
> bigger impact long term. I would go this way only after/when we conclude
> there is absolutely no other way and we need to have allocator in those
> critical sections. Now you have a single place which complains ATM

We already have alloc_pages_nolock() which uses ALLOC_TRYLOCK internally
for these limited contexts. So the support and commitment exist. This
just exposes it via a new gfp flag alias. But if there's a single user
and it's already disputed, we don't have to expose it that way indeed.

> without much of an explanation why this cannot be really handled in
> other way. Have you even considered any options to pull the allocation
> from within the raw spin lock section?



