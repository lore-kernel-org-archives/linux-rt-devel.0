Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043232;
	b=d7CN2YXwk5nMJN7Pu+5IjAfQWEy8rAc/n5fYohcGIAkFNFMD5QdaPmuXmHhxvmdi2rvF
	 EJzeGi3nI5qc8+1nlsPj+P9DodIHR6wOPK7ZahAmYO8xj+A12wRj3hINpL9RU8fXhyZyC
	 usO32RXxLAGQKMjd7kcl3+FebB8W845jsG0H9bBXnpgPl47zydegVDGzUeUJPwcRz4fFk
	 jTHK+EzSwAjjy5LBkJZkqUdq1Ac8fn/DNJDbVAUtyPUs09CivjcE+JTk8bLUZX8Jd05JX
	 SaOAduwo0n1vZzD8B6nCxyx+RvEph6YQFrV3Y2clZ2YtGlO4jjz9fGGCR7UfYy7rWNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043232;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gjCMCiFgwSvFosXqRzXpQPvyNTdQByDJKxuvHT1hhPE=;
	b=NI47rmdpbZOKfN4xotuWFK3BaQ4I9miz5YxGiokpAoaetxTbRLUDuXdaRyMAdvuhpfdW
	 lF+R0pwxF8GuMdF37AenIIlAAzWcXJpHhlz/HUxW2SqRpcm+JZkhFd0nhOt/uNB8+nllA
	 u6NZy7MSlzer/0jdqiLSqkCNG8A7IjphMozpRL7oSXR7TcU/bB/ACxheInfUARntq6OgD
	 Vd48AmTma2c8BePOG0KyszgBKH8tjJv6DY5sYaDeTVsKKy6/UQ5GHgzyHmOtKCNWXdvRQ
	 395eCEfo/BFEBCd1gun9g+XJe+HJaw22yng3jce8OgjgvN4kOA6ZoG9/Fsbik+aFjWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3G2D5lx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB84606D81D;
	Sat,  7 Nov 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3G2D5lx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F0C1F008A6;
	Sat,  7 Nov 2026 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794043232;
	bh=gjCMCiFgwSvFosXqRzXpQPvyNTdQByDJKxuvHT1hhPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3G2D5lxa62jCXnBSb+fiXcf50itev0KsrW2DDHWu9kMeETLEAYKrShEpbkcXW3uj
	 mKkH0FP/6XePyZYrKgHRSinbboUBYREOMusssErO7L2pVsj/UQxea+qLExo+Bz3G11
	 9cz35rTK/69PmTDQyjoLBcu2H9JVlYohRnQyaDXl0FO/IVwzcSKnO3sCWRPreUucy9
	 yqFljRLMEt46sZo5zh9bCn+C79U8kGcfoqJOBHx4xa0kj7BLq3wd9MQyVYSJu7/nTg
	 MHNTZlledHMRoVBWxRj+irNce2ZHDPbJ18NYoa06GXKZj80Kqud4MWdiIz/okNo/mI
	 ykym9EGo+5vBA==
Message-ID: <sashiko-outbox-202764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/10] Documentation: Describe kconfig-checker
 overlays
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
In-Reply-To: <20261106091922.7560-10-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-10-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 09:20:30 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] docs: kconfig_checker: missing schemas/ directory in schema file
  paths
- [Low] docs: kconfig_checker: empty commit message body
--

commit a4e08eff4d708d44ce736f88aa1913f31f9a424d
Author: Ahmed S. Darwish <darwi@linutronix.de>

> Documentation: Describe kconfig-checker overlays
>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>

[Severity: Low]
Could a commit message body be added to describe the new overlay
documentation and the schema file path updates?

> diff --git a/Documentation/tools/kconfig_checker.rst b/Documentation/tool=
s/kconfig_checker.rst
> index 73717ac56ea9d..152bc0c634eac 100644
> --- a/Documentation/tools/kconfig_checker.rst
> +++ b/Documentation/tools/kconfig_checker.rst

[ ... ]

> @@ -47,4 +51,51 @@ The checker's rule files are written in YAML, and are =
stored in::
> =20
>  The schema for these files is fully documented in::
> =20
> -   tools/kconfig-checker/schema.yml
> +   tools/kconfig-checker/base.yml
> +   tools/kconfig-checker/rules.yml

[Severity: Low]
Are the schema file paths here missing the schemas/ directory component?

Commit "kconfig-checker: Split schema to support component reuse" and
commit "kconfig-checker: Introduce overlays schema" placed these files
under tools/kconfig-checker/schemas/ (base.yml, rules.yml, and
overlay.yml).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091922.7560=
-1-darwi@linutronix.de?part=3D9
