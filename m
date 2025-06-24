Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D855291C09;
	Tue, 24 Jun 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775707; cv=none; b=rosGYeweKeNqjFG9CHDquaUzOQm5q9bWk7chYK4zY/vrLO5VUpTM5AMgPGVphdpizpP2ryxE1vq/yLs9/uEkxx901bZOq0P+CogjPSguUYo9Cs0Lzwz8s3f3ZoCkluTb1DMXtOH6XfhTl/uuQGOSqpSFQfMsHeB5r2nj12YGbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775707; c=relaxed/simple;
	bh=xdTfpxDZzCS30NH7J9FZx9r2GnHM46JXMgjn8uCu54o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUzvKIXdyBwaZweUftNqBT8yzpzxe4tl1rRUsd7fssOeb7sM51EtptFpRmKPZsC/na22Y5hIdIaR/gPY0dW54yN9/cPYKkWGZwRQ8wESi2I16emj1umnepqjlckjSOG8+AxkMHSHq83uKb5PFLapnFvJwZOJvDpgqmnL/X0sdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=poqq7hHY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="poqq7hHY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DyOk14eUc32P6w82vpyuzaHeCuPZSG8D+2f7eCuUwY0=; b=poqq7hHYMP6HTbyqyrgvFlYdYz
	zYh0lCtHZrkpFTJ2BsSx25VNC8pJw3iqCqu1isssiO1Oh+qLqAusXbQP9FTLQcZkljrOgpiyjf5wb
	r4MUmRITnFUGs94hQRtFxuz6q9Boe5JomK4QMGEOaShNmBGHOAs7zAhn+CVUAjHR3qd17B4OvH9mO
	H0uVnOSWRnloKFCXHoEHxzatoAIL335aNDKDiOlKQv3BX9Mbw79mTZX3Srv8Vgv4sdPe+DWadse20
	lNTAstXIRl+md6y8JyfQz4uGrw+zx84oDLXTQ71PJh1belrKoTWv87eVXs852LWrkNcIzwth/nijX
	fSvQ78RQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU4jj-00000006pFk-07Ar;
	Tue, 24 Jun 2025 14:34:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 64FC1307E51; Tue, 24 Jun 2025 16:34:58 +0200 (CEST)
Date: Tue, 24 Jun 2025 16:34:58 +0200
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
Message-ID: <20250624143458.GW1613200@noisy.programming.kicks-ass.net>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
 <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
 <20250624141130.gZVv4WnP@linutronix.de>
 <20250624141801.GV1613200@noisy.programming.kicks-ass.net>
 <20250624142350.xZ_DdClH@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624142350.xZ_DdClH@linutronix.de>

On Tue, Jun 24, 2025 at 04:23:50PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-24 16:18:01 [+0200], Peter Zijlstra wrote:
> > I'm confused, sending signals is for exception from userspace. That has
> > nothing to do with exceptions from kernelspace being NMI like.
> 
> Yes. See the original submission
> 	https://lore.kernel.org/linux-riscv/20250620114346.1740512-1-namcao@linutronix.de/

I'm still confused, that code is trying to enable IRQs in the
from-kernel part. That's insane.

Can some Risc-V person explain why a from-kernel exception would ever
result in a signal?!?!
