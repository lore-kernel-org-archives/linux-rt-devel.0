Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31992472777
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929824; cv=none; b=YSOCt2KnGem7z+qhMM7X60ssh0RXcepYQxVO3sgJV8UiYs+7HIbkHAfed8jGBCOjIQMwPSclSQQNBY7iIN5oIjZe5DlHlJnudRi332/AQpiim8KuBjfmlbw8y7RnnE/pna5UuMQFgZej7CJfYSlSwofP4P+W2A1734pl/+8T/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929824; c=relaxed/simple;
	bh=HUCJAHpdxO3SqP8mncblfqGC9JyCR84Ecpg3rTGRQn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOXb+yt8RpxiYC+DyQwM7bGB7wb52hpDNTOmQ4ILAkc0eOLPeV6arxrYMMoukc0ckDBOX7DaAOQC+jdn9M3pOGQFHObdMhQEFw8kCjXpPGOZhHXr07u4B+0P1bhNUO+cVt7eV2C1lBSMsOPk1EZmBb3+TtCehtd9tSjYdFarpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1yC3/1T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BPKwfdr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1yC3/1T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BPKwfdr"
Date: Fri, 28 Aug 2026 17:10:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787929820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txJxc7ggr3poI2FLO7VfIUDXdgIFyMuKHMC/a4AMXzQ=;
	b=k1yC3/1TSLVucW+G2hOymttYJNyxemcF0Wij24KbbvzrWJWTl2dTj6e6PoI5S0HrfHyPXp
	oI4RGa6W3u5aoEJG/2uXG7Yr1esVzqcii9kIAcVvca2UlTbIgjnuyFklJJzrTKZXRqX+fu
	ejgAg7ZLLzBYuFgz7MtDzaMLtFU/HLtc0BAfv8hKr3HpJsrtlz2g3lJ/Sqlfh3LdKWrn1S
	GTsJ4NmbyXAzkDLkFbgBjQNfoTov42PXv67fjZOSlBNDbwHx3Uq0FYD8NUjYTI3ReNlsL6
	lO/wJgykH2TvEmnn79Xfqs7ZjEmbXcCqXW/IiJFI0ER3lTMAlcw/3g0ZxDwYLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787929820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txJxc7ggr3poI2FLO7VfIUDXdgIFyMuKHMC/a4AMXzQ=;
	b=4BPKwfdrdUNYh8LjOXHLTIAFqeXqMCtM1JBZhaIPoExx/1SClqrf3LjHhwWJfGMIRfuC0h
	PrxrqZaP9E/FVKAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20260828151018.HnR9xV1N@linutronix.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260828135947.GU776954@noisy.programming.kicks-ass.net>

On 2026-08-28 15:59:47 [+0200], Peter Zijlstra wrote:
> > > +
> > > +	  The wakeup latency of tasks with reclaimed stacks may increase,
> > > +	  especially while the system is under memory pressure.
> >=20
> > It says *may* increase and on RT it _definitely_ will increase since
> > there is a kworker involved not to mention the memory allocation itself.
> > Anyway. This either needs to stay away from PREEMPT_RT or find a way to
> > exclude at the very least mlock()ed tasks.
> > Did lockdep see this?
>=20
> It should have. They're taking spinlock inside raw_spinlock and lockdep
> should very much warn about that by default.

Yes. My point was that this was hidden from lockdep.

> > If I understood the whole exercise correct then you have a kernel stack
> > of two pages and in best case you can unmap and release the second page
> > while the task is napping.
>=20
> THREAD_SIZE_ORDER	2
> THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
>=20
> that makes for 4 pages.

Oh. I wasn't aware that we have 16kib stacks these days. But looking
at it we have it now for over 10 years=E2=80=A6 Judging from 6538b8ea886e4
("x86_64: expand kernel stack to 16K") it might be temporary and things
are better now? Arm64 has a different story according to 845ad05ec31e0
("arm64: Change kernel stack size to 16K"). Risc-V also mentions "for
now" in 0cac21b02ba5f ("riscv: use 16KB kernel stack on 64-bit").

I just booted my XFS kvm box and did things and 8KiB works so far.

> > What might be a tad simpler is to memset(,0,) the remaining part of the
> > stack. Since the stack is vmap-ed it should be swapped out on its own
> > without additional tricks. That memset() would help zram to compress
> > better so it uses less memory. ta-da.
>=20
> That would still be a 12k memset with IRQs-disabled and rq->lock held.

Right, because the stack grew a bit. Probably still cheaper compared to
the other things done here ;)

> > What also should be simpler (and I am not saying just to move you away
> > from the scheduler) is to have a shrinker which iterates over all tasks
> > which are marked for reclaim and then similar to swap just unmap both
> > stack pages and release the second page which is not used.
> > Upon wake up the task should create a page_fault which would be used to
> > allocate the second stack page and map the whole stack again.
>=20
> Right, so you can FREEZE the task, unmap its stack and then thaw it or
> something. But there should be a definite opt-out on all this, because
> taking faults on your stack will be horrible.

Definitely. Not something for the currently visible app.

> Not to mention you'll suffer wakeup latencies while frozen.

Right but you would use it under memory pressure and steal the stack
=66rom the most idle tasks rather from everyone.=20

> This all really sounds like what should be addressed is this insane
> number of tasks rather than trying to cope with the consequences of
> that.

Sebastian
