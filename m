Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E531CF7DD;
	Wed,  2 Oct 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884425; cv=none; b=mc+VFnuhiCkwAVlqgijGlK90eDF1LgkjgyrqpBrWP7U2AiaWV+0BoK+QpDFY6FuW7DOxAWQj2X/4+rGwv1Pl0vmWDrtERZnP49yDvYzY6RvXhOzH+SavcFI0oHWKvpFybKfAc8Bpy1HCArqv2+AcSWH2Q/DWeXtMiI9JYxW0mw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884425; c=relaxed/simple;
	bh=UjwGjALvm7A6c8F3TZCQwyNJIpsdLssL7FKveZ1VTuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucG7Ibr/F5dqcPYTmJJvgOryDE1+Cpsrg9fD4LJ1GROFlPF9QHzdQSkmtntTOVnnGaq4SVnd2HmJjBVNeTM3S2l0n8afjBItQKgy72wyh4E1y2/EzRWH9+5CUMheyi6Puay7jh7SFqxO6FhINdJkBlj0ZBEilpRXm44/W0uTAas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17151C4CEC2;
	Wed,  2 Oct 2024 15:53:43 +0000 (UTC)
Date: Wed, 2 Oct 2024 11:54:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ben Segall
 <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, Valentin
 Schneider <vschneid@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Repeated rto_push_irq_work_func() invocation.
Message-ID: <20241002115435.4e618a8e@gandalf.local.home>
In-Reply-To: <20241002153500.UVq2Zn-J@linutronix.de>
References: <20241002112105.LCvHpHN1@linutronix.de>
	<20241002103749.14d713c1@gandalf.local.home>
	<20241002150543.IhYy2Q9k@linutronix.de>
	<20241002111920.12cdc78e@gandalf.local.home>
	<20241002153500.UVq2Zn-J@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 17:35:00 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > Hmm, I probably should look deeper to make sure that anytime a schedule
> > happens where there's overloaded RT tasks, it tries to push.  
> 
> I think it tried pull on schedule but then it got outsourced to push via
> the IPI with this new code. Don't remember the details 

Pull is much more expensive than push. That's because we keep track of the
"cpuprio" which is the priority of tasks running on each CPU. To do a push,
you simply look for the CPU running the lowest priority task using the
cpuprio logic and send the task there.

For a pull, we have no idea which is the highest priority RT task that is
waiting. We originally did a search of all the CPUs with overloaded RT
tasks, but this search takes way to long, and since it's done in the
scheduler, it caused high latency. Which is what the IPI dance is trying to
mitigate.

-- Steve
