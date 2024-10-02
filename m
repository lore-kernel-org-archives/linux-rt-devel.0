Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA71EB21;
	Wed,  2 Oct 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879819; cv=none; b=P+SHGd8feWeE1Zb8mMxHUn93sHYxI8J6U+trQjhcWUbiJIdzxc10v3oOTFqoCNCNiDHv8kCT1zNKc/7VIw/Zs1fWsaYgZvHSRVPn8jWoKYRAIPIo9vG0++NPnAu1C+thAkHhFgj1xDXT6FCK5z60dnFiaIdrohE3PSMmyyrTmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879819; c=relaxed/simple;
	bh=qRYAegFdAYkhuKtiBZJQWMuaYA3BD+Qsuj+kUakjM7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBPNgANG8i/9K/zdtqr9YTu0X/7AcHuFbf7nJQHkeRfoG+UM58625kN2BHK7R8/TQDXplrqpdx2jvFLad3w++VXIVaKauHSfeJgNllXhJ6ZM4REGp3GvjrfwdPfpABZAhxWlDly9haE3+ow/7XrmlDLSlPPcvO6TJgdC/2gQE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48255C4CEC2;
	Wed,  2 Oct 2024 14:36:58 +0000 (UTC)
Date: Wed, 2 Oct 2024 10:37:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ben Segall
 <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, Valentin
 Schneider <vschneid@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Repeated rto_push_irq_work_func() invocation.
Message-ID: <20241002103749.14d713c1@gandalf.local.home>
In-Reply-To: <20241002112105.LCvHpHN1@linutronix.de>
References: <20241002112105.LCvHpHN1@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 13:21:05 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Would it make sense to avoid scheduling rto_push_work if rq->curr has
> NEED_RESCHED set and make the scheduler do push_rt_task()?

Can we safely check rq->curr without taking any locks on that CPU?

I guess tasks do not get freed while a CPU has preemption disabled, so it
may be safe to do:

	task = READ_ONCE(rq->curr);
	if (test_task_need_resched(task))
		/* skip */

??

-- Steve
