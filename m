Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876401;
	b=MVoja14qV5s4owJBvXs5WfIMh4tY6Vxbf1DKfLAa2K35vJ5BRnayr/WJyP+6kYfeyP9y
	 n0aqbk5SGvRbQ2tQnWS/LMgibQYaLPSrO7ASscVNfwgeNxuQoHOCL9NL400rgxqqXweiz
	 89ETgQ2GkAgGFLp7OuXXjfQ+8hKkgTPYLjidbUHyi6Xo7McLhTMYpTOmqLzbbYvvyoCyh
	 UKn0nNJofY7/2uFEl6MZhlV2IyJ1B4/jhSnX0GRrt29P+OGZaGF0Aa+mhsCTFo6kk603t
	 cnth2wnkNlo5MaYNXNOdcYzbmSY+eFKfgO5H9nyKXUREr+R/kDcPkS6Sm9vPuxVBaMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876401;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Oek9BHm9kE/i/pAixALrJCjyIzhOnrADlEzuRw14Asc=;
	b=lYVKpeJ8WzZAipez6eGLsUi0QH/D5IiBUziYMqqB0JiTH/HYUqUTqMMnRSveoI5vF0Lt
	 FDZJwKEyy/OEUDPOH6FYJpfyVbAPdOnwH89KBBo8BkjOsKlHbEbLJgzLACDi4b33o4NNt
	 n4SFwpaNGhNq3SHg6+UWmo25Dee3y9MSW/e/i7bgWJCZOWe5Md6mIHiVKKgbt9L3JwG0f
	 yH95W6uFTT9U37gbz9miJq6TPYuEE7DKfVO6aqgv0D+iFPggBu7GubL+OY5Kh2XZcwKXu
	 B/uTE9fr6ry1vWLDEvNbV696z6KXluHlFWrWJdRl+pWetQ0HRbuzLgnDV0AujV9iSRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eof7o6I9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94966606A326
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 11:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94966606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eof7o6I9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793876399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oek9BHm9kE/i/pAixALrJCjyIzhOnrADlEzuRw14Asc=;
	b=Eof7o6I9QJoGrUpRzW01FUYw5NhwFA+Mu/f+id6qiDSkIpUobQHINEaC8P3eRmVqTKizVu
	3kC2JJtGijlmhdKDbgR4anqLl5QYXDxp0f0Rknu+wTmtgGU8O25jtv+kLawV47evfzpxQc
	9XzSeVe93xcBRd0liaB8HBIyPxBhBNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-LNyTQA3NMvulaHD5A14PSw-1; Thu, 05 Nov 2026 05:59:56 -0500
X-MC-Unique: LNyTQA3NMvulaHD5A14PSw-1
X-Mimecast-MFC-AGG-ID: LNyTQA3NMvulaHD5A14PSw_1793876395
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490ed502749so754320f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 02:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876395; x=1794481195;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oek9BHm9kE/i/pAixALrJCjyIzhOnrADlEzuRw14Asc=;
        b=yA2GEdrMC1LGaKi+lz4kHX8NbYjAXEf0ITaaL63LF8gkOsI4PD+/J3yFnStWVEucfo
         QAofYjsuAUx+D3KuJzm8C2y8PgaMPPS9SJCCKyUfBBrLqVhCOMBinZ/Pzex2/C6iNwiv
         meHw0haNP253ljhPlpQFn+zwPjxg6iI81hMe86HzBuw+owgwPqOycEckLKUBDAuqVLc2
         M6UGvlyQXYb5F4fsgNBg64UYmKCK3lMh3vDxxFp3mOuIAk1WVfxZn0g1BbkdJ2GL6hwo
         Fs9gHTX63QKwH+a3c7AL5b7z77XzAkMWuRbmxxKUmnFVCslRFOH4/mGuTrzmOGRLag8L
         02kw==
X-Forwarded-Encrypted: i=1; AKwUvBzF9woiyCErgT3ac1dSpnvcwX33jq5Fhq12d6/p0uxi0G6hhHauk2a6sVm7n51Be3VWLqF3yFZLTNB3ygjqOw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Se/JqArYau+EG+aCTlrsmck6pckuwIgtpoGkis0tZ4RFAXHFe
	MBNoF5g5KWdTDJW+MIFdp9HhAKru8BxdArTCG6n9L3Fhz/1TceR7BZfeTTQ9Bi/ujdhtlbjFPMo
	FLIfu9G1CKPP5YmNn0oZ43k6yyYbidZLA5N/coYSiZvXAmUsukoNkldTVFuIw5jsSocO4
X-Gm-Gg: AYBFou3E4QLOe+IwEw4AmpO0GIEPX2fOZQo8Y2Z+IK1uIFDhG/K4hsakTq5NEsuCG4d
	jxNl63QaKJF8HL/1ro2HYP3QisfEmEISVNf4PnlPCp6eh56ZFOzl2fEU9RdsJwsfxzYTFwG+q5v
	uConCb35jeMkcTh7q4seCtfDxeeS28oiQneVAEXNjkIUaabpgET8cyY2ujkqjgWsM4qxIj8qMCp
	FRkxFCQmiJoT2p76QRPxbipGjRQWXOvIurMQoND6WqOag0E+OfoDMR1EnONa2kjF5aGs5XYyRXp
	KI6rwzjAGLmmjUBnvUujUKbTz2+tiqLMInsSRPxbkUy7YHxqJZq2awqXAptPNE8WU1mUZo7cvww
	COxsSfNPxHESxiT4FqwME4CzuDi/iQuVVFTQvP0yBj94wialPr96m5VZGC3Gi0C9HaqKSgSAzPs
	SDqA==
X-Received: by 2002:a05:6000:1acb:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-48e6e4f56dbmr39400073f8f.41.1793876395118;
        Thu, 05 Nov 2026 02:59:55 -0800 (PST)
X-Received: by 2002:a05:6000:1acb:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-48e6e4f56dbmr39400028f8f.41.1793876394719;
        Thu, 05 Nov 2026 02:59:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed5521c7sm9157524f8f.39.2026.11.05.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:59:54 -0800 (PST)
Date: Thu, 5 Nov 2026 11:59:51 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 05/21] sched/deadline: Do not BUG() on a deadline task
 with no active CPU allowed
Message-ID: <auxhp05Xmz9LYOo-@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-6-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-6-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XB2ICbwAmPulPLB-Lq6ZtueWsU7LPUp7aMnd-u0eUHE_1793876395
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> dl_task_root_domain_cpu() finds the root domain that holds a deadline
> task's bandwidth from the first active CPU of the task's mask, and
> BUG()s when the mask has none. A mask can have none:
> 
>  - a task boosted into the deadline class by priority inheritance keeps
>    the affinity of its own policy, which may allow one CPU alone, or a
>    cpuset of one. dl_task_needs_bw_move() and set_cpus_allowed_dl()
>    take it for a deadline task, dl_task(p) being true, and look the root
>    domain up from the mask they are replacing, which allows that CPU,
>    inactive by then: the cpuset code updates the masks of a cpuset's
>    tasks once the CPU is inactive, and select_fallback_rq() widens the
>    mask of a task it pushes off that CPU;
>  - with admission control off (sched_rt_runtime_us at -1), a deadline
>    task may be pinned to fewer CPUs than its root domain spans, and
>    those may all go offline.
> 
> Both take the kernel down on the first try, in 8-CPU VMs of v7.4-rc1
> with the four deadline fixes of sched/urgent. The priority inheritance
            ^^^
Not sure how much sense will this info make when reading this changelog
in the future. :)

> one, which asks for no unusual configuration, through the wakeup of the
> boosted owner:
> 
>   kernel BUG at kernel/sched/deadline.c:3340!
>   CPU: 7 UID: 0 PID: 0 Comm: swapper/7
>   RIP: 0010:set_cpus_allowed_dl+0xf0/0x100
>   Call Trace:
>    <IRQ>
>    set_cpus_allowed_force+0x9f/0xf0
>    cpuset_cpus_allowed_fallback+0x12b/0x1d0
>    select_fallback_rq+0x238/0x340
>    try_to_wake_up+0x2a0/0xb70
> 
> Fall back to the CPU the task last ran on, which these callers used
> before the commit this one fixes. Its root domain may have no active CPU
> left: the previous patch has __dl_sub() and __dl_add() take that. Ten
> rounds of each case leave no warning with it.
> 
> Fixes: b4a61fdc19c5 ("sched/deadline: Fix stale root domain in cpuset bandwidth transfer")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/sched/deadline.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index dadda1a528ec..30a52e42c26d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3338,13 +3338,19 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
>   * current cpus_mask (not yet updated to the new mask) to find the
>   * actual root domain. Use cpus_mask rather than cpus_ptr, which
>   * may be temporarily narrowed by migrate_disable().
> + *
> + * The mask has no active CPU left when the CPUs it allows went offline,
> + * which the affinity of a deadline task allows with admission control
> + * off, and that of a task boosted into the deadline class by priority
> + * inheritance always: fall back to the CPU the task last ran on.
>   */
>  static unsigned int dl_task_root_domain_cpu(struct task_struct *p)
>  {
>  	unsigned int cpu;
>  
>  	cpu = cpumask_first_and(&p->cpus_mask, cpu_active_mask);
> -	BUG_ON(cpu >= nr_cpu_ids);
> +	if (cpu >= nr_cpu_ids)
> +		cpu = task_cpu(p);
>  	return cpu;
>  }

At least (worst case) we fall back to how things were before my change
introduced the regression.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

