Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0614B08C
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189127; cv=none; b=C7OtR4OvYB78Xfxl1X4EovaHOcXQlqT0TdBaRbUbfDiUBEZGG/on8FjisXq4vSKkhos7OyAZGOyaVhQajk47nWaRC6dAmj4zsVsHuck8Osp6wB+SDA7/HTgck5RyGqUO0ZjrpR1ZP2Nh4UNtJMNA2fau/y2/4zLUhybLCt9/y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189127; c=relaxed/simple;
	bh=B/VdbrFRaTLPcLJE6vwqbTEidh8ib6z3dkMcWfVp0r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke4NOC/aG14PF4O5BIYK8B6meLp2D2/SJKXgD9/XlsECyDzwzPRWExATPz+fyRoCeD6wyrBBOdqoVX89XAapAg5wTQB0NAqVZ359iVCVJ2tgNEWmMVS8A+Q7qnG4rssrfNJYF9XsxtjaZ6x8DpOHyQrdCRj7lRGEnkUcgGJ/RkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yEagp+lj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcGSnRX7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yEagp+lj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcGSnRX7"
Date: Mon, 10 Feb 2025 13:05:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739189123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxapaJhXMHi1dkamuCkDcE4Mfsv6fMSJ0gziQn4ozoY=;
	b=yEagp+lj2TIOwbHUOA0f1F+2J7YuakUp9/683voOGACDtw5iab8Hxq30Z3lr8Ey5xJ+KVN
	YfY94NlB7UIsJPauWBo0YCLLg85EfKgKDa0GPgsLErZ/vZpN32kqRyAVo8CUPHOkttEXSG
	bEspGEXqx06jsskW4WRmLwZY/X2xr/eVB29h9ubx6cIh7qr0tyjcfXkgfClZhIyoQaBSKo
	vRnBee3pfKmXG9GsEJdnQKIfrWWveU0CZSLGYtCusOgDA4xG27xLV31BAf0i+ophSGGUns
	B2Yqp1CZ5IP7umiaDeol1opT88F3keAsUddHJfpddRuh7raExBrOhVI8JtPmgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739189123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxapaJhXMHi1dkamuCkDcE4Mfsv6fMSJ0gziQn4ozoY=;
	b=FcGSnRX7Qd+JKTQZTRBam/OwH+Xede4wWJLiVQmU4YICNlc4o/NxAPgGbqcjkWOnjJpTS9
	bH9aLXxMNl3sC0AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/9] arm64: Rely on generic printing of preemption
 model.
Message-ID: <20250210120522.VvikzMr_@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203141632.440554-5-bigeasy@linutronix.de>

On 2025-02-03 15:16:27 [+0100], To linux-kernel@vger.kernel.org wrote:
> __die() invokes later show_regs() -> show_regs_print_info() which prints
> the current preemption model.
> Remove it from the initial line.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Is it okay, to route this via the sched tree?

Sebastian
