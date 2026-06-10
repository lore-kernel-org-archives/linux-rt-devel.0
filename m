Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C134E75C
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Jun 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116592; cv=none; b=iFtE7bl3Wo4q57q1Tn22dWmT0wguaklxAG1L/2UHZgWHKHqPTdhRFwk4qbOCar3T2ie+MMmEhCJ8S0qWRP0imvd1jZKMFXGFd+1BqG0Gu57TARYcQQzFF57tIl/f6THmSKBkEyT/h/i7ahY5wcm1p64p5ARb3H8pJCeUsAlVaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116592; c=relaxed/simple;
	bh=4rjlzwFl4SNJQSIhgRzMe6SvYNA6a91957CexrddqwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8jvE+PgPTsE7ASuWSFddMysg2avv17X8/ysEU8eeIeETzy8RUfTqJktI88sZMFU09BSETKOpNld008zwCj08ooXqm6Nli4mnQuGSrLjtjmdWnlNsecnKb20/XZ5f0n7x4qhDLZfDqJqDcWT2g5HQ5iTcH1GUVvm8V3Y17DloS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXk+sXFV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXk+sXFV"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dc67a5e102so73491517b3.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 10 Jun 2026 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781116589; x=1781721389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUujVtmtiJ0ulcRer2P4+Kpx3Yv3Q98tfMDf+JEUqu4=;
        b=hXk+sXFViY2cldUHY0YDD2ArlftPzukJwOHuysIvCeh0GEeuU2VTyTjZUBI4YIl3w6
         sGXzUqs60+DE+mx0Kn/sy7rk/EKUyCdNFoWWo4uwxH8zn+TXBGgKVCY3W5ve0Px0nhpQ
         9rO5qHuSFU3O82Z8OjUwJXPBrQ2yykc/kQtMdWe3/dYtHJ++DrLSkcqbYsy/TyQbFQyg
         ZV3Qtnt49luOLLZPCE6+CYvQ0xKDuXt5o1wzgzBpvLa3zuXOHUBYRcEA/j2HXd2XMKru
         s65qaEs7jj9R8InqeWVAWHmAR1bTk1eyoAw9a0XPeqObbm5P52S9VBrXOzgwz4aHumNB
         AAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116589; x=1781721389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUujVtmtiJ0ulcRer2P4+Kpx3Yv3Q98tfMDf+JEUqu4=;
        b=MzQXjyegvr3fR18DpLF7IDWkmqkzgx5B3AYHx9LTUTSullUSSWdQN4Wc5bai4+5iIV
         Bb2jT9n606Otd2i5/AtYVJSavauTd/8XciAF0oW0WH/EIYiqGKlhQk+P5zsTcl4jxM7n
         FzWZ6kyTZ5SVSg+XDVYXQPUdlhUlo0SfSWbecMSIG+K5lPe/jCS/RGyrundTia+3w1DN
         VTV3aGGeNXHQrl+fzYD2e8VG5cENYk5rqf4DVfzDGrEWrF8S/tPp4lV3cz5/TKik06/i
         HEpDzpvmJ8wWJKEqFmZ7qlS/Cd4JS1RgH8mLHs9ClvPOlhfGh03kO5ucf0kYiV3U3OWk
         5KXg==
X-Forwarded-Encrypted: i=1; AFNElJ/cBMSbWoT/GCEYBb2weBUHcYOxcNxQlCNQnw7o4F71RMwR6ZVRS6pzdmSf29CCIbhvAxYjQqrXJFyyYSDdjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAMM6Dr+z7ytzWevKE0m9ZADwpbws5WJekPSXYk9qeM4K2pR4E
	fPBVyn99DIIWrugg3CeQmuohNohn4q2RsnAFvFioC7+VykW4yMKU2JAO
X-Gm-Gg: Acq92OECkjyrn3AbcuuE0FUB4dX4IML6DVZq1iJlyEP5orLhsvIiDonyhpmYFQi9DXw
	eNdQPLOAVNadkQUzFC/n0mOKzrad8EPbS9TiCD7c9sq4MpF3EUWB8O8rIEQS23OmYqKbxf0Vheq
	RCnCaN96WhxZB9L9OvkkvElaHPhw7VDSesV6wGRMXICb41eJlfOtLvse7IS0jK2lVMj5mPAZh8f
	GhqOo493Hq1yNTXuvN9yZP3tmiXYxjs0kB28CqgETbvchAM3UEaPZw/1UtNqI705nv0Wy13aVde
	eidyUZsIbsd7m2vtIP2igZV30eeyDY/jsRBgXNsdIWcdlT2k/yhzo49t0NKL7z3CRnUZ9+kYyQo
	G2hyso1rmnrYVOnKaa8GuYTz4O/Iid674AJbn9aBWWPi663Ff15Y422m0VHUFB+zTPh4Xei8YA2
	qJgijF2sra5pC4R6CGTn64X+FWj6Y=
X-Received: by 2002:a05:690c:7004:b0:7bd:5b06:5c32 with SMTP id 00721157ae682-7f61711b7ecmr4602517b3.1.1781116588803;
        Wed, 10 Jun 2026 11:36:28 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea21968299sm116150847b3.19.2026.06.10.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:36:28 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] netpoll: run NAPI poll in softirq context to avoid rq->lock self-deadlock
Date: Wed, 10 Jun 2026 11:36:21 -0700
Message-ID: <20260610183621.3915271-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_poll_dev() can be called from process context with interrupts
disabled, most notably from printk() -> netconsole when a WARN()/printk()
is emitted while holding a runqueue lock inside __schedule() (e.g. from
put_prev_entity() during a context switch). console_unlock() then flushes
netconsole inline, which polls the NIC to drain its TX ring.

Drivers free completed TX skbs from their ->poll() via
dev_kfree_skb_irq_reason(), which queues the skb and calls
raise_softirq_irqoff(NET_TX_SOFTIRQ). Outside softirq context that helper
takes the !in_interrupt() path and calls wakeup_softirqd() ->
try_to_wake_up(). Waking the local ksoftirqd takes the current CPU's
rq->lock (ttwu_queue() -> rq_lock(); ttwu_queue_cond() refuses the remote
wakelist for a same-CPU wakeup). If the caller already holds that rq->lock
this recursively acquires a non-recursive spinlock: the CPU spins forever
with IRQs disabled. Every other CPU that subsequently load-balances
against this runqueue spins on the same lock, TLB-shootdown IPIs to the
wedged CPUs go unanswered, and the machine dies under the NMI hard-lockup
watchdog.

This was hit in production on a 252-CPU AMD system running a 6.16-based
kernel. A scheduler WARN_ON_ONCE() fired from __enqueue_entity() with the
rq lock held during a context switch; flushing it to netconsole reentered
the scheduler and the CPU deadlocked on its own rq->lock. The backtrace of
the wedged CPU (spinning at the top of the stack on the rq->lock it is
already holding further down):

  native_queued_spin_lock_slowpath
  _raw_spin_lock
  raw_spin_rq_lock_nested
  rq_lock
  ttwu_queue
  try_to_wake_up                  // wakes ksoftirqd/N
  dev_kfree_skb_irq_reason        // raise_softirq_irqoff(NET_TX_SOFTIRQ)
  __bnxt_tx_int
  bnxt_poll_p5
  poll_one_napi
  poll_napi
  netpoll_poll_dev
  netpoll_send_udp
  write_ext_msg                   // netconsole
  console_unlock
  vprintk_emit
  __warn
  __enqueue_entity                // WARN_ON_ONCE() here -- rq->lock held
  put_prev_entity
  put_prev_task_fair
  __schedule
  sched_exec
  bprm_execve
  __x64_sys_execve

About 215 of the 252 CPUs then piled up in sched_balance_rq() spinning on
that runqueue's lock; pending TLB shootdowns to the wedged CPUs stalled in
csd_lock_wait(), and a victim CPU finally took down the box with "Kernel
panic - not syncing: Hard LOCKUP". The particular WARN is incidental --
any printk() that reaches netconsole while a rq->lock is held reproduces
the same self-deadlock.

In the normal receive path this cannot happen because net_rx_action()
runs ->poll() with bottom halves disabled, so raise_softirq_irqoff() sees
in_interrupt() and merely sets the pending bit. Make netpoll do the same:
wrap the poll callbacks in local_bh_disable(). On !PREEMPT_RT all callers
invoke netpoll_poll_dev() with IRQs disabled (see the WARN_ONCE() in
netpoll_send_skb_on_dev()), so pair it with _local_bh_enable() to leave
the section without running softirqs inline -- running them here would
re-enable IRQs and execute softirq handlers deep in a lock-holding
context. On PREEMPT_RT the path runs with IRQs enabled and softirqs are
threaded; _local_bh_enable() is not available there and would not drop
the softirq_ctrl local_lock taken by local_bh_disable(), so use the
regular local_bh_enable(). The raised NET_TX softirq is harmless: netpoll
reaps the freed skbs via zap_completion_queue() and the pending softirq
is serviced at the next irq_exit().

Cc: stable@vger.kernel.org
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 net/core/netpoll.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 3f4a17fa5713..18da97eff532 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
 	}
 
 	ops = dev->netdev_ops;
+
+	/*
+	 * Run the poll callbacks in softirq context, exactly as net_rx_action()
+	 * does for the normal NAPI path. netpoll_poll_dev() is called from
+	 * process context with IRQs disabled (e.g. printk() -> netconsole while
+	 * holding a rq->lock inside __schedule()). Drivers free completed TX
+	 * skbs from their ->poll() via dev_kfree_skb_irq_reason(), which calls
+	 * raise_softirq_irqoff(NET_TX_SOFTIRQ). Outside softirq context that
+	 * helper sees !in_interrupt() and calls wakeup_softirqd() ->
+	 * try_to_wake_up(), which takes the rq->lock of the current CPU. If the
+	 * caller already holds that rq->lock this self-deadlocks, wedging the
+	 * CPU (and then the whole machine via rq->lock contention) until the
+	 * hard-lockup watchdog panics.
+	 *
+	 * Disabling BH makes in_interrupt() true for the duration of the poll,
+	 * so the TX completion only sets the softirq-pending bit and never wakes
+	 * ksoftirqd. The raised softirq is harmless and benign: netpoll reaps
+	 * the freed skbs itself via zap_completion_queue() below, and the
+	 * pending NET_TX softirq is serviced at the next irq_exit().
+	 */
+	local_bh_disable();
+
 	if (ops->ndo_poll_controller)
 		ops->ndo_poll_controller(dev);
 
 	poll_napi(dev);
 
+#ifndef CONFIG_PREEMPT_RT
+	/*
+	 * On !PREEMPT_RT all netpoll_poll_dev() callers invoke us with IRQs
+	 * disabled (see the WARN_ONCE() in netpoll_send_skb_on_dev()). Use
+	 * _local_bh_enable(), which leaves the BH-disabled section without
+	 * running pending softirqs inline -- the full local_bh_enable() would
+	 * re-enable IRQs and run softirq handlers deep inside this restricted,
+	 * lock-holding context. The raised NET_TX softirq is benign: netpoll
+	 * reaps the freed skbs itself via zap_completion_queue() below, and the
+	 * pending softirq is serviced at the next irq_exit().
+	 */
+	_local_bh_enable();
+#else
+	/*
+	 * On PREEMPT_RT this path runs with IRQs enabled and softirqs are
+	 * threaded, so there is no IRQ-disabled, lock-holding context to
+	 * protect. _local_bh_enable() is not available on RT, and local_bh_disable()
+	 * there takes the per-CPU softirq_ctrl local_lock that only the full
+	 * local_bh_enable() releases -- so use it.
+	 */
+	local_bh_enable();
+#endif
+
 	up(&ni->dev_lock);
 
 	zap_completion_queue();
-- 
2.53.0-Meta

