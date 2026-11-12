Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475197;
	b=QJBHTvvqXxjT78+IW3AWL7lwQx/GHmy7Dcz655ICqFnRuNGQdOfoINN+krJdn8VSSy6p
	 OthQ5q/4XsaHhK3Y+5w3rcMcIndOxJQLaFPe5WltA5zIz5be4my6ytB0l5c9XAlkK7Cll
	 j/AZ6nqEmx6u3U+zYkCdfQPZva4LeFzEzqgsLW7feR9P1kJq+Y8pDqom4IqMsXNH1me6A
	 tCnhROKBsB7+B5ytS8vBY5iVACcoY48ZQyjX5AOFc436vnwe1jSUbrjKVWz5rM1FZrz4k
	 1FhyvHYvyknR+fLbUG0yCxfAppVGyow7WzBn3ExcRzXnMemRoHaEMt47Aw0PLQaugMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475197;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=BbdGJ+QfN/0a61vAo8i3jrwRHXo8FO9ut3fDr0zQx8s=;
	b=KyRaMldvHdgC6Bd7sDbj4XVobi6YZYrTqG7S/K0/GpalC6vxx78K7lekZv6Pg5r7MbO/
	 psTClCjmJwVx8zcGJHuzmAqSpKyYsx33eRpk5oYjxe8Xu9Vyur26AKhw/ANhqcIpxOxJT
	 f+pWRKmyzAriu2QKRPW4sdL/X7BwMNvqHk46DWI9TeCbH/vbQzc62sgoNhWq9cqzNlUlB
	 Ql9ACJZjEwt4n+uIFnu9o4K0eErBHrTqBHRAFmo9AIP8nSpY7Cj3tTKHpFtxUjqHpOkKl
	 dk2Oh+ls7+Z8BydE69eSSbp4pfgXMoAXoItR89NZGEnFfiTWKNRnaxIUvLflwS8LJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G3nQzf9V;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF37606A327
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 09:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEF37606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G3nQzf9V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794475196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbdGJ+QfN/0a61vAo8i3jrwRHXo8FO9ut3fDr0zQx8s=;
	b=G3nQzf9VeRZQYW6rJ6HF59qJk5ITceiEwG2f+AMxq3UujANFYXUKP+lFECb4Wh88auGg6s
	XVJ8Gb7TtoOYxLDnFxc9j80Y2LWmJ9/V3f5TOH4g82Ijt1HSfcPF7mvLQWV9dObL3jhwRz
	hvZhmqZMsBRcyFjOutq6ZWQs5nLK6Ew=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-b_BNpb66OjS8FZgkwWnybQ-1; Thu, 12 Nov 2026 04:19:54 -0500
X-MC-Unique: b_BNpb66OjS8FZgkwWnybQ-1
X-Mimecast-MFC-AGG-ID: b_BNpb66OjS8FZgkwWnybQ_1794475194
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso2617704f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 01:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475193; x=1795079993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BbdGJ+QfN/0a61vAo8i3jrwRHXo8FO9ut3fDr0zQx8s=;
        b=VSSyis1iiAK7JXppn1GGYsPy3yJsbMl0IbvYPZ/f1dgMcx/oBuYxsmAN0zrwejtBtG
         Tu6acHGQ4MkRMkPOWce4U5DpnR5gtXKBg8p2az5SzKeE1j/wNdbLSDoucwpr/Vn2H93l
         D5ih5STQbHN4KpdB28+VMXcin0yYCvEG/AIl9dxZ2SzstzxsctKTWtbyyLYEkFfU2Djc
         rdJ/7Ia4zQ1kiD74VwtC45K/iv8hzgStP3nYRwQUtspRViEjxowTh3DEbXLtLc8oFWIp
         D78JT6HyUzdbvNK6UgHqdCd2SKDwe0L2j/FsW+2ixBLlwJPo3BSwsJsUKtPD4n+SP9gO
         R/sg==
X-Forwarded-Encrypted: i=1; AL+hErFekMKxHaHt+G4WhmrNH3XoIC3IEcoCx7mQ0LDfwf0k/0tQ7ppgVGLOEEO0mcK4nPyQkhPjp+34wqEBQFo2kg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+sxwyrI94vOpKssUaZUlhTIUbIjfs7Ck3MTyTzpQo0L1m3kDT
	VRmgcQ2XC3gJBbUG3EoKLDt9xCSLNlkYtH7HeXnL/k1J6eqMzTxwSkGHF6J/YDHT6VI9G8AHMWd
	nbKZtc2ldoS416yy407lpB6LoEbQeEH1wabiAM9DSlfQHLZr7md+frAoUqWO5pq3+inQi
X-Gm-Gg: AYBFou2ZQL8puOJyQfen0lvRaS3XZjI3+CpuH19cjKcpqMjJ0KqQ9Y6c7SpmulzkVnl
	iqOj3EFbH+3d3l6QSuBBLVxJ0sn9fT8LNtlbGp43w0D6I1NBo5jJNJsPK/nZgO6lXgPT7SO6qWh
	DP/qKvw6A92uPXXj4ev2EFrQ+2RglRpQvxxFiKKr6uTSrOK6uios5A6uFnhXS7ZiA+g5gd0dhqW
	LlIFhtQrJe0G80P0gv+Qkm2cPoNS3UzSE2Rm+P7eYtbtn2KFjY02JW83LJ+T7alaAL52dktwGwD
	76g1GqAEvGt+DheXU56bNOguJWWpV/g8n2W3i0duNjk8tNy7nsHFpGOaIE/ApUYSCqn3GYbNMS5
	yV0yVXN0QqdTeIJpZkgS1v+93dUSnMtvG+WpVbw9E/xbgAMHrhTxepAsJyVSctrDEcYdi7hdZpq
	zGXmg=
X-Received: by 2002:a05:6000:144b:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-499c6f8c43cmr8114276f8f.47.1794475193449;
        Thu, 12 Nov 2026 01:19:53 -0800 (PST)
X-Received: by 2002:a05:6000:144b:b0:488:7496:15b5 with SMTP id ffacd0b85a97d-499c6f8c43cmr8114228f8f.47.1794475192931;
        Thu, 12 Nov 2026 01:19:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988f5b1ce3sm13996822f8f.14.2026.11.12.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:19:52 -0800 (PST)
Date: Thu, 12 Nov 2026 10:19:49 +0100
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
Subject: Re: [PATCH v5 20/29] cgroup/cpuset: Give back the bandwidth an
 attach did not move
Message-ID: <avWEta7b9X4K6hF7@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-21-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-21-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MuGQPKGj0ChMi0XellZu5czcofVj2p3AZYWV1_U065s_1794475194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> Commit 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach()
> fails") reserves the bandwidth of an attach as one sum.
> cpuset_can_attach() adds up the bandwidth of the deadline tasks it
> moves. Once all tasks pass their checks, it reserves the sum in the
> destination root domain. If another controller refuses the attach,
> cpuset_cancel_attach() frees the sum. If the attach goes through, the
> move of each task uses its part of the sum.
> 
> But a task can change its policy, or die, before the attach:
> 
>  - A task that left SCHED_DEADLINE, or died, moves no bandwidth. Its
>    part of the reservation stays in the destination's total_bw, until
>    the next rebuild of the accounting.
>  - A task that became a deadline task has nothing reserved. The attach
>    still moves its bandwidth. The destination lacks it, and its
>    total_bw underflows when the task leaves.
> 
> In testing, a task switched between SCHED_DEADLINE and SCHED_OTHER
> while it was moved 200 times into a one-CPU partition root and back.
> On v7.4-rc1 with the patches before this one, the partition's total_bw
> ended wrong in 5 of 6 VMs with 8 CPUs. It kept up to two reservations,
> or wrapped below zero.
> 
> Fix this by keeping the tally of what the attach moves, in
> sum_moved_dl_bw. Flag the move of a task only if the rest of the
> reservation covers its bandwidth. Once the attach is through, give back
> what it did not move.
> 
> set_cpus_allowed_dl() decides the move under the runqueue lock.
> cpuset_attach_task() does not hold it. dl_task_offline_migration() can
> change the task's record meanwhile, for a task throttled on a CPU gone
> offline. So the tally counts what set_cpus_allowed_dl() reports in the
> affinity context.
> 
> With this patch, total_bw ended right in 6 VMs of 6. The random_mix case
> of deadline_bw_test, added later in this series, found the bug. It could
> no longer lower a fair server in a partition root with no room left.
> 
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

...

> @@ -3285,17 +3299,28 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>  	 * cpuset_reserve_dl_bw() made room in @cs for the bandwidth of the
>  	 * deadline tasks that cpuset_can_attach() counted. Flag the move, so
>  	 * that the bandwidth of this task moves with it.
> +	 *
> +	 * Nothing was reserved for a task that became a deadline task since.
> +	 * Flag its move only if the rest of the reservation covers its
> +	 * bandwidth.
>  	 */
> -	if (dl_task(task) && dl_task_needs_bw_move(task, cs->effective_cpus))
> +	if (dl_task(task) && dl_task_needs_bw_move(task, cs->effective_cpus) &&
> +	    cs->sum_moved_dl_bw + task->dl.dl_bw <= cs->sum_migrate_dl_bw)
>  		reserved = true;

Humm, this is identity-blind: it cannot tell a task that can_attach()
counted (its bandwidth really is inside sum_migrate_dl_bw) from one that
became a deadline task in the can_attach() -> attach() gap, for which
nothing was reserved, can it?

Say A and B, 50 each, are reserved for a sum of 100, and C becomes a
deadline task with 70 in the gap (can_attach() <-> attach()). If C comes
first in the taskset it passes 0 + 70 <= 100 and moves; A and B then
fail 70 + 50 <= 100 and both properly reserved tasks are denied their
moves?

Not sure if we can consider tracking the counted tasks per task? The
taskset is pinned between can_attach() and attach(), so we could build a
list of (task, bw) pairs at can_attach() and let the gate check
membership?

Thanks,
Juri

