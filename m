Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252566;
	b=pkUaUXUOSTSjD0rcgne3TneZNDc3O2XUkSndAmySVZC6B4+Yxfi3fj5yHxIY8nTnHRaV
	 cXW7lzeTn/Krw+KFFk29NUz3z/eHLzgodlf/IxuCuhqVrFScIa5QwRJvh6DG+KqeKVkz1
	 8KGyvlG2XRot3vGIA7w5LDj51vri2phm0BWXQq5Rj9WOwsOGJspxswjpM8bZBlxsnzCa+
	 +lCxq1dvP5Rs8+8eXyeHqVBVSC51chb1MvnFJ6e3q86f51mATkcCcZf7BfuXpwXl8ejjN
	 e1nEDrvtc2Pwy4oNoXLcdAor9n6ax/BrbGRudrgAGGcrV5WiftBTL0zOccdLjfPjCdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252566;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=jVCGfkX1RIb2wLuptqR9bvcqrBU7RikfXXwk8aiHdtg=;
	b=3cyche/gj09q+bOYlludwSJWNiPLkMzf0Z38AGCgxKjE2Db0rKQTrOmNSRXoesz1hFJ5
	 CrlwJhjE+zoqsevBTTn8dPmFtoPCt6BZefyEmSS43nCO3VwnLwZoDPmcBvk+AqRlkoeY3
	 qjco9GcPtlxHVBWXFc8dw6RY8BpPNlnIeQhWXiHFt1bHlXhElKysiC9Ejrnf3cwXyRC5K
	 NgOj3cso8VdP4U+64D2VMWBoicwPkfAOYMrAvGGaC4P4+XED1p1/iuzMnDQNkrx7/SoJD
	 d4oljJz+kTELrWzO8x2XJjsDWuvu+AIALHulmFbAhfn6+qc6AkE4Ms/onN0yqOahnOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="fjLY/+VF";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1tdcC3gh;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72621606A321;
	Mon,  9 Nov 2026 19:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72621606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fjLY/+VF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1tdcC3gh
Date: Mon, 9 Nov 2026 20:29:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794252564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVCGfkX1RIb2wLuptqR9bvcqrBU7RikfXXwk8aiHdtg=;
	b=fjLY/+VFMKmkJECS8BA54MKsiBaEKQwVQWNOJhtiDteQpWvrbKIrqkHjf5zblWYIJiPtkK
	lgeQwEvwE16OLyJkLnEGw8qyR5KBNy0Aqu61bSVGcpcJ9ny61pf/mBRbVgaq+mjJbrm5Q8
	0a2EdCPWcnn91A3QXhzTwMyEuhk7IMqglSF+vTYv6jHHXb9Us0HgMPxr94hSE7wqjJC50r
	UwIZFFiNDM8Lv9umbs+iuQ1YFmaGkFucGqiJ94vNSvocyG0jVy+zqh6LTyEgMHOkKFgt93
	f3iBY2d0+u7vb/kv3oJRZerE83lnc/rVeK8fFvRCFltXdAqqeBg7dk915ZHX3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794252564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVCGfkX1RIb2wLuptqR9bvcqrBU7RikfXXwk8aiHdtg=;
	b=1tdcC3ghJ0UbmhHHYclN2HiCG2v+MZMzGS2Afnr4k5ZSGRPcyZG7Dyz1gxXuElCVKArA8U
	u+t1w64Wk1JdLHAQ==
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
Subject: Re: [PATCH v1 03/10] kconfig-checker: Add the configuration checker
 code
Message-ID: <avIfEhE83UkF9g_Y@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-4-darwi@linutronix.de>
 <sashiko-outbox-202758@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-202758@kernel.org>

On Sat, 07 Nov 2026, sashiko-bot@kernel.org wrote:
> >
> > + def _find_issue_pattern(self, pattern_rule: PatternRule) -> Optional[PatternIssue]:
> > +	  """Check the .config against a pattern rule. Return found issues, if any."""
> > +	  if pattern_rule.expected == ExpectedValue.allowed:
> > +	      return None
> > +
> > +	  violation_type = 'unset' if pattern_rule.expected == ExpectedValue.y else 'set'
> > +	  docs_url = self.rules.get_docs_url_for(pattern_rule)
> > +
> > +	  violating_symbols = []
> > +
> > +	  for symbol in self.kconfig.get_matching_symbols(pattern_rule.symbol_regex):
> > +	      symbol_value = self.kconfig.get_symbol_value(symbol)
> > +
> > +	      if pattern_rule.expected == ExpectedValue.y and symbol_value == 'n':
> > +		  # Exclude the config symbol if it's explicitly disabled elsewhere
> > +		  symbol_rule = self.rules.get_symbol_rule(symbol)
> > +		  if symbol_rule and symbol_rule.expected == ExpectedValue.n:
> > +		      continue
> > +
> > +		  violating_symbols.append(symbol)
> > +
> > +	      if pattern_rule.expected == ExpectedValue.n and symbol_value in ('y', 'm'):
> > +		  # Exclude the config symbol if it's explicitly allowed elsewhere
> > +		  symbol_rule = self.rules.get_symbol_rule(symbol)
> > +		  if symbol_rule and symbol_rule.expected in (ExpectedValue.y, ExpectedValue.allowed):
> > +		      continue
> > +
> > +		  violating_symbols.append(symbol)
>
> [Severity: Low]
> Should _find_issue_pattern() skip any symbol that has an explicit
> SymbolRule, regardless of symbol_rule.expected?
>
> Only checking for opposing expected values causes two issues: when
> pattern_rule.expected is ExpectedValue.y, a symbol with a SymbolRule of
> ExpectedValue.allowed is not exempted and is falsely reported as unset,

I think you misunderstand what 'allowed' means.

'expected: allowed', means that an option is permitted. Quoting the schema:

        #
        # Expected value for the matching kernel configuration option.
        #
        # Values:
        #
        #   y        option is expected to be enabled (built-in or module).
        #   n        option is expected to be disabled or unset.
        #   allowed  option is permitted and must not be reported as a violation.
        #            This is to be used either by overlays, or to exempt a specific
        #            symbol from a broader `name_pattern` rule  with `expected: n`.
        #
        expected:
          type: string
          enum: [y, n, allowed]

So, for below policy:

  - name_pattern: CONFIG_DEBUG_.*
    expected: n

  - name: CONFIG_DEBUG_ATOMIC_SLEEP
    expected: allowed

having a CONFIG_DEBUG_ATOMIC_SLEEP=y should not trigger an audit warning.

But for below policy:

  - name_pattern: CONFIG_DEBUG_.*
    expected: y

  - name: CONFIG_DEBUG_ATOMIC_SLEEP
    expected: allowed

having CONFIG_DEBUG_ATOMIC_SLEEP=y should trigger no warning, but having
'CONFIG_DEBUG_ATOMIC_SLEEP is unset' should definitely trigger a warning,
even with the second 'expected: allowed' rule.

TLDR; the pattern expected: y / symbol expected: allowed case is not a bug.

>
> and when a SymbolRule has the same expected value as the PatternRule (for
> example, to give a specific symbol its own severity or rationale), the
> violation is reported twice—once by _find_issue_symbol() and once by
> _find_issue_pattern().
>

Hmm, the tool does not handle below case:

  - name_pattern: CONFIG_DEBUG_.*
    expected: n
    serverity: medium

  - name: CONFIG_DEBUG_ATOMIC_SLEEP
    expected: n
    severity: fatal
    rationale: Danger! must disable! Danger!

But on a second look, maybe it should... I'll think about it.

Thanks,
Ahmed
