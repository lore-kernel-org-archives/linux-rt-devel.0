Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BD134A8;
	Wed, 12 Feb 2025 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385712; cv=none; b=iH4sBUQgLj8XLg+vLILrX4m5PSTqqTqAocf3xqkjRDoCmfbgl7eoZgPSp/aPbdQ6chLRt0IGH/LEToX5AcLu3D6FzA8ilFMRbC/jV/BUcp5cV/vGqYRYnSr9sUVNs9zQMuZavKBW0SnePHGAHnc+0noIwBUuR2S+NHL5rd6Vrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385712; c=relaxed/simple;
	bh=ToC5PWdVV0L8ziXowZqcSfmdPrWjcstzwCI+oLNsMWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTb9QcCSZA1Wnj96EihBU0TUPi2Fpp61pJWbwJIDieR7jpy3YvX+vSnDF8A3EsTF4D46K1h/FSeS1DFYRJSjNFPygtTVoNixCMaSM5KTrJgKkxYU2d+0Hcrr8xgSg9bFJvrFPhqNEzrNtsGmQDUGZbR/KgMTTtHFxlMF6BGOT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FCBC4CEDF;
	Wed, 12 Feb 2025 18:41:49 +0000 (UTC)
Date: Wed, 12 Feb 2025 18:41:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/9] arm64: Rely on generic printing of preemption
 model.
Message-ID: <Z6zramjL3dceOwIl@arm.com>
References: <20250212134115.2583667-1-bigeasy@linutronix.de>
 <20250212134115.2583667-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212134115.2583667-5-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 02:41:10PM +0100, Sebastian Andrzej Siewior wrote:
> __die() invokes later show_regs() -> show_regs_print_info() which prints
> the current preemption model.
> Remove it from the initial line.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
