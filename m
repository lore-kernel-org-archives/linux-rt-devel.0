Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826A25743B
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380710; cv=none; b=soL3kQu9JSHGVQMSNVA5lws4A4gSGOkU5Ymb9737kPs32sOAbHbeYAL2GQmrNh0jKrJe9a/3M5EO6vSvRRZqogAzzfP2IOnKvgruOe+JG/kC7EJLpjVVGmERHvaNqyVAUaP+rEAPAktcQgBoXTk+Oc08V8Gmj6mFlQ1mgbLrJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380710; c=relaxed/simple;
	bh=RsdHihflbagnLMjV2H74kIxdr7mggu+uHmIFkbWjxOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pldecL6O/+7YUF54HTd73djB4O8pCy4/BJZPE6JJEOneWVg1OmOzRVtOpLJpqqA9rqtDbCZkwPuO3QpLmJ0JDQd+cm9T7cTAmxCsTLZbOhotA/SHXSoch7YKWtjTH7q9cAqnB0p1y6l7cTr8zoRCby+1Wev3axAKnfbbYPwyrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C692C4CEE2;
	Wed, 12 Feb 2025 17:18:29 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:18:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212121837.3b25b941@gandalf.local.home>
In-Reply-To: <20250212170955.x1oRhNjr@linutronix.de>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
	<20250212114531.4e95ffe7@gandalf.local.home>
	<20250212165908.DoNnHJ5v@linutronix.de>
	<20250212120328.28fe4123@gandalf.local.home>
	<20250212170955.x1oRhNjr@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:09:55 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > Why not? It keeps the same paradigm as non PREEMPT_RT. Do we really want to
> > litter local_bh_disable around all these cases that spin_lock_irq*() is
> > used to disable bh?  
> 
> Yes.

OK, after testing that patch I see the issue. The local_bh_disable() makes
it look like we are in a softirq, and that triggers a bunch of
BUG(in_interrupt()) that are around the kernel.

Couldn't we make the spin_lock_irq*() also disable softirqs without making
softirq_count() return true?

That would keep the same paradigm between non-PREEMPT_RT as well as
PREEMPT_RT without having to litter these all over the place.

-- Steve
