Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942419F464
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 Aug 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687323; cv=none; b=ODaQl/SXJH5jA221ew+LOS1SB8K3RpUj/38bGKFZhVmt2jNIJs5Obcl0zjg/0QyKDMYOJ9BqRvylE8Xe0G8fQ/5vWSxpuFAamxrSIyINeWxSuUZSbi5IOAgcx8gGBfTV3U+lvNHDkulKCEa+XS/ziLTc0Uar/ui0E4d8rA2UK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687323; c=relaxed/simple;
	bh=ITEZ2gg6hclVMnZAoz6wZrDiXZNRaBTmGjBygPBanh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlC7EhZKT5yBaLoAKlX9c74dx/ODuYboTrlzn+JJZH5E6NPBcDqEcb5XEUdCXOsdqf8+ihHDYnai4ljRA6NqKxLLZNpRAexwe9F4NLlbc/zm82i+Z3TYZTYy9hcTzPa79kAqoqJFvv++WKR2FaYRq+PMHSZHsYQmYUWo+1/H7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHpeY3kT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Foc64dA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHpeY3kT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Foc64dA"
Date: Wed, 20 Aug 2025 12:55:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755687319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnrhWmXEmI6B6LqO1KJdu24Qh4xtzbhbmKycSJ77qmE=;
	b=hHpeY3kTBoEqwKHQsMj9lbqsNf4vpCRF2HVQmwF0lWvwJ2HYgRK/Vg9FK19XVhsohxc3yr
	aiOq/vCfhM85czswSMrJttr29D8ukgQ1Vv5FtSryPGf5p9zIzVzO6RO4pFtDfJMMdilBrS
	5nv/QKRVri38V/i8agshXpMpoC8yhD9G+9mfvoEo0up54UzVV08E/D7v5P98H5Y7LDnB1R
	VlShAEsfHBIBPjS6YDSNIKvyKDrL4zyRrjggXy1u8PilnNlgX7IzERSgoZjfHLvBNCgyo8
	o0kre3ncMloHJr7SiXKk+ng4JJCztS/51nVwMyNG3T0Sia4poI/KGp22C6BB8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755687319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnrhWmXEmI6B6LqO1KJdu24Qh4xtzbhbmKycSJ77qmE=;
	b=1Foc64dAXerGN6cZ/QAYOPeKqV2Xd5HbVHl7RdM4MXaVWol0PIoFztfcFyh/EkjUwWwle4
	58BV8k3VL5xqE8Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250820105518.Yf36NzJd@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
 <20250820103657.vDuDuLx6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250820103657.vDuDuLx6@linutronix.de>

On 2025-08-20 12:36:59 [+0200], To Tejun Heo wrote:
> Subject: [PATCH] workqueue: Provide a handshake for canceling BH workers
=E2=80=A6
> This will flush all BH-work items assigned to that pool.

We need to flush all items because the inserted wq_barrier is at the
end of the queue. So if the cb_lock is dropped after
worker->current_func(work) then we will live lock. Just tested, I
somehow assumed it polls on worker.

This behaviour is undesired and goes back to the requirement to be able
to cancel something from an atomic context which can't be atomic on
PREEMPT_RT to begin with.

Since the caller can never be atomic on PREEMPT_RT, what about the
following:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c31..6ce9c980a7966 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4214,28 +4214,16 @@ static bool __flush_work(struct work_struct *work, =
bool from_cancel)
 	 * can't currently be queued. Its data must contain OFFQ bits. If @work
 	 * was queued on a BH workqueue, we also know that it was running in the
 	 * BH context and thus can be busy-waited.
+	 * On PREEMPT_RT the BH context can not be busy-waited because it can be
+	 * preempted by the caller if it has higher priority.
 	 */
-	if (from_cancel) {
+	if (from_cancel && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		unsigned long data =3D *work_data_bits(work);
=20
 		if (!WARN_ON_ONCE(data & WORK_STRUCT_PWQ) &&
 		    (data & WORK_OFFQ_BH)) {
-			/*
-			 * On RT, prevent a live lock when %current preempted
-			 * soft interrupt processing or prevents ksoftirqd from
-			 * running by keeping flipping BH. If the BH work item
-			 * runs on a different CPU then this has no effect other
-			 * than doing the BH disable/enable dance for nothing.
-			 * This is copied from
-			 * kernel/softirq.c::tasklet_unlock_spin_wait().
-			 */
 			while (!try_wait_for_completion(&barr.done)) {
-				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-					local_bh_disable();
-					local_bh_enable();
-				} else {
-					cpu_relax();
-				}
+				cpu_relax();
 			}
 			goto out_destroy;
 		}
@@ -4351,7 +4339,7 @@ static bool __cancel_work_sync(struct work_struct *wo=
rk, u32 cflags)
=20
 	ret =3D __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
=20
-	if (*work_data_bits(work) & WORK_OFFQ_BH)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && *work_data_bits(work) & WORK_OFFQ_B=
H)
 		WARN_ON_ONCE(in_hardirq());
 	else
 		might_sleep();


It is not the revert I suggested.
This should work for softirq caller and from forced-thread interrupt
(not that I encourage such behaviour).
It will not work from an atomic context such as with raw_spinlock_t
acquired but this will also not work with the current
(local_bh_disable() + enable()) solution.

I prefer this because it avoids the locking bh_worker() and the flushing
of all pending work items the flush/ cancel case.

Sebastian
