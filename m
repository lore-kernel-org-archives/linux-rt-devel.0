Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753532DAFCB;
	Tue, 24 Jun 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791120; cv=none; b=ZMJfCA4AEJzwDBtESXfMVyR7tAQBx32Lw4I/I/iHIrwRI9F5rvl5X0MMGf38zfZugZFupiywNaGIH2SOq3BxMByP4Hx1VDdvrrZwABRBosBwBWmVh7JMMiwW6S8V0YkjygyJwoiO78sFrr0gLRCJWoBYHb0ROgMU/IBUjdaP7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791120; c=relaxed/simple;
	bh=tTycH2nU8FqzSxZbW6bO+Av81NiSi/cbfYzoccwfUPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6yhrgjBMtSaxccPKexiL3+husBNX9qAhZoZvIvZ0Gr8PFSEfdiCmUH/2yKCO5wFzcubCc4HLLU4lnC3CRiosVqtHaRAd1dxN0zGE6L0bHR+WPFdVr1V1/wwBqkoTYZkdR7TIgg3VfeiPv/eL5i3TJTcpPPM50jcZnBvH0+bkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xcni6oT1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xcni6oT1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6rko2rcwweZUsDslFiCZ/96atADm8L+QGmM0MZgbpk0=; b=Xcni6oT11a3lARymFBo/G++cGb
	61k68L4Qlky8CIACOtprdwVLtXynD7FbCq+TwqTninD54XTQqG+pPlqt7iG6IDc4nXU6stV/50zD+
	Z+eONVol6MtR+L1BsGHECXhwJ3xQ8vkiBbTgfWpaebGwipgTE/YKVSRad//gX/68rzOjKF1lAJt+k
	dpN89wUtLQmat9gfyGY4F43caiZQ/XhBJ5WnPjnrfBpusGB8WM7Ml5OvU5n+VvaIs+FL5C5n0vyTg
	H3lA3+AJHirBKXmMMjVVZuMaAzKEjIcE5wnxFEi30gqx6bB9xBl2bF/oVLpc6sGGwj2KydpTqVf6M
	vWR8x6NQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU8kI-00000005Xad-0xel;
	Tue, 24 Jun 2025 18:51:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EBED930BB6E; Tue, 24 Jun 2025 20:51:48 +0200 (CEST)
Date: Tue, 24 Jun 2025 20:51:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Cl??ment L??ger <cleger@rivosinc.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
Message-ID: <20250624185148.GA1490279@noisy.programming.kicks-ass.net>
References: <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
 <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
 <20250624141130.gZVv4WnP@linutronix.de>
 <20250624141801.GV1613200@noisy.programming.kicks-ass.net>
 <20250624142350.xZ_DdClH@linutronix.de>
 <20250624143458.GW1613200@noisy.programming.kicks-ass.net>
 <20250624153314.2Mwvvjmy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624153314.2Mwvvjmy@linutronix.de>

On Tue, Jun 24, 2025 at 05:33:14PM +0200, Nam Cao wrote:
> On Tue, Jun 24, 2025 at 04:34:58PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 24, 2025 at 04:23:50PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2025-06-24 16:18:01 [+0200], Peter Zijlstra wrote:
> > > > I'm confused, sending signals is for exception from userspace. That has
> > > > nothing to do with exceptions from kernelspace being NMI like.
> > > 
> > > Yes. See the original submission
> > > 	https://lore.kernel.org/linux-riscv/20250620114346.1740512-1-namcao@linutronix.de/
> > 
> > I'm still confused, that code is trying to enable IRQs in the
> > from-kernel part. That's insane.
> > 
> > Can some Risc-V person explain why a from-kernel exception would ever
> > result in a signal?!?!
> 
> Exceptions from kernel do not raise signals. Enabling irqs there is not
> necessary, I can remove that part.
> 
> But for my curiousity, do you mind elaborating why it is insane to enable
> irqs in from-kernel exception handling?
> 
> For "NMI-like" exceptions, (I think) I get it, the context would be messed
> up. But what about the others, e.g. kernel page faults?

The non-NMI exceptions like page-fault are okay. In fact, we hard rely
on it when kernel space accesses user-space data in a preemptible
context, it is expected to handle the fault.

My concern was about the NMI like ones -- enabling IRQs for those is
quite mad.
