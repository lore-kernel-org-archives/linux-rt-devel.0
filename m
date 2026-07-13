Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B07427A04;
	Mon, 13 Jul 2026 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950394; cv=none; b=sQAe+4jIr7MblsXRNKUjjGN2gQ5UUdyjDf3/xYL3+89Mlo8/HRXK3b/mXOD2upVKSMQRk1zL6oW9sy1T04FzcXzrTKoNRvqFS6P/wtzGU9evVb0xDup1C2fLdI9Au6U0Z45mTPJ9CiinpYrPmIJ+GKnXoLCT+Nqi/310Yb2UVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950394; c=relaxed/simple;
	bh=s68Yye8VF/BEr637ik4F+vuYWnkS3iXq4RmtH7TgNy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvDyFKkXToGpMYPW2f+9RxPw9SD+3jJjIsYAqMaKyDGYvdrBpfpE2+cS+aTikdecB8qlox+bepd0t9zadeW5YcHov3wIYBcXKHdEGoxwkb2KI4ZcsSOn3hmzZ0+yjUcO5svjegFJsqyD+PSJF5hU4R8yLmOsm4u5jjKQbXBRXbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWU2dUHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWU2dUHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26AE1F00A3A;
	Mon, 13 Jul 2026 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950393;
	bh=Gi6by9W+BjPxJGcAVM4qqNGrl90WcOjeaplWb2jNiTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nWU2dUHDFQhtPiZcUpj4K3kON8LNMpuUuYf3GuPCLmsacqNTh7DugEoMASdOiPiCc
	 kdKeodHz6LIf1Nrqnb612Lp0FaQ5Ljhm+Dv3A51cpHz9Md0HfaYPedbTGWMP6bcV3+
	 FEFawoH2hC8LuS34i0Ejqw+gtjtozKaBv14C7rg2KijUp00Bih50f2Oo4bs029hbkt
	 s1qmwYKFutquVqz1ytbvChfYhzmg7WOw7alYseS6HU8IzelNIldBuKhTgQuaySnWav
	 0zeLjTTdIcvq75cushlAYOR/t8tcV8Q8mpoXGvCRtbHqHX586HNX7aiPUZJDdrq8OY
	 sL3AU6JQjp8HA==
Message-ID: <0e178f49-dcd9-41fe-9a03-7d8214bf8548@kernel.org>
Date: Mon, 13 Jul 2026 15:46:27 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
Content-Language: en-US
To: Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
 Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Harry Yoo <harry@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
 <0048210a-e186-49c7-9897-32c9b66336c6@kernel.org>
 <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com> <DJXHAPFS6JMW.13QLTQP4D5YZT@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DJXHAPFS6JMW.13QLTQP4D5YZT@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 15:30, Brendan Jackman wrote:
> On Fri Jul 10, 2026 at 2:14 PM UTC, Zi Yan wrote:
>> On Fri Jul 10, 2026 at 8:40 AM EDT, Vlastimil Babka (SUSE) wrote:
>>> On 7/10/26 12:42, Brendan Jackman wrote:
>>>> As discussed in the linked patch, the there is some inconsistency between
>>>> "trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
>>>> used in the public API it seems to have more mindshare so do that.
>>>> 
>>>> The linked patch did this for the ALLOC_ flag but forgot about FPI_.
>>>> 
>>>> Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19d3@google.com/
>>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>>
>>> Naming things is hard. Maybe it should have all been called "nospin". I
>>> don't know anymore :)
>>> _nolock() functions and ALLOC_NOLOCK are part of API, FPI_ is internal so
>>> it's not that urgent. Furthermore:
>>
>> I had a similar concern when reading ALLOC_TRYLOCK -> ALLOC_NOLOCK[1],
>> since the name is _NOLOCK, but the comment says spin_trylock.
> 
> Yeah I do actually think "nolock" is a bad name here, it takes a lock.
> But I never cared very much about the _bad_ ame. On the other hand
> _inconsistent_ naming is a concrete problem IMO.
> 
>> I agree that "nospin" is better and less confusing. But whether we want
>> to churn it again, TBD. :)
>>
>> [1] https://lore.kernel.org/all/DJOZN5H048UX.1ZVSFD48QZN05@nvidia.com/
> 
> Yeah I also dunno what's best here. I guess this is a decision for Vlastimil?

Let's keep the FPI_NOLOCK rename then, but separately from the fix.

> 
> IMO can_spin_trylock() is matched with spin_trlock() while FPI_NOLOCK is
> matched with ALLOC_NOLOCK which is matched with alloc_pages_nolock().
> 
> If you like, we could just drop the ALLOC_ and FPI_ renames and just

ALLOC_NOLOCK is better to me than ALLOC_TRYLOCK.

> rename alloc_pages_nolock(). I steered away from that because "the
> latter is public API", but... it's not like it would be a huge treewide
> patch, it only has one user.

