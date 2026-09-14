Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD44455600
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391769; cv=none; b=quujKbxYGBp55M2KwWs0E+YNeU3byiAzhD42qoPXbH92ScGIdcVhVJySAFy41/70Eb55cFpjIQ/InlN3GelNTQIsZhtCo1FCDVQHzlduH3EeW+8QIJxS3OhreZwG7YBd4VuGB4FtBl+B6zsCWvCOF0yKtOYDo8ae5YUPIeS/CuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391769; c=relaxed/simple;
	bh=3vwr07MU3joRPtrubT4HcmFEc9BUR3dpvqJO1KXq/IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcE3pguzKTcD1gCieV1HNCVa0dMyPDBB1HuVIZdZnircLSR5XA7dmcckATkA4x0agOfh2nBjZy228P4j7uQGo6hNN2h+ZbeqSrQOfliCfilEJ9+yo8h3OuYlgYEdMRv9RkcPaOeo7QAjm32GjJUtNyDFd4r0+lqToMJAzlC0kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4qCbMt6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XGp2t4S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4qCbMt6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XGp2t4S"
Date: Mon, 14 Sep 2026 15:16:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789391764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vwr07MU3joRPtrubT4HcmFEc9BUR3dpvqJO1KXq/IM=;
	b=d4qCbMt6yGCiZhj2a+ZHFOmZpi2J/YabhieElMYC3lNVefjofvaJk/MRt19JzoVb5lUUie
	Yzzp3X+u/1K8tAA3Gh9DGtqf9Yb/5xtlicqBc8pMUj81ZD2QE2nd62gWRu68mltzbGtFBU
	NLQsG30OSKS1Gh6yEvHsdr1odzHW92MetxuNm8fv7iEFTxNYlA9DmiNtWCuSJiNyCqJLqY
	Q2DM9vmjYYdMkkD03E8e9x9X9j0WL5cGxVJkI9yJEAhfRe+eeNWqhNxJZ5Mu3TTkCTJlPC
	39kj6jWmTUPTHGVM72elD5Cgm/VZGE5E2w0YvJqwG+i85EQBsbkLXfgToagiFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789391764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vwr07MU3joRPtrubT4HcmFEc9BUR3dpvqJO1KXq/IM=;
	b=1XGp2t4SF0M7XQYHGMGx2qQPX3D9Zomx1ML5e8lRRIWOjzSl+KMr4LupgGi70O3rOViVtZ
	eirXuz5pitySxkAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/3] irq_work: CPU-hotplug improvements on PREEMPT_RT
Message-ID: <20260914131603.th1LyYn0@linutronix.de>
References: <20260911143815.997254-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260911143815.997254-1-bigeasy@linutronix.de>

On 2026-09-11 16:38:11 [+0200], To linux-kernel@vger.kernel.org wrote:
> There was an unrelated thread which made me look into how
> !IRQ_WORK_HARD_IRQ is processed on PREEMPT_RT. Turns out the queue of
> callbacks gets never flushed on CPU shutdown. !PREEMPT_RT has a flush
> but on PREEMPT_RT the thread context is required.
> This almost never happens but if it happens it is a pain.
=20
Something else that almost never happens: printk() has this
__printk_percpu_data_ready() thingy. I interpreted this wrongly last
Friday: If someone does prinkt() before per-CPU pages are setup then the
work item has the IRQ_WORK_CLAIMED bit set and this work item is copied
to every CPU's view of the per-CPU data. It is not protecting itself
=66rom setting bits but the irq_work API.
irq_work has its own per-CPU llist_head which gets copied during per-CPU
setup. As a result, once interrupts are enabled the IRQ-work will be
invoked on each CPU passing the "original" irq_work pointer (from the
per-CPU-data-init sample). The actual per-CPU data (after setup) never
gets cleared.

We should either disallow irq_work_queue() until per-CPU data is setup
or flush the irq-work queue before the setup (so it has no items while
the data is copied).
While the printk workaround feels wrong, it gets the job done for now. I
am a bit worried that if its usage spreads around and we get other early
users=E2=80=A6

Sebastian
