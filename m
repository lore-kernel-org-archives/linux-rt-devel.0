Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848712;
	b=thlynQlmGYmcc8e91drlIyQ3fQ4h+5LHRnPEVEqaoErb1uU8NCw0IRJ1OJgxrrB5ni9n
	 UEUCwV8zZx60tN+BB9D1GEyZJahJ2S17uAjZC8gh2A1VR+QMg1hcvqHV+P5U0WFlH63Vy
	 yFHlXTkdLVkC8iYIxrWOKXBL5aYGpQGOxra9qqc93dt/HK4lr2GQRxqWAZjmnjSNZbVYo
	 KhzMEJPM5fZ6q6D85tgfcfJ7XxlXO+YWvjwuLX1e0s6lQV5KZDs8y6dWTY+TcJT1YMii4
	 rUC6WUX0A41FTsnhSeNPbfQi9Zx7Q1cHQBA9t75kpxmO4BFcBxVc+myCn498B8msLmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848712;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KRT8uv0aNd6+YIA6SfZsO76YnqQBWuSYLjPKYLuuEKk=;
	b=SECG8E84yEyGIoIOsFavO2cwISm5de4FwPP1FDm4ly+Ws6b8nszizLj1mGx7t+5Rbvv2
	 T/P7rlU2g04V5+yoHhDVmB5/04mMa9Tci4jfUi6I/DPOleagHzglzbcVu7nrU1i50+3Qe
	 3U4dvkjTbFfniUEHi5OgSg8bNCNNzCOQTfjxyNalOz5e4bvPTOjwHaI7bu5i/ApvcU2Hl
	 PaYbrI+JyrVsdF2yF3MNuZzel3qm5STLsLLCGgdnuQRYuzvs7DJ6o4i4yPy5rtNTzgqBJ
	 NRguBhnxZahjcfSea2X1yHE/uh/l6E9VKrqV5/ILQ6YTmWO2OdwjSwMZliVs2AEK4gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wjF261J9;
	arc=none smtp.remote-ip=95.215.58.63
Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEC606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42CEC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wjF261J9
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=9/VbSCdnMhWS3PcbVZaHCWXgbSyBS2QjbGHqcqG23bk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848709; v=1; x=1793453509;
 b=wjF261J9nxxJDX/9wdvyB8fde1KLyH/K+OqP02Z2uxY5rdbVS4Yhv2v6lQtmHJnSuGihLfxt
 2TQG0quKK95q6eyjhBxX5hlywp2xwfMYKxYSxoomgJ0Suu9BH6hX2ZOFQlm2kQP7Y3Zc6OSgNgM
 WVm5xS2os9eOKcxfnajvdpZM=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 29c702cc58482384;
	Sat, 24 Oct 2026 13:31:49 +0000
X-Mizu-Trace-ID: 29c702cc58482384
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 13/15] net: Allow to use SMP threads for backlog NAPI.
Date: Sat, 24 Oct 2026 21:30:37 +0800
Message-Id: <fa7332793e029b2151368e2d26d7dec33b0a40ab.1792847032.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>
References: <cover.1792847031.git.wen.yang@linux.dev>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.

Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
used by drivers which don't do NAPI them self, RPS and parts of the
stack which need to avoid recursive deadlocks while processing a packet.

The non-NAPI driver use the CPU local backlog NAPI. If RPS is enabled
then a flow for the skb is computed and based on the flow the skb can be
enqueued on a remote CPU. Scheduling/ raising the softirq (for backlog's
NAPI) on the remote CPU isn't trivial because the softirq is only
scheduled on the local CPU and performed after the hardirq is done.
In order to schedule a softirq on the remote CPU, an IPI is sent to the
remote CPU which schedules the backlog-NAPI on the then local CPU.

On PREEMPT_RT interrupts are force-threaded. The soft interrupts are
raised within the interrupt thread and processed after the interrupt
handler completed still within the context of the interrupt thread. The
softirq is handled in the context where it originated.

With force-threaded interrupts enabled, ksoftirqd is woken up if a
softirq is raised from hardirq context. This is the case if it is raised
from an IPI. Additionally there is a warning on PREEMPT_RT if the
softirq is raised from the idle thread.
This was done for two reasons:
- With threaded interrupts the processing should happen in thread
  context (where it originated) and ksoftirqd is the only thread for
  this context if raised from hardirq. Using the currently running task
  instead would "punish" a random task.
- Once ksoftirqd is active it consumes all further softirqs until it
  stops running. This changed recently and is no longer the case.

Instead of keeping the backlog NAPI in ksoftirqd (in force-threaded/
PREEMPT_RT setups) I am proposing NAPI-threads for backlog.
The "proper" setup with threaded-NAPI is not doable because the threads
are not pinned to an individual CPU and can be modified by the user.
Additionally a dummy network device would have to be assigned. Also
CPU-hotplug has to be considered if additional CPUs show up.
All this can be probably done/ solved but the smpboot-threads already
provide this infrastructure.

Sending UDP packets over loopback expects that the packet is processed
within the call. Delaying it by handing it over to the thread hurts
performance. It is not beneficial to the outcome if the context switch
happens immediately after enqueue or after a while to process a few
packets in a batch.
There is no need to always use the thread if the backlog NAPI is
requested on the local CPU. This restores the loopback throuput. The
performance drops mostly to the same value after enabling RPS on the
loopback comparing the IPI and the tread result.

Create NAPI-threads for backlog if request during boot. The thread runs
the inner loop from napi_threaded_poll(), the wait part is different. It
checks for NAPI_STATE_SCHED (the backlog NAPI can not be disabled).

The NAPI threads for backlog are optional, it has to be enabled via the boot
argument "thread_backlog_napi". It is mandatory for PREEMPT_RT to avoid the
wakeup of ksoftirqd from the IPI.

6.1-rt port notes:
 - The upstream context for this patch is the v6.9 net/core/dev.c. Five
   hunks could not be applied verbatim against the 6.1.y base and were
   applied by hand; each one is a pure base difference, not a behavioural
   change:
     * backlog_napi percpu definition: the 6.1.y anchor is
       "int netdev_max_backlog" instead of "unsigned int sysctl_skb_defer_max".
     * ____napi_schedule(): the WRITE_ONCE(napi->list_owner, ...) line added
       by "net: add napi_struct.list_owner" does not exist on 6.1.y, so only
       the "use_local_napi" goto/label was added.
     * napi_threaded_poll() split: applied against the 6.1.y function body
       which now matches the upstream pre-image after the prerequisite
       commits.
     * smpboot block and net_dev_init(): the 6.1.y net_dev_init() has no
       net_page_pool_create() call, so the block was anchored on the comment
       preceding net_dev_init() instead.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linuxt.dev>
---
 net/core/dev.c | 148 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 113 insertions(+), 35 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0b2cf2f0f5a4..d5f8831e22e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/smpboot.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/string.h>
@@ -217,6 +218,31 @@ static inline struct hlist_head *dev_index_hash(struct net *net, int ifindex)
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
 }
 
+#ifndef CONFIG_PREEMPT_RT
+
+static DEFINE_STATIC_KEY_FALSE(use_backlog_threads_key);
+
+static int __init setup_backlog_napi_threads(char *arg)
+{
+	static_branch_enable(&use_backlog_threads_key);
+	return 0;
+}
+early_param("thread_backlog_napi", setup_backlog_napi_threads);
+
+static bool use_backlog_threads(void)
+{
+	return static_branch_unlikely(&use_backlog_threads_key);
+}
+
+#else
+
+static bool use_backlog_threads(void)
+{
+	return true;
+}
+
+#endif
+
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
@@ -4453,6 +4479,7 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 /*************************************************************************
  *			Receiver routines
  *************************************************************************/
+static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
 
 int netdev_max_backlog __read_mostly = 1000;
 EXPORT_SYMBOL(netdev_max_backlog);
@@ -4485,12 +4512,16 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 */
 		thread = READ_ONCE(napi->thread);
 		if (thread) {
+			if (use_backlog_threads() && thread == raw_cpu_read(backlog_napi))
+				goto use_local_napi;
+
 			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
 	}
 
+use_local_napi:
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	/* If not called from net_rx_action()
 	 * we have to raise NET_RX_SOFTIRQ.
@@ -4735,6 +4766,11 @@ static void napi_schedule_rps(struct softnet_data *sd)
 
 #ifdef CONFIG_RPS
 	if (sd != mysd) {
+		if (use_backlog_threads()) {
+			__napi_schedule_irqoff(&sd->backlog);
+			return;
+		}
+
 		sd->rps_ipi_next = mysd->rps_ipi_list;
 		mysd->rps_ipi_list = sd;
 
@@ -6023,7 +6059,7 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 #ifdef CONFIG_RPS
 	struct softnet_data *remsd = sd->rps_ipi_list;
 
-	if (remsd) {
+	if (!use_backlog_threads() && remsd) {
 		sd->rps_ipi_list = NULL;
 
 		local_irq_enable();
@@ -6038,7 +6074,7 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
-	return sd->rps_ipi_list != NULL;
+	return !use_backlog_threads() && sd->rps_ipi_list;
 #else
 	return false;
 #endif
@@ -6082,7 +6118,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			 * We can use a plain write instead of clear_bit(),
 			 * and we dont need an smp_mb() memory barrier.
 			 */
-			napi->state = 0;
+			napi->state &= NAPIF_STATE_THREADED;
 			again = false;
 		} else {
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
@@ -6753,43 +6789,48 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
-static int napi_threaded_poll(void *data)
+static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
-	struct napi_struct *napi = data;
 	struct softnet_data *sd;
-	void *have;
-
-	while (!napi_thread_wait(napi)) {
-		unsigned long last_qs = jiffies;
+	unsigned long last_qs = jiffies;
 
-		for (;;) {
-			bool repoll = false;
+	for (;;) {
+		bool repoll = false;
+		void *have;
 
-			local_bh_disable();
-			sd = this_cpu_ptr(&softnet_data);
-			sd->in_napi_threaded_poll = true;
+		local_bh_disable();
+		sd = this_cpu_ptr(&softnet_data);
+		sd->in_napi_threaded_poll = true;
 
-			have = netpoll_poll_lock(napi);
-			__napi_poll(napi, &repoll);
-			netpoll_poll_unlock(have);
+		have = netpoll_poll_lock(napi);
+		__napi_poll(napi, &repoll);
+		netpoll_poll_unlock(have);
 
-			sd->in_napi_threaded_poll = false;
-			barrier();
+		sd->in_napi_threaded_poll = false;
+		barrier();
 
-			if (sd_has_rps_ipi_waiting(sd)) {
-				local_irq_disable();
-				net_rps_action_and_irq_enable(sd);
-			}
-			skb_defer_free_flush(sd);
-			local_bh_enable();
+		if (sd_has_rps_ipi_waiting(sd)) {
+			local_irq_disable();
+			net_rps_action_and_irq_enable(sd);
+		}
+		skb_defer_free_flush(sd);
+		local_bh_enable();
 
-			if (!repoll)
-				break;
+		if (!repoll)
+			break;
 
-			rcu_softirq_qs_periodic(last_qs);
-			cond_resched();
-		}
+		rcu_softirq_qs_periodic(last_qs);
+		cond_resched();
 	}
+}
+
+static int napi_threaded_poll(void *data)
+{
+	struct napi_struct *napi = data;
+
+	while (!napi_thread_wait(napi))
+		napi_threaded_poll_loop(napi);
+
 	return 0;
 }
 
@@ -11314,7 +11355,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 
 		list_del_init(&napi->poll_list);
 		if (napi->poll == process_backlog)
-			napi->state = 0;
+			napi->state &= NAPIF_STATE_THREADED;
 		else
 			____napi_schedule(sd, napi);
 	}
@@ -11322,12 +11363,14 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
 
+	if (!use_backlog_threads()) {
 #ifdef CONFIG_RPS
-	remsd = oldsd->rps_ipi_list;
-	oldsd->rps_ipi_list = NULL;
+		remsd = oldsd->rps_ipi_list;
+		oldsd->rps_ipi_list = NULL;
 #endif
-	/* send out pending IPI's on offline CPU */
-	net_rps_send_ipi(remsd);
+		/* send out pending IPI's on offline CPU */
+		net_rps_send_ipi(remsd);
+	}
 
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb = __skb_dequeue(&oldsd->process_queue))) {
@@ -11587,6 +11630,38 @@ static struct pernet_operations __net_initdata default_device_ops = {
  *
  */
 
+static int backlog_napi_should_run(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi = &sd->backlog;
+
+	return test_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+}
+
+static void run_backlog_napi(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+
+	napi_threaded_poll_loop(&sd->backlog);
+}
+
+static void backlog_napi_setup(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi = &sd->backlog;
+
+	napi->thread = this_cpu_read(backlog_napi);
+	set_bit(NAPI_STATE_THREADED, &napi->state);
+}
+
+static struct smp_hotplug_thread backlog_threads = {
+	.store			= &backlog_napi,
+	.thread_should_run	= backlog_napi_should_run,
+	.thread_fn		= run_backlog_napi,
+	.thread_comm		= "backlog_napi/%u",
+	.setup			= backlog_napi_setup,
+};
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11637,7 +11712,10 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+		INIT_LIST_HEAD(&sd->backlog.poll_list);
 	}
+	if (use_backlog_threads())
+		smpboot_register_percpu_thread(&backlog_threads);
 
 	dev_boot_phase = 0;
 
-- 
2.25.1

