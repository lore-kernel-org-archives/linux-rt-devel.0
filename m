Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA632EC090
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330297; cv=none; b=sv0rLaEC3sxTE1iaHnVU1FFV+nwGH5pvS08F2H7DO6ohqDj8dRN2YxUc88GUqKP2UHNS3t6TxXAscURBBchfsgr1w9ZOO6TnEFDBqJZcrMcfveP9pBmyTUjQnOkBOAVcZvhQbkpwLVKwS5RMQ/aXDSurK09nO6CAZaMQeTkvcKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330297; c=relaxed/simple;
	bh=3XA9gA6YFpI0E9iu1XTrfZKSm2PNmHfW/1Gg5ohzBtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzCQhngS55Z/VcqbOiUmKM38ebNAbNxU5jEmtsLe0HmnPuKPO1z5ofzoLW1KOXma1Jb15GcwMhPQXSx1ICnFug80mhsLonhjLkCDS2ic23UdqPRpO5618W9RqCKyuN9YzDMitI3GvAL9nfDb6uLT0ZEgj2/CVvwvhJjMomHjwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kIsn8PND; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kIsn8PND"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768330292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YSyCYm4RI/yOISWqF0EpwwOCB780fUcqokCOrTMCaj4=;
	b=kIsn8PNDwk/uIEAwdGjqTZ9RFbMGqbD5t/OD3hzJ4Ifr+7yWtFRpLFXOnXJxBeHaEhUxPz
	xx8kF/7Tr9UrUn10mTQ0ciIeDwd8AbjaoTuT5X3ua0HqZyqstTQCjV2ZatcM+UVHf2QSzi
	0ZkPHCG2ZYnwPrCuvx3ABUZU6Dp/4Ac=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chris Mason <clm@meta.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,  Andrew Morton
 <akpm@linux-foundation.org>,  Christoph Lameter <cl@gentwo.org>,  David
 Rientjes <rientjes@google.com>,  Harry Yoo <harry.yoo@oracle.com>,
  Uladzislau Rezki <urezki@gmail.com>,  "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,  Suren Baghdasaryan <surenb@google.com>,
  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Alexei Starovoitov
 <ast@kernel.org>,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-rt-devel@lists.linux.dev,  bpf@vger.kernel.org,
  kasan-dev@googlegroups.com,  Petr Tesarik <ptesarik@suse.com>,  "Paul E .
 McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
In-Reply-To: <a4b0be3f-bb6f-42d7-9176-a2bc0dcbd3a8@meta.com> (Chris Mason's
	message of "Mon, 12 Jan 2026 09:36:25 -0500")
References: <20251024142927.780367-1-clm@meta.com>
	<28e6827e-f689-45d9-b2b5-804a8aafad2e@suse.cz>
	<9a00f5c2-7c9b-44c3-a2ac-357f46f25095@meta.com>
	<01cf95d7-4e38-43c6-80ef-c990f66f1e26@suse.cz>
	<a4b0be3f-bb6f-42d7-9176-a2bc0dcbd3a8@meta.com>
Date: Tue, 13 Jan 2026 10:51:21 -0800
Message-ID: <875x95ibx2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Chris Mason <clm@meta.com> writes:

> On 1/10/26 10:41 AM, Vlastimil Babka wrote:
>> On 1/10/26 14:20, Chris Mason wrote:
>>> On 1/9/26 3:16 AM, Vlastimil Babka wrote:
>>>> On 10/24/25 16:29, Chris Mason wrote:
>>>>> On Thu, 23 Oct 2025 15:52:32 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>>>
>>> [ ... ]
>>>
>>>> By the way, there was another bug in this patch, causing a severe memory
>>>> leak, which the AI unfortunately didn't flag. Petr reported it during
>>>> performance testing and it took me more than a day to find it. Oh well :)
>>>>
>>>> Wonder if things got better since then perhaps, and your or Roman's tools
>>>> would find it today? :)
>>>
>>> Yes and no.  It didn't find the leak until I changed the prompt to say:
>>> "there is a leak, find it".  I'll see if I can improve things...
>> 
>> Thanks. Hmm even if it has to be done like this, it could be a substantial
>> time saver vs finding the leak myself.
>
> Finding the missing break on the first pass was tricky because claude
> consistently focused on concerns about potential NULL pointers and
> mostly ignored the loop flow control changes.
>
> I think I've fixed things by expanding the loop analysis and also
> forcing it to make a more fine grained list of changes to analyze before
> it jumps into the review.
>
> It caught the missing break 5 out of 6 times in a loop, so maybe?
> That's probably the best I can get right now for a generic review, but
> claude will almost always be more reliable with extra directions like
> "there is a leak, find it" on top of the review prompt.
>
> I've pushed out two new commits to:
> https://github.com/masoncl/review-prompts
>
> 9a44c271 CS-001.md: pay more attention to loop control flow and memory
> allocations
> 7fad3996 review-core.md: make change categories more fine grained

It helped Gemini too. With these changes even the flash-3 model caught it
from the first attempt.

Thanks
