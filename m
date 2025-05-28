Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB2212D7C
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 May 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412706; cv=none; b=NO6pG3T9WT/vSDdp8jLev5v6K8/k4kOHx5d6LzUR7garsHw+wopkz3N12GBWutbHcVQpYePR8j/H03zOlYXUIx4G91u09Kc4EPh683eKNgIoselPDCka3/0QQ7MXpIWVQnrqMzDwcP4XrrAhNgWt53L6dL4BBLfjH8JqIzAFnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412706; c=relaxed/simple;
	bh=th6onijDmEAqKQNBouMaWlCRYU8Gs+p4CxlQ9kwbO7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI8HzijI7NFkLNGpeRce8DlKoMbRX5cFF4xDm8I1JjkJVSUiWzO+tg3dsqCSe2rXIU5B7OdkOTJZ0OUHoCfUDB7XKCTtn0QJgN4OEAkE+BdHzcx5QSAIFuOt9FtpQEFdnJHafV5yV3Kam8pSl35lLxSEgnd1kFhUWkiB62vhU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nDuXxbNU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDVieAar; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nDuXxbNU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDVieAar"
Date: Wed, 28 May 2025 08:11:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748412700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16YBBqCiZhinPTnmceXSxQCAGhulKhyOEucK93L3/6Y=;
	b=nDuXxbNUG+IfucsOEgIpuE37NDn2WnRNjloqdPvW2+JNSU5hQG6xrJ/7SWBT/bKgzBkD69
	1Kb6a0w9XAU+Jo1HRDUQcr9b5RnhObUMWdSel8BIkJm1P5sU4IU9vTlq761MkMvtETDI82
	POyi2Y3+OYiyBaefWkOGqWBAdHZ5+bZTJKn9i79ZXi62zr51zt0pJCeqVBJRrLjqtii6+M
	ZzhBI/E4kUGcdCb392b6W3InVViO8eCFCh/PSFJlohyzlM1gNk23ALs5EEF3iPnjT8MhPb
	20SaJR9rSLnkXRqUWeNdmshSdJXPvYZQk99Wzwg8HKjYnL06ffqRiRNABhrGtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748412700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16YBBqCiZhinPTnmceXSxQCAGhulKhyOEucK93L3/6Y=;
	b=RDVieAarL/NxlTX3kgjO/lS4BPTq3Ap1FSSufSQNGwtzI5doPyQ1HkfDol92snApSGTgR/
	Wfd0NzbxdNpwJxBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [RFC RESEND v10 14/14] locking: Switch to
 _irq_{disable,enable}() variants in cleanup guards
Message-ID: <20250528061139.MduTfTBS@linutronix.de>
References: <20250527222254.565881-1-lyude@redhat.com>
 <20250527222254.565881-15-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250527222254.565881-15-lyude@redhat.com>

On 2025-05-27 18:21:55 [-0400], Lyude Paul wrote:
> diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
> index 6ea08fafa6d7b..f54e184735563 100644
> --- a/include/linux/spinlock_rt.h
> +++ b/include/linux/spinlock_rt.h
> @@ -132,6 +132,12 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
>  	rt_spin_unlock(lock);
>  }
>  
> +static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
> +{
> +	return rt_spin_trylock(lock);
> +}
> +
> +

no extra space, please. It appears this should be part of another patch.
That patch where the spin_trylock_irq_disable() was introduced.

>  #define spin_trylock(lock)				\
>  	__cond_lock(lock, rt_spin_trylock(lock))
>  

Sebastian
