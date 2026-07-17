Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EF385D9B
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271834; cv=none; b=NmZ6uCkV+Iq3NjpmS5urBd9+bqJTebKIRAjqKwq4jpEgSh5f8o3Ba2Jm5LQdb+5PBXPRmkFOqx0bL4JBlhRJt1kz7qdLZQAluF3yun9HSc1XrNSPk32jRbUYuxY8y+uHfX5jkaHAz2MHWzZcW66LO/xa18lsWhGZ/Lc0M8dKisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271834; c=relaxed/simple;
	bh=pNWxN+AIWX1hCY0ysCw0vfuqLn49Z1jODG6KBbe2n7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpGEy1MeJAcWkuUgqiQ71Z3sYznKq+tepk+X390Uu10etNj8lsmYVSjhQH/9mTFjmsJgyJTYghUDMG0j0P9D+IVJbmc7kb0XbFkgt6tAGpX8WllOERVkblClzWlaAXHt+K3u81wg57lTqRlWjjuJ/4imLvJUL/ZxZI7tPdTEVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QVlMtu5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMb0AeHz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVlMtu5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMb0AeHz"
Date: Fri, 17 Jul 2026 09:03:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784271831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6cmnfycj2KUStP4y16+55TqqyQRiz2ZkFVvw4HoG7s=;
	b=QVlMtu5oYdpL8vCova70McyDA8s5E6hK3ttlamnKs8onYsKMhOHnYX7VRxBnocTqVhhF0H
	YZovUehKcG5A7KjX2UWFrxPxICsdTHvCxUrD2aIso7davCtt3Og+9JMtEh5JFvPPb/B5dZ
	fOiLqvVO79+rP/7GQLKf4PKxtzuhyk+z5J80TUwR8M6tYB4ZSh6/H4NdSHg/pXU8afWWrB
	CHcQQDJbmh2VswojFQltLxyOZbJLdcF77KBceQNpOaliBGAa3+Mqewmg9WwZWdueKDsY0b
	81ILjNxGKhszt6stbpYZYSzYjXmthC/qBMzSrLS29z+uwZKOIwCfNYz1L6l0fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784271831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J6cmnfycj2KUStP4y16+55TqqyQRiz2ZkFVvw4HoG7s=;
	b=zMb0AeHznCksJfhHizeScTwUKgpupuXMrqjA8KRtRqr68auHRoa9dm5yolBPkEmQY7XGzA
	pEzEK2nXlcMSniCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Chiu <tchiu@tenstorrent.com>
Cc: anup@brainfault.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	kvm-riscv@lists.infradead.org, dfustini@oss.tenstorrent.com,
	greentime.hu@sifive.com
Subject: Re: [PATCH v2 2/3] riscv: vector: allow non-preemptible kernel-mode
 vector with IRQs off
Message-ID: <20260717070350.Vw9N1GT-@linutronix.de>
References: <20260715051629.1169645-1-tchiu@tenstorrent.com>
 <20260715051629.1169645-3-tchiu@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715051629.1169645-3-tchiu@tenstorrent.com>

On 2026-07-15 00:16:21 [-0500], Andy Chiu wrote:
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
> index 307ac369c3d4..6627e1a82e19 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -55,13 +55,16 @@ void get_cpu_vector_context(void)
>  	 * disable softirqs so it is impossible for softirqs to nest
>  	 * get_cpu_vector_context() when kernel is actively using Vector.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> -		local_bh_disable();
> -	else
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (!irqs_disabled())
> +			local_bh_disable();
> +	} else {
>  		preempt_disable();
> +	}
>  
>  	riscv_v_start(RISCV_KERNEL_MODE_V);
>  }
> +EXPORT_SYMBOL_GPL(get_cpu_vector_context);

EXPORT_SYMBOL_FOR_KVM ?

Sebastian
