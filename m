Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE229B79B
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542658; cv=none; b=Pi/vjDRJussrEq/g/c9hWuCtlotny+o38gSk9MOGJr+sr9ShuOw++fp9Sv5yTS5iW4GL1M6N+UY6eHQxY4XMYeb4I2p8to15RmB7aunloeft9lP/mEAAqj0pb3E86mzYyyuUw601UQJBw9SS9yvnS+tJJOpL/wU0YVr//t1cHQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542658; c=relaxed/simple;
	bh=UFEPff+52irqq2tLpNPdwXwsoadBqpS5yktgafLQoBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeqBQWCmwBMvNLm5wv/qcbfAxicLhsKvMUzKTg1bD7L4+HgNgpwvC7MdI6bNmSGVIq4RDQUpu5wQY3rdhr1pqK23EcXwXnN8+9O8qSC0kSiQJpjLIiPXNcI1rE85I98958BUc3o/G5G9XbGco8RKoDwBmjEboPmfcvJu6wUaDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=MoI4uEc7; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="MoI4uEc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771542643; x=1772147443; i=spasswolf@web.de;
	bh=uZ3mSUtz7VTG8XfD0xZbvIqj5LddoEchaO3hsNZzuMM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MoI4uEc7RlMC2lT0oI/IJB+scccFdZWlTyCJOY4DdFX+l4EImfrq8Bdt7lM94qJY
	 J2uKOLnSWBeW8oHj9AfxCLIHjDoPdwq8XPUlKSQWLCUlfrN4SlBsg5ZXA78nDSEfM
	 BHWWkohAG1va1O4VsATx7yQbobnUAD027lm+sMOW5n+G9MwhPk0u0BhxYDSRfMbew
	 jRntEDAmlieG91wSK2+POqM75tyMe+pJvArqo0grlk5UhNw4sk1erbPYKEEZnEM8F
	 1ZQ3Og8j49Q7YT3piPNHx8sR6Pt8WR4bquV2ZozF5cCY8QLyZcYn9faehs5ntRehy
	 Z5Xqwk8eSkpkBpbEUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1vtl8O3zkE-00HGlG; Fri, 20
 Feb 2026 00:10:43 +0100
Message-ID: <594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Tejun Heo <tj@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>,
 dschatzberg@meta.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, spasswolf@web.de
Date: Fri, 20 Feb 2026 00:10:41 +0100
In-Reply-To: <aZd4YCNTAHZNpTfh@mozart.vkv.me>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	 <20260219164648.3014-1-spasswolf@web.de> <aZd4YCNTAHZNpTfh@mozart.vkv.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lFMdkRKAoyb95w2yzI8IxfLlBY0UI1CL1KvcQMkle549EDeeXBG
 Ebryf+bjOt4uM6yweQg9xgYu7rwHcYfIrUA6R9Ni4Xlv+4avtM+vWRw4x6t4LcxFc0gRoIJ
 dpwSTyDygVFc3wD85eOKnoaT/Q8GTOPnD999t9ZI15dDO8t2SnnmxTt/K+v/kF9FBuSqYAJ
 SZub0UVPAniuQIFP0iqmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kjod0GvCXa4=;4uv9K06YhB0SPJxzogRorqhbfux
 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
 TMvRALkw=

Am Donnerstag, dem 19.02.2026 um 12:53 -0800 schrieb Calvin Owens:
> On Thursday 02/19 at 17:46 +0100, Bert Karwatzki wrote:
> > Since linux v6.19 I noticed that rebooting my MSI Alpha 15 Laptop
> > would hang for about ~90s before rebooting. I bisected this (from
> > v6.18 to v6.19) and got this as the first bad commit:
> > 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PR=
EEMPT_RT")
> >=20
> > Reverting this commit fixes the reboot delay but introduces these erro=
r (which
> > also seem to make the system crash sometimes):
> > [    T0] BUG: scheduling while atomic: swapper/0/0/0x00000002
> >=20
> > Compiling the kernel without PREEMPT_RT also fixes the issue.
>=20
> Hi Bert,
>=20
> I'm not seeing this behavior, there must be more to it than just this.
>=20
> Could you share your kconfig? The dmesg with initcall_debug will be more
> verbose during shutdown too, that may also help.

I tested v6.19 with initcall_debug and I'm seeing these messages (on start=
up, there
no extra message during the 90s reboot delay). I put the .config as an att=
achement in
a gitlab issue (Or should I put it in the mail? It's ~6500 lines):

https://gitlab.freedesktop.org/-/project/26509/uploads/8d1c04bbe0ab121945b=
e7c898d08e1b6/config-6.19.0-stable

2026-02-19T23:37:50.140437+01:00 lisa kernel: [   T16] BUG: sleeping funct=
ion called from invalid context at kernel/printk/printk.c:3377
2026-02-19T23:37:50.140439+01:00 lisa kernel: [   T16] in_atomic(): 0, irq=
s_disabled(): 0, non_block: 0, pid: 16, name: pr/legacy
2026-02-19T23:37:50.140441+01:00 lisa kernel: [   T16] preempt_count: 0, e=
xpected: 0
2026-02-19T23:37:50.140443+01:00 lisa kernel: [   T16] RCU nest depth: 1, =
expected: 0
2026-02-19T23:37:50.140445+01:00 lisa kernel: [   T16] CPU: 1 UID: 0 PID: =
16 Comm: pr/legacy Tainted: G        W           6.19.0-stable #1159
PREEMPT_{RT,(full)}=20
2026-02-19T23:37:50.140446+01:00 lisa kernel: [   T16] Tainted: [W]=3DWARN
2026-02-19T23:37:50.140448+01:00 lisa kernel: [   T16] Hardware name: Micr=
o-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 1=
1/11/2024
2026-02-19T23:37:50.140456+01:00 lisa kernel: [   T16] Call Trace:
2026-02-19T23:37:50.140458+01:00 lisa kernel: [   T16]  <TASK>
2026-02-19T23:37:50.140460+01:00 lisa kernel: [   T16]  dump_stack_lvl+0x4=
b/0x70
2026-02-19T23:37:50.140461+01:00 lisa kernel: [   T16]  __might_resched.co=
ld+0xaf/0xbd
2026-02-19T23:37:50.140463+01:00 lisa kernel: [   T16]  console_conditiona=
l_schedule+0x26/0x30
2026-02-19T23:37:50.140464+01:00 lisa kernel: [   T16]  fbcon_redraw+0x9b/=
0x240
2026-02-19T23:37:50.140466+01:00 lisa kernel: [   T16]  ? get_color+0x21/0=
x130
2026-02-19T23:37:50.140468+01:00 lisa kernel: [   T16]  fbcon_scroll+0x165=
/0x1c0
2026-02-19T23:37:50.140470+01:00 lisa kernel: [   T16]  con_scroll+0xf6/0x=
200
2026-02-19T23:37:50.140472+01:00 lisa kernel: [   T16]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-19T23:37:50.140474+01:00 lisa kernel: [   T16]  lf+0x9f/0xb0
2026-02-19T23:37:50.140475+01:00 lisa kernel: [   T16]  vt_console_print+0=
x2ff/0x460
2026-02-19T23:37:50.140477+01:00 lisa kernel: [   T16]  console_flush_one_=
record+0x21c/0x3e0
2026-02-19T23:37:50.140479+01:00 lisa kernel: [   T16]  ? console_flush_on=
e_record+0x3e0/0x3e0
2026-02-19T23:37:50.140481+01:00 lisa kernel: [   T16]  legacy_kthread_fun=
c+0xc7/0x1a0
2026-02-19T23:37:50.140482+01:00 lisa kernel: [   T16]  ? housekeeping_aff=
ine+0x30/0x30
2026-02-19T23:37:50.140484+01:00 lisa kernel: [   T16]  kthread+0xf7/0x1e0
2026-02-19T23:37:50.140486+01:00 lisa kernel: [   T16]  ? kthreads_online_=
cpu+0x100/0x100
2026-02-19T23:37:50.140487+01:00 lisa kernel: [   T16]  ? kthreads_online_=
cpu+0x100/0x100
2026-02-19T23:37:50.140489+01:00 lisa kernel: [   T16]  ret_from_fork+0x20=
e/0x240
2026-02-19T23:37:50.140491+01:00 lisa kernel: [   T16]  ? kthreads_online_=
cpu+0x100/0x100
2026-02-19T23:37:50.140492+01:00 lisa kernel: [   T16]  ret_from_fork_asm+=
0x11/0x20
2026-02-19T23:37:50.140494+01:00 lisa kernel: [   T16]  </TASK>

and

2026-02-19T23:37:50.338878+01:00 lisa kernel: [   T16] BUG: sleeping funct=
ion called from invalid context at kernel/printk/printk.c:3377
2026-02-19T23:37:50.338880+01:00 lisa kernel: [   T16] in_atomic(): 0, irq=
s_disabled(): 0, non_block: 0, pid: 16, name: pr/legacy
2026-02-19T23:37:50.338882+01:00 lisa kernel: [   T16] preempt_count: 0, e=
xpected: 0
2026-02-19T23:37:50.338884+01:00 lisa kernel: [   T16] RCU nest depth: 1, =
expected: 0
2026-02-19T23:37:50.338893+01:00 lisa kernel: [   T16] CPU: 7 UID: 0 PID: =
16 Comm: pr/legacy Tainted: G        W           6.19.0-stable #1159
PREEMPT_{RT,(full)}=20
2026-02-19T23:37:50.338895+01:00 lisa kernel: [   T16] Tainted: [W]=3DWARN
2026-02-19T23:37:50.338896+01:00 lisa kernel: [   T16] Hardware name: Micr=
o-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 1=
1/11/2024
2026-02-19T23:37:50.338897+01:00 lisa kernel: [   T16] Call Trace:
2026-02-19T23:37:50.338899+01:00 lisa kernel: [   T16]  <TASK>
2026-02-19T23:37:50.338901+01:00 lisa kernel: [   T16]  dump_stack_lvl+0x4=
b/0x70
2026-02-19T23:37:50.338906+01:00 lisa kernel: [   T16]  __might_resched.co=
ld+0xaf/0xbd
2026-02-19T23:37:50.338908+01:00 lisa kernel: [   T16]  console_conditiona=
l_schedule+0x26/0x30
2026-02-19T23:37:50.338910+01:00 lisa kernel: [   T16]  fbcon_redraw+0x9b/=
0x240
2026-02-19T23:37:50.338916+01:00 lisa kernel: [   T16]  ? get_color+0x21/0=
x130
2026-02-19T23:37:50.338917+01:00 lisa kernel: [   T16]  fbcon_scroll+0x165=
/0x1c0
2026-02-19T23:37:50.338919+01:00 lisa kernel: [   T16]  con_scroll+0xf6/0x=
200
2026-02-19T23:37:50.338924+01:00 lisa kernel: [   T16]  ? srso_alias_retur=
n_thunk+0x5/0xfbef5
2026-02-19T23:37:50.338935+01:00 lisa kernel: [   T16]  lf+0x9f/0xb0
2026-02-19T23:37:50.338937+01:00 lisa kernel: [   T16]  vt_console_print+0=
x2ff/0x460
2026-02-19T23:37:50.338957+01:00 lisa kernel: [   T16]  console_flush_one_=
record+0x21c/0x3e0
2026-02-19T23:37:50.338960+01:00 lisa kernel: [   T16]  ? console_flush_on=
e_record+0x3e0/0x3e0
2026-02-19T23:37:50.338962+01:00 lisa kernel: [   T16]  legacy_kthread_fun=
c+0xc7/0x1a0
2026-02-19T23:37:50.338964+01:00 lisa kernel: [   T16]  ? housekeeping_aff=
ine+0x30/0x30
2026-02-19T23:37:50.338965+01:00 lisa kernel: [   T16]  kthread+0xf7/0x1e0
2026-02-19T23:37:50.338966+01:00 lisa kernel: [   T16]  ? kthreads_online_=
cpu+0x100/0x100
2026-02-19T23:37:50.338968+01:00 lisa kernel: [   T16]  ? kthreads_online_=
cpu+0x100/0x100
2026-02-19T23:37:50.338972+01:00 lisa kernel: [   T16]  ret_from_fork+0x20=
e/0x240
2026-02-19T23:37:50.338976+01:00 lisa kernel: [   T16]  ? kthreads_online_=
cpu+0x100/0x100
2026-02-19T23:37:50.338978+01:00 lisa kernel: [   T16]  ret_from_fork_asm+=
0x11/0x20
2026-02-19T23:37:50.338980+01:00 lisa kernel: [   T16]  </TASK>

These seem to be the same type of messages that commit
9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PREEMP=
T_RT")
is supposed to fix.
When I compile a kernel with 9311e6c29b34 as HEAD I do not get these messa=
ges, so
I guess I have to do another bisection here.

Bert Karwatzki
