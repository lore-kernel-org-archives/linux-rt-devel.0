Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA2451981
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136784; cv=none; b=eUtQjt3yUHCD+KP3L9Mr/x0AqK06NHxNiuT0HAUXyZ3Z5xgbpG6H0ny4wJaijFJZHQtjAaLXCa5bbO0VV7thdKTLrRnXV/40bRUdE+x2f21fzo3S1EYc99i0PUyEZhovtK+L/Asmy2VRpqMkKpDtlr9eBlCZREpUalmHdz9qqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136784; c=relaxed/simple;
	bh=QMVBFrJGi3n8ZkMR9+OqIpeDAGPHoHFHzCh0oKqDon8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQNFkcz+365qlDjm/htpSYb443x8Ly6ifcQlZfpUPJJsTQTPUltn7kpt0yZl2/2fhXpjL1/7n2Kv8BDdjHp0Hkpwlbp5QXjIAPKRLZOTV1Z2CIh/jOGeONp1Xo74jh6rIHkPKyP5r+Jz8QIt43ybVFCrSSPQU5cqB0vQ3eaytAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahQZvX2/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hr8kh6zh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahQZvX2/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hr8kh6zh"
Date: Wed, 19 Aug 2026 12:52:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787136780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMVBFrJGi3n8ZkMR9+OqIpeDAGPHoHFHzCh0oKqDon8=;
	b=ahQZvX2/NACpUvvduJy2WpPuN7b7zlqtBAPFY7rlyNBZ0h9pOffcUcsBMkFTI2W8nGs7aB
	uhNbuhIg3rxJR9655XotgBkpJ/SsSLs4s1aYFvAzVYbSJM5Ln/RtR5On0RS7LRQBGENvkd
	jMgIC6yTez61Xrvb0Xp1gbBq/YhGZA65wQr5OidzN3GTl+9g0wsyiuu2poKp7C57ZIElCg
	Apgz9UKPOIhYYjEhLFbYU3IbXb/DHHxvLFp/bbWNZWsxSF1ru5QvpEsRUW3AE9Aq6ju6oZ
	mQONwusNHNjiwmb6JuDusxMUSnXAytuAtlooe2I1zHGngZPWfAoANFhssZFmSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787136780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMVBFrJGi3n8ZkMR9+OqIpeDAGPHoHFHzCh0oKqDon8=;
	b=Hr8kh6zh+ZMQq1FGkGAo8n9M0FKXdwpZejgwkD1Ea2/ZHuQu09n9d02pSIYMXbt2y/GHSN
	JMCCfibxVRlmhLBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260819105259.7ENaDrl2@linutronix.de>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
 <16fda1b1-2c72-4d05-b1c8-f424ac2848c6@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <16fda1b1-2c72-4d05-b1c8-f424ac2848c6@siemens.com>

On 2026-08-19 12:44:57 [+0200], Jan Kiszka wrote:
> With this patch, arm 32-bit, and a single-core SoC, I got a noticeable
> slowdown of irq_work_sync. Reverting the patch resolves this. So I dug
> deeper, found out that things were even worse before [1], but even with
> that, I could still see up to 2 ticks delay per call. If you combine
> that with an unfortunate loop of irq_work_sync calls (mine is
> out-of-tree, but I see something even "worse" in bpf_mem_alloc_destroy),
> there is this impact.
>=20
> While this patch is motivated by PREEMPT_RT, the condition to enter the
> modified branch are not limited to it:

It is not motivated by PREEMPT_RT. All the lazy-work has "this" problem.
It is just on RT most of the work is stuffed into the lazy queue.

> ... || !arch_irq_work_has_interrupt()
>=20
> arch_irq_work_has_interrupt() is false on some archs, either always
> (very rare) or under certain conditions. On arm, it's false when
> is_smp() is false.
>=20
> If we "only" need the synchronize_rcu() for PREEMPT_RT, should we limit
> it to that configuration? Or do we actually need otherwise as well?
>=20
> And what could be done to accelerate irq_work_sync loops? Practically, a
> single synchronize_rcu() at the end could be enough, no?

Let me look into this again=E2=80=A6

>=20
> Jan

Sebastian
