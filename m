Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043227;
	b=t6/H0D72P8fRPSu9/mt+HbgU0RBN3YSY60n+eKBfKB/Ab6fRM+FN+a/TIIb59xD0lEqq
	 kzb2Z8RulQI+HEeYY2WZG8p6y9AD8jF3h0i5C9t2NXD5vDbf3PsMUk+tQ+tz+RfCYZXXX
	 +F+3uuv93v3tPjvYYabLz0bScT11mN6+UubLt06hB/3iXTVLjQBoFm+kQF2lI7vlqdtln
	 0A9YVrHf6goLapputxW0JitMxl5qgFAiVV5r8fV/s8JrH+H4Mh5M3nFp1Hlp7pNB4uAOK
	 UFcMLaUfsFjrvQ6olxhtZP484UdGVTbQ9n18byYRzLjG+bTq+3mO+0xGV6ZonmR0/VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wYLMnWH689UA6djhwpK6fNUdplmnjtXsolXkGo2WkLo=;
	b=fjXNe2yyVoriWeS7EB0Xo35/l7yhNnFLuBEDv482MdOuYPPEoexXtJE7tOESgUfsJ/uU
	 c7420GZLpCcTWoqyo/Z017ZLelP25KwCtcFQMQU90Hcw1mmShTZ6SDJfj+TXLzmsP5m+V
	 iGTK9w2X3ipCRoUSqvp+SazvVv8JI/dUhwCbXA4xatDzJie8vFrayBzNX1+WiEQNbHD3h
	 oUqGI6MpVvUBbiSlI6zkn1gzUSZ8jNOPxEJqNV2OjWg+fMFNIpaNRR+Y8YVrO8vhW6Yn8
	 6VB9BMUEeZhrKPzK4/DpVOVg9P7r7X3LuIXg4NIon8mgSGqgd99+0OtHu8i65MdNhSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxoJzUTn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85A606A330;
	Sat,  7 Nov 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxoJzUTn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7891F008A1;
	Sat,  7 Nov 2026 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794043226;
	bh=wYLMnWH689UA6djhwpK6fNUdplmnjtXsolXkGo2WkLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxoJzUTnlGw9SpOqskQ2WT3vXb7ru3KBJWk06L05quyVvDatCIAgIS3CScFYgaZnX
	 rMByxXcKLQgNiUYzeJgD9oY6sgryR+wz9HyTxFjD5reO6CqqmJNd3WSiVIa2EbKYF2
	 UDLgg2s8fFCKUXh4RfoE0f1l++v88vvhyTlqQHm9fVlz27dJQxor+8JfkHfoxE9WB1
	 GNweVwwJ/6TFlpYIVkkNtZ5BbeT9HcGMiHGXWj/7Kfs0db1Otr8P+QomnbUuuGamvj
	 mw+eEUqcgJpzvy8cDSOJfnxqxDYvi02p7W6wuWQtZrRXBH53SDmm+yhUW8CVoNWiYw
	 L2B4lBnZ/Uhxw==
Message-ID: <sashiko-outbox-202758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/10] kconfig-checker: Add the configuration checker
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed S. Darwish" <darwi@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@redhat.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "John Ogness" <john.ogness@linutronix.de>, "Derek
 Barbosa" <debarbos@redhat.com>, =?utf-8?b?WmJpZ25pZXcgSsSZZHJ6ZWpld3Nr?=
 =?utf-8?b?aS1Tem1law==?= <zbyszek@amutable.com>, "Daan De Meyer" <daan.j.demeyer@gmail.com>, "Luca
 Boccassi" <luca.boccassi@gmail.com>, linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106091922.7560-4-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-4-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 09:20:25 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kconfig-checker: duplicate and non-exempted rules in
  _find_issue_pattern()
--

commit 8f6e383a6cf382d507daf59d926387f2a7971370
Author: Ahmed S. Darwish <darwi@linutronix.de>

kconfig-checker: Add the configuration checker code

This commit introduces a Python-based kernel configuration checker that
validates a .config file against YAML rule profiles and reports issues by
severity.

> diff --git a/tools/kconfig-checker/check.py b/tools/kconfig-checker/check=
.py
> new file mode 100755
> index 0000000000000..476cd13e59eb8
> --- /dev/null
> +++ b/tools/kconfig-checker/check.py
> @@ -0,0 +1,558 @@

[ ... ]

> +    def _find_issue_pattern(self, pattern_rule: PatternRule) -> Optional=
[PatternIssue]:
> +        """Check the .config against a pattern rule. Return found issues=
, if any."""
> +        if pattern_rule.expected =3D=3D ExpectedValue.allowed:
> +            return None
> +
> +        violation_type =3D 'unset' if pattern_rule.expected =3D=3D Expec=
tedValue.y else 'set'
> +        docs_url =3D self.rules.get_docs_url_for(pattern_rule)
> +
> +        violating_symbols =3D []
> +
> +        for symbol in self.kconfig.get_matching_symbols(pattern_rule.sym=
bol_regex):
> +            symbol_value =3D self.kconfig.get_symbol_value(symbol)
> +
> +            if pattern_rule.expected =3D=3D ExpectedValue.y and symbol_v=
alue =3D=3D 'n':
> +                # Exclude the config symbol if it's explicitly disabled =
elsewhere
> +                symbol_rule =3D self.rules.get_symbol_rule(symbol)
> +                if symbol_rule and symbol_rule.expected =3D=3D ExpectedV=
alue.n:
> +                    continue
> +
> +                violating_symbols.append(symbol)
> +
> +            if pattern_rule.expected =3D=3D ExpectedValue.n and symbol_v=
alue in ('y', 'm'):
> +                # Exclude the config symbol if it's explicitly allowed e=
lsewhere
> +                symbol_rule =3D self.rules.get_symbol_rule(symbol)
> +                if symbol_rule and symbol_rule.expected in (ExpectedValu=
e.y, ExpectedValue.allowed):
> +                    continue
> +
> +                violating_symbols.append(symbol)

[Severity: Low]
Should _find_issue_pattern() skip any symbol that has an explicit
SymbolRule, regardless of symbol_rule.expected?

Only checking for opposing expected values causes two issues: when
pattern_rule.expected is ExpectedValue.y, a symbol with a SymbolRule of
ExpectedValue.allowed is not exempted and is falsely reported as unset, and
when a SymbolRule has the same expected value as the PatternRule (for
example, to give a specific symbol its own severity or rationale), the
violation is reported twice=E2=80=94once by _find_issue_symbol() and once by
_find_issue_pattern().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091922.7560=
-1-darwi@linutronix.de?part=3D3
