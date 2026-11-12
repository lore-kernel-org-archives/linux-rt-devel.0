Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487006;
	b=uY81XL+Jry1bg4nDtPupZts/BjR/SAbkb1p86skiqDnaEdeIK5acNt7p9cfmjZ7A0Q8T
	 A2fD+/EfLooJ53k14HYBL8qN8YSxS1gMxiZcgvN6dL2YKebIeEdT121tqzihG3vI10a68
	 J2qd5IYkuYvHclfBlGNCFIAZjea8b7Xs2DJ2qjnb7fH7pXmzH4toQnaTXJJAjZHu/EBKA
	 ppQp/SUarvI3Qm9Jf3M86k4oWN4a1sf4z2fJdDg6+q/B1g5y91A3CKDR1ihAtzUfOp6MH
	 H9G36fITXSlFJlP8XjDj1MUfF3GGvdBXTgPafN8ookq6f5iSZMwW0ZtwsonJdG9xnFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487006;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=J4ynqIBSfVzw+rEpy/cObYYx4ZAAJOboAFNeWh8nIQM=;
	b=Axi+o4+0diFdNLRLuP72R6WF7yn9Pk061LesApuc5gaXDvT5lPCCC9Gn2A0rJEYWxomU
	 00Jz3bJCTqGjjlKoBWEYp0UQyovqsWHcQ9OreB1E9fsnPqt9zirsC6IudD3ETIwocyInT
	 13bGceenau4NNnCIgnt0LH94xs4LzqWWBnLGHiw4wuAg4TM0ZkLXaSeG100iLmtQPhtXu
	 AzzeWSkECFj0teFoUb1DquQ43e3p0X1SRknsaCoTvEqvHj95QTnN9b5jgDqEL9xOvErm9
	 /5RSeuRx+GP4A1lH+xPjwNq53lb1otuL7Djq++z5+oJWoDrghHEsOixC5pDfwifO3Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=elrslbwu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+TrMSOnp;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DE606A33A
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 12:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79DE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=elrslbwu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+TrMSOnp
Date: Thu, 12 Nov 2026 13:36:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794487003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4ynqIBSfVzw+rEpy/cObYYx4ZAAJOboAFNeWh8nIQM=;
	b=elrslbwuU38g9YXSXdn+gxraSJVQS06AFc4PCzYOi8FgK16zj0CIlI7H/wwXw9Hq3EgNuH
	2i2cKH1zeBWPqm84SsrHd8UECMMfaIXjReWc8NJmjkVauf0YwPjvee6IV800efkReP1oO6
	CAguI1PbmtzSP+j4zJEUnuhbIqTver7uiXUxxjlbzjvtYV42UBDwUadEFxK/WmNpnPkMNZ
	a0OJwjLc8QL0bQ/r5M+pLI2QRLT6Yhf3FGdRbOqTpGHZEYK8yK8os07Vlqt4yf9kznSjwh
	8Ki2QTx6iEhzcTyPztqTuFngAveN3RrkNTdHi7vwnlFFaif0kGB1peGx7O8Ayg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794487003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4ynqIBSfVzw+rEpy/cObYYx4ZAAJOboAFNeWh8nIQM=;
	b=+TrMSOnpqyRE1l2mBcpBINr+40Dc+KUcbbqYkobiGjraQQTEE8HBvtGoBcjL+SREyQWJgb
	DED1kAF/XbA3kQCQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
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
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avWy2r1BcDatzwo1@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <avQNdicGzL3De556@derry.ads.avm.de>
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
In-Reply-To: <avQNdicGzL3De556@derry.ads.avm.de>

Hi Nicolas,

On Wed, 11 Nov 2026, Nicolas Schier wrote:
>
> Thanks!  I know some people who are definitly interested in such a
> config policy checker.
>

Great, thanks!

I hope this leads to more mainline kernel configuration policies as well.

On the user-space side, it's one of the reasons I'm versioning the schema
in v2.  This way, projects like systemd can ship their own kernel policy
file, and that policy will be guaranteed to work with all future versions
of this tool.

So it's all mainline-first; both kernel upstream and userspace downstream.

> Please prepare a new MAINTAINERS entry in a respin.

Sure.

Beside a separate entry for the checker itself, I'll also add:

    F: tools/kconfig-audit/policies/preempt_rt.yml

to the 'Real-time Linux (PREEMPT_RT)' entry.

> Are you planning to maintain it after inclusion?

Yes, I'll be happy to maintain it.

Would it be OK if one or two people from the Kconfig side also step-up as
reviewrs?  Julian? Nicolas? Nathan?

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
