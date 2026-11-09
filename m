Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247782;
	b=NVWesBPoAKnxbxdrX6nXzOFXluHMEzcEXWQ3JUfDOs3AHW6twaBq3rOZ8WrJsbEuJUgo
	 YVlTHrS45jA6xpWZDk+KyiKcjpsBSemDLR7G+R+2IHOukyDdo8ozx43o9ykqbh0NjtiR2
	 WRALJl5NV7dpyqb2lVWSDuhLCgO7ckKdn2+EIPHR4GW1d9SWhd+nD5l2tb4QrrpcBUoCD
	 0E/tVoUlCIQ5f6J25qFk7TafhthJz5bgynw6B9C38S14a3AvhqZi2vIahmbzPHPrzIv+9
	 BbhqCCcp4sFe35GTXsJOwjlCjpgoJ5RlshEidiVXLxCjHtKknsUaFLm7RahIySBFygQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247782;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hoQOzrsBfuekc5HffGWMwvLYL2nRUtXJwxmyC3goQbg=;
	b=YCGCn8+IlqD7H7/hM7frxD72FW9TRyZya9BcRZl0uSUVQO3wTd7Q+pc1HgIrviDGy5Ga
	 JGCy5H5MUKUpXpBlA928w47y2iPL1e97Ef5cviKiK3FUv9nIIMsk2Wmz1Y84iMWlhe+mJ
	 iGrZlTATQYUTFn4SlTrtD9dInd4lmcSMMK3VznBnOLd+jIFGE8VpBJiXjnFNqm2vTVNRY
	 sppNtYxqP3YEgp6gelLRKkRDCbRpXGyQLYZBIO4eTdd0TdEiHIKd+0E5Oi1TedqfF6NnS
	 klu8EQylcvtHQZAtRO4ydL3kwLJuDdn1AB5w9/8KEBOg6JVqhjPt9DsM2An67JY3OlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c1YnfyYH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cZnTZKI4;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F770606A338;
	Mon,  9 Nov 2026 18:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F770606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=c1YnfyYH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cZnTZKI4
Date: Mon, 9 Nov 2026 19:09:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794247778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hoQOzrsBfuekc5HffGWMwvLYL2nRUtXJwxmyC3goQbg=;
	b=c1YnfyYH4Jkf1wyvgFuiBZhOGHbif341DwyM9F/dA/kFZoJ3zmersEJqTTGNjl6Sracff/
	28jhNQ6RIu2Q6TygiohXin57t1gyEcrFcBLHQjaKl4DIp9OahytWc9vCOeIPIt+tLfprf2
	5J+gUM+rNO0rG789piUC0cSE3zcgxRXgQB58uzjNk8OeVpE0p06RemNywnkh4i8DBfHCF1
	DFYvantMZ5rOOqGO5STNwpg5fvMPIOCC6FjanFaIBo2c7bgNxEvKJgqBj0zRjEe6uz2vhT
	aWHRoFgrAyRJaWROKpTWT4x46Qi2fARrXTHtpjdMLPkFfClvOOsLm8fJtxLqog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794247778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hoQOzrsBfuekc5HffGWMwvLYL2nRUtXJwxmyC3goQbg=;
	b=cZnTZKI4NHAI3Dktunl/gh47SVwPWYsMWTdlJLbeHZtMW+885w8vJswl+YnbI88JZ+CAZO
	5ACkXliLEDXbP8Ag==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] kconfig-checker: Introduce PREEMPT_RT
 configuration rules
Message-ID: <avIMYMqTKkwAozk_@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-3-darwi@linutronix.de>
 <sashiko-outbox-202757@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-202757@kernel.org>

On Sat, 07 Nov 2026, sashiko-bot@kernel.org wrote:
>
> [Severity: Medium]
> Should this also check CONFIG_NO_HZ_IDLE?
>

Correct, it should be added, as legacy "compatible" CONFIG_NO_HZ might be
removed in the future.

>
> [Severity: Medium]
> Will any .config with CONFIG_DEBUG_INFO=y or CONFIG_DEBUG_FS_ALLOW_NONE=y
> still fail against the CONFIG_DEBUG_.* pattern rule?
>

Correct, both CONFIG_DEBUG_FS_ALLOW_NONE and CONFIG_DEBUG_INFO.* should be
handled.

>
> [Severity: Low]
> Is this rationale meant for CONFIG_DEBUG_KERNEL rather than
> CONFIG_DEBUG_MISC?
>

Correct!

Thanks,
Ahmed
