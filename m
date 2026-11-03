Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689680;
	b=JogEARI9kmOpURvyOuMrmCvI7TuOnvAQs49zsVmXbh/OWT3vLk8aDlhwLyAbA5rENWK5
	 MbglgtnkxagesaVCayrntUOZgoAEOZB8o+j1K4STV/jRpgDESApJuw8x2d729moqQIhvU
	 LlU78/mupFcNF2lQHLAtynfy1JaqeFGPTIKvRHdQp7Og0RQwDLQw3+ZyE4h3h/EXwgbkd
	 EmTbwGdGM+fBq2IH83DTfzzuuuboJzRv2hd+UCGl+C5bhgO32EcUDEcgdD3/SJe7EPJIt
	 b/xOR2SjhWxsphBM5JZT2fApe0XPTt3KrDFA5+eALVCKjYBSh0N7U1Jj9OSh10tak7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689680;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=fj56z1BKjY0QeIgexJqhobjoHtJNuvhgBU1MRi3qBMg=;
	b=AGNcS9uXm9vS7cVgJsmCMc7kLVzoNv8raCjMBffK/xAmWlmF5Q2PQGUxJtpii0FAaZZP
	 RZ29J2/g0GXCnG2lcBIKMwMUszn7TrkrNZ4143U9lGMlidWkxnZqh042DVSU394Kcixy0
	 DdP8WX1rzv0eNI2CpyUlGmGbGukzyjz1z2fHQ42ZGr0d7hLYVTotl0LsiNQ+4rD/vIoLl
	 dvioDl+VhodCjnb62C87vafl1hMVDV97VSIwf9rstCiIYW9V6NvUYdD84m1IGjVX0Qugn
	 U/Hy+OtkkhPQgzeBjmNQMK/yy+bDA8o2RVHOeI3UjGBJkUEYAGufTaW1R5XO0KWpE6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ee5K7dxy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E15606A338
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 07:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E15606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ee5K7dxy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793689678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fj56z1BKjY0QeIgexJqhobjoHtJNuvhgBU1MRi3qBMg=;
	b=Ee5K7dxyBCYuqCI/bo8NIoEtFu2djOtPiOq2ei1yQvPi8PsSexZjfwuziRsSi8oh43FLST
	sFGArqlF//R+Vml8lwPrJZ/wr43s9AYlFIT+VRKCVVMR5wZnxthFBCpzpKvh3AHy6GrQw0
	DH+xTgiOw7LmV1lnkqNuS+1RWiixBg8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-VExJWCSmN_qKiCpeioKt4Q-1; Tue, 03 Nov 2026 02:07:55 -0500
X-MC-Unique: VExJWCSmN_qKiCpeioKt4Q-1
X-Mimecast-MFC-AGG-ID: VExJWCSmN_qKiCpeioKt4Q_1793689674
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a17741243eso28700565e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 23:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793689674; x=1794294474;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fj56z1BKjY0QeIgexJqhobjoHtJNuvhgBU1MRi3qBMg=;
        b=qGoAArK/3xU1lVviPGV2GMEhlbIXYMesQ6zrZMF9KbmzmLu1gZUIf0loUsogYRPt1E
         dP6I+/ivwFbk0rbBnllRlKYwiuv7p9enOyXW31ni1K5nUKO88JTZKu6S1l6MxuEFSIay
         hx/u66r5WyeYKUF94FL0Uwdi3oNH3RR6+biqkIoS77oNXzNYM2PGygThePHN2v1H1pbJ
         9cOSOLTFppOJ3veYeD8CePv0BQ9tC750uKcCDcr7ru6uOlt6lGlxRg5Gf2qeQa2gf8zt
         eVsPNimQEZvlgCGzMlXPL9t4j+mkse2HBxoyaCgesTuyLdA9QwndoxD4EWHYgNRDE9jc
         X2bA==
X-Forwarded-Encrypted: i=1; AKwUvBwBirdnglb9C9Ws5J17UzKb1U4o53AgqHWhv3KNPiW1Uwlp0qY4BmGXraKak7vurlsJvitOZQsjtLFPPnKLsw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9fT0iL2DJk406EGJug03i3L/faFthBo5aarhkM8eWLPn7dmcmP
	WX6PoZgqBPj5IaAAw/j7794kHLnDXXoMvpEylh3sJmHlr0FXRcbEPqMT1TWjYLnlmKIarpfgTle
	dKnAZOeG5KO9kRjC1vjH8vpnVaLeTB2H7nDr42yk0YZHsB7tYWdIh4UgWmj/VOYS1w08m
X-Gm-Gg: AYBFou3RI1kmBdcuS162i75F5nEs4JL6lgyJASZOXEtmtBiHOvxzaoRwf4eOxv7xjsY
	q3vC13EFVfZdGCxsKl0jJWsUlg+diNWv/cbmYPjctGLmZJpTXbEniPmLh9p0mr7V/QjowmtLInU
	1hS6akcsgGX44EZfS8ccs4/9Qfl6osT6i7a1xEPSFfWiF+Qq+Kp6lglMikmCZcViVMLot0Rx/xh
	451dCdE/s6D8ryh+ewnCnzQOBymbLIG56dHlj1DBYIMtzPGaa8aY+KfpzcCxoRqhU82/LnQg/Ws
	4j7EtXDvIcpw2+/Cpf0z94SgcBKD6XdT1O6noKhEHVKI5Krx3i7B06IYG+lioeETw9Zlruj+cCI
	gxxAIpVzsRGmVBesKRArhE5fGlB76wJ+f5MDV2rn65tXp1y2uHcXw2e/wObk8cFQNUdNISkCbBC
	rXdQ==
X-Received: by 2002:a05:600c:811a:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ac187a6b30mr262967025e9.28.1793689673766;
        Mon, 02 Nov 2026 23:07:53 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ac187a6b30mr262966665e9.28.1793689673372;
        Mon, 02 Nov 2026 23:07:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a0a3495sm250673935e9.4.2026.11.02.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:07:52 -0800 (PST)
Date: Tue, 3 Nov 2026 08:07:50 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix spurious -EPERM for
 migration-disabled tasks
Message-ID: <aumIRjQS2M0wWlVq@jlelli-thinkpadt14gen4.remote.csb>
References: <20261102135420.244745-1-parri.andrea@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261102135420.244745-1-parri.andrea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h1c9zSunvExbTQ-yEQpGXi9zMLQmSjeo7Dmmjr9gYx4_1793689674
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 02/11/26 14:54, Andrea Parri wrote:
> sched_setattr() can refuse to make a task SCHED_DEADLINE with -EPERM,
> even though the task's affinity covers the whole root domain. A retry
> can succeed, but the error blames an affinity the task does not have.
> 
> __sched_setscheduler() tests p->cpus_ptr, which is not always the task's
> affinity. When a task is scheduled out inside a migrate_disable() section,
> migrate_disable_switch() points p->cpus_ptr at the current CPU until
> migrate_enable(). On PREEMPT_RT every spinlock_t holder is in such a
> section, so ordinary kernel work opens the window. Elsewhere, seccomp
> filters run in one.
> 
> Test p->cpus_mask instead, which keeps the task's affinity and is what
> sched_getaffinity() reports. This should be safe because an admitted
> task's cpus_mask covers the root domain, so set_cpus_allowed_dl() moves
> no bandwidth when migrate_enable() restores p->cpus_ptr.
> 
> The following program, run as root, had 553679, 453720 and 424623 of its
> 1000000 requests refused on three boots of a 4-CPU PREEMPT_RT guest, and
> 236182, 217174 and 237183 without PREEMPT_RT. With this applied the count
> is 0, also with lockdep, and a task pinned to one CPU is still refused:
> 
>   #define _GNU_SOURCE
>   #include <errno.h>
>   #include <linux/filter.h>
>   #include <linux/seccomp.h>
>   #include <pthread.h>
>   #include <stddef.h>
>   #include <stdint.h>
>   #include <stdio.h>
>   #include <sys/syscall.h>
>   #include <unistd.h>
> 
>   #define REQUESTS 1000000
>   #define INSNS 300
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
>   static long set(struct attr a)
>   {
>       a.size = sizeof(a);
>       return syscall(SYS_sched_setattr, target, &a, 0);
>   }
> 
>   static void *worker(void *arg)
>   {
>       struct sock_filter f[INSNS + 1];
>       struct sock_fprog prog = { .len = INSNS + 1, .filter = f };
>       int i;
> 
>       /* Reading the arguments keeps seccomp from caching the result */
>       for (i = 0; i < INSNS; i++)
>           f[i] = (struct sock_filter)
>               BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
>                        offsetof(struct seccomp_data, args));
>       f[INSNS] = (struct sock_filter)
>           BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW);
>       syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);
> 
>       target = syscall(SYS_gettid);
>       while (!stop)
>           syscall(SYS_getppid);
>       return arg;
>   }
> 
>   static void *hog(void *arg)
>   {
>       while (!stop)
>           ;
>       return arg;
>   }
> 
>   int main(void)
>   {
>       pthread_t t[9];
>       long refused = 0;
>       int i;
> 
>       pthread_create(&t[0], NULL, worker, NULL);
>       while (!target)
>           usleep(100);
>       for (i = 1; i < 9; i++)
>           pthread_create(&t[i], NULL, hog, NULL);
>       for (i = 0; i < REQUESTS; i++) {
>           /* SCHED_DEADLINE, 2us every 1s */
>           if (set((struct attr){ .policy = 6, .runtime = 2000,
>                                  .deadline = 1000000000,
>                                  .period = 1000000000 }) && errno == EPERM)
>               refused++;
>           set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
>       }
>       stop = 1;
>       for (i = 0; i < 9; i++)
>           pthread_join(t[i], NULL);
>       printf("%ld of %d requests refused\n", refused, REQUESTS);
>       return 0;
>   }
> 
> An LLM helped find this bug and write this patch and its test.
> 
> Fixes: af449901b84c ("sched: Add migrate_disable()")
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: stable@vger.kernel.org

The fix makes sense to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

I only wonder if we want the reproducer in the changelog. An alternative
might be to move it to https://github.com/jlelli/sched-deadline-tests
where I keep the rest of SCHED_DEADLINE tests. I can probably do that if
you agree and prefer.

Thanks!
Juri

