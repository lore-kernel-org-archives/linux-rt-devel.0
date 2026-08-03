Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3922417BF8
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Aug 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768179; cv=none; b=QbDKheV3gqij0qEXdNfuwhqBcqdIn3rrd1MHJiBNyO3Orfr2Q7zUCuyaOoJG9cWCAWCLfYxmrB6viqfknQWJtedBu0G3e/enil5+kol9+4wlQTAWoOaKP0u0+Pa1Cabic5TCUH8F3DpEaeV6yfypH2gSYEKtonPB9kO8Bm4RYVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768179; c=relaxed/simple;
	bh=EIMB8g+z88ta9A0HnWeMgjH33RCEp8Sp+esA1vOK7ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJPbo1EQ7j1RVS1Qtc3Ft9yttx/9cdO/6xCITllxJbgLSWPzcfFvs0S/WLRYczTBed2KXP/lOawzKsHsabAhQjrPOY5BZu0O3ac7VJy/7DxqRXwCoh9oJCm+m1EbZ7T56XqNWiBMuj1IAftoivd8vO+Oni4dFo6THG5Hpv+JoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBPRCe+u; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBPRCe+u"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f236418so2726761b3a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Aug 2026 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768177; x=1786372977; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFGVOOUWX0mAMIEPaZoaW6dTQJKfd10arCkaEnydLf4=;
        b=sBPRCe+uqLN4QTBRS1sRZI82ohwyakvVq6NNAkn+Gvrn+h1JvoPPKmzszWZubp2QJY
         TqKQTcyTsc9tVZsuDaAp4xnaEndTcNWPUFyHdymlD5LaX8sLpi3qAAaedd7SSRPavf5S
         JGSfCU4bzRDd3NCLIQbX36pSX0u9KL/t9gbOUZYmMW0hryjoVRa2+TgBJbr3G5N/d7E1
         Z6VX9pQXNSH7HxuR+ZJFmUBx40Z5N+ePZIbnCbOwK1Mje9YodDuHMH/rnGpCVmkI/9cV
         9D9b2sPH/ikbdtkHOktwyV6aRxpo8VieutlDdYJzuyC7eDMirzCZukn6MkO09FFDRm4A
         OApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768177; x=1786372977;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFGVOOUWX0mAMIEPaZoaW6dTQJKfd10arCkaEnydLf4=;
        b=r9PWKI24xM8cElR2XNGHAD8ditQlHlO4IuN0uSL+dqYfTBX4uMNDTTbEijz3UsKv6Q
         dUNdVthnJPNQc12p9xIH27u7UQs/QWPHXHihfta/2lAlxW4Z4yWwRZ+HymG6xsvj3krg
         1f78y08dzV4j0n1ukOnAnDmO8tfxk1ir0TyDNtwI3KMDPbu1B8KIWbtdA9cdEMBaQxjy
         jiCwLT/Amuw1r6ZznWczxNHmnUV43OCc5cuVyNkiyU7vHq2Mt31vvvaNurmJYS/gV2GS
         jXNlqKibwuoa+HZ0OheZUuYI8+lV9Vsowrll2qjlhCoFtdBZEoPxAvjKQ0KbIo0rPpaQ
         C4VA==
X-Forwarded-Encrypted: i=1; AHgh+RrJrnCPSOUTPzaQN6JOCSV4ARH1ntdKwgv28IGQo6evuv48ISZvts3j5hvQ3+PpC9XJKzRPg6hs1I3R5odM1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHgP/TWvhsdSlT7eP9I2fa3nC9ANttMGxNAzvgCgYQtrt3NnzZ
	YP8Zn3Bhks2hBkeciomppzSoaE4fbv2SwjjPoJwznV+6nsQijvMzpPkp
X-Gm-Gg: AR+sD11GFrwrknLIpZ1KCxiMh/pU8l4brRBzdKzn53wEwve877Kx+mvCfdSURl7ghTV
	6oWuEWxImI54fEAe0txau4oq02wf9tAI53KunFFe7msUrzLeFnFNTURT9pHtrO4sPkF5ROCOi7l
	pd7gXAOG81KLoEc8zDbBwMsdW1mpB31puMDN3U4y7RVM35om5hQSQul4HY4z6cl9Kn5I88TgX5X
	AMMHPv1UgZrc0ZKAXghZr2LoGjEpjPjIee21vlyv0WU7jQ/49YDNb6ZSZY8DZHFrwdzlqt80A8m
	fpWL9ngGIAV9rZEcViKCtPQeyE5qNLc4YXpxrP2ndgQqlAo1iYYJZix4qo44BqjRkpBW8UV5fsf
	Kd8xx/XVn+xoCoS+fJ0IW02Pjg4Dl6b0kk+QS/VucT11PdpYxFVO0Zi+fZLW+zZ2cA9y5QMdBGL
	CMJlS082i/XFOdpZuEsTCRKphG3NvhIkU4CUJ/xVWKtTDqNVzMeWdjENMEs9uigVbVTli7Ru8jB
	08=
X-Received: by 2002:a05:6a00:2887:b0:84e:52d0:69cb with SMTP id d2e1a72fcca58-84ee4988987mr9565872b3a.75.1785768176779;
        Mon, 03 Aug 2026 07:42:56 -0700 (PDT)
Received: from [10.121.80.58] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc4237e5sm3744982b3a.59.2026.08.03.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 07:42:56 -0700 (PDT)
Message-ID: <310a8931-414a-4dae-b2f5-f8614e52ac2f@gmail.com>
Date: Mon, 3 Aug 2026 22:42:48 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: show the blocker task if the task is hung
 on rtmutex
To: Petr Mladek <pmladek@suse.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, bigeasy@linutronix.de,
 lance.yang@linux.dev, mhiramat@kernel.org, mingo@redhat.com,
 will@kernel.org, boqun@kernel.org, longman@redhat.com, clrkwllms@kernel.org,
 rostedt@goodmis.org, zhouyuhang@kylinos.cn, arnd@arndb.de,
 colin.i.king@gmail.com, ebiggers@kernel.org, inux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <cover.1785376929.git.ruipengqi3@gmail.com>
 <4dd13bdf76de6ce1e4d825af9f393a5dd59f25e8.1785376929.git.ruipengqi3@gmail.com>
 <amzIVppBvLghHdRN@pathway.suse.cz>
Content-Language: en-US
From: Ruipeng Qi <ruipengqi3@gmail.com>
In-Reply-To: <amzIVppBvLghHdRN@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/1/2026 12:07 AM, Petr Mladek wrote:
> On Thu 2026-07-30 10:29:08, ruipengqi wrote:
>> From: Ruipeng Qi <ruipengqi3@gmail.com>
>>
>> Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
>> lock types. Extend it to also cover rtmutex or rt_mutex-based
>> implementations locks on PREEMPT_RT, so that when a task is hung
>> on an rtmutex, the hung task detector can identify and report which
>> task holds the lock.
>>
>> On 64-bit systems, lock pointers are 8-byte aligned, so their three
>> least significant bits are always zero. Use these bits to encode the
>> blocker type.
>>
>> Unlike semaphores, rtmutex has built-in owner tracking via lock->owner,
>> so no additional bookkeeping is needed. The owner can be read with
>> rt_mutex_owner().
>>
>> --- a/kernel/hung_task.c
>> +++ b/kernel/hung_task.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/sys_info.h>
>>   
>>   #include <trace/events/sched.h>
>> +#include <linux/rtmutex.h>
>>   
>>   /*
>>    * The number of tasks checked:
>> @@ -149,12 +150,15 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>>   	blocker_type = hung_task_get_blocker_type(blocker);
>>   
>>   	switch (blocker_type) {
>> +#ifndef CONFIG_PREEMPT_RT
>>   	case BLOCKER_TYPE_MUTEX:
>>   		owner = mutex_get_owner(hung_task_blocker_to_lock(blocker));
>>   		break;
>> +#endif
>>   	case BLOCKER_TYPE_SEM:
>>   		owner = sem_last_holder(hung_task_blocker_to_lock(blocker));
>>   		break;
>> +#ifndef CONFIG_PREEMPT_RT
>>   	case BLOCKER_TYPE_RWSEM_READER:
>>   	case BLOCKER_TYPE_RWSEM_WRITER:
>>   		owner = (unsigned long)rwsem_owner(
>> @@ -165,6 +169,12 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>>   					hung_task_blocker_to_lock(blocker)) ?
>>   					"reader" : "writer";
>>   		break;
>> +#endif
>> +#if defined(CONFIG_64BIT) && defined(CONFIG_RT_MUTEXES)
>> +	case BLOCKER_TYPE_RTMUTEX:
>> +		owner = (unsigned long)rt_mutex_owner(hung_task_blocker_to_lock(blocker));
>> +		break;
>> +#endif
>>   	default:
>>   		WARN_ON_ONCE(1);
>>   		return;
> On one hand, it is "elegant" to handle rtmutex the same way as
> the other locks.
>
> On the other hand, this adds a lot of if-deffery and
> does not work on 32-bit systems.
>
> Alternative solution would use the existing tracking,
> something like:
>
> 	if (rt_mutext_blocking_task(task))
> 		owner = (unsigned long)rt_mutex_owner(rt_mutex_blocking_task(task));
>
> , where rt_mutex_blocking_task() would be a racy public variant
> of the existing task_blocked_on_lock(). Something like:
>
> static inline struct rt_mutex_base *rt_mutex_blocking_task(struct task_struct *p)
> {
> 	struct rt_mutex_waiter *waiter;
>
> 	waiter = data_race(READ_ONCE(p->pi_blocked_on)
>
> 	if (waiter)
> 		return data_race(READ_ONCE(waiter->lock);
>
> 	return NULL;
> }
Thanks to Petr, Lance, and Xusheng for the feedback.

One concern with the alternative approach is that 'waiter' is typically 
allocated on the stack (for instance, in __rt_mutex_slowlock_locked()). 
If the blocked task gets woken up and resumes execution, its stack frame 
is destroyed and the 'waiter' structure becomes invalid.

Since the hung task detector reads p->pi_blocked_on asynchronously 
without holding the lock, dereferencing waiter->lock could lead to a UAF 
race condition if the waiter is destroyed concurrently. Therefore, the 
first solution (encoding the blocker type in the pointer bits) seems 
safer, as it avoids dereferencing a potentially stale stack pointer.

I am currently preparing the V2 patch to address the issues you mentioned.

v2 changes:
  - Reduce #ifdef-deffery.
  - Remove the unused function debug_trace_blocker.
  - Clean up and update relevant comments.

Best regards,
Ruipeng
> Plus, it would require using WRITE_ONCE() when task->pi_blocked_on
> is updated to make sure that the value is always consistent
> (valid pointer or NULL).
>
> It would avoid the duplicate tracking in the rt_mutex code
> and might be more acceptable for the rt_mutex maintainers.
>
> Best Regards,
> Petr
