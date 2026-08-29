Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D72486341;
	Sat, 29 Aug 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787993368; cv=none; b=Pkx5lbzy/9BJ+xaV4P/uaIEuZO/NdKwroY5n7vEttNuG7ZtFmurg8Vj//+BXcVPdHiuxRs5xyJDgzy3qg+0xFcowEuWf3aJ1nUiItMW84BnpOfbg/OVeMbyhdrLTEmlY9FYIgd6zIFeC64fLkbb0IQggd/4dJF6/JJeMsuc0L/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787993368; c=relaxed/simple;
	bh=jeXvhmrVaVTZGcY4Yk/I2REYu/lieyjM8rjy/gAgq/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/x7tgCehqjT47ikOgSp1X0ubHVraSZg3mcQA3zoN9SfOzXO2wHpHb2PE8u3sQXWENeWyQsh6HIPXQXzk1H54kVpRgDhkv37HcAbAnEbqcoWnYDlNilNQYz0TY6EMBnLXM+GJQqm3TMIUC/levIUu6xLdICmtti8KbyOP19xDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VupjAuyC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VupjAuyC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pcZd5qV9VBribsCJdVCEf9+lpTwexMZzlTrNX//b62A=; b=VupjAuyCvQhU3mbZf/BnGX6m2k
	VT1HVO1wyzdj8Xzv4lMNi8LnM6i3Up8WWM5CIgsDIOvMrhkuY02BLOGHTJvpEzChU0TT5DmwduTGX
	TfRA9u60b2spcFTxEI2vUr/erSyxfF6oBDiv27r0yLWz0AhNb5uZphuqZXr7rLX8ja1/nbYzjaEDf
	3V5RZCp8WRo6f4Yu1m9QybYjgref+K9HR4wP52/F8BfO3M25/wdh1omen9ZOjSAdE3+rqJzrjGNaW
	4i6bGcI/PkNjzTz0vZIkgzJXEJm6qXq2Rxl72Zpa26SHx6v/7Bu1hjGupGztYq6J9m2NVwZUVz5gf
	Z5n0oCiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0EkI-0000000GDbC-1Te9;
	Sat, 29 Aug 2026 08:49:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CABCD300382; Sat, 29 Aug 2026 10:49:01 +0200 (CEST)
Date: Sat, 29 Aug 2026 10:49:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Stevens <stevensd@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20260829084901.GA776954@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>

On Fri, Aug 28, 2026 at 01:50:05PM -0700, David Stevens wrote:

> > It should have. They're taking spinlock inside raw_spinlock and lockdep
> > should very much warn about that by default.
> 
> It does trylocks on spinlocks and local locks, inside of
> alloc_pages_nolock_noprof(). Lockdep considers that safe.

Argh, that alloc_pages_nolock thing is a horror show.

> On PREEMPT_RT, it is necessary to skip the call to
> alloc_pages_nolock_noprof() from under pi_lock, since with that
> configuration spin_trylock can end up needing to take pi_lock. But at
> least on !PREEMPT_RT, there is no risk of deadlock.

Yeah, which puts the lie to that horrific hack Alexei did. We should
probably teach lockdep about spin_trylock() not being safe and see the
house of cards crumble.
