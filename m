Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AD1F892A;
	Thu, 14 Nov 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590865; cv=none; b=Z0E5ycbyGTcI4TbvvJi84O2NPSb8GN1gp4BAfejDDqiaOXSzEei9la3zVWiN2+gbJoVLzLJO1BpwF2bal59Xt2FE3zVOjKQ15LoDb+7tiTrHgVFnauK27ViafWUzVukHnoDTQdbq5ybgc4Z9Xs9kyoHF+ZikEQzOxpjkhhvUzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590865; c=relaxed/simple;
	bh=n7lN0pS4JeN5d5Vaqc+BLriS9COn68OXZc9ZlhR9iTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xps4yBBaQODlFMuT6pKQpOgqh8LaoVpjqsMLyWAtZzEsdSGzwQIH5Cg4xxJhL04CuCg21p/M7y7gcy1b+tAPBNmQTmQjUqTmAkrXk2o9M6RaWG3TCqeahxqEFaSp75XIagyDqd39/4rodTtBXwk90QgNJKbFIKwduBQ0/iP8Sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KjspVQsU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qAmReEM+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KjspVQsU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAmReEM+"
Date: Thu, 14 Nov 2024 14:27:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731590861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7lN0pS4JeN5d5Vaqc+BLriS9COn68OXZc9ZlhR9iTs=;
	b=KjspVQsUP9RL/qKitAbPPbffNuORdIj4ESNOj78pOQdd/OCLYBNo/NsVkWYGu2ZK5S/qJp
	wYWZdw9lVGiM1VTlR8xNhIL0YoN5FMnHGCbcDxhAKaWQyMT9ITAd0C9dQtb+IlymwE8rId
	qb1vLUNbgqjdcgzp0g0oAJMqTmuPuKhE4SkdYFq0HwRkz596EWuVh5ffYzvtUQY187lIw7
	34NS48jG19Axr8c3O2hfj/d6Noe6z0MC6m2RQFr8QYnb6Q6QPfR4G2OkI7eBzSTnT1sNq5
	+8SIQCpZw5AlaIiPqqBErtq1XjMKT4ucpMecLIa22+eLGROvc0zq5LLFx9TKaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731590861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7lN0pS4JeN5d5Vaqc+BLriS9COn68OXZc9ZlhR9iTs=;
	b=qAmReEM+lYjvoK5JNzrlEE0+T1u3NVa2LOV3WlZ+xe9ro/CF/ZJ2e1GKDt6E3qpGlU2MVs
	Vf12GutSzl/VF4CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] LoongArch: Reduce min_delta for the arch clockevent
 device
Message-ID: <20241114132740.NuomQBEN@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-2-chenhuacai@loongson.cn>
 <20241114102136.X-knc36J@linutronix.de>
 <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com>

On 2024-11-14 19:46:39 [+0800], Huacai Chen wrote:
> Hi, Sebastian,
Hi,

> On Thu, Nov 14, 2024 at 6:21=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-11-08 17:15:43 [+0800], Huacai Chen wrote:
> > > Now the min_delta is 0x600 (1536) for LoongArch's constant clockevent
> > > device. For a 100MHz hardware timer this means ~15us. This is a little
> > > big, especially for PREEMPT_RT enabled kernels. So reduce it to 1000
> > > (we don't want too small values to affect performance).
> >
> > So this reduces it to 10us. Is anything lower than that bad performance
> > wise?
> Maybe I misunderstood the meaning of min_delta, but if I'm correct,
> small min_delta may cause more timers to be triggered, because timers
> are aligned by the granularity (min_delta). So I think min_delta
> affects performance.

They are not aligned. Well they get aligned due to the consequences.

In one-shot mode you program the device for the next timer to expire. It
computes the delta between expire-time and now. This delta is then
clamped between min & max delta. See clockevents_program_event().

This means if your timer is supposed to expire in 5us (from now) but
your min delta is set to 15us then the timer device will be programmed
to 15us from now. This is 10us after the expire time of your first
timer. Once the timer devices fires, it will expire all hrtimers which
expired at this point. This includes that timer, that should have fired
10us ago, plus everything else following in the 10us window.

> Huacai

Sebastian
