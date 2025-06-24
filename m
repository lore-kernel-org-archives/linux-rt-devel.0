Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118728EA4D;
	Tue, 24 Jun 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774106; cv=none; b=uZmX/h7Q3CylkHCyWEJ2clNciS1YyT1tuEUh9rL8zJTkty0cww9DoR4V/1um6z6KdeTraNf9bppZfV+GAqbOzMmGklBHTL32WYkKwIWdCG+inZhxGiVc+FPYoHldB6tPg4cmk9Pm5ESPvoXLd9hYv8WerJa9zR3elpNmBbvx/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774106; c=relaxed/simple;
	bh=iV4gr/3BWV7NDdHOhEsRqVulf21qeRC85FDYk+HLPN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmqVB/tEeemMer8psKI8C61mREx5335X04hWhjzq8a74IwqkZxskKvE0828PB79D56MQ6C5/UYY4T2Dsglb8mp36Q8LS0i73StTjcMu3AHjHQLGx8m4YQgdlwUL6e5RlYTBvnkUM0DUVdywZfQuJ24bcbWQGgCkdWdPukm3awLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LWuD3VSW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWuD3VSW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LJ52+yqkREKU2n9YRiyK+/2J+b9eohTa6Rk0szUFEOE=; b=LWuD3VSWymEY53n/WlHmdkJc/b
	YzK3kQa/G79T7gG+xtXFq2WZipwh5UpGA0W0fv0YtNLauDcMNjOnBv1btZyeFtV47UJun+SZwUEXV
	uDI0vzvMP0wy/8jEW/w0jQ/fDClDP3IEx+LUUiLQOFT0uNwf9zUcb6H8gGMHv4YFN7hiBj7I8hs/W
	Qj3vvnez6pTwAY1sUw30W3AVI3NbRi9TCjvVxAuwKxRiliZRkCWUz01DxPxWiuB31Nu3R0+k94OrY
	pgrjcuyCsoZewvIJ2Xsks3X7KduKPHK7se76aexBvCpHZga1JxgBiSe3YGu8Pcox0h6x6PNnuqr/v
	w87ENWuw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU4Js-00000005SFZ-33Ob;
	Tue, 24 Jun 2025 14:08:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 905AB307E51; Tue, 24 Jun 2025 16:08:15 +0200 (CEST)
Date: Tue, 24 Jun 2025 16:08:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Nam Cao <namcao@linutronix.de>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
Message-ID: <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>

On Tue, Jun 24, 2025 at 03:48:21PM +0200, Clément Léger wrote:
> 
> 
> On 24/06/2025 15:17, Nam Cao wrote:
> > On Tue, Jun 24, 2025 at 01:37:13PM +0200, Clément Léger wrote:
> >> On 24/06/2025 04:09, Maciej W. Rozycki wrote:
> >>> On Mon, 23 Jun 2025, Palmer Dabbelt wrote:
> >>>> I'm kind of split on a Fixes tag here.  One could argue it's a regression, as
> >>>> having interrupts disabled during exceptions is going to cause all sorts of
> >>>> performance issues for users.  Seems a bit risk to just backport, though...
> >>>>
> >>>> That said, if nobody noticed then it's probably a good sign nobody is really
> >>>> paying attention and we should just backport it before anyone notices...
> >>>
> >>>  Oh, someone did notice and it's not only performance, cf. 
> >>> <https://lore.kernel.org/r/alpine.DEB.2.21.2501070143250.18889@angie.orcam.me.uk/>.
> >>
> >> I also had a series which was doing so for misaligned accesses handling,
> >> but after discussion, it was not ok to do so.:
> >>
> >> https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/
> > 
> > If I understand that right, exceptions from kernel should be treated as
> > NMI, so that lockdep can tell us if exception handlers touch locks.
> > 
> > But (conditionally) enabling interrupts does not lose us that benefit. It
> > is still considered NMI by lockdep.
> > 
> > Unless I miss something, the patch is fine as is.

I'm confused, you're wanting to conditionally enable interrupts from a
kernel exception while its NMI like? *WHY* ?!

