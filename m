Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7D328243;
	Fri, 28 Aug 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921842; cv=none; b=kbo8zOHA00R9dn81a09zblKlQ1mEQvAnzkNQ7e8RSnpF2zOfP3YWR1s7D1T3673b/jZR4OKvHbibIw59kf22Y/h3dEq+kPcIhjCf2puJHf1ROCq8TMb/qBDrozIDr6TJXJCONbuEqzpPTlvBagIYRxNqW3TAQCD61f2AAhfvwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921842; c=relaxed/simple;
	bh=nES8lH77B+aFpP4B7r3qJxpoAExRq7bhWbrwvKyCwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCZyJnN8s/LEC+l3AMyo/U+8SefXOiWQlKNmyBKQVWqp3nNbNKGC9ECjNXxKzY4VFKQrsjOvL8qylfa/kB6IVdWtFBqlivJTFHPnaia+xpd0RV7eFZABWBJmsP/dz9IlcyyKdTmaHpsi23jNgmZX7i0VAB4bXgNjKd7CLuT1/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZBP0PlIg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBP0PlIg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qHN2OGlf9GRTtKA96vHo/h+pDHfL02/7NECu7KyWS+I=; b=ZBP0PlIgUBT5PXNCWPnT6ZNLza
	iqi8pjnn5U2zgxLE3/f1oPZ9VivUarl90IrtBOBu31xNSGl542Eh2cQMsbuXL8RhZI7DhRsskA9Ov
	9C4dP5+Pwos2L2HWhnCqdm9+DLYTiHOEm8b8L+wIALCO+s8eaRWQDHTNysdJS3RfEZmJ/Z2v+ePz6
	+a5Nb5uJOArtDnR8MEwaQG+AR1VGkPILsrjEtlxSAmpUHVbTu9adhmtvtwM2kOgyivnGev1wctlAd
	c63CCdNSci5tpTj6b9w2phQOg1GEBotE4nJuU+zmBShMnRddlInXXJyDYh+NPB3FJbKSJCWhodF24
	EYMbarmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzw8p-0000000Eih6-0Dlt;
	Fri, 28 Aug 2026 12:57:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A54630116A; Fri, 28 Aug 2026 14:57:06 +0200 (CEST)
Date: Fri, 28 Aug 2026 14:57:06 +0200
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
Message-ID: <20260828125706.GQ687043@noisy.programming.kicks-ass.net>
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
> +DEFINE_CLASS(allow_stack_reclaim, bool,
> +	     ({
> +		if (!_T)
> +			current->flags &= ~PF_RECLAIMABLE_STACK;
> +	      }),
> +	     ({
> +		bool was_set = current->flags & PF_RECLAIMABLE_STACK;
> +
> +		current->flags |= PF_RECLAIMABLE_STACK;
> +		was_set;
> +	      }),
> +	     void)

> +	allow_stack_reclaim(prev);

> +void __allow_stack_reclaim(struct task_struct *tsk)
> +{
> +	union stack_reclaim_state prev_state, target_state;
> +
> +	if (WARN_ON_ONCE(tsk->__state == TASK_DEAD))
> +		return;
> +
> +	prev_state.val = READ_ONCE(tsk->stack_reclaim_state.val);
> +	do {
> +		target_state.val = prev_state.val;
> +
> +		if (prev_state.stack_state != STACK_PREPARE_RECLAIM) {
> +			WARN(prev_state.stack_state != STACK_IN_USE,
> +			     "Reclaimable state %x for previously running task", prev_state.val);
> +			return;
> +		}
> +		target_state.stack_state = STACK_RECLAIMABLE;
> +	} while (!try_cmpxchg(&tsk->stack_reclaim_state.val, &prev_state.val, target_state.val));
> +
> +	if (irq_work_queue(&tsk->stack_reclaim_work->irq_work)) {
> +		/*
> +		 * Take a ref that gets released by do_reclaim_stack() so we don't
> +		 * have to worry about races with remove_from_stack_shrinker().
> +		 */
> +		get_task_struct(tsk);
> +	}
> +}

> +static inline void allow_stack_reclaim(struct task_struct *tsk)
> +{
> +	if (unlikely(tsk->flags & PF_RECLAIMABLE_STACK))
> +		__allow_stack_reclaim(tsk);
> +}

So you have a guard with the same name as a function, but the function
only functions when inside the guard of the same name. WTF ?!

Anyway, it looks like you're sprinkling this guard around a few specific
block sites. Which seems to suggest your PF_ flag *should* have been a
TASK_ flag, no?

