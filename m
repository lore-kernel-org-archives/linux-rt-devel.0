Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9846D43F0AA;
	Fri, 28 Aug 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918673; cv=none; b=rUo4hykyB4BKqoJP8gTKg59Lf8dtm8+XrgEtgGfjrcciTEN9nqZa9e8B+xm7qv0OSQoQgTkHhe2v/Kj3eFQA8RlDW46CPMUl8iJvcd6L+5ymy8zB0croKok9mmtveuwDzmnCYqvi4h+0JkpTzpHOBJ029lyngxFe1z4D7j7yH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918673; c=relaxed/simple;
	bh=y6MS7RW2QFwTyTrqrzjVFQkghDAB+ao6TxdiVe2xvOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJmxDKHIAMnrNamwq4xL7YHSdhaH2LLabkatxPgqpbobYMBPCy7qUN0iqzkh9axS+X8REBol3LgRm73fl3Zl42yC1qGvkIXOjQL6ViuvzA29MdBaejTNFD+Uqt23bxNzXM5QpHVEyeazIf4gcdGYdOL823aj89doN5VWUjj33KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g+U/AXhX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+U/AXhX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=StE6yv7xm+286I4g7RWcb83gyYNv11/og1VLCuJGGrg=; b=g+U/AXhX8u1eDgBpqdk1xR7ga/
	Kt2hts3Z9eGty/byZBIGMnrQhk/z73YD7BnlLXJwvr6ynDNUvl0iUhKu+cG2shbEd3kuLi992Vcro
	vmMiuuboTD5xG7X9MClGy68OxbgmVZxEfM4tAgWp1DY+SGyMeUPMCpfN8bw9sC57YlIi3JTqGiFh0
	hUOoveqNeQM+T12KwEUktnDJFQ4VMR3Wl6HGEQ0el6HwnDTxlhplPqU0nH0qLgaMIoFPXlLLWNOEy
	xxvq5k4GVM+EAGtMijScxqO2e+VjpG5pl9SoXYrzoimnOXM4XI/KPJcx4fglBC4lXtT0B/Y+oGdS8
	GioRT/cA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzvJY-0000000EeNr-2cYx;
	Fri, 28 Aug 2026 12:04:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2AC2230030F; Fri, 28 Aug 2026 14:04:08 +0200 (CEST)
Date: Fri, 28 Aug 2026 14:04:08 +0200
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
Message-ID: <20260828120408.GN687043@noisy.programming.kicks-ass.net>
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
> @@ -4320,8 +4319,18 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		 * A similar smp_rmb() lives in __task_needs_rq_lock().
>  		 */
>  		smp_rmb();
> -		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
> +		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags)) {
> +			trace_sched_waking(p);
> +			break;
> +		}
> +
> +		if (!ensure_stack_is_present(p, &need_deferred_repopulate)) {
> +			WRITE_ONCE(p->__state, TASK_STACK_RECLAIM);
> +			do_deferred_repopulate_wake = need_deferred_repopulate;
>  			break;
> +		}
> +
> +		trace_sched_waking(p);

Absolutely not; ensure_stack_is_present() must not call
repopulate_stack() while holding ->pi_lock. Not happening.

