Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B8259CB6
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112647; cv=none; b=Y9a9U/UM5S6LED+0HmV47uzmEjbFbxBeb5xORoCQB1HyuMXP/XhVuZEDOmDFcRcFVu8NBFY0ye259QWda4ID2AeCMo0q3lSdvgk2AvCkI2qO6e3JH1bQNAN2byu2c+l9H2CAlu2MJTfBtQXIX4s1Ne3CDJhQ4Yiatp6GMLgQnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112647; c=relaxed/simple;
	bh=1JJFPASpIIjQR26HiaZE86XKPtyZGDjamzUt6TFCAeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4Al08QMNg7G0gf4La6C5ecObS050Fl4nNmpi9GXKCfmw7upXeO9+jBMnp2FrsKBDf84KzAUAkppk7KvQ66QvP+iRu3y+vQBcwJTk3AWltt8Dvxpt4EdTH0LRu0Suvu+YM6f2zJ0RX2gtBVxF29AEEzs7I7UC+UFX1kRUJTUEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=T9qGkIj7; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="T9qGkIj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772112643; x=1772717443; i=spasswolf@web.de;
	bh=4lw6JK1LbdqgNtXX572wRAIGDxuhI0Nq+F2ZSBrf36Y=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T9qGkIj7fDY9ddb5NH5TQ+Wtc9JadKGkx8UXEROGvL9KM/E2n5KCD+CAajDFGa9x
	 smQHvCE/h/lMfiCS2UkcjPExuPO9OrTGDI6M4M9XU8QfXN8jA9yv3BWcZqW8obged
	 1S+3DPfhM6GnWwYrGeEOTxsymfVdbvWd2q98B95PNeARkHA84aR665yYt4ge5550Y
	 HODIUkJA4An8nI4Gs8Vk6Sq1Arj+ODlVz/r7zG9N5LaayzivpEbsJqN+MuwyDSw1w
	 ORmfBnX0vgQ7aWmGeOZSyCt9zsRgs5SaXW/BQiDK+f+UB7tmP7lPoLxaCfsuwnPzN
	 U8cscssx+L6qJbdb3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1vWPVQ21au-015Tdb; Thu, 26
 Feb 2026 14:24:36 +0100
Message-ID: <b5a3f7a9e83e19209b1bd054e8bd8dfff0d22317.camel@web.de>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Steven
 Rostedt	 <rostedt@goodmis.org>, spasswolf@web.de
Date: Thu, 26 Feb 2026 14:24:34 +0100
In-Reply-To: <20260225223135.vjfaFo0c@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	 <20260219164648.3014-1-spasswolf@web.de>
	 <20260225154341.32AjXoVi@linutronix.de>
	 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
	 <20260225165954.180aRkaV@linutronix.de>
	 <20260225223135.vjfaFo0c@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FG2oamYUeoAgbei93vfIEM39OHsjbrwJe4zzELiY+a2KFO6tSg
 746gK7hxP3nEtIcikoDdmD8gfNGapd/mfRZnC/WgS/BbIHlejIfa0fdEMesguevFTw83Ydb
 Ni4YXo8ewCMR1yZyshRuMznkwDGPljXSuuXefF1sp15+ybUztfxkE8K5e0VzyUtwsH0wxu8
 KsDySJ1BvMTD7kR9OYwBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xX6/+hijzm4=;dp7t0K6X44uBwWSK44pq0IOjm2P
 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
 TW/oJR0FrlrCZ2Ukk=

I think I've found the reason for the stall. I was looking at commit 9311e=
6c29b34
("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT"),
and noticed this:

+static void __init cgroup_rt_init(void)
+{
+       int cpu;
+
+       for_each_possible_cpu(cpu) {
+               init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
+               per_cpu(cgrp_dead_tasks_iwork, cpu) =3D
+                       IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
+       }

IRQ_WORK_INIT_LAZY() expands to __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY):
(in include/linux/irq_work.h)
IRQ_WORK_LAZY is declare in include/linux/smp-types.h:
	IRQ_WORK_LAZY		=3D 0x04, /* No IPI, wait for tick */

The "wait for tick" gave me an idea as I'm also using
CONFIG_NO_HZ_FULL=3Dy

so I tried

commit b7453da1c7de288235234eb9265c3a2d661c1a2d (HEAD -> reboot_delay_debu=
g_0)
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Thu Feb 26 14:01:41 2026 +0100

    cgroup: use IRQ_WORK_INIT in cgroup_rt_init()
   =20
    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b750aa284b89..ed22842eb5d3 100644
=2D-- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7047,7 +7047,7 @@ static void __init cgroup_rt_init(void)
        for_each_possible_cpu(cpu) {
                init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
                per_cpu(cgrp_dead_tasks_iwork, cpu) =3D
-                       IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
+                       IRQ_WORK_INIT(cgrp_dead_tasks_iwork_fn);
        }
 }
=20

and this seems to have fixes the issue for me. (Five successful reboots
in a row, needs more testing).

Bert Karwatzki
