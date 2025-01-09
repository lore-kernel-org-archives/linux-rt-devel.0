Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFA54769;
	Thu,  9 Jan 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434455; cv=none; b=cZPf251XQVv0WqBgkNiai+6oWbUy3lZMQmlHT3PWdbtIjlyjLtVkhZyaHGztNKcBACr1xDF5rvho8fKMtjJG7vgtquRp59oz+cmplHJQ1BnZVyPIzoug6rhmTyIPYKmfBWim65EnVumAob+5SL4vyXj8oFX5+afzPE42R6KW3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434455; c=relaxed/simple;
	bh=jgtJZEeueWmBgS7x0jYrg1wO/yLtnQ3r969neK03UPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPtbgBXDCRpBQPnzKuy42JWZYbadpjU27ixe9VvgVGgOz2mBlQw2htchC3YiLv2C4KKTjr9M6sU6+Ll03+vFRk7ovq3uGqUjgese1MXQD51AiKOzF6V7dC9ijxYNO1FXRy/TAMhbERAkAjSpCo5kvUXsJYEbX7f68f9jju/MozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ERKuAusP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERKuAusP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kQlSSzzzFuf3vHaM/p+LVncrUKn7UvEMPTm7/h2S2y0=; b=ERKuAusP7/KxmVRj9Vs7IT/uxZ
	7EcFVOWgE6pNRuZf0qEaoW7Qc6Q3QPiNBzReXSWeV04O0VHrW4GQJIdZd+xWEjfP5qSMUmda9EcJz
	NpK6onkfR7fOHXJTrwGwAgB0/WHl5OKsJcg9celtxyInnXNMQODQVMUanBIat4PLULPLOBouawdMM
	7xjWRTXxJqp7zFs8hhfgxwIpZbwioShTotKaYdL5LEZ5AtG4yxMSUDi6k/ywB1RVhMMX/OVrnE57L
	pCUlg8GRSl0If3LOwiADp5nT72H5O1S1DC4eCi7bQBiHynf2g8xTQ3kEJLigRp384joklI1Jgekt/
	AhbybhdA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtvE-00000006Uw4-470J;
	Thu, 09 Jan 2025 14:54:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 974333003AF; Thu,  9 Jan 2025 15:54:08 +0100 (CET)
Date: Thu, 9 Jan 2025 15:54:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20250109145408.GB5388@noisy.programming.kicks-ass.net>
References: <20241206113431.Q-VXMlru@linutronix.de>
 <20250109114339.GB2981@noisy.programming.kicks-ass.net>
 <20250109093702.5fe3400d@gandalf.local.home>
 <20250109143701.GA5388@noisy.programming.kicks-ass.net>
 <20250109144124.a7MWASit@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109144124.a7MWASit@linutronix.de>

On Thu, Jan 09, 2025 at 03:41:24PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-01-09 15:37:01 [+0100], Peter Zijlstra wrote:
> > Upgrade brain. Also the proposed thing was just plain wrong.
> 
> Was it?

Yes, things like:

> +             if (preempt_model_voluntary())
> +                     return "VOLUNTARY+LAZY";
> +             if (preempt_model_none())
> +                     return "NONE+LAZY";

don't exist and make no sense.

> For the !DYNAMIC case everything should be optimized away except
> for the current case.
> Let me try your thing to see what is different…

For the various cases it was supposed to print something like so:

RT+DYN:	 PREEMPT_{RT,(dyn_mode)}
RT+LAZY: PREEMPT_{RT,LAZY}
RT+FULL: PREEMPT_RT

DYN:       PREEMPT_(dyn_mode)
FULL:      PREEMPT
LAZY:      PREEMPT_LAZY
VOLUNTARY: VOLUNTARY
NONE:      NONE

