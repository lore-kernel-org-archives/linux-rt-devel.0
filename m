Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A38634E
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678960; cv=none; b=pMYzEq34VHhnNhNYaLm8DJ3c9LdUp3unyPu2b+gi59x8awsajYtktFhrPeL2cvGyDF0DfC40y4bnYucllg7gPddFVlfCVpJN/87v7+DnCjt3qz43inqLyfRathS84Zo7gLiaUzDDrnPV2Wj99M5Fif9DKHDaL+pz/OariaJLMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678960; c=relaxed/simple;
	bh=aNPSmxxE7DLUHOh2f/aAFekHooCdFTgYLvurCDVow54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8upFpP6cbHb1LgsIXO3NBmkzQxzPskpGC4hdlyntp4j0RAviS9D1NlrXVpollIDfRZs5l0d6i7zGls2gEIFTHWSjl9YUjH6hx3/AgdkxvOLafqI6FM0fJ8XLw8+O0KESedmYnZCgXWbK8xn0BWTc3+DIAreSOv/gfrAplEyysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Au2bx+vh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nqpyo2/F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Au2bx+vh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nqpyo2/F"
Date: Fri, 20 Dec 2024 08:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734678956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hN7VeAC13CpfOWxLECpt456kevXmI0soSj+ZygDylNE=;
	b=Au2bx+vhnpUE1RcDPcFnC2yzOestj3JBdW/suv62YyS/8tMPIhjauoZUscgCH0jmPEfjIf
	0cYNmhw6xxEC7b88Y0H3zGOB+KXQIbzPcwv9E5LFjmrmmN4EYwwhGA+mIIyH4Q/++XqaUB
	1DNDRGT2FdBTxGKzYoAsYVb6YfRxApEpa2lKNFpWnjfo/uMAwSqxSqQuNsswjyDo5hATKo
	ZMU+PGCSJDXvy6+tsYXRoEzqX41fAretnXexS6+4BT5ptJFBXpuV50tPbi5h8Uwxywq0/j
	Rs39pxPoPjlwp494Rpt7RVqRo/Y1K25M3qq/8aEf0re01PsP7Lyg1IXZxSzMwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734678956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hN7VeAC13CpfOWxLECpt456kevXmI0soSj+ZygDylNE=;
	b=Nqpyo2/FHIXiNhYIHBMrDmJZU9gdwY9HvYtJmwbAfqBmrVQL7YuH/8dwmLw6ftvet+Vld/
	z2COIrFUjqD6W0DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, peterz@infradead.org,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, longman@redhat.com,
	mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Message-ID: <20241220071554.YAD157bS@linutronix.de>
References: <Z064BAsxrEe5zQV7@boqun-archlinux>
 <20241209160943.254299-1-ryotkkr98@gmail.com>
 <Z2Sdv6tSEoxiYW4e@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2Sdv6tSEoxiYW4e@boqun-archlinux>

On 2024-12-19 14:27:11 [-0800], Boqun Feng wrote:
> diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> index fc53e0ad56d9..7191a753e983 100644
> --- a/include/linux/bottom_half.h
> +++ b/include/linux/bottom_half.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/instruction_pointer.h>
>  #include <linux/preempt.h>
> +#include <linux/lockdep.h>
>  
>  #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
>  extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> @@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
>  }
>  #endif
>  
> +extern struct lockdep_map bh_lock_map;
> +
>  static inline void local_bh_disable(void)
>  {
>  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> +	lock_map_acquire_read(&bh_lock_map);
>  }

Could you put this before __local_bh_disable_ip(), please?

Sebastian
