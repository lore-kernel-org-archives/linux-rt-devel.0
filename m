Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631847;
	b=RbhXKZUl2xo2KidD69vjIoWG7NiJKR+WePkBL0B0GH73VMNRq7Z3fNQ9FaL5+RU86oKs
	 jvav0/f7M0c5qfuQP/lhEeLfEitStHivT4EC9IxkVJ4J+HpUbyb0FZH6wypR3Gjcjv7BT
	 PC+2a0+F/waiFanZ+YkTKOoulpfGgjf7OLcEmQjf1gWrSYhd3aDUNalvTi8Pc5YNJzB/2
	 D8lVC7/uFlA9gc8Qx+L7rfUA0dCL0WD79gd1151ZpLTFfErUJanzCSpfYpIfx1F4YzmyP
	 7ix3WsLHb1BLel1ciQOJ7XOUDyAijTH7mSBgfTtld7a0cvyWrtCDQCbq0v9Z+DpdBpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631847;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=n4unYGnEJXc0oP4c3ZRlr/4xZ+BPjwJpmxhBX5TZrqU=;
	b=yBYJFpalLHocpTXdipOInn86/xcEUZFEUYo9E7Jfk7G5MQaPAougwfhbLDP3/Cp8l5Im
	 H4wcDEpVVuc8APc/0CRhE5rsleQl90YKEUm8LeHlj62lO/R7cBGqP9/2jPQ55NMNlIQCj
	 mQr/TIpNaw7iIXdnruTvDHY6/Wi09cYL5XWXFSk7/ZDAPOSLNKLDX4XNFAtCWCN0v2Wbp
	 7Ef3K4061/JZRk/nkQknRSSY0TfNbQh3xkykmkzt2psIV0uroivBq8erj2rIpQXRyMZZ8
	 31ABCUh5W654Iyi1SANMb1/eqguaISoYpHFH2xJUxAhsACY/eioOic/h3hNjp3c9Wqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mzm00P57;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFC6083E23
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EFC6083E23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mzm00P57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793631845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4unYGnEJXc0oP4c3ZRlr/4xZ+BPjwJpmxhBX5TZrqU=;
	b=Mzm00P577bi4C8lLGhoLowlDlWqg9C9OMGYYvBqDHwKuAnccCZ2+2bOaVI1FpkWhELZCV0
	IXldUehjf5GGgYbfvB7ZfGwSGRgHkBNj2Fzc8EukVeCXC9kKX1S9/baCyMitDvh/tN00ZV
	udUldYtBYLz+dx93oorfCDdKgtV49xc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-RbAmLUxcNdSOd9T-77OXZg-1; Mon,
 02 Nov 2026 10:04:00 -0500
X-MC-Unique: RbAmLUxcNdSOd9T-77OXZg-1
X-Mimecast-MFC-AGG-ID: RbAmLUxcNdSOd9T-77OXZg_1793631836
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47AB519772E2;
	Mon,  2 Nov 2026 15:03:56 +0000 (UTC)
Received: from [100.91.18.181] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EC59433;
	Mon,  2 Nov 2026 15:03:53 +0000 (UTC)
Message-ID: <4146798a-5f0a-4bae-af6c-90d2b894aced@redhat.com>
Date: Mon, 2 Nov 2026 10:03:52 -0500
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
To: Andrea Parri <parri.andrea@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
 Hui Su <sh_def@163.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261102134606.242743-1-parri.andrea@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20261102134606.242743-1-parri.andrea@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 50mMq-8XQhZ148sqi7KJqFjD8RYCQZV5xhFw2Yu8tew_1793631836
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/2/26 8:46 AM, Andrea Parri wrote:
> A sched_setattr() with SCHED_FLAG_KEEP_POLICY on a SCHED_DEADLINE task
> unlocks cpuset_mutex twice if the task's policy changes concurrently:
>
>    WARNING: bad unlock balance detected!
>    7.4.0-rc1 #1 Not tainted
>    -------------------------------------
>    repro/126 is trying to release lock (cpuset_mutex) at:
>    [<ffffffff9a17cacc>] __sched_setscheduler+0x9cc/0xc40
>    but there are no more locks to release!
>    ...
>    Call Trace:
>     print_unlock_imbalance_bug.part.0+0xfb/0x110
>     lock_release+0x286/0x2e0
>     __mutex_unlock_slowpath+0x1a/0x400
>     __sched_setscheduler+0x9cc/0xc40
>     __x64_sys_sched_setattr+0xa3/0x1b0
>     do_syscall_64+0x106/0x5f0
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> __sched_setscheduler() samples p->policy before taking any lock, and
> restarts from the recheck label if p->policy differs under the rq lock.
> The restart drops cpuset_mutex but leaves cpuset_locked set, so a pass
> that no longer needs the mutex still unlocks it on its way out:
>
>    CPU 1                                CPU 2
>    __sched_setscheduler(KEEP_POLICY)
>      policy = p->policy /* DEADLINE */
>                                         __sched_setscheduler(SCHED_OTHER)
>                                           p->policy = SCHED_OTHER
>      cpuset_locked = true
>      cpuset_lock()
>      rq = task_rq_lock(p)
>      oldpolicy != p->policy
>        cpuset_unlock()
>        goto recheck
>      /* no cpuset_lock() this time */
>      ...
>      if (cpuset_locked)
>        cpuset_unlock()
>
> Without CONFIG_DEBUG_MUTEXES, or CONFIG_DEBUG_RT_MUTEXES on PREEMPT_RT,
> nothing warns. The second unlock still clears the owner field regardless
> of who holds the mutex, so another task can lose cpuset_mutex inside its
> critical section. Entering SCHED_DEADLINE needs CAP_SYS_NICE, but a
> racing caller that owns the task does not need it if it samples a policy
> other than SCHED_DEADLINE.
>
> Clear cpuset_locked when dropping the mutex for the restart. This should be
> safe because the flag is only tested on the paths leaving the next pass,
> after that pass has set it again if it took the mutex.
>
> The following program, run as root, reproduces the splat, which no longer
> appears with this applied. On PREEMPT_RT it crashes the kernel within
> seconds, which this also fixes:
>
>    #define _GNU_SOURCE
>    #include <pthread.h>
>    #include <stdint.h>
>    #include <sys/syscall.h>
>    #include <unistd.h>
>
>    struct attr {
>        uint32_t size, policy;
>        uint64_t flags;
>        int32_t nice;
>        uint32_t prio;
>        uint64_t runtime, deadline, period;
>    };
>
>    static volatile int stop;
>    static volatile pid_t target;
>
>    static void set(struct attr a)
>    {
>        a.size = sizeof(a);
>        syscall(SYS_sched_setattr, target, &a, 0);
>    }
>
>    static void *sleeper(void *arg)
>    {
>        target = syscall(SYS_gettid);
>        while (!stop)
>            usleep(1000);
>        return arg;
>    }
>
>    static void *switcher(void *arg)
>    {
>        while (!stop) {
>            /* SCHED_DEADLINE, 2us every 1s */
>            set((struct attr){ .policy = 6, .runtime = 2000,
>                               .deadline = 1000000000,
>                               .period = 1000000000 });
>            set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
>        }
>        return arg;
>    }
>
>    static void *racer(void *arg)
>    {
>        /* KEEP_POLICY | KEEP_PARAMS */
>        while (!stop)
>            set((struct attr){ .flags = 0x18 });
>        return arg;
>    }
>
>    int main(void)
>    {
>        pthread_t t[5];
>        int i;
>
>        pthread_create(&t[0], NULL, sleeper, NULL);
>        while (!target)
>            usleep(100);
>        pthread_create(&t[1], NULL, switcher, NULL);
>        for (i = 2; i < 5; i++)
>            pthread_create(&t[i], NULL, racer, NULL);
>        sleep(30);
>        stop = 1;
>        for (i = 0; i < 5; i++)
>            pthread_join(t[i], NULL);
>        return 0;
>    }
>
> An LLM helped find the PREEMPT_RT crash and write this patch and its test.
>
> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> Sashiko reported this while reviewing [1], which adds another exit from
> the second pass. The bug does not depend on that patch.
>
> Tested on x86_64 with lockdep and DEBUG_MUTEXES: the splat fires without
> this patch and not with it.
>
> Also tested on PREEMPT_RT with lockdep, with DEBUG_RT_MUTEXES only and with
> neither: each kernel oopses within seconds without this patch, and runs
> clean for 30 seconds with it.
>
> The 2us reservation only keeps the test running: tasks leaving
> SCHED_DEADLINE while asleep leak total_bw [2], so a 1ms/10ms reservation
> stops being admitted after 38 switches on 4 CPUs, and 2us after about 2
> million.
>
> [1] https://lore.kernel.org/20261016062629.2102883-1-sh_def@163.com/
> [2] https://lore.kernel.org/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
>
>   kernel/sched/syscalls.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 45a127deeadd9..2af550f92ac65 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -640,8 +640,10 @@ int __sched_setscheduler(struct task_struct *p,
>   	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
>   		policy = oldpolicy = -1;
>   		task_rq_unlock(rq, p, &rf);
> -		if (cpuset_locked)
> +		if (cpuset_locked) {
>   			cpuset_unlock();
> +			cpuset_locked = false;
> +		}
>   		goto recheck;
>   	}
>   

LGTM

Reviewed-by: Waiman Long <longman@redhat.com>

