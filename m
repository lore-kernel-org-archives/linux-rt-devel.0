Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D613A42B72F
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204003; cv=none; b=RElw2xZwNlwPjTvI1z81XvU4/Q10zIDw9IB5adwnWSkvYZ/RmrIl/xkUn7d/4Hct6R3hgTRPPSlP6H0IbdPQf6mhvmt+n5BsNdA9ENPr4xlagEhHCmEzsYaUZg4/UnUJObwosyLQ30zdTllgaNtmQjOPWpCUYIUMA5ej8TikByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204003; c=relaxed/simple;
	bh=RLZiFHzht4vT3BQiUN7tP05j7C+BhyPxvTzrkiY7+Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXKzuAQZuTI0wY6zs8fioRlZEEv+n5U7oA8bYhaNRKtZatR0oKldevaLrQBIHb0xeedvDW3Vj3bj8Fna5AvmaKDo+KC30kpvVOv8v/fChSZtpNW63dxYVWIt8hLgsRj7tgNMc0Vw1o2tstijbq4Sw8kKHSsy+EMjhV0Ur+rpdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 453A3C0E8B;
	Fri, 27 Feb 2026 14:53:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id C157120030;
	Fri, 27 Feb 2026 14:53:14 +0000 (UTC)
Date: Fri, 27 Feb 2026 09:53:34 -0500
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
Message-ID: <20260227095334.40768d0b@gandalf.local.home>
In-Reply-To: <97dd1a4f-e524-4337-bcbb-9cbe4bfdda30@linux.ibm.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
	<a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
	<20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
	<20260225194809.1f5e44a6@fedora>
	<127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
	<20260226122252.184254cd@gandalf.local.home>
	<97dd1a4f-e524-4337-bcbb-9cbe4bfdda30@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4yp7u5e55n59q3atzm5hrbf5er9fz1wn
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C157120030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/d/UB7p8/PGzgFbactOkJDV9DFbL20fqM=
X-HE-Tag: 1772203994-516703
X-HE-Meta: U2FsdGVkX19hxhwE+MLoq1Hsn9Wh8XHUkq+cFbFuYh8LIqV5ee2BuMJNw2ojZyehN8TfGsbf8BdCDnFUkLBXAOSoeHVlB4y4xWylGJLXUwry5ANR4bQgO8oQ2tzP/8nQ1oe3Ygoqo6XZ6PeDdedpdsr6YXRpRNSLtu5W7PsCW5edzqe+zeZeG4apa4IeRCaSsK8ACFc58pOtXL2+Y8RdCSVnd6Jx4Ywt5AI/X/aQ8g1+DlMAubuIYp08QROtaXNpdt9ljjx+l9izIMgVq3jZBAAJkqtDXxK7HHgKyEIUvc5EHKjYLyzFUtgn9dlRzpIXDrxaSreyBmnqnIo7pElQt4bpXo1HyzUi

On Fri, 27 Feb 2026 14:39:42 +0530
Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> I am afraid we will have trace all functions to begin with (which is expensive), but filter
> out those which took minimal time (like less than a 1s or so). that would eventually leave only a
> few functions that actually took more than 1s(that should have limited overhead).

Well, I think the detection can be done with timings between schedules.
What's the longest running task without any voluntary schedule. Then you
can add function graph tracing to it where it can possibly trigger in the
location that detected the issue.

On a detection of a long schedule, a stack trace can be recorded. Using
that stack trace, you could use the function graph tracer to see what is
happening.

Anyway, something to think about, and this could be a topic at this years
Linux Plumbers Tracing MC ;-)

-- Steve
