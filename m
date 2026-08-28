Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22693471D06;
	Fri, 28 Aug 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928316; cv=none; b=Op6sVEdLBa8AAJSwcEj9CUf4Vy6J5vA5FBOVE30w9wOv6ukDx1Jjp21HH2iKlNVwxeXjxEwfNY+PHW2rN0VH83xQgu8ZI2UBk0BwDn2qykd6HIRx9IvjsfKsARIedqIjFpzKR5xFaBc/ylX5VzUhV+RQPUPAxNjdsUaqGwW7jWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928316; c=relaxed/simple;
	bh=soZ9PL61goEMOkaDJT6p0gnMZMgrTdoK6hpq+e4lLlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlpK1GmrSkD4zqZRGZknmuJ+xXVFA12bSuJOOAlqNfHBisbWVBWNDat+iMEh589UI+GDWBkZ1xwmVJArpFcYblIpzOILM7KK2oP5z4plYXe+MydLSlhjrmz/tr6I+gJvvWkhMWsz8Jrnq0BNwbfY9jlrdrNmZlCHd+3+i1HMkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Au9yP3eB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Au9yP3eB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2svEyFOZsFh7Z9gUJnKXJmkUHjn+t2fc++fT9yfnVTw=; b=Au9yP3eB6i4vjvt53lDNHwLHlH
	7GVgsID/l2OoVPVxPQoAzsrTgC8xDr62Gl7PzX36y4pzO91NYooNY0VRMTX25aDzYsXrWhSrKBfD3
	eEknGtS+cIS2Jfadq9c5/IK4QycHdXAqPY9FFegcrduJNbHVrhcWLe8n2+/j92MRChzgCnB+QWMLc
	kS9VFW/sxoqKApZL2rhQ7eCkQjZcGfK+3oIXe6z752aOnqF9Fxgl/p5zCePvciTBNIXYBjU26qejO
	l16qPsRAMGjpvTTFFhkVoUX+1zgiHnca29azGuoTY/oUB/KYztdt9eCJlLUFx8X7gHVqh1JO7kz5T
	BFCChTlw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzxpF-0000000EqNL-1I6b;
	Fri, 28 Aug 2026 14:45:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C4B2930116A; Fri, 28 Aug 2026 16:45:00 +0200 (CEST)
Date: Fri, 28 Aug 2026 16:45:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	jstultz@google.com
Subject: Re: [RFC 00/10] Reclaimable kernel stacks
Message-ID: <20260828144500.GW776954@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260828124758.GP687043@noisy.programming.kicks-ass.net>
 <20260828103328.633bbfbc@gandalf.local.home>
 <20260828143540.GV776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828143540.GV776954@noisy.programming.kicks-ass.net>

On Fri, Aug 28, 2026 at 04:35:40PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 28, 2026 at 10:33:28AM -0400, Steven Rostedt wrote:
> > On Fri, 28 Aug 2026 14:47:58 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > On Android, system processes typically have 2000-3000 threads. App
> > > > processes add 1000s more threads on top of this.  
> > > 
> > > WTF ?!? Why does that all spawn *that* many threads? Perhaps work on
> > > reducing that some?
> > 
> > I guess you never ran Java ;-)
> 
> Of course not; why would you want to do something that silly ;-)

I realized I actually have a Java thing, the kids have Minecraft, so I
booted that up and I found all of 108 threads. Which is still kinda
insane, but nowhere near the 1000s per app as claimed.

Reducing the thread count from O(1e3) to O(1e2) would win far more
memory than any thread stack shenanigans would.


