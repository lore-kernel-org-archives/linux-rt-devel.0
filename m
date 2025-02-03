Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80120C03F;
	Mon,  3 Feb 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592714; cv=none; b=OOxEUSpQLRWQs1M4K5NRsdWKOjX56ZTozrZEmyGCwa3QyJVnzTsZHdWbIf+gC1CMPinwuacGOfQNjYdt/fULjqRPwKyH/1jysfcPVHOGIwRRk4kUVeG0YFi6M3saGA4A24nM8MVeqJtEWqkNHpiLVnlTf3mFmFXYRkkby7ZigJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592714; c=relaxed/simple;
	bh=gDyx3jc9Nefr4uzjw4Tc0EJFWg1rlOTssHFg613y+1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IguHFRfc8MQXkFCvELBh2mIexKx9Zn50qCtN1Y7u71wXIQf2SvrNiFESUTgrtHvEOjv6Q2QzNXyFygU3AL7XJHx0nT36R43Pag2qDSxXxz2NxoF1JrInXdRNN+Z9/uCiEOQz9wfl7bF6/yj0V+HfFm0Yuwv3CRdU730mp8S9YlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hiDSx+Bc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hiDSx+Bc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0PTn3kewas4GEoHUgt5P9i+EIFgUQcOlE7ZnF54n59c=; b=hiDSx+Bc5/X313kFtcsO7mU7iR
	0K76BNDRC2mSRH3bD3qU3ymmgAr2j2sDkyYoYFgkIYFLvIZV0AHAU5QZ89Y/uYyj2KJluxTHy3VLf
	PDFzu4rxPl9rNLahHBR1RIhamHGiCxtQ02+QOnerghzMK1OmHLZRrv+d1tcjOiQSm7WSZqqbk6yAC
	2lVeRb+Ttufnp+3SLD/91D+QPYy/2livDvSLTQoWTMguzBXcbVkWido8du8y/LNtUYJE76jf8Ar4b
	ZnY/sbxnS3KKRiMwfvw+GXj0EgfPRWoN1DproCm0LTrWIGQaE/L5c8Qz8E8snUTlYHTx0u+uxRYuL
	sVd1/V1g==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1texNq-0000000G6AT-27TM;
	Mon, 03 Feb 2025 14:25:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A356300310; Mon,  3 Feb 2025 15:25:05 +0100 (CET)
Date: Mon, 3 Feb 2025 15:25:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/9] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250203142505.GH7145@noisy.programming.kicks-ass.net>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>

On Mon, Feb 03, 2025 at 03:16:23PM +0100, Sebastian Andrzej Siewior wrote:
> The individual architectures often add the preemption model to the begin
> of the backtrace. This is the case on X86 or ARM64 for the "die" case
> but not for regular warning. With the addition of DYNAMIC_PREEMPT for
> PREEMPT_RT we end up with CONFIG_PREEMPT and CONFIG_PREEMPT_RT set
> simultaneously. That means that everyone who tried to add that piece of
> information gets it wrong for PREEMPT_RT because PREEMPT is checked
> first.
> 
> This series adds a generic helper which is used by
> dump_stack_print_info() and other architectures which don't use the
> function and provide this information on their own.
> 
> RFC…v2 https://lore.kernel.org/all/20241206113431.Q-VXMlru@linutronix.de/
>   - Split into individual patches.
>   - Implement preempt_model_str() based on feedback by Peter Zijlstra
>     and Steven Rostedt.
> 
> Sebastian
> 
> Sebastian Andrzej Siewior (9):
>   sched: Add a generic function to return the preemption string.
>   lib/dump_stack: Use preempt_model_str().
>   arm: Rely on generic printing of preemption model.
>   arm64: Rely on generic printing of preemption model.
>   powerpc: Use preempt_model_str().
>   s390: Rely on generic printing of preemption model.
>   x86: Rely on generic printing of preemption model.
>   xtensa: Use preempt_model_str().
>   tracing: Use preempt_model_str().

Works for me; how do we want to go about merging this?

I can take it through the sched tree I suppose, once the various arch
people have blessed it.
