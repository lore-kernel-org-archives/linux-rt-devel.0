Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3653B6BEA
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Mar 2026 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225658; cv=none; b=OSI+5z50gYvZECY7jfFdDhWW+eLjnC4SX2P7Rcai5PyCe/fCLKRkZU7b+8zaxtzg4NpdwKSA5vL5+aasMWlqgHxze4h6KuSbu9ngkV1satlT2eCg1lw44HMRqY1uRdfq7MW0zSIW4nQegdjm3cC/rU712rCJ0Iog9s06wubODJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225658; c=relaxed/simple;
	bh=LzV2NqkduHOZ2bfPR1CgU60Ws4bB7eqcQChQon3fo5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN/K5IS5JDBOmyYFdcjS/s8IYNQ9aXV0x8XpgWWKDu+rjvJ5RqF0abeR9qbpniYWk0619ujhNsESX7AA17zC9VS7wAiEAsZ64S8J+h2tUnXapY7m7gVJ3oo0DVyCGA+PuaPjFoS3Yvei5HHOGenyii1ulEmkeyWcE65nqe2PPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=idzO+BfN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="idzO+BfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oK
	BR9ItYyVvyMG9DuDnHfAHu0IB2Gf9Ooct+uerMLSQ=; b=idzO+BfN+DLVb7XF8L
	Yc10iar/Dq6vMElxTYqw/xkgMNfbBlwnsFQ21LhunWvaNUhQUIe/77T/j40sHdr8
	+dWDs63YcjKztbmtRTouH2Od9GDbwfDNCFw7nZuxI6MFyODI5g4EPOmSaHRfFCEP
	T51tQBar+7PQrcvTidgl4eR94=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnjT+HRrFpNO7lSA--.144S2;
	Wed, 11 Mar 2026 18:40:10 +0800 (CST)
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
Date: Wed, 11 Mar 2026 18:40:07 +0800
Message-Id: <20260311104007.66966-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311093303.4_1N-y3-@linutronix.de>
References: <20260311093303.4_1N-y3-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnjT+HRrFpNO7lSA--.144S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF43Jry5Kr47Cry5CFyfZwb_yoWrWF1kpa
	97W348tr4DXFy0vwnFyw18uF15Zw4rJa4rCr9Yka4xAwsxKr1kXr4xKF10va4Du3yrJw1S
	vF12yry7uFy8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRfOz3UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwt6hGmxRouh6wAA3V

hi, Sebastian

On 2026-03-11 9:33 UTC, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2026-03-10 19:55:34 [+0800], Xin Zhao wrote:
> > In RT-Linux, when enabling CONFIG_PREEMPT_RT_NEEDS_BH_LOCK, calling
> > __local_bh_disable_ip() when !preemptible() is illegal because it uses
> > local_lock, which might sleep. The only exception is during the
> > cgroup_init() logic in start_kernel() while preemption is disabled,
> > cgroup_init() calls cgroup_idr_alloc(), which calls spin_lock_bh().
> > It is sufficient to only exclude the system startup phase in macro
> > DEBUG_LOCKS_WARN_ON.
> 
> No, cgroup_init() should not be quoted as an exception. It is okay to
> exclude cases while the scheduler is not active because here lock
> contention can not happen.

Yes, I shouldn't quote cgroup_init().

> > Although the original check of this_cpu_read(softirq_ctrl.cnt) can also
> > prevent the WARN_ON print during the boot process, it may hide some issues
> > that should be exposed immediately. Because softirq_ctrl.cnt maybe 0 when
> > __local_bh_disabled_ip() is called in !preemptible() context.
> 
> That is actually the point. If it is known that the call chain does not
> origin from bh-disabled context the it is fine. Well, not fine if you
> stick to the details but good enough if you don't to constantly complain
> to everyone about the little things which don't make a difference.

I just think that using (system_state != SYSTEM_BOOTING) for conditional checks
is more reasonable than using (softirq_ctrl.cnt).

> > In RT-Linux, __local_bh_disable_ip() will be used by numerous _bh variants
> > locks and local_bh_disable(). Since locks call __might_resched() check, we
> > analyze the scenario of using local_bh_disable() in !preemptible() context.
> > 
> > If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled, __local_bh_disable_ip()
> > does not enter the local_lock lock and thus using local_bh_disable() in
> > !preemptible() context does not lead to might sleep problem, but using
> > local_bh_disable() in !preemptible() state is not meaningful in RT-Linux.
> 
> but it does not cause a locking or scheduling problem either.
> 
> > In non RT-Linux, we use local_irq_save() followed by local_bh_disable() to
> > keep soft interrupts disabled after restoring interrupts. However, in
> > RT-Linux, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled,
> > local_bh_disable() merely increments the softirq_ctrl.cnt counter without
> > actually disabling the soft interrupt behavior, because other tasks on the
> > CPU can preempt the task that wants to disable soft interrupts and execute
> > soft interrupt-related logic.
> > Consider the sequence diagram below:
> > Task A                        Task B
> >                               __local_bh_enable_ip()
> >                                 __do_softirq()
> >                                   handle_softirqs()
> >                                     ...
> >                                     local_irq_enable();
> >                                     ...
> > local_irq_save()
> > local_bh_disable()
> > local_irq_restore()
> >                                     h->action(); -- it is serving softirq
> > local_bh_enable()
> 
> Okay. How is this a problem? You can enter this scenario event even
> without disabling interrupts within Task A.

I should use the situation where CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled to
illustrate the example above. People would expect that soft interrupts on this
CPU would not execute after calling local_bh_disable(), but as shown in the
example, this cannot actually be guaranteed.

Using (softirq_ctrl.cnt) as a condition for WARN_ON will only report issues in
scenarios similar to the one shown in the example. In many other cases, during
the execution of Task A, if there is no soft interrupt-related logic running on
the CPU, this WARN_ON may not get printed, thus hiding potential issues in the
code.

If Task A truly expects that soft interrupts remain disabled after calling
local_bh_disable(), and this expectation may not be met, we should detect this
risk early and prompt the user, just like the might_sleep() checks, providing
warnings proactively rather than indicating an issue after it has occurred.

Xin Zhao

