Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EB409637
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738845; cv=none; b=CPPGLxm7VbLyIC/KCgm6/6K721njoj/j41U+UA3x+goO+Ed4073eDIDw01cephs1yyhRWFey5YX/nlVh8FZ3YtPt1MYDzXf732KB8WQE7qBJDTT0wiPSa9eRMwroZ2np17Uc5iKPrk+JY9PFJUhov2KiMXU51OOismkLPmra5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738845; c=relaxed/simple;
	bh=dsCvoTBfI3Q0uw5W2R8bfQ9TktztHWpOOMWspYhCGe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPFUhF2kgzPWOtiAgbM0sZxH3AQlP0/dtr4zAvObiQXc9HIZzNRCmfelcqplQjjQ+D70HkbYVwpjBRvsIzGPSQDlVY/GRCB+JWv0JjrgUobNDCwqeY8GzBKLpkIib50HwTN3pFZSSV9ObDN32zBjCsuJELTCpJXlaXQbbrsGbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1mT0Syg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pfl56ZMN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1mT0Syg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pfl56ZMN"
Date: Mon, 29 Jun 2026 15:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782738842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czGvkONbU3gBgqbKsbSlbR1vwEDU0TwjN9yj6UAgoM4=;
	b=k1mT0SygWH9fdcP3ueR9lmCcPcOTsb+gpIuGBeFrjhRP/xvgqs8lT5ZqcSr/vFQjW0qLz4
	GG9JHJwUisPTECmjDRO4adnorpJUNt65Fv6+zvCjAUAbOlATXRk0rlnN+AaCJhugvclxBF
	53jVcHzBGBoHayYOk10B4iFGsHs/FeHTkJgeuFI9ER1O/D1yTU09PLSfri90OkKRhv/xIA
	tcrCw4+FpxWJIEFxkYYO1P+7foHRdq3JJnlOpVdt+g/8jeAsdjG6emFf/YIO1xRaOXPHpi
	lGrkQtTVdgDBxybBWPeyXiWUZ1kxwk2gcp3o5MtJsatPz2JvWDyx0DB5402G3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782738842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czGvkONbU3gBgqbKsbSlbR1vwEDU0TwjN9yj6UAgoM4=;
	b=Pfl56ZMNZNA2CY1i9zNYEr5B9imW89ugJUC2JwyC4OjxoPmv6WS1e2ZkHVV/eQ0fL7D/kF
	wBv46H5D4AdbkDDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, clrkwllms@kernel.org, rostedt@goodmis.org,
	rmk+kernel@armlinux.org.uk, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH v2] ARM: enable interrupts when unhandled user faults are
 triggered
Message-ID: <20260629131401.tzYFtfKk@linutronix.de>
References: <20260629123349.134224-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629123349.134224-1-xieyuanbin1@huawei.com>

On 2026-06-29 20:33:49 [+0800], Xie Yuanbin wrote:
> PREEMPT_RT requires interrupts to be enabled when sending signals.
> 
> When do_DataAbort()/do_PrefetchAbort() triggers unhandled user faults,
> that is `inf->fn()` return a non-zero value, and the interrupts are not
> enabled within the hook function, force_sig_fault() will be called
> with interrupts disabled.
> 
> This can be triggered by user programs executing the bkpt instruction,
> with kernel config CONFIG_PERF_EVENTS=n.
> 
> Enable interrupts in do_DataAbort()/do_PrefetchAbort() when unhandled
> user faults are triggered to fix the issue.
> 
> Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This fixes the issue that can be easily triggered.

Sebastian
