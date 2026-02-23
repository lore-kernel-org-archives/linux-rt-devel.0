Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15237E313
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Feb 2026 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889829; cv=none; b=oqu7Je8RU4Sq26Lg4C9pYqlVUiwwXCSl3PkT8IUMV6llj86COaPhU/qKR/oH0TY7tJsSqp2A5N7301NyCvjx+WFvLclzSTKiFxEuer8VyWLj6vSNyUyGW7+rRMIXPWSGFfMosnN6ZeNSTVuESN8b3ajD9NdA4vMlZxjIhjUzFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889829; c=relaxed/simple;
	bh=8LUFYubaRGbSxCSauwb2t8m1/ENJL3yHnrUbrSyOa9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElvBbytmZIo6U6/vOe2ViNC8yIqmgrLaROkTNRLV0ZT3XCB4mmF29cj4SFuLPL1m6wr5UrTd/PbkGcC7yLLm5b5Odpuo5IncpAoGc+nd/+Rfh2zyrnHYa7MWcUSlYGDuS6oluvffG2bXUaTtCiySnVu9DuhzUaxTBVXY6ymRWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=YaGzxBO8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="YaGzxBO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771889791; x=1772494591; i=spasswolf@web.de;
	bh=8L4mwK3Bc+bFmTYVB5HFK17snm5p/OjXR9+ulwuYtKo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YaGzxBO84UqlurWH8vtBDJOaYRNgF0ezL2FJmHKJl6/uC5cMS6+AqGZ1fSMZrGIC
	 VmD+HrQu7YkPW/1y7EFN6L5TU2pZDL+yN/Rjp6vXvfUXpu+2++veMZW4/iiFJtq54
	 BBzejHzVSVPvFEMVfLatMMA01wMv0yfISQ+aM2kYabhIu98WphJa8TKr8RLGMZcnk
	 cZ8w4hNtROXyvFCE2z6Pmv9fu/5Xd+IbTjqIcf7qz8VjaM3L4bjVARvNp8LcXnhPA
	 0QxgoKpqEbCKJQb0PH3L85t3nIwDVHspcLmQrOHHwVn8xQLXfOV/nxB13bnT2cjt/
	 55zUX5/CjWYJJd27bA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1wCTRW0iEj-00JBax; Tue, 24
 Feb 2026 00:36:31 +0100
Message-ID: <e76913d8778d3eb1d759cdd3239a2963216b9328.camel@web.de>
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, 
	spasswolf@web.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas
 Gleixner <tglx@linutronix.de>, dschatzberg@meta.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Date: Tue, 24 Feb 2026 00:36:27 +0100
In-Reply-To: <80f657156fb2d32d8fe246e65e9ac8bf9d7cfbd5.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
				<20260219164648.3014-1-spasswolf@web.de>	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
				<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
				<20260219195851.7a7bd1b2@fedora>
				<1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
				<20260220104420.54610b04@gandalf.local.home>
				<ba582a2511d8cd4cda5a186ec48263076ac885cc.camel@web.de>
			 <20260223032257.4e6db467@fedora>
	 <80f657156fb2d32d8fe246e65e9ac8bf9d7cfbd5.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TnKL/4YrtRaqutj370i1yz7T6v4g+aua8XZpqm0YoJ/wX50lqIU
 mLCOUhk5UwRQ94Q2t83iAiKAggZIgONvx44l3pbJr25R1lPK8bPo+zi5j6G+leaQW51Wpgv
 J1VUOfDULfv77xX9MuFvuafzS9R9mR3cyGgKzLdgH8iZguKdcp+xdH3roUpklV4LysJBkzG
 zEnL38sDvQtkXBJCF7x9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BpVTuz186/8=;qUdi//cjv0UwbEga47ZKeEG7JgV
 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
 R2ZVr4jE=

As the bisection in suggested that commit9311e6c29b34 ("cgroup: Fix sleepi=
ng from invalid context warning on PREEMPT_RT")
is somehow causing the problem I put some printk()s in the code changed by=
 this
commit and captured the output via netconsole (I tried using trace_printk(=
) to
use the persistent ringbuffer but got no output).

This is the debug patch (for v6.19):

commit 655ad0d7ce2d03b1b8bfbc2a3e6c36b46a4604c5
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Mon Feb 23 21:49:47 2026 +0100

    cgroup: add printk() cgroup_task_dead for PREEMPT_RT
   =20
    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f0d33b04910..16bb40df5dd0 100644
=2D-- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7029,6 +7029,7 @@ static void cgrp_dead_tasks_iwork_fn(struct irq_work=
 *iwork)
 {
 	struct llist_node *lnode;
 	struct task_struct *task, *next;
+	printk(KERN_INFO "%s:\n", __func__);
=20
 	lnode =3D llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
 	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
@@ -7050,6 +7051,7 @@ static void __init cgroup_rt_init(void)
=20
 void cgroup_task_dead(struct task_struct *task)
 {
+	printk(KERN_INFO "%s: task =3D %s\n", __func__, task->comm);
 	get_task_struct(task);
 	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
 	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));


This is the output captured via netconsole after rebooting via
# echo reboot > /dev/kmsg && reboot

2026-02-24T00:17:38.836655+01:00 localhost 12,5335,211298089,-,caller=3DT3=
211;reboot=20
2026-02-24T00:17:38.848658+01:00 localhost 6,5336,211309667,-,caller=3DT0;=
cgroup_task_dead: task =3D reboot
2026-02-24T00:17:38.848658+01:00 localhost 6,5337,211310223,-,caller=3DT50=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:17:38.852694+01:00 localhost 6,5338,211313770,-,caller=3DT0;=
cgroup_task_dead: task =3D gmain
2026-02-24T00:17:38.852694+01:00 localhost 6,5339,211313776,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-sess:cs0
2026-02-24T00:17:38.852694+01:00 localhost 6,5340,211313798,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-sess:sh0
2026-02-24T00:17:38.852694+01:00 localhost 6,5341,211313810,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-:sh_opt0
2026-02-24T00:17:38.852694+01:00 localhost 6,5342,211313830,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-:traceq0
2026-02-24T00:17:38.852694+01:00 localhost 6,5343,211313840,-,caller=3DT0;=
cgroup_task_dead: task =3D pool-spawner
2026-02-24T00:17:38.852694+01:00 localhost 6,5344,211313839,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-:traceq0
2026-02-24T00:17:38.852694+01:00 localhost 6,5345,211313868,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-session
2026-02-24T00:17:38.852694+01:00 localhost 6,5346,211313871,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-:traceq0
2026-02-24T00:17:38.852694+01:00 localhost 6,5347,211313874,-,caller=3DT0;=
cgroup_task_dead: task =3D xfce4-s:disk$0
[...]
Here comes the part which shows the delay (I did not remove any message he=
re):
2026-02-24T00:17:40.964180+01:00 localhost 6,6838,213423568,-,caller=3DT0;=
cgroup_task_dead: task =3D (sd-close)
2026-02-24T00:17:40.964244+01:00 localhost 6,6839,213423756,-,caller=3DT0;=
cgroup_task_dead: task =3D systemctl
2026-02-24T00:17:40.964576+01:00 localhost 6,6840,213424221,-,caller=3DT34=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:17:40.964649+01:00 localhost 6,6841,213424221,-,caller=3DT23=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:17:40.964969+01:00 localhost 6,6842,213424435,-,caller=3DT0;=
cgroup_task_dead: task =3D (sd-close)
2026-02-24T00:17:40.965057+01:00 localhost 6,6843,213425219,-,caller=3DT50=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:17:44.025094+01:00 localhost 6,6844,216485806,-,caller=3DT0;=
cgroup_task_dead: task =3D (udev-worker)
2026-02-24T00:17:44.025094+01:00 localhost 6,6845,216485810,-,caller=3DT0;=
cgroup_task_dead: task =3D (udev-worker)
2026-02-24T00:17:44.025387+01:00 localhost 6,6846,216485816,-,caller=3DT0;=
cgroup_task_dead: task =3D (udev-worker)
2026-02-24T00:17:44.025642+01:00 localhost 6,6847,216486228,-,caller=3DT66=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:17:44.025718+01:00 localhost 6,6848,216486239,-,caller=3DT12=
2;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:17:44.025923+01:00 localhost 6,6849,216486239,-,caller=3DT82=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:19:11.070444+01:00 localhost 6,6850,303512419,-,caller=3DT0;=
cgroup_task_dead: task =3D systemd
2026-02-24T00:19:11.070444+01:00 localhost 6,6851,303513238,-,caller=3DT34=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:19:11.070725+01:00 localhost 6,6852,303513728,-,caller=3DT0;=
cgroup_task_dead: task =3D (sd-pam)
2026-02-24T00:19:11.070888+01:00 localhost 6,6853,303514010,-,caller=3DT0;=
cgroup_task_dead: task =3D (sd-close)
2026-02-24T00:19:11.071192+01:00 localhost 6,6854,303514221,-,caller=3DT90=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:19:11.071291+01:00 localhost 6,6855,303514238,-,caller=3DT50=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:19:11.071626+01:00 localhost 6,6856,303514629,-,caller=3DT0;=
cgroup_task_dead: task =3D (sd-close)
2026-02-24T00:19:11.072139+01:00 localhost 6,6857,303515237,-,caller=3DT50=
;cgrp_dead_tasks_iwork_fn:=20
2026-02-24T00:19:11.107473+01:00 localhost 6,6858,303549400,-,caller=3DT0;=
cgroup_task_dead: task =3D psimon
2026-02-24T00:19:11.107473+01:00 localhost 6,6859,303550244,-,caller=3DT66=
;cgrp_dead_tasks_iwork_fn:
[...]

I've tried this several times and the function calls just before the delay=
 are always the same.

Bert Karwatzki
