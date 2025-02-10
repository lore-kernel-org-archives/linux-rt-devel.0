Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD414B08C
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189074; cv=none; b=jbZMtnfy+pLhDeVZQU7dO7o3rQhdk5Tu+1dzX+8F3ryl4q9g/u2lut2a+LznKRw6rARabfsrFOpzAbU6F98KOVZ6WZGHdM7jLdrFslAZJ1BiNAuDd6dz2EdPMH7drt8oLgWQiyCDnSXd0lt6O/U+DeQOxmb2pi2LCwyC9HnV9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189074; c=relaxed/simple;
	bh=wg9VxpOpxoZHxEagghNlmD/wQTz74yim1SXm0sPtzfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJbflbLCDPzzhJMRpzR2Ykjw1goodL6vjFEZZbVsbwqHBrhYeqLZyzs/zv+l4jhCkGpo/MQSPvB0/WgREOPrdA/+k1y4H0/zVNzmyIY5CHmfd6vu28tYyKdT9FV3DEVEnbTEOr2V+nA5s1gEyTYFSvCDeVN8qXIpXzqBPP0EkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRxBpw6t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9jYSm56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRxBpw6t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9jYSm56"
Date: Mon, 10 Feb 2025 13:04:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739189070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/76Ws4ERHAARzCBmx64U4hnYZV3XD1o/uZgQrN85Wk=;
	b=eRxBpw6tTNK+3wdWCDDXRd/r/TMjr/nC/Cl5NEiPTnG6nse+s4Gq4CZoZjEzkUTv8OHZLq
	LWfx1iwUY5ZnLI0eMuSkzeCjoVXHUoDUTzNQYGR0IDW9YI3BpGsfaM0Issm8OV65TvOhiM
	KHni0YhZgZq4ulcElRNirluZ/Bf1JGBbf0N73fJWs+e4Bq1X5S1kGdEDa6tkunKvMPYSk6
	vTsI0/hRG46duY8L0hYUd6Sn9WbBFThQIEHXKVH7PXzeXGmfnf7ytOdNj0EGwiEpOiPnsa
	wDPBzZTluKowBHJt7OGMh63dIRkLtfyvUjQJIQ3M84zqix23mcz36+zHJLjNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739189070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/76Ws4ERHAARzCBmx64U4hnYZV3XD1o/uZgQrN85Wk=;
	b=k9jYSm56kYwwgyUEJOl82G5qVa0iKZBIItuPJdvfx6wfac2vZ8L/6bQpq+SAEmKRrMJGm8
	Oxp7Ql/3EAcwPTCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/9] arm: Rely on generic printing of preemption model.
Message-ID: <20250210120429.iFfBClW1@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203141632.440554-4-bigeasy@linutronix.de>

On 2025-02-03 15:16:26 [+0100], To linux-kernel@vger.kernel.org wrote:
> __die() invokes later __show_regs() -> show_regs_print_info() which
> prints the current preemption model.
> Remove it from the initial line.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Is it okay, to route this via the sched tree?

Sebastian
