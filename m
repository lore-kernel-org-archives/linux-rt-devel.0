Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA444E66B;
	Fri, 28 Aug 2026 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921313; cv=none; b=O/VPAMtqy/0Adyr5GyXnL+WDzc+O40CXJotLeCfsJht0w0iVIYG6Ha9wzmVTqcAtvSKGvvsC47GMyoe/Jb0brIq5eJeA+A6cMP/+5+TJ/WWp9w3/vQBRgOsRpMPt/lG2OSTalodWgZr3EHWTEZp81QTNydsVC3TJR+zbwR+HyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921313; c=relaxed/simple;
	bh=59pQEm4J632UzlRc38VlYiLZzPG9Ldg1oVqBQQFCU10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0czSPEoGxNntMBtjvovOD6IF9ZW8bFP6PEk+V5wXxQuwyyLo3FR29GPfEg4lginT70Yu9AD8MAKeiyMsA38Z319BG07L6RVlgbwnHfqIvtOfc80bllzmo8Hj2mIPQEQ8uvt17ygrD7OwLnGPd+aM2SZMAmyjZ7JupeO8LsAHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=apd9kBBL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apd9kBBL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AY84rfjFkNDjAWFNf8AP9fCrg78WzFe8p1rGWp/UIAo=; b=apd9kBBLyOu58CYgPPP5CX3ADi
	bQwvk9xWrikcjNqyLtRx2ifMpANi76pueMtJCNpfBW3hS6hNFriUiwNXeOieYmaxYoWVEhH4yeyGQ
	B4ChwuMdqS6J+KGWO6Pa3/maqlBEgbclayatiFx/Nevfd831UN+Hiq0OeBqw4epE32rqEZruKNo5h
	Q94YyBfUjvAiC772y/3ECHbKipiJm4gmgQlmEjGqyB2krabU5/5qZDMZWTDH1+KD+eIB+yuwmHYHm
	GaTodGV5H2Mm+kMp6XQEbWwM8QktRq9qECMqOyA+DpA1ltXatP778QCi/VudQMVEmDm5i25tjrCUk
	2pUDBrnA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzw00-00000008FkC-1X7M;
	Fri, 28 Aug 2026 12:48:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C791030030F; Fri, 28 Aug 2026 14:47:58 +0200 (CEST)
Date: Fri, 28 Aug 2026 14:47:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Stevens <stevensd@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	jstultz@google.com
Subject: Re: [RFC 00/10] Reclaimable kernel stacks
Message-ID: <20260828124758.GP687043@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>

On Thu, Aug 27, 2026 at 04:29:38PM -0700, David Stevens wrote:

> On Android, system processes typically have 2000-3000 threads. App
> processes add 1000s more threads on top of this.

WTF ?!? Why does that all spawn *that* many threads? Perhaps work on
reducing that some?

> Tracking blocked state and when it is safe to reclaim a stack is done
> via a series of hooks in the scheduler. The actual reclaim of stacks is
> done asynchronously in a shrinker.
> 
> Once a task's stack has been reclaimed, it cannot be rescheduled until
> its stack is repopulated. Although there can be a repopulation fast path
> within the scheduler, reliably allocating memory to repopulate the stack
> requires a fallback path that defers the repopulation and wakeup to a
> workqueue context that can use GFP_KERNEL.

I am really confused. On the one hand you have John working on proxy
execution, with the aim on reducing latencies, and then here you are,
posting something that will introduce basically unbound latencies.


