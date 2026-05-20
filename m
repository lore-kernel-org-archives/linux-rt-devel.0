Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649473F7884
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300632; cv=none; b=QlBJPaAn5m1m0FfaGbl/Ttq12KwY3GLfymfQsyf1ne0HmHJajw0Lpy2jx8kjdXCPW2SbrNZZ2V4RYP+YvATJfwL/vFjreGeXHnGehcSvskztDIb0NHQNDcDlBl09HshHv60H90vjcFgaXCb8zskNqjgHHHxibV+6WPhSAK6fRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300632; c=relaxed/simple;
	bh=M9J6eZGUyouMkq3hOwUqUbCB9eDjuAT60DVZRvVgx+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fx0/QWdDjstac7V+U+fel4FLnQFB4j0nA9rauPOXvdc6G5t968nalhP/Q44scEc+FB0GaJOchc0Z6p8zoIca+tJoc2oTJ7U9q67PNwH/KzGys/mSQpSN2OCFTLs/ObOZdxBqzoeDlO5KVgrYXwMwhsqYAM+EI6cOnTdgrEG4iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZkpPq62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZkpPq62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779300630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTn4epUBJ3eZleKoLAJNaMq1fDbCpUJmP9YHIsQfwOY=;
	b=LZkpPq62fMJZITUNGAzKN9kYC2CPEWGmkmdFEAkFZaaXLWQg5Yo64Z+ywrQrrXhlhuiZQZ
	76wo5WvtInlflEaTGut3MTlM6Gze7VjNkGmIsxEZPdG5rOVfhkF1TCaGtMrPbjvqQq2Azs
	h0S0lC7BiazNCH5EcahDy2zpNg18qmY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-wNRtxTplMM-uYZeK5iclJg-1; Wed,
 20 May 2026 14:10:24 -0400
X-MC-Unique: wNRtxTplMM-uYZeK5iclJg-1
X-Mimecast-MFC-AGG-ID: wNRtxTplMM-uYZeK5iclJg_1779300623
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EDFE195609D;
	Wed, 20 May 2026 18:10:23 +0000 (UTC)
Received: from [10.22.64.248] (unknown [10.22.64.248])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B109719560A2;
	Wed, 20 May 2026 18:10:21 +0000 (UTC)
Message-ID: <d2ce1a71-6f8a-404a-9dd0-dfa3d9f68145@redhat.com>
Date: Wed, 20 May 2026 14:10:20 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugobjects: Don't call fill_pool() in early boot
 non-task context of RT kernel
To: Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260520164349.921226-1-longman@redhat.com>
 <3fc2e03f-d34f-4b87-8421-e28e94247757@redhat.com> <87qzn6vtxq.ffs@tglx>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87qzn6vtxq.ffs@tglx>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 72nEVo17r3IyLjn5iR8G2R_40DUkvUj6xA5x-sMx9vo_1779300623
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/26 2:04 PM, Thomas Gleixner wrote:
> On Wed, May 20 2026 at 12:57, Waiman Long wrote:
>> On 5/20/26 12:43 PM, Waiman Long wrote:
>>> It shouldn't really be a problem as fill_poll() will not called from
>>> non-preemptible context after early boot, but the lockdep warning can
>>> still cause confusion and anxiety. Fix that by further restricting the
>>> call to only in_task() context during early boot.
>> Sorry, the above paragraph isn't right. Will send out a v2.
> And please trim the back trace while at it.
OK, will send a v3.
>
>>> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>    lib/debugobjects.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>>> index 12e2e42e6a31..236ea5e716df 100644
>>> --- a/lib/debugobjects.c
>>> +++ b/lib/debugobjects.c
>>> @@ -727,11 +727,14 @@ static void debug_objects_fill_pool(void)
>>>    
>>>    	/*
>>>    	 * On RT enabled kernels the pool refill must happen in preemptible
>>> -	 * context -- for !RT kernels we rely on the fact that spinlock_t and
>>> +	 * context or in task context during early boot.
>>> +	 *
>>> +	 * For !RT kernels we rely on the fact that spinlock_t and
>>>    	 * raw_spinlock_t are basically the same type and this lock-type
>>>    	 * inversion works just fine.
>>>    	 */
>>> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
>>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() ||
>>> +	   (system_state < SYSTEM_SCHEDULING && in_task())) {
> Conflicts with:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/urgent
>
Will rebase it to tip.

Thanks,
Longman

