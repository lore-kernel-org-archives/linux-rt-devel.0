Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA3306779;
	Tue,  1 Sep 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264109; cv=none; b=dnSw1Vdx3dwneD/bdGDFNwQczAujzkhrGjJcSclLUtDBjaAB73cAtCMISigtU7+VjCcWIF4ox2ukqtUgv8/AhpXKQe0DUOfH08NS0uLeJoEwWJdaFtudlyT6eUcGopw4QqwGi+LClkYn+jD96sw6ZLqIv2GGER9Dr2is0b/T4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264109; c=relaxed/simple;
	bh=WVws5znW5mlkxwhkdSa9M683SecZ9NpvO7l8xTX9Q3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/gZJrfGtdVdscM+wKIL46sa7Ro+F5fcULcuCa/VKXnG1diangulTV/L9uTNZlIinBgIW+Yq6zXt6fr1ju5VZMaVvP+4seuFMX0D4OhNDlx/R85yXCjHTd5EkhRJD+mFximZyHra+IOXpzxYxCcKpobo5LS9gsyhwJUc3/8s8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNCIx8Hy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNCIx8Hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F821F000E9;
	Tue,  1 Sep 2026 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788264107;
	bh=UZeZ5z1io+JXvJ9SjEpRD3rg5z31zLq/vQ8rd29RbRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LNCIx8HyxE0C0GimP6YmdWgLiB61HFusPK9NlVs4pEdW6tXaSiLthMT19zo3zVt5o
	 Ny4xjCLyqoAD/a81rXEoo6DYlQ0vBjc647cjWj1LKugWyiJso8WoYF2GrZAX3yqEkP
	 /zSdQr1lcwLka1XKTtrDWcdOIhjoq8u0XAJmMZ7wkd7jVjlkZO2re7+Qpo/7Wl0ezt
	 1VZjC0Avsup3v6VcvQijMM1myhSYP5gfZUWQPW42wS/wa+W4oQqskwzmQMKhHfjnvg
	 oJSAoOpUW+uC53zJbe9IthmM/+B73Y252UlAbIuPjXr2h3ASy2P1hQtqnK1oo59jZ6
	 78ZdXpfDAWJwQ==
Date: Tue, 1 Sep 2026 13:01:37 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Stevens <stevensd@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
Message-ID: <apa-ocvQBOi8gy_E@willie-the-truck>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <20260828151018.HnR9xV1N@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260828151018.HnR9xV1N@linutronix.de>

On Fri, Aug 28, 2026 at 05:10:18PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-28 15:59:47 [+0200], Peter Zijlstra wrote:
> > > > +
> > > > +	  The wakeup latency of tasks with reclaimed stacks may increase,
> > > > +	  especially while the system is under memory pressure.
> > > 
> > > It says *may* increase and on RT it _definitely_ will increase since
> > > there is a kworker involved not to mention the memory allocation itself.
> > > Anyway. This either needs to stay away from PREEMPT_RT or find a way to
> > > exclude at the very least mlock()ed tasks.
> > > Did lockdep see this?
> > 
> > It should have. They're taking spinlock inside raw_spinlock and lockdep
> > should very much warn about that by default.
> 
> Yes. My point was that this was hidden from lockdep.
> 
> > > If I understood the whole exercise correct then you have a kernel stack
> > > of two pages and in best case you can unmap and release the second page
> > > while the task is napping.
> > 
> > THREAD_SIZE_ORDER	2
> > THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
> > 
> > that makes for 4 pages.
> 
> Oh. I wasn't aware that we have 16kib stacks these days. But looking
> at it we have it now for over 10 years… Judging from 6538b8ea886e4
> ("x86_64: expand kernel stack to 16K") it might be temporary and things
> are better now? Arm64 has a different story according to 845ad05ec31e0
> ("arm64: Change kernel stack size to 16K"). Risc-V also mentions "for
> now" in 0cac21b02ba5f ("riscv: use 16KB kernel stack on 64-bit").

FWIW, I'm hoping to make the arm64 stack size configurable on the kernel
cmdline with a view to changing the default back to 8k (assuming a 4k
page size). With 8k, we currently see some overflows in direct reclaim
(mirrored by a later stacktrace in this thread), but Suren has been
looking at ways to improve that (e.g. by moving it into a separate
kthread) which look promising.

Will
