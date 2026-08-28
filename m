Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D1391E76;
	Fri, 28 Aug 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927172; cv=none; b=U75oEtfzUfemBHAExqrRVNK48ThLrP5V41iS5KrAm1il+zsmwpXqVe38c9t0u/Y9bNhaezBeDDT2cvWZl7loxumfYXlt2OnQsbG5FAZvf/fnu+YyJrocH6snjVfl/4+3qPVTdXcmsomKtWPDkcaxq7lUMn//8oniKPW5QPk+hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927172; c=relaxed/simple;
	bh=MCnszT+cq6J0R2ln/5GuZbGHKJJQgN4ypa5dtJ3XHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGu0HRxJSiUX7I7tQbdCVPRoOyM087shDHX+sydI06HdgWQumagiC7TykzgSoaEZFt1cFApMPWQdBU5rgq6S+7oZy2HRf5wexaIzAaFtk5QJTLrd+xiv975OF0eawHel0pFz+8pe+FbE+OOYPTISIWhEDiSvsNI/7RgUNZLTpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WCbV4WdJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCbV4WdJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G0OQQM96cRuVu1FTu7WqbsC1AtHFFzwK+Yp7CP8KbN0=; b=WCbV4WdJizqDtTanXClaA1BwAe
	Jjs+oePpTqjB1oPSb26S2hl/+wnoLIJGLla0PnZ6b0Beam3zsMbSC8WaAq93PDlR1udof1RGiUv+K
	KQdbq5Tj7gJJI9IvkTDGLZdQhps+NZUtcD6B1FYK31lRBFQQx/oORxCe3SdO3dFR8FgUOZ7/FuepD
	PHyGlYqPwCULkIL3vDy3h4sVaDulX+MEKgtwi538lReReUUWAz0zj0qtXppeYzqHAfoKSUkpsfdQ3
	ea0MLXzia3rEQ58B8NVuTDl28douQsFa2aHC8V2hS58kKAT1ITSVOdNRKBt2abcnDLl1OLNK/eJbx
	3gsPn1kg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzxWj-0000000EpCU-3vkK;
	Fri, 28 Aug 2026 14:25:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE3C930116A; Fri, 28 Aug 2026 16:25:52 +0200 (CEST)
Date: Fri, 28 Aug 2026 16:25:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: David Stevens <stevensd@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260828142552.GN788244@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828135947.GU776954@noisy.programming.kicks-ass.net>

On Fri, Aug 28, 2026 at 03:59:47PM +0200, Peter Zijlstra wrote:

> > What also should be simpler (and I am not saying just to move you away
> > from the scheduler) is to have a shrinker which iterates over all tasks
> > which are marked for reclaim and then similar to swap just unmap both
> > stack pages and release the second page which is not used.
> > Upon wake up the task should create a page_fault which would be used to
> > allocate the second stack page and map the whole stack again.
> 
> Right, so you can FREEZE the task, unmap its stack and then thaw it or
> something. But there should be a definite opt-out on all this, because
> taking faults on your stack will be horrible.
> 
> Not to mention you'll suffer wakeup latencies while frozen.
> 
> This all really sounds like what should be addressed is this insane
> number of tasks rather than trying to cope with the consequences of
> that.

Taking faults on the task-stack is not going to work. That fault will
happen while you have locks held and IRQs disabled. Ideally, it'll
happen when you're knee deep in the allocator.

That fault will then again call the allocator to allocator your stack
page, and...
