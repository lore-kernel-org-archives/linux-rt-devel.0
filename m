Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F128C874
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Mar 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512704; cv=none; b=LBzJqNNXMZ3BlSyDL4T/uyzrmcmiWNZr9YIqZfXBwrXF0yG6uVUcOzMUS9yzcqbAQldqsXSJYZ2wBATGHqkUUH1uus6Kr4v+8yHN1q25bWdtA9+6vqkKlGooZvbJFDZ9qSiIBWf94xmJ0FZEsZiJ7Z9PJrIRh4Il2YQ0BKftQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512704; c=relaxed/simple;
	bh=m3B4bDXmrf68EFdv1Pap6pDGLuKNs+0tU6ZaCD83/Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIPKPKLsbF+c1zXF/1WAI70RRKANng5oifXLeOf4PKQmRksXiN021zvg4BkJV1Tc3IOfeovvqgCs0tXtdpK14u+LeJhoGuVIJiOP9kEhhcTp+MufccxW6lI+L210UTNqx7ae2wygXLSLCUQP34Z0O2Q1qxxPx5pv9i0YGPBVGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBfjaDmI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hgZ+opNq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBfjaDmI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgZ+opNq"
Date: Thu, 26 Mar 2026 09:11:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774512702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GX1xs2o3huzMzG3Fi3z/VL3SfbbVmEHskTvZ8RdiKoE=;
	b=KBfjaDmIGywuDHnnsXFmM0Ylyb9RLUzLrXjznvvABeDBZ+ttYXYU5sFZG+5RYk2/KoMYsI
	P3mMnjca2B6ZhWMeqj1DTfgN7L+GxL5OxaDEDpbJfJS6vPMC5rqlFgZ85XTUG5w64HjThO
	1vu9PdoPC+Y4Y9X+R3ri1x2wwVW8yTP0AHsrzNZVxWRQEYdAeKSKK4LRJKhSeyrFyRY+8x
	cttDpMKwHdaH6tzQS9GqKK1iZQluUpp9XRmgWajlS54VTUAJVlI6sxcawVXYI4XLBm71if
	TdfhRd52M0rXgqtdHeTsY2jqVFRdDIbsc5rYcNZjuMhQRz6oEnpijhmEHzPfAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774512702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GX1xs2o3huzMzG3Fi3z/VL3SfbbVmEHskTvZ8RdiKoE=;
	b=hgZ+opNq5ksNale7WyLiD8jmMyQX6SZM69HNWgLaFqL6kE9hfuCRN54nxYSVxDdOpDLc2b
	s1+3FNDXSn72ARCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v1] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260326081140.qzEgA7jy@linutronix.de>
References: <20260325153826.EbSqlX_n@linutronix.de>
 <20260325115315.052e34ac@gandalf.local.home>
 <20260325155504.tm4zHWMI@linutronix.de>
 <5b6f6480-aa2d-4966-b3c7-6c719e915285@linux.dev>
 <20260325170539.MHkr49jU@linutronix.de>
 <20260325134433.7d46507d@gandalf.local.home>
 <20260325175150._IrYQldq@linutronix.de>
 <20260325135540.4d127635@gandalf.local.home>
 <20260325175915.YufD1Y8T@linutronix.de>
 <b4a90c71-f559-4a47-beea-1f915fe97321@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b4a90c71-f559-4a47-beea-1f915fe97321@linux.dev>

On 2026-03-26 10:27:10 [+0800], Jiayuan Chen wrote:
> Combining your and Steven's suggestions, I think the simplest fix would b=
e:
>=20
> static void run_irq_workd(unsigned int cpu)
> {
> +=C2=A0 =C2=A0guard(rcu)();
> =C2=A0 =C2=A0 irq_work_run_list(this_cpu_ptr(&lazy_list));
> }
>=20
> void irq_work_sync(struct irq_work *work)
> {
> =C2=A0 =C2=A0 lockdep_assert_irqs_enabled();
> =C2=A0 =C2=A0 might_sleep();
>=20
> =C2=A0 =C2=A0 if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(wor=
k)) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 !arch_irq_work_has_interrupt()) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rcuwait_wait_event(&work->irqwa=
it, !irq_work_is_busy(work),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TASK_UNINTERRUPTIBLE);
> =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Ensure run_irq=
_workd() / irq_work_single() is done
> =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * accessing @wor=
k before the caller can free it.

  Ensure irq_work_single() does not access @work after removing
  IRQ_WORK_BUSY. It is always accessed within a RCU-read section.

But, yes, this looks like a simple fix.

> =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_rcu();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> =C2=A0 =C2=A0 }

Sebastian
