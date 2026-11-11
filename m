Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379332;
	b=GisXD4OtKwM9IoRJFXnVOOKf7NVcjanKSYr1e3zzQAPWIwK1WpUSbiQP2DjqUNwm9Fhe
	 wF0RlL0wT1jP9uWqIsf5BfFjLazLKqbQIBEGJmuP4yfiwNPbcuP+Kvg97pW8jn4eVK+ud
	 kNJJO1W1LuJb6Lkp8NbgZAxPQN2Hfm/PcdBxF20qNMGkoshlgsaEXPRUJGnIzjFRuo2EN
	 kRSUQdXWRU8WhWDsD+Awly8jEv/KCzjsf9EeaSzXrmSIBayxgan4XCg71EFwp04tZc1l+
	 Q+q+Detg8HtdOGXhpl1C5mU6Dg7mmvjvdoWwJpsR2u18evOPjKfGGG6/DZuwWIgGUHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379332;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BqfUoDsUtJ55CvSWG39o66A+cikDrDRqEoXCzLkhX/E=;
	b=zBEuFb/PpN5J1Hh6897G34jNEQoTekhvc5DGRnc5XdZR2n9qZVpeE/bEpyjcmap5MJz/
	 +uU/kx/4gaDSQo6EWDVk0aPcL0owxJHEiXf4nZVlqS+zOnfPgmyLsmLfQT4iGaLs3P1r/
	 6UhD/4p62S/1w+KvEoS4aNqKAabZGucvweYZR6RRBF7MmyHWmQInUoz+H/xFg9KfFeXzW
	 4OZY47GeeD8sdB0oJpbuTCRw/+apYTLFrK0+YRI5PiTEfOE1eVWmn8OBeTbKK46I2xvoo
	 dMQRxZ3diyr04b9T74L8vGKuBEES8oEps39UbSmwwEyZ7U4dPhQ0C0poMiJUEMRPSOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyQk0TRk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B760A2607;
	Wed, 11 Nov 2026 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyQk0TRk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6138B1F00A0A;
	Wed, 11 Nov 2026 06:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379332;
	bh=BqfUoDsUtJ55CvSWG39o66A+cikDrDRqEoXCzLkhX/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyQk0TRkenFuaqwPAWagIphVBTiAsW2u5+fvVLCiAuFUzNGApWcgXnNqcphrXL9MG
	 5PoxztFckKqVa2SYUm9QU6fRxI6lwTg+7Bz4pqEY+l+CJl7TrGJtFblPpmAWzUen0Y
	 V8VUo/K1gFtD35waZ3gCfKv/eB83lR/R6WYDoDhoonlWw8xgMs217hN2YQUwkbqsDi
	 K/aWZ+cKn8Eqb+Oi5frhHoMYh+qFp7yKQfMLo52/9H3x+fATkjJavQHgRCc20Zpq0x
	 nV8Akp4XZqCZ9aBWbyB+twTjtkTsKLO9HxmPPRpOeIhbGBfBLkgIrEr6AEU7dnHth1
	 0JsWUi+GuiGEg==
Date: Wed, 11 Nov 2026 07:38:57 +0100
From: Nicolas Schier <nsc@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
Subject: Re: [PATCH v1 10/10] kconfig: Introduce OVERLAY= for make checkconfig
Message-ID: <avQNgXSWhODyc5Fc@derry.ads.avm.de>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-11-darwi@linutronix.de>
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
In-Reply-To: <20261106091922.7560-11-darwi@linutronix.de>

On Fri, Nov 06, 2026 at 10:19:22AM +0100, Ahmed S. Darwish wrote:
> For the kconfig checkconfig target, allow passing a rules overlay file
> through an OVERLAY= parameter.  This is mostly intended for distribution
> kernel packaging scripts, CI systems, and board support packages.
> 
> Document this parameter at the kernel's administration guide.
> 
> Note, the detailed overlay semantics are already explained at
> Documentation/tools/kconfig_checker.rst
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  Documentation/admin-guide/README.rst | 7 ++++++-
>  scripts/kconfig/Makefile             | 6 ++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index 77ffe4dcb85b..b62689bcda6b 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -263,7 +263,7 @@ The kconfig build system can validate the generated kernel ``.config``
>  against a selected rules profile. Running ``make checkconfig`` prints
>  usage information and the available profiles::
>  
> -  Usage: make RULES=<profile> checkconfig
> +  Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
>    Available RULES: preempt_rt
>  
>  For example, to validate the current configuration against the PREEMPT_RT
> @@ -278,6 +278,11 @@ selected rules profile. Each diagnostic includes a severity, such as
>  Apply the reported changes as needed and run ``make checkconfig`` again,
>  against the same rules, until no relevant diagnostics remain.
>  
> +The ``OVERLAY=`` parameter specifies an overlay file whose rules overrides
> +the built-in mainline profile selected by ``RULES=``. It is intended for
> +distributions kernel packaging scripts, CI systems, and board support
> +packages.
> +
>  For more information, see Documentation/tools/kconfig_checker.rst
>  
>  Compiling the kernel
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index d67a23730259..faaa8c16ab03 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -126,6 +126,8 @@ testconfig: $(obj)/conf
>  clean-files += tests/.cache
>  
>  checkconfig := $(PYTHON3) -B $(srctree)/tools/kconfig-checker/check.py
> +checkconfig_overlay = $(if $(OVERLAY),-o "$(OVERLAY)")
> +
>  list_checkconfig_rules =						\
>  	echo -n >&2 "Available RULES: ";				\
>  	$(checkconfig) list-rules >&2;					\
> @@ -134,7 +136,7 @@ list_checkconfig_rules =						\
>  PHONY += checkconfig
>  checkconfig:
>  	$(Q)if [ -z "$(RULES)" ]; then					\
> -		echo >&2 "Usage: make RULES=<profile> checkconfig";	\
> +		echo >&2 "Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig"; \
>  		$(list_checkconfig_rules);				\
>  		exit 2;							\
>  	fi
> @@ -143,7 +145,7 @@ checkconfig:
>  		$(list_checkconfig_rules);				\
>  		exit 2;							\
>  	fi
> -	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)"
> +	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(checkconfig_overlay)

Please add the optional overlay arguments right here:

	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)" $(addprefix -o , "$(OVERLAY)")

<bike-shedding>
... or let kconfig-policy-checker read the 'OVERLAY' environment
variable itself.
</bike-shedding>


-- 
Nicolas
