Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA6449997
	for <linux-rt-devel@lists.linux.dev>; Fri, 31 Jul 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514077; cv=none; b=gCn/Y5DcdSrfqSa0N4hxsW4eiU256xr+HS4qKeERqG6LMiGG55511TuU3JML7sOfIjkFdwFuCQ5t/I9wzSbKYD1dt436/j8CCG9HDc7q2CujA+XOj1jO0ztnEapWCxUXJ9lMunbt0EkJu28yV9v/cJHu7pXGNfdAMmUu0ZneEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514077; c=relaxed/simple;
	bh=yIn3ZI55PT3p3aMIgV3uKJsaGHqW4wi0qXbNlZHzO8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX1RoMturjA8vAVPqTMwgZSsx62MAIVHnfDWWEVqIIQ2a3VpWcdVm3m3dtvc28fBIVVgLdk2DrKrb23BpUn34XInNW0rBGa6woqmWNqzBIrd3/B2BvIOd8l6qdBd1kKNhtt3J9H52IajM/4ZMCvRIV40iD+4P8w5V/QWKkjbR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JKkkznCu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JKkkznCu"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1677c91969so145209566b.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 31 Jul 2026 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785514074; x=1786118874; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6U4xkeRbg/Dy6P9bIARoaeErU2OYDju54UoGwSwPEnE=;
        b=JKkkznCuIBrKwe9g78akTgjJ9hnJHQBLJVZDdGEuLvKHJ8nnm40jazEeRZ2ew5TWcp
         u1e/d9NEbnwESGoWlk/52KYkEpUOx5PFniBABPTtfgEbmRr9BWn+SMYXuZisBHjbnC/J
         gMNDb0LfCVsDEmqoyczzeCJs8XWZKDk2SiuOVVNbPSFIaGwLWuiX8ScUyGMBhfXx9c6K
         eXvk+GGFkrpvcHL6NVHh2mIAgAw5NGJq3LutIKGlIDCUdrjsvn24NiVnE51qjilY45yr
         3mXc1VnFq0uf3cP3ofKyFKoRX4XLWit8qr6Q6frRnCmX5aDXDpyBAuuU0omx2WZlT3a3
         5fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514074; x=1786118874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6U4xkeRbg/Dy6P9bIARoaeErU2OYDju54UoGwSwPEnE=;
        b=m3y+MRv9oyxku013/PWpF7kW5zPP29SbBpp51jYiTBdzuMqWKC/hfz0pHuqvNPnp7i
         tY72nPcY8h2maaLqiFEzT2/Wb7ehXD1SDP16LOVIahacy1R2ICdR/Go5vna8TwV1cq+n
         HF2qZ0L5XQxfnkUrDhdm6QA/WqW7dN2IKO49kRydXPXmPqWpIEUEtwdle4+sYX8tKVNv
         Dcqb4HCuGxGmHJf9AofpjuSc6LtYiMSkZ/6Zr5EEGoPXAIgX2KrvIXNIc2gfD+vb/EhW
         lMz7qDav3iB8D2voIS0ujvzAz2ogxsQev3CdAJyEU0T7c5MVZIppSNgNDR+gTAckeqka
         M+Jg==
X-Forwarded-Encrypted: i=1; AHgh+Rqzggqo3OC9d1ZXeqkxM9uLeiLzls5xpVEW6KoznqpPcBKXZNsovwSB/Dpz3v5J9oB5DiyIa09VSaEhPtfkcw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+ZllhTk6/o7oaMyRi0fSxBAEsnxd6GVijCyyE58Qypn9lrPr4
	DoS9qEGy+9H+KMqg4G5a1iNsvelmt1DA5Y5zoTFH1GKtV7KFIIEzJoYHnoG5nn56D2I=
X-Gm-Gg: AR+sD10bt0i5AViTJOKCDOA13YjeDuHTQO7moFf3zCCu25hU433VCIwgk1ZTKDFAEGr
	EdH8ooWXiZo08mee6sPCL2s8yk3XLyoCRsuF/0lABuTDBAEmDcf+s9Bgww0PtQ5G5Bd9t1HV5Sh
	NWt5bAKzw24MD9+Q0C74uK/AiM07RN2lE7dKcZE5udiRaGyI1W7m3HT8RXYZGAtAL3prEwJBCtc
	AoKDvM6g/R+rZzD0aiUAyUIrPIXOurKbsvQryMiSveeXiVypF/htZkAAFBfm7ZGKQ2JeZvCw8yG
	dftXVHr+TdhhZGkaWONIjpAS+tbbHUld1ao81Tbb4tpx6k0CG783b8IZhqmaXENIHx/qjzEm+42
	40QEjhewqg3gflRXgAy/OBIMze74DMFkFFJA3rtePdG7tCMcF9PGXOn4M0SgBSWuYVzVTcCfpDS
	bT686Z0rYzDTaJp1510x782JbpU6knYxwG+W0qR7qkttanDDpku+BmYnRVlcYnPo/0cl/nNOj57
	g==
X-Received: by 2002:a17:906:6296:b0:c12:979c:5a5e with SMTP id a640c23a62f3a-c1fe7d654e4mr23406466b.0.1785514074192;
        Fri, 31 Jul 2026 09:07:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm6326785f8f.12.2026.07.31.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:07:53 -0700 (PDT)
Date: Fri, 31 Jul 2026 18:07:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: ruipengqi <ruipengqi3@gmail.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, bigeasy@linutronix.de,
	lance.yang@linux.dev, mhiramat@kernel.org, mingo@redhat.com,
	will@kernel.org, boqun@kernel.org, longman@redhat.com,
	clrkwllms@kernel.org, rostedt@goodmis.org, zhouyuhang@kylinos.cn,
	arnd@arndb.de, colin.i.king@gmail.com, ebiggers@kernel.org,
	inux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] hung_task: show the blocker task if the task is hung
 on rtmutex
Message-ID: <amzIVppBvLghHdRN@pathway.suse.cz>
References: <cover.1785376929.git.ruipengqi3@gmail.com>
 <4dd13bdf76de6ce1e4d825af9f393a5dd59f25e8.1785376929.git.ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd13bdf76de6ce1e4d825af9f393a5dd59f25e8.1785376929.git.ruipengqi3@gmail.com>

On Thu 2026-07-30 10:29:08, ruipengqi wrote:
> From: Ruipeng Qi <ruipengqi3@gmail.com>
> 
> Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
> lock types. Extend it to also cover rtmutex or rt_mutex-based
> implementations locks on PREEMPT_RT, so that when a task is hung
> on an rtmutex, the hung task detector can identify and report which
> task holds the lock.
> 
> On 64-bit systems, lock pointers are 8-byte aligned, so their three
> least significant bits are always zero. Use these bits to encode the
> blocker type.
> 
> Unlike semaphores, rtmutex has built-in owner tracking via lock->owner,
> so no additional bookkeeping is needed. The owner can be read with
> rt_mutex_owner().
> 
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -27,6 +27,7 @@
>  #include <linux/sys_info.h>
>  
>  #include <trace/events/sched.h>
> +#include <linux/rtmutex.h>
>  
>  /*
>   * The number of tasks checked:
> @@ -149,12 +150,15 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>  	blocker_type = hung_task_get_blocker_type(blocker);
>  
>  	switch (blocker_type) {
> +#ifndef CONFIG_PREEMPT_RT
>  	case BLOCKER_TYPE_MUTEX:
>  		owner = mutex_get_owner(hung_task_blocker_to_lock(blocker));
>  		break;
> +#endif
>  	case BLOCKER_TYPE_SEM:
>  		owner = sem_last_holder(hung_task_blocker_to_lock(blocker));
>  		break;
> +#ifndef CONFIG_PREEMPT_RT
>  	case BLOCKER_TYPE_RWSEM_READER:
>  	case BLOCKER_TYPE_RWSEM_WRITER:
>  		owner = (unsigned long)rwsem_owner(
> @@ -165,6 +169,12 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
>  					hung_task_blocker_to_lock(blocker)) ?
>  					"reader" : "writer";
>  		break;
> +#endif
> +#if defined(CONFIG_64BIT) && defined(CONFIG_RT_MUTEXES)
> +	case BLOCKER_TYPE_RTMUTEX:
> +		owner = (unsigned long)rt_mutex_owner(hung_task_blocker_to_lock(blocker));
> +		break;
> +#endif
>  	default:
>  		WARN_ON_ONCE(1);
>  		return;

On one hand, it is "elegant" to handle rtmutex the same way as
the other locks.

On the other hand, this adds a lot of if-deffery and
does not work on 32-bit systems.

Alternative solution would use the existing tracking,
something like:

	if (rt_mutext_blocking_task(task))
		owner = (unsigned long)rt_mutex_owner(rt_mutex_blocking_task(task));

, where rt_mutex_blocking_task() would be a racy public variant
of the existing task_blocked_on_lock(). Something like:

static inline struct rt_mutex_base *rt_mutex_blocking_task(struct task_struct *p)
{
	struct rt_mutex_waiter *waiter;

	waiter = data_race(READ_ONCE(p->pi_blocked_on)

	if (waiter)
		return data_race(READ_ONCE(waiter->lock);

	return NULL;
}

Plus, it would require using WRITE_ONCE() when task->pi_blocked_on
is updated to make sure that the value is always consistent
(valid pointer or NULL).

It would avoid the duplicate tracking in the rt_mutex code
and might be more acceptable for the rt_mutex maintainers.

Best Regards,
Petr
