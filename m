Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73132217F5C
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jan 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433690; cv=none; b=k+mC7Xb8kKAx6xDddTm6rqzGKQVCMOm+wPGscI4ROLjNl2UlyLj/+j4UrAFnDge9UqNYECjkOsoZHqQUjBOfX8EyBzeg/z3AeH+oW1dQp/TXXEXxY0laF2a9x6TemOCtvL26s2KmjXoSVS4CHlmqGFmSq4UVUr0rCil4h+CXaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433690; c=relaxed/simple;
	bh=vGvsp95MvTvb5kSGeDC/LpscepHlDQG8L1JfqpR/ssA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xku20LYogk+XdAoCZlGuQb+hXQ21hvWuLWbr38EVrcVls4dwHWNdnbIgvwt1cwH8BVe9aW5hlrks8qAdh+z0KnOqH9QFwlZIQmIklzFs6+ZI+y/40tLZwPiVQD4AbJ61/BrfUJVO0p0ydTEpunrwzvDZ87tBhNdNyrPXvNYZEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+9/0klI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKksWbwC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+9/0klI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKksWbwC"
Date: Thu, 9 Jan 2025 15:41:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736433686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGvsp95MvTvb5kSGeDC/LpscepHlDQG8L1JfqpR/ssA=;
	b=g+9/0klIQFdAPFIy68bmBj0WI0dwBqSdtFStUsqBpNEDts8gMZ3YNVU8Ma00bEACu8Q71h
	1jepFEToN+WqLkIA5vJw9jFLm+2o2TP206YaA+r2rQZ6fVsAsYffMYcnPLWK782SDuS6gE
	0dXIQ7JwG2UaLJzZW5Sun4uHMeD/BZsWCJD6gTPmaKhg6kMIGR7xtEsTHHa909uYPGthrd
	XQ/Rk0DIdTZwHMBhJcAuqlR006zdQIUbmfImU58L6J89i1hQZvWCxe4W+Ubtrc+hjkl5sC
	bnn6weLNLCFLxRWEAR3EN3MqWueT95AjzjA7rp1+HwFBNaDe+hKzUijbpIIiPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736433686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGvsp95MvTvb5kSGeDC/LpscepHlDQG8L1JfqpR/ssA=;
	b=oKksWbwClpmPou80vJfAi4pP5za6a3pcmrKdRE5IP3kW9Tbx9N6Fzr4dItuZp6DIH2c3ge
	wdgUhPV4G5hMy/Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [RFC PATCH] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250109144124.a7MWASit@linutronix.de>
References: <20241206113431.Q-VXMlru@linutronix.de>
 <20250109114339.GB2981@noisy.programming.kicks-ass.net>
 <20250109093702.5fe3400d@gandalf.local.home>
 <20250109143701.GA5388@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250109143701.GA5388@noisy.programming.kicks-ass.net>

On 2025-01-09 15:37:01 [+0100], Peter Zijlstra wrote:
> Upgrade brain. Also the proposed thing was just plain wrong.

Was it? For the !DYNAMIC case everything should be optimized away except
for the current case.
Let me try your thing to see what is different=E2=80=A6

Sebastian
