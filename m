Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239397;
	b=2q5BUlzBLhpVxOKGuxHbvzb4UYCrpAExwyNbZ81atztrUdgyRPHfb6G/l4q48ND64kfc
	 2pUKXlIC4rSiEZpHBbsL1cqdrnM/tWSJOjcqCpGj9pRulETPaM2YCFucBe3npw4ZEFmIe
	 HsdDSWb8FueVAxdcsTPgL39Yg4Gx9k/E7OWbhKYxNFGwih+yqUsAxpXhVKkAw1CRMcxbL
	 rWbxbntghmXdWHXhyF0q+7h0S46uCptV1Z2p6ORp5y2K0K1F/xShlzqCPzvjSkmz2Bs6X
	 eYb3Co+9/zIMpgjn+fM5NycNaaAON2+hpEAbGPSnyT9XtiPa9wElTYN8yJrlR4Xo3sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239397;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fzoqxKLaBDRZoQJ0AXTUnKYnidJqAGP4Dy7AtaGjvCo=;
	b=2A+aZgVKvxzP8h8Cn7rXGhCT8UoQjMcHBJGvfosRgxc1uUGg3R6KVMHq9Z9sSu0tlZqk
	 +uLoRBr7d3BX+3jjBLcbkU/GrXyRHMjF33Omqn0F0QCSKIGKSI26MnyQy8IuLQ1sNDAFN
	 0fkfLCE1ZTLb+K7Fsp1D2PoyCIET2H3WwiyEmI0+gCJjC+yrHOJBuQBSPnGM8YDllQJVl
	 Es1u9hdIdgdOENV9nvIP9jNEo1dfdGwqPsM9RucHMrfmfkFoPDB6rpqJwzHe/BgzOp06S
	 iM74En6lSiczDF6UTG1JlWEYaLM38WnOzCUdB6w7lN7mXs93bNZpj4gZAx0YZqrvYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="xo/2tJZh";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2pLz5F40;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED6606A325
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 15:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12ED6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xo/2tJZh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2pLz5F40
Date: Mon, 9 Nov 2026 16:49:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794239394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzoqxKLaBDRZoQJ0AXTUnKYnidJqAGP4Dy7AtaGjvCo=;
	b=xo/2tJZhqcNf7D4jyoWB/UQoVzCqQpuMa9Nlb2Pf2bU9MssqSyUsBI1MUiCqHURvByjmhp
	bA8PtHmi9RkL1utLq/aapRcP7eynGBpNulFDrHBQha06ZfgtKmai4ZC3i0OgQS906oSN75
	tCUMFbdKa6nzBNWjvgOxYsLU/BS68Plf2oPQaErGyi6x9DJdbyDCP7A3q9Gf0sWDrLY9+F
	xAWD/vA1pzETluwtHicgrqT24HT4+Qk/Cv1o57VNoblcfUvZxn3EocD/VPHSGS3Qrztznx
	FvStGzR6dmDCR/MOJi0V3mzMuJN9U47BbKL6cKvu7r3apLdBtPNmh11L/5m8wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794239394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzoqxKLaBDRZoQJ0AXTUnKYnidJqAGP4Dy7AtaGjvCo=;
	b=2pLz5F40pYHuIAoIKssXj3vv630LtYU0veP+T64OOa9utBSVrrIpd11WHox1P+bXcKWnfP
	wMWl74JHE8guctDg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Julian Braha <julianbraha@gmail.com>
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
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, arighi@nvidia.com
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avHroNa1vcxmCIOs@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
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
In-Reply-To: <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>

Hi Julian,

On Sun, 08 Nov 2026, Julian Braha wrote:
>
> Cool tool :)
>

Thanks!

> >
> > If no ruleset is specified, the target prints the available rulesets:
> >
> >     $ make checkconfig
> >       Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
> >       Available RULES: preempt_rt
> >
> > The overlay mechanism allows distributions, CI systems, and Board Support
>
> On the topic of distributions, this seems *a lot* like Canonical's
> Annotations [1], albeit yours uses YAML and supports matching option
> names with regex.

The difference is not only in the implementation details. Please see below.

> As you say about PREEMPT_RT configuration not being
> "one-size-fits-all", similarly there are 100+ Ubuntu kernels that need
> to adhere to a configuration "policy".
>
> So this seems to be a real problem that others are having.
>

Kernel configuration is definitely getting trickier.  That's why I've
contributed the PREEMPT_RT kernel configuration guide earlier:

   https://docs.kernel.org/core-api/real-time/kernel-configuration.html

Regarding the Canonical tool, it's the first time I see it.  From that
announce e-mail, it seems that they're using it for generating a .config:

   Starting with 22.04 (Jammy Jellyfish), Ubuntu kernels are now using
   only annotations to /generate/ their corresponding .config.

   ...

   $ ./debian/scripts/misc/annotations --arch amd64 --flavour generic > .config

Yocto also provides a very light concept of .config generation:

   https://docs.yoctoproject.org/kernel-dev/common.html#creating-configuration-fragments

But this tool does not conern itself with generation.  That is, Canonical
can use this tool to validate that they've generated the right thing! ;-)

> > For example:
> >
> >     $ ./tools/kconfig-checker/check.py check	\
> >           -c path/to/.config			\
> >           -r preempt_rt				\
> >           -o path/to/overlay.yml
> >
> > or:
> >
> >     $ make RULES=preempt_rt OVERLAY=path/to/overlay.yml checkconfig
> >
>
> I think the name will cause confusion.
>
> We already have some "kconfig checkers" in-tree, like
> scripts/kconfig-sym-check.pl
>
> But actually, your tool is quite unrelated, because that one checks
> 'Kconfig' source files, while yours checks the user's '.config' file.
>
> This has already caused some confusion in the past, for example in this
> thread [2], someone misunderstood which one 'kconfig-sym-check'
> actually checks.
>

Haha, good point :)

> In addition to .config vs Kconfig, the name is similar to
> 'kconfig-sym-check', but is not as descriptive about *what kind* of
> checks it performs.

Maybe "kconfig-audit" would be a good name?

It makes it clear that it "audits" a .config against a certain policy.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
