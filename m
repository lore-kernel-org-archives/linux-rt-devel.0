Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C535C180
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385223; cv=none; b=K7qdQCcfqSlEAFx+kZ1itWGPvNMbckKozrOQHA9wDfeBjyvBTXl7GkRYekzSsMbd7DnRdtXEXTlu8ekmLhoohE0x+8ml6BnxI6Qwn7Civzv9RIKocIq3WHUXaiA7ny66oncU5JZjgcp68Y4IkZ4j8LO8JmFcApOyIdmFXQClQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385223; c=relaxed/simple;
	bh=GVZy9vTQXfo/Q2Sy93S3xnS8wDMKayJocnztB7HUvR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8Jwr/Lq7t0lnzrW3FR9Zs5lm4h97Lo/GRTGzL+SvNUjdz1ajo7yQo4D5bBD5KlpS1ZrF6o+0ajyoiLQRpdmWuJmiE8bTJgIymYTWjP09kBvgGxURK07+tC4vYOjqcwpiMOuJ1qiGz/zAfMlEDadwDnLVBBLn8PRQkH65+gEHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3GU+rDX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3GU+rDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779385216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJEyad8/zSUSfFThXl+omadAtBvnvl3F5572ZCdBP0Y=;
	b=Q3GU+rDXn2ofGh7+OLNbyCxaMmxEOzZUW0rxkX6Y/ls5Nux676LcuAf0zJZ9bKgiZW5cIf
	0vcGYV02KDh0U2RfENWNcc9LwKwDQgK3TBVVUwqJZL/DN4H5EyNQy+eHADEA53iaPt/Sxs
	KilqWhw8LkJRUlwaiLKgVBBS8x6os4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-bF8ejiEDPdiWvmJNxRVV2g-1; Thu,
 21 May 2026 13:40:13 -0400
X-MC-Unique: bF8ejiEDPdiWvmJNxRVV2g-1
X-Mimecast-MFC-AGG-ID: bF8ejiEDPdiWvmJNxRVV2g_1779385211
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29255180060D;
	Thu, 21 May 2026 17:40:09 +0000 (UTC)
Received: from [10.22.80.218] (unknown [10.22.80.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43AD119560AB;
	Thu, 21 May 2026 17:40:04 +0000 (UTC)
Message-ID: <f0f4841a-816a-4442-bebb-277984ee950e@redhat.com>
Date: Thu, 21 May 2026 13:40:03 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev, Matthew Wilcox <willy@infradead.org>
References: <20260520204628.933654-1-longman@redhat.com>
 <ag8zX5KJUKo70TvG@lucifer>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ag8zX5KJUKo70TvG@lucifer>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: iXCSSNm9pnY4bXisf9UkMNbyLyKz6hwqkBVU1UOGBeE_1779385211
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 12:40 PM, Lorenzo Stoakes wrote:
> +cc Matthew who has fairly strong opinions on GFP flags and such :)
>
> Also, please don't send 2 patch series with 2/2 in-reply-to 1/2, use a
> cover letter + have patches reply to that :) [yes it's one of those
> subjective things that people differ on a lot but generally how we do in
> mm]
>
> On Wed, May 20, 2026 at 04:46:27PM -0400, Waiman Long wrote:
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
> This seems like the wrong place for the solution, now we have to remember
> to use a specific GFP flag but only in one specific place in some IRQ code,
> yet RT is fine with this in any other scenario?
>
> This is really confusing.
>
> Wouldn't we better off with a way of actively detecting this context
> somehow in the page allocator?

This new GFP_ATOMIC_RT flag will make memory allocation more likely to 
fail compared with GFP_ATOMIC. That is the main reason why I think a 
separate flag with documentation about this difference will make the 
users of the new gfp flag more aware of what they should check before 
they use it.

I would certainly like to have the mm memory allocation code to handle 
it automatically if it doesn't impact the failure rate.

>
> It just instinctively feels like this is the wrong level of abstraction for
> a fix here :)
With PREEMPT_RT, GFP_ATOMIC_RT just translates to __GFP_HIGH. It can be 
set explicitly in the relevant call sites. This patch is more a 
documentation step to make clear the purpose and consequence of doing that.
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/gfp_types.h | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
>> index cd4972a7c97c..ac30882b6cd4 100644
>> --- a/include/linux/gfp_types.h
>> +++ b/include/linux/gfp_types.h
>> @@ -316,6 +316,13 @@ enum {
>>    * preempt_disable() - see "Memory allocation" in
>>    * Documentation/core-api/real-time/differences.rst for more info.
>>    *
>> + * %GFP_ATOMIC_RT is similar to %GFP_ATOMIC with the addition that it can also
>> + * be used in context where preemption and/or interrupt is disabled under
>> + * PREEMPT_RT, but not in NMI or hardirq contexts. The allocation is more
> I'm not sure 'GFP_ATOMIC_RT' really communicates all of this information.

I am not good at naming. If you have other good suggestion, I would like 
to hear it.

Cheers,
Longman


