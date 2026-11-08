Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164385;
	b=NhPPQhubPJAciVDPfbAJBDY+z+G4CMOPeV4itMHooNH1TTvhb4aKP78sMyTjOObomPaU
	 jx2Bl/6HwvDpSgFnEJjfvQ89nTe6uZBZ3OGrLC5OISeE5O/1P9jQP4yRKuZ4AchJQFpPN
	 ++XOCFummIs/BnnPjdQgpHWzHDfi1U0T/SNNH0dGe2K7tvI8V39aX5yfFXedMivnFSFq1
	 G81KjCO6xo1fKT3zlIO92c48OdSrZB4orm8f/NukBgE9YaqXwU0tUtkH5OJ+m2erHGKTt
	 7tYSsRx+vNVyMqBu86rxlwLXOVrTmYczWmTL1b1nxOJ/ec8Jc3k2tMaGUGV1qKgdBLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type;
	bh=y63byGnQBDqvrsbSDi7RU9ZtkQTeXrhNmd2jcGqenW0=;
	b=up7YkVIIxn5tunAKyiVcLr9D9S8uQp6eV9CiUbQLhOPaP98YuHAPg3/DJwMmxgCkkDe4
	 GkaU0TitNyz7IaByhUjLlIp+EDQi+Gd8t+gLufBAYsppbmtpdXjtmXeG7PFnG/BjDMb5G
	 NGHhTqK76UFfEa8MaDL5mI7OZoB3T1TS5kqiaKouv2aQcKJmWoItsh5+wiypk1J8TOEDb
	 zO+i6WKrkMePIgHAvstYQA/MOgK9y3EBonH79yhQl7FUS3Hb8gzAlplZFZ5aNPIII6sb+
	 LhJmcMB/1QzfQlVXrFuJhqOhQBq8M+K1WXjQ/foOX26gyuirWzdxNQwtuy1IDOdBWSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oIjoN81I;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD29606A32A
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 18:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD29606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oIjoN81I
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so1550485e9.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 08 Nov 2026 10:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164383; x=1794769183; darn=lists.linux.dev;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y63byGnQBDqvrsbSDi7RU9ZtkQTeXrhNmd2jcGqenW0=;
        b=oIjoN81IoBxb9lBl/ifvM4lOPmrVEwa5nRSg6C+HMhK8eknmFk5f7daQCPHOrwndFK
         MBvN3XENv/+HqOzgIyYqDf60x2AG6G+tgDausgeVOs0yijCLHwjFTLuenq9BCW+YHILS
         rfdX9A/fYGji3Ze58nX3cstEqSWH3X073cicFe5D2tAb5if/FYIGiTaaygZBoVneRRqG
         85Dr/lriGSl92fYgSaYa68l1jyBtjBfQI0HN5om3fo996zqQRlDp8OJ0lNcqKBU+ymap
         PaxmIija21+Oio5ocbplvUFyg0KPqEFyrZO396t8FN7o7ZrKFD5uBHbJe7vxy2dvASHE
         YZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164383; x=1794769183;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y63byGnQBDqvrsbSDi7RU9ZtkQTeXrhNmd2jcGqenW0=;
        b=C5aIjqUj/kjZwPgRdoKtSQZbnYjL2ZLlo23+aIsdmjfk7MXUU6Tr/NHDBkuQSXVimU
         RMUCxefluDg3SxZ5LBWOd/gnMJCpLTd+LcUIIjS5OBYz10wLX4gdVDDmwm35nyw7gCKe
         7pbHLn7mrxSxiomY50tk6HNiiv1OuQ78/TllINYKaCM8Lbqd+nWFzGPpBKtFKY0Cb1zP
         uB20GdQHTzdXDyOMXbqOg51hZM8ACmM4XIu2QqN4QmSsU7iSIec4ZMwiRr1encbZam/u
         cVPlxt+ItDe+IQ+qmV7UF9Eq8QS/IYL6/cUEHh3nAeE/jD5KbMsLljrvjLa3POY3nPSs
         PutQ==
X-Forwarded-Encrypted: i=1; AL+hErGcbfhkcWZAkwfkWbXvSI6uz21mPIllOL8oIr4bZ8b6LQvfZgyS4bBBw2vmOtKVvPQjWsn5+igfnVpdko7yTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+KYaY3zn+Z5kihI0YLU4Z8X5DZz/dNrraSx2fu2eQHTXu5xlPD
	LG3PJjnvUBvc+YNlcuy3WKDZqcQe0HYl8ldniNVgI4Oz3tSnGhSn0H1/
X-Gm-Gg: AYBFou1m0qqigucyYvGTFSI3hJ8gmEh0CXGGQ70HPxjJsfw/NaXRp9ST2wW4sCFfO0V
	JiwVLGjVGhN1Ky7mffi0ruG58zh1aV+5u3/0UJ3LEejP+YN3J4i9iiNRScD77GfC8dE+ZCIyOaJ
	aqWF800aLk5YFCNxo6zvrck6suVu+HtY8k6bkNFFiujsXE0kCN1E3gFpOe/OBbEGUiQZvkqm3gJ
	kpLSMn6Mt4elM4dgjUTqZuj4XMJoAZ43D1O+xOBPXnpaNegVhChcvvMsfCDLEGYo5wZtAw3wwdW
	nBOgxNFJFqHSVnvMkxAiYFZF5fcGbDn6fqjJtZkY1P56Z5Ins3gruniIqyRtL9B14vZcLaLUZm8
	fR+4GW6QaTX2PivKVE6kqph2Vkh0h87xVRDF4N8pqVaQksbhBJ3gZyl0P9hpC8adGmVrhwRm/sc
	S2GY5H+Q+VW/YJX0pCOzMm6HoUkGjHsCszV+RJkdGfRxxim3uO8JcPVXSY/T5+ZYHiibRtAQzcC
	uYpiqjP/mECSK92DtwT7x+cVXG7bZTI7L25WBfAOASmWLgaJqpfT7eqcTiZdOS+i3EqfpMjueJ2
	kxbsz/XJd1PGBru4Yk80pG6fXNVN2kEblp+QTni+Hs/Ov1QtJzbfzsat0ae4B+Y4pSiRJ9n1Ccj
	iWKX86jaDUKfNB+EMTawl
X-Received: by 2002:a05:600c:6990:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4b963c7e550mr38189275e9.13.1794164383440;
        Sun, 08 Nov 2026 10:59:43 -0800 (PST)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f11172esm80401145e9.12.2026.11.08.10.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 10:59:42 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <9729a4c6-22f9-4102-b62f-c76a75488240@gmail.com>
Date: Sun, 8 Nov 2026 18:59:41 +0000
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
Subject: Re: [PATCH v1 03/10] kconfig-checker: Add the configuration checker
 code
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
 <20261106091922.7560-4-darwi@linutronix.de>
Content-Language: en-US
In-Reply-To: <20261106091922.7560-4-darwi@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wygbcu0eB30HJ7r218T0kJHN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wygbcu0eB30HJ7r218T0kJHN
Content-Type: multipart/mixed; boundary="------------XEeck90arMImjdiitW9iXW07";
 protected-headers="v1"; hp="clear"
Message-ID: <9729a4c6-22f9-4102-b62f-c76a75488240@gmail.com>
Date: Sun, 8 Nov 2026 18:59:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v1 03/10] kconfig-checker: Add the configuration checker
 code
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
 <20261106091922.7560-4-darwi@linutronix.de>
Content-Language: en-US
In-Reply-To: <20261106091922.7560-4-darwi@linutronix.de>

--------------XEeck90arMImjdiitW9iXW07
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/6/26 09:19, Ahmed S. Darwish wrote:
> Introduce a kernel configuration checker.
>=20
> Validate the passed kernel .config against a YAML rules file and report=

> problematic configuration issues by severity.
>=20
> For correctness, readability, and long-term maintainability, type-annot=
ate
> all the Python code and split the tool's logic into a clean set of clas=
ses.
>=20
> Create a proper Python objects data model for the kconfig checker to wo=
rk
> with.  Confine all direct YAML dictionary access to YAML files loading,=

> validation, and data model construction.
>=20
> Document the tool's development rules on top.
>=20
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  tools/kconfig-checker/check.py | 558 +++++++++++++++++++++++++++++++++=

>  1 file changed, 558 insertions(+)
>  create mode 100755 tools/kconfig-checker/check.py
>=20
> diff --git a/tools/kconfig-checker/check.py b/tools/kconfig-checker/che=
ck.py
> new file mode 100755
> index 000000000000..476cd13e59eb
> --- /dev/null
> +++ b/tools/kconfig-checker/check.py
> @@ -0,0 +1,558 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Kernel .config checker
> +#
> +# Main usage:
> +#
> +#     $ check.py list-rules
> +#     $ check.py check -c path/to/linux/.config -r preempt_rt
> +#
> +# Notes:
> +#
> +# - All code is to be fully type-annotated. Before introducing changes=
,
> +#   please verify type-safety using:
> +#
> +#     $ mypy --strict --no-warn-return-any check.py
> +#
> +# - The minimum required Python version must not be newer than what is=

> +#   required by the kernel build at Documentation/process/changes.rst.=

> +#
> +# - The tool must not depend on being run inside the kernel source tre=
e.
> +#   This simplifies invocation, testing and possible future packaging.=

> +#
> +# - The YAML rule files are only treated as a serialization format.  A=
fter
> +#   loading and schema validation, such rules are parsed into an inter=
nal
> +#   data model: Severity, Rule, SymbolRule, PatternRule, Rules, and ot=
her
> +#   related python objects.
> +#
> +#   All checker logic must operate on that typed model, and not on the=
 raw
> +#   YAML dictionaries.
> +#
> +# - Minimize external dependencies: this tool is also intended to be r=
un
> +#   from distribution kernel-package scripts in the future.
> +#
> +# Script exit codes:
> +#
> +#   os.EX_CONFIG          passed kernel .config does not match rules
> +#   os.EX_NOINPUT         input file(s) could not be opened
> +#   os.EX_DATAERR         YAML/schema/rule data is malformed
> +#   os.EX_UNAVAILABLE     Python version or dependency is unavailable
> +#
> +
> +from __future__ import annotations
> +
> +import argparse
> +import os
> +import re
> +import sys
> +import textwrap
> +
> +from dataclasses import dataclass
> +from enum import Enum, auto
> +from pathlib import Path
> +from typing import Any, NoReturn, Optional
> +
> +#
> +# Initial sanity checks:
> +#
> +
> +def error(message: str, code: int) -> NoReturn:
> +    print(f'Error: {message}', file=3Dsys.stderr)
> +    sys.exit(code)
> +
> +if sys.version_info < (3, 9):
> +    error('Python 3.9 or later is required', os.EX_UNAVAILABLE)
> +
> +try:
> +    import jsonschema               # type: ignore
> +    import yaml as yaml_m           # type: ignore
> +except ModuleNotFoundError as e:
> +    error(f'Missing Python module: {e.name}', os.EX_UNAVAILABLE)
> +
> +#
> +# Actual script:
> +#
> +
> +class KernelConfig:
> +    """.config file parser"""
> +
> +    def __init__(self, file: Path):
> +        try:
> +            self.lines =3D file.read_text().splitlines()
> +        except OSError as e:
> +            error(f'Could not open {file}: {e.strerror}', os.EX_NOINPU=
T)
> +
> +        self.symbols =3D self._parse_symbols()
> +
> +    def _parse_symbols(self) -> dict[str, str]:
> +        """Extract CONFIG_* symbol assignments from .config"""
> +        symbol_set =3D re.compile(r'^(CONFIG_[A-Za-z0-9_]+)=3D([ym])$'=
)
> +        symbol_unset =3D re.compile(r'^# (CONFIG_[A-Za-z0-9_]+) is not=
 set$')

What does this do for Kconfig's int, hex, and string options?

- Julian Braha

--------------XEeck90arMImjdiitW9iXW07--

--------------wygbcu0eB30HJ7r218T0kJHN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavDGnQUDAAAAAAAKCRDElYPCBXNxILlL
AQChbcKlonSXUa3TJuKdVVP0T/VTxOqGsEjOelartYR2RgEAyBM2bZtsfxLzLDLge3f2Jazt2mRu
u+hzj/qSZNHDuQ0=
=BT3m
-----END PGP SIGNATURE-----

--------------wygbcu0eB30HJ7r218T0kJHN--
