Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198B37D1C0
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803379; cv=none; b=K2nc+l/xOa4oFQDFG4BSnS98FsYkfvo1rzs6OeYIwjuydyQasZ96R4+WGbA9b3nw2EjH5U/Vr49d//uS28FUcKl5o5jZMXAbHGaXDwDL5YMZAVc7i8iAkZ2RwC48TXNP3RHLYQRyRr9qxy76ZpVJ6I6emb+2n/u9AUPyBMb5t28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803379; c=relaxed/simple;
	bh=h4g1T8+nTdGRiKEX2zWnm5RgnG79J06XV+19EmwzTxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+KtzKmuytDfJEFBOiiHt1cIje9d+h977TNExpssENELIRA1auSkmJfQR1ehr2b5MfVWrPHRafgke18SnoHFyJm8BKt0dtXAMEKsgkBaoOUc06GSPFObCzA4Ei+x0bCU+K6kY7eeU8LTuc8AyVYmRaa1oqvx98Mf+u3eKQLtc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4E792160476;
	Wed,  7 Jan 2026 16:19:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 37D5E20018;
	Wed,  7 Jan 2026 16:19:09 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:19:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260107111935.3befc296@gandalf.local.home>
In-Reply-To: <20260107111709.0d115cd8@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: regmgp5xptze837exf5tromfaembwfp4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 37D5E20018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19t1uYnw622G91V7nQiZPO3aimEGwqxAoA=
X-HE-Tag: 1767802749-236976
X-HE-Meta: U2FsdGVkX18/wIi3/OMgHpXPjGUWt6PrTQOjaOrUDU49HogZnJHHwu/Vm2eb5nYUPuBswgrudCYbFK+vo10c6w2pMHNJK7/+WEwVvkSJLf36+FPI+RKB5AeZs3FpGCNIcOToiqYvHRHb/k7FvXEfvEDrt0NvqhLbvBPL5fFjsbXWDmBQRidwfZBOlSHDVKrA1pJsRzRUp8MEsOTMheAINzSHEBq2dNsj6GomR4KOCjB8KVbaVPcI8+lAbquE3f4FbbNhpGEwykX3OtF5Dg06cxsRGeGWaIingNANJERPMnRvvG++Q/TODzxbQxRTgQS7kPoY4qTrURw3ZSW6Yp+BsVsOPExFFjcH3LJC1NYS8UNcsN8pPOCfRLvzdocTvn7G

On Wed, 7 Jan 2026 11:17:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Or we simply change it to:
> 
> static inline void

Actually, the above should be noinline, as it's in a slower path, and
should not be adding logic into the cache of the fast path.

-- Steve


> rb_irq_work_queue(struct rb_irq_work *irq_work)
> {
> 	int cpu;
> 
> 	/* irq_work_queue_on() is not allowed in NMI context */
> 	if (in_nmi()) {
> 		irq_work_queue(&irq_work->work, cpu);
> 		return;
> 	}
> 
> 	cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
> 	/*
> 	 * If CPU isolation is not active, cpu is always the current
> 	 * CPU, and the following is equivallent to irq_work_queue().
> 	 */
> 	irq_work_queue_on(&irq_work->work, cpu);
> }

