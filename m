Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B633C0608;
	Mon, 31 Aug 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160517; cv=none; b=ZqAzl6TVEjufvTePO3DQopOM4zgwrvXeBoWMZI3UxYIG07vXImS6dWU9bW625FTFg2fLnXnq9k4OiZH5yHGtjTsVc7G5dU5MYZwX6E2nfCIDW89HUdSJUZHS6Ta7ZKA4FHSOGDEOpV7IwF710rQXK2kDrsDsGKsziDOuH51jo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160517; c=relaxed/simple;
	bh=ijEyptNiPN5HW9gpoCVFaJTKI5pwHgOUe4gqsCyv6SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACn/XfAE5hPqBUyM0QTzld6dBBXZCa3CWj0tLAW/lDQz7lsnK+lxyuB1FW46XKjHfXuWcBS2b/2l9IR8oc5GoHi5asC+1j3ewd2KnEa2ZwDoK8+CjG4EnGuGnQZIGuw/ihiT/k69wwUn7hSOdAgmA1+0WWVb0S1jqpX9fjAeL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pGIgXFEK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGIgXFEK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c2115nKGBEwObmSrqlfs2WcBhmzv4iDh4H0qiO5lvUM=; b=pGIgXFEKAN/kTi6sG6t/00uMvv
	+WycgRgKlg/+rvkAKsveOmQTewMEVutHhuo5hVygDJWrzcNnYzE7wD+mQYmhxZKmHutXGdW+zNJ0H
	OyUKRZQJE2oXdf8gdmVvf7G1wf0r5LcVy71HIPmPUrpkyzANAaTHG15lLBvSqf7FaJ+gA2Uq5rV/g
	uj+0F9R8YG0UxT1bpDWxxd/xYyYYqc1wmAynqepmWo4TB9B5IPbw0uCJKDqp/H3ooTXtSvGJdRSlP
	0TMmHkfzu51BKdWUabDiW6kkL6aNKnDGgLILH9HbPwmWZLqpYHo+pm82f0/WFES3FAUGqRxoYI3Qf
	7tFNNdGA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x0wEA-00000009bM1-2gNA;
	Mon, 31 Aug 2026 07:14:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7EBA3002D8; Mon, 31 Aug 2026 09:14:44 +0200 (CEST)
Date: Mon, 31 Aug 2026 09:14:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20260831071444.GT687043@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
 <20260829084901.GA776954@noisy.programming.kicks-ass.net>
 <apLxcg3Lgy0-nXA4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apLxcg3Lgy0-nXA4@casper.infradead.org>

On Sat, Aug 29, 2026 at 03:49:22PM +0100, Matthew Wilcox wrote:
> On Sat, Aug 29, 2026 at 10:49:01AM +0200, Peter Zijlstra wrote:
> > > On PREEMPT_RT, it is necessary to skip the call to
> > > alloc_pages_nolock_noprof() from under pi_lock, since with that
> > > configuration spin_trylock can end up needing to take pi_lock. But at
> > > least on !PREEMPT_RT, there is no risk of deadlock.
> > 
> > Yeah, which puts the lie to that horrific hack Alexei did. We should
> > probably teach lockdep about spin_trylock() not being safe and see the
> > house of cards crumble.
> 
> Why is spin_trylock() unsafe on PREEMPT_RT?  It's not intuitive since
> one can mutex_trylock() in interrupt context or under spinlock.

We should not be able to do mutex_trylock() from interrupt context.

Because then we end up with an owner that is not a task, or if we
account the interrupted task as the owner, idle that owns a sleeping
lock, which also leads to problems, such as trying to boost idle and
other such nonsense.


