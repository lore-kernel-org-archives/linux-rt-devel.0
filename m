Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EFE4964F
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927122; cv=none; b=BXPo9gOkSQp0PMTKo8IfdNnmAUFVbfS0d1FeHrGKjutwUKPSjH56srxvdoDhSjyf+9w755vH2zfCNvD0ht16E0JVUeOGmL5jG2TADJFMeNnX/lcPgEFQNYQOP+Y4gcfPmzLMUYuG1hVA0f10tofkkZx8G7wCowFtXrw3McqvQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927122; c=relaxed/simple;
	bh=GAvbBO+3gCE4FFhULFUzZtgq1FYbyAHcvmDxLqDyQhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihmWlB41pKCp6a/uFsN5TRljjkfy+YVwLXxNEnIy65KDAzPuMZ/QSyI1mJA+ma8/jThj8htIHrqKuk1kTkmfQEhOyHIDViYCG8s2Ctwp2vcPTlCM0WVx8uIJ5D0nkrCFJuQnoGGFuHRxZH1F1DDpyM0HYaV5XuCrN3ULpI+bNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZ3V66Se; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7+F9tU8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZ3V66Se";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7+F9tU8"
Date: Wed, 11 Dec 2024 15:25:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733927119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JniKxZaKIckwpZT/I3NSeEVGJX/9DihSJgU5m9ylrJY=;
	b=oZ3V66Sew7gClffQOrHqY78VWXJUbUzqFXHLdb6mAJUHtN2lM53BRX0HxOUm21QQDlSmIH
	r2Ka4+RbT0M60LM3aE+tOiVwbNWJptwi+foi/VMCODdUgV60nNKhYtMPiBiCZJ3+Aadwuo
	n01zz9i0K1crpJHShTz83I6JmdMyw76zmLNbbqUPBDHmCbydd0cDAwFVRnHT9NOxM7++77
	4oZN6WBmzSPwKY2UPo38UjvNSx5un1kF5593+Ab9mC3RoZghFEXjR8kahVmgPkknbVNrBA
	kmZuBQiND+pNNb/1mE+4GpqyYThyVarfjAaNZ4VxZKr30fb19DyElD/6DjObXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733927119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JniKxZaKIckwpZT/I3NSeEVGJX/9DihSJgU5m9ylrJY=;
	b=d7+F9tU81J6PP0W/cr25Ib9q5pTZelDPbjs7enEICI6UojHUyU8/5vvl8k9YB0rsU4bX1d
	LahZ3EQ1IsluJFAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
Message-ID: <20241211142517.fhnOz46I@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210160556.2341497-4-arnd@kernel.org>

On 2024-12-10 17:05:55 [+0100], Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
> systems with 16GB of memory that made lowmem a particularly scarce
> resource, and the HIGHPTE implementation gave feature parity with 32-bit
> x86 and frv machines.
> 
> Since Arm is the last architecture remaining that uses this, and almost
> no 32-bit machines support more than 4GB of RAM, the cost of continuing
> to maintain HIGHPTE seems unjustified, so remove it here to allow
> simplifying the generic page table handling.
> 
> Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent a patch to drop HIGHPTE support on x86 today, see
> https://lore.kernel.org/lkml/20241210144945.2325330-9-arnd@kernel.org/T/#u
> 
> If that one gets merged, we can merge this one instead of the one
> that makes HIGHPTE depend on !PREEMPT_RT, but if we decide against
> the x86 change, then we probably don't want this one either.

Based on what I have written in 20241211140402.yf7gMExr@linutronix.de it
makes sense.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
