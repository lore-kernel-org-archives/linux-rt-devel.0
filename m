Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B97250BEC
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285574; cv=none; b=JpPgoRnT0liKQs6BMXPRUiucSET6QZ6AIiGIpfSNyJ/uAf9gpVZNvwXTQiTnsrEIiy08Hai6/+QHKNgrE7JPRbhZL5L18skSE7VWhHNlJ43aAteJfM8LgDWbwHEt9hGBxp+csmUp1zwodjym1yK3QVmfUKdl6RByDFqFEmugszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285574; c=relaxed/simple;
	bh=lTuqE1uLqDU4/vLbG2lGa6heQommDeS+cVngcjjbUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMLemTh7fbxqEqrRpYjjAiMKaSdB5MtXGffTXIZSGQO1duBpYrEiPNOaUudQG5UYoxADP+kDI3IC6i7kwUGiMG9C/xZdZkRJzRJucSyU0otWo8HK3QLYu0Lv8bCErrigU1KPADAPYmLYXvv6xV6Ef5qzBBWK5h1o+PPwnC/bCnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySxqJFJg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3e8B9RZG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySxqJFJg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3e8B9RZG"
Date: Tue, 11 Feb 2025 15:52:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739285571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/WSAFYTr1r5PgwAwK6qtJ6MnRejIEWvXAXuKCccZfg=;
	b=ySxqJFJgJsU3HuzLJUpcSeX/TNEej8+Ah9YRinYms+E4qZOXJEFt63CTy0NGDiQ+8/AORm
	32u8uoPjUhvWpIHJk3wHRB3xHdKYfYYJVN/agBZ8bx8ZAQrFHEfwK1HOojCDBhlcAwNaks
	5qvg0G2EQc6pPWJMCDIZr0dloYvUUqHsZPuB4ZYCvo5b32JgOqaPK1dpfnsqYiVN5Gw9zh
	IPg7omZ3BNsBBVr8oO8D7Zr1X4MfErhoky7CG9bw2yCYi5xuVSyFSDc9yulciAQjNqCsui
	Lw4sEWm8wxu0S6nJaphSjZnd/H1G+coJG5KI5HjuQOQQ4egE3UOw2mw7gh3zVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739285571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/WSAFYTr1r5PgwAwK6qtJ6MnRejIEWvXAXuKCccZfg=;
	b=3e8B9RZG9nbA5FRiLra16h2Z9aRiJX11vmzIi5P1yxgM5kpJlNjKKmMzoHfUi47gXcGfA/
	8vQ34MNRGrSomYBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/9] arm: Rely on generic printing of preemption model.
Message-ID: <20250211145249.StI6tEZv@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-4-bigeasy@linutronix.de>
 <20250210120429.iFfBClW1@linutronix.de>
 <Z6oYO5uKlEJ8C8Ne@shell.armlinux.org.uk>
 <20250210153902.06VTSS6d@linutronix.de>
 <Z6oo0MExaEy5J55_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z6oo0MExaEy5J55_@shell.armlinux.org.uk>

On 2025-02-10 16:26:56 [+0000], Russell King (Oracle) wrote:
> > Patch 2/9 adds this. [ https://lore.kernel.org/all/20250203141632.44055=
4-3-bigeasy@linutronix.de/ ]
>=20
> That explains it - patch 2 is only sent to a very restricted subset
> and not even to mailing lists that would be relevant in the absence
> of a direct Cc. Ditto patch 1. All I received were patches 3 and 4.
>=20
> In patch 1:
>=20
> +	static char buf[128];
> ...
> +		seq_buf_init(&s, buf, 128);
>=20
> Why not sizeof(buf) ?

Indeed, why not. Updated.

> For patch 2:
>=20
> "Use
> pr_warn() instead of printk() to pass a loglevel. This makes it part of
> generic WARN/ BUG traces.
> "

> How about cases which use dump_stack_lvl() to dump the output at a more
> severe level than warning? Should the message be printed at a less
> severe level than the other messages?

This is bad indeed. I reverted that piece.

> > This this applied, die("test") on ARM ends as:
> >=20
> > [    1.595106] Kernel panic - not syncing: test
> > [    1.596044] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W=
 6.14.0-rc2-00009-gb80a798df08c-dirty #13 PREEMPT
> > [    1.596768] Tainted: [W]=3DWARN
> > [    1.596946] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 0=
2/02/2022
>=20
> Hmm. I've no idea what you're testing, what you've quoted makes zero
> sense to me.
>=20
> First...
>=20
> void die(const char *str, struct pt_regs *regs, int err)
>=20
> is the die function prototype, so it takes a bit more than what you've
> indicated.
>=20
> Second, "Kernel panic" suggests that panic() has been called. However,
> this only happens when die() is called (or more specifically
> oops_end()) from either interrupt context (in which case we get
> "Kernel panic - Fatal exception in interrupt") or if panic_on_oops
> is set ("Kernel panic - Fatal exception").
>=20
> I don't see a path which would result in
> "Kernel panic - not syncing: test" to be printed from this path.
>=20
> Since __die() does not call dump_stack(), we're not going to call
> dump_stack_print_info() from __die(), so I don't think it's appropriate
> to remove this information.

Okay. Let me try again with a stack overflow during boot. With the
series:

| Freeing unused kernel image (initmem) memory: 2048K
| 8<--- cut here ---
| Unable to handle kernel paging request at virtual address df82a000 when w=
rite
| [df82a000] *pgd=3D80000040007003, *pmd=3D41487003, *pte=3D00000000
| Internal error: Oops: a07 [#1] SMP ARM
| Modules linked in:
| CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.14.0-=
rc2-00009-gdca8d546a8a3-dirty #16 PREEMPT
| Tainted: [W]=3DWARN
| Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
| PC is at mmioset+0x38/0xac
| LR is at 0x34343434
| pc : [<c0a07a58>]    lr : [<34343434>]    psr: 20000013
| sp : df829c88  ip : df829ff4  fp : 00000000
| r10: 00000000  r9 : 00000000  r8 : 34343434
| r7 : 00000000  r6 : 00000000  r5 : c0a33278  r4 : c1207bd4
| r3 : 34343434  r2 : 00000080  r1 : 34343434  r0 : df829ea4
| Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
| Control: 30c5387d  Table: 40003000  DAC: 00000001
| Register r0 information: 2-page vmalloc region starting at 0xdf828000 all=
ocated at kernel_clone+0x58/0x3b8
=E2=80=A6
| Process swapper/0 (pid: 1, stack limit =3D 0x4c737b1e)
| Stack: (0xdf829c88 to 0xdf82a000)
=E2=80=A6
| Call trace:
|  mmioset from func+0x24/0x50
|  func from kernel_init+0x7c/0x168
|  kernel_init from 0x34343434
| Code: e1a08001 e1a0e003 e2522040 a8ac410a (a8ac410a)
| ---[ end trace 0000000000000000 ]---
| Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
| ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x0000000b ]---

Without:

| Freeing unused kernel image (initmem) memory: 2048K
| 8<--- cut here ---
| Unable to handle kernel paging request at virtual address df82a000 when w=
rite
| [df82a000] *pgd=3D80000040007003, *pmd=3D41487003, *pte=3D00000000
| Internal error: Oops: a07 [#1] PREEMPT SMP ARM
| Modules linked in:
| CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.14.0-=
rc2-00010-ged8f7288c355-dirty #17
| Tainted: [W]=3DWARN
| Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
| PC is at mmioset+0x38/0xac
| LR is at 0x34343434
| pc : [<c0a079d8>]    lr : [<34343434>]    psr: 20000113
| sp : df829c88  ip : df829ff4  fp : 00000000
| r10: 00000000  r9 : 00000000  r8 : 34343434
| r7 : 00000000  r6 : 00000000  r5 : c0a331ec  r4 : c1207bd4
| r3 : 34343434  r2 : 00000080  r1 : 34343434  r0 : df829ea4
| Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
| Control: 30c5387d  Table: 40003000  DAC: 00000001
| Register r0 information: 2-page vmalloc region starting at 0xdf828000 all=
ocated at kernel_clone+0x58/0x3b8
=E2=80=A6
| Process swapper/0 (pid: 1, stack limit =3D 0x7d941701)
| Stack: (0xdf829c88 to 0xdf82a000)
=E2=80=A6
| Call trace:
|  mmioset from func+0x24/0x50
|  func from kernel_init+0x7c/0x168
|  kernel_init from 0x34343434
| Code: e1a08001 e1a0e003 e2522040 a8ac410a (a8ac410a)
| ---[ end trace 0000000000000000 ]---
| Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
| ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x0000000b ]---

As you see, the PREEMPT string moved and is still existing.

Sebastian
