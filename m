Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B043A1CED
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Jan 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406516; cv=none; b=SKROJtrRzCgA2C84U6Tgs0XoReDNbh7ETk/oMufQJ6C5dG+KFyQpi+pLZkmFeatzVHxCb3vHoHgsvi/E1+yh3DPrRlTaKrZDYA7KZsNnQV7QeIYHk09+wDa6NAruNSIVGXZm6hkYQoNfv9SSTA9Htqz0oEBifMfnJrHd5usAQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406516; c=relaxed/simple;
	bh=hZ0OFnIX7hUMbsNflNAslWyTKRUhy/o2U+HmtUmHfGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCjNIL29HIi96Zpb5/lMiYcZhYBjdBXpND1u6VPWescg4kMUvDuasRpZ+UTEJ/I1UaChyf+oV9YR8qAsV6EnIJs4sJj6YmfN+9CTkuP4f8Jd2JovOHfAC8BE906on//1GV22MQJhwxuHXB0uflBqrc1qWD4AEQ6UjmpMA13vpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rfd7vHBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DxY1P3G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rfd7vHBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DxY1P3G"
Date: Wed, 14 Jan 2026 17:01:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768406513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ0OFnIX7hUMbsNflNAslWyTKRUhy/o2U+HmtUmHfGI=;
	b=rfd7vHBz1WLpBHPczQ9hBag1uDo0KrUEd8bXS0fbsoVEZPkBXa29t6yJQcrbonhGArJmYS
	DjKDiUNu936WcaJhnoLGjVVHSIQWrcuecyATrfQ5RgEVjT8W7kf7hGFlhI0XgdN5v9eaHQ
	OESy5zqu76PVbymLrsjJJMCVM+PjjbmLNI6mGL22NjNHVdYu0EA2O+xlLplv+MlsZWjQSq
	qNo4feUlMl1XxxXsOsucxoYEeHlNwhsZuQNevxPeuB0gnzH7KZKUPYTq/P5PE149JPciIj
	+hrkg6762jROj9jkM/49OZQZOr61ANEPIrDI7CICW9L8yvuABiq/ekJ5Ba3qfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768406513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ0OFnIX7hUMbsNflNAslWyTKRUhy/o2U+HmtUmHfGI=;
	b=3DxY1P3GNYDLGzssQhKPKAP4fVb2O4OwkDPQU++qPNhVw73yzXipwIyScTrN8CYLMVDwjv
	SEaCksFXfofKgJBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Waiman Long <llong@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
Message-ID: <20260114160151.a6y9OxQW@linutronix.de>
References: <864iowmrx6.wl-maz@kernel.org>
 <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org>
 <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com>
 <87cy3eg94y.ffs@tglx>
 <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com>
 <20260113115515.98Mc29Nm@linutronix.de>
 <CAADnVQ+eQU+isNBXOJwQ=RYZUyO00e48ESHUhh8Kp7pgRgQu0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAADnVQ+eQU+isNBXOJwQ=RYZUyO00e48ESHUhh8Kp7pgRgQu0Q@mail.gmail.com>

On 2026-01-13 15:25:26 [-0800], Alexei Starovoitov wrote:
> On Tue, Jan 13, 2026 at 3:55=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > The last one does local_lock_irqsave() on PREEMPT_RT which does a
> > spin_lock(). That means atomic context is not possible. Where did I make
> > a wrong turn? Or did this change recently? I do remember that Alexei
> > reworked parts of the allocator to make the local_lock based trylock
> > allocation work.
>=20
> Are you forgetting about local_lock_is_locked() in __slab_alloc() ?

Yeah but this just checks it. Further down the road there is
local_lock_cpu_slab() for the allocation and there is no try-lock on RT.

> With sheaves the whole thing will be very different.
Yes.

Sebastian
