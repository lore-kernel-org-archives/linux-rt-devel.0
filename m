Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006120967D
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375900; cv=none; b=LnC4D+VmpXvf8Q7TWe45CjKKeq2Rl/RMO4U8uFZcEkra47rwMOkikv/Qf9mBuk5MdnGh34baOMwbX4Q2/a6hG3qz4k4Fj4wJzlYcYTHFUYxuoFrv5bICESyZ11VwOkQKn6uZAY9s7XGRmKWp9xNo1pedi7QsZEKKGBzLEFgxsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375900; c=relaxed/simple;
	bh=iNd/p6/s7ItEchmlzektaVLpoF9v4t1aAQx+8gimlz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAqvzDTfB0U99MmQZ44/K39aVR45qh+WLiJ2jSRWlwt7Gxm5nbu+Q5w+9DKbBjMaeKAkCIGZEXcaT2nnenTFdngvO4zv0aT7feAEZVl4nGA3hrMq0xytv0LbwhsdDst+AtHDAGFer73ghocrsHKcpoaxOXJY4ZZ5Zd1Aisg/3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=B5UrjMVX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B5UrjMVX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JsKn7GMdO3njzX47mOUfui0PU3MsuTcQm1Wy0OmjeYc=; b=B5UrjMVXgOIgssMSIb+9CLM0WP
	rGL8t4QfUJ34KPvfufe0lY0zRfoGFo0FlFUnm3lrFB3Ofu25gSA9f8e0mkR7yKK7oaYbjo/aeEFvi
	uzwhAz2kRhtcF9ZAm1MM9+Li5nNLA0meG9TrzSx8m1CangLnjFFjHxFaxIs/NLF2tQSMG1nIXgZg5
	QyXnSnY7Mrm94Ru3pLWBzHcuOwGbYZEpqjmj2fjqdPttE/Rptg5HSLhWUq5trUH1XJRb2AkW6Xy/X
	YTirpEFt05Qt7UoEJNJYxNlA6aqz6i+gqxYUXOHHVZsem9GeHCIiSnFg4wdNBsMhNJhCcVZils14U
	qfYySOOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiF7s-0006PZ-0r;
	Wed, 12 Feb 2025 15:58:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiF7o-0001Ek-0M;
	Wed, 12 Feb 2025 15:58:08 +0000
Date: Wed, 12 Feb 2025 15:58:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/9] arm: Rely on generic printing of preemption model.
Message-ID: <Z6zFD2HcAtQJWIOY@shell.armlinux.org.uk>
References: <20250212134115.2583667-1-bigeasy@linutronix.de>
 <20250212134115.2583667-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212134115.2583667-4-bigeasy@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 12, 2025 at 02:41:09PM +0100, Sebastian Andrzej Siewior wrote:
> __die() invokes later __show_regs() -> show_regs_print_info() which
> prints the current preemption model.
> Remove it from the initial line.
> 
> Cc: Russell King <linux@armlinux.org.uk>

Please either drop this - or correct it as per my r-b below. Thanks.

> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/kernel/traps.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 6ea645939573f..afbd2ebe5c39d 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -258,13 +258,6 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
>  	barrier();
>  }
>  
> -#ifdef CONFIG_PREEMPT
> -#define S_PREEMPT " PREEMPT"
> -#elif defined(CONFIG_PREEMPT_RT)
> -#define S_PREEMPT " PREEMPT_RT"
> -#else
> -#define S_PREEMPT ""
> -#endif
>  #ifdef CONFIG_SMP
>  #define S_SMP " SMP"
>  #else
> @@ -282,8 +275,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>  	static int die_counter;
>  	int ret;
>  
> -	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
> -	         str, err, ++die_counter);
> +	pr_emerg("Internal error: %s: %x [#%d]" S_SMP S_ISA "\n",
> +		 str, err, ++die_counter);
>  
>  	/* trap and error numbers are mostly meaningless on ARM */
>  	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
> -- 
> 2.47.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
