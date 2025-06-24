Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67132D540A;
	Tue, 24 Jun 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774691; cv=none; b=lyF56JiwTmZ9+NbDO925YtlpU7OsHxLoUDROKP8FubxZ4TfVhy2hOr0WTBb5L286gyBypSu1w6T6F3o6xZIsW2WIasfSUDbva12GO5Mn+5EpwPvTe7iFxZTszM1yo6WWqSFdwrfnZDgYAWZYTlRa65+l1D1Bv6ydWA+VT/q67z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774691; c=relaxed/simple;
	bh=HamFfQTYAw3tgaHc35DT2y7EnBEaF/pUJISbotOSIiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFq1yTOp5U/pmGGdszlxKR9yvi0aJ88hQxnocjaMLFzLmIJv3EPpMc/vzszfNUryBANvnUt1vh8Lx0eNU6aRad63rw3tEdCmWgXYRkCgSYly9HzDaOS8z/cW/Q7ADw5HNGGBzLz+zokLNRxcz4DkYuxRI+S5bc4plCB1DkpejCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rUks+Jnd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rUks+Jnd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3M75jWfb216WOXODZaCIr+/xgufHXrDaemvMWPhwVns=; b=rUks+Jnd4nDKeI7pcVJcAxPX/9
	EVO7M1Q4v3jE949Tyg0JRRMteD8qYmBkKc56jbyJouA7cRoo23e1P6LjS1b02LmcarmMrSfD0O5bp
	OnP65PXhe9637K/umZcSFe4XWnk+zYlQTyiswkPLTUCraqv9aXGiU4b244nq1diovouBtgV0sQ00T
	asrCe0KC06qYGERqFS7lPqvF3eL6swKXLgf1p6maB6T5KjYHYt0hGXASv4/J+ggOwOyHNDGdWoNvB
	yxroEGo6wEI/DNeBlEzq/qTr4eN2MclVN5MZgN9aUMrYpUYaF62p5onmCZGn2KzUuKYC6c1Hn55VZ
	bKSyL7ZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU4TK-00000006n9g-1heH;
	Tue, 24 Jun 2025 14:18:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82F9A307E51; Tue, 24 Jun 2025 16:18:01 +0200 (CEST)
Date: Tue, 24 Jun 2025 16:18:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Nam Cao <namcao@linutronix.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
Message-ID: <20250624141801.GV1613200@noisy.programming.kicks-ass.net>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
 <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
 <20250624141130.gZVv4WnP@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624141130.gZVv4WnP@linutronix.de>

On Tue, Jun 24, 2025 at 04:11:30PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-24 16:08:15 [+0200], Peter Zijlstra wrote:
> > > >>
> > > >> I also had a series which was doing so for misaligned accesses handling,
> > > >> but after discussion, it was not ok to do so.:
> > > >>
> > > >> https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/
> > > > 
> > > > If I understand that right, exceptions from kernel should be treated as
> > > > NMI, so that lockdep can tell us if exception handlers touch locks.
> > > > 
> > > > But (conditionally) enabling interrupts does not lose us that benefit. It
> > > > is still considered NMI by lockdep.
> > > > 
> > > > Unless I miss something, the patch is fine as is.
> > 
> > I'm confused, you're wanting to conditionally enable interrupts from a
> > kernel exception while its NMI like? *WHY* ?!
> 
> What we want is to enable interrupt handling if it was enabled before
> the exception occured. So we can send a proper signal on PREEMPT_RT
> without chocking on spinlock_t/ sighand.

I'm confused, sending signals is for exception from userspace. That has
nothing to do with exceptions from kernelspace being NMI like.
