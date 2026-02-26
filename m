Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2E3290A9
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126556; cv=none; b=KBycpG3knUi0NCFs5L8YCFHG7aakX36WnMSXLw98wwEGdkblLYc/L9T24VpEy2jdqNks3mDW7o6bQfyTWTDo+6ciDGr2blwuNC2COgd0ubcCVs62pQk8KTBZD3RMJEujImW3xVRcgACoLGYxkMIevJYkNlcZWFfUwU03Y06lW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126556; c=relaxed/simple;
	bh=o9vWMyBliQyQ+A8bEk8Q/o/j03TtkCkjarYpD+jNokA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeoXc4qHQ0Wp70kKNIG9o8q1hpgGkqM86aykMvDi3sV+E3trJa8Yhz2UAKBJbRiFj1F+gIrrjlfO1c8PDNk03nQgPAcjAjD1X6lvwWln3sCqyGk2Rhmv+jPKG2ubXVhgIWUKbZscI9INbF7+B/3I+um5kHYBhS9HqFf1k9f2RcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 299D414032E;
	Thu, 26 Feb 2026 17:22:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id B358720010;
	Thu, 26 Feb 2026 17:22:29 +0000 (UTC)
Date: Thu, 26 Feb 2026 12:22:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Linus
 Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260226122252.184254cd@gandalf.local.home>
In-Reply-To: <127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
	<a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
	<20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
	<20260225194809.1f5e44a6@fedora>
	<127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f6jkxrwg9re4g8aisfa6hti41czgizk4
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B358720010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19++4HcvRydBxndeC7Y81kb03K6gs8dZBo=
X-HE-Tag: 1772126549-928997
X-HE-Meta: U2FsdGVkX1++p7EZmPH7sShGBxnTpi5IWNzu7VLNbLCTs8X3fOkxnGso/Dkha1Nx4qKVxNBjAczadw0cg9Qj8oYxFbfCPKI93zBFncWyrrW9Inf4lzAsueaFzdMwWidsDdLyaZ++Je6a/W1sxdJv/zKomfqSQVa0QT7b9qpPhx2XGZD2uFiZay6CuVho8KYp0lVjz9IRWKJAwHEBMlrg/UC2Y/rwP23zn0qmB7Pv3KMQ7VgQENed59FjRIS2ZZgK0dQCheiS3KocPYOwHwGxooOSauZ0QCqjCdJDtRcFjAfw5NlaX2j1AO4sili5X4g103DdXzyfy8mqrnXRYqqZwaF/EEdJGusBPJ4XbvOvpL3YCmuw4h9zTJT7uMoL1zZHyL5MNgUCvob8iI+lPTRcXQ==

On Thu, 26 Feb 2026 11:00:14 +0530
Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> On 2/26/26 6:18 AM, Steven Rostedt wrote:
> > On Wed, 25 Feb 2026 11:53:45 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> >> Oh, that reminds me, Steve, would it make sense to have
> >> task_struct::se.sum_exec_runtime as a trace-clock?  
> > 
> > That's unique per task right? As tracing is global it requires the
> > clock to be monotonic, and I'm guessing a single sched_switch will
> > break that.
> > 
> > Now if one wants to trace how long kernel paths are, I'm sure we could
> > trivially make a new tracer to do so.
> > 
> >    echo max_kernel_time > current_tracer  
> 
> That is good idea.

Yeah, I think something like this should be added now that LAZY will
prevent us from knowing where in the kernel is really going on for a long
time.

> 
> > 
> > or something like that, that could act like a latency tracer that
> > monitors how long any kernel thread runs without being preempted.
> > 
> > -- Steve  
> 
> With preempt=full/lazy a long running kernel task can get
> preempted if it is running in preemptible section. that's okay.
> 
> My intent was to have a tracer that can say, look this kernel task took this much time
> before it completed. For some task such as long page walk, we know it is okay since

Tracers can be set to only watch a single task. The function and function
graph tracers use set_ftrace_pid. I could extend that to other tracers.
Hmm, that may even be useful for the preemptirq tracer!

> it is expected to take time, but for some task such as reading watchdog shouldn't take
> time. But on large system's doing these global variable update itself may take a long time.
> Updating less often was a fix which had fixed that lockup IIRC. So how can we identify such
> opportunities. Hopefully I am making sense.

Not really. Can you explain in more detail, or specific examples of what
constitutes a path you want to trace and one that you do not?

-- Steve
