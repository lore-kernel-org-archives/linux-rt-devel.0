Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FE44781B;
	Fri, 28 Aug 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920891; cv=none; b=FmEuHU7UAx5vl6AIKBlhbEjqrJqs7qTbSMZVlPDjxziBPOdtTsMXHEYqJQpCuT6PCnBTWin1+966AeLHBXXh++5sos0DaGyL2UN3qZRXdHdjrLvAu0DrN14XT+Mhmf76UQNLDJSoozVjAibYBIJlqGnFXr8KncfHrXBXBMCC1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920891; c=relaxed/simple;
	bh=JsdYFNlmu3mZtC0DhffCWqMCuB12dqERlIoFUoVuPCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVU7tQCYUma7vbdnr2uOeknInzlGo2ppNs20y/ZOTkupwxbU3e6vUWLa7zzt2Ssz+p+X/Np5b230DgMMtY5KV2qbXcPKijLz228QZxAQQT0Q1eEyXyYl+k/3tl8j2kutk+o60d9rD6bQzqAvLTtGRYk2d8nefgoVmS9dGff7X4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HzpcEx3Z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HzpcEx3Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JsdYFNlmu3mZtC0DhffCWqMCuB12dqERlIoFUoVuPCg=; b=HzpcEx3Zje4gJfUb+ceU/x1FvE
	Zl3Mh4+eWu1HIJa93GBWDAjBGZo41IkX2S3AHDLV+ABH8Iudi6x4SUr8JFb7Xp+1f8Ta90NUfIQpx
	xATI1wocphSZX/9LCrdJL9vLsfbJVD4ikAX0dnigoFCt2X36M6tqukfVSkYUTSw7/RpzWURd7G2B7
	ky42+wb5W0wgO3bhKN8rW0nZqed7CeNX1TYQw6coaPu0LDtCbvXRJ5cNfOXMnNwCO/uM4nFSEQZzM
	jAGWSRVFbt1xFQbORlb47ptVlPQUcPizFCQgguncsUiMarbI0Ol/17cCxaQrLbrIovxFgxl4kOQLa
	mZsBqG5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzvtH-00000008FbN-2c6I;
	Fri, 28 Aug 2026 12:41:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07F9C30030F; Fri, 28 Aug 2026 14:41:01 +0200 (CEST)
Date: Fri, 28 Aug 2026 14:41:00 +0200
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
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260828124100.GO687043@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827232948.2520558-7-stevensd@google.com>

On Thu, Aug 27, 2026 at 04:29:44PM -0700, David Stevens wrote:
> This feature does work on PREEMPT_RT, but is likely undesirable due to
> the extra uncertainty. The fact that alloc_pages_nolock_noprof() cannot
> be called from under the scheduler lock also makes repopulating stacks
> more expensive.

Aaah, so you knew it was hot garbage :-(

Please don't ever post anything like this again.
