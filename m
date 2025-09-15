Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795930ACEE
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939089; cv=none; b=fOMqn5ufi3QhV+HTG8Z/xMzpMgfAMpHpw4XWYWTkltdIqu9P16Cl1BIeii/Pi+QhHa4kmpz1EnFpdn2svPVjKOO5B0qrF4mE5ntI0oSFjtsv/vnOTNRcVclCMUHIE2Z4Lq9rT3YxyF7ywXaIqbS4SNzivetpPlWmAqgn71AA32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939089; c=relaxed/simple;
	bh=/siky0mWqlUtrQlrqmrfLod+4cn0kDw8MIW2UWnQ6k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxkaDMdLHGabMJbz6/CkxR3ldAZL2valaZMPdmuZv1MNTCmrPJ3MA6Qid83PzEQXX3L2CvPEwSGpow/krIo5WzasZMC8PV2lqJ7uUCskS2DeaWkvpsqevUYzNlLxm4j+6KvKdLAEfEZcoDBxpRbN2lWSrBVqtKjqfNHTb0PcI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDLtGh2w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ZsCjFYo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDLtGh2w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ZsCjFYo"
Date: Mon, 15 Sep 2025 14:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757939086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/siky0mWqlUtrQlrqmrfLod+4cn0kDw8MIW2UWnQ6k8=;
	b=sDLtGh2weupEnwyICVrLK0nl8nR/FMVv48BImBzBQb6nS8tJ7Dai+KzZ/H5SGFLdbv18Cd
	XkWzCbhP9qJ6QZxdAoQJ5K/JGKaliK+KqCByQyU05yGnJ1kvzL38gqsOHCgY69NNc/NMJg
	kxPKLHNdbgobat3vjDp9kSyH3NhPMqTUGRkgYQ4zCrnILwhhgVIUp17Gw5WDbBxUMTxphi
	2x6fqcCcTwI0yCTWKO9S24p0iSoMNGXMAgPy1CGlE+w2En3Q1tr7bMbG34bbG/yR3xIsfn
	DZ18TY4XWKF+r9UH+/Oqsens/T7pOF5XSXn5eFD+7U8Wq715yAbPJnHGsEkmqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757939086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/siky0mWqlUtrQlrqmrfLod+4cn0kDw8MIW2UWnQ6k8=;
	b=9ZsCjFYomIoQ4s3MtS4NtKkmly5HEV/nFGYmKPJy1QLRRjNG0tZruCja8F9sPrbgtKEh2T
	uV8bmxFypzDlv4BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <20250915122444.Gg_Tsymz@linutronix.de>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915113812.GB3245006@noisy.programming.kicks-ass.net>

On 2025-09-15 13:38:12 [+0200], Peter Zijlstra wrote:
> Right, but I thought we did want to make this behaviour consistent.

That is correct, that is what I asked for (either consistent or a
compelling reason why not).
Oleg pointed out that the patch description does not match the change.
That is the only complaint.

> And IIRC RT has been running with this for ages, and never seen a
> problem.

The syz-bot picked up RT recently. Other than that, yes, RT had it for
ages.

Sebastian
