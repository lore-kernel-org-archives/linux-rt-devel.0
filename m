Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543671;
	b=Tv+QZeYiaH98H5kOpUK83xxtkb5BC6G3g1VxZjykHy1E41BIW1p2K2Hu3JsEw+TL3Z1Y
	 njIZrOcze/kMVd/o0G4nd0Q2H0AtGZ/dvFMfjOyqXFMAee7g1exnnwGg6nJo+taiGYH/9
	 +1tio9UoUxaVKJmJIOOg5bKX1JplFvuf3tCP5yMSlrA9vHXxtpVj8j8SDoJmcqw662Eg7
	 7rNuNxrr/fRKNBfXAaDRwVCHxZ5ktdhoQweYEtq0nBviRf0UtErytMs3I2HyVykNcdEIj
	 CdtaSmaJpSLkuMAd+1tE81Q6x1QkRKKeM2UCzs94Q96U8pgxViurU+rDH0A6bvE3IyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=VsP8MXxfo3SZdbWSOQKBU/IrTFvBThmLY9Ku8DE2rr4=;
	b=VC1L6B9rqNJqzS/zZt3Dsoy2YMySWx+YUyVNphkR4s4ScfEufb0jk8+X34RQl1rPyIob
	 /HT6FCYZmkT7OuOneYkaG2LT79j5UhfhRPxCti6qHLbsHBbLCIo7C/YP7emwR/eZZViip
	 dmr1X/sfHUeGKC+D8NaejYCt0dYY2QBGxCnCFrLpTCioSBCRbhFnTE308hJ8a0hi3G4xW
	 McWjvQEmnfw/N8DHiVr2/CJVE3ZJjy/kxACzO8lK0Vqqfe4ZNn0O2+id7vjmtgyfT356v
	 3ZDfeoRlTANb1u7UnYpTMbkEhjO8qp3D2wqIvkkGP4QULqKwTTUawBbQ2C4iqU0w8EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=jBIHKzb1;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D7606A33B
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60D7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=jBIHKzb1
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd69954c755so3459582a12.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795543668; x=1796148468; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VsP8MXxfo3SZdbWSOQKBU/IrTFvBThmLY9Ku8DE2rr4=;
        b=jBIHKzb1smqc4tpznans0Db/+QVk54TcspBLC0QRDmCEDMagZw8FZQguqvDt7aRyvN
         SRcSMYo2jCj3KKevFX7T04s4tAGV6zxZx+boBjd5E6u4bQTIolTqeLgkFb8sGwxKDXRG
         bIiKw8f9sJAKH7J28WmgcqFqhaI9FNxMZ7c1EAGg1rFJ2dqoq+paa03C2UKOMBnB/Dzo
         p3fvCeSjP43miU7VpZ1OknkIZAMSq2aTCZZv9vHqNV2Og2iyKMbhV+EmucuCSPU2KDdn
         H9MEIYsCjpf8mzzxT5Iith6/8lzQbdixkfAKbJJJCBDkhDQl3Iv3K+r/L/1QIjhrxeuX
         Pleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543668; x=1796148468;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsP8MXxfo3SZdbWSOQKBU/IrTFvBThmLY9Ku8DE2rr4=;
        b=A+MJqR509mKBw+fzQRB3hG7EHWjzGyUqpqiRaNVJBtyjPTs34bAyQa0FxBoBQzXU3J
         3slgAOkdd8VJgMGwgiPzfEDH8ly/gJ5KiX+i6F0AY8idAIp7nJGxhKW3cDNGYdv3YpNp
         T5xaySF6Zsw9qUDQ3CRms7A+DVvzrdumql6FlAwNO+6tZYWBzdnfWOPYtz3H+plzdHnJ
         WlZjWu4XnMQMyCAgpg8oHQzkM6FWuKjOHirQz/N3GkAafwxipP98xkJYuxT/rtJsgM05
         FD5d47LZfckSM6rAhNcEBy/soOLQtFEO5K24NAwWXugqgr/Fq/v1h7c6sLGgIzAawhKn
         h8gw==
X-Forwarded-Encrypted: i=1; AL+hErG/gECWbmhT/r4+SQhBB7yjjv9gYG6ALWZKA6tleqp7zvI7FglcmAATTI1+Hu7i10Ubw+0xSJ29qCIYqfgC9A==@lists.linux.dev
X-Gm-Message-State: APuU4Z93pf5tkCREQmTJTmw1ZZz1xFymQHVQrG7C0pcM+qaka4c/nMkJ
	nedp4D+fokcAVWisENyr30xf5zroTTg1jHLTwX4BtmL3LYTn6Fvge482WUeUVqWX728=
X-Gm-Gg: AZFdTZcxD5LZxkTcHDd2qDfIZtFPJeyN7fvJ1fbXtls0tXBHYDp2gSYRfRTng1VI1B2
	yfqJlctH/N1c5QO9uhkOwa2AEnya5/iwmncLulT3wVZm2qSfGMBAEZhU80fIPap5q1FNts6aIzF
	ZUdxYSLCAd3DO+vpmjXQpgrToSCSUZ5DIXrrDcJuARtcH3n42y6U6sM4QVCRNNXYsy/TxBI8iIs
	ZakV07C2L8LYRXDIRvEYBO1n0JyXqLzveDTh57trBidv1yBgL1a3quKZzW+oOC6q2iNSS6RxH4x
	5PL9L8ai2smAnGQOaSu/+vyrn0+oVzFmvjLW3hXKxkuvGYyCZZEywblW0+ggLl/kLbI+FSq8bFT
	rEqWNEVopP5bR5ogQlfQAYbfrBVm/DNKseIoFkdVcocVBESmufunyNaKNj5P0pzjcH7eXNbLxxi
	LS6IAyj9MH3nrBFvAxSxqW47RuKb6loPwNN6LmDmmHyynU+RInH15/+qDqVRfi1DWiJkIzvZ5zZ
	G5MmeLdfE37xBQkUdvUaNGQkVRf+//Q7mG7CXD/ALVMoqYU+WGlQZgqESamau6ZDTvVW7EcLbHb
	+lC7cY5hjUs7bWWR1Rpri3LwrDe7svfley17AJfdUd7yFXQGvdlAiNl28jhEBd0CctB8UCJ2aWY
	7acIwlu3C6lTjk/QT1F8BQ/g1ha6kIvb9Kmb37pY=
X-Received: by 2002:a05:6300:492:b0:3eb:a2d9:58f1 with SMTP id adf61e73a8af0-401493a61ecmr13003503637.9.1795543668120;
        Tue, 24 Nov 2026 10:07:48 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm7283156a12.15.2026.11.24.10.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 10:07:47 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 18:07:46 +0000
Message-Id: <DN3N3WXWFO3J.IQPVUAFZKE3B@etsalapatis.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Harry Yoo" <harry@kernel.org>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation>
In-Reply-To: <awWRZ9xCzWLnj_R6@thinkstation>

On Tue Nov 24, 2026 at 1:59 PM UTC, Harry Yoo wrote:
> [+Cc Relevant folks]
>
> And a bit of context on the underlying problem.
>
> kmalloc_nolock() could fail when there is a contention on locks
> shared across CPUs (e.g., n->list_lock in slab, zone->lock in buddy),
> or there is a decent amount of memory pressure. It's more restrictive
> than GFP_ATOMIC.
>
> Unconditionally using kmalloc_nolock() in BPF local storage is
> unnecessarily restrictive when the program can sleep or spin, and
> Emil's patchset teaches the local storage whether the BPF program
> accessing the local storage could sleep or spin on a lock.
>
> Answering the question "Does this context allow sleeping, or spinning
> on a lock" is extremely tricky in the Linux kernel as BPF programs
> could run and call kfuncs almost at any point in the kernel code and
> the "context" is usually encoded in the GFP flags or the process flags.
>
> Tracking whether certain locks are taken by current context is not
> ideal either as it adds unnecessary overhead for everybody.

Yes, we considered the page_alloc approach with Harry offlist and I think w=
hat
it comes down to is that one approach is the most turnkey for users while
the other has the clearest semantics. I went with the latter because
making the selection straight in the BPF code makes the behavior of the
top-level local storage alloc call ends up easier to understand and
explicit in the BPF subsystem.

>
> On Tue, Nov 24, 2026 at 06:40:11AM +0000, Alexei Starovoitov wrote:
>> On Mon, Nov 23, 2026 at 10:03 PM Emil Tsalapatis <emil@etsalapatis.com> =
wrote:
>> > +	/* Only try the spinning allocation when preemption disables are tra=
cked. */
>> > +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
>> > +	    size <=3D KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
>> > +		ptr =3D kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
>>=20
>> It works, but I after a bit of brainstorming the following
>> might be a better fix, since it will address the root cause:
>> Pls run it by Vlastimil, Harry, Sebastian.
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2fef409..4368ab5 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2536,6 +2536,24 @@ __rmqueue(struct zone *zone, unsigned int order, =
int migratetype,
>>  	return NULL;
>>  }
>> =20
>> +static DEFINE_WAIT_OVERRIDE_MAP(zone_nolock_map, LD_WAIT_CONFIG);
>> +
>> +/*
>> + * zone->lock is always held with IRQs disabled. A caller that runs wit=
h IRQs
>> + * enabled is not nested inside of it, so it can wait for the owner.
>> + */
>> +static bool zone_lock_nolock(struct zone *zone, unsigned long *flags)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || irqs_disabled() || in_nmi())
>> +		return spin_trylock_irqsave(&zone->lock, *flags);
>> +
>> +	/* The caller may hold a raw_spinlock_t. */
>> +	lock_map_acquire_try(&zone_nolock_map);
>> +	spin_lock_irqsave(&zone->lock, *flags);
>> +	lock_map_release(&zone_nolock_map);
>> +	return true;
>> +}
>
> I'm not sure this is a better solution unless this could be generalized
> or abstracted further.
>
>>  /*
>>   * Obtain a specified number of elements from the buddy allocator, all =
under
>>   * a single hold of the lock, for efficiency.  Add them to the supplied=
 list.
>> @@ -2550,7 +2568,7 @@ static int rmqueue_bulk(struct zone *zone, unsigne=
d int order,
>>  	int i;
>> =20
>>  	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
>> -		if (!spin_trylock_irqsave(&zone->lock, flags))
>> +		if (!zone_lock_nolock(zone, &flags))
>>  			return 0;
>>  	} else {
>>  		spin_lock_irqsave(&zone->lock, flags);
>> @@ -3237,7 +3255,7 @@ struct page *rmqueue_buddy(struct zone *preferred_=
zone, struct zone *zone,
>>  	do {
>>  		page =3D NULL;
>>  		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
>> -			if (!spin_trylock_irqsave(&zone->lock, flags))
>> +			if (!zone_lock_nolock(zone, &flags))
>>  				return NULL;
>>  		} else {
>>  			spin_lock_irqsave(&zone->lock, flags);
>>=20
>> pw-bot: cr

