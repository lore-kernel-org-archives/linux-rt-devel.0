Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B95371880
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932728; cv=none; b=iLGpTqNAhgfW/HeIKsRXMROsas0iIKbH0tmvtzgjJQDkSgdUJ/+VL5oRiQscNm1q398zMXiiyfk1LvHZq/+LddSHm8BLNgN5fPRowNEpGaqOD5hyvO8NgIlUipiRIsoeZ5jdfgV6gNdV3DIkXzKDDpPCATgNNc+j8u+whqpZe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932728; c=relaxed/simple;
	bh=x5IFlUG3Gp1H70vRS982SS1fEJ7RE3Giv2Qt4O6gvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR/lC3siGwrQrCXx9LuO+49E0iZ076SZGtrsZat1e7jbtJar0W4TM0G+6xBiubxa7uyPEdDMNb6vKgat8NTbR8wcsUcLi96NDWd2ryHCdoDREmOvl9Sgg4eNnhXpIjqrcrZq7/iCIdvIkairAM4DL5L9HgAYIdBvPSeGA6siYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o2SzTzUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eit7LjiA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o2SzTzUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eit7LjiA"
Date: Fri, 28 Aug 2026 17:58:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787932724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MjQ31cfuQKa5k82uaGT/Cyx34wNELqTN6/K1Rh0XD+c=;
	b=o2SzTzUsSOuV/AWS4fKiiKyn/1LhaPYC6Yfdi9fN77edZ6oncnntoZNhDlY+g5FN0uIwEw
	zDLTrEojOcnJRJhRQAb5HCWHd7BbTk9sIN0zPDHE7URywDDDKInIzLBonFQjkJNHVimBoL
	kWzGMCLwRRmRuqGEMRRmC+06LriM6fJe9MbsK+pBSojb6eX8G3SqLu20XaIhwBNbTl5OoI
	9/FFI5P8JkXnl0wGKMTDSeUYaukHKz3pwoo7a0R18G6ypphqw6MC2H45rnhcZbOQ/ClAs7
	vMj0j3h3AzvP+zmWK/m3B+PnqHU7/qIvx3PIK31jHYeE3+dcsciApSaUFtlioA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787932724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MjQ31cfuQKa5k82uaGT/Cyx34wNELqTN6/K1Rh0XD+c=;
	b=Eit7LjiABhdeRfzT4glURHG1RCeV2ZAjuv33J9ECHEaXD7arcRHH/58kzIbGZWU8KSPYLR
	Vh8qqix9q1P5ueBA==
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
Message-ID: <20260828155842.kIh5T7iS@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <20260828142552.GN788244@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828142552.GN788244@noisy.programming.kicks-ass.net>

On 2026-08-28 16:25:52 [+0200], Peter Zijlstra wrote:
> Taking faults on the task-stack is not going to work. That fault will
> happen while you have locks held and IRQs disabled. Ideally, it'll
> happen when you're knee deep in the allocator.
> 
> That fault will then again call the allocator to allocator your stack
> page, and...

indeed. So I do have a few ideas floating around but I leave it at it.

Sebastian
