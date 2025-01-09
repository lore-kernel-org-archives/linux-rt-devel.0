Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713B2153D6;
	Thu,  9 Jan 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423028; cv=none; b=EosOVPP1DKzuiFXoVGjGRbGpfUWZxx9deVZvkSF+HKX1SFCviRw0POe5e7IVnOplaiMcVpivox1zTU0taGObySYaCvmQ19Z81Kv4P3GQBj+baxchbcuWoejm65VBDDP5vkij6FoZxlQUxhj+FPf1nnG18dGBRviI/BkUmulCIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423028; c=relaxed/simple;
	bh=I9POol12TFW7F0zNVv1NOu6YAQeyVtVgKBtI7FxF1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dayS6/Dy9OjM3xi+lXojRzyxUaLU037H1COmpxvwL3piEEeUxGhjsVsmvxjGSEdTBr3xsm998mFqat/QLvR4ZnH5SKGz9JqP/jIuE1ZmA48I8T05pkT2D8Xa0QBzik8QsEfjBtxfMXkAxe/o2+ZTmUsAOA58HkcCOP2mD9QJbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VWGVWWOL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWGVWWOL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=20KXPR2Y18i8FHU+K41dPmCcIB1RmvBNagD1HEkCeFg=; b=VWGVWWOLMcnQNaA3y5WSuAsOLR
	DeXnYd+GRY6vQgl2RAi0aVrmB2jYrtTTK8Kwa8mXfubN0EE4CUEYn9Tni4ocUqxIa+mtDvP/Cn4ye
	OcU3gDctTj0jjwk15C4eUQsfx6c8rebt7JReBXZsV4f+1RDmxEaP14TAYBuW9OwEK6ipj7NsXKdtI
	7SbUWE0WCeVfGdpzck0Uf2ZWzJjfJkr8AHSfPZ0A53eHykBgDexmZaUSJwCBu2JxzPebAGya5s02s
	YYLDZOWHWov2Sp2Y0ZM+n+3fTIEH5jIAPAYOVgUP1SHAniZUt7TwMY0zN+te93XdinoYPrYh7ssog
	XQN/JSzw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqwu-00000009Yf9-2TCL;
	Thu, 09 Jan 2025 11:43:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0A9830057A; Thu,  9 Jan 2025 12:43:39 +0100 (CET)
Date: Thu, 9 Jan 2025 12:43:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [RFC PATCH] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250109114339.GB2981@noisy.programming.kicks-ass.net>
References: <20241206113431.Q-VXMlru@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206113431.Q-VXMlru@linutronix.de>

On Fri, Dec 06, 2024 at 12:34:31PM +0100, Sebastian Andrzej Siewior wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 95e40895a5190..8f5517dbe07d4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7642,6 +7642,30 @@ static inline void preempt_dynamic_init(void) { }
>  
>  #endif /* CONFIG_PREEMPT_DYNAMIC */
>  
> +const char *preempt_model_str(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && preempt_model_lazy()) {
> +		if (preempt_model_rt())
> +			return "PREEMPT_RT+LAZY";
> +		if (preempt_model_full())
> +			return "PREEMPT+LAZY";
> +		if (preempt_model_voluntary())
> +			return "VOLUNTARY+LAZY";
> +		if (preempt_model_none())
> +			return "NONE+LAZY";
> +	} else {
> +		if (preempt_model_rt())
> +			return "PREEMPT_RT";
> +		if (preempt_model_full())
> +			return "PREEMPT";
> +		if (preempt_model_voluntary())
> +			return "VOLUNTARY";
> +		if (preempt_model_none())
> +			return "NONE";
> +	}
> +	return "UNKNOWN-PREEMPT";
> +}

Hurmph.. a bunch of those combinations are nonsense :/

Also, we have a string thing in sched_dynamic_show().

Can't we do something like:

const char *preempt_model_str(void)
{
	static char buf[128];
	size_t off = 0, len = sizeof(buf), r;
	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
		     (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
		      IS_ENABLED(CONFIG_PREEMPT_LAZY));

	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
		r = snprintf(buf + off, len, "PREEMPT");
		off += r;
		len -= r;

		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
			r = snprintf(buf + off, len, "%sRT%s", 
					brace ? "_{" : "_",
					brace ? "," : "");
			off += r;
			len -= r;
		}

		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
			snprintf(buf + off, len, "(%s)%s", 
				preempt_modes[preempt_dynamic_mode],
				brace ? "}" : "");
			retun buf;
		}

		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
			snprintf(buf + off, len, "LAZY%s", 
				brace ? "}" : "");
			retun buf;
		}

		return buf;
	}

	if (IS_ENABLED(CONFIG_VOLUNTARY_BUILD))
		return "VOLUNTARY";

	return "NONE";
}


