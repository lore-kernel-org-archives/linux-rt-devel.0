Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379326;
	b=fc1fkd/ecga1+gC+xuCza5FUUOrf0gtCAuxhfMzR/LZ0wFMX7gS+lcToF9LFPt7vA5IZ
	 TDL2x3T2Ee+rVoXvsH9LSox5P5tzSMr6gdzaiVN3DkHqR6zT5EauYyC7ofFF8eg75Xs6f
	 u3X7rqlAz8Fzmcvy2RC81Fq/Qq/3UdSAnmmWkxueNuTYipXLKyaUZa7d7OqEdRbtStgGb
	 zEn9UBGvnyHYqYJ0xK2HZYdCegkX7TwxV/h3f6ISUat5qlXFCA1JcPr8w4+6zk18225Fu
	 iJ4t2b9usplOgpTQMqZGsbY9fmmLvfeZG7V+U/v6eYguJ5pC2KvO+0IcZnpIWQASn3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379326;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KJSys14uiqyY3oEqw9LH65L7ZG7qUs2/g+sc0RbLbj4=;
	b=kiSPPSq2hdacBSu3f+nwOQoJ9Tq06D4d+HcmFxMJA3+zBCX3Yqek5kn/xQIC1JFoOwBT
	 A3SS4kyDqFZ/E1VPPcxlmAFLjD9g8AzUQ6k1ymN/m2sfScKtpKQhEnLWcLjvln2Z/bmAH
	 oHd+Hox8rheZ/MeJpFG4gJjJmsgpQFEA1G6IqOpEGWj2VP5Suf3ct267MBA35XXPKGIQK
	 mv9HhS5C3YKHg+x+LicKOijsyUOePaHPn0nSRI60xcGI3Emyx2TPtAANRCJbVion9/5uY
	 eZk+1Ruo7c4FYxq6nJwkiLRGrZ1BdR2rkbX04vykNISIMQ9qwbmY5PT7Lukgab2mYTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcrPVbeA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3C606A320;
	Wed, 11 Nov 2026 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcrPVbeA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880E21F00A05;
	Wed, 11 Nov 2026 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379326;
	bh=KJSys14uiqyY3oEqw9LH65L7ZG7qUs2/g+sc0RbLbj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hcrPVbeASthEXdl/qX9b+82u68k5Vv2zhnTJ+A9ovWkrsqLelYD0di2qFcAt8kYrC
	 LbuubXHck1dFdA8EYcwMod52tXVgC9DwrV0umQfd53M1v1YlUNGIkL7mWMiqdSEyDu
	 d8BnxJQYx7IWN8+OL9X8y9bixjA9BqYKx7kzLBKjlg95HMDSKVi34SU86NMa5cM79o
	 lKKIqU4S2XK4c+IAImrBkoiOSlE6eqS84XQimzuI/D/kZbKRpPVCopSjbtBtKSGZ2A
	 Kpg7OfRhVuqyMw+XI2DcYGQu1wvfws4l0/YWL7cfhmkm9aj+PuDNFTOhgvYTIlEa4U
	 0tTTSHjqq0axQ==
Date: Wed, 11 Nov 2026 07:38:46 +0100
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
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avQNdicGzL3De556@derry.ads.avm.de>
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
In-Reply-To: <20261106091922.7560-1-darwi@linutronix.de>

On Fri, Nov 06, 2026 at 10:19:12AM +0100, Ahmed S. Darwish wrote:
> Hi,
> 
> A month ago in Prague I proposed a kernel configuration checker:
> 
>     PREEMPT_RT configuration: Best practices with kconfig-checker
>     https://youtu.be/hqnOmdpGBdQ
> 
> This series adds kconfig-checker: a Python tool that checks the kernel
> .config against a set of YAML rules and reports all issues by severity.
> 
> The series also adds:
> 
>      - a PREEMPT_RT configuration ruleset
>      - a make checkconfig target
>      - support for ruleset overlays
> 
> Example:
> 
>     $ make defconfig
>     $ ./tools/kconfig-checker/check.py check -c .config -r preempt_rt
> 
>       Configuration Issues with severity = FATAL
>       ==========================================
> 
>       * CONFIG_PREEMPT_RT is not in .config
> 
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-configuration.html#config-preempt-rt
> 
>       Configuration Issues with severity = HIGH
>       =========================================
> 
>       * CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is unset
> 
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-configuration.html#config-cpu-freq-default-gov-performance
> 
>       * Below options are set:
> 
>         CONFIG_SLUB_DEBUG
> 
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-configuration.html#kernel-debug-options
> 
>       Configuration Issues with severity = MEDIUM
>       ===========================================
> 
>       * Below options are set:
> 
>         CONFIG_CPU_FREQ_GOV_USERSPACE
>         CONFIG_CPU_FREQ_GOV_ONDEMAND
> 
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-configuration.html#non-performance-cpu-frequency-governors
> 
>       ### ...
>       ### More output
>       ### ...
> 
> The same check can be run through make:
> 
>     $ make RULES=preempt_rt checkconfig
> 
> If no ruleset is specified, the target prints the available rulesets:
> 
>     $ make checkconfig
>       Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
>       Available RULES: preempt_rt
> 
> The overlay mechanism allows distributions, CI systems, and Board Support
> Packages to apply additional policy or override existing mainline rules.
> 
> For example:
> 
>     $ ./tools/kconfig-checker/check.py check	\
>           -c path/to/.config			\
>           -r preempt_rt				\
>           -o path/to/overlay.yml
> 
> or:
> 
>     $ make RULES=preempt_rt OVERLAY=path/to/overlay.yml checkconfig
> 
> Patch 09/10 documents the overlay format and gives an example use case.
> 
> My goal is to get this into the kernel and have Debian's PREEMPT_RT kernel
> packaging to use it.  I'd also like systemd to use it: its README lists 60
> kernel CONFIG_* symbols with different requirements severity.
> 
> Thank you!
> Ahmed
> 
> 8<-----
> 
> Ahmed S. Darwish (10):
>   kconfig-checker: Add schema for rule files
>   kconfig-checker: Introduce PREEMPT_RT configuration rules
>   kconfig-checker: Add the configuration checker code
>   kconfig: Introduce checkconfig target
>   Documentation: Describe kconfig-checker usage and design
>   kconfig-checker: Split schema to support component reuse
>   kconfig-checker: Introduce overlays schema
>   kconfig-checker: Add support for rule overlays
>   Documentation: Describe kconfig-checker overlays
>   kconfig: Introduce OVERLAY= for make checkconfig
> 
>  Documentation/admin-guide/README.rst          |  29 +
>  .../real-time/kernel-configuration.rst        |   3 +
>  Documentation/tools/index.rst                 |   1 +
>  Documentation/tools/kconfig_checker.rst       | 101 +++
>  scripts/kconfig/Makefile                      |  25 +
>  tools/kconfig-checker/check.py                | 686 ++++++++++++++++++
>  tools/kconfig-checker/rules/preempt_rt.yml    | 169 +++++
>  tools/kconfig-checker/schemas/base.yml        | 114 +++
>  tools/kconfig-checker/schemas/overlay.yml     |  28 +
>  tools/kconfig-checker/schemas/rules.yml       |  20 +
>  10 files changed, 1176 insertions(+)

Thanks!  I know some people who are definitly interested in such a
config policy checker.

Please prepare a new MAINTAINERS entry in a respin.  Are you planning to
maintain it after inclusion?


-- 
Nicolas
