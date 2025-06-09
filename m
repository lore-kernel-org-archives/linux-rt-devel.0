Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE29191F66
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Jun 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469105; cv=none; b=c44H2Sw0LgA5OI/HAe/8HplmDD+QzRx+4coMAAqgdVniA6ohwlQ5PWGjIPAwNBeifvenSl6pKyiWOvZAVxLXa7q1o4nb5adeRs4b5IWlo0CujYxWIkUV3736Rm52bRfP7NPeSA2KTNcWvtMv3Rt4WCsu3b89zMvAGV/MHVrtSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469105; c=relaxed/simple;
	bh=xdWrDFFpC6icaaTK0pj4QPMHQ7LFHc2zTOhj//A83jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ks7gO4o6/2WwGGpzP9ZirF43jh7s9P5lxlvxz16APKuQmWA8SW/AsM2Chg7WW97tTxGnqG7XIbuMUlmK5ngE9QpDPeKM5oi4a6GbnnJvR79MVwnR/7En5MT+b8IS23tCjFo0VUWWVRDqaca5kfA7ZNKrT7gVKVlIkS0DY6kIGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=RjRv9W7B; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="RjRv9W7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749469080; x=1750073880; i=spasswolf@web.de;
	bh=EJ1vkrlvPCLzfWyTHeS+qk8L/ziRZ/dA7Y0V2IgPGd4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RjRv9W7By3E2bdK77crj84g2cIaYk8v18Nrh78ot8L3DgQBNG+C7YlqJRzfAHFQW
	 u4mhbDk1NdZ5yx/8NjYNGjaosicALBXoP4xhxGIrPq6FI88rQ252tQg/m7Y/imzmk
	 CDKCGiZbPlJcELldtNjsLGiGPBvVAvVN0/ueggOWDhEKbUblEX7E4XrKEgVE/O+kg
	 gCN+NSXQtnUgPA8HJ3L2jTN9IxsHrC82asTjnoxN2lb9ZrlpcCTA4DLmbs7bNwAaO
	 YSUk2sXqSmIPrTiaM1Z5dT5t2Mz1c+EsCwD7/lnKVwRMWZRSpE/X18gmUsPp1qCmY
	 0cKIB0Cj8pL+vMU3Ww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1uCAVT0Efv-00PMRo; Mon, 09
 Jun 2025 13:38:00 +0200
Message-ID: <0c0b2385452292d6b1df3066b7223b420066f0a1.camel@web.de>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, spasswolf@web.de
Date: Mon, 09 Jun 2025 13:37:58 +0200
In-Reply-To: <727212f9d3c324787ddd9ede9e2d800a02b629b2.camel@web.de>
References: <20250605091904.5853-1-spasswolf@web.de>
				 <20250605084816.3e5d1af1@gandalf.local.home>
				 <20250605125133.RSTingmi@linutronix.de>
		 <0b1f48ba715a16c4d4874ae65bc01914de4d5a90.camel@web.de>
	 <727212f9d3c324787ddd9ede9e2d800a02b629b2.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IBhpcVjJm16Ssg8olTCfUI0c1WnV05z4F4MMR08baRfeif4PvWF
 BM5Rktgk0S//PyFuRCwiYlB6q0zLCeSh5bJj0UGsRO48eYLNOC4BjegpPX5Vm4FfV4wwEUo
 OqzQ3gK6I8LWNC5YnL9YguxcYKavHpAMKOpSRfOzMm3SjLONE4e56pVr0lAFx0bGvNvSZ9h
 ibDYyJn9VhZXetcdStP/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J7ACHJa90Ik=;Jb6COGrGcUHFV3mfJPTqe2412Pr
 IqOOSZq0u+BHH7KzOiHWJhPIEo4uLalWmUEim6ZLu8mMGAs9iHZkhErRgv5eYMuuURCHoyzBb
 ejZtlGP8aVGq1LDAP6GhblDX/4X9Q7GYQAexwTrZqRI2tNpasEWH9Aqrgoww7r9RNN48TU5Ty
 jdW/nkn7j+YG9fz+/EtC8G3E3hHWvGhqQkiZQbiCtJwNzfnkEPccBYE3sK6ByjUBPBv/HoWOQ
 5lEbeSVDXqdKqbkeeiz2FCuef1ukIYx9BTe5OnPDkdiIa0CWIbi+OvPUe+lb5Ha44kA2tbon2
 yfva78US+ztLw4vuTmyH4vHkLgHAqDtzTPigthF+BAA/kFhBgQOTsMuBR5ywalS+8T2mhPvB/
 sZUVnuksCfm7T9ufn/znPJA7UQeI6aM24cm+8VD/MiOZja9Mz+U7dFItLknA85/oMTkVoRQ32
 C4W5ObZQ1iS2yiwZLbshq44Sidn9M7mhAGoJKyYaXvkpZHIM3j/W7yfCBDUSu10AO2v/fg47X
 diXKe3YNt5Bel2Fc5MHoi7SpkgpkIzmzMjVdexCSu5pqNGajDmqDEHUqXaqCqXBp81QEQItxL
 xsW0FkFb5J8O7ltsPWIk2GUdVbv/e9/xgp6S7mtj4+xXmkoWybNJCOWb6DZ2ZLI6H+5t/MEpD
 mV/MgasHVBt50wafVftMS43etExmQ7LyI3ENMkEVM9P1jGwRcfTyLulnjPoGqjZrw6EsGYYJN
 6FyJ0tnjWS4JLelDBc9oLmtbCB9JzZd99bY9Tp/PQRglTYwpFajsas8ENUo3acEc0QrZWQP+7
 y0sbqqidRfKF5EHjauIMUw9fcp6dVrTMACRYeZACsH6ZWRTEJQtzCeN4LOB/ij3cBY+on8G0w
 BCTgG87LZr1Nh04VeRDtkY9YGJZLd4BZlmf1kzxRHQrjXMOCWCVaESLLRZh4RWxWuQDDCeI28
 R0k0Qkuot4qBWKNG/t5WBwQZ4fbQhlg1jgYGsR0ITv4vxJ8aep8FPOMXLgLZnrzuGXG7eFJp0
 HXYRikfYmFqbL8Y8/Snj5JeBD/OYMX77a27XlRRWcdz0tLJIBEHdhUZtKAPgnG78fRD1GhmZe
 s+FTQlZbaHtb3gGTDEfBSFJ2MSHTs0kIQYQGwE4Bfo2BswldFwDRObXlB/CPryB0tN7IClnfx
 SAaQxZmNyMkudao6VPQOhi4HYmOZwWElJNldIBEikAswZMXbmNjbaeRLjm0Vv4EqvJ+do9OfX
 YEhNA3CmZ4tcXdl/w9D7GjBUBv/d32bAWrO372NsudU2RgkZJLlbIaz0jz9isuTIGITQASXTC
 iBlyCpGDo/dKJ1ng/XlsUe8G0SBRda2CO0a04QDCgx1IZibcKBg+zt3ftHEPnjrRPWUuKptKR
 XoKXRHXbjjeNqoBR6+d/DCPVtiC2DKj3FX7IGPapPvbDul0msh1KInT4qJ6qU1FpY6LzfJjUo
 RGT174ecM5Iigd0yflA73mdBy0GUaspRa4NKN8fDYOuomjqz8zVW86mEcAZ5h5tMUT8YfVfdt
 NFoXgH2aG3wqvPQg5bimMTd/E35FYB+I0T13hiv1lgxK2lcSyceEMnhh0E3fQrrMjx0VqlR1C
 aA6ryE1MSmeR4unjwny6Fs+gZGV1IWmHnqjXLLqjVc76A2N/K2wwA2XPH8Lwl7WLgzdZG8UY1
 n1vCJP/uJuxfSTeN/5swqhBsG+HWRxDGXqD4D7XZBaWXxy1SSPTTxrwFCDgZ6bd/KRB5cXnxQ
 3b0IpEXEuA4TvyHcz1UJsolexj+Xv0QpGK794AEBmACR3fLldvUKLcEQs3617jRWJZm573ENu
 pIj6EkqbH6I6m7+/Oois07miS6TCjAygW0mzgW6koJPcOt7L3h4W+K/MJCU3ky+M9lDs6L50b
 QIVAiL+BrdefwMfHmSG1uUbegBEQAfRW2KmnyNDOHWlgubLVBQ9iD4H8Mep4dvkIQa0WvrUl0
 3Y5QadxtpAC2MAC6sVCOl3DpglwH6hwRbyVq5G8FOXwaPa7yYX15cGZCV1YgWm7COLMzuuNSy
 XDC7EeMWnxsiTBdbi0F1nazEWHo0qsfCn/1F8Aov9BosDfw7OrUt3YWGcn/XN89PGLLvkmslM
 bMMQRexoK4LV4tYG9WV7fzfrk4NySEDGXnA5lpjTd27+yw4oTokq135hKHhft0JrtHsvTj4YO
 C82wrfyBXvOV02VEPgzSFNdTkqvAQLOVWn1loPfbm2x6h3aCxe1Lx7rl9/7fy5WRrSjTQlzaT
 TxqlMAtqtgXIwfloeA07Vz1Lp6s5owio9UPw/gARv46iBHLv3115dc9GuMjbxvlTMQzLUYVbj
 jXSJ/UV0u/a2U1RqsxkWcASWCzJ0zWbVKmEAi+xU1sXwDhTtoug9tK7UixGOE6Z09bUYKs4An
 kddcLScgKZG38vlAg/2SV4MBUM+CdteoO6du7lCvJvd7Tbb6jvHIZEeQm+7WLG/TZJJ22hnX4
 5zATE1WS1eAGJezrFIctHhgGkxDtgXTh3BYi39DNn+QIosXcVzhNZYVLWH5zQBuqWVOT7Mvyd
 PTqwCBUfPUsNNpGD3XUxqpUsWnlHmFA5g5Cl5OvyrvajSRPIJLFGNsG/mjV+p51vzE1n46Hzp
 PdNOLBKDJM3iSeH3SGXFulZZ6yEwRCk4ftOt5TMcpPVvBHbQAX6L/RJdRBelu/E7TpM5BbqfN
 2AIhaGI49gBg1Kl10XNS5aR3Wj18yywZ+2KQxyqtNNz7eDI90bU2jVoxg2uHirGmHt5s3nt0X
 vt+EULQxK8nfCgeL+7mmqRDZRIyepp6fu1mC9JlRoS59VPeQ2nszwFspLHelBzqYu47tZxXxK
 wHsDQ+gBkGE+ccFoXmjwEk+SELUGx1N9TX09RjtvQwdbHuMgqoyS4ij3PX1B2Okn4tO8bR6IJ
 KIpEkEFBjmJeRLMy/7AXqTkD+3np0k27LSJnDbEIgkAQ5dXR/U8cAf7H11qZzE7yCDmZktTH5
 f1R2scLkyAvQRJtdDMVXP4sUzWrztskPa17+s20PQKMLBoiHHi+5hGe8gDnDz52+L4Zb7msdb
 uiS36hZG1+5PwMd3S9f3Yduj11/PeBh8tW15S1F6zW9wuyzy8h2u0DguxgGeOxJWzD4E8Jn4f
 7GVe3bX52Ofc6p1s3vq5/xHI4v1tEsYl8p7T5u1ZmAwWhJfqCd4zZCgyOb7FLusPLFXybOLe7
 B4gxfeb7Fe/JDfHzfT9rq9GN57JpLNdIbvHuxFcs/HMh0YjPpQ6Dp4iQGXql0eJgJ7UCydU2r
 wntJndha6hTNNCRni7vNVSIVu7WuEgahQMnCKA==

Am Sonntag, dem 08.06.2025 um 17:53 +0200 schrieb Bert Karwatzki:
> Am Sonntag, dem 08.06.2025 um 10:45 +0200 schrieb Bert Karwatzki:
> > Am Donnerstag, dem 05.06.2025 um 14:51 +0200 schrieb Sebastian Andrzej=
 Siewior:
> > > On 2025-06-05 08:48:38 [-0400], Steven Rostedt wrote:
> > > > On Thu,  5 Jun 2025 11:19:03 +0200
> > > > Bert Karwatzki <spasswolf@web.de> wrote:
> > > >=20
> > > > > This patch seems to create so much output that the orginal error=
 message and
> > > > > backtrace often get lost, so I needed several runs to get a mean=
ingful message
> > > > > when running
> > > >=20
> > > > Are you familiar with preempt count tracing?
> > >=20
> > > I have an initial set of patches to tackle this problem, I'm going t=
o
> > > send them after the merge window.
> > >=20
> > > Sebastian
> >=20
> > I've found the reason for the "mysterious" increase of preempt_count:
> >=20
> > [   70.821750] [   T2746] bpf_link_settle calling fd_install() preemt_=
count =3D 0
> > [   70.821751] [   T2746] preempt_count_add 5898: preempt_count =3D 0x=
0 counter =3D 0x1b232c
> > [   70.821752] [   T2746] preempt_count_add 5900: preempt_count =3D 0x=
1 counter =3D 0x1b232d
> > [   70.821754] [   T2746] preempt_count_sub 5966: preempt_count =3D 0x=
1 counter =3D 0x1b232e
> > [   70.821755] [   T2746] preempt_count_sub 5968: preempt_count =3D 0x=
0 counter =3D 0x1b232f
> > [   70.821761] [   T2746] __bpf_trace_sys_enter 18: preempt_count =3D =
0x0
> > [   70.821762] [   T2746] __bpf_trace_sys_enter 18: preempt_count =3D =
0x1
> > [   70.821764] [   T2746] __bpf_trace_run: preempt_count =3D 1
> > [   70.821765] [   T2746] bpf_prog_run: preempt_count =3D 1
> > [   70.821766] [   T2746] __bpf_prog_run: preempt_count =3D 1
> >=20
> > It's caused by this macro from include/trace/bpf_probe.h (with my pr_e=
rr()):
> >=20
> > #define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args) \
> > static notrace void \
> > __bpf_trace_##call(void *__data, proto) \
> > { \
> >  might_fault(); \
> >  if (!strcmp(get_current()->comm, "test_progs")) \
> >  pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_c=
ount());\
> >  preempt_disable_notrace(); \
> >  if (!strcmp(get_current()->comm, "test_progs")) \
> >  pr_err("%s %d: preempt_count =3D 0x%x", __func__, __LINE__, preempt_c=
ount());\
> >  CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args=
)); \
> >  preempt_enable_notrace(); \
> > }
> >=20
> > The preempt_{en,dis}able_notrace were introduced in
> > commit 4aadde89d81f ("tracing/bpf: disable preemption in syscall probe=
")
> > This commit is present in v6.14 and v6.15, but the bug already appears=
 in
> > v6.12 so in that case preemption is disable somewhere else.=20
> >=20
> > Bert Karwatzki
>=20
> After reading this=C2=A0
> https://lore.kernel.org/bpf/CAADnVQJf535hwud5XtQKStOge9=3DpYVYWSiq_8Q2YA=
vN5rba=3D=3DA@mail.gmail.com/
> I tried using migrate_{en,disable} like this (in v6.15)
>=20
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 183fa2aa2935..49257cb90209 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -58,9 +58,9 @@ static notrace void							\
>  __bpf_trace_##call(void *__data, proto)					\
>  {									\
>  	might_fault();							\
> -	preempt_disable_notrace();					\
> +	migrate_disable();					\
>  	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args)=
);	\
> -	preempt_enable_notrace();					\
> +	migrate_enable();					\
>  }
> =20
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 187dc37d61d4..ec0326405fc3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2350,7 +2350,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link,=
 u64 *args)
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
> =20
> -	cant_sleep();
> +	cant_migrate();
>  	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
>  		bpf_prog_inc_misses_counter(prog);
>  		goto out;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/=
testing/selftests/bpf/progs/dynptr_success.c
> index e1fba28e4a86..7cfb9473a526 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -7,6 +7,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
>  #include "errno.h"
> =20
>  char _license[] SEC("license") =3D "GPL";
>=20
>=20
> This fixes the warnings when running the bpf cgroup examples:
>=20
> ./test_progs -a "cgrp_local_storage/cgrp1*"
>=20
> but I still get a warning from another example (I don't know which, yet)=
:
>=20
> Bert Karwatzki

Another of the bpf selftests that gives a warning with PREEMPT_RT=3Dy (for=
 calling spinlock
with preemption disabled) is

$ ./test_progs -a wq

giving this warning:

[ T3576] BUG: sleeping function called from invalid context at kernel/lock=
ing/spinlock_rt.c:48
[ T3576] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3576, name=
: test_progs
[ T3576] preempt_count: 1, expected: 0
[ T3576] RCU nest depth: 3, expected: 3
[ T3576] 6 locks held by test_progs/3576:
[ T3576]  #0: ffffffffa1131300 (rcu_read_lock){....}-{1:3}, at: bpf_test_t=
imer_enter+0x1e/0xc0
[ T3576]  #1: ffffffffa109acc0 (local_bh){.+.+}-{1:3}, at: __local_bh_disa=
ble_ip+0x29/0x1c0
[ T3576]  #2: ffff997b0e7d78b8 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __lo=
cal_bh_disable_ip+0xc8/0x1c0
[ T3576]  #3: ffffffffa1131300 (rcu_read_lock){....}-{1:3}, at: rt_spin_lo=
ck+0xf0/0x190
[ T3576]  #4: ffffffffa1131300 (rcu_read_lock){....}-{1:3}, at: __local_bh=
_disable_ip+0x29/0x1c0
[ T3576]  #5: ffff997b0e7f4588 ((&c->lock)){+.+.}-{3:3}, at: ___slab_alloc=
+0x68/0xde0
[ T3576] irq event stamp: 247437
[ T3576] hardirqs last  enabled at (247435): [<ffffffffa05b5fa7>] _raw_spi=
n_unlock_irqrestore+0x57/0x80
[ T3576] hardirqs last disabled at (247437): [<ffffffff9fbbc57b>] __bpf_as=
ync_init+0xdb/0x310
[ T3576] softirqs last  enabled at (241464): [<ffffffff9f98a2e1>] __local_=
bh_enable_ip+0x111/0x180
[ T3576] softirqs last disabled at (247436): [<ffffffffa036688c>] bpf_test=
_run+0x10c/0x350
[ T3576] CPU: 7 UID: 0 PID: 3576 Comm: test_progs Tainted: G           O  =
      6.15.0-bpf-00003-g5197b534e6ad #4 PREEMPT_{RT,(full)}=20
[ T3576] Tainted: [O]=3DOOT_MODULE
[ T3576] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-158L, BIOS E158LAMS.10F 11/11/2024
[ T3576] Call Trace:
[ T3576]  <TASK>
[ T3576]  dump_stack_lvl+0x6d/0xb0
[ T3576]  __might_resched.cold+0xe1/0xf3
[ T3576]  rt_spin_lock+0x5f/0x190
[ T3576]  ? ___slab_alloc+0x68/0xde0
[ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3576]  ? __lock_acquire+0x45f/0x2a70
[ T3576]  ___slab_alloc+0x68/0xde0
[ T3576]  ? bpf_map_kmalloc_node+0x72/0x220
[ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3576]  ? lock_acquire+0xbe/0x2e0
[ T3576]  ? bpf_map_get_memcg.isra.0+0x182/0x310
[ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3576]  ? find_held_lock+0x2b/0x80
[ T3576]  ? bpf_map_get_memcg.isra.0+0x8d/0x310
[ T3576]  ? bpf_map_kmalloc_node+0x72/0x220
[ T3576]  __kmalloc_node_noprof+0xee/0x490
[ T3576]  bpf_map_kmalloc_node+0x72/0x220
[ T3576]  __bpf_async_init+0x107/0x310
[ T3576]  bpf_prog_aa38f9274c0318a2_test_call_array_sleepable+0xb3/0x10e
[ T3576]  bpf_test_run+0x1ef/0x350
[ T3576]  ? bpf_test_run+0x10c/0x350
[ T3576]  ? migrate_enable+0x115/0x160
[ T3576]  ? kmem_cache_alloc_noprof+0x210/0x2b0
[ T3576]  bpf_prog_test_run_skb+0x37b/0x7c0
[ T3576]  ? fput+0x3f/0x90
[ T3576]  __sys_bpf+0xd33/0x26d0
[ T3576]  ? srso_alias_return_thunk+0x5/0xfbef5
[ T3576]  __x64_sys_bpf+0x21/0x30
[ T3576]  do_syscall_64+0x72/0xfa0
[ T3576]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ T3576] RIP: 0033:0x7f1c8e2a6779
[ T3576] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d=
 01 f0 ff ff
73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[ T3576] RSP: 002b:00007fff8ef7b4d8 EFLAGS: 00000202 ORIG_RAX: 00000000000=
00141
[ T3576] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1c8e2a6779
[ T3576] RDX: 0000000000000050 RSI: 00007fff8ef7b510 RDI: 000000000000000a
[ T3576] RBP: 00007fff8ef7b4f0 R08: 00000000ffffffff R09: 00007fff8ef7b510
[ T3576] R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000000
[ T3576] R13: 00007fff8ef7c038 R14: 00007f1c8e8db000 R15: 000055d507eb3890
[ T3576]  </TASK>


Here the problem is in __bpf_spin_lock() which calls arch_spin_lock()
with preemption disabled:

static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
{
	arch_spinlock_t *l =3D (void *)lock;
	union {
		__u32 val;
		arch_spinlock_t lock;
	} u =3D { .lock =3D __ARCH_SPIN_LOCK_UNLOCKED };

	compiletime_assert(u.val =3D=3D 0, "__ARCH_SPIN_LOCK_UNLOCKED not 0");
	BUILD_BUG_ON(sizeof(*l) !=3D sizeof(__u32));
	BUILD_BUG_ON(sizeof(*lock) !=3D sizeof(__u32));
	if (!strcmp(get_current()->comm, "test_progs"))
		pr_err("%s: calling preempt_disable()\n", __func__);
	preempt_disable();
	arch_spin_lock(l);
}

The call to preempt_disable here was introduced in commit
5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable progs").


Bert Karwatzki
