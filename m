Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043225;
	b=fBuMYgIfcVet9tXmUgnU5ChoFAHyTZ+4/nCt5KgjqmvfLBhO1aNR4v69l5l2U6GyOZP7
	 8znLUL7ZyUOMxYDCPBMaJzkZpAAUjBy+tnLOwGcCU7a/WoUSJaXvSjzsoQKHzqch+YQCy
	 /pYrZtzFhc3l7hm3i9ob8smqw0OQMz94+PMPGXEourBgnpn5sFcGxEyErk3LuJVwU2nCh
	 Q/Fd7BryBYaGM5ZyJZvTprZU9GSZNS9YcVqanV0H/kZ5v48ieRsWil5jShff9r0ogfzAG
	 +aIBbjc/GQWpxd1qncO9Z0FEFfS11HruzKrm5mQHcmH1QVEILQDFykwr+oXQ0rJrfKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OB7F34qy4xq47WLpMABCG9M/Pj+EQnVaet0E0R5Nom4=;
	b=pyB2vTe4XDRmH0a1ytDepJXpT5O4gygSwnK/Lu1AAHn8uaBCzwtlesElYG8H4PVevX+c
	 Nuq0fPPwSbXNqjTkifsCI6+xM/tyDYXqOQMmyE1PgM+UYldY6aVnlXRCVKXkEYViQuogl
	 vx9fWbyX4zh816xIUmotPi6lBCUTHDcIgQzhvDhbz01hZDkIIpd614emp+hqtvSxESTXg
	 IjiBQNcjcmXSiPmA+dL4+FIrWNZTdRlKWs0eaRLsbapkuyC+KCOdDQXmiX9jx1ouhoX7c
	 IP3+N0sqWFhnjWt5dVqCVL20GtDPG1ewVt+l8QK+2L/PcQBp7bqmgM+qTMjkDwLIPmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5Wg7aZd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62581606A326;
	Sat,  7 Nov 2026 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5Wg7aZd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259F91F0089F;
	Sat,  7 Nov 2026 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794043225;
	bh=OB7F34qy4xq47WLpMABCG9M/Pj+EQnVaet0E0R5Nom4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a5Wg7aZd6wqB/pu8vGdVq2lkM5V384ccO8bFXrZDEyNTBvv8EyAnjEq6KnXIfTBtD
	 WmFJ+Uyc/UrT5yKpGHp+aHF2XaXg4LzFGO13zsZ68mhHF30R7LiI051rPvxOa4WrOO
	 vYORgqSbOr4/0QAVd+USeB7kxW4bLY5gwE9KX789pAjURee7TedJ5KtRZ4RBhwicz0
	 lf/H0q04cB7/F6wVft4d3MZgGHDXGOUUiQefM9toJsy8Og7mJj62TXQw/uHkT73RKG
	 HvkgqMyZHJpwVfM35PUeX6bPiTJo5zXKlucjCac+9+e0c/ZFizfPKBOcw4Y30jB5IN
	 1bGWqr4+P3yZQ==
Message-ID: <sashiko-outbox-202757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/10] kconfig-checker: Introduce PREEMPT_RT
 configuration rules
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
In-Reply-To: <20261106091922.7560-3-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-3-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 09:20:23 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] kconfig-checker: incomplete CONFIG_DEBUG_INFO and
  CONFIG_DEBUG_FS exemptions
- [Medium] kconfig-checker: missing CONFIG_NO_HZ_IDLE rule in
  preempt_rt.yml
- [Low] kconfig-checker: wrong rationale and exemption for
  CONFIG_DEBUG_MISC
--

commit e938c2a281eebdc8d9e5b3bc80f568d54980b699
Author: Ahmed S. Darwish <darwi@linutronix.de>

kconfig-checker: Introduce PREEMPT_RT configuration rules

This commit adds a PREEMPT_RT configuration rules file for kconfig-checker
based on the real-time kernel configuration documentation.

> diff --git a/tools/kconfig-checker/rules/preempt_rt.yml b/tools/kconfig-c=
hecker/rules/preempt_rt.yml
> new file mode 100644
> index 0000000000000..5c1b80adc846f
> --- /dev/null
> +++ b/tools/kconfig-checker/rules/preempt_rt.yml
[ ... ]
> +  - name: CONFIG_NO_HZ
> +    expected: n
> +    severity: medium
> +    docs_hint: config-no-hz-config-no-hz-full
> +
> +  - name: CONFIG_NO_HZ_FULL
> +    expected: n
> +    severity: medium
> +    docs_hint: config-no-hz-config-no-hz-full

[Severity: Medium]
Should this also check CONFIG_NO_HZ_IDLE?

In kernel/time/Kconfig, CONFIG_NO_HZ is only a legacy compatibility symbol
used as a default hint, while the active "Timer tick handling" choice symbol
for tickless idle is CONFIG_NO_HZ_IDLE (which selects CONFIG_NO_HZ_COMMON
without setting CONFIG_NO_HZ).  A .config that selects CONFIG_NO_HZ_IDLE=3Dy
with CONFIG_NO_HZ unset will pass kconfig-checker without reporting that
tickless idle is enabled.

[ ... ]
> +  #
> +  # Debugging
> +  #
> +
> +  - name_pattern: CONFIG_DEBUG_.*
> +    expected: n
> +    severity: medium
> +    docs_hint: kernel-debug-options
[ ... ]
> +  - name: CONFIG_DEBUG_FS
> +    expected: allowed
> +    severity: low
> +
> +  - name: CONFIG_DEBUG_FS_ALLOW_ALL
> +    expected: allowed
> +    severity: low
> +
> +  - name: CONFIG_DEBUG_INFO
> +    expected: allowed
> +    severity: low
> +
> +  - name: CONFIG_DEBUG_INFO_NONE
> +    expected: allowed
> +    severity: low

[Severity: Medium]
Will any .config with CONFIG_DEBUG_INFO=3Dy or CONFIG_DEBUG_FS_ALLOW_NONE=
=3Dy
still fail against the CONFIG_DEBUG_.* pattern rule?

In lib/Kconfig.debug, CONFIG_DEBUG_INFO is a promptless bool selected by the
mandatory DWARF version choice (such as
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT) and forces a mandatory compressi=
on
choice (such as CONFIG_DEBUG_INFO_COMPRESSED_NONE).  Because only the exact
symbols CONFIG_DEBUG_INFO and CONFIG_DEBUG_INFO_NONE are exempted here
(whereas Documentation/core-api/real-time/kernel-configuration.rst allows t=
he
wildcard CONFIG_DEBUG_INFO*), enabling CONFIG_DEBUG_INFO=3Dy always leaves
companion CONFIG_DEBUG_INFO_* symbols that trigger medium-severity violatio=
ns
under CONFIG_DEBUG_.*.

Similarly, enabling CONFIG_DEBUG_FS=3Dy requires choosing either
CONFIG_DEBUG_FS_ALLOW_ALL or CONFIG_DEBUG_FS_ALLOW_NONE, so omitting
CONFIG_DEBUG_FS_ALLOW_NONE flags the more restrictive debugfs access mode as
a violation.

> +  - name: CONFIG_DEBUG_KERNEL
> +    expected: allowed
> +    severity: low
> +
> +  - name: CONFIG_DEBUG_MISC
> +    expected: allowed
> +    severity: low
> +    rationale:
> +      A menu option which enables the display of other debug symbols.

[Severity: Low]
Is this rationale meant for CONFIG_DEBUG_KERNEL rather than
CONFIG_DEBUG_MISC?

In lib/Kconfig.debug, CONFIG_DEBUG_KERNEL is the menu option that gates
other debug options (and is listed as allowed in
Documentation/core-api/real-time/kernel-configuration.rst), whereas
CONFIG_DEBUG_MISC enables miscellaneous runtime debug checks in the kernel
and is not listed as allowed in the documentation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091922.7560=
-1-darwi@linutronix.de?part=3D2
