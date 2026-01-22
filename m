Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B6318133
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089643; cv=none; b=u8S8K1v9UBEGQmlbYUy9suHmZFNN7x8zb9p26eqcLrI3vNUGysc+mCds0ELreRHbR/HfEKqkNtP87wHNAME1qDarXWiJ7MQ6FKqvnzNb02xSami22aYgSYYtdaqFrDdHPJCPngUK1ctO6EBqPhY7ZCfMOQvUZlVtFVgeb41/tQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089643; c=relaxed/simple;
	bh=pTe1f8kJACAKEGIyUf+bONmTFWhbj5v1cGpd8dlK8XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9rcs1kNe0vU7w1O0mHxZyDrHGGBSDw8I/Dc9trnkRiBsYJXSUZxX94ol9d00Kc+OmbTePdwrEMHpuJudXH5u16kdKpW93UZWsALagNNTEn8PvK4mc7W+oXOi6ASutd4aLoNyjT1mB3hGk7+0Zs7k7WGtakaK/BOSEUaQAqJfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9851476;
	Thu, 22 Jan 2026 05:47:15 -0800 (PST)
Received: from [10.57.80.101] (unknown [10.57.80.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404703F632;
	Thu, 22 Jan 2026 05:47:18 -0800 (PST)
Message-ID: <41874647-a464-4884-9a39-544723d3e6b6@arm.com>
Date: Thu, 22 Jan 2026 13:47:16 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, Yang Shi <yang@os.amperecomputing.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, mhocko@suse.com
References: <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
 <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
 <aXCPHaylUbRJ3CME@e129823.arm.com>
 <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
 <4c98a1b2-6215-4e71-8bb1-eaeb1722e7b1@os.amperecomputing.com>
 <aXHU02hsrB64Zopo@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aXHU02hsrB64Zopo@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>> I'm inclined to leave this as is for now.
>>
>> I agree. I don't think this would be a real problem.
>>
>> Thanks,
>> Yang
> 
> Although partially using GFP_ATOMIC might not be an issue given that
> there is no contention at the moment,
> technically using a memory allocation API inside stop_machine() is problematic
> for PREEMPT_RT, and the relevant page tables should be pre-allocated.
> 
> That said, taking a step back (I’m not sure why I was being so stubborn about this),
> since the kernel_alias area is mapped using block mappings,
> a simple calculation based on your dm_meminfo patch should be sufficient to
> determine the number of page tables that need to be pre-allocated for
> splitting the linear mapping, without having to walk the page tables again.
> 
> So, after your dm_meminfo patch, I plan to respin this patch based on that.
> 
> Am I missing anything?

Yeoreum and I had an offline chat about all this and I just want to spell out
the conclusion for everybody;

We believe it's impossible for the secondary CPUs to have any scheduled work
during this window, and therefore it's impossible for the split race to occur,
and it's impossible for there to be any contention on the page allocator lock.
All of which means that in practice, there are no bugs here and the code is safe
as is, even for PREEMPT_RT.

That said, allocating memory inside of stop_machine() is a bad smell, so Yeoreum
will rectify this down the track; it's not urgent though.

Thanks,
Ryan

