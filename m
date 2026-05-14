Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD931A572
	for <linux-rt-devel@lists.linux.dev>; Thu, 14 May 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722281; cv=none; b=a+8ioK1/DomCl/G5PMTyznDBoPKYtLJoPnG/gB6DUSOSuwQE7ltgeLad8V5wOciAzFePI3wulcPqFFX+qf4Au4Iyo0Vcrc8N1msiB1G/ygl60Q/OFSuGGFOfHA7fcQ0vltMECUWBsAWIvFBbscOy6hYXwl59LSU/kJHZRjyzyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722281; c=relaxed/simple;
	bh=Dk/eNmIh9Hdp+iA0K555dAd9uFQ+LzHl6uX/91q+8j8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGTtW0p3sL+juhNYBnLquIPXDpYFBlKc89y1AgquVzSBOBr+3jY+49lvXyhE214jbw8yapUgBIakmSLqVXm8qaPXuR3x7pX9BkSYSjNWIvKD5MMb3RScb5ov5iPIyA+QDYAHNB94bJCp7DGWRUJmYBsr4hLNq/2RlFyfTT+zD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 847FF12023B;
	Thu, 14 May 2026 01:31:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id A22246000F;
	Thu, 14 May 2026 01:31:12 +0000 (UTC)
Date: Wed, 13 May 2026 21:31:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <20260513213108.2870a1e7@fedora>
In-Reply-To: <agUdAatmlqQc1NS_@slm.duckdns.org>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
	<20260512172847.5024e5e8@gandalf.local.home>
	<20260513193914.1593369-1-tj@kernel.org>
	<20260513202432.18dd7b9f@gandalf.local.home>
	<agUdAatmlqQc1NS_@slm.duckdns.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9ku7n9w1yp6udfp13tk7cibz3k83cxuh
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: A22246000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+iN2UnIt8ObgSa+1TgJ/oIToAwtayOVoA=
X-HE-Tag: 1778722272-969880
X-HE-Meta: U2FsdGVkX18AfKVVq0rvEBkWoVussd8EL1vmybfyac1SJ5CO222Xh17qtKe6DlMb8rzEdsD1lmYHynEgeXBhtNAkARlKt9JFVpbEhrgZGCYTNMusgEgpCEDiN6qd04Ls5Mi/d5AukYqTh9+PJKKW1RPgTO8O82UaxvT1ZroNRcMNRMOtn7WkEyEufkEie6OqLloJX9ercBQdwEEixBdVRkm+n2facEFNO6Vntn4Oldun8n7jZPHs/wKFZXcFDeIfNZXi0iG96QSJd5xsLWjYeoORaX+Krzvjo5t7UdUHHz7Mf2GdKI1jeVPjPql+cuBAU3fflkTgKU8NIR7YdXEYH4jVoG26NPYK

On Wed, 13 May 2026 14:53:21 -1000
Tejun Heo <tj@kernel.org> wrote:

> > This still doesn't explain to me why the current process is of a lower
> > priority than a waiting RT task.  
> 
> 1. The CPU was running a fair task.
> 
> 2. IRQ triggers which creates softirq work.
> 
> 3. Either IRQ, softirq or another CPU wakes up multiple RT tasks to the CPU.
> 
> 4. The CPU enters softirq.

OK, this is what I was missing. The fact that the CPU was running a
softirq at the time that was running for a very long time that prevents
the schedule from happening.

> 
> 5. Other CPUs keep sending pull IPIs, slowing softirq processing.
> 
> 6. Before softirq processing finishes, another IRQ happens which creates
>    more softirq work. Go back to 4.
> 
> > I'm really starting to think you are fixing a symptom and not the cause.  
> 
> It seems relatively straightforward to me. The CPU was relatively loaded
> with irq/softirq. While in irq context, RT tasks wake up to it and then the
> CPU gets hammered by pull IPIs to the point where it's constantly chasing
> new softirq work and thus can't leave irq context in a reasonable amount of
> time. What am I missing?

So if the current task running is SCHED_OTHER we still need to handle
the case where the next task is pinned, as it will cause a warning
again if it tries to move the fair task, especially since that doesn't
fix the overloading.

I think this requires a bit more complex fix. Perhaps if the current
task is fair and the next task is pinned, it needs to look for the task
after that one to move.

-- Steve
