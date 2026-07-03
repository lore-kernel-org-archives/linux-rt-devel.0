Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86E3B14AD
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070780; cv=none; b=hansyDf/7+vcWU3vM+w2vaSgsqrIm2Gu4B0NT8I7P4Rgsruj2J7NnVMVC2UV2c5n+Z53cCAdYVQvxPUYWEoM2cAQ10D54Q66mWRtCQ/7moiLKq/cta7MEL3lyia2B0w3OfgiD4D0Xn3+ltVUJjZTTJdEekjS7XsCH0sduIxw794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070780; c=relaxed/simple;
	bh=SiBbJzbVpINUuvEV2ZZbm9PvYX/w11qTrMJLfeetB+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WKD8FdsgPMZNP0jnqIFk6jZOsWjwMOf7xMSwjFyj0VFBWuN1SJM5ryYMcB1Pr4ywIpmcE+JOyss/F7dStXAmQ0kU4H4IDFhRrBFDF52+LlLzwB/qCSIItGsfLC+fD2LpzI7aIBBlMmPBTnWF3/YpyXblE31xaOtITLM2Gq3/o2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r3nDtytD; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3nDtytD"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783070776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xCCG+fiv8yWbu6fWkXiLLVYWLMzK+xu+oxDBafmZhw=;
	b=r3nDtytDg7caAIH6z/JHU9AnIIjvlFjm5/RDsHneREnq2EzYKrPRxpAVSlFJ14m/TpcKcL
	9PkvQKm0yv3t/DwumglY3KOUnHMfRxfrJ3nucHp/ekoesMHslBC9NE5b8+yIoo66ZwYXHh
	mDkL7aoW4pbcqVD9VYiAiKo7W/1lGzQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 09:25:56 +0000
Message-Id: <DJOTTXFDIIN3.3JGPUL349UM63@linux.dev>
Cc: <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/18] mm: move some stuff to mm/page_alloc.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-7-0af8ff387e80@google.com>
 <20260702102828.3C8651F000E9@smtp.kernel.org>
In-Reply-To: <20260702102828.3C8651F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu Jul 2, 2026 at 10:28 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Duplicate declaration of `drain_local_pages()` in `mm/page_alloc.=
h` contradicts the commit message.
> --
>
> commit 54f4dc2300a55c6c9cef3e3916ba57e09ad07e39
> Author: Brendan Jackman <jackmanb@google.com>
>
> mm: move some stuff to mm/page_alloc.h
>
> This commit shrinks the scope of several internal functions by moving the=
ir
> declarations from the public include/linux/gfp.h header to the internal
> mm/page_alloc.h header.
>
>> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
>> index a4f4b325381ad..6bb50bae3ba27 100644
>> --- a/mm/page_alloc.h
>> +++ b/mm/page_alloc.h
>
> [ ... ]
>
>> @@ -266,6 +266,34 @@ static inline bool free_area_empty(struct free_area=
 *area, int migratetype)
>>  	return list_empty(&area->free_list[migratetype]);
>>  }
>> =20
>> +/* Convert GFP flags to their corresponding migrate type */
>> +#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
>
> [ ... ]
>
>> +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
>> +void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
>> +void drain_all_pages(struct zone *zone);
>> +void drain_local_pages(struct zone *zone);
>
> [Severity: Low]
> The commit message notes that drain_local_pages() is still used externall=
y
> and needs to stay behind in include/linux/gfp.h. Since it was successfull=
y
> left in the public header, is this declaration in mm/page_alloc.h an
> accidental duplicate?

Ugh, yep. My local Sashiko run found this but apparently I failed to
actually fix it...? Doing thigs is so hard.
