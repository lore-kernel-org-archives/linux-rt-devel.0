Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07D18DB01
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Nov 2025 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830270; cv=none; b=PFAFPmVvbBWNMntbGeK/YVb7cZqXCL1wS5JZYDqmeFqXLnEHcXDBA0BGY/M1GUfORBzkNzTgYVma08ZdFxM22ZacvF180CbwyUa9TsvGQ03o2jxt7/DB8FZD360gXe5GdvYRR4Auh9Kg9/wSBugHTgsA+7477bm/UeR9QrQjkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830270; c=relaxed/simple;
	bh=54lsAScodbRTpR1bH6qMs5x+FVqbnXjPhe6PWB9xz3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUKoBpqlgFsuW98D+cv12eaV1dzkfnkSAF0lGp3nZfCNpNI12eyt5GXuRo5mrNV6Rlh9ASvq/6ErrknpsgzFBMH8lNN7kwf2iy8/AKBsuOR+fwX13Lm+t4Hsu41+gNh5/yNrkoX1VmB2PXU38g2xSYlCuTIN3B5QEeb3FJbiD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m1VOnbj0; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1VOnbj0"
Message-ID: <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762830265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5c8zazQymbCh3EJOF0KTydVfHgB+HL63txNkj2DBcg=;
	b=m1VOnbj0B52FF5eqkgvxn2ibcAZ2AlUdQ2OpPrHQmPQeylgDhQJZc44smuZ/tFwxYYmsLz
	MO94ShQBlC2V/Nu2D3aYvij6xrHH3NeUozTm0MkGI8F9M9YBE2vzLtaW4CW2d3AV3LqiNx
	ieAfXns9GSZy2EFyQl44C+OKbFBoyNc=
Date: Tue, 11 Nov 2025 11:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
To: Shakeel Butt <shakeel.butt@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry> <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo> <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/11/25 12:47 AM, Shakeel Butt wrote:
> On Mon, Nov 10, 2025 at 02:43:21PM +0900, Harry Yoo wrote:
>> On Mon, Nov 10, 2025 at 12:30:06PM +0800, Qi Zheng wrote:
>>>> Maybe we could make it safe against re-entrant IRQ handlers by using
>>>> read-modify-write operations?
>>>
>>> Isn't it because of the RMW operation that we need to use IRQ to
>>> guarantee atomicity? Or have I misunderstood something?
>>
>> I meant using atomic operations instead of disabling IRQs, like, by
>> using this_cpu_add() or cmpxchg() instead.
> 
> We already have mod_node_page_state() which is safe from IRQs and is
> optimized to not disable IRQs for archs with HAVE_CMPXCHG_LOCAL which
> includes x86 and arm64.

However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?

> 
> Let me send the patch to cleanup the memcg code which uses
> __mod_node_page_state.

