Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04F217652;
	Thu,  9 Jan 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433332; cv=none; b=VxZ9u8j4slO7RFQ9myxMEnulkYlixWOwVbbe/TZ1zlXDON1ejMMQep4vnsP1YhE+DVl0Yj2InJLHJBTU8rg5Hx07eoyS9kAhJfMusySpIn87t5ByYrsP7HxFvq5Ry8ByIezhtwADfgWsODPSvCZ3K06h0d9GQJaANlHmM1p8Rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433332; c=relaxed/simple;
	bh=SiJzv2wrERJd107gxPIoj/5IjZ6mNVFAJrmpEfWdN/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxXIg8CQbxuXzUaNcWmraiCtfJzxbIwaek6bwWvb7Ig001NObLkZWk5p2RLesUJTXuwWo8f2nDUaEzaWkNUo98fbIldlDbBXgm5RGO6r1NYqh1E1kZG6ciI7AKVoxRaKj9bBILYuScBGjPRxYKvH52nxgAvOoGJ7lg/hvQZzd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40665C4CED2;
	Thu,  9 Jan 2025 14:35:29 +0000 (UTC)
Date: Thu, 9 Jan 2025 09:37:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ben Segall
 <bsegall@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Thomas
 Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon
 <will@kernel.org>, x86@kernel.org
Subject: Re: [RFC PATCH] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250109093702.5fe3400d@gandalf.local.home>
In-Reply-To: <20250109114339.GB2981@noisy.programming.kicks-ass.net>
References: <20241206113431.Q-VXMlru@linutronix.de>
	<20250109114339.GB2981@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 12:43:39 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Hurmph.. a bunch of those combinations are nonsense :/
> 
> Also, we have a string thing in sched_dynamic_show().
> 
> Can't we do something like:
> 
> const char *preempt_model_str(void)
> {
> 	static char buf[128];
> 	size_t off = 0, len = sizeof(buf), r;
> 	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
> 		     (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
> 		      IS_ENABLED(CONFIG_PREEMPT_LAZY));
> 
> 	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
> 		r = snprintf(buf + off, len, "PREEMPT");
> 		off += r;
> 		len -= r;
> 
> 		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> 			r = snprintf(buf + off, len, "%sRT%s", 
> 					brace ? "_{" : "_",
> 					brace ? "," : "");
> 			off += r;
> 			len -= r;
> 		}
> 
> 		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
> 			snprintf(buf + off, len, "(%s)%s", 
> 				preempt_modes[preempt_dynamic_mode],
> 				brace ? "}" : "");
> 			retun buf;
> 		}
> 
> 		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
> 			snprintf(buf + off, len, "LAZY%s", 
> 				brace ? "}" : "");
> 			retun buf;
> 		}

I'm sorry, but I can't even tell what the above is doing without my brain
hurting. Why make code that was easy to read into a cryptic obfuscation? I
can't see this as an optimization as IS_ENABLED() is determined at compile
time.

-- Steve


> 
> 		return buf;
> 	}
> 
> 	if (IS_ENABLED(CONFIG_VOLUNTARY_BUILD))
> 		return "VOLUNTARY";
> 
> 	return "NONE";
> }

