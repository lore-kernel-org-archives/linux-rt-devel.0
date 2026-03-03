Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC24D90B2;
	Tue,  3 Mar 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554925; cv=none; b=fx+WyhAgb14gUqqdqBr8fPaqL2C/b9S9lYlkJukvafOmKZxmW48Voj3o3AW0xxKKjPDlCLTilRyuYMePbwcvMzjZly4MVvAwIq/YhAI+kTtksQfAL9Fl1fmK6N6trI6PedMn4P4WlQsIAeTz9gxwJ9HsJW5cLVyT02idhssMNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554925; c=relaxed/simple;
	bh=JfR8Uml82cdGIBCvJ1lqgmUooPoskruQwZ6YnHcU87M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TVymBEcUuAIocB7IZ8tXyaK4cDhn8iDQkz3jCz5nKzfPAz4DwcTC70PptauCJSJVszwKVmHUirmSC7zM33xpNXM4ALVWHVRrGSSvV4BnZjnSIEO1rBqopNuVlkitPHPp/kVmyy4pAmL6u4tY99qoeSdQ939db5eLvbfzhbCirf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIeGUN4H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIeGUN4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B07C19425;
	Tue,  3 Mar 2026 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772554924;
	bh=JfR8Uml82cdGIBCvJ1lqgmUooPoskruQwZ6YnHcU87M=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=WIeGUN4HONeaJmSPGM2LuRQ+0//BCDXzs2Y127qtKqgM5qaSMyYKkFeIoIeQM65Ug
	 JGXAPSblZCTKl6KJNjh2JV8XAajwcXUbsxRYT7eehhp7F+9BLFdBahtus9AjGzg+gn
	 PYmPgkSYkTcatEZ2cC7QsF0rqhj4yCxGA8fOeLhYKa5cyoQ2+BrUuEqVOzZ7dnYvBn
	 bo4DrwNFBW1Iz2VzH3Qm+2EdZyxUXBuiH4pPXDNAzkLUvCHoEj40asOIvdjvvixPAF
	 w/EHLlmWuP3lkb7HJ+mkyHl/JnLdS5djL6NESCumPiDRGLDSxU7ENWpT3RDtELEeNb
	 39xL/z/4nSoLw==
Message-ID: <5b379992-ad9c-4f04-b710-b0e2c338c524@kernel.org>
Date: Tue, 3 Mar 2026 17:21:59 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH 1/3] mm/page_alloc: effectively disable pcp with
 CONFIG_SMP=n
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Matthew Wilcox <willy@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
 <20260227-b4-pcp-locking-cleanup-v1-1-f7e22e603447@kernel.org>
 <5d5c8927-95ad-47c4-ae8c-9b56f5534e27@kernel.org>
In-Reply-To: <5d5c8927-95ad-47c4-ae8c-9b56f5534e27@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 17:09, David Hildenbrand (Arm) wrote:
>> - * With the UP spinlock implementation, when we spin_lock(&pcp->lock) (for i.e.
>> - * a potentially remote cpu drain) and get interrupted by an operation that
>> - * attempts pcp_spin_trylock(), we can't rely on the trylock failure due to UP
>> - * spinlock assumptions making the trylock a no-op. So we have to turn that
>> - * spin_lock() to a spin_lock_irqsave(). This works because on UP there are no
>> - * remote cpu's so we can only be locking the only existing local one.
>> + * On CONFIG_SMP=n the UP implementation of spin_trylock() never fails and thus
>> + * is not compatible with our locking scheme. However we do not need pcp for
>> + * scalability in the first place, so just make all the trylocks fail and take
>> + * the slow path unconditionally.
>>   */
>> +#else
>> +#define pcp_spin_trylock(ptr)		\
>> +		NULL
>> +
>> +#define pcp_spin_unlock(ptr)		\
>> +		BUG_ON(1)
> 
> Did you try turning this into a BUILD_BUG() ?

I considered it, but was afraid it would work, until with some weird
compiler and arch/config it wouldn't.

> I'd assume that the compiler would optimize-out all dead code and
> consequently not trigger the BUILD_BUG.
> 
> if (pcp_spin_trylock()) {
> 	/* dead code */
> 	pcp_spin_unlock()
> }
> 
> IIUC, the trylock+unlock is not really split over multiple functions.

Some of the code is a bit more complex like in free_unref_folios() there's a
loop where early on is a check meant as a result from the previous iteration

                        if (pcp) {
                                pcp_spin_unlock(pcp);

and only later

                        pcp = pcp_spin_trylock(zone->per_cpu_pageset);


Also in free_frozen_page_commit() we enter locked but might unlock. Yes the
function should be eliminated as a whole, but again in free_unref_folios()
this is a bit complex...

