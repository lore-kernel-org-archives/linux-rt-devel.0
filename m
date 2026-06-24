Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B430DED0
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281938; cv=none; b=b919lnaHnb2dGJLJXY8WvgJy2Wrfjy5GKNSr73fZ7AvqjiFJKkhYQ9kkrexPXeAqD9AZ9njMFiFbB7ybo19VXV4NWnuyuJbPYSe6H8Ltbmw6PySYQGQgr0ANIdhitwSIa6lVecFMG/DuedTaT9/qoqgyDbY44H1j5O755r08HWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281938; c=relaxed/simple;
	bh=eC4lfErW+pR+pmA2pRiyG8E+5zceic1+1XV2r3gfocI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GheRi1wiuekpTIwLy0Z+ifMqy89WWj5yEAjUPb0LtpTKNQNS6r9QomRCGqYbHnhjZu6liWs7zidinK1yRuc5mKn0N6rpEA5rRaZCCdPNrOt1XGgYK996lMvDbWmVNJy5tR5dJSZn2tKg5fXY+ITOj7XN3+6v81O1mxnoQwBA8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbqnWZGg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3o/2qr5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbqnWZGg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3o/2qr5"
Date: Wed, 24 Jun 2026 08:18:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782281930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uadqRAI2LngWZ5a6Pld4O97ztBIDaJnPvhfMToZjyag=;
	b=RbqnWZGgDz7b37XGb/YS6kRSATRZUMu7oEpxmNoY/LTxohVvqTa2jkGFZnmtyRi7da6L+D
	byIh800LSqoL8xEgGgi3Ds/ICvQL6zBXXcXlb9ZSJegftALReg4SoNajutV9Qs6aRGRcmz
	iIeKkGplXcAh4/usUSH+NNCvkWWWAZLLAisqRMevxdIqUepH8Nz3FfpdblNavtnU8Bme30
	WsQcQEr0DhAH13dY8eCYhnLlWBKkbDC0KGrD7PnqSnOroEkR3KnEIdOD8hiMWxcZTqtJNY
	LfTjuJDYD6zywanjTuiQpXVhRk9VEsp2ZzJ9iuePRMwP3fyZZLuJS9CM02gxYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782281930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uadqRAI2LngWZ5a6Pld4O97ztBIDaJnPvhfMToZjyag=;
	b=A3o/2qr517AlyeH6REsGBIwqETSY6/6SB36VagU0oYlAPV8fcYkDm+4iL7qCCJqZhNDqlM
	J8j7QUV5fq5RjYBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] MIPS: loongson64: add IRQ work based on self-IPI
Message-ID: <20260624061848.DKue8khU@linutronix.de>
References: <20260623172728.191557-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260623172728.191557-1-xry111@xry111.site>

On 2026-06-24 01:27:21 [+0800], Xi Ruoyao wrote:
> Since the commit 91840be8f710 ("irq_work: Fix use-after-free in
> irq_work_single() on PREEMPT_RT"), we observed the performance of
> execve() is significantly impacted on MIPS.
>=20
> While we are unsure how that commit caused the impact or how to improve
> it (or even if it can be improved at all), implementing IRQ work with
> self-IPI seems able to mitigate the impaction.

I suspect mm_struct::mm_cid.irq_work.
That IPI ensures that after irq_work_sync() returns the enqueued
irq_work can be freed.=20

> Perhaps this can/should be implemented for other MIPS architecture
> processors as well, but we don't have the enough knowledge of them, nor
> access to the hardware.  So only implement it for loongson64 here.

I have half done bits for cavium and need to finish it=E2=80=A6

> Link: https://lore.kernel.org/6be1cdd5f91dd7418a32ff372a6f3ae259b19195.ca=
mel@xry111.site/
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
