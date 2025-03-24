Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9D1EA7C7
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Mar 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806189; cv=none; b=ChwygDyeCRO9Leai2armxq0QaT1qgbTICPEdn2LtMuKFKD3ofNW9POCFmZWrgj52cgKX2WjH7SmGCWpkEYIkTrfBqyICLGWRmPr5ZOSJmvSAoG6+d8hRa8e+XzSRbco2okaDMMyhkACraqjB2MxRuV0LkS+0vwnHN6hd9qcxDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806189; c=relaxed/simple;
	bh=+sToP3pixtP25svobMgGXAU3cGSfV1smaDpJO+OPZXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBlryZZqK2yBiU3dt+evggddxs+SxExaFXqIPuSze41wVHxPmvVBSM3DR6vA6UQEfzriIanEQ1uiMOuwDhF1kSouXBlydnYHoWe7WtlenSpWoYJvGAUlFiCAUhlpn1Lo16zsk+GqkGCBJukflZeAIztT4SLEACya++Q65h9eESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jDzC0VFa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Fo9saBI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDzC0VFa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Fo9saBI"
Date: Mon, 24 Mar 2025 09:49:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742806185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKBj0T72KDDkEXHVASentyqDmL/9h8qGAHGx41X5rGA=;
	b=jDzC0VFa6FtHleFSNly3Ld9eEUDm8VJGibifsdJPS19CYoUtBDXQ0M8PrvMt9LTGWUHi3X
	a7hXcexX4qlAPQ/V8MO724nsBTzh7EpH/n7knf93MoTbdOoVaqjALge5aqz6KOfqoByEXp
	PKaztVJ3aIEcbi9IJ9saeEccNIbM4iaVpqWp9TTqHKJkhL+dPXcnnxK0VhoCBzLvdh4rw9
	XXmPp3Jj8FvlhEx7503NENtbn4XweXASTnVyehXDLXCBA18Nqt/fSlWjeo0THXjgbTjHA9
	egyJ8YDCwQTQ+wKCyS9C8wU6p12qlyBLUx4a9z2eAeJxrQGDlwlB8V5u3PrJzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742806185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKBj0T72KDDkEXHVASentyqDmL/9h8qGAHGx41X5rGA=;
	b=7Fo9saBI0puPPdi3Hlhm2qT6S/3TzGP7e5soEcFPwJYWF5Vfl8XHwgEJursfv/ReVWqewW
	TQchQ1j9vbADuMDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: cuiguoqi <cuiguoqi@kylinos.cn>
Cc: tglx@linutronix.de, anna-maria@linutronix.de, clrkwllms@kernel.org,
	frederic@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org
Subject: Re: [PATCH] hrtimer: Fix the incorrect initialization of
 timer->is_hard
Message-ID: <20250324084944.z1J0Kf8c@linutronix.de>
References: <874izm2v02.ffs@tglx>
 <20250322082403.3126947-1-cuiguoqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250322082403.3126947-1-cuiguoqi@kylinos.cn>

On 2025-03-22 16:24:03 [+0800], cuiguoqi wrote:
> Hi tglx,
>  
> First of all, I'd like to thank you for your reply and for pointing out the email issue. 
> 
> As you've accurately noted, when PREEMPT_RT is disabled, it introduces a certain
> degree of ambiguity for kernel developers. So far, no malfunctions have been
> observed as a direct consequence of this.
>  
> This issue came to light during kernel development when using the is_hard flag, 
> where the expected logic was not achieved.Naturally, we opted for the more reliable 
> is_soft flag to address the situation.
>  
> Consequently, when PREEMPT_RT is disabled, there is a potential risk if developers
> choose to use the is_hard flag. I firmly believe this risk should not be overlooked.

You shouldn't try to set the is_hard flag without knowing its
implications. HRTIMER_MODE_HARD is what you should pay attention to.
Everything else is implementation specific.

> I concur with your analysis that one of these flags is redundant. In fact,
> it might be possible to consolidate them based on the overall requirements. 

A timer that is missing HRTIMER_MODE_HARD is not a automatically a
HRTIMER_MODE_SOFT and also a timer missing HRTIMER_MODE_SOFT is not
automatically HRTIMER_MODE_HARD. These depends on RT vs non-RT mode.
Wouldn't your suggestion influence the warning in
hrtimer_start_range_ns()?

> Thanks.
>  
> 
> Cui Guoqi

Sebastian
