Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51F30EF6B
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Mar 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319759; cv=none; b=ZUrFR6n8oaZayqLJImBEBBZqR1L6kHsvTk79mPzxxJou6+lPiTo7Hd5E+32hO6RsAL3ru1tjh+M3x6+y16pOLeiKneR4NinfDmieWUl+4DxavPXAwHxc8h/rdYCU/mQdZv+M4qgGWwX/u8+voJpPCc95X9ELg1PHcsgKJB7BKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319759; c=relaxed/simple;
	bh=e9aEAwBwRN6zPfDEWNAhGeyOf0MTxtXscMXftiyG3Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtJtD1jGaC8mGTm61VLDhWubEpjkFdaQy1Ql4qu1NBqc5SjMo7bdbT6dQI8sesmka9Vp+CQvq3GwHOGMof380aBsKT2pa9FZPYuXTmuqxi/eFUuRzTl3vCszWqtxzMm9Y6tFz8ArHuL/gdb31Smq+3xp8h5XjLVxn0KPxpfdxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GzfduCly; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GzfduCly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=h/49DH7tMmyQvegc/mN27ZJ+hkDAdl6TzzuhQDYNw4c=;
	b=GzfduClysN2gn12Dgl82Pqqm9BqFm7tYXLJDSByK42VWzsgdyVsnhhDWig5kzS
	nTdHcrnmai+xlCFMxtittxNRMNMU3wI+IXDB4ab++/ItsZPSEgC+CGvGAZoX/FyI
	SWRYk4FaniMkf6RMuoLTaK5aekyG5ZD103zSShILmaLTs=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3t6v5tbJpTwtkVQ--.19150S2;
	Thu, 12 Mar 2026 20:47:54 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: bigeasy@linutronix.de
Cc: boqun@kernel.org,
	clrkwllms@kernel.org,
	jackzxcui1989@163.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in bh disable on RT
Date: Thu, 12 Mar 2026 20:47:53 +0800
Message-Id: <20260312124753.962974-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312100546.jjvRquDg@linutronix.de>
References: <20260312100546.jjvRquDg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3t6v5tbJpTwtkVQ--.19150S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1fKFWktFyDurWxWw1rJFb_yoW7WFW5pF
	Z3Kayqkr4DJF1Ivw17Aws7Xryxuws8Xay7Crn7Gry0yws8Grn5ur4xKa1YvFsrGrn3Za42
	vr1Yv3s7u3s0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR6uWJUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwByzvWmytfw7wgAA35

hi, Sebastian

On 2026-03-12 10:05 UTC, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > As you said, the current implementation is good enough. :)
> > If you think it’s appropriate to change it to (system_state != SYSTEM_BOOTING), you can make
> > that change later when you git rid of CONFIG_PREEMPT_RT_NEEDS_BH_LOCK. :)
> 
> If I get rid of CONFIG_PREEMPT_RT_NEEDS_BH_LOCK then
> !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK becomes the only code and the code in
> question will vanish.

Yes, you are right!

> > I'm actually curious why the users of _local_bh_enable, specifically those using the s390
> > driver, haven't raised the issue that this interface cannot be used in RT-linux. Could it be
> > that s390 users have never run on RT-linux?
> 
> This driver is very old and s390 does not support PREEMPT_RT. You can
> grep for ARCH_SUPPORTS_RT to see who supports it.

I see. Thanks.

> > I did overlook that local_bh_disable() is also considered an RCU critical section and is
> > used in conjunction with rcu_read_lock_bh(). Although I saw comments in the code like
> > "/* Required to meet the RCU bottomhalf requirements. */", I don't fully understand why
> > local_bh_disable must be treated as an RCU read critical section. Is it simply because the
> > implementation of rcu_read_lock_bh does not directly call __rcu_read_lock and instead relies
> > on local_bh_disable to proxy this call? I haven't figured this out, and it seems a bit
> > strange to me.
> 
> local_bh_disable() becomes an implicit RCU read lock section on
> !PREEMPT_RT and be must preserve the semantic. 

My current understanding of the statement "local_bh_disable() becomes an implicit RCU read lock
section on !PREEMPT_RT" is as follows:
In a regular Linux system, during the period of local_bh_disable, both preemption and soft
interrupts are disabled, so RCU callbacks cannot be executed. This effectively means that the
progress of the RCU grace period is stalled during the bh disable period. In a PREEMPT_RT system,
RCU callbacks are executed in an RCU context and are not protected by bh disable, so it is
necessary to explicitly mark the RCU read lock state.
I don't know if my understanding is correct.

> > Are you suggesting that the future implementation of soft interrupts might be optimized to
> > use a per-task approach for queuing and processing soft interrupts? I think this is a very
> > good attempt, as the current handling of soft interrupts is a bit chaotic. High-priority
> > tasks often end up passively dealing with many low-priority soft interrupt tasks during
> > local_bh_disable(), effectively acting as 'ksoftirqd'. This seems unreasonable to me, as
> > it elevates the priority of low-priority tasks for processing.
> 
> Yes. Getting rid of that BH lock removed much of the pain. This would one additional piece.

I am looking forward to the per-task softirq optimization. :)

> > If soft interrupt handling could be implemented in a per-task manner, it could even lead to
> > priority inheritance in the future, and possibly work in conjunction with BH workqueues to
> > thoroughly resolve the long-standing issues of soft interrupts in RT-linux. In my project,
> > performance problems are often related to __local_bh_disable_ip and various sporadic
> > latency spikes caused by migrate_disable(). This is quite frustrating.
> 
> Ideally if task X queues soft interrupts, it handles them and a later
> task does not observe them. Only a task with higher priority can add
> additional softirq work.
> If task X queues BLOCK and gets preempted, task Y with higher priority
> adds NET_RX, then task Y will handle NET_RX and BLOCK. This can be
> avoided by handling the softirqs per-task.

It does sound like it can optimize quite a lot. By the way, does per-task
manner calls softirq callbacks just before voluntary switch out or trigger
task_work before return to user-space? 

> However if both raise NET_RX then task Y will still handle both. This is
> because both use the same data structure to queue work, in this case the
> list of pending napi devices. In this case threaded napi would work
> because it avoids the common data structure.

I see. 

> I am not a big fan of the BH workqueues because you queue work items in
> context in which it originates and then it "vanishes". So all the
> priorities and so on are gone. Also the work from lower priority tasks
> gets mixed with high priority tasks. Not something you desire in
> general.
> In general you are better off remaining in the threaded interrupt,
> completing the work.

Indeed, if we queue the soft interrupts triggered by different priority
tasks into a single workqueue, it wouldn't be very appropriate. If we
want to queue them into a bottom-half (bh) workqueue, we would also need
to create a corresponding workqueue for each priority and queue based on
that priority. I previously developed a patch for a real-time workqueue,
which has been used in our project. If certain soft interrupt tasks are
very important and do not require CPU affinity, then queuing them on
other CPUs to execute according to the actual priority needed might
optimize performance to some extent from a real-time perspective.

https://lore.kernel.org/lkml/20251205125445.4154667-1-jackzxcui1989@163.com/

Xin Zhao

