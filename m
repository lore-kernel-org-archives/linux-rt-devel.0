Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164389;
	b=D2xXeDOsXY2UB9l4wTCreATh4tZHZHxr8G7NshBVUVbHp8HlqVx+MZIw/fZ2l8VPPnku
	 lfcpWv/R3PjBEu/zX6mjV3sGf2x3rIQjzVPW5gd6XgBeKmlhsBoGVN0jKMoGp2oph4adR
	 TQmonddbxWQAqnRwH3luQ7kXXARVs90FCGF8/T5S9yJS8NNWLSwZaLuuPVt3Th+uuvJuw
	 p+umQUBmmsl/TSCR6b8XJXKgSct1+jCQ5oB/khHN51cAWCH5l9hlMEepjd1VYRPeCPiyg
	 noEozbsuI366eqBODS5NcRk3G8EiiR2HEydhic2MSSonEVCPVXFrQa2UZGRhTGvDalw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type;
	bh=GpAFUlt0XxBY6dBpUlo0gkGGdcjqwC3S9cjFDt6ElxU=;
	b=M6Vn3gPPJOhQ2pIzNi3nB2E+lJbO9CeiNR9dQbMu1I3gslQT8cWCbRUg38Z7/jC47cId
	 707SeMB9bL3iigkY4fddXfT2g59zkSqdzoz2ysnAh2H9E4LV/jqFaWidOTkBcHigcGpqR
	 f4OlEhgwDnS8BOQMq7YO8R3mokflhpKuZV14Ra3IiwD/LyKL34JSt8016A7ZX4f15NMV2
	 G0pX1rw7HLAhinP1WL8PVXMoOVgSbGgccKpU5drJ3JC+V26DfWBclSecpmt1cw8npqYRX
	 M2GZEfwRzuueAw3HM30YiAqZ2+H0tU4KsYyFTOoi4nkPfzl5SqNw8fhmihIz32X00rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2r+KU1S;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED315606A32A
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 18:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED315606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2r+KU1S
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so1233495e9.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 08 Nov 2026 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164387; x=1794769187; darn=lists.linux.dev;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GpAFUlt0XxBY6dBpUlo0gkGGdcjqwC3S9cjFDt6ElxU=;
        b=Q2r+KU1SCPEwdtQX3yRp+SHRbSAIYzEvloQxWTlfHkUU5wfpkOVcK9qqQNJjPbalPL
         Ku21SrSk1QvYTmomB2XV0dQrsCiuPAoPU/98sHoW3SYf7CM1j3hpRhU+FonlfzKeJXz4
         XAKz3Czdw+kXiX5ZvX0hM4npsYAi8Lv5Q8aV2LAv4i4rofq+T7bsgj5F2ycCoSJrPHQu
         K+3+oWAvNlvX2sAsQMOjBBvX7zXK+QuUDVXnXNLBWeH2cB41CgvlCIvwH7AXw7P7XyB8
         nUWQum+Xx9meAwZHCzzMTEoUoBhzt+QuVSQIA63dxaOrodedkFo5J1g1rqOmAmhHaPYw
         0bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164387; x=1794769187;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpAFUlt0XxBY6dBpUlo0gkGGdcjqwC3S9cjFDt6ElxU=;
        b=yFKsujin6iSEVlPLvRQo7KBgnxXe9Eq/v6LfXOTlrNl8KHtGYegPOvVv1uaK8g2Zao
         /4mIn0VVKSNLtvHpfadC/sfBnmKsZB/89Rq749KTXUbYYUOOOInsHHVyGc4GQZigdrY/
         Nriz3EPWCfglGTpJnydKg0ToWm4w7atZJHW5bJCxIetsbHImaWrY8Zc4tmDnhN/U8pju
         gsf/7jYrZzEaUsZV7Q980l2zApuwPRFOwh3PdNdaUtcnapxs7zEwgjmERdyZj8nRQIcc
         2o1L/NJOA83L5beuLMNRb7d3a8aJIb4hgCqfx4I+Atztf6hMfCIfqztQ7iRu0CgD5fsp
         QifQ==
X-Forwarded-Encrypted: i=1; AL+hErG2m8LRl3xzaaGZWJ5dT2UC/PtRT5iIEn+ht6U2fUf6ufGfVtUTwA1yfYPJ1nrCVMdhf301gvh/wRM9Cpanuw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/f+X4pZm37I4Qg0ag1CvhZjGRJ3Lj+b5FGfI+AqMhJ+tuUaB32
	bZZ6e3XbDdZKMRLxlrUCwbtqObgloaqs1dt4+Aq+Inl6MkLscf90KGJ0
X-Gm-Gg: AYBFou3DOHh7iQuESbJN7wpLj1+C7kS9MQ4Z6vhj64rh4DfLiF9Hz/psRvPEtDIJnDT
	/rXLRQHEbsQzlexfF6+zgXEb6p2E4YHgAYAQIpFtU4gKFYraOP8gdSy+sG7EpO+mdKH2nFm8+4P
	/D4lYdTQgmaJU0uoqJ3tbdiMuugcydU4ItDiPn2HCe2/gmUdjjd+3Y+tnslDvbtlxyLZA28mNXq
	OtwX/8QAr9TArYKzlpKflmDz8kSRW5/rTlfT7P6kzM96HuSRwMhjuigkhOP8RqgZ/15rhaA9FZe
	o05T7PlS4zZ99qLmMv2FXgivmO7j7LT+z47TSJ0N/Y2zLkQ8ciNmEdSmquTIyp4F1uXdt2iy0op
	pzss/Ne11YJQPHUDcu06oWy/7po1h9T5RaIGuQt9hdPPcZBhdRdBnFxdtoqAWOL1rNPmK4UvIr+
	DtlpFvS5PdWLAisum7WEAnfyHIc7bk1Z3SexussqHBvPj5cAf68OBjx8aPYda4gcpcYu7XcUg9O
	kG9FoGD97WaIpr44LHV536hGEiRL9/0KLsIl/kMawE3IubdguMZ6ispkI5pdTtS/fb6LVe5vS4q
	90K5FDmw6KtlL36GQrkDDEqUTvheyRUZprCYzu5p8MTt+y9gLxFBubJi7iiLegUTplDTEjwx7N5
	laXjZlJYzhK96aBUkbs5CvXlAY6KJ7UNZevDPfCXXwA==
X-Received: by 2002:a05:600c:3ba4:b0:4b2:61e5:b2f4 with SMTP id 5b1f17b1804b1-4b963c65a88mr49152645e9.11.1794164387223;
        Sun, 08 Nov 2026 10:59:47 -0800 (PST)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f11172esm80401145e9.12.2026.11.08.10.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 10:59:46 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>
Date: Sun, 8 Nov 2026 18:59:45 +0000
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
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20261106091922.7560-5-darwi@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3ScbaGCYTbGeYkRt0jz5kpka"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3ScbaGCYTbGeYkRt0jz5kpka
Content-Type: multipart/mixed; boundary="------------NII28W9PtdHxoeuGqG7HRNpZ";
 protected-headers="v1"; hp="clear"
Message-ID: <3dd2bb0d-8486-4630-b496-e92e4ac37c29@gmail.com>
Date: Sun, 8 Nov 2026 18:59:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20261106091922.7560-5-darwi@linutronix.de>

--------------NII28W9PtdHxoeuGqG7HRNpZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/6/26 09:19, Ahmed S. Darwish wrote:
> Add a checkconfig target to validate the current kernel .config against=
 a
> set of rules.  Select the rules using a mandatory RULES=3D make variabl=
e.
>=20
> Example usage:
>=20
>    make RULES=3Dpreempt_rt checkconfig
>=20
> Use the kconfig-checker to perform all sanity checks.
>=20
> Document the new target at the 'make help' text.
>=20
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  scripts/kconfig/Makefile | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 5baf1c44ffa2..d67a23730259 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -125,6 +125,26 @@ testconfig: $(obj)/conf
>  	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=3Dno)
>  clean-files +=3D tests/.cache
> =20
> +checkconfig :=3D $(PYTHON3) -B $(srctree)/tools/kconfig-checker/check.=
py
> +list_checkconfig_rules =3D						\
> +	echo -n >&2 "Available RULES: ";				\
> +	$(checkconfig) list-rules >&2;					\
> +	echo >&2
> +
> +PHONY +=3D checkconfig
> +checkconfig:
> +	$(Q)if [ -z "$(RULES)" ]; then					\
> +		echo >&2 "Usage: make RULES=3D<profile> checkconfig";	\
> +		$(list_checkconfig_rules);				\
> +		exit 2;							\
> +	fi
> +	$(Q)if ! $(checkconfig) list-rules | grep -qw "$(RULES)"; then	\
> +		echo >&2 "Unknown RULES profile =3D $(RULES)";		\
> +		$(list_checkconfig_rules);				\
> +		exit 2;							\
> +	fi
> +	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)"
> +
>  # Help text used by make help
>  help:
>  	@echo  'Configuration targets:'
> @@ -154,6 +174,9 @@ help:
>  	@echo  '                    default value without prompting'
>  	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
>  	@echo  '  testconfig	  - Run Kconfig unit tests (requires python3 and=
 pytest)'
> +	@echo  '  checkconfig	  - Check current config against sanity rules s=
pecified by RULES'
> +	@echo  '                    Example usage: "make RULES=3Dpreempt_rt c=
heckconfig"'
> +	@echo  '                    (requires python3, PyYAML, and jsonschema=
)'
>  	@echo  ''
>  	@echo  'Configuration topic targets:'
>  	@$(foreach f, $(all-config-fragments), \
> -- 2.56.0
>=20

I think this tool may belong in scripts/ due to the kbuild integration,
as was mentioned in the past on another tool review:

https://lore.kernel.org/linux-kbuild/20260428183101.GA3304253@ax162/

- Julian Braha

--------------NII28W9PtdHxoeuGqG7HRNpZ--

--------------3ScbaGCYTbGeYkRt0jz5kpka
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavDGoQUDAAAAAAAKCRDElYPCBXNxICr8
AP9ab7lj4yj0R79XczFEOb9wo5VIMZGC3vGZY5oFqemP3wEA3AwrJodpubXiVsw04hceTbqM6l8E
RZBUQogdrKCHxwU=
=wQlh
-----END PGP SIGNATURE-----

--------------3ScbaGCYTbGeYkRt0jz5kpka--
