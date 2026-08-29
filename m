Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A05175A66;
	Sat, 29 Aug 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788014992; cv=none; b=KbKuaGp0XtXpXyG1XmZplGZV0nF5jHaRt77Rkt5sZkDKeBaHgojXYQFxzj7GvTW1HfSyss+Gz4vrPdT5rXAqCPCS1PNx600VHM6LAY6L+Rf3HpwUzOfPQs2UV9fLma8DblDkcwZ849mBKLShWR8pPnENnBBN9DxvvnvGlqtoHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788014992; c=relaxed/simple;
	bh=66dDGRD1kT5icwzJuYUEOtk0SliXmmuCYMcXg/Mpo5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjF3NobTQPuDChQIX2HNKyM2h7vYRiHKwoMZQJS+EvpLFkrsstvdqCM/qxZuFcGdV0ISJDjhUiZxJzzScT0KOPgAIa0Ezd7cFF5nTlQ1ViSv+m0UTQA9rjiouuRbLXDnKA9ErCvXfrElm6Ax1WZpn9w26qirqQmeTF70yTht7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OvozmjiX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvozmjiX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SX1FLvOIFSHuqgjqZXoyvcWzn59rRJ4yAy3cPilBPfs=; b=OvozmjiX5mFbDoB4jSgTxkNxJ5
	Zfhj7AJNCi2u1p2S6ieZ3nMrvkj151vzofRuiFEtBNVz43gfPB5P7/Oa1vbTIskKCIYUXSrO07ppN
	OiKsyqHdyBhlVSw78tpf1rYf+g1rT66QEZeH0x/zWKX8tst6RBW1U+4WyQFQlRjQUUXCwlnsbDBbb
	idHkygyLw05rNiH0LzWDD+blm0X/hIK6DUYdKm2oQJZAulbAmC5fFqheRJehMiJxsOO7Cqd8ORGIs
	3YicaqqUsyNU956MFxLwfQJ5/3Eq5JxZwq3wNIO2WvwMUIvUjQMWbQkYm4ij7TR9l6nMPYkOb0OOF
	7lzqn0VA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0KN1-0000000Gbyg-0k1Y;
	Sat, 29 Aug 2026 14:49:23 +0000
Date: Sat, 29 Aug 2026 15:49:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Stevens <stevensd@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <apLxcg3Lgy0-nXA4@casper.infradead.org>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
 <20260829084901.GA776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829084901.GA776954@noisy.programming.kicks-ass.net>

On Sat, Aug 29, 2026 at 10:49:01AM +0200, Peter Zijlstra wrote:
> > On PREEMPT_RT, it is necessary to skip the call to
> > alloc_pages_nolock_noprof() from under pi_lock, since with that
> > configuration spin_trylock can end up needing to take pi_lock. But at
> > least on !PREEMPT_RT, there is no risk of deadlock.
> 
> Yeah, which puts the lie to that horrific hack Alexei did. We should
> probably teach lockdep about spin_trylock() not being safe and see the
> house of cards crumble.

Why is spin_trylock() unsafe on PREEMPT_RT?  It's not intuitive since
one can mutex_trylock() in interrupt context or under spinlock.
