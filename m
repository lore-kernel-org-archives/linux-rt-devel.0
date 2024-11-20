Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AE156676;
	Wed, 20 Nov 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088208; cv=none; b=EXMWuklghQzwvBzHjlwKarBTaWzwmAcA1mpr96f9vu/nIR40wDbPTi4kBDz/s2hBGT3uhzyoRQqH7WF8+3hij51yqBCF0ZaWZIxqFU7nExBCznYX9uxn9fElRMKUkPgn2Q+YL3ezb3PH7i2qCjYBttOcozH9zWACQFZdlgV3bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088208; c=relaxed/simple;
	bh=WOBjE9kTd2QqaeB+8CLez4fjd6LlTtEZDmP3EAaO+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ9s6SaYm2jf97wTdWb1IMs6L87CL6iXb35LUlNrMG6axN5uqvbLZ0k/RVRRBIVk8MgVwnmXfqgrx9BKwSf1CU6L19Hvu4+MLU25lkyFte5h4Q/x2xymMyQfCM4yGhPseY7TwsFM4Q//6a6cBrWZY/sU+rtqF7bCQ80JY+4QE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/FEoeL2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T3TOYwg9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/FEoeL2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T3TOYwg9"
Date: Wed, 20 Nov 2024 08:36:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732088199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOBjE9kTd2QqaeB+8CLez4fjd6LlTtEZDmP3EAaO+OQ=;
	b=Q/FEoeL2n3rPOA3BjimAeMTo1U6LuQneHGWVC/Xj7SFK+piscwl/jb0syV49xRcJUQ+/bV
	5HJ1H9EdvyGA5DUIMpWJg4Q4Bsv3+qQl3W52U258+H3uFvQ3WB0QdtPsJrW4kiRncQy1M2
	xaIYfJpr+8ruyTuFLK3EQfTZbRCzYWTYiJZaTTsukW3Lndq7jnwFmQCDxmsMZuXqLH5odM
	geWhU0cXZvPbzZ40YEPBd2ohdsX5PcrwkCYk4T7RpAFItREWF69uUktFdd412Y5sETyRmS
	j6LxbZeXGrGg6/CBaDYsJGsgVm+KDoS37Q2niJyd8KzlU71FozYMrH9svs+daw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732088199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOBjE9kTd2QqaeB+8CLez4fjd6LlTtEZDmP3EAaO+OQ=;
	b=T3TOYwg9QCc9ArJ8tzo8otiKD6Kn24s+oPAKwTTYPZ2uESkXucu4HsyRPe+2nHjEJ5XIBn
	ryVjf3ru52o4RbDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clark.williams@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241120073637.iwQyy4q7@linutronix.de>
References: <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
 <20241114111409.LWKp5YEg@linutronix.de>
 <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
 <20241114113018.Ilo9ZsQo@linutronix.de>
 <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>
 <20241114132956.wafcHvaB@linutronix.de>
 <ZzYMie7ktV8ByaQF@demetrius>
 <20241118073659.MGircGsm@linutronix.de>
 <CAPAFJkp_MQ8rNsTTY3xfYMhdtiWQunN65Yfft1SqZLptG2J5cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPAFJkp_MQ8rNsTTY3xfYMhdtiWQunN65Yfft1SqZLptG2J5cw@mail.gmail.com>

On 2024-11-20 02:17:53 [+0000], Clark Williams wrote:
> On Mon, Nov 18, 2024 at 7:37=E2=80=AFAM Sebastian Andrzej Siewior <
> bigeasy@linutronix.de> wrote:
>=20
> > On 2024-11-14 08:43:21 [-0600], Clark Williams wrote:
> > > We see similar problems with chronyd accessing the RTC on aarch64
> > > systems that use UEFI. Accessing anything via the EFI Runtime is very
> > > slow. Probably going to turn off 'rtcsync' in chronyd when running
> > > low-latency workloads.
> >
> > But isn't "we call into EFI and have no clue what happens" exactly the
> > reason why we disable EFI runtime services?
> >
> >
> I've had customers want access to EFI variables. I believe we default EFI
> runtime to be off and allow it to be turned on.

So the efi-rtc is accessed via functions calls into EFI. So you call in
there and they do (probably) access the RTC via i2c and remain in EFI
(block) for the entire process. That is why the access is disabled. The
difference here is that the bus access is slow so every read/ write
seems to take a while.

The EFI variable access by itself is fine however the variables might be
saved in NAND flash. The write access may trigger an erase process and
relocate the data and so may the read if too many bit flips were
detected.

> Clark

Sebastian
