Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBE1F5437
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037503; cv=none; b=pgGlvzlI/o0Mlfo95vn6O3b72UrhZ3bt/KOEw3iiR5BNVhHYVNCK3yZsNxFL4pDU8slAKz1SqiS9EPmQ66FDwbj8y1dYx1KfcaNBahV9B4Oy40vDsIzRvRkCHUvc5hmTSzLgRokGaphraIL0gwn9EqWNsGf6qbK7aTzF7wzhLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037503; c=relaxed/simple;
	bh=nNmAUNTkAqTZAxxXwF5pnhiP+R4BdCBoB3J53xk2qlc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5NJcEEFnpeYHv3Vszq9kcQ/vlToQ8cX8vGvhVPT17Y/w6HlZb6XPsj/QDs2ENbu6F8es+LpcHnJzu7CPWoOJK0C7TWnJWJs7M0sjX7DrQLHxRxIPSamIfCFOq1qjH9zJsOjouggubi9Q56Jr2lPwacvehffmSKnnof9qXuVZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=muEmSNF/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="muEmSNF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772037479; x=1772642279; i=spasswolf@web.de;
	bh=nUFlItDOwTukYAnaHXW5/mOHEp3ZpfRvU5NwsJkdk+o=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=muEmSNF/94K/jNKEL5LULGmAJyi1gW2uD0s0zZet6+utnxOjeQOWA9IEI7Qih/mH
	 kVD5VTruzdYYAcqgYEyzXk27MY3dy7/kaBoNnDJwYZ0smTOvvV1kTGjkWqZ7NJ/Tc
	 ycyTzY0LK55TP40KstpjM7GF9E39Ptk3qKlZhgyYjdLkmfAVi3zunlzJEkknOtIPY
	 gCtABRIGUvE36/MHT7rqvXWxqpOFKxoOZInUjznAUGlHDpfojfvWfDbjFyPsLvE86
	 aW3HsI+nTAIX/LM7HagPwUUGochvrUf0oZIw0JiHO+ZJxyfHRoaJR/Lhqla16nNfF
	 VEV8Jaf7y5RSrSDbmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQyl-1wEK332eWh-00Kss4; Wed, 25
 Feb 2026 17:37:58 +0100
Message-ID: <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	spasswolf@web.de, calvin@wbinvd.org, dschatzberg@meta.com,
 peterz@infradead.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Steven Rostedt	 <rostedt@goodmis.org>
Date: Wed, 25 Feb 2026 17:37:56 +0100
In-Reply-To: <20260225154341.32AjXoVi@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	 <20260219164648.3014-1-spasswolf@web.de>
	 <20260225154341.32AjXoVi@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UjTuM/rn2Rw1PYjGlU57i3uFG6592cERzci1ZCd6twt5bJvnyk6
 gazHmuisf8VOBhkmOsMpSAFHdYQiTiTWOOy/ZUnxOsHNty1nu0ZppHM690zkontb2zpVsYM
 cH7YqiHV9y+yNJ+zsq1TnFZqoxM7SYWRuK1xEh4Bmj9rZNBj+y2fV8zZ3MLc/A2wZ8/KXOG
 y07W7wQMRPvvS4ijpOEzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cTKeiiAdsNU=;p/8P6OrWfJiCtvUvtUHO4Bd6oWw
 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

Am Mittwoch, dem 25.02.2026 um 16:43 +0100 schrieb Sebastian Andrzej Siewi=
or:
> On 2026-02-19 17:46:47 [+0100], Bert Karwatzki wrote:
> > Since linux v6.19 I noticed that rebooting my MSI Alpha 15 Laptop
> > would hang for about ~90s before rebooting. I bisected this (from
> > v6.18 to v6.19) and got this as the first bad commit:
> > 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PR=
EEMPT_RT")
> =E2=80=A6
>=20
> I'm on it. I looks like we free the task after sched_process_wait() but
> before it is entirely gone there is a wait() on its pid. Some of them do
> come back but one seems to be stuck and I need to figure out which one.
> If we get rid of the LAZY then it happens "quick" enough so it works.
>=20
> > Bert Karwatzki
>=20
> Sebastian

I've done two testruns with this debug patch (The persistant log buffer wo=
rks now, thanks
again to Steven Rostedt):

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f0d33b04910..b750aa284b89 100644
=2D-- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6990,6 +6990,7 @@ static void do_cgroup_task_dead(struct task_struct *=
tsk)
 {
 	struct css_set *cset;
 	unsigned long flags;
+	trace_printk(KERN_INFO "%s 0: task =3D %px\n", __func__, tsk);
=20
 	spin_lock_irqsave(&css_set_lock, flags);
=20
@@ -7029,9 +7030,11 @@ static void cgrp_dead_tasks_iwork_fn(struct irq_wor=
k *iwork)
 {
 	struct llist_node *lnode;
 	struct task_struct *task, *next;
+	trace_printk(KERN_INFO "%s:\n", __func__);
=20
 	lnode =3D llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
 	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
+		trace_printk(KERN_INFO "%s: %px %s", __func__, task, task->comm);
 		do_cgroup_task_dead(task);
 		put_task_struct(task);
 	}
@@ -7050,6 +7053,7 @@ static void __init cgroup_rt_init(void)
=20
 void cgroup_task_dead(struct task_struct *task)
 {
+	trace_printk(KERN_INFO "%s: task =3D %px (%s)\n", __func__, task, task->=
comm);
 	get_task_struct(task);
 	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
 	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
@@ -7059,6 +7063,7 @@ static void __init cgroup_rt_init(void) {}
=20
 void cgroup_task_dead(struct task_struct *task)
 {
+	trace_printk(KERN_INFO "%s: task =3D %px (%s)\n", __func__, task, task->=
comm);
 	do_cgroup_task_dead(task);
 }
 #endif	/* CONFIG_PREEMPT_RT */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 854984967fe2..19b130b831bc 100644
=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5078,6 +5078,7 @@ static struct rq *finish_task_switch(struct task_str=
uct *prev)
 	struct rq *rq =3D this_rq();
 	struct mm_struct *mm =3D rq->prev_mm;
 	unsigned int prev_state;
+	trace_printk(KERN_INFO "%s 0: %px (%s)\n", __func__, prev, prev->comm);
=20
 	/*
 	 * The previous task will have left us with a preempt_count of 2
@@ -5153,6 +5154,7 @@ static struct rq *finish_task_switch(struct task_str=
uct *prev)
 		 * visible to SCX schedulers.
 		 */
 		sched_ext_dead(prev);
+		trace_printk(KERN_INFO "%s 1: %px (%s)\n", __func__, prev, prev->comm);
 		cgroup_task_dead(prev);
=20
 		/* Task is done with its stack. */
@@ -5202,6 +5204,7 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
+	trace_printk(KERN_INFO "%s 0: %px (%s)\n", __func__, prev, prev->comm);
 	prepare_task_switch(rq, prev, next);
=20
 	/*


This if from PREEMPT_RT log, there*s a long pause in which cgroup_task_dea=
d() is not called
59366:           <...>-3209    [001] d..2.    33.110392: 0xffffffffa36c309=
b: 6context_switch 0: ffff933eb264a180 (reboot)
[...]
112455:          <idle>-0       [006] ...1.    40.503766: 0xffffffffa2da57=
0c: 6cgroup_task_dead: task =3D ffff933f1885c300 ((udev-worker))
[...] no call to cgroup_task_dead() here, just finish_task_switch() and co=
ntext_switch()
217571:          <idle>-0       [010] ...1.   125.282118: 0xffffffffa2da57=
0c: 6cgroup_task_dead: task =3D ffff933e94fae480 (systemd)
[...]
274103          <idle>-0       [014] d..2.   130.157472: 0xffffffffa2cef12=
5: 6finish_task_switch 0: ffff933e815e10c0 (ksoftirqd/14)


This is other log (no pause here, just the first messages after reboot is =
initiated and
the last message, to show duration of shutdown):

58029:           <...>-2975    [003] d..2.    33.564291: 0xffffffff934b3e8=
9: 6context_switch 0: ffff88e1e0302180 (reboot)
[...]
107700           <...>-1       [000] d..2.    37.352191: 0xffffffff92aee9c=
5: 6finish_task_switch 0: ffffffff93c12980 (swapper/0)

The complete logs are here:
https://gitlab.freedesktop.org/spasswolf/pastebin/-/issues/2

Bert Karwatzki
