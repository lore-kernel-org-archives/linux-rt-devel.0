Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164382;
	b=L8GTk1ZZfGK/Mpza2aQxchwJ90c7gienu3eC5kSj6E5GSzIsOP4QJruiE5sHynLtoq/4
	 kA39VE3brQA3bL9LHxtwYwrbklAk0x8JpQV/BalSRHbqmTf0/ixBg/fO2h/4rRLwlyiv6
	 aBG+fO04aobsGCFAo1yYUf+Y5fEvgyqQsHzm3u8GheHIG8evCwRTK0wXnDi9yPehzFbUO
	 1uQPTtjybg8nUqkbRW40ooblLOCwfOj/HdXw6seXKBZHznFR9kQvn29n5QNeCn7PM/MIG
	 8X8y9sR8qKwoDZh4ImS9QGtu1kD+wF5Ir0YEoZiy44+x+kLUVI4hZZYJsi/tRxlUyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type;
	bh=hRnFLZttE2HPaN2aGWT8I7nTJ9h2UoaKauDcSkba7jQ=;
	b=eGQtoAwk903/wVJgOgsy4lD9CQ5O6v+GF6niDCZ01Dfssfs3Ofimh9aJ/jmLHfb7RVTp
	 +iTfU3HaLfPN7oWzuTOCuhbqQdwyM4Vq5qmvwR2ZOQXE8jdS15lapnW5NQYthqBQ1kRe2
	 rmSdcyWCKS6YWV/vu4iTJXYSs0UeI1jBb2QrcWdbhfow4cdxGpIE4k6jAj2MptZbeoh/m
	 QRLGhmNyc4A8CDawnJVC64M8t/UpTnD6otKuW8HFqjoAKMB+6r8J4Py5t2SqMWBZvy6Lw
	 ktoZXkT7bcyA9RBnBILA56Qog8rPZCMWnWmUrVTCeIIkzpxNN5FICRc+mM5qPcRiXsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MVg1diyl;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47786606A331
	for <linux-rt-devel@lists.linux.dev>; Sun,  8 Nov 2026 18:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47786606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MVg1diyl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso1303235e9.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 08 Nov 2026 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164379; x=1794769179; darn=lists.linux.dev;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hRnFLZttE2HPaN2aGWT8I7nTJ9h2UoaKauDcSkba7jQ=;
        b=MVg1diyl+mXrrZ9C7aHB6buvNptnLurn4anpcw6yCjHbK0s/i59h1/Ou0jNpXrgm3O
         MuxYXrrVBX88vfk0zp9DtE3ahOc1f/CFQF8cI7o2eNoR7sd5e7mIWGYhXGaQ4T+9nh4e
         jqrszPyD49xPBvSsMqEXpaKRgzPFF0/wvJ2T3xO+YxeU0X4MvVcZoanaQ4wIs6WzCaoY
         UUNCSpvuvCP/YeX2//A+Q4qHOF/aHMJA+QaKJ2piAzh9vm8lNVWbfTlEfO9xzxQxOkST
         vP5lusLzIkw2hSbEahDxNLBEYXAKQsbPtq699uNWHIglkVkNmdq/9sEClAAxtTduU8dL
         nhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164379; x=1794769179;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRnFLZttE2HPaN2aGWT8I7nTJ9h2UoaKauDcSkba7jQ=;
        b=aa4rEH462upUPwLthn/tvjO6S/nDZJWbArzgZ372MyNcnyqeJOy0299wfYaiMXDSOE
         ZANGRfSvW44fvw6rR3dgzlIBHKnm+YZukFzlva0CJJdFLUq8edjfe3emr2K0epa5q3yI
         isxbvB3osQp8fvxPUQ1so+wESyizB5HuAQBiTV7aAYi5JBgTg2X6uYn8Wbpl4LPGl399
         9HyXG58SrOX5Dl6cBkvG72/u9u+nfEc5weyAu0lc43OSyHPx4XR0v5cW6I9eiKg7+pjI
         1vh0I1CBagiWdg2G7uql/2/6KEeNEU5Z/sHObxMpEWHuybgiiRKaQlJYplZKXA2vib3X
         3XHw==
X-Forwarded-Encrypted: i=1; AL+hErFwSDilBxqmhiyrL+doV5HC3HFTm/Lodw0ZzG9aQFLsg4x1M5a5i+nAcrS0xX3+kq/V2qXuNdrNN3REDM0SqA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/i0PT24yLXwmgQXlzZrMQwZlHi6Lz+WwwdytKtbcGvLIol6xI6
	v/uZpGAqb5X5iU845yk1X4VJUJWkXtKM4vv83BjYI2kV6J5AtModfMCd
X-Gm-Gg: AYBFou3ltIZxIv/QVgx9VT1rTFQ80bPDpnZHgjmMGvC+hyyT2jhckLZYMO4ymNhG/x9
	eyJ+ghJ6uZaW0qh2tRO97aIHPT+TYV9/jyxiu8bnZdSswHKGqvRewv7hxbRl8qhdxj6RBVyIvnW
	WaLtewthMPebE32iwTrVzDT3g6fM2cZaNR4dMGcflgRcB6Akoq/tIvz10QUvpOPSoJUzQ5fi8sZ
	6H0diRBHGPurIBLB/ZvypftAHeFRm4tZ/qh2w0alakcu5fKMXe7L3OuxT47TkNb4c2JEdfe53bG
	MN2QVktMK8UgpxVvf3aSXJnRhFkE+pp0nvkHmBMzUlAjN40JTTbTO/k5uAcwtBNn1uUVTpFWpj4
	isgxZrF4lLHAlRZsBzEYR/5SUKFGm5lOc8dWcsHXK8CpbhG4AUNIpaB9ldOq4CFi8uLFW4jIEv6
	zTnROuTrcnM1h6LvWpOatgl7jx+zOrfFr7xm/p9hVowOGNOSGHdETtt0S6OrP6t9b/YDESaPQWh
	Xjr41M7brt9Iel08TBMZDgMdfeuZKS7k8BG1dwUtsWp1fuHXrG46f6sdVzUrfkv7Q8Er/e/8Ge2
	XthE9+kklSYqb1ChXn+Y8/EoJ+Ozszwa1WICqv7eWVGxBfwsrqUpebLI2iNHJgFDatzl/R9FLfM
	LxRYl7msL21WM+Fw4LPAP
X-Received: by 2002:a05:600c:4e50:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4b963c7d01fmr38198605e9.17.1794164379254;
        Sun, 08 Nov 2026 10:59:39 -0800 (PST)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f11172esm80401145e9.12.2026.11.08.10.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 10:59:38 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <e0ffecfe-8c4f-457e-ae8d-32a9601e69e5@gmail.com>
Date: Sun, 8 Nov 2026 18:59:37 +0000
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
Subject: Re: [PATCH v1 01/10] kconfig-checker: Add schema for rule files
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
 <20261106091922.7560-2-darwi@linutronix.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20261106091922.7560-2-darwi@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n0jyBVewKwmhUucz3R1v1dT0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------n0jyBVewKwmhUucz3R1v1dT0
Content-Type: multipart/mixed; boundary="------------DIHfuWC5H49s70Tk4afQiYfK";
 protected-headers="v1"; hp="clear"
Message-ID: <e0ffecfe-8c4f-457e-ae8d-32a9601e69e5@gmail.com>
Date: Sun, 8 Nov 2026 18:59:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] kconfig-checker: Add schema for rule files
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
 <20261106091922.7560-2-darwi@linutronix.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20261106091922.7560-2-darwi@linutronix.de>

--------------DIHfuWC5H49s70Tk4afQiYfK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/6/26 09:19, Ahmed S. Darwish wrote:
> The kconfig-checker YAML rule files describes which kernel .config symb=
ols
> are expected to be enabled or disabled. Introduce a schema for such fil=
es.
>=20
> Describe and add rational for each element in the schema as well.
>=20
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  tools/kconfig-checker/schema.yml | 115 +++++++++++++++++++++++++++++++=

>  1 file changed, 115 insertions(+)
>  create mode 100644 tools/kconfig-checker/schema.yml
>=20
> diff --git a/tools/kconfig-checker/schema.yml b/tools/kconfig-checker/s=
chema.yml
> new file mode 100644
> index 000000000000..a7f1b0a78cc7
> --- /dev/null
> +++ b/tools/kconfig-checker/schema.yml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +"$schema": "https://json-schema.org/draft-07/schema"
> +
> +title: Schema for kconfig-checker rule files
> +type: object
> +required: [rules]
> +additionalProperties: false
> +
> +properties:
> +  #
> +  # Optional base URL for the documentation page used by rationale
> +  # links.  See `docs_hint`.
> +  #
> +  docs_url:
> +    type: string
> +    format: uri
> +
> +  rules:
> +    type: array
> +    minItems: 1
> +    items:
> +      type: object
> +      oneOf:
> +        - required: [name]
> +        - required: [name_pattern]
> +      required: [expected, severity]
> +      additionalProperties: false
> +
> +      properties:
> +        #
> +        # Exact kernel configuration symbol to check.
> +        #
> +        # Example: CONFIG_PREEMPT_RT
> +        #
> +        name:
> +          type: string
> +          pattern: '^CONFIG_[A-Z0-9_]+$'
> +
> +        #
> +        # Regex matching one or more kernel configuration symbols.
> +        #
> +        # Example: CONFIG_DEBUG_.*
> +        #
> +        name_pattern:
> +          type: string
> +          format: regex
> +
> +        #
> +        # Expected value for the matching kernel configuration option.=

> +        #
> +        # Values:
> +        #
> +        #   y        option is expected to be enabled (built-in or mod=
ule).

Kconfig's tristates use 3-state logic. It seems like you're
approximating 'm' as 'y'?

These are meaningfully different values :/

> +        #   n        option is expected to be disabled or unset.
> +        #   allowed  option is permitted and must not be reported as a=
 violation.
> +        #            This is used to exempt a specific symbol from a b=
roader
> +        #            `name_pattern` rule  with `expected: n`.
> +        #
> +        expected:
> +          type: string
> +          enum: [y, n, allowed]

What if a user wants to specify that the value can be 'n' or 'y', but
not 'm'?

- Julian Braha

--------------DIHfuWC5H49s70Tk4afQiYfK--

--------------n0jyBVewKwmhUucz3R1v1dT0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavDGmQUDAAAAAAAKCRDElYPCBXNxIBhZ
AP0St5Gm6t5qmVeEmHVFmeBETjuK3DVAGHB6hDtQY4jQcQD/ZxYo1ObM3GAgg5kaUzxTu4/2XW7B
bUrRbAjtbCe3pQs=
=jHVw
-----END PGP SIGNATURE-----

--------------n0jyBVewKwmhUucz3R1v1dT0--
