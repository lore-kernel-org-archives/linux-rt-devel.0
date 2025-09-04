Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4730CD8B;
	Thu,  4 Sep 2025 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006936; cv=none; b=kS4O3Osd1ruCJT3IrW8UsDNxy8RaPnKmymPIhWIhJrF6e/GzPAYxMWEIU2Iwh3mViKc71lqcEtPni/3mqCotDVNTT+8bmGjCdLfOme4bopdGeqDPyyIaQ0+exv0EF51BwmBKpiUN5nuTz15X0owATgcGBE3mrnKX2FBf6VXkZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006936; c=relaxed/simple;
	bh=PlgQy4W5xujkUoV4WOx8P4W9T6Qdb6LIgHalUSFF0Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3yj+7uHeM7AzyLYSIBgcT6Av5POgQwtJmOD9ITM8iUGl/P3QdK8lUnHg6KEhoongOg64NU0Y7XJwfUYss/2Ellpa/ic32q4mPb0B7MMfd3b6NZh2hIXFMEu4Io+15hqkksSmMf7V3T4/k0ra+2ntsRUbBE0hDz3Y0bbE/0oFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXdaBvvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXdaBvvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79742C4CEF1;
	Thu,  4 Sep 2025 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006935;
	bh=PlgQy4W5xujkUoV4WOx8P4W9T6Qdb6LIgHalUSFF0Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXdaBvvhqz0QYRKGQNXB6aoEzT6sCMyV3XvExLCRJml5TOeDendih8TvlKcKP8lny
	 /NN9uKMjD9YS+TtknxGgQlhEUBqKQOpaPGYutVw+IyGBy3cnqF65YC9T/AwS+bqiIu
	 nHRjFwhuzSyqtA/6Pi9VC8M1oYP5yeHWHhs2b/rfLM3wpLlxrrQ8gbALZrG0dYPIn5
	 rtjhSEy7QUJufhLA4FaSdc9i8K8UKzbdkPIpnSeFaWQSLpyjk6YZzA63SzemLjTE7n
	 BsTQqR2gSn82khFm1uJ0VH62v0Z1GjDFL1MTAsNP8aBuWhsZGIO/YB8aJ+l30Sdhga
	 ZfpGLsVv52pvw==
Date: Thu, 4 Sep 2025 07:28:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] workqueue: Provide a handshake for canceling BH
 workers
Message-ID: <aLnMVqcHFQPnKHyi@slm.duckdns.org>
References: <20250904142526.1845999-1-bigeasy@linutronix.de>
 <20250904142526.1845999-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904142526.1845999-2-bigeasy@linutronix.de>

On Thu, Sep 04, 2025 at 04:25:23PM +0200, Sebastian Andrzej Siewior wrote:
> While a BH work item is canceled, the core code spins until it
> determines that the item completed. On PREEMPT_RT the spinning relies on
> a lock in local_bh_disable() to avoid a live lock if the canceling
> thread has higher priority than the BH-worker and preempts it. This lock
> ensures that the BH-worker makes progress by PI-boosting it.
> 
> This lock in local_bh_disable() is a central per-CPU BKL and about to be
> removed.
> 
> To provide the required synchronisation add a per pool lock. The lock is
> acquired by the bh_worker at the begin while the individual callbacks
> are invoked. To enforce progress in case of interruption, __flush_work()
> needs to acquire the lock.
> This will flush all BH-work items assigned to that pool.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to wq/for-6.18.

Thanks.

-- 
tejun
