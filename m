Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702441;
	b=wfcG4ORxmIrXiMp0rHKCA3x4BkkHQqgkQUslmxO8Tl6NsETmAhOb29mB30QBNOhS7anl
	 de/aRNhtkr2kEHskre/5Hluv2RMuQWrGI0fw/IkEtN0fTkqOllR80+BCoW3jPBGzGlc8t
	 u/9j8u1xHanzola9DvMYrHeC6H+pLpaXFxe1QobMRTIHBL5IVr/Qh8/LA68vD4Nh8xasv
	 nuiJguZPbuexh5XKHCaaMN3Y6ZDbR+0qmfSmVSUMA8efS42mQYaOsQblNT6c6H94f/k6S
	 J/OpJH+HDyFHtQsz7crFmpmlK9KhfUKH12fCKg9jAC00n8O9o0iNSoEOMZKU+jZw3Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702441;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=NZQ/jxaXhmx3+NGsx5iUfLAnkKxEwFa1sS+NnNdS1BU=;
	b=1UNhytMwTPjHvZHVNhiSt8DFI+iYZd4/jflYtX2ftcJVb/n2pW/QXdh4Jqe7lJ4NWxhn
	 2En6mlVDkunFI9cxjkYkaeBZrf2Z85pGkErK0OKuQBFT9Z5Q0/TFf6FelkLHXalg5BR1k
	 VAUKPps0kqKseVIA3HRhfAZ0yOUlbbbSuYnZ7VhBmHaH1ihJghRPwUxHK5iPelUfSSc0x
	 KU+BFgH9v3F9K45fd9CnPN+naTHU9qUZKlcU6qOT2+WtuLC12WkwyOiHxKW8dFoDvE1Sy
	 ufPeWjrdb84bRWNJsuRi+dx4xHirsc9vHulGc7fMDcFY+Qml+xM09L+/TIfwbcG98tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlzFpAOC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3232606B103
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 10:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3232606B103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlzFpAOC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793702439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NZQ/jxaXhmx3+NGsx5iUfLAnkKxEwFa1sS+NnNdS1BU=;
	b=MlzFpAOCLJgZvfL6rAX08CeOZnHwz2WJ1jZpFrXadUDzNm1S8Bof2UajWf+OOHNYeo62mc
	nWC0n4v2Apt8KrW1xg0Q6c4GcU9nZ6neRK9n026O7J/VSX5lp8xdpV4JG0yArdhc3Sx831
	2fAKE6NUGwFY9gESdB/eU6J+7gH/3L8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Q6-XzITYP8eVbC6lmH5C3g-1; Tue, 03 Nov 2026 05:40:38 -0500
X-MC-Unique: Q6-XzITYP8eVbC6lmH5C3g-1
X-Mimecast-MFC-AGG-ID: Q6-XzITYP8eVbC6lmH5C3g_1793702437
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so2146451f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 02:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702437; x=1794307237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZQ/jxaXhmx3+NGsx5iUfLAnkKxEwFa1sS+NnNdS1BU=;
        b=xhjwaNhJgzoN3+fEVqE6diL51mujfYiLbUAGoiQpKZ6gQQAh/XxD2v4GkAKwMJJQUj
         L/mun9YcwjUCxYCGCIWOZDclxin263t0yp4TFZO9EP0sImHcwtc4nKVRgsc+bbdSyqbe
         ft8HDM5I3Chj91V1lBwNuAbpelrWN0eBqK88gJmPQcqzQAl7qJdxBpxMyFbvr9Eos4Gy
         5hrfwOpXJicCldwKUrZjTMkmPDVHdJMS/h68Hd1HDRE5F4bBWcXvIhrK0mBO9i6pSkJJ
         xrkLIcB2zyRQha3GsFSH2ap1eOo1XtfcHMAmAe77qoM+BWiSZet0Jq9spyD60asm4vrG
         wQLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgCdod6i6aA7ivF/Yf+IafFBhPa9TbMQzLDrn26DXAPAU7or6qeOm1B6pw52F47WAFm5rSDLo71qeviwfNjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zz/wXDZT9s48XSqurKDYoUXf4g0shuEzopLuJu0e/vCiZKw5D
	SXuCai4XqtWEPHP7LYfarVxWz9QdTqEzj0zkcYYAqaKIj37tCzU84OHb8sGNGaQj15HmQj5UgFd
	xCoGKhDJkyM8J/1miT7qTXrXJlvWHX11uuEbSadfbc7paRPE+F47YSX0f+dZwBkNKgv6M
X-Gm-Gg: AYBFou1b6hiGfX4bFDAV79ldd3Lsz6eGzlEju6hInKi2/wByIjSMnLYuCcFTDzHvlRy
	1LRupDO516WIRMqJi/uU0eLetYe5fsvyMWBD2WWKYdD/AAtRxNgGPrQRNJ+bmcnDAszsPIBLg1Y
	fF6ifK98VsVPitas5+7S8t83098c+ZPchrUrgo2PW8koMn5I4QONaIriaH5DpL5tNYAQCK0+yAQ
	YNd+PNoo85wYWcx3SkUst3rNKhS8CLzoWXv2WuK9Z4Isf2W4Xdh2F196MiTsfsPgDUDYGTRhNkR
	DlApo0r0WUVHHZZd7RVnKf1MXl9BBHz/vEKVdU7TMpdtf1tAsEI7q5Fnr4q/oimrXon9CpdNdvI
	99KwzpQ4OieljeiCSy5k0eFK9Z9FID14xjDd38x8xrTcnKi0Vos+jpM1PwLUcbQTey6vJGcCAG8
	hxoQ==
X-Received: by 2002:a05:6000:2885:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-48e6e2c2536mr26477994f8f.1.1793702436872;
        Tue, 03 Nov 2026 02:40:36 -0800 (PST)
X-Received: by 2002:a05:6000:2885:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-48e6e2c2536mr26477952f8f.1.1793702436456;
        Tue, 03 Nov 2026 02:40:36 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm24096953f8f.27.2026.11.03.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:40:35 -0800 (PST)
Date: Tue, 3 Nov 2026 11:40:32 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Hui Su <sh_def@163.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
Message-ID: <aum6IBxgdiJ09Kiv@jlelli-thinkpadt14gen4.remote.csb>
References: <20261102134606.242743-1-parri.andrea@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261102134606.242743-1-parri.andrea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mJWrhwLRipzJh6XYkpvJhh-bgszShGX0Jc1_VKTn0SQ_1793702437
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 02/11/26 14:46, Andrea Parri wrote:
> A sched_setattr() with SCHED_FLAG_KEEP_POLICY on a SCHED_DEADLINE task
> unlocks cpuset_mutex twice if the task's policy changes concurrently:
> 
>   WARNING: bad unlock balance detected!
>   7.4.0-rc1 #1 Not tainted
>   -------------------------------------
>   repro/126 is trying to release lock (cpuset_mutex) at:
>   [<ffffffff9a17cacc>] __sched_setscheduler+0x9cc/0xc40
>   but there are no more locks to release!
>   ...
>   Call Trace:
>    print_unlock_imbalance_bug.part.0+0xfb/0x110
>    lock_release+0x286/0x2e0
>    __mutex_unlock_slowpath+0x1a/0x400
>    __sched_setscheduler+0x9cc/0xc40
>    __x64_sys_sched_setattr+0xa3/0x1b0
>    do_syscall_64+0x106/0x5f0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> __sched_setscheduler() samples p->policy before taking any lock, and
> restarts from the recheck label if p->policy differs under the rq lock.
> The restart drops cpuset_mutex but leaves cpuset_locked set, so a pass
> that no longer needs the mutex still unlocks it on its way out:
> 
>   CPU 1                                CPU 2
>   __sched_setscheduler(KEEP_POLICY)
>     policy = p->policy /* DEADLINE */
>                                        __sched_setscheduler(SCHED_OTHER)
>                                          p->policy = SCHED_OTHER
>     cpuset_locked = true
>     cpuset_lock()
>     rq = task_rq_lock(p)
>     oldpolicy != p->policy
>       cpuset_unlock()
>       goto recheck
>     /* no cpuset_lock() this time */
>     ...
>     if (cpuset_locked)
>       cpuset_unlock()
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
>   #define _GNU_SOURCE
>   #include <pthread.h>
>   #include <stdint.h>
>   #include <sys/syscall.h>
>   #include <unistd.h>
> 
>   struct attr {
>       uint32_t size, policy;
>       uint64_t flags;
>       int32_t nice;
>       uint32_t prio;
>       uint64_t runtime, deadline, period;
>   };
> 
>   static volatile int stop;
>   static volatile pid_t target;
> 
>   static void set(struct attr a)
>   {
>       a.size = sizeof(a);
>       syscall(SYS_sched_setattr, target, &a, 0);
>   }
> 
>   static void *sleeper(void *arg)
>   {
>       target = syscall(SYS_gettid);
>       while (!stop)
>           usleep(1000);
>       return arg;
>   }
> 
>   static void *switcher(void *arg)
>   {
>       while (!stop) {
>           /* SCHED_DEADLINE, 2us every 1s */
>           set((struct attr){ .policy = 6, .runtime = 2000,
>                              .deadline = 1000000000,
>                              .period = 1000000000 });
>           set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
>       }
>       return arg;
>   }
> 
>   static void *racer(void *arg)
>   {
>       /* KEEP_POLICY | KEEP_PARAMS */
>       while (!stop)
>           set((struct attr){ .flags = 0x18 });
>       return arg;
>   }
> 
>   int main(void)
>   {
>       pthread_t t[5];
>       int i;
> 
>       pthread_create(&t[0], NULL, sleeper, NULL);
>       while (!target)
>           usleep(100);
>       pthread_create(&t[1], NULL, switcher, NULL);
>       for (i = 2; i < 5; i++)
>           pthread_create(&t[i], NULL, racer, NULL);
>       sleep(30);
>       stop = 1;
>       for (i = 0; i < 5; i++)
>           pthread_join(t[i], NULL);
>       return 0;
>   }
> 
> An LLM helped find the PREEMPT_RT crash and write this patch and its test.
> 
> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: stable@vger.kernel.org
> ---

The fix looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

As I said in the other fix, I'm not sure we want to keep the reproducer
in the changelog, or if it's better to start collecting them somewhere
else (it might be easier to actually run them).

Thanks,
Juri

