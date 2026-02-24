Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D64396D33
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937104; cv=none; b=i/psVAoleXI/8NBzrjtgJe9KbVWupsNz+f7XYglnxVDJ363R5EKjWMQ4Qc/PWsoJ64ZtrfVuCwmv7aPOZOZypP8ik4fKw3hocoo1w72ohgbu0cP0ML3I4NRHZ+ESW3vuKUk+1neehjUGhuGaLe4tiqiyi9BSH5iz/wCThU9oLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937104; c=relaxed/simple;
	bh=w0VnEb4QYaikdDY5Qc88hVNHJ/J9mKDkcEPP8oMe/y8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PCngUVXpIn1l8rejpsIrsb+p71on2dz5/4nCxq1I81+AolxhMT1ONhScbjob8/7jX+8MMbtKKz0NMI4oQU0uCYPb+kjCJiLRaBaiVucguzKTJrNrCfRfqYipiSJyl1l+cG0ykLhag+bN//b+IKbnMqeeCZYXgcgi94mygnbaSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=gJ1uTTif; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="gJ1uTTif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771937064; x=1772541864; i=spasswolf@web.de;
	bh=Tj2PL195Eqwd6HvhI5jU/bbr75F4xGKmkz6cUgpuy3s=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gJ1uTTifoswlLmFEPfBpbS3U4/GxCcAIF6tZyVEMm5L/0i/iYkHn1nqfIm+hrjIV
	 X1QEdNK3U5XgQ6XsFODuSZtt7xTyMSL6Ue3izKAHkhjJovw3HmOy0pqHxJvVnRVQC
	 Rnq7yRmLQkG5y4xAUzHRJpTcZbQIP756ddGpzEvt8oKbQF8pY4eyY74MdXTQhyT8A
	 cqP8D+QBBihG9UWquYoPjRZg+QsclOLFY0cRODp4WTeLr6z15FiGbm9PndXA/lRqb
	 pe6KzqZfQQFoGsZcSCVvuZo/P8jrSRvjH1TKmN/by4UquMF1TBuCFYWYUOLh3wGUJ
	 48D2xaTPdX9Qe7hMeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFs1t-1vwFLb1Vqp-00CqeB; Tue, 24
 Feb 2026 13:44:24 +0100
Message-ID: <e1375d364a2ec20b393b24740ee5df6d53e9f120.camel@web.de>
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Calvin Owens <calvin@wbinvd.org>, spasswolf@web.de, Tejun Heo
 <tj@kernel.org>,  Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, 	dschatzberg@meta.com,
 peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Tue, 24 Feb 2026 13:44:21 +0100
In-Reply-To: <e76913d8778d3eb1d759cdd3239a2963216b9328.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
					<20260219164648.3014-1-spasswolf@web.de>
		<aZd4YCNTAHZNpTfh@mozart.vkv.me>
					<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
					<20260219195851.7a7bd1b2@fedora>
					<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
					<20260220104420.54610b04@gandalf.local.home>
					<ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
				 <20260223032257.4e6db467@fedora>
		 <80f657156fb2d32d8fe246e65e9ac8bf9d7cfbd5.camel@web.de>
	 <e76913d8778d3eb1d759cdd3239a2963216b9328.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LddsDF9Tnoj/+KLh4DmITykwIGJJxZGj/Z+1bqw5atl3BLp/U0v
 x8FewWYLOA7Qgf1Xb8RcF+I+iPRqiBVAf5ln2V7kiai4CFiwHihsqKL/J9Zcs/3yEUFC4Vt
 xw7M4Bvq1dV24kVPQhRKiGl3ACBmKnMCir+hrMnMgSRTppQ/hhqQeB45LfkPDf0EF3Bklbt
 cQodB8Fj1iOUh2geKMneQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sv//rm+agh0=;QOMXbkXHf1Eny3eAdLIRFmdxczg
 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
 R7iC6AFI=

I've done some more monitoring with this debug patch which monitors
cgroup_task_dead() and the function which calls it finish task switch.
To avoid too many messages some printk()s are filtered by command name
(a previous patch showed systemd to be the problematic process):

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f0d33b04910..7bb6931a4d86 100644
=2D-- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6990,25 +6990,32 @@ static void do_cgroup_task_dead(struct task_struct=
 *tsk)
 {
 	struct css_set *cset;
 	unsigned long flags;
+	printk(KERN_INFO "%s 0: task =3D %px\n", __func__, tsk);
=20
 	spin_lock_irqsave(&css_set_lock, flags);
=20
+	printk(KERN_INFO "%s 1: task =3D %px\n", __func__, tsk);
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset =3D task_css_set(tsk);
+	printk(KERN_INFO "%s 2: task =3D %px\n", __func__, tsk);
 	css_set_move_task(tsk, cset, NULL, false);
+	printk(KERN_INFO "%s 3: task =3D %px\n", __func__, tsk);
 	cset->nr_tasks--;
 	/* matches the signal->live check in css_task_iter_advance() */
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
=20
+	printk(KERN_INFO "%s 4: task =3D %px\n", __func__, tsk);
 	if (dl_task(tsk))
 		dec_dl_tasks_cs(tsk);
=20
+	printk(KERN_INFO "%s 5: task =3D %px\n", __func__, tsk);
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
=20
+	printk(KERN_INFO "%s 6: task =3D %px\n", __func__, tsk);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 }
=20
@@ -7029,9 +7036,11 @@ static void cgrp_dead_tasks_iwork_fn(struct irq_wor=
k *iwork)
 {
 	struct llist_node *lnode;
 	struct task_struct *task, *next;
+	printk(KERN_INFO "%s:\n", __func__);
=20
 	lnode =3D llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
 	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
+		printk(KERN_INFO "%s: %px %s", __func__, task, task->comm);
 		do_cgroup_task_dead(task);
 		put_task_struct(task);
 	}
@@ -7050,6 +7059,7 @@ static void __init cgroup_rt_init(void)
=20
 void cgroup_task_dead(struct task_struct *task)
 {
+	printk(KERN_INFO "%s: task =3D %px (%s)\n", __func__, task, task->comm);
 	get_task_struct(task);
 	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
 	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
@@ -7059,6 +7069,7 @@ static void __init cgroup_rt_init(void) {}
=20
 void cgroup_task_dead(struct task_struct *task)
 {
+	printk(KERN_INFO "%s: task =3D %px (%s)\n", __func__, task, task->comm);
 	do_cgroup_task_dead(task);
 }
 #endif	/* CONFIG_PREEMPT_RT */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 854984967fe2..73e477d8cf1a 100644
=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5078,6 +5078,8 @@ static struct rq *finish_task_switch(struct task_str=
uct *prev)
 	struct rq *rq =3D this_rq();
 	struct mm_struct *mm =3D rq->prev_mm;
 	unsigned int prev_state;
+	if (!strcmp(prev->comm, "systemd"))
+		printk(KERN_INFO "%s 0: %px\n", __func__, prev);
=20
 	/*
 	 * The previous task will have left us with a preempt_count of 2
@@ -5144,15 +5146,18 @@ static struct rq *finish_task_switch(struct task_s=
truct *prev)
 	}
=20
 	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
+		printk(KERN_INFO "%s 1: %px (%s)\n", __func__, prev, prev->comm);
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
=20
+		printk(KERN_INFO "%s 2: %px (%s)\n", __func__, prev, prev->comm);
 		/*
 		 * sched_ext_dead() must come before cgroup_task_dead() to
 		 * prevent cgroups from being removed while its member tasks are
 		 * visible to SCX schedulers.
 		 */
 		sched_ext_dead(prev);
+		printk(KERN_INFO "%s 3: %px (%s)\n", __func__, prev, prev->comm);
 		cgroup_task_dead(prev);
=20
 		/* Task is done with its stack. */
@@ -5202,6 +5207,8 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
+	if (!strcmp(prev->comm, "systemd"))
+		printk(KERN_INFO "%s 0: %px\n", __func__, prev);
 	prepare_task_switch(rq, prev, next);
=20
 	/*


I also tried monitoring the schedule_tail(), which is one of the two funct=
ion calling
finish_task_switch(), but that did get rid of the delay.

The result from this is:
2026-02-24T13:13:21.739185+01:00 localhost 12,32039,34364889,-,caller=3DT2=
955;reboot=20
[...]
Here the delay section begins (all message here have comm =3D=3D "systemd"=
):
2026-02-24T13:13:38.124013+01:00 localhost 6,45456,50748843,-,caller=3DT1;=
context_switch 0: ffff97fd40884300
2026-02-24T13:13:38.124234+01:00 localhost 6,45457,50748851,-,caller=3DT0;=
finish_task_switch 0: ffff97fd40884300
2026-02-24T13:13:38.271984+01:00 localhost 6,45458,50896237,-,caller=3DT15=
73;context_switch 0: ffff97fd46050000
2026-02-24T13:13:38.272255+01:00 localhost 6,45459,50896244,-,caller=3DT52=
;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:13:38.272556+01:00 localhost 6,45460,50896287,-,caller=3DT15=
73;context_switch 0: ffff97fd46050000
2026-02-24T13:13:38.272759+01:00 localhost 6,45461,50896289,-,caller=3DT51=
;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:13:38.273225+01:00 localhost 6,45462,50896303,-,caller=3DT15=
73;context_switch 0: ffff97fd46050000
2026-02-24T13:13:38.273406+01:00 localhost 6,45463,50896305,-,caller=3DT51=
;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:13:38.273819+01:00 localhost 6,45464,50896481,-,caller=3DT15=
73;context_switch 0: ffff97fd46050000
2026-02-24T13:13:38.274025+01:00 localhost 6,45465,50896484,-,caller=3DT0;=
finish_task_switch 0: ffff97fd46050000
2026-02-24T13:13:38.274465+01:00 localhost 6,45466,50896801,-,caller=3DT1;=
context_switch 0: ffff97fd40884300
2026-02-24T13:13:38.274635+01:00 localhost 6,45467,50896804,-,caller=3DT0;=
finish_task_switch 0: ffff97fd40884300
2026-02-24T13:13:38.275034+01:00 localhost 6,45468,50897328,-,caller=3DT1;=
context_switch 0: ffff97fd40884300
2026-02-24T13:13:38.275254+01:00 localhost 6,45469,50897331,-,caller=3DT20=
77;finish_task_switch 0: ffff97fd40884300
2026-02-24T13:13:38.275680+01:00 localhost 6,45470,50897600,-,caller=3DT1;=
context_switch 0: ffff97fd40884300
2026-02-24T13:13:38.275886+01:00 localhost 6,45471,50897602,-,caller=3DT0;=
finish_task_switch 0: ffff97fd40884300
2026-02-24T13:13:38.276300+01:00 localhost 6,45472,50897936,-,caller=3DT1;=
context_switch 0: ffff97fd40884300
2026-02-24T13:13:38.276487+01:00 localhost 6,45473,50897939,-,caller=3DT0;=
finish_task_switch 0: ffff97fd40884300
2026-02-24T13:13:38.276907+01:00 localhost 6,45474,50898225,-,caller=3DT1;=
context_switch 0: ffff97fd40884300
2026-02-24T13:13:38.279144+01:00 localhost 6,45475,50898228,-,caller=3DT68=
;finish_task_switch 0: ffff97fd40884300

[...] 1505 similar lines removed

2026-02-24T13:14:54.000427+01:00 localhost 6,46981,126614226,-,caller=3DT4=
4;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:14:54.000967+01:00 localhost 6,46982,126614420,-,caller=3DT1=
;context_switch 0: ffff97fd40884300
2026-02-24T13:14:54.001060+01:00 localhost 6,46983,126614422,-,caller=3DT0=
;finish_task_switch 0: ffff97fd40884300
2026-02-24T13:14:54.001562+01:00 localhost 6,46984,126614462,-,caller=3DT1=
;context_switch 0: ffff97fd40884300
2026-02-24T13:14:54.001666+01:00 localhost 6,46985,126614463,-,caller=3DT0=
;finish_task_switch 0: ffff97fd40884300
2026-02-24T13:14:54.002182+01:00 localhost 6,46986,126614533,-,caller=3DT1=
;context_switch 0: ffff97fd40884300
2026-02-24T13:14:54.002296+01:00 localhost 6,46987,126614534,-,caller=3DT0=
;finish_task_switch 0: ffff97fd40884300
2026-02-24T13:14:54.002811+01:00 localhost 6,46988,126615219,-,caller=3DT1=
573;context_switch 0: ffff97fd46050000
2026-02-24T13:14:54.002910+01:00 localhost 6,46989,126615221,-,caller=3DT4=
2;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:14:54.003402+01:00 localhost 6,46990,126616376,-,caller=3DT1=
573;context_switch 0: ffff97fd46050000
2026-02-24T13:14:54.003510+01:00 localhost 6,46991,126616378,-,caller=3DT0=
;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:14:54.004034+01:00 localhost 6,46992,126621884,-,caller=3DT1=
573;context_switch 0: ffff97fd46050000
2026-02-24T13:14:54.004125+01:00 localhost 6,46993,126621887,-,caller=3DT0=
;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:14:54.004645+01:00 localhost 6,46994,126625311,-,caller=3DT1=
573;context_switch 0: ffff97fd46050000
2026-02-24T13:14:54.004734+01:00 localhost 6,46995,126625314,-,caller=3DT2=
35;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:14:54.013405+01:00 localhost 6,46996,126637601,-,caller=3DT1=
;context_switch 0: ffff97fd40884300
2026-02-24T13:14:54.013614+01:00 localhost 6,46997,126637603,-,caller=3DT0=
;finish_task_switch 0: ffff97fd40884300
2026-02-24T13:14:54.014165+01:00 localhost 6,46998,126638229,-,caller=3DT1=
573;context_switch 0: ffff97fd46050000
2026-02-24T13:14:54.014266+01:00 localhost 6,46999,126638232,-,caller=3DT4=
4;finish_task_switch 0: ffff97fd46050000
2026-02-24T13:14:54.014774+01:00 localhost 6,47000,126638469,-,caller=3DT1=
573;context_switch 0: ffff97fd46050000 END

So there's something strange going on here with the scheduler.


Bert Karwatzki

