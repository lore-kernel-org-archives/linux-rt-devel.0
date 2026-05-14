Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA973B9D98
	for <linux-rt-devel@lists.linux.dev>; Thu, 14 May 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767393; cv=none; b=pKPE2kKpDdstbymeFd3730trBu3rPsstr6kZnsyYIuia0r9bubHToywzGR9IYoCuBwP63SRKraBtmU3vqTTAZBhmFecd6TTx1QvTgF8t2J5x4nPqoIV8Ce4rD/VHTRkc2jjQzwgtTJuR6NXd0L7+AErAiHjmDD7qmWx5woYb1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767393; c=relaxed/simple;
	bh=4dgtp24w/ifz2MXIqkWveTTH9LDcFXwnbr3XcBvb5rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5WIIsstmVYcWSISiELvzVWJJRSMgx7aqT2XIK6QG1iKH7+qqxRT3+Q2P3fqhvy7GJYcacI6iZ0h3dHi2ZS7oNZKTJWTAVhsuzwAtVGtkeFzfZtZs6Ipzr4IoJJUIB59OZmzfqCb0ukYkpQ92ZURjct0vuwhwPjiHlx2kPOLOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 80B091205A9;
	Thu, 14 May 2026 14:02:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id E95A020029;
	Thu, 14 May 2026 14:02:54 +0000 (UTC)
Date: Thu, 14 May 2026 10:03:00 -0400
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
Message-ID: <20260514100300.1d594c7a@gandalf.local.home>
In-Reply-To: <agVUH-L503DwAiSW@slm.duckdns.org>
References: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
	<20260512172847.5024e5e8@gandalf.local.home>
	<20260513193914.1593369-1-tj@kernel.org>
	<20260513202432.18dd7b9f@gandalf.local.home>
	<agUdAatmlqQc1NS_@slm.duckdns.org>
	<20260513213108.2870a1e7@fedora>
	<agUodtxEi24HQ1Oo@slm.duckdns.org>
	<20260513220136.5a11c740@fedora>
	<agVUH-L503DwAiSW@slm.duckdns.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E95A020029
X-Stat-Signature: io689kdtgyxajypz1t8rpm7dwhj1miwt
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19KhBgS9pq3fT6x8+ows0b15Ra5CBzTS6A=
X-HE-Tag: 1778767374-902110
X-HE-Meta: U2FsdGVkX1+SNEWFUrQykZVtVR1VNUSkQq40av+MMAAwUmRo9b8vfla5B8mXzpEyny9k5rRIhoD3lQ8C+3v3fxCm2WH2fUNxuDwpXiFSSOA867xbS05yUxwn/TC1IRf3OAhFkI36QOF7YO4qh/nsK7SAGmEy7gtKGBOuzvXuBXQRnb4erETK1QQANWUYB5ALoCKAnz72L0nEYLiLXwx99lEdVpJHVLMtDXMVKIqhiC9LTZpn1vwBUVd04hlrxgV2NxgStpLODicPTe70dTCE8BIZTqOQZhUtgbhWU78Ot3wCOfC644uvLKKI/gmcWGnC95z9Fx+6mrIALG5fUlLtpydRUU1CEo2w

On Wed, 13 May 2026 18:48:31 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Wed, May 13, 2026 at 10:01:36PM -0400, Steven Rostedt wrote:
> > I could try, but there are still some things that I don't understand.
> > One is that to send more IPIs due to the RT pull request, there needs
> > to be RT tasks constantly sleeping. Is that happening in this use case?
> > Are the softirqs waking up RT tasks that run for a short time and go
> > back to sleep, causing the pull IPI to trigger again?  
> 
> Ah, yes, that makes sense. That's why the repro is using FIFO threads too.
> In prod, there's mpi3mr threaded irq handlers that are FIFO. These are
> storage machines so they're also constantly active.

I was thinking about this more and does disabling the RT_PUSH_IPI cause any
problems for you?

  # echo NO_RT_PUSH_IPI > /sys/kernel/debug/sched/features

The reason I ask is that I'm not sure he RT_PUSH_IPI even makes sense to
have enabled when CONFIG_IRQ_FORCED_THREADING is not enabled. The reason
the RT_PUSH_IPI was created in the first place was due to a kind of
"thundering herd" of taking the rq lock of the CPU that has an overloaded
set of RT tasks on it.

When RT_PUSH_IPI is disabled, instead of sending an IPI to the CPU to do a
push, the CPU that is scheduling a lower priority task takes the overloaded
CPU's rq lock and will try to pull tasks from it.

The issue that RT_PUSH_IPI solved was that if you had a 100 CPUs all
scheduling a lower priority task at the same time, they would all try to
take the lock of the overloaded CPU. Only the first one would succeed in
pulling a task. The other 99 would finally get that lock and see that it
has no tasks to pull from. I found that this could cause 500us of latency
or more.

That 500us mattered a lot for PREEMPT_RT, but doesn't really matter if you
have softirqs running uninterruptable and for 500us themselves. I'm
thinking that we could just have the following instead:

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d..0a4f4a212cd6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -829,8 +829,14 @@ static inline int rt_bandwidth_enabled(void)
 	return sysctl_sched_rt_runtime >= 0;
 }
 
-/* RT IPI pull logic requires IRQ_WORK */
-#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP)
+/*
+ * RT IPI pull logic requires IRQ_WORK and doesn't make sense for uniprocessors.
+ * If CONFIG_IRQ_FORCED_THREADING isn't set, then softirqs do not run as threads
+ * and can cause latency larger than what RT_PUSH_IPI can save, killing the
+ * effect of it.
+ */
+#if defined(CONFIG_IRQ_WORK) && defined(CONFIG_SMP) &&	\
+	defined(CONFIG_IRQ_FORCED_THREADING)
 # define HAVE_RT_PUSH_IPI
 #endif
 
-- Steve
