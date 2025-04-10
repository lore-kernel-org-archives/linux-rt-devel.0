Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99AB1E5711
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299130; cv=none; b=CDF6ZMviQxVnUlOlw45Ps7ZPjhE/4QlJIfwfrRVk7zLZmQwqBg+UnOOI5EFHA1HpsPgEmlNZr9h6uK9mn2g1yPja2pPPD16HCOD4IPVc40fN98ZJklP6LYaFRe1hV83QbWPyWJPxf7s62le+3qS62GxWIYQZjMqxvhKEV06y0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299130; c=relaxed/simple;
	bh=gxdJcCJ/gmxFhPUHphCiTz7Q1fy1LpjwDoMAC34A6rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRZ3u+HW2aVhtHizffTwC/bUhFLWZxzgWCghrVXcDBfCXIpSSRLRHSzPq8YZu8PLZ2MLqZHdlFxD/JiHS1pmY6NOTT6zAoyYHKSN4kkwN4b5HG3KJVG1iWjg6AWsyp0b9NiH9kY6oC3EgBaBxsdfJhRNnFFtyK188s6ml3iEs6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45tnEOjv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iD7s6FRu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45tnEOjv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iD7s6FRu"
Date: Thu, 10 Apr 2025 17:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744299127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXnaW/57HWHmskd8RUZVPy85ulCSYuK64zuk6RecFgQ=;
	b=45tnEOjvTDE1O9dDasSGHedjb7mnAMkvaJBjYfio31r1HY7YvFEJlP+BpNfVkBRj0o3wER
	CHmljNQDa0wPGtUWBtVn4964e27Tq8CUQ+x9B6s5DQ1FJQN47SXRx2H1U8CteoZIvjKHwr
	C7o1thKgoMFW/+BJ1v76UneQvqkv3D2Hgcydg0zj4B8km6/Mh/DlLl/6z6SP+OVR/DaRzA
	kmGKPlNTb7amqUvTzX+7WerfK6BzVaLzI88zqtTc/xi5Q6PA9oT1vxQOzLxY+pXbBrIwfM
	Y1bgLxHnX4Uoq3rad2eKKxsIDqRJUJyqzxVn3VFFoD8kUN2fO2nZxoxvwvzkuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744299127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXnaW/57HWHmskd8RUZVPy85ulCSYuK64zuk6RecFgQ=;
	b=iD7s6FRuajNbUf7o1wCtmtr0TPf75IyFFYqBB+ZQl5ba+QAZenJA+Liyok5cErMXOhQSl+
	dx+ouDdCS9LwQCAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, lclaudio00@gmail.com,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250410153205.u92eJDos@linutronix.de>
References: <Z_bDWN2pAnijPAMR@uudg.org>
 <20250410064844.wm4KbunL@linutronix.de>
 <20250410075103.GV9833@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410075103.GV9833@noisy.programming.kicks-ass.net>

On 2025-04-10 09:51:03 [+0200], Peter Zijlstra wrote:
> > I complained about this special RT case in put_task_struct() when it was
> > first got introduced. Couldn't we just just unconditionally do the RCU
> > put?
> 
> Yeah, please make it simpler, not more complex.

Just so we clear: simpler as in everyone does call_rcu() or RT does
always call_rcu() and everyone else __put_task_struct()? I mean we would
end up with one call chain I am just not sure how expensive it gets for
!RT.

Sebastian
