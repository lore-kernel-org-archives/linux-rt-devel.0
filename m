Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AB376BCC;
	Thu,  5 Mar 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701562; cv=none; b=cq/4MLgiH6CNlBsPLYkAaF59V5fKvNAo+ieoYxbG6bwJ5xwa6a96d0FKlhXHDFG4h22PbEnI7iNw1cmKLqVA0UeEprD2HNrB/UY3jr4ZJSbW9+OB50ePiUT0nIW7ZAZfNRUfldpk+fPpV3YWDdV2ZeIfiOJuTncT281g1jWOxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701562; c=relaxed/simple;
	bh=mmssFpHsTTTOrOd4y+zoY0xhIkR5xO0zlcS/SUuUFGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lbPrDxH1ruOyAHgDAz3Ep8zoNfgxWuWKF9M/mTYwSLSo2nWIdd7vxKBm4BKVxFP71p//j3nl+19yVmskiOlKlMQebHIWiUFUTT0hcqwmE5+3VV4qJC/eA6ZFvLT6vugkwAEbUrzJSMuD6tpWApj5L6lF5FR2HhUh2rbi92/+tYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0/k/B/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0/k/B/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4BBC19425;
	Thu,  5 Mar 2026 09:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772701562;
	bh=mmssFpHsTTTOrOd4y+zoY0xhIkR5xO0zlcS/SUuUFGk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=J0/k/B/ZSPtOdp5SgcAwYMgs6ZHGAR7ZKKSC7akGX8lelqRptgjCjk35rnVHtV9vn
	 OjqT58W+8i38KUlkTl+8QgpdL4fS5bWQ/77tChQAxbPHmyCIR2wJsPN6nurzvh5NkC
	 bmCzPhNi6tiSzSGlIZ/91rk4UXr+XUgV4D/JfmSx/L5nG25VTEtqAJEsAknmxHJtqB
	 bmhNQPj59f4VLdaWyJb6ZhMOVvti8qisA7fhRkABFxktOo7GqOA1+mdV5ecv4CuraM
	 g4lSJYMxB1wT23qft7LhnNt+jaWIqvXYeYd1vFovUAOcQ4WPM9u8KQ+m2oXjfip32y
	 YIaZg15SMyhhQ==
Message-ID: <985005f4-fe5e-4ad0-83a8-14ce324db58a@kernel.org>
Date: Thu, 5 Mar 2026 10:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: rtmutex deadlock and memory corruption when running gcc testsuite
 in next-20260303
Content-Language: en-US
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, Harry Yoo <harry.yoo@oracle.com>,
 Hao Li <hao.li@linux.dev>
References: <20260303222127.2992-1-spasswolf@web.de>
 <f4591e7b-d07a-402a-a051-8ff12b0ccc09@kernel.org>
 <9541893b588ef644a06cf01bb65005e9efcb3427.camel@web.de>
In-Reply-To: <9541893b588ef644a06cf01bb65005e9efcb3427.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 21:44, Bert Karwatzki wrote:
> Am Mittwoch, dem 04.03.2026 um 15:15 +0100 schrieb Vlastimil Babka (SUSE):
>> On 3/3/26 11:21 PM, Bert Karwatzki wrote:
>> > I tried building gcc-14 from the debian repositories (fetched via apt-get 
>> > source gcc-14) on my new and shiny zen5 machine (Cpu: "AMD Ryzen 9 9950X 
>> > 16-Core Processor) running debian stable/trixie and linux-next-20260303 
>> > (PREEMPT_RT=y) with the following command:
>> 
>> It's probably my fault, sorry about that.
>> Specifically commit 666a739089c from slab/for-next-fixes.
>> Does the following fix it? The fixed commit was meanwhile
>> queued so hopefully will be in next-20260304
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 740edbad0475..1871c5ef354a 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4610,6 +4610,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>>  	}
>>  
>>  	local_unlock(&s->cpu_sheaves->lock);
>> +	pcs = NULL;
>>  
>>  	if (!allow_spin)
>>  		return NULL;
>> 
>> 
> 
> Yes, this seem to fix the issue (two testruns without errors). So the problem was __pcs_replace_empty_main()
> returning a non-NULL pcs in the case where it can't take the lock (&s->cpu_sheaves->lock) and jumps to
> barn_put:.

Thanks for confirming and sorry again!

> Bert Karwatzki

