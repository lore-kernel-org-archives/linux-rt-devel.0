Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9043469F4
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802614; cv=none; b=bO/l6X675m9KmPeG8SHjx711Y2xFUxvs4K60A9uD3y0zlMdbMVsWpkSxbLJaYRAbv0nxraDd4+DrYhTlUXrtgLAyKIxzMPP5TEIWA/qIq8v5kph93J6ic4gjAGUG1UWe1IW8463q8qPvR2+zbVPFC355lRrM3he5MOjZyCv8p+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802614; c=relaxed/simple;
	bh=ZPXqCY0tho6GkwmA6fbStYsMzfpN/ihT2eAucHg9+6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7vHqQbX6YquVB79mE/3HICbw2T7XFwNhqzgLyCJoxpAX6bgedvAOFxbgPg+R14s1pPJf6eAC9tivsrP3ix9LFrqvfcBnSAeEhNd4h3O/cbRBVcaugT7EWeeDibdNfIb5OBqkjaHy1x0GP3+/cCZZZAwF26bvRrTmkV+jUA6sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C35701A0434;
	Wed,  7 Jan 2026 16:16:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id ADB0218;
	Wed,  7 Jan 2026 16:16:42 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:17:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260107111709.0d115cd8@gandalf.local.home>
In-Reply-To: <20260107105137.4cf9a67e@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: inzb3rjx98gangpw8ut1k8r1t7gaxxdb
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: ADB0218
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19wzP8VKZmWVZCPfE0i6TVAtAqY+P8NKJk=
X-HE-Tag: 1767802602-156917
X-HE-Meta: U2FsdGVkX19Kri1jK5kubktxQQFJRrmq4ZI847AS2na2jPx5t5RfZXCXYwig/ta7ww642uasvv6l69u0UB28AT1SyNeL0O4RYptw0XHlE3c1llKWYlKarx3fTGG1umQlyn7kX30f+QPsOCqQe1n0mhkiV+mwVJ3QgLDBckoQwDjYgpdjsLnfhouY26iS1WZgk/4jAfpZ//LWfqTrqRho6yx3/480jWCSYRPqwfWzv75qfW5+hvD4A0Y7iEIikq1SC42w0CxS9k9EHhv+D1PEBv9RfB1n2fn7UYprmMCeYl1uOsrC1s8L3P5qQoqIcrpZihHfvTholYVDZ/zXoVlRoZKdhVJDMshlerQfhZ3BEHP7IVGcMVYuK35VP1dJ9a4s

On Wed, 7 Jan 2026 10:51:37 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> Erm. It's actually good I had a look. :-(
> 
> A helpful comment in irq_work_queue_on() explains that "arch remote IPI
> send/receive backend aren't NMI safe". That's something I wasn't aware
> of, and I'm afraid it's the end of story. The comment is followed by a
> WARN_ON_ONCE(in_nmi()), and I can easily trigger it with "perf top"
> while nmi:nmi_handler is traced.
> 
> Please, remove the patch again. I'm sorry.

Or we simply change it to:

static inline void
rb_irq_work_queue(struct rb_irq_work *irq_work)
{
	int cpu;

	/* irq_work_queue_on() is not allowed in NMI context */
	if (in_nmi()) {
		irq_work_queue(&irq_work->work, cpu);
		return;
	}

	cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
	/*
	 * If CPU isolation is not active, cpu is always the current
	 * CPU, and the following is equivallent to irq_work_queue().
	 */
	irq_work_queue_on(&irq_work->work, cpu);
}


-- Steve
