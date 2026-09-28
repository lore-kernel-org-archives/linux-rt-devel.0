Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AC46EC69
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583855; cv=none; b=qmP83bocOPXzF7sYTpgPyrJhQsieHQ8Mc7IK75YpJrOYhQNo//NeN5nwTJ4MxGJbQWAy9mpBq12WNHUJDLV/J5pZYqwkgcOjlsrfxouzENoI69p8XCZi4d46Igds7SKP9S3jhszho7m0ZlO9AK1D4jsUE/izZdLrqyMPsm85BLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583855; c=relaxed/simple;
	bh=In+ZCVEKJu7O1xLlyIuk4GIGlvHKAbZJFfimuuDb8UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDQkIhJaTYODtmz2hWQLxMuBygsIpSDm3KB//UfvfnkShZPH579vzXe0y1YU01QQBcbCOG8SPeGpSpqPXS6Ww2pZ8oQdlPnqsL0KzCLIWWmwbod5mcYaEuF995btiCV7HxnehEG1NyaBASSfmqxX+DIY6e3/EMwi2WQbH4ESCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNFbQjts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KH3wuyxB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNFbQjts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KH3wuyxB"
Date: Mon, 28 Sep 2026 10:24:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790583845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aY2Jmg12jNs+yCWHxN7FfAyJ0S41hqe3zjAamjhfaI=;
	b=sNFbQjtsObmjeIgxWpXU8QceSok29vIz2nTDpLnewdG7gveN8LwcwoyR4Fz0X6RlBbzoYI
	frYWHzy2AYYfmy2AxGGA/Usk62XpypIKRhuQ++V3hXrUrF7l9uIvQi2D8P0RKYtao3R4Dl
	Ja3LQjMl9KaywEwF1PioU01CkhkR+A4Ng5UGpHPQVrsrPFfv/DgiMyqE/1K0w8QnX4U7I4
	bUyr/JzQBBAk4IjxCudNiI7Djhi630vNzEraqMuYOk5+BFtMGl1ApBXxjsTeO8WSu9GN0E
	dgtXkgiD6OeYaw6JU3iR25WtpcwCLw4LnJdOMcSe1Bq2zG7koYe1ZeJLN9SN+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790583845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aY2Jmg12jNs+yCWHxN7FfAyJ0S41hqe3zjAamjhfaI=;
	b=KH3wuyxBSQDvOqUnTpLnnj1DLOD4W2hvq92pyV0l06IQv4HTHYBW2yPR962KiE2cq5oSxf
	I41yuw6Sp6S5sXBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20260928082402.1iCSzDzY@linutronix.de>
References: <20260926143505.66024-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260926143505.66024-1-kmehltretter@gmail.com>

On 2026-09-26 16:35:05 [+0200], Karl Mehltretter wrote:
> On the return from interrupt path, __irq_exit_rcu() removes
> HARDIRQ_OFFSET from the preemption counter at the very top of the
=E2=80=A6
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming=
=2Ekicks-ass.net
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> ---

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

but=E2=80=A6
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -758,10 +788,21 @@ static inline void __irq_exit_rcu(void)
>  		invoke_softirq();
>  	}
> =20
> +	/*
> +	 * Wake the timer thread even if the interrupt hit a softirq or a
> +	 * section with BHs disabled. Only nested interrupts and NMIs are
> +	 * excluded.
> +	 */
>  	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
> -	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
> +	    local_timers_pending_force_th() &&
> +	    !in_nmi() && hardirq_count() =3D=3D HARDIRQ_OFFSET)

could you please do
	(in_nmi() | hardirq_count()) =3D=3D HARDIRQ_OFFSET)
instead? This will merge NMI check into the hardirq check, dropping one
conditional jump away.

>  		wake_timersd();
> =20
> +	/*
> +	 * tick_irq_exit() relies on in_hardirq() being false for the
> +	 * outermost interrupt.
> +	 */
> +	preempt_count_sub(HARDIRQ_OFFSET);
>  	tick_irq_exit();
>  }

Sebastian
