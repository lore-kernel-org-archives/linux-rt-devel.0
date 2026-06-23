Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD894242910
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197456; cv=none; b=gC1G6X0ybgptWHgidDKnxcMmCJ3dcucCAhmuwEkwpIpqTOwoa8dR111dg7tW0JofT1ZkyOim8CGI3ylXK+yVQlD5yeDu6TGc9VxNczmRhtymfZb7rWQD764Yrrzmrwcx2b/RUMgiI2hbGhjy0ueAqCQO+Ij8vQMWMNoGHmIvw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197456; c=relaxed/simple;
	bh=PP58sXJdTORj2dmdQsbOxa0IvKbskJToqkKiyXgW42w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoI8xoXrw9us4LQtHp4WITH1MPbZ9OxoiX65pao/PccaZjZBzGyOw9wllVHuiPfQiQK9CWp7irZ92BmURukxVEdXMc7QrNQ2+efF5krstA79yYMafGq/3Z5DDEON2hdEk+4Oc/P/RVEio5ZX9YCfsilBrf83uGkRuC4JPH33EMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pyTi2t4b; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pyTi2t4b"
Message-ID: <037178f2-bd9e-4766-8df1-0881e2eee9c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782197451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmo3eVU2Vf8oqTkENsOcNVqm/en18iIcmn9Crxfb++4=;
	b=pyTi2t4b35HMDBQBNlZTLDwGnFebJjSlM9XOtmX2EmuCAtQteA/Gwv4mrfVmgF6QeAO4r8
	5OEruL9HCPmG878Xfdj1NFyBh1af/b7Ny/TO5wgIx4IQfBzM+9vlAajlNFjVAI3F4w46xg
	S4UrF9mRaX8N4DTa2E/OXWcuoqOCGZk=
Date: Tue, 23 Jun 2026 14:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2 12/13] mm: Move __alloc_pages() to mm/internal.h
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
 <20260622102105.53D141F00A3A@smtp.kernel.org>
 <DJFJ96IPBX9H.33CCUBF385H1W@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <DJFJ96IPBX9H.33CCUBF385H1W@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Brendan


On 2026/6/22 19:14, Brendan Jackman wrote:
> On Mon Jun 22, 2026 at 10:21 AM UTC, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] Missing EXPORT_SYMBOL for out-of-line alloc_pages_node_noprof() causes widespread module linker errors.
>> --
>>
>> commit 42f7742177beb0066c00a7aa081250feb5859171
>> Author: Brendan Jackman <jackmanb@google.com>
>>
>> mm: Move __alloc_pages() to mm/internal.h
>>
>> This commit moves the __alloc_pages() family of internal functions to
>> mm/internal.h to restrict them to the mm subsystem. It also moves
>> alloc_pages_node_noprof() out-of-line into mm/page_alloc.c since it
>> depends on __alloc_pages_noprof().
>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 36f0d625a4390..38238203ef7b0 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>> [ ... ]
>>
>>> @@ -5419,6 +5419,17 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>>>   }
>>>   EXPORT_SYMBOL(__alloc_pages_noprof);
>> [Severity: Low]
>> Since __alloc_pages_noprof() is no longer visible outside of mm/, should this
>> EXPORT_SYMBOL be removed?
> Yep.
>
>>> +struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
>>> +{
>>> +	if (nid == NUMA_NO_NODE)
>>> +		nid = numa_mem_id();
>>> +
>>> +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>>> +	warn_if_node_offline(nid, gfp_mask);
>>> +
>>> +	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>>> +}
>> [Severity: Low]
>> Does this code cause module linker errors? alloc_pages_node_noprof() is called
>> by the alloc_pages_node() macro in include/linux/gfp.h, but it does not have
>> an EXPORT_SYMBOL.
> Yep. Doesn't show up in defconfig but if you set CONFIG_BLK_DEV_UBLK=m
> then:
>
> ERROR: modpost: "alloc_pages_node_noprof" [drivers/block/ublk_drv.ko] undefined!

I was about to report this linker issue myself, but Sashiko caught it first.

While testing your patch on top of mm-new, I hit the exact same modpost

undefined symbol error as mentioned above:

   MODPOST Module.symvers
ERROR: modpost: "alloc_pages_node_noprof" [arch/x86/kvm/kvm-intel.ko] 
undefined!
ERROR: modpost: "alloc_pages_node_noprof" [arch/x86/kvm/kvm-amd.ko] 
undefined!
ERROR: modpost: "alloc_pages_node_noprof" [drivers/gpu/drm/ttm/ttm.ko] 
undefined!
ERROR: modpost: "alloc_pages_node_noprof" [drivers/misc/sgi-xp/xpc.ko] 
undefined!
ERROR: modpost: "alloc_pages_node_noprof" [drivers/misc/sgi-gru/gru.ko] 
undefined!
ERROR: modpost: "alloc_pages_node_noprof" 
[drivers/net/ethernet/amazon/ena/ena.ko] undefined!
ERROR: modpost: "alloc_pages_node_noprof" 
[drivers/net/ethernet/amd/xgbe/amd-xgbe.ko] undefined!
ERROR: modpost: "alloc_pages_node_noprof" 
[drivers/net/ethernet/aquantia/atlantic/atlantic.ko] undefined!
ERROR: modpost: "alloc_pages_node_noprof" 
[drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] undefined!
ERROR: modpost: "alloc_pages_node_noprof" 
[drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko] undefined!
WARNING: modpost: suppressed 14 unresolved symbol warnings because there 
were too many)

I'll resolve this locally and retest the patch afterward.

Thanks

Best Regards

Hao

