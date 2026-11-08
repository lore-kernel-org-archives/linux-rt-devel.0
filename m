Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164371;
	b=qg59VbzyR7D+UgakoAi2YBQ8wZv+BTvJ1DHaFiqu+rye/bc25rzNot3gDUtN5dAhI5hw
	 lJuk90ZxUX/tU5ZcqF2d79fpg0IPGoQbHs2fruWswSN/+gXD6zPLkoIBczSY+Lc22FR9U
	 /b0SALNSp7gLQI0m31nJN6dFJwFKV+IkWAcmo3jnJJi1rw74Zg6IkJ7fYk5nFjaIX7zVu
	 nQsqyAQ2YQf54sooTlMVexFv8xyKzoGZ3u4eJenkr+M9F+nXWJo8QKgeuCisqBg/V3Hsi
	 UpAek4P2fs4pDwI2tFf2IstVn24WkoUOq9f08MsFlz2gyQCUOR4UeA5B686ZjsDXebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type;
	bh=EG4lPV5GD6MHzcQif79VS7R03/QdTS/TP7QGXLXitfM=;
	b=HWUe6SwZWvgi1J2CwS5BZ1AhVvzq1dR3O4r66sZCktReLTDVJkEZTGve1Y/YGQIC4ZB2
	 v0FU6LKdzT2lvNbt2iM/E68MJIZBlMdaRq4vMNKZGPl6m0ndB9idQ/Dfz8cWzX7r4CGG/
	 7DC0M2uZnVTt63XdoUonheEQQEkPs6SPBTbobMn+szlJ92cQaT5EK1rA82WUmLEoDhBao
	 +QL4ESacJ29fO9X2VNU+KRl73SslCaMqF9aXH+L7frKNEiVz0nSyw+vR1dkfLGqRM2+zC
	 bv4QyQMOgFNJjs1CfpyCuFvr0+ZwB2XJWfdDPvNdDIyomg8oUF0ylB13G9tncR9ntoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXjzAJP3;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF777606A322
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 18:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF777606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXjzAJP3
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-491aaed7565so123946f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 08 Nov 2026 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164369; x=1794769169; darn=lists.linux.dev;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EG4lPV5GD6MHzcQif79VS7R03/QdTS/TP7QGXLXitfM=;
        b=eXjzAJP3hBCja4nYaOzgL9o9EQQaIRAoV4rE15K7Z3xkg3Qu4pULnmi+4sQfRWLDrN
         mi0LI0jMHV1kmkgB5FZ2FKue7O7tOI9f502XbuPvQc6UFC8Afm66OOMUv28NUh+757H0
         5EVMJexSH9p4xgIAtGXy/cPwsO/pj/G0BV6XwnWVpoyljG1mo6BxSoZBqm7ZEzqbAJ0l
         2sRWDif1m2hV1/LvR2IFbNIlUOwC9XilevhF988x/4nye2OB96EbHoIEImY/obF8WLCU
         SReL0SyY+Br9fdXjrMkqIuJr1ch4ffkRaBRe23g/oEqSu4IZ+ySaGE99HgAo+gDoMWsc
         ruoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164369; x=1794769169;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EG4lPV5GD6MHzcQif79VS7R03/QdTS/TP7QGXLXitfM=;
        b=Z2XTjw/xo+W259tH7Lp+X1QhkQ6dW0GY6hFnjoZtrbo3U2tbtiTwpfp7mUJhtu9+Bh
         E85o5kS4oC7qxjQY7R1KEOT7k8xkQrtdi9R9tfXEYZFxWTok0htl+uXZdqzngALFbLLt
         D0dmRRXSFOLO39snQ/+ZeuYA3LqMPD7En7nP4xRrZmJ4pU1y0NWvF/gMQ7LscTFzL4Y0
         qxEcqwa1xpn4sdn5NKoFvdjZ0vxfH1CkaIVAqI/xH3XStV1i6jQ17cM87gmzKUHdPD8s
         TNZJ5o5fKX/JJtClRCa5wNIQnZ9HGp524K2WLoTO+WDsw0KSC3LX+C/nq84+UpQ/oDTT
         lA5A==
X-Forwarded-Encrypted: i=1; AL+hErHziR2EtrRPesf6SPk2OkZHpVQhsjO80TNefQJ9wPt92mZIpEmHd1ekIjuHEudqcOmYia9bHGNzst9Tz35/WA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8S/XOta1dcXVyCX35o1v94S3ux+Dhb5Ey5F+W7o9U4t1Xxz4YA
	2Z0FsscED2j7fUkDfJAJQx06CUcGO4xzXcAReEXDEh9JZvi1RFLY5/s6
X-Gm-Gg: AYBFou0/dp1Z82QkFafd2o6fGppEyC0MVVEYGM27vU9G23lN9sZUU2/ExE8MEwDQpkc
	KsKf0wb7MZ/Iu8ytCeTitkloIe4habIr2mS78iI8VOBEct/5NF5Iv1c+HAlxLPC2SKIgpmwWt9j
	WpVsTORAXT8pJbqSXvvs35iHR5aQSkzb6ijsOoaoXx1eDp6RKluUp5hVqUA0FUOAWeKqQ1Q5i7T
	2I8y9ViffFGqCr1Q1E4wFvIWhmkmTpNasIwEPzIkq+6am2+61cJCmN7dXVaouMXhL1eWDrgZoBv
	JHc40wYceIHFnbvCCWaGNiDCpQKP/jFaPWoyYrAKvDDa72E10lZ5M+z6Ghhl5Z9FOgSbTiMrxLo
	+uo+hKP6T7PDDsif3SthTcTcqOdX3tzetfjuNusBxMpK9fqlw7cVAIelbK7w9+A24FyzyMuiRjF
	WajU8zeAzUs+j06DphdrCxfhHICeh+8UzpkUWKjl620Nb/FiFV1qWYTEiCXHKo7Mbr5pe6UD1yx
	rvczIwWq+gzaeBwrvp35/Ef9hxjB0JLEu7U/N8CWLwHymfABlLV5aqiyzN+VL/Z7Q1d0XcYgwLC
	pCESqYo3ThgxAF6V325gGS7mlHCw9nktyGzprxnyfu5exoWvgtDNy1VUA92y3mwme/iGNixvJuM
	srlt2xCC4cZ1iPg/T5yed
X-Received: by 2002:a05:600c:34cc:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4b963c6ca22mr39222205e9.18.1794164368936;
        Sun, 08 Nov 2026 10:59:28 -0800 (PST)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm116251035e9.4.2026.11.08.10.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 10:59:28 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
Date: Sun, 8 Nov 2026 18:59:26 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, John Ogness <john.ogness@linutronix.de>,
 Derek Barbosa <debarbos@redhat.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 Luca Boccassi <luca.boccassi@gmail.com>, linux-rt-devel@lists.linux.dev,
 debian-kernel@lists.debian.org, linux-kbuild@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, arighi@nvidia.com
References: <20261106091922.7560-1-darwi@linutronix.de>
Content-Language: en-US
In-Reply-To: <20261106091922.7560-1-darwi@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RdQycBE5cMMMiUBKuDcENBzr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RdQycBE5cMMMiUBKuDcENBzr
Content-Type: multipart/mixed; boundary="------------DqGXJIIQNEu3dpPKwL26zFRE";
 protected-headers="v1"; hp="clear"
Message-ID: <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com>
Date: Sun, 8 Nov 2026 18:59:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, John Ogness <john.ogness@linutronix.de>,
 Derek Barbosa <debarbos@redhat.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 Luca Boccassi <luca.boccassi@gmail.com>, linux-rt-devel@lists.linux.dev,
 debian-kernel@lists.debian.org, linux-kbuild@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, arighi@nvidia.com
References: <20261106091922.7560-1-darwi@linutronix.de>
Content-Language: en-US
In-Reply-To: <20261106091922.7560-1-darwi@linutronix.de>

--------------DqGXJIIQNEu3dpPKwL26zFRE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ahmed,

Cool tool :)

On 11/6/26 09:19, Ahmed S. Darwish wrote:
> Hi,
>=20
> A month ago in Prague I proposed a kernel configuration checker:
>=20
>     PREEMPT_RT configuration: Best practices with kconfig-checker
>     https://youtu.be/hqnOmdpGBdQ
>=20
> This series adds kconfig-checker: a Python tool that checks the kernel
> .config against a set of YAML rules and reports all issues by severity.=

>=20
> The series also adds:
>=20
>      - a PREEMPT_RT configuration ruleset
>      - a make checkconfig target
>      - support for ruleset overlays
>=20
> Example:
>=20
>     $ make defconfig
>     $ ./tools/kconfig-checker/check.py check -c .config -r preempt_rt
>=20
>       Configuration Issues with severity =3D FATAL
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>       * CONFIG_PREEMPT_RT is not in .config
>=20
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-
> configuration.html#config-preempt-rt
>=20
>       Configuration Issues with severity =3D HIGH
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>       * CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is unset
>=20
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-
> configuration.html#config-cpu-freq-default-gov-performance
>=20
>       * Below options are set:
>=20
>         CONFIG_SLUB_DEBUG
>=20
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-
> configuration.html#kernel-debug-options
>=20
>       Configuration Issues with severity =3D MEDIUM
>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>       * Below options are set:
>=20
>         CONFIG_CPU_FREQ_GOV_USERSPACE
>         CONFIG_CPU_FREQ_GOV_ONDEMAND
>=20
>         Rationale:
>         https://docs.kernel.org/core-api/real-time/kernel-
> configuration.html#non-performance-cpu-frequency-governors
>=20
>       ### ...
>       ### More output
>       ### ...
>=20
> The same check can be run through make:
>=20
>     $ make RULES=3Dpreempt_rt checkconfig
>=20
> If no ruleset is specified, the target prints the available rulesets:
>=20
>     $ make checkconfig
>       Usage: make RULES=3D<profile> [OVERLAY=3D<overlay>] checkconfig
>       Available RULES: preempt_rt
>=20
> The overlay mechanism allows distributions, CI systems, and Board Suppo=
rt

On the topic of distributions, this seems *a lot* like Canonical's
Annotations [1], albeit yours uses YAML and supports matching option
names with regex. As you say about PREEMPT_RT configuration not being
"one-size-fits-all", similarly there are 100+ Ubuntu kernels that need
to adhere to a configuration "policy".

So this seems to be a real problem that others are having.

> Packages to apply additional policy or override existing mainline rules=
=2E
>=20
> For example:
>=20
>     $ ./tools/kconfig-checker/check.py check	\
>           -c path/to/.config			\
>           -r preempt_rt				\
>           -o path/to/overlay.yml
>=20
> or:
>=20
>     $ make RULES=3Dpreempt_rt OVERLAY=3Dpath/to/overlay.yml checkconfig=

>=20
> Patch 09/10 documents the overlay format and gives an example use case.=

>=20
> My goal is to get this into the kernel and have Debian's PREEMPT_RT ker=
nel
> packaging to use it.  I'd also like systemd to use it: its README lists=
 60
> kernel CONFIG_* symbols with different requirements severity.
>=20
> Thank you!
> Ahmed
>=20
> 8<-----
>=20
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
>   kconfig: Introduce OVERLAY=3D for make checkconfig
>=20
>  Documentation/admin-guide/README.rst          |  29 +
>  .../real-time/kernel-configuration.rst        |   3 +
>  Documentation/tools/index.rst                 |   1 +
>  Documentation/tools/kconfig_checker.rst       | 101 +++
>  scripts/kconfig/Makefile                      |  25 +
>  tools/kconfig-checker/check.py                | 686 ++++++++++++++++++=

>  tools/kconfig-checker/rules/preempt_rt.yml    | 169 +++++
>  tools/kconfig-checker/schemas/base.yml        | 114 +++
>  tools/kconfig-checker/schemas/overlay.yml     |  28 +
>  tools/kconfig-checker/schemas/rules.yml       |  20 +
>  10 files changed, 1176 insertions(+)
> =20
>  create mode 100644 Documentation/tools/kconfig_checker.rst
>  create mode 100755 tools/kconfig-checker/check.py
>  create mode 100644 tools/kconfig-checker/rules/preempt_rt.yml
>  create mode 100644 tools/kconfig-checker/schemas/base.yml
>  create mode 100644 tools/kconfig-checker/schemas/overlay.yml
>  create mode 100644 tools/kconfig-checker/schemas/rules.yml
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 2.56.0
>=20

I think the name will cause confusion.

We already have some "kconfig checkers" in-tree, like
scripts/kconfig-sym-check.pl

But actually, your tool is quite unrelated, because that one checks
'Kconfig' source files, while yours checks the user's '.config' file.

This has already caused some confusion in the past, for example in this
thread [2], someone misunderstood which one 'kconfig-sym-check'
actually checks.

In addition to .config vs Kconfig, the name is similar to
'kconfig-sym-check', but is not as descriptive about *what kind* of
checks it performs.

[1] https://lists.ubuntu.com/archives/kernel-team/2023-June/140230.html
[2] https://lore.kernel.org/all/ajo4DVWoSaEZtBDa@google.com/

- Julian Braha

--------------DqGXJIIQNEu3dpPKwL26zFRE--

--------------RdQycBE5cMMMiUBKuDcENBzr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavDGjgUDAAAAAAAKCRDElYPCBXNxIFSI
AQCDtDk4+oYBccZZgs+OoTuGu0I3s6o7yQXNz7whYRGfogEA7DEWidXa/2MWHU9Jv6J8SSA+WGkh
n7X58cRcqhQiDwk=
=cRiT
-----END PGP SIGNATURE-----

--------------RdQycBE5cMMMiUBKuDcENBzr--
