Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412457;
	b=L6sFDWd3VzhrADCV2j1+Le+A92rOP2YNWrV6Qd+S/nYEqRIQmS/pc7npqdHzIeE8+SUw
	 9KMXB6ylZy79bAuSjOVsfUToCfsWKfr8U93gdJfjNg1sjdc5SWDtfCQBaIzOzYUMbMiwJ
	 68IrF5ka4hKQzSN6ZQaAz888vspEd0lgAAqkZPMIEgnZi4YE3UBqOKM+KCBBBccAUfEJj
	 sNm84/s4SAvT6jk5tKiQO3agLA7edqGKomnjcvM17ZoSyQvROco5ijo7CwbRlK49nadcB
	 NK/nkKHSQPcv7u2d2rOYVrvSiGxGSKhWOOacQri1Q/2Y19F1aJ/KAnCzXPfZ3SJrncg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412457;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
	b=HzRkraGKNp/eNDj7lCeqowWOy0b7vtrdjHNVmstmJuB7Z/KqEUwFEqnX4jwvEnp5gWGN
	 d/fxkRUZCwOyBjkvACystqZ2EvMESLzNk/qJn92nPRJfl5BZQFSu8xKELbi6UhnE/Ex/r
	 /Be3vDbfyleEmB2e9FLs0gLUAsjj1Eyu4etkjWRDsmAe9Ns35rC6BT6OeUk9/XTqVxzKS
	 qrs7F0ojGkqEnBxBFTdjiY9PHiyUlla/BcyF77Co0mjhPuixB8Tg2sygfhclkTT7uqFMD
	 gM2YdxfWdSyL2OYCiVbsHcggllQiGP+WOltp5HtugWggSB8emdGEwhfrlIlTkZINccA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUSu2kHQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F7606A326
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 15:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D1F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUSu2kHQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794412456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
	b=gUSu2kHQoBGwsfid6Qv8XjXkF2WEbCOG0OeZLNt30hbw2tOnZnBD3sT4eI4Gdo0G+sHIO8
	CllLsSaWcxGrlqQHZtVKgzLaayHeVHqTwW04uYWUQaCoF9Nugmp1w0o3vP5fsLy/loc5gB
	7fKQBKhEEn3XRLRM5bpZixFaC71VpFk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-4XtHU2PnPXOpozXdYHifYw-1; Wed, 11 Nov 2026 10:54:14 -0500
X-MC-Unique: 4XtHU2PnPXOpozXdYHifYw-1
X-Mimecast-MFC-AGG-ID: 4XtHU2PnPXOpozXdYHifYw_1794412453
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-490d2ac331bso2833920f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 07:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412453; x=1795017253;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yO4iRBEsOuH32jlGyQ/kcDjMlOuvsYBA1s1+h7mpqw=;
        b=y5ROECbfd9ePI5rDUu/mtYJBHZBgAoSKX8A6MO+WqJ36fxm01p72xQQ59SVJYqKStu
         IBdgq7Nw8/BFO9JOIORNuSe37WlimqoZQM/ZQpYKjsT5QY6+Zx4COArIqCtwyhVej31m
         iz7//Y9LD4sM64tsgKzMCCzafxoMVzDa5GUdr3aCimPn3GssZ7Q7O53Hpq6fD0+Me8Rz
         lI9N2uRtd1Yr5k7oY2nUAuGdFUAMbXPtXUELeVBSJTusZ0F+zIDiRRSfyliB3gvbWFZr
         shjeTJtZbDgpAX4fYB+1BkNQTi0Ab4S7bt4HjdOt7khepHP9YC712h3kXdYjaBrt2mRm
         By7Q==
X-Forwarded-Encrypted: i=1; AL+hErEFx4COwlQThnxQMHUs3eoTrVnOzfaolO/XT9VO135OoSJqo9ysWiC9yaEmoCYoPnP/mnGbHaxBggmURpUDrw==@lists.linux.dev
X-Gm-Message-State: APuU4Z84zH3YZP4btmh2N71g82pc999ypGfoKkSySq8vSWeGFyo0ACdq
	jkDYYvTAQ0T/xkOW3WvRPrw2/nR9LGLHQ0akTXFzdEscpGrRmx0d509m2Ioi41Lm1vLOgGamBky
	f1OnJlvESXjmQx6gt8qAATo59OzYXIMXcP5uLMI/6XZqIcxoU29GkNh+7f7XOi/wMMnvW
X-Gm-Gg: AYBFou2ApiLYoi2g+RqAX6HK9ErcEbHAuEKGYuPF1FOiEkpGJ8AUAP5RxBhWN1ZIV94
	FJMVPzuW+C1aZq1iHEHKdpqvg/xGF8VGNeWa0n2xfMNakK/JhX2l6TJDJbZtmYATn8gwMvjDeto
	VDW4GpikCtSiJaq0S7ftcxh5byg0FhPsRGDbFQFIKFpwI9zzAsC7whjsuevhRYN85P9BJ1DVoiG
	Jxe+oAjRC2S0STcKNC2zLzhK23W/d9nPsw8AscsSF73vptIEg73NNR9N7OnlvTB+XKlAfDSnpwz
	MEUALmDVcUxMRmI8e3dUytitNDTrWc89cJsJiPX1PZxpg4o7H4Xd9KLv4Qd39d9nmY0sbGZX+hA
	mwDp7MMOu62Dxj/6HF7lCg0s7cYCTB5kVo1s7E/ojWGjOhU2pMf/qPPdzvK6phvrPEgRx+bxwBB
	za9U4=
X-Received: by 2002:a05:6000:3ce:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-499c77423e2mr4360046f8f.50.1794412453264;
        Wed, 11 Nov 2026 07:54:13 -0800 (PST)
X-Received: by 2002:a05:6000:3ce:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-499c77423e2mr4359995f8f.50.1794412452846;
        Wed, 11 Nov 2026 07:54:12 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm12632851f8f.57.2026.11.11.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:54:11 -0800 (PST)
Date: Wed, 11 Nov 2026 16:54:09 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 16/29] sched/deadline: Record the root domain holding
 a task's bandwidth
Message-ID: <avSPoSnNATnwZ8cS@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-17-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-17-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Seb7_qUl9f66LYTBqFkhVt6_sEKeLqXA_NAghUKL27Y_1794412453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> Admission, moves and releases of a deadline task's bandwidth find the
> root domain that counts it from the CPU the task is on. That CPU can be
> in another root domain. Two cases show it.
> 
> Commit 7f51412a415d ("sched/deadline: Fix bandwidth check/update when
> migrating tasks between exclusive cpusets") moves a deadline task's
> bandwidth in two halves. cpuset_can_attach() reserves it in the
> destination. set_cpus_allowed_dl() frees it in the root domain of the
> task's runqueue. Both halves now move nothing when that root domain
> overlaps the destination. But a sleeping task stays on the CPU it last
> ran on. So a sleeping task moved to a partition and back leaves its
> bandwidth in the partition:
> 
>   admin                                       task T
> 
>   makes P a partition root of CPU 3
>     CPU 3 is now in root domain B
>     CPUs 0-2 are in root domain A
>                                               sched_setattr(SCHED_DEADLINE)
>                                                 A: total_bw += bw of T
>                                               runs on CPU 0, then sleeps
>   echo T > P/cgroup.procs
>     cpuset_can_attach()
>       dl_task_needs_bw_move(): true,
>       A does not overlap P
>       B: total_bw += bw of T
>     set_cpus_allowed_dl()
>       dl_task_needs_bw_move(): true
>       A: total_bw -= bw of T
>                                               still asleep on CPU 0
>   echo T > cgroup.procs of the root cgroup
>     cpuset_can_attach()
>       dl_task_needs_bw_move(): false,
>       A overlaps the root cpuset
>     set_cpus_allowed_dl()
>       dl_task_needs_bw_move(): false
>   kill -9 T
>                                               wakes up on a CPU of A
>                                               exits
>                                                 A: total_bw -= bw of T
> 
> B keeps the bandwidth of T. A does not count T while T is in A, so A
> admits beyond its capacity. When T exits, A loses the bandwidth of T a
> second time. Its total_bw can underflow.
> 
> A rebuild of the accounting counts a task in the root domain of its
> cpuset. With admission control off, a task can be pinned to one CPU.
> When that CPU goes offline, it joins the default root domain, and the
> release takes the bandwidth from there. The root domain of the cpuset
> keeps it until the next rebuild.
> 
> The first case was reproduced on v7.4-rc1. The second was reproduced
> with the earlier patches of this series. Without "sched/deadline:
> Release the bandwidth of a task that leaves the class asleep", nothing
> releases the bandwidth of that sleeping task.
> 
> Fix this by recording, in dl_bw_cpu, a CPU of the root domain that
> counts the bandwidth. Each site that counts it sets the record. Each
> release or move reads it, and the release clears it. A move skips a
> bandwidth of 0, so sched_dl_overflow() does not use its record. The
> move_zero_bw case of deadline_bw_test, added later in this series, tests
> this. The record replaces dl_departed_cpu. If dl_bw_gen shows that a
> rebuild dropped the bandwidth, nothing is taken back.
> 
> A move now leaves out a sugov kthread and a task boosted into the class
> with no bandwidth of its own. The rebuild leaves them out too: no root
> domain counts theirs. A move would take a sugov kthread's bandwidth
> from a root domain that never held it.
> 
> Weiheng Qiu reported the moved sleeper, and Juri Lelli analysed it. His
> fix, linked below, took the first active CPU of the task's mask. A mask
> can have none during CPU hotplug. Tip dropped the fix after a sugov
> kthread hit its BUG_ON() there. The Sashiko AI reviews of this series
> found the other cases.
> 
> Reported-by: Weiheng Qiu <weihengqiuu@gmail.com>
> Closes: https://lore.kernel.org/all/14508cb2-805f-41ac-9f6b-bfd7c3d7cb1c@gmail.com/
> Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761fe005b4@redhat.com/
> Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

...

> @@ -3541,17 +3570,29 @@ static void set_cpus_allowed_dl(struct task_struct *p,
>  	 * domain (see cpuset_can_attach()).
>  	 */
>  	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
> -		struct dl_bw *src_dl_b;
> +		unsigned int src_cpu = dl_task_root_domain_cpu(p);
> +		struct dl_bw *src_dl_b = &cpu_rq(src_cpu)->rd->dl_bw;
> +		unsigned int cpu;
>  
> -		src_dl_b = dl_bw_of(cpu_of(rq));
>  		/*
>  		 * We now free resources of the root_domain we are migrating
>  		 * off. In the worst case, sched_setattr() may temporary fail
> -		 * until we complete the update.
> +		 * until we complete the update. A rebuild that dropped the
> +		 * bandwidth of @p leaves nothing to free.
> +		 */
> +		if (p->dl.dl_bw_gen == dl_bw_gen) {

So, this is not guarded by dl_departed_lock, but then this gets fixed in
later patches?

> +			raw_spin_lock(&src_dl_b->lock);
> +			__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(src_cpu));
> +			raw_spin_unlock(&src_dl_b->lock);
> +		}

...

> @@ -4189,6 +4245,23 @@ int sched_dl_overflow(struct task_struct *p, int policy,
>  	if (new_bw == p->dl.dl_bw && task_has_dl_policy(p))
>  		return 0;
>  
> +	/*
> +	 * Change the bandwidth of a deadline task where it is counted: in
> +	 * the root domain of the CPU recorded with it. A task moved asleep
> +	 * has not run there yet, so the CPU it is on can be elsewhere. No
> +	 * bandwidth is counted if a rebuild dropped it, or if the task
> +	 * enters the class. A runtime below about a millionth of the period
> +	 * gives a bandwidth of 0. It counts for nothing, and no move updates
                    ^^^
Ah right, quite cryptic corner case buried in this comment. :)

This is the 1024ns/2s of the test. Which indeed gets dl_bw 0. Don't
think it's a huge deal from a theory/practice pov as to actually make an
impact we probably need quite a lot of these admitted (fork bomb style).
But it's still weird :P. Not sure if we want to impose a min of 1 dl_bw
for these. If it actually complicates the accounting (for no good
returns) or not.

> +	 * its record. In these three cases, the root domain of the CPU the
> +	 * task is on takes the new bandwidth. The caller holds cpuset_mutex,
> +	 * or dl_accounting_mutex without cpusets, so no rebuild runs
> +	 * meanwhile.
> +	 */
> +	counted = task_has_dl_policy(p) && p->dl.dl_bw_cpu >= 0 &&
> +		  p->dl.dl_bw_gen == dl_bw_gen;
> +	cpu = counted && p->dl.dl_bw ? p->dl.dl_bw_cpu : task_cpu(p);
> +	dl_b = dl_bw_of(cpu);
> +

Thanks,
Juri

