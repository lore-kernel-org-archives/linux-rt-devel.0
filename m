Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD8282F5;
	Fri, 24 Jan 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749791; cv=none; b=ihsfggw7JCHpTvlY9ze3v4ARzBw4Gb3hToWZFfn2ZtSzNd4b4FBd55inKpUJS+4kfyvfRbS9j7bodpVx3qOAVX3tQm5Tr7Ev8LwAMGxkVrx4QiX4diEYUWtGJLuQY/MMKgu3TCVVRUAdVUBoGFMa9OEAtdC6PP0YHmXj0j9whtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749791; c=relaxed/simple;
	bh=P3L+wseA1XHaPMjgM88Rist9y60ogoQGC73uoM08TUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ9V5VwZRApsncb2LosgYmsIr4PJ+6NwHPN+50HwoQSNqwEXiTaC/5wj2tPF0AIeRDSTFw04HKUr6ECqVz3Qvhlk4yxxFoqeF3ypbmZdpVN5G8lfsGMFA9hm3f3N/Y6V4kIPCv2Lw6fyNPakBGqUfeqz9GFpXCTPz0QHVf5vxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cxlv3y+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cxlv3y+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D81C4CED2;
	Fri, 24 Jan 2025 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737749790;
	bh=P3L+wseA1XHaPMjgM88Rist9y60ogoQGC73uoM08TUo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Cxlv3y+mbfmWp5tjf5XEONh1qcL7o9sZfJzbYpbcmkQuEPt3IIwmOmVuw9hxlqC6m
	 sD3r0JosnVunbX4Fa+hB+ZbnOEgbncceswSh73J/9mCUbSNcoR3M+/wm9lMhaCHPKe
	 YvYOqXhF9DkIcf7hC68/zCbpBCB34C4yirwkYI1B2UpgbycbmRStirAMuOwkZDu0wO
	 jBUCWf/BSJb9fONNp9zBeBxRmjyUJAMCIZ2dktR69P8v7d/TIfJ+E09B9XLv1bw1b7
	 xlwvhGJrNZ2ppIKAr4KXn+rdo8QZq3AEbawhBml44yAFhld2SVnCKAlNJY4gDpofz+
	 wwGTr+v+LfAfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 27B66CE1419; Fri, 24 Jan 2025 12:16:30 -0800 (PST)
Date: Fri, 24 Jan 2025 12:16:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] clocksource: Use pr_info() for "Checking clocksource
 synchronization" message
Message-ID: <a519d1f3-8924-47a2-9b79-552be47ebf16@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250124185923.3610964-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124185923.3610964-1-longman@redhat.com>

On Fri, Jan 24, 2025 at 01:59:22PM -0500, Waiman Long wrote:
> The "Checking clocksource synchronization" message is normally printed
> when clocksource_verify_percpu() is called for a given clocksource if
> both the CLOCK_SOURCE_UNSTABLE and CLOCK_SOURCE_VERIFY_PERCPU flags
> are set. It is an informational message and so pr_info() should be used
> instead of pr_warn().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/time/clocksource.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 7304d7cf47f2..77d9566d3aa6 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -382,7 +382,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
>  		return;
>  	}
>  	testcpu = smp_processor_id();
> -	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
> +	pr_info("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n",
> +		cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
>  	for_each_cpu(cpu, &cpus_chosen) {
>  		if (cpu == testcpu)
>  			continue;
> -- 
> 2.47.1
> 
