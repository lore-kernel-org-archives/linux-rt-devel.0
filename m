Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6C22C353
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925847; cv=none; b=EGRlg3sPMfymmCDPABuepK8uLtk7b/S6P1wiSVcdNcQd+gxYFiO/hLjxCV9yx0LTXJqblerEqX8JJIs9YnMIZDYEHLLAazq7pPwC+dvfpqZIhuvu0VLhicGbwnGcvXF701YN5MPTkz170xYgNV4Ee7OQoZMXxkBq+2dieViGDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925847; c=relaxed/simple;
	bh=uig1fxNOcNQk4L4DcKA96S4K1+tjKyUesavchLaLiC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9IRNjjECEPrmxuO8lYDSfXUGwmju5QYjNHQPWF8JA8bTsITm60lHDtKlM4+XqAmKsfZm5CZOrJo48agpj/iYzyxDasdLhUgUUOqheI2shRJ3bvaymslwHbmoUf8nvrGpb+zvc9RalskG7NJGw2j61takDJuWKB91vVnBcZUbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWVLS6d4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OKKVRjHg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWVLS6d4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OKKVRjHg"
Date: Wed, 11 Dec 2024 15:04:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733925844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsNEwFWdf8+xj8apQ2tpCjXCCbHBW+SvnxbyipiMG7c=;
	b=kWVLS6d4m+EdcwV3DiEN+Tq0iCErqJGk2iwi7xF+AVXRlYxWVxHuSBbykXREOtAi1RWMQA
	8ayx646x4C82OrGgSupCiDY55xXdldBUUmGU/RAvhqvBKsgO8r29iOc8gOtKb2QMTmxoTV
	Boe4qN6fO+Kl8Ciz820pgNZ5sK/hKM262a/Ahb+qUNK1h4zkPb0LcGYp1n+mN0jlYg0GEk
	qm8hRO8nm9alfzkHePtvVRTB9ZaFJiNoE7Q7j9+N++paHbPLmus4EffeRREhL4VG6ZF/Id
	8/CqVJUwrr6vpTPzNWFUIrp+TFHPjA7pNNcNlDoqSoduukWH+JIFzbNaYYY4NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733925844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsNEwFWdf8+xj8apQ2tpCjXCCbHBW+SvnxbyipiMG7c=;
	b=OKKVRjHggoTfjau/0sKye5pPUjMe8nsbgsOCCpYuo4jyTYQistgxgsYQz4pnoDQjFIFnH7
	FAG0k5Ffj1lb+UDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Message-ID: <20241211140402.yf7gMExr@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-3-arnd@kernel.org>
 <20241211134811.wM_UADhQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211134811.wM_UADhQ@linutronix.de>

On 2024-12-11 14:48:11 [+0100], To Arnd Bergmann wrote:
> I guess if you have boxes with 4GiB+ and can proof that the performance
> improves without HIGHPTE (since you don't have to map the page table).
> The question is then how much of low mem has to be used instead and when
> does it start to hurt.

Some numbers have been been documented in commit
   14315592009c1 ("x86, mm: Allow highmem user page tables to be disabled at boot time")

and I would like cite:
| We could probably handwave up an argument for a threshold at 16G of total
| RAM.

which means HIGHPTE would make sense with >= 16GiB of memory.

Sebastian
