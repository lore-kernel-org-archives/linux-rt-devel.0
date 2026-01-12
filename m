Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E15306487
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232993; cv=none; b=c3smIXjgo4tZ7k/sOBFs/omWLQV2xuh2Vk0PMwcgk25TT1bznMUDiiPPvplVswQ+dXlC2VmuwjDfMsnSx9TxPwYKhC52XcPOinDj/9MB93i3vh57lOvi+StCR0K0JxBexjaV87BDf8Ez8QEFoaX60YAelGGkr6F/w6kegIdOuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232993; c=relaxed/simple;
	bh=RSA8C6crQlQO4oFtq02vr1QpV0nDh1Ig7PXF2dcnxDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppptewDmF33n7lp9LMRhG9XM3G8Vj+31qjAgOAWU+wc5v9IB5gOdF9wwUI4UUgfKOmHFBWOI4wqaaJVGD0HvZrcO2Be0/CikYpX3lYeOc054+ZuTDe3RLOy5syV+nHVOIJsdktGYhNQm0qjY5Qn6uiirFVZetfJjqqAOKIDorKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4S252Z9S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vaEr6NPs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4S252Z9S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vaEr6NPs"
Date: Mon, 12 Jan 2026 16:49:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768232988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSyLhBaSAZ7V3E2rNJAZbDIMKTR+IBDHlvbt1HHlBOY=;
	b=4S252Z9SL3G43rQ+ZWr36/w5Tim88QDDdp5yNJZoc3XntW4ONJ2cPueobMMS8+H6cMQnBP
	xrqg0EBu2G+pIpbmnjWuJUAKC+4o6BZtxCj2aN8yw9y2HZmqo2JY3vniNAysZF+MTs0SiD
	rUsuuVwcqfIAcBi9nVqPH1UirHLJxjRqbINMaB59vOFQ9MssClGywWC2BYyJW8kmdKBcYa
	SA9CA5U0Ni11UvOAhaU4Gpj7W9yCMnJBIciT6fHkoIq6UHIvjKbPPXt68RBFpXtj5F2zKW
	TCzlib/nDUV01MZoRpoB/CdpdDIqkPFc5SnodJz2y8fLp9++w+nR2sj5yowuZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768232988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSyLhBaSAZ7V3E2rNJAZbDIMKTR+IBDHlvbt1HHlBOY=;
	b=vaEr6NPsN5Umwx77Kr25OoDWGCKu61vc+PM9509ffMJkU6xPbLxbH3ByNp/LR2L7fgh1Fh
	xM6TKvfxzpoaolBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable-rt@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v4] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
Message-ID: <20260112154947.5C8DFdQb@linutronix.de>
References: <20251223051413.124687-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223051413.124687-1-jiayuan.chen@linux.dev>

On 2025-12-23 13:14:12 [+0800], Jiayuan Chen wrote:
> On PREEMPT_RT kernels, after rt6_get_pcpu_route() returns NULL, the
> current task can be preempted. Another task running on the same CPU
> may then execute rt6_make_pcpu_route() and successfully install a
> pcpu_rt entry. When the first task resumes execution, its cmpxchg()
> in rt6_make_pcpu_route() will fail because rt6i_pcpu is no longer
> NULL, triggering the BUG_ON(prev). It's easy to reproduce it by adding
> mdelay() after rt6_get_pcpu_route().
> 
> Using preempt_disable/enable is not appropriate here because
> ip6_rt_pcpu_alloc() may sleep.
> 
> Fix this by handling the cmpxchg() failure gracefully on PREEMPT_RT:
> free our allocation and return the existing pcpu_rt installed by
> another task. The BUG_ON is replaced by WARN_ON_ONCE for non-PREEMPT_RT
> kernels where such races should not occur.
> 
> Link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6918cd88.050a0220.1c914e.0045.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This is upstream as commit
   1adaea51c61b5 ("ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT")

and should be backported down to v6.12 due to the fixes tag. RT wise it
should be broken since its introduction so if the stable team could take
it down to v5.10-rt, that would be nice.

Sebastian
