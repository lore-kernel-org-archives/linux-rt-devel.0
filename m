Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B31F12E9
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066897; cv=none; b=srPJTJF54UJs5qJalpP3IWUTMQ2MPfy4WSmiLuv04xuPvzOKaY+ytSn0urBzbK91DiKk/5+aRh7V2TkvvI0S/r5wf3vkecChDPzZvnTOfKmCGsjYS9z8mcVrUSUKgcLFVUxnR1C1qLlZYo2KPFuHoq9tR/ikd8KirzC3ssrPfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066897; c=relaxed/simple;
	bh=+nScr5O+8XN72KsthIHdBfbcTb5RkEHQc09X7joplhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrPhhs9zxUJrvelsoOtJAGIy8NTz43AHdwbzlMyZ9ITEGgr2fppXw8pYT/VP8cGyq7Fb54l7KYhO43RSb7AgF9i2m9xsPxzqiuBx4/9veF9gZdpk6jvpP4F/+GhvvvtbtdGRkYoEw8cl6iZdSoywnUer5Kc8Wq4zr1B0rKnRrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 540521402AD;
	Thu, 26 Feb 2026 00:48:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 6F0512002A;
	Thu, 26 Feb 2026 00:48:10 +0000 (UTC)
Date: Wed, 25 Feb 2026 19:48:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Linus
 Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260225194809.1f5e44a6@fedora>
In-Reply-To: <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
	<a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
	<20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: eh913opgghia1ai67mntnx7y3qsoyeyf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6F0512002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LmxV/qj/B89LDSV/0R5PkTrk0iwFxs90=
X-HE-Tag: 1772066890-966173
X-HE-Meta: U2FsdGVkX18Hf6RrxK3ZQAFIveO7+KKflbA0hChrE5zmj4PsZ2DcqeDR0MAojM1rEvL9V0Tzc8NtyrElDEp38SuV9ebmvj441F49DdkSDwEL1arFn7MXoUGIy1lwFUbhVXWjkFxlDuWMONRFHsc7BxS7EnHD/hLA94nE1qG0QunMOKRtaPrrV7c7eYVzISvSVeTy+lEqM9U/lt74ojUDdKoRvu+LjTgs9LOsj0Ua+Ttg1zzbsgGzBfBjZpWGRBukHOAxSq/NpmlcbBYefZiNVJxBA/wjGGHJuvf6cresgSDVKZHEAusDDHUZiiK/F3jzSYDSSEve27YCaB5Qa7dRZLoPyHBjUWa+8JwYwbJqEat0Ysx+Ylw7kKmtSMN4De13

On Wed, 25 Feb 2026 11:53:45 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Oh, that reminds me, Steve, would it make sense to have
> task_struct::se.sum_exec_runtime as a trace-clock?

That's unique per task right? As tracing is global it requires the
clock to be monotonic, and I'm guessing a single sched_switch will
break that.

Now if one wants to trace how long kernel paths are, I'm sure we could
trivially make a new tracer to do so.

  echo max_kernel_time > current_tracer

or something like that, that could act like a latency tracer that
monitors how long any kernel thread runs without being preempted.

-- Steve
