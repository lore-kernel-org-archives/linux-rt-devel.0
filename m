Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282239A7F3
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937914; cv=none; b=uQ5yp+d7IQNlaFUieBHVuVwHudDCah+sfXqkYsAcqBGVZuwRSFM02AueRIL7cCeYIsenBiekCssf27dRhE9PzYlI8f/Fje6gsxbvpfKA0lSmt2d8XheDBT8FILWyloGqvj8eHNT7S39GjFKOyhcpatsFvruJTLU+55pVn35bqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937914; c=relaxed/simple;
	bh=4xTMxd9uLibrAONWVtZZhCvoLxIAwQCGJeUCoA/K4GY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IegpU1OdwFGkj9qpUcE+BjUhOAfr7G0Tj/+WZ/Qda4NYVXYCtQxUXYuKUNj9zWXpgot0g2CCgx6uXb0Pa7Qmwk+ohEdcMbgXzLD8bqhQet9Ir5yzPbmccrIS0PLsBfJyb3VC8gxlDaMk4+TWi5eKquWf2yuLMsQrP0wYTRWX61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=fwvUBNdE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="fwvUBNdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771937901; x=1772542701; i=spasswolf@web.de;
	bh=LDk6CKS7FOGpRkpFMji9VEaP9qRBsrBkMciqzGBgKqY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fwvUBNdEJFERJtcxtAVmFopxY/0j812GCZP4oVCNGrgkb3ruVhxV8UAjVP3GHuBr
	 Uy688gzm+G0HzeY3YZlQBNQDy6qkfJ1etER+L1qEMGQXkwASANnPlgh67Jq0UsgZH
	 vpq7TxH0OwBQtT1/xE/YvwCbv2+a8BW3zlT33cxGbGMhEaWqZf1ys1itLWn1fufNU
	 4HPsqxCCiiXxLPZBGdqyzKG5WrT0m2qOYfDHJcOHw38+ZlH6NReEyjz/uEuvOo1Dv
	 DL4vXR+MONQ8nRrMND+O0di7WHxHuzk6qS2lTISc8S8lcshO/UYjdXr4glqTmLfGv
	 hRsXKcac2RWYg15e4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1vR0sL0kOa-00gwAY; Tue, 24
 Feb 2026 13:58:21 +0100
Message-ID: <4570355cda2a669903e2f77bd14b55148fd0ed38.camel@web.de>
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Calvin Owens <calvin@wbinvd.org>, "spasswolf@web.de Tejun Heo"
	 <tj@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas
 Gleixner <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Date: Tue, 24 Feb 2026 13:58:19 +0100
In-Reply-To: <e1375d364a2ec20b393b24740ee5df6d53e9f120.camel@web.de>
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
	 <e1375d364a2ec20b393b24740ee5df6d53e9f120.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RvkkhTGq5MKQ89s7x/XKhs7BepN1GVXNHNFqHAo1RUYoeQz5O+S
 BGaozKkQ1TP4XsOHxOJYbRzTVC41jG63u0IqDmq5oXtq1O6hO6XIGpmYkLeSwDjJznxuRxq
 +rpbhRGiyrT3Vu7DXVIQAQ5UgWl8U5OdMHeL9dOebLnSPGg61ILmg57vQQcaEbXoZsVdvav
 VJbtInHYLhhKmmu9TAtOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BVgAr1dqnvE=;mPOYEcFV8EA4L/P/pYOE9ruj0Gz
 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
 7vNcXwbk=

Am Dienstag, dem 24.02.2026 um 13:44 +0100 schrieb Bert Karwatzki:
> I've done some more monitoring with this debug patch which monitors
> cgroup_task_dead() and the function which calls it finish task switch.
> To avoid too many messages some printk()s are filtered by command name
> (a previous patch showed systemd to be the problematic process):
>=20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 5f0d33b04910..7bb6931a4d86 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6990,25 +6990,32 @@ static void do_cgroup_task_dead(struct task_stru=
ct *tsk)
>  {
>  	struct css_set *cset;
>  	unsigned long flags;
> +	printk(KERN_INFO "%s 0: task =3D %px\n", __func__, tsk);
> =20
>  	spin_lock_irqsave(&css_set_lock, flags);
> =20
> +	printk(KERN_INFO "%s 1: task =3D %px\n", __func__, tsk);
>  	WARN_ON_ONCE(list_empty(&tsk->cg_list));
>  	cset =3D task_css_set(tsk);
> +	printk(KERN_INFO "%s 2: task =3D %px\n", __func__, tsk);
>  	css_set_move_task(tsk, cset, NULL, false);
> +	printk(KERN_INFO "%s 3: task =3D %px\n", __func__, tsk);
>  	cset->nr_tasks--;
>  	/* matches the signal->live check in css_task_iter_advance() */
>  	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
>  		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
> =20
> +	printk(KERN_INFO "%s 4: task =3D %px\n", __func__, tsk);
>  	if (dl_task(tsk))
>  		dec_dl_tasks_cs(tsk);
> =20
> +	printk(KERN_INFO "%s 5: task =3D %px\n", __func__, tsk);
>  	WARN_ON_ONCE(cgroup_task_frozen(tsk));
>  	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
>  		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
>  		cgroup_update_frozen(task_dfl_cgroup(tsk));
> =20
> +	printk(KERN_INFO "%s 6: task =3D %px\n", __func__, tsk);
>  	spin_unlock_irqrestore(&css_set_lock, flags);
>  }
> =20
> @@ -7029,9 +7036,11 @@ static void cgrp_dead_tasks_iwork_fn(struct irq_w=
ork *iwork)
>  {
>  	struct llist_node *lnode;
>  	struct task_struct *task, *next;
> +	printk(KERN_INFO "%s:\n", __func__);
> =20
>  	lnode =3D llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
>  	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
> +		printk(KERN_INFO "%s: %px %s", __func__, task, task->comm);
>  		do_cgroup_task_dead(task);
>  		put_task_struct(task);
>  	}
> @@ -7050,6 +7059,7 @@ static void __init cgroup_rt_init(void)
> =20
>  void cgroup_task_dead(struct task_struct *task)
>  {
> +	printk(KERN_INFO "%s: task =3D %px (%s)\n", __func__, task, task->comm=
);
>  	get_task_struct(task);
>  	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
>  	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
> @@ -7059,6 +7069,7 @@ static void __init cgroup_rt_init(void) {}
> =20
>  void cgroup_task_dead(struct task_struct *task)
>  {
> +	printk(KERN_INFO "%s: task =3D %px (%s)\n", __func__, task, task->comm=
);
>  	do_cgroup_task_dead(task);
>  }
>  #endif	/* CONFIG_PREEMPT_RT */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 854984967fe2..73e477d8cf1a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5078,6 +5078,8 @@ static struct rq *finish_task_switch(struct task_s=
truct *prev)
>  	struct rq *rq =3D this_rq();
>  	struct mm_struct *mm =3D rq->prev_mm;
>  	unsigned int prev_state;
> +	if (!strcmp(prev->comm, "systemd"))
> +		printk(KERN_INFO "%s 0: %px\n", __func__, prev);
> =20
>  	/*
>  	 * The previous task will have left us with a preempt_count of 2
> @@ -5144,15 +5146,18 @@ static struct rq *finish_task_switch(struct task=
_struct *prev)
>  	}
> =20
>  	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
> +		printk(KERN_INFO "%s 1: %px (%s)\n", __func__, prev, prev->comm);
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
> =20
> +		printk(KERN_INFO "%s 2: %px (%s)\n", __func__, prev, prev->comm);
>  		/*
>  		 * sched_ext_dead() must come before cgroup_task_dead() to
>  		 * prevent cgroups from being removed while its member tasks are
>  		 * visible to SCX schedulers.
>  		 */
>  		sched_ext_dead(prev);
> +		printk(KERN_INFO "%s 3: %px (%s)\n", __func__, prev, prev->comm);
>  		cgroup_task_dead(prev);
> =20
>  		/* Task is done with its stack. */
> @@ -5202,6 +5207,8 @@ static __always_inline struct rq *
>  context_switch(struct rq *rq, struct task_struct *prev,
>  	       struct task_struct *next, struct rq_flags *rf)
>  {
> +	if (!strcmp(prev->comm, "systemd"))
> +		printk(KERN_INFO "%s 0: %px\n", __func__, prev);
>  	prepare_task_switch(rq, prev, next);
> =20
>  	/*
>=20
>=20
> I also tried monitoring the schedule_tail(), which is one of the two fun=
ction calling
> finish_task_switch(), but that did get rid of the delay.

This is incorrect. Monitoring schedule_tail() does not undo the delayed sh=
utdown, but
the delay probalbly has only 95% reproducability.

>=20
> The result from this is:
> 2026-02-24T13:13:21.739185+01:00 localhost 12,32039,34364889,-,caller=3D=
T2955;reboot=20
> [...]
> Here the delay section begins (all message here have comm =3D=3D "system=
d"):
> 2026-02-24T13:13:38.124013+01:00 localhost 6,45456,50748843,-,caller=3DT=
1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.124234+01:00 localhost 6,45457,50748851,-,caller=3DT=
0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.271984+01:00 localhost 6,45458,50896237,-,caller=3DT=
1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.272255+01:00 localhost 6,45459,50896244,-,caller=3DT=
52;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.272556+01:00 localhost 6,45460,50896287,-,caller=3DT=
1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.272759+01:00 localhost 6,45461,50896289,-,caller=3DT=
51;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.273225+01:00 localhost 6,45462,50896303,-,caller=3DT=
1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.273406+01:00 localhost 6,45463,50896305,-,caller=3DT=
51;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.273819+01:00 localhost 6,45464,50896481,-,caller=3DT=
1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.274025+01:00 localhost 6,45465,50896484,-,caller=3DT=
0;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:13:38.274465+01:00 localhost 6,45466,50896801,-,caller=3DT=
1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.274635+01:00 localhost 6,45467,50896804,-,caller=3DT=
0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.275034+01:00 localhost 6,45468,50897328,-,caller=3DT=
1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.275254+01:00 localhost 6,45469,50897331,-,caller=3DT=
2077;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.275680+01:00 localhost 6,45470,50897600,-,caller=3DT=
1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.275886+01:00 localhost 6,45471,50897602,-,caller=3DT=
0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.276300+01:00 localhost 6,45472,50897936,-,caller=3DT=
1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.276487+01:00 localhost 6,45473,50897939,-,caller=3DT=
0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.276907+01:00 localhost 6,45474,50898225,-,caller=3DT=
1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:13:38.279144+01:00 localhost 6,45475,50898228,-,caller=3DT=
68;finish_task_switch 0: ffff97fd40884300
>=20
> [...] 1505 similar lines removed
>=20
> 2026-02-24T13:14:54.000427+01:00 localhost 6,46981,126614226,-,caller=3D=
T44;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.000967+01:00 localhost 6,46982,126614420,-,caller=3D=
T1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.001060+01:00 localhost 6,46983,126614422,-,caller=3D=
T0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.001562+01:00 localhost 6,46984,126614462,-,caller=3D=
T1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.001666+01:00 localhost 6,46985,126614463,-,caller=3D=
T0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.002182+01:00 localhost 6,46986,126614533,-,caller=3D=
T1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.002296+01:00 localhost 6,46987,126614534,-,caller=3D=
T0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.002811+01:00 localhost 6,46988,126615219,-,caller=3D=
T1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.002910+01:00 localhost 6,46989,126615221,-,caller=3D=
T42;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.003402+01:00 localhost 6,46990,126616376,-,caller=3D=
T1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.003510+01:00 localhost 6,46991,126616378,-,caller=3D=
T0;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.004034+01:00 localhost 6,46992,126621884,-,caller=3D=
T1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.004125+01:00 localhost 6,46993,126621887,-,caller=3D=
T0;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.004645+01:00 localhost 6,46994,126625311,-,caller=3D=
T1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.004734+01:00 localhost 6,46995,126625314,-,caller=3D=
T235;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.013405+01:00 localhost 6,46996,126637601,-,caller=3D=
T1;context_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.013614+01:00 localhost 6,46997,126637603,-,caller=3D=
T0;finish_task_switch 0: ffff97fd40884300
> 2026-02-24T13:14:54.014165+01:00 localhost 6,46998,126638229,-,caller=3D=
T1573;context_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.014266+01:00 localhost 6,46999,126638232,-,caller=3D=
T44;finish_task_switch 0: ffff97fd46050000
> 2026-02-24T13:14:54.014774+01:00 localhost 6,47000,126638469,-,caller=3D=
T1573;context_switch 0: ffff97fd46050000 END
>=20
> So there's something strange going on here with the scheduler.
>=20
>=20
> Bert Karwatzki
