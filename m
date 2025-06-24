Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE326CE04
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779199; cv=none; b=X7nbKw5Rgj2hZM1HR9BV17VTrIMe4CzTcMMTZ1oAOldeF7Vo9uwsm6ks8Ac5349o/hzaHPQZ/1RwwmTlkXZGJkemsGJu0E+U48GDkLEgrIJQSBvMYjrWS+WnlkJmygj4ow8j58kS43eESX83MNfRpVABX5YObPY68uYSRmdMjuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779199; c=relaxed/simple;
	bh=5V0P1fSmYxDSgpS/o/vNsmbsCRW9oZrAWixnLT8nAsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLnk86t7lSU7CzMyfU3I9BCLvvciEk5wnPQnRM7/Vh0rERESQj8MoziDYSXvVeCKM/gQ5P/V2Ae/WSOcepk2DMLNg2u/LFYgahOdzvUtla37ypik2VIl1z++Dg9x4gALMn2rX0T/HODEmrS2yM7TalBNOY14GzPxcgUu+MKiW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gxSriVND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5Og8P0v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gxSriVND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5Og8P0v"
Date: Tue, 24 Jun 2025 17:33:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750779195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBrzg5DCuHrE1OY+QwXkYAH3DJNsPYdSW7dnUZCTfyk=;
	b=gxSriVND0Umc1rzkQrowmw7fLnGOU0KC7P7VlIYi3MHtfr1jmWIR3tWpp0OsN0CW7tPSc7
	SlPxftUHUyx0rW9Av6YeE9wBkPRBwij2J9O32AjYjfh9DDn/wHnY2igOlJGBerF9p2DHC9
	nItHplqYTT1zIq0hybApyVIsvalJhnmW+BqcqEyXix+bQb5W8aC6fBh0Ulpv+C1mEYmo2a
	qQZhm7lgfmD6DDyYkBvePQt6CFfs+LLDktcczrRf6NAumtIw4imroSSFjzwK509FGqMYq/
	iRo64jZl/ZXYKWHi4SinwzyzU3508zqE0hsaMSzgxX+CKWgW5H0xAR1BM9QGAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750779195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBrzg5DCuHrE1OY+QwXkYAH3DJNsPYdSW7dnUZCTfyk=;
	b=S5Og8P0vHyE3rai9+oFP5AquPdi3KPrrqARx0pEPwNeBj/xJU/A/R29GcX0CAt5veRBwA6
	+NUrjc8Ux0vAlBDA==
From: Nam Cao <namcao@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
Message-ID: <20250624153314.2Mwvvjmy@linutronix.de>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
 <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
 <20250624141130.gZVv4WnP@linutronix.de>
 <20250624141801.GV1613200@noisy.programming.kicks-ass.net>
 <20250624142350.xZ_DdClH@linutronix.de>
 <20250624143458.GW1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624143458.GW1613200@noisy.programming.kicks-ass.net>

On Tue, Jun 24, 2025 at 04:34:58PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 24, 2025 at 04:23:50PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-24 16:18:01 [+0200], Peter Zijlstra wrote:
> > > I'm confused, sending signals is for exception from userspace. That has
> > > nothing to do with exceptions from kernelspace being NMI like.
> > 
> > Yes. See the original submission
> > 	https://lore.kernel.org/linux-riscv/20250620114346.1740512-1-namcao@linutronix.de/
> 
> I'm still confused, that code is trying to enable IRQs in the
> from-kernel part. That's insane.
> 
> Can some Risc-V person explain why a from-kernel exception would ever
> result in a signal?!?!

Exceptions from kernel do not raise signals. Enabling irqs there is not
necessary, I can remove that part.

But for my curiousity, do you mind elaborating why it is insane to enable
irqs in from-kernel exception handling?

For "NMI-like" exceptions, (I think) I get it, the context would be messed
up. But what about the others, e.g. kernel page faults?

Best regards,
Nam
