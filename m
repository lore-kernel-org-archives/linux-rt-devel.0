Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371120AF8B
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593578; cv=none; b=Hd4E29IQThUKn88P0IHYc2McsT4bnUMssBaVvtqDSlDJ1raf1AhBZPJdyEw6RJVqujVMPFaBi+TRIjrWpY+IAOEt+BjqVWh5XwHUxYElY/s5btelKkR0R7jclkFe6Wtsyp3GE19kwf1rS881T0zCBjQmV6VyYLTUFafKFMME4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593578; c=relaxed/simple;
	bh=xPh2fAesUlGfAMD/r/2pwd0PWgmES4VNbLPCCRgkqS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS9+UjY+SWNE7G2zibiGoHyur9kliwJ3IoquiIWaEo1H+KLq7DcUBvfUdmlzUYarZ+6QVV5cG+dKuWmBYAfqpSytnY6orrT465ILC23wsscEHeqUX8NsSsdW0Gy/k5UrN3XpeWqQI00p+L5xpspUqzAwDFk6jfKkQLW9hbF3lc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNJgPO5c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmX7LDsR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNJgPO5c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmX7LDsR"
Date: Mon, 3 Feb 2025 15:39:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738593575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPh2fAesUlGfAMD/r/2pwd0PWgmES4VNbLPCCRgkqS4=;
	b=gNJgPO5cQV5xOM1mv2RPF+wPqQKsnCNl5AhgfOxNC/SZ2ZsuwN2Mehfj1QP9prSTjQGRhL
	dmOYJfe1bsUshDU1boPQGWJOZPmYbbkVaN85or9pA8+rBb4M2xJWK2LN9mymLArVlauGcF
	FJf6SakVwCVeaNRHAGhSdb+CmHuUAxivgA7WnjtTMrtCkIRs1hMMMMnJPZa5KFF+lAUngG
	IINVVPuMDmihks9gvtpWevWlfhjqywyfF03Y9f9qcF59VAtBybkVSb8wFoLWBUzVU5suXz
	1jUQpSBR9VbC6zCmjbfLjiMzxBr2Zt3x5zO+Y5JZZE8meekTBpdQ502xfE/CxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738593575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPh2fAesUlGfAMD/r/2pwd0PWgmES4VNbLPCCRgkqS4=;
	b=AmX7LDsRpGAWY9F7iasB8l7HXXDSEafMd5n2CfisNy8HbnM6A1Cra8JBahlCkFQw+3JFwX
	sakyCD9HylMtsuBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/9] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250203143933.VJphcnTv@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203142505.GH7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203142505.GH7145@noisy.programming.kicks-ass.net>

On 2025-02-03 15:25:05 [+0100], Peter Zijlstra wrote:
> Works for me; how do we want to go about merging this?

Thank you.

> I can take it through the sched tree I suppose, once the various arch
> people have blessed it.

I guess this is the easiest part. I would ping those who did not ACK
their bits next week.

Sebastian
