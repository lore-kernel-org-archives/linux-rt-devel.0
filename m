Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6323F7A9F
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300277; cv=none; b=VV3dMEBxS0vsRgc68UuLN3yluadzhRv2kazqMw7CxeCvsnyFIXtCfDMEekSWy0w3Jjioh4MmS01hgc2R0O38h2qdHnGt0d5625Dzgv1cN/DI1yNznpPTjbCOhsQReKyu4PZ6DAWy32s9UltIVL+6SIdO2Z8NVabglRKslWJr6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300277; c=relaxed/simple;
	bh=okgr/RUfOGWGmNgrNESgfqcCUrt32FVHkP4aHgJFoD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKoSqil6enbp0mNszg+8CcwSaGsBHG5uTtPMvfFfCzfey60rIz+hfEB5gi0AEGNUAAuf96W1RULwjwLph8bc38QKzBUSrNB6KjMgIYxwGh1lVn69kvXOvpMBBaV3b1VV5yj4UjuxY/n0aDmKmLIvY/PJnzoyvJ0+x2CL0ufcGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qktsx0CS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f2yuyTQF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qktsx0CS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2yuyTQF"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779300274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thK8RZrCyOiIwsNBf7vv49vQI/h0eDeAVUJZhsiHlaA=;
	b=Qktsx0CSdG3oLkN2ii9MrI7krWXVwNFUYTdn7Y2KWgvKw//y04i8zXgAkcluh2BEJ501oZ
	RZeKqZZh13jKDdy3voXTIWTCQW4kIBcFxsN9Uj6GerHITHV7b1JryL5wWwQyOMtUikKdLz
	B/Fp0in6XyiJd67jT6IP0MsN2uGQyi6eMCyjSKwRzAzs8HIGt0cZpWAiOSxekkSRCsXie0
	jw4kmR4mciAz0dMTe1wsEmujN78OUWb3g6uiXndlhwRSEsjPZPI2vpooGy1KIG8tA8CRb6
	chT4lx39AzLlMvix5jRlAeQQ7OocJbo7pXXjM0XjngVuUKwYh5f5rfQ5MzohDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779300274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thK8RZrCyOiIwsNBf7vv49vQI/h0eDeAVUJZhsiHlaA=;
	b=f2yuyTQFZ7VedtGowbGS+b1FbxCtyDyFiuJHxXBhCd7K6jBkI3BylBQE812SiI4+E8n/hS
	u9XkCrdwF1shwuCg==
To: Waiman Long <longman@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] debugobjects: Don't call fill_pool() in early boot
 non-task context of RT kernel
In-Reply-To: <3fc2e03f-d34f-4b87-8421-e28e94247757@redhat.com>
References: <20260520164349.921226-1-longman@redhat.com>
 <3fc2e03f-d34f-4b87-8421-e28e94247757@redhat.com>
Date: Wed, 20 May 2026 20:04:33 +0200
Message-ID: <87qzn6vtxq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 20 2026 at 12:57, Waiman Long wrote:
> On 5/20/26 12:43 PM, Waiman Long wrote:
>> It shouldn't really be a problem as fill_poll() will not called from
>> non-preemptible context after early boot, but the lockdep warning can
>> still cause confusion and anxiety. Fix that by further restricting the
>> call to only in_task() context during early boot.
>
> Sorry, the above paragraph isn't right. Will send out a v2.

And please trim the back trace while at it.

>> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   lib/debugobjects.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index 12e2e42e6a31..236ea5e716df 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -727,11 +727,14 @@ static void debug_objects_fill_pool(void)
>>   
>>   	/*
>>   	 * On RT enabled kernels the pool refill must happen in preemptible
>> -	 * context -- for !RT kernels we rely on the fact that spinlock_t and
>> +	 * context or in task context during early boot.
>> +	 *
>> +	 * For !RT kernels we rely on the fact that spinlock_t and
>>   	 * raw_spinlock_t are basically the same type and this lock-type
>>   	 * inversion works just fine.
>>   	 */
>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() ||
>> +	   (system_state < SYSTEM_SCHEDULING && in_task())) {

Conflicts with:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/urgent
