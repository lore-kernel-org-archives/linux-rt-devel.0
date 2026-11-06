Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956777;
	b=DF2EI/UJ75PGmmAknCUpLIDgsHTNo0hgFtrO7vnm1GF+5tY4vkMCkjfJb5wzKN7ZuC1z
	 imLXRv063EDPBG3OIpjYSRb9kwOv3050bkcrwd9Bo9Bmxzepku4HqbbAwxgk33w2fHZEm
	 sBYHVgAj2uuym3Rvn9jDJ2GLMHXpWU/SZg42PpMLK5XbrS/kt+TX/C5I717FVESVDhN1h
	 5GqSAoCwrkR8aDoqsb3XRW9XTFNjA1+6u3JIjIUw6uTsdFGg1TH7XPthtXefyFDoGuUU5
	 z/MOryTbdgPaEvdYsXfq5T0XAizCbDzWzeFYcizPA+4sRVuJikvdZ8wYQof4ZTS5mBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956777;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=CLqGhRWL28nklaizU2djeHKmMcMTeFFmrv6Rmqf/vS4=;
	b=OQbwwm3hSZ09YhZ7mi2HUhD1/Vm1RGVtlAvV7hVLK4eCw7S1iclISmwiKhYP04bMeQT4
	 A3dG1i/3xqqfZnhWwbjnnLJLG92c2+tfrfyUKbCrRnRbtC26W+t8sDaw0FSSzrLEfnT5j
	 hvUFF9cZocePoG5q8/C4DQQqu4wRZYOCEgH4TmgTjLil4TVUr1NwLMoIQ8Lxhs3BxrH/r
	 s01NRBwIdfCfuUxn46Q/aRMbAYO4sYYWE7oEefE/S4j7SnUDYOy++Tc6k6G0Gap1H1Gjp
	 v7VmjHNUCXbcRQBKR7TsOjSGDbxQT/rR+WkzFby26lkVIjZgtrtweSxE2E4uWoVSOBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F4cTQbfj;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jQaYRbf8;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB78606A329
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB78606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F4cTQbfj;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jQaYRbf8
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CLqGhRWL28nklaizU2djeHKmMcMTeFFmrv6Rmqf/vS4=;
	b=F4cTQbfjtJka3sRGuDUXf6gpEYUhVSYjrN6Tpk0Il9iWONC33smP4oY5nqTvkt70J374Q3
	hYU+oDDUWy4/MQKdClEYEFiryYPQfU6Im+40B8PCvZGgml0ej3/iA0k1EPFNP1TCxpt6q0
	GmZe9ff39mFeGvxT1YkegdUzdyg2svCEgclNjptZMhVMgKn3Oy0nKI7dtv7bEopnbdkvDQ
	6+lMUgY+jzbolcZJFrFuM1bG0lZ5coEUoL3gEHflWjYPzPdYLo+kex3/XDTqWI7P9sizEV
	L2ZJovHyOxtDEQ6qUEoy6agbxDsnYvzLLelp9Guhhko+t86Naev3waynk+aAPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CLqGhRWL28nklaizU2djeHKmMcMTeFFmrv6Rmqf/vS4=;
	b=jQaYRbf8s7LKY0qD3zjMOV47Zw34wEQCu4abMIbrqBCZEgVabqoFTgnP74cXDYWKT8ls2l
	CbUQIdLtfCEeXrDQ==
To: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev,
	debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Date: Fri,  6 Nov 2026 10:19:12 +0100
Message-ID: <20261106091922.7560-1-darwi@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A month ago in Prague I proposed a kernel configuration checker:

    PREEMPT_RT configuration: Best practices with kconfig-checker
    https://youtu.be/hqnOmdpGBdQ

This series adds kconfig-checker: a Python tool that checks the kernel
.config against a set of YAML rules and reports all issues by severity.

The series also adds:

     - a PREEMPT_RT configuration ruleset
     - a make checkconfig target
     - support for ruleset overlays

Example:

    $ make defconfig
    $ ./tools/kconfig-checker/check.py check -c .config -r preempt_rt

      Configuration Issues with severity = FATAL
      ==========================================

      * CONFIG_PREEMPT_RT is not in .config

        Rationale:
        https://docs.kernel.org/core-api/real-time/kernel-configuration.html#config-preempt-rt

      Configuration Issues with severity = HIGH
      =========================================

      * CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is unset

        Rationale:
        https://docs.kernel.org/core-api/real-time/kernel-configuration.html#config-cpu-freq-default-gov-performance

      * Below options are set:

        CONFIG_SLUB_DEBUG

        Rationale:
        https://docs.kernel.org/core-api/real-time/kernel-configuration.html#kernel-debug-options

      Configuration Issues with severity = MEDIUM
      ===========================================

      * Below options are set:

        CONFIG_CPU_FREQ_GOV_USERSPACE
        CONFIG_CPU_FREQ_GOV_ONDEMAND

        Rationale:
        https://docs.kernel.org/core-api/real-time/kernel-configuration.html#non-performance-cpu-frequency-governors

      ### ...
      ### More output
      ### ...

The same check can be run through make:

    $ make RULES=preempt_rt checkconfig

If no ruleset is specified, the target prints the available rulesets:

    $ make checkconfig
      Usage: make RULES=<profile> [OVERLAY=<overlay>] checkconfig
      Available RULES: preempt_rt

The overlay mechanism allows distributions, CI systems, and Board Support
Packages to apply additional policy or override existing mainline rules.

For example:

    $ ./tools/kconfig-checker/check.py check	\
          -c path/to/.config			\
          -r preempt_rt				\
          -o path/to/overlay.yml

or:

    $ make RULES=preempt_rt OVERLAY=path/to/overlay.yml checkconfig

Patch 09/10 documents the overlay format and gives an example use case.

My goal is to get this into the kernel and have Debian's PREEMPT_RT kernel
packaging to use it.  I'd also like systemd to use it: its README lists 60
kernel CONFIG_* symbols with different requirements severity.

Thank you!
Ahmed

8<-----

Ahmed S. Darwish (10):
  kconfig-checker: Add schema for rule files
  kconfig-checker: Introduce PREEMPT_RT configuration rules
  kconfig-checker: Add the configuration checker code
  kconfig: Introduce checkconfig target
  Documentation: Describe kconfig-checker usage and design
  kconfig-checker: Split schema to support component reuse
  kconfig-checker: Introduce overlays schema
  kconfig-checker: Add support for rule overlays
  Documentation: Describe kconfig-checker overlays
  kconfig: Introduce OVERLAY= for make checkconfig

 Documentation/admin-guide/README.rst          |  29 +
 .../real-time/kernel-configuration.rst        |   3 +
 Documentation/tools/index.rst                 |   1 +
 Documentation/tools/kconfig_checker.rst       | 101 +++
 scripts/kconfig/Makefile                      |  25 +
 tools/kconfig-checker/check.py                | 686 ++++++++++++++++++
 tools/kconfig-checker/rules/preempt_rt.yml    | 169 +++++
 tools/kconfig-checker/schemas/base.yml        | 114 +++
 tools/kconfig-checker/schemas/overlay.yml     |  28 +
 tools/kconfig-checker/schemas/rules.yml       |  20 +
 10 files changed, 1176 insertions(+)
 
 create mode 100644 Documentation/tools/kconfig_checker.rst
 create mode 100755 tools/kconfig-checker/check.py
 create mode 100644 tools/kconfig-checker/rules/preempt_rt.yml
 create mode 100644 tools/kconfig-checker/schemas/base.yml
 create mode 100644 tools/kconfig-checker/schemas/overlay.yml
 create mode 100644 tools/kconfig-checker/schemas/rules.yml

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

