Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483158;
	b=jMwMyNEoyfxMpmDAWYuiPZHH8D1fBkj+EtH8vYafXbWzQj46Hvbhl+tR68tD+DF9yb7F
	 csr0auCfonNgekIWompMrG/mT2aaffbFf+Lt3fpKi04TbfC2g+k84bHOVmDao2dwfKniU
	 4SNlJDGd+0pOlPzw/Uuvlf/FfoQlPC6D8lrJq/3AvEUXSwTseujM6/Qv9EL75Ow2wLaCL
	 lOpD1IPeP0UJzI8Rs+R1hkDqEhofOi6jq4wa43f+kHKVZockJ7oAvub/wl5OFowTbvY6/
	 xW6hARpprKjTgeqfADGzACrQ6ikg2WIVaaKu4AjH/saFSLOpybcxPwZcoFzGXOgxARA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483158;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=E30ohjkNEQQO5IQT4pDBP5MSNoM/lhLP9pcvjKk/Sew=;
	b=KltFpP5Vpix7VPEP+V60y21PZ+O3vh++VUN9djjliz2FbJ41BAV+c2D27x4Fr9+pGqM4
	 yEF96qfvWnTYlDq5CPiVMdfUjdl4RfsGjl+hkCKwoCkZoqy70nfOjvIAzJ5FlN0H9FV0D
	 BJtWYU+YoEDIPv8MhFfgKAaTtCBaMuqITurWRJ/DnYTUtNwoHLNAyiHTG9cv1O8jhHc3o
	 xui3BpccbzWMbfBtWLbTJFVgHJHp2dfatOKww/cnQdapf5JImiqRYNBbT9IQ9MolXeGme
	 8LYFFdnoZRHTr6ka/RiGSjGxCb/2Q3gIE7BcQMPLr7VAw+PtYEPfip8+Yp4qEhREIHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gJ3auvYB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gwLsnWYD;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A98606A330
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 11:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A98606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gJ3auvYB;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gwLsnWYD
Date: Thu, 12 Nov 2026 12:32:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794483154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E30ohjkNEQQO5IQT4pDBP5MSNoM/lhLP9pcvjKk/Sew=;
	b=gJ3auvYBsG3YbD8W8Ej/BMM/KtBvqmYRVkOTwlq2EbzZrAzCSgzS/Oqc1IoH38elxHmjVU
	DxT3O6WlVy6FwvOzGN6nQNnOjHTxEZcKjVwmwha5dZhMQEMpTYYrpJdlFAePemRVc1nwmH
	BgB5z1c716W9xroh9SPmVOundqzvqyEcgU83HY8yfNGJAj+xNDn3C/qQ8kjJ15rUCEWEtX
	oHkFTTMEEpGuuPH1cYunw8eL+SnxS4yV1EjOYZiYVLsSK23l36YBZmzeXVh+b8H0ZUKf0M
	amBij9kvvDJ66fEv1nicdvUD/vCB2zBHpsxucDoywaOwl8ZbUtwFDasIGKGc9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794483154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E30ohjkNEQQO5IQT4pDBP5MSNoM/lhLP9pcvjKk/Sew=;
	b=gwLsnWYD7XGOUzElu7f+eFnHJXWRvaGcgZTEWak+pKXU9nXSHM9+DEfep0qYoAOBmOSjSy
	VYmOxm4cKivkgrAQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
Message-ID: <avWj0PDoPWu2IkgD@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
 <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>
 <20261109003909.GB3429615@ax162>
 <avHIOS9NHwCCMITd@lx-t490>
 <avQNfFbeoMImmtre@derry.ads.avm.de>
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
In-Reply-To: <avQNfFbeoMImmtre@derry.ads.avm.de>

Hi Nicolas,

On Wed, 11 Nov 2026, Nicolas Schier wrote:
>
> On Mon, Nov 09, 2026 at 02:18:49PM +0100, Ahmed S. Darwish wrote:
> >
> > This is why one of the development rules at the top of the Python script,
> > at patch 03/10, is:
> >
> >   The tool must not depend on being run inside the kernel source tree.
> >   This simplifies invocation, testing and possible future packaging.
>
> Then, please move the argument checking from Makefile to the script
> itself.  Handling wrong arguments is good native feature for the script.
>

The script does its own argument checking, all through Python's native
argparse mechanism:

    $ ./tools/kconfig-checker/check.py check -h
    usage: check.py check [-h] -c KCONFIG_FILE -r RULES [-o OVERLAY_FILE]

    options:
      -h, --help            show this help message and exit
      -c, --config KCONFIG_FILE
                            .config file to be checked
      -r, --rules RULES     rules file to check against
      -o, --overlay OVERLAY_FILE
                            file overlay over picked rules

    $ ./tools/kconfig-checker/check.py check -r safety

    usage: check.py check [-h] -c KCONFIG_FILE -r RULES [-o OVERLAY_FILE]

    check.py check: error: argument -r/--rules: invalid choice: 'safety'
    (choose from 'preempt_rt')

And that's by design, as an independent tool that can be later packaged.

Regarding the Makefile's own error handling, I'll touch upon that below.

> As far as I have seen when skimming through the kconfig policy checker
> code, it does not use any Kbuild variables.  So, if it is being placed
> below tools/ and does not use Kbuild at all, and is expected to be run
> w/o Linux tree context at all: why do we need an additional top-level
> Makefile target for it at all (alongside of
> 'make tools/kconfig-policy-checker')?

The reason is the expected kernel configuration workflow, e.g.:

    $ make defconfig			# Generate a default .config
    $ make debug.config			# Add debug options to it
    $ make menuconfig			# Manually customize it

    $ make RULES=preempt_rt checkconfig	# Validate it
    $ make menuconfig			# Follow checkconfig advice
    $ make RULES=preempt_rt checkconfig	# Try again..

and so on.

So the "checkconfig" target fits that workflow, even when the checker
itself does not depend on any Kbuild internals.

The Makefile-side validation is also there to improve error handling for
that workflow:

    $ make checkconfig

    Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
    Available RULES: preempt_rt

    make[2]: *** [scripts/kconfig/Makefile:138: checkconfig] Error 2

Without it, the user just sees the lower-level script errors:

    $ make checkconfig

    usage: check.py check [-h] -c KCONFIG_FILE -r RULES [-o OVERLAY_FILE]
    check.py check: error: argument -r/--rules: invalid choice: '' (choose from 'preempt_rt')

Both error messages are correct, but the former informs the user, exactly,
on how to call the Makefile target.  This matches the aforementioned kernel
configuration workflow as well.

I hope this clarifies things a bit.

Thank you!

--
Ahmed S. Darwish
Linutronix GmbH
