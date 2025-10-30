Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2B36337A
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838085; cv=none; b=K10sjsG1mi8iyZRJcs3kuQ6eYaYk6sHQ8pSNOyu9zCZm4COvFybrmTC/A2yIHRpCBcVAyOf3vnUzqy9z/XMHbEJKCYYdRGFfY59njeWBeuXpc4JwaoIRVXBb6axI7w8euqC2ehXD+T57COA/vMluKlYb+ecqzneD/64i0fYvkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838085; c=relaxed/simple;
	bh=+H/TWInAyePBeiEAFJhr3RPDJ0H39GlE+N/+IuKxDU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB8fAiPK80WwW7T+vIB8x+mxM3a5EJ2ZRRs49vFShFr7e9L7wEHVNvMXpr3hEG34boJ/SjshLRLlApsLykVMEY+quZpI+X2u5ahv9vg1AWvx8+bzgRGy7Ob3iXneDnpHih5Qjj0pm3sJ9NJEWUDmzdbDkzyY0tn23kyiwejeI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUWdCq7c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zb46iSxJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUWdCq7c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zb46iSxJ"
Date: Thu, 30 Oct 2025 16:28:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761838082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XcZmBDUJk7yw41e2osOtFQYA59+nZfoqavQZwKrx8SU=;
	b=mUWdCq7c+05S92Z6e3ycQap5GG7kv30irDPESS3zUYv5LZGe7HhqHaUMNrlwONd33psUke
	D5+1VvUj8ejnw9gyvQ+qOWQZvr0WbTRysFttiLkBTWMRczshO0ubWTEMrQgs0hKlagMPKU
	cPM8AYLlwviqdfPTYH1gHK7sOptPMkuIBRYojp4P5uKhpK1gE+S6KlyXrlK4Y+Ar1eueO0
	8qXcCGD/hrVeABPAXazUN398ZtWm5LbCdHLHe/jQu+YuxppyfA+yKuVzCfoDLriiDMz4S6
	Rqu8PxIB8v9CVRzPTCbvPTGEzl4D1ohGAN58AuP+9ks+ssgfkx0KJ47WnFvUFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761838082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XcZmBDUJk7yw41e2osOtFQYA59+nZfoqavQZwKrx8SU=;
	b=zb46iSxJzjaqi0J3/h4ZeZvlpftP3P6uGPFVE+TMicvvCPwsPjZkdtL4z1LgsFzylToKqK
	ooHg9L9VKk6q9LBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Message-ID: <20251030152800.9LD5D2GP@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
 <20251029155918.503060-5-bigeasy@linutronix.de>
 <a86e9827-9b8b-4313-8d46-5fb2af5b8826@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a86e9827-9b8b-4313-8d46-5fb2af5b8826@app.fastmail.com>

On 2025-10-30 16:24:16 [+0100], Arnd Bergmann wrote:
> On Wed, Oct 29, 2025, at 16:59, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > jump-labels are used to efficiently switch between two possible code
> > paths. To achieve this, stop_machine() is used to keep the CPU in a
> > known state while the opcode is modified. The usage of stop_machine()
> > here leads to large latency spikes which can be observed on PREEMPT_RT.
> >
> > Jump labels may change the target during runtime and are not restricted
> > to debug or "configuration/ setup" part of a PREEMPT_RT system where
> > high latencies could be defined as acceptable.
> >
> > Disable jump-label support on a PREEMPT_RT system.
> >
> > [bigeasy: Patch description.]
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  arch/arm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 864a14a434b08..99c9b1c320af8 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -80,7 +80,7 @@ config ARM
> >  	select HAS_IOPORT
> >  	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
> >  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> > -	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> > +	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU 
> > && !PREEMPT_RT
> 
> I posted a slightly different version last year, which optimizes
> the uniprocessor version and has a little more information
> in the changelog:
> 
> https://lore.kernel.org/all/20241210160556.2341497-2-arnd@kernel.org/

This actually slipped my mind but I was fine with it according the link.
So let me replace this, too.

>      Arnd

Sebastian
