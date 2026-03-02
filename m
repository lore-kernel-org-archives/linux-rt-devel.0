Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E732ABCD
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447604; cv=none; b=ObeGdhpDJmxhZ3vsYl6LEt5EqYkXKEc+cj7gGnlCNACfP2tWSMv12LDrP0LLssAvr/fGSXLMWMj4O/C7iKaqmfOM02VO/otnp5MgUecssA5gupYtcKXmQ/MofGR1mxOGmi1QL5OYWUTezKWXgWEzaJs4+yJ4C+0YzGv3VOKCu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447604; c=relaxed/simple;
	bh=MbSOzDEm2OmCgL9BjGpViMtZsmeutFPVslXiuoycP88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plqF+6fqMAfehh5A7obhGnTMXq2P6SoA9FfBvdIPVb69d9KpkKFai6A179irfBsqOdJMzCmnOPSI4dRW9CTl7ETBY9U6LJ6oEAzcNwZZz3SdkjDU9bPeeDl7bA/+qzJvO+bQUPy3/07BfHe0JejW6o8Kk4ufNLjgdZ7Ws3bxIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=agDuY6VS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLfEhmvn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="agDuY6VS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLfEhmvn"
Date: Mon, 2 Mar 2026 11:33:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772447601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zpCsC76A/B8FEp6NQth+KPKVyK8PduJ80CXc9DihGY=;
	b=agDuY6VSHjOEVidIw9tmeJdXttkw0fiS17n6SGkI/4sKaOdW3x451mWnod8UdVEJ8Q4wky
	LqAV/voYBIHtT1nF+GjG4Tfldk5ScLL/XWqJjtBZD78+E1EhqJF50N5uP8kyIyXrPKc+14
	kBdAPp2MzMWtUDbwyQWyg7PvKWGgTMALIMZO5oJKYqsFmUL+yMR6FKKFtjara5awUReslW
	4IcE6aDrrGdKdEFrUVLA/jWNwYW7JgDn9OPx/Smbi1UwV+9QsKeLGviv5ThJdxjZCACznX
	M8WRXzoyT2Ii9b69DQRsHciEGEjW5kQCLq95P6o/gEy6wpe2ZUh/hX0+wJk2hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772447601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zpCsC76A/B8FEp6NQth+KPKVyK8PduJ80CXc9DihGY=;
	b=qLfEhmvnxGcsNliQohntBn3K6GLY3gY5LOFdBG1n0YwuyoOzlDQYN4lsWFmAV2BlNpy+m3
	i4YMjG1POEhtljBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/6] ARM: ensure interrupts are enabled in
 __do_user_fault()
Message-ID: <20260302103319.VI_GSa_5@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcS-0000000Awnu-1u0H@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vvzcS-0000000Awnu-1u0H@rmk-PC.armlinux.org.uk>

On 2026-02-27 15:19:08 [+0000], Russell King (Oracle) wrote:
> __do_user_fault() may be called from fault handling paths where the
> interrupts are enabled or disabled. E.g. do_page_fault() calls this
> with interrupts enabled, whereas do_sect_fault()->do_bad_area()
> will call this with interrupts disabled. Since this is a userspace
> fault, we know that interrupts were enabled in the parent context,
> so call local_irq_enable() here to give a consistent interrupt state.
> 
> This is necessary for force_sig_info() when PREEMPT_RT is enabled.

Reported-by: Yadi.hu <yadi.hu@windriver.com
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/mm/fault.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index ed4330cc3f4e..6c27ebd49093 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -190,7 +190,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
>  
>  /*
>   * Something tried to access memory that isn't in our memory map..
> - * User mode accesses just cause a SIGSEGV
> + * User mode accesses just cause a SIGSEGV. Ensure interrupts are enabled
> + * for preempt RT.
          PREEMPT_RT.
>   */
>  static void
>  __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,

Sebastian
