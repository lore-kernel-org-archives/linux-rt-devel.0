Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34B382F14
	for <linux-rt-devel@lists.linux.dev>; Tue, 12 May 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621339; cv=none; b=nCMTK6b3nMmUlZlvMuvTsQhm7rrXqPoHHmgRjpRXy0IEr0bnz8EHHUPR3ih0nsUCP9RD8oqfV7eqxGMPVGvZSyMwSShdEEXDJWbzC3eNmNHib6Fkvz08VI1EI7iwGVdmMHPEqQYmLRNi2DZqVK7tuTSmGQCWVjNFvqmdBk0T0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621339; c=relaxed/simple;
	bh=4C6pvIOAVQbukdwjKbK+qiW+/2zL51bFxyPW5XZJiyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBFsaiKLAnAiSV7impVwrMMvEivu+qObzr3F49a84WqsZb6VcdXRBvyIoS7FYsf/cSdCb6GC7rrtoplbwQMNEQtYskuz5VGMa08z2DVbtshgCO00Ro4up4CwDpfbmDq1s2ub6wPPWHZA0GyrqBO2rYCxnqqeIgH2y2hvCcj8xhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 93792140604;
	Tue, 12 May 2026 21:28:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 14EBC6000B;
	Tue, 12 May 2026 21:28:50 +0000 (UTC)
Date: Tue, 12 May 2026 17:28:47 -0400
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
Message-ID: <20260512172847.5024e5e8@gandalf.local.home>
In-Reply-To: <056f95bc5805f7e161458984fff4b3cb@kernel.org>
References: <20260506235716.2530720-1-tj@kernel.org>
	<20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
	<20260512113754.448c1f5b@gandalf.local.home>
	<056f95bc5805f7e161458984fff4b3cb@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 14EBC6000B
X-Stat-Signature: 8qy5uhfwsxeapkmuuepq1oazmbkn8p8b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//6atTrnTg2GrIa9eEi1vvCQ3Nm8vM5uI=
X-HE-Tag: 1778621330-773637
X-HE-Meta: U2FsdGVkX19tsj67avr6NdZ5Fn/QWcaOKZ5UlYE0wn9jp9KehtkYY9VbvhkeEymnFHFe916J3Qr4L1b3DwQBf1Yc10Ss8h9VknViUKxANUwMlgwaQO2/wdyFjYLud5aAEhSO4gaJNwqr4JARx+AZmGYrk5SejYJhVX3gnwMdLFQVKbDbBFrDFuoXeqOSlwT1pX98HWhFknjwxQi3+EcPlLwA0AQOT/TbzLQx6DFCJ8DC8UPMzD8PHl5xqDPVTc7it7lf11YexmyveFTql6qvfJYRvuNp7T3Vee6vK2IGq/BWAKgfV1UvAnjDvR8Z9Zy/PDyuG0jsLVxWMzcFtCLY5w7T/4Cd87kP

On Tue, 12 May 2026 08:07:58 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello,
>=20
> Looking at 49bef33e4b87 ("sched/rt: Plug rt_mutex_setprio() vs
> push_rt_task() race"), the prio bail looks like it was already there
> and only got moved up to retry:. For non-migration-disabled next_task
> the bail fires at the same effective point both before and after, and
> rto_push_irq_work_func() + rto_next_cpu() were already in their
> current shape, so the loop seems reachable before the move too -
> b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration
> instead of pulling") looks like the actual origin.
>=20
> Am I reading it wrong?
>=20

No, I missed the movement of that code. Which means I need to understand
the problem better.

I'm still wondering about the trigger of this. That shortcut means the
current process is of lower priority than the waiting tasks and a simple
schedule should happen. From your tests, can you see why a lower process
was running on the CPU instead of a higher priority process?

Also, the IPIs only happen when another CPU is about to schedule something
of lower priority where it tries to pull a task to it.

=46rom your description, you are seeing a storm of IPIs from all these CPUs
before the first CPU could return from hard interrupt and schedule?

I'm thinking there may be something else wrong here.

Note, the RT_PUSH_IPI logic only has a single iteration happening. If it is
happening and another CPU wants to do a "push", it simply ups the counter
to try again. It doesn't send another IPI.

Do you have a trace that shows what is happening?

 # trace-cmd start -e sched_switch -e sched_waking -e irq -e workqueue
 # echo 1 > /proc/sys/kernel/traceoff_on_warning
 # trace-cmd extract

may be enough.

May need to add some trace_printk()s into the IPI logic code too.

-- Steve

