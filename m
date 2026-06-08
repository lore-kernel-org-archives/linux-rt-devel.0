Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB831197C
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885330; cv=none; b=Omqf7q+EBt3p/XjwOsf0HVxooFuoWteuqvTvvhNO6BJKMofSsS86V5EtvZjZ0hq8VUw8xurG9VD1oFgjA51O5W2NZqcLY97adj5ul2MlzGUvgb8TpraiKBEStBxe8lPgZGBWz0ukCVapdft4idDglwBAVGn1swMmXz99E0gyXYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885330; c=relaxed/simple;
	bh=yBcwxfno4nWAj3Uj7ltcBVg4Xsp9mT+NJrtHENWbaH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWMqyAV9dcQjcokad/1sxbRdPYONszYS8Q8QjAzVJu3zf3VKmBjblJsMwJu5ONV+qg2nX5VajGsw3xwdY4KLHf2+T16b3PSTaUl/M9IiRg11XULZTFPmp6KYio2u9xA6vZuqANSEQDrwg8LG+qQgmymtI94h4do6Vs5Gk1cFGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq5LKpKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq5LKpKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780885328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVpugBYUPu/REUSH123I3T+dvBgdgeTreN5r26Hty7U=;
	b=Xq5LKpKUb7ELa2W2WN61mw5EL32j3uHZ+3uUr8OQC7HuQIkdTLM4i6YLWzGLf2W5DZYgeY
	Hu81O5Mr2HBkdPXxuQLuJEk2vPag2mEhzVOIayyiEBPUa1MEMkGv9VES2z70vEJ2HXq6X/
	h1N8z5KThW/h4Ck3qBLHzfnFlFAaHdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-y_SAc3oOMOuEz221GkN_Og-1; Sun,
 07 Jun 2026 22:22:02 -0400
X-MC-Unique: y_SAc3oOMOuEz221GkN_Og-1
X-Mimecast-MFC-AGG-ID: y_SAc3oOMOuEz221GkN_Og_1780885320
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFAB0180034B;
	Mon,  8 Jun 2026 02:21:59 +0000 (UTC)
Received: from [10.22.88.52] (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4655330001BE;
	Mon,  8 Jun 2026 02:21:58 +0000 (UTC)
Message-ID: <445b741f-c36e-4b20-ab0a-4a2215489eba@redhat.com>
Date: Sun, 7 Jun 2026 22:21:57 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] debugobjects: Don't call fill_pool() in early boot
 hardirq context
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260605173038.495075-1-longman@redhat.com>
 <aiT-Wp4rAvJoN6iG@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <aiT-Wp4rAvJoN6iG@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: dVrCGwr-xq7FdFqtSnCUAHLdXYYcckcxfUI5cFFUd-E_1780885320
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/26 1:15 AM, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> When booting a debug PREEMPT_RT kernel on an arm64 system with grace
>> processor, a "inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage"
>> lockdep warning message was reported to the console.
>>
>> During early boot, interrupts are getting enabled before the scheduler
>> is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
>> can fire and attempt to fill the pool from within the hardirq. This can
>> lead to a deadlock the interrupt occurred while in the memory allocator.
>>
>> Add a new can_fill_pool() helper and reorder the exception rule and
>> forbid this scenario by excluding allocations from hardirq.
>>
>> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
>> Co-developed-by: Waiman Long <longman@redhat.com>
>> Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   lib/debugobjects.c | 46 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index b18a682fe3da..6fb00e08a4e2 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
>>   #endif
>>   }
>>   
>> +static inline bool can_fill_pool(void)
>> +{
>> +	/*
>> +	 * On !RT enabled kernels there are no restrictions and spinlock_t and
>> +	 * raw_spinlock_t are the same types.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> +		return true;
>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
>> -	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
>> +	if (can_fill_pool()) {
> Would have been nice to have this as two patches: first one
> factors out the check into can_fill_pool() without changing the
> logic, while the second one applies the fix to can_fill_pool().

OK, I will send a v6 patch as suggested. However, Thomas had merged the 
v5 patch into tip. I am fine whether it will be one patch or 2 as long 
as the problem is going to be fixed.

Cheers,
Longman

