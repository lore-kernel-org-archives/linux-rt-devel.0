Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1673DA7CA;
	Mon, 29 Jun 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754797; cv=none; b=h7idcP9YiiKl8TV9zBfzFU8UqlSqWxZhfytAJ6m9EtwMTJ0VSfRjzm154SGw9ZhdnJBLn7G4lzcf/ps07mN9RhkRAxFocaI5wbvEZSF9qEIlcyPepTrwlC4GOv7xgiLdAmzBLkKsDToF6vydFa7I/oVjCeYX6MP7FMEZU4E8asY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754797; c=relaxed/simple;
	bh=nX2pdBsexUM5hf5OHrK8Sn34uutzOiniDpVtW0nTXNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJsWtZr/Q0iD0YwvlnRaRvjwWYadBfeiCBW6lO72RodciV3scE2B28X+sCdJNVsylstc1p7YlT13RDCM4tVqv4ATGsCSB2wdC1618CXVNLrEq/x3LQe5aFL1x2KVmEFcY0PqXkXn0hwsJZiifdDghtINiRllN2MBF3huLEIEOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1weFd2-0005iX-00; Mon, 29 Jun 2026 19:18:40 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id B4A74C013E; Mon, 29 Jun 2026 19:14:22 +0200 (CEST)
Date: Mon, 29 Jun 2026 19:14:22 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] MIPS: loongson64: add IRQ work based on self-IPI
Message-ID: <akKn7hHZF3wi4OLC@alpha.franken.de>
References: <20260623172728.191557-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623172728.191557-1-xry111@xry111.site>

On Wed, Jun 24, 2026 at 01:27:21AM +0800, Xi Ruoyao wrote:
> Since the commit 91840be8f710 ("irq_work: Fix use-after-free in
> irq_work_single() on PREEMPT_RT"), we observed the performance of
> execve() is significantly impacted on MIPS.
> 
> While we are unsure how that commit caused the impact or how to improve
> it (or even if it can be improved at all), implementing IRQ work with
> self-IPI seems able to mitigate the impaction.
> 
> Perhaps this can/should be implemented for other MIPS architecture
> processors as well, but we don't have the enough knowledge of them, nor
> access to the hardware.  So only implement it for loongson64 here.
> 
> Link: https://lore.kernel.org/6be1cdd5f91dd7418a32ff372a6f3ae259b19195.camel@xry111.site/
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/mips/include/asm/irq_work.h |  9 +++++++++
>  arch/mips/include/asm/smp.h      |  2 ++
>  arch/mips/loongson64/smp.c       | 10 ++++++++++
>  3 files changed, 21 insertions(+)
>  create mode 100644 arch/mips/include/asm/irq_work.h

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
