Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8525263C8C
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949443; cv=none; b=khd7oBrjYWUiK1bWuynOShFBhBZ/9I4ts7iaHeonBnF34yRIp9XtrGfYRbG8JvFeQKKVaRmylQlGhPZfycx8S+/KVDdjD49osO91mK1FyJwG3NjM4C2ApBso3Q7hyD77PPhJ8+rqhwE3Mv220VaNINVSilBi7Ib/1P3zDShIF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949443; c=relaxed/simple;
	bh=WtBpIVXwlc9F8M3JSmUqIhhQwP/WKKiddOWuLiFCjXo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RYNsq6c9hi04a6BK+e7ldaj/B0JX6hqHshhcrHaZBY1W5Q9MsxruVP3/x0XnUn2XWGF3RfgOvQ+3K+i/HYAZe+9isi64zU1nuRgT9hYti+oPDxUGkVzQ7EYp2LYEv1cWAfI8+I/adqjmdv6O5lH8ek/JRSBvKFzI33eKIsVaXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGCX9vP9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGCX9vP9"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783949439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuIKCS8XARdOYgN62xhr6Rxk9e6zKkx4Eae+B+wGUpE=;
	b=fGCX9vP9CpwIjgVAcZAcZxGCv2QJ3c+dNYKFulbwzCCwrqkCESWvItr6vNRzesxcIy0kW7
	cijlbZ0Pa/VzoZ90SVTqEtPL1BARQiV27binn7PYumKaTt3zz1ueJAQ6UjXH3NFYvtheFY
	6hIA6A/GfXgxq+/s5TJHO5W8d5zedhc=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 13:30:36 +0000
Message-Id: <DJXHAPFS6JMW.13QLTQP4D5YZT@linux.dev>
Subject: Re: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Zi Yan" <ziy@nvidia.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Harry Yoo" <harry@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
 <0048210a-e186-49c7-9897-32c9b66336c6@kernel.org>
 <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>
In-Reply-To: <DJUYCPR6Z66E.LC3RMX9CEX29@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Fri Jul 10, 2026 at 2:14 PM UTC, Zi Yan wrote:
> On Fri Jul 10, 2026 at 8:40 AM EDT, Vlastimil Babka (SUSE) wrote:
>> On 7/10/26 12:42, Brendan Jackman wrote:
>>> As discussed in the linked patch, the there is some inconsistency betwe=
en
>>> "trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
>>> used in the public API it seems to have more mindshare so do that.
>>>=20
>>> The linked patch did this for the ALLOC_ flag but forgot about FPI_.
>>>=20
>>> Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e1=
9d3@google.com/
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>> Naming things is hard. Maybe it should have all been called "nospin". I
>> don't know anymore :)
>> _nolock() functions and ALLOC_NOLOCK are part of API, FPI_ is internal s=
o
>> it's not that urgent. Furthermore:
>
> I had a similar concern when reading ALLOC_TRYLOCK -> ALLOC_NOLOCK[1],
> since the name is _NOLOCK, but the comment says spin_trylock.

Yeah I do actually think "nolock" is a bad name here, it takes a lock.
But I never cared very much about the _bad_ ame. On the other hand
_inconsistent_ naming is a concrete problem IMO.

> I agree that "nospin" is better and less confusing. But whether we want
> to churn it again, TBD. :)
>
> [1] https://lore.kernel.org/all/DJOZN5H048UX.1ZVSFD48QZN05@nvidia.com/

Yeah I also dunno what's best here. I guess this is a decision for Vlastimi=
l?

>>> ---
>>>  mm/page_alloc.c | 18 +++++++++---------
>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>=20
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 5fe1c11f919d7..ba8d882072de5 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -90,7 +90,7 @@ typedef int __bitwise fpi_t;
>>>  #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
>>> =20
>>>  /* Free the page without taking locks. Rely on trylock only. */
>>
>> here's a "trylock"

This is accurate though. It's talking about the implementation which
calls spin_trylock().

>>> -#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
>>> +#define FPI_NOLOCK		((__force fpi_t)BIT(2))
>>
>> And here's not anymore.
>>> =20
>>>  /* free_pages_prepare() has already been called for page(s) being free=
d. */
>>>  #define FPI_PREPARED		((__force fpi_t)BIT(3))
>>> @@ -1419,7 +1419,7 @@ static __always_inline bool __free_pages_prepare(=
struct page *page,
>>>  	page_table_check_free(page, order);
>>>  	pgalloc_tag_sub(page, 1 << order);
>>> =20
>>> -	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
>>> +	if (!PageHighMem(page) && !(fpi_flags & FPI_NOLOCK)) {
>>>  		debug_check_no_locks_freed(page_address(page),
>>>  					   PAGE_SIZE << order);
>>>  		debug_check_no_obj_freed(page_address(page),
>>> @@ -1558,7 +1558,7 @@ static void free_one_page(struct zone *zone, stru=
ct page *page,
>>>  	struct llist_head *llhead;
>>>  	unsigned long flags;
>>> =20
>>> -	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
>>> +	if (unlikely(fpi_flags & FPI_NOLOCK)) {
>>>  		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>>>  			add_page_to_zone_llist(zone, page, order);
>>>  			return;
>>> @@ -1569,7 +1569,7 @@ static void free_one_page(struct zone *zone, stru=
ct page *page,
>>> =20
>>>  	/* The lock succeeded. Process deferred pages. */
>>>  	llhead =3D &zone->trylock_free_pages;
>>> -	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
>>> +	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_NOLOCK))) {
>>>  		struct llist_node *llnode;
>>>  		struct page *p, *tmp;
>>> =20
>>> @@ -2882,7 +2882,7 @@ static bool free_frozen_page_commit(struct zone *=
zone,
>>>  	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
>>>  		pcp->free_count +=3D (1 << order);
>>> =20
>>> -	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
>>> +	if (unlikely(fpi_flags & FPI_NOLOCK)) {
>>>  		/*
>>>  		 * Do not attempt to take a zone lock. Let pcp->count get
>>>  		 * over high mark temporarily.
>>> @@ -2979,7 +2979,7 @@ static void __free_frozen_pages(struct page *page=
, unsigned int order,
>>>  		migratetype =3D MIGRATE_MOVABLE;
>>>  	}
>>> =20
>>> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>>> +	if (unlikely((fpi_flags & FPI_NOLOCK) && !can_spin_trylock())) {
>>
>> can_spin_trylock() was matched with FPI_TRYLOCK, now not anymore

IMO can_spin_trylock() is matched with spin_trlock() while FPI_NOLOCK is
matched with ALLOC_NOLOCK which is matched with alloc_pages_nolock().

If you like, we could just drop the ALLOC_ and FPI_ renames and just
rename alloc_pages_nolock(). I steered away from that because "the
latter is public API", but... it's not like it would be a huge treewide
patch, it only has one user.
