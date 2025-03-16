Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F910F2;
	Sun, 16 Mar 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123754; cv=none; b=Qdy0rENGMO059o1q8mcqfWID7z/WA6bbeII4rsR1z/rSlC8oXyGxfY+lUO0D3EwMBZEnftXB1plGbHaVr2GYbkrrfuQV+ewGR2ZEPbfPwL4MIa0YJct6sgwjQlEh7KfWaQv6uQYTg65ehQIaE2J2YGBiOqqalonFg45BCfMUdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123754; c=relaxed/simple;
	bh=DFGOfDKZBpLnLmR52adzPCUkz+rQjYgi1LUd8xi8EwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN+KhAqrS8JWz4T/nhP+75Vm6jA1x09z069UXNVbJeAh8I9VIyyP6U1+6ntF23qqmfSlenPAyuVupR6upMah5nqfGOmPhSIUlh4o+L/VQDRJFMRfxRHuk4OtYPJRI4ifQjxXhb7wcRO1ZAaTwDpkDHdcFthP1f2nOERwK6NLQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqHE0Den; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqHE0Den"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D4C4CEDD;
	Sun, 16 Mar 2025 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742123754;
	bh=DFGOfDKZBpLnLmR52adzPCUkz+rQjYgi1LUd8xi8EwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqHE0Dentm2A9HEMjm47WSkJ7XOsm1YRgKxFOm5uG+4YCwdy7RqWwQDNMCP1CutoG
	 1Wh39z4T0be0mYJuQwRW2MHR7EF96Wy6auWegRNQvN3SjDOynvQDA09MVaDJNx+nty
	 gpGB50scxcBg0T0vovNhLO2Il0xhvETjXSOJw1hCBDuQWHS9z7uQuwB/jrtmjHGE2T
	 EIFt7dIwl8TtdK/9i68z1drIL7XyFyN7NGWsAM1Zz0u87bdlZMbSB8xBa9+V/NWq2G
	 1j8p/WhcIOLLHvUnps8ZjiHMrpTszqi6YL/ogXSoo6YnGv4nGeqIT0PXFELjHNK+dw
	 fOJ4cBDfZL89Q==
Date: Sun, 16 Mar 2025 12:15:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <Z9ay49NsoC73dKXe@gmail.com>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160810.2373416-2-bigeasy@linutronix.de>


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> +const char *preempt_modes[] = {
> +	"none", "voluntary", "full", "lazy", NULL,
> +};

> +	/* Count entries in NULL terminated preempt_modes */
> +	for (j = 0; preempt_modes[j]; j++)
> +		;

I'm pretty sure the build-time ARRAY_SIZE() primitive is superior here. ;-)

Thanks,

	Ingo
