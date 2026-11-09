Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254836;
	b=U5hXxXc10RpkluC7UmlM8Sy8sp33kAJZv06nxGDFDof0/tqbT2Cn3jkeO3uWraQ6EQfJ
	 Pi7ZQATsjhWhhcNqaAdn0wCKbw8/JBuvtb+wH/jHBpUj52TePK3mSsUklW6C2HLrj9QgH
	 xErCZbpyjChdTMqbhzShvoUzfr4Q+lpgrzVKnO8LU39eq/uu7SzEswk6Gy0k6iH2D4+Oa
	 JwCk13glag7SQYu6l9LQwPt4K2M3RpTI9dHWN9+QZHFLuA0sikvcGGv6C+B/BjvUm6C9Y
	 hol/89yNAE5lpknMlZzXCVgIsdiEuPRMzTNzGM+OxOEkVO/bTHy8tHUAOluvMgD72mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254836;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yRz3xBS2P6QB23UW9SPrskdtcdbexIqa29HxXhxwnyc=;
	b=ZJM/s3OOYa5lproxiKI6v18pdxuo/1IojAw0vtbOY5bctPcU2XWpSgOjLAzw+fayJ5nI
	 PjCFqupZ4EXFH4kNVM8vZHwofbvBhjAbDhPv9m/Y/i5BDe8ilvQ2xzVv/cGdlNFyG1mwI
	 PFR2R8gIW22PDVAaUa6pCcqqHouLsrxEagBfwQUXZJLf6GRegCIFMPPZCQ1mwH0FsByDT
	 GaTL+jy1abI29QOtogufXHItGpTdIq+qr/BBrvOHbEAJeQKXIs5j7eZEFSfJ56eH/yoNG
	 AL6KXuVT+uoe6QBX6jGKEBby8qpAxtzXRCimPnEYWuOuPMghS2e8hIi6NSD+ODcmskQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1yaSpnxb;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Lq9+W8xG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF3606A332;
	Mon,  9 Nov 2026 20:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6FF3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1yaSpnxb;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Lq9+W8xG
Date: Mon, 9 Nov 2026 21:07:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794254833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRz3xBS2P6QB23UW9SPrskdtcdbexIqa29HxXhxwnyc=;
	b=1yaSpnxbovoH8DcGVOVIMJL9Az88a0SGbTS3bMkFvGcQ+RD6tW2e6AH6d0Wg4X6Z1j8GaM
	dxvrPPKg7lg2BFVOdzeAX0tRB0SA92IFwFEl1p72wqlq5MektW7DukRuClJvIqHStKK3ks
	SQeVdIOprrbGjTCOkA5FYhWL1ZzXAiuUZ0LKWPAo9yU3C45AEmIZU0KwCluYhPe7zHs8Nk
	kN6EYnLYWkESkQ9HUSnu7T2n+P67zZq7CE/rJrc1WQAYnVSEcFShsgLGtIuZeLXVvYN+PQ
	MqiF8UdD0mUerK01lK+zm7wIbPTGwz5nEO+QUfIB6iSCwLH/gAeeH0yhP58v1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794254833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRz3xBS2P6QB23UW9SPrskdtcdbexIqa29HxXhxwnyc=;
	b=Lq9+W8xGRwCZ/RcDWGQ44nuGzp9INi8Xrq8+3iktck6bvjvXB854avzo9gr3d7qXi0FRCV
	HOxH5FqIXHnRGDBg==
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
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
Message-ID: <avIn71Md3LtNaYje@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
 <sashiko-outbox-202759@kernel.org>
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
In-Reply-To: <sashiko-outbox-202759@kernel.org>

On Sat, 07 Nov 2026, sashiko-bot@kernel.org wrote:
> >
> > +checkconfig := $(PYTHON3) -B $(srctree)/tools/kconfig-checker/check.py
> > +list_checkconfig_rules =						\
> > +	echo -n >&2 "Available RULES: ";				\
> > +	$(checkconfig) list-rules >&2;					\
> > +	echo >&2
> > +
> > +PHONY += checkconfig
> > +checkconfig:
> > +	$(Q)if [ -z "$(RULES)" ]; then					\
> > +		echo >&2 "Usage: make RULES=<profile> checkconfig";	\
> > +		$(list_checkconfig_rules);				\
> > +		exit 2;							\
> > +	fi
> > +	$(Q)if ! $(checkconfig) list-rules | grep -qw "$(RULES)"; then	\
> > +		echo >&2 "Unknown RULES profile = $(RULES)";		\
> > +		$(list_checkconfig_rules);				\
> > +		exit 2;							\
> > +	fi
> > +	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)"
>
...
>
> When either module is missing, check.py writes the error to stderr,
> produces no stdout, and exits with os.EX_UNAVAILABLE.  Because the POSIX
> shell pipeline ignores the exit status of $(checkconfig) list-rules,
> grep -qw exits 1 on the empty stdout and the negated condition enters the
> branch.  That reports a valid setting such as RULES=preempt_rt as an
> unknown profile and runs $(list_checkconfig_rules), which invokes check.py
> a second time and prints a duplicate module error on the same line after
> "Available RULES: ".

It works, so there is no reason to complicate things.

For example, invoking the make target from a container with old Python:

   $ make checkconfig
   Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
   Available RULES: Error: Python 3.9 or later is required

   make[2]: *** [scripts/kconfig/Makefile:138: checkconfig] Error 2
   make[1]: *** [/home/darwi/linux/Makefile:772: checkconfig] Error 2
   make: *** [Makefile:248: __sub-make] Error 2

and:

   $ make RULES=nonExistent checkconfig
   Error: Python 3.9 or later is required
   Unknown RULES profile = nonExistent
   Available RULES: Error: Python 3.9 or later is required

   make[2]: *** [scripts/kconfig/Makefile:139: checkconfig] Error 2
   make[1]: *** [/home/darwi/linux/Makefile:772: checkconfig] Error 2
   make: *** [Makefile:248: __sub-make] Error 2

The duplicate error, which is a single line, is no big deal. IMO, it's
better than complicating the Makefile for that single edge case.

>
> In addition, grep -qw treats $(RULES) as a regular expression with word
> boundaries against the comma-separated output of list-rules rather than
> matching an exact profile name, and spawns Python twice on every valid
> invocation even though check.py check -r already validates the profile
> name.
>

That's good catch; will fix.

Thanks,
Ahmed
