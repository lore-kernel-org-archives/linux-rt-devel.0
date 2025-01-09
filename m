Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146821D598;
	Thu,  9 Jan 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437897; cv=none; b=mcdu5Lcm5mTpY+oBTUEv3quSHjdt29G58NvcJFPynDMQnGb4m8VKu0Fx8hpMtYLiC7utRoOFRTx015DJm2aBGsQ9CDIIhWTb7xQQz1nTdzBHbt/4zYTXbUvn3/80jWow9MGCkNn55Oo8jwRwqd+few9fzKqutiBfx8EiHIls1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437897; c=relaxed/simple;
	bh=/1WyInbQ0j3+LaSpdgVnybmUgFkpMG5pSoytLnVMycM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1G3aKff9m/dvGl51lDRl2cfUSATo/5FpVGaWgguQgW9Ihv4fqca/Ww8h6WjWdyz+gmgFHhD1xCMUOgUZ5LsZ2GxZZTzBWNVkXASfbXVAyqpRI34IqrYHxmgbBeZW/PQehpJGnT6k3shv6hqYXKamsHJVdhVOZY2TpJSMCqdzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8593DC4CED2;
	Thu,  9 Jan 2025 15:51:35 +0000 (UTC)
Date: Thu, 9 Jan 2025 10:53:08 -0500
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
Message-ID: <20250109105308.6c60dd8c@gandalf.local.home>
In-Reply-To: <20250109143701.GA5388@noisy.programming.kicks-ass.net>
References: <20241206113431.Q-VXMlru@linutronix.de>
	<20250109114339.GB2981@noisy.programming.kicks-ass.net>
	<20250109093702.5fe3400d@gandalf.local.home>
	<20250109143701.GA5388@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 15:37:01 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > I'm sorry, but I can't even tell what the above is doing without my brain
> > hurting. Why make code that was easy to read into a cryptic obfuscation? I
> > can't see this as an optimization as IS_ENABLED() is determined at compile
> > time.  
> 
> Upgrade brain. Also the proposed thing was just plain wrong.

Or use seq_buf to make it a little more readable again:

const char *preempt_model_str(void)
{
	static char buf[128];
	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
		     (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
		      IS_ENABLED(CONFIG_PREEMPT_LAZY));

	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
		struct seq_buf s;

		seq_buf_init(&s, buf, 128);
		seq_buf_puts(&s, "PREEMPT");

		if (IS_ENABLED(CONFIG_PREEMPT_RT))
			seq_buf_printf(&s, "%sRT%s", brace ? "_{" : "_",
					brace ? "," : "");

		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
			seq_buf_printf(&s, "(%s)%s",
				preempt_modes[preempt_dynamic_mode],
				brace ? "}" : "");
			return seq_buf_str(&s);
		}

		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
			seq_buf_printf(&s, "LAZY%s",
				brace ? "}" : "");
			return seq_buf_str(&s);
		}

		return seq_buf_str(&s);
	}

	if (IS_ENABLED(CONFIG_VOLUNTARY_BUILD))
		return "VOLUNTARY";

	return "NONE";
}


At least this removes the need for keeping track of off, len and r.

-- Steve
