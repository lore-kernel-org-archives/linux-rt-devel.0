Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184755;
	b=0MD2JhcTkmGWKL5T9XtBdhchp9QalAakBM3d822c+imXk8CBNWdqQfciSGB6OWtWZvJj
	 53SJHT+YmSf97qAtspgRmlKMhUbFPF76CRVLm/oiLFJ6kCwW482wJLCbjd+MZmAyhskFm
	 DN6oMFXzcVv/4+UBdOibvJATAucPsIsF4CyQteGi4/zepjaiYnjAQk27tCkx2r0xMg5/7
	 Wz2Ndyd+DZ+hUr7Du5fX+/6Fnl3E8krDOeGQWiyn76p7DgzcSLBgZdktf+BMbHQiSnSqz
	 af4nNurmdSqg5BvYyfg0Oj6WtuzVvf8TyJpDgMLTEMZFTo4WXYveA/DGSXOufutrm7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184755;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+K+PG/oogt/eNAg9NDEXRDJuxcbPu513PzwhryksQVQ=;
	b=wun81L7oDlBgiLP+a5Ad2EZjFCwtT8bmuJnvDVJC1C/8tNsy00ePZ4vcmTlkhlO3PiAA
	 70ED/GHHwBtvwLZY+ULoNkCRApB1Xm5kfDP8LTI7m3255P0nzcng1MMVCOkfqX9i+5FH1
	 Xb5FJ5C8V1QVjeiSgrNEAWnWIUGg7zRDFkfxYCUOVrH6+ZNPWmRGgnrKhiug1xalQ5k+m
	 JkNHXjXAOHgX/QWi/mhUwnWNjwemC9yEeJbUW1IhA50sMRSpe5/X3Cr1+YyD6AgFzAC5G
	 17T9Yz3CuJYcAZMx1W/Bl/vrQcwGljBR4D/yCYsprHtuZPm2vLAU7YiLmr7j6PXWqrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXxX6eOM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87859606A31C;
	Mon,  9 Nov 2026 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXxX6eOM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0FC1F0089F;
	Mon,  9 Nov 2026 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184755;
	bh=+K+PG/oogt/eNAg9NDEXRDJuxcbPu513PzwhryksQVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YXxX6eOMtPSiFx//WISHWWxWTHIwzCPoYFHr1D0Tompx9dWFoe4dfc6luRvj7OTjt
	 0plc2V8LQcnEH/GLUSlwU8nHwxygzIUmlRpS2a04MxUkVbHs2XppGT8m0+4T4eTIVL
	 iHDUhZ5t6Zr60kboFLNhSBZEfzNvydUnGz98+gCdCoLWoVfONfU8mxLFU658Wriota
	 oLJXKQ/ru7W7RvI0m/SXriIaMQMCpCA2E7FeSBNocimr5l7XXZ1FUfCDSqOz5w6vO5
	 alHgAwxwB5XprdocJPsX/ESBEPcQ9DiHL0oDM8gWSULSJJCq1JO5A++lnRwasVTYn+
	 ZfJ3EuSIqgX7g==
Date: Sun, 8 Nov 2026 19:39:09 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Nicolas Schier <nsc@kernel.org>,
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
Message-ID: <20261109003909.GB3429615@ax162>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
 <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>
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
In-Reply-To: <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>

On Sun, Nov 08, 2026 at 06:59:45PM +0000, Julian Braha wrote:
> On 11/6/26 09:19, Ahmed S. Darwish wrote:
> > Add a checkconfig target to validate the current kernel .config against a
> > set of rules.  Select the rules using a mandatory RULES= make variable.
> > 
> > Example usage:
> > 
> >    make RULES=preempt_rt checkconfig
> > 
> > Use the kconfig-checker to perform all sanity checks.
> > 
> > Document the new target at the 'make help' text.
> > 
> > Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> > ---
> >  scripts/kconfig/Makefile | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> > index 5baf1c44ffa2..d67a23730259 100644
> > --- a/scripts/kconfig/Makefile
> > +++ b/scripts/kconfig/Makefile
> > @@ -125,6 +125,26 @@ testconfig: $(obj)/conf
> >  	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=no)
> >  clean-files += tests/.cache
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
> > +
> >  # Help text used by make help
> >  help:
> >  	@echo  'Configuration targets:'
> > @@ -154,6 +174,9 @@ help:
> >  	@echo  '                    default value without prompting'
> >  	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
> >  	@echo  '  testconfig	  - Run Kconfig unit tests (requires python3 and pytest)'
> > +	@echo  '  checkconfig	  - Check current config against sanity rules specified by RULES'
> > +	@echo  '                    Example usage: "make RULES=preempt_rt checkconfig"'
> > +	@echo  '                    (requires python3, PyYAML, and jsonschema)'
> >  	@echo  ''
> >  	@echo  'Configuration topic targets:'
> >  	@$(foreach f, $(all-config-fragments), \
> > -- 2.56.0
> > 
> 
> I think this tool may belong in scripts/ due to the kbuild integration,
> as was mentioned in the past on another tool review:
> 
> https://lore.kernel.org/linux-kbuild/20260428183101.GA3304253@ax162/

Yeah, while I would prefer for the script to live in scripts/ due to
being called from Kbuild, I am not sure if the rules/schemas belong
there? It might be better to keep everything in tools/ for that reason,
especially if this may be called externally, but I am open to other
thoughts.

-- 
Cheers,
Nathan
