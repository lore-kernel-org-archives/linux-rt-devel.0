Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334739;
	b=n3JoMAWWJoUIs1sn/tYCdmhHtHApwnCOpzNwPKinCt0KgAyERDrV593om8RhbqpwnRCH
	 8yQ72GZzZL5LglOcxRErdQVE7rOCrYxCaYI3x82oEBuQvxhPsnWmqmzrKxYyelEBkBg5e
	 McbDogtXEI2Fsvh4YTiv6anxoQxHeCOVTNEm0u1Iked/TnrXSkO/TLi9/DK5og3kW5gkL
	 uDRu5VgoCEljls+XNhz1OSvMGgSWYQu6PEOTR64cK92+00BUZNmuTaw5CiQS+JX9hG38w
	 fsfzsLW6cHlBsoymG8+j+79D1tZ+TLbxum4wAtCuYqJ0risM6wL7+Uvz+TjybsYnZvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type;
	bh=SE2lrUu9zrSXQsWXpC9NEVG/yxx3i85b5haa93pV8Hw=;
	b=W3exhJ7uZHWMtthfqCHI+kZVHPV/I6lX2QWPT1LsYVB92F6Gm7uAZqDeiaKb5KiDeGsc
	 BqFA5IlNDto0KwFGKL8AT7mvB+uG8raSALGdeOKGQjq7yWr/mkEwb4nACDKmDRvekfgRD
	 fgB7Pb05n3FfFVSEnhZzEHFnphjUzSdbXuwmeJBqFBGxpq+QNweeKKHI/eXwWl3lpDYEy
	 fl8WFWk2Jbx0Odrevyg1tUt4shxpYfVtZXC4/Njlnajlm45k06gtMbE0T/hKA7wGc7fwZ
	 05fQ8H5/KnFNu8FygJQnoBtn9oNkeptsShsbU3glFKsUitle/ZstW6125xhgMQS805A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJrloqRj;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF41606A33E
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 18:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF41606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJrloqRj
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so15542685e9.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794334737; x=1794939537; darn=lists.linux.dev;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SE2lrUu9zrSXQsWXpC9NEVG/yxx3i85b5haa93pV8Hw=;
        b=OJrloqRj2hT/gNN8SNFWxHLEG5ljGuGLzjPIbDJKy/8U/nAr2UB73HNR6xfjfdY1OU
         bkZfr/McFzHVlzXMy2C6lE1H65H6Nsmymgb5z9pDj8CQXht8Cbt2+T/m8yfqeQMbK1iD
         intBpncrh8ki64XkqV/kuM3erxhGFWzQxmDMQXGIV6rTG/vS6OE9i2yEGB1KxrCFBy4Q
         sj8xrcraUxhkH32MwK3TnWx+2du8GKLFeCmHD5qi0IWo4FeIhEK15sVrHrt4Hb8UImY8
         2ih7Ps4GlnumdK1N2pyi9pj5/uc811j8bE5z4XFAYnqluSpPWO42aXV/T6eeZ0oVbBAg
         F+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334737; x=1794939537;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SE2lrUu9zrSXQsWXpC9NEVG/yxx3i85b5haa93pV8Hw=;
        b=TDfkI3Kdo0YGr16DoSYX7rAMlHbmZ+i5r2ArrsIp72tNdc/spuXHSfjN56f4vzL9zU
         eADndBVq4ATqRhUrqV7a4PH98ObECjwkZox16ZaSekkThhb47KmfVHDR/Xm7TbabFt9M
         CMG9yuFoUv2N56fHXY26l3ItJxbdTKRAFoC1F5SARjGNMI+Cv28VbUfDeLWrTw3xlacf
         /gn7rhXaOupb92wy3HDhXNP4PhFbfeXAw4QCDjPcM/xh7LglbX3MP28uB6abqYlIn0X7
         4nV/cL7V64qIASLTc6+b6CAGDWo3OcOlJYkwu0c1YiGRx1I2Gex2yx2smTWpzxJ0MHOE
         gqQA==
X-Forwarded-Encrypted: i=1; AL+hErEsyhXO/Z7Wr92+7BLwO7DQp5qQZYYQJdYzkvQRtgst3Inq1DA7qfYG5H6FjqftQZpsiZWteSm5R+f1WiQdgw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/vb4TGRShNB0gF9ipuqEZ5cYsNqcOEVjCgXIZ86Mc+gxGjMa70
	iVYb15QXcMhrTKMbnaIoXz+Ehh0d1+LFMvKMvLIXJdIxsJN2Ar4CT+nU
X-Gm-Gg: AYBFou0KnrLPI21v6agFO47hwOurQmXfvERjPCSAzpW0Jk5htMSd8KbePyH5G0yHSaG
	mPQ6OXNgTzIG+gVKLS+sg52o/NEeCdzHXJGj6024bGlWQQgkZgzlS+WWjvLM39sH1bfPTbkYjAG
	RMu1Og8GcgdrG3ekeKJTzkazvSzduzon+2gtMQTGCLI48yIoQEV4yGb+c40XpV8XqBs++Naygro
	L9VoDqRTwJSKSdYb7KlC2JTR7xImG9TIgX1tLFtkG6hsIkSQv96XMFb1j67p1qnSwfrp/jLSbro
	VuLj0QCjTNUYhpQEGcj1vc9FlRjiPlUvN3GsT9Gb+iGADmf8GwKsmR7Xc34TFpPrERfFZEQz11J
	IotpnPFgAJZfH0scm8jUumBeILH4yM456Rd5Vdm6GL8el3O36Gas3iJgfdD4cb4JqUjjk5UqTuN
	DhmF+krQDPiXAeR1XRFVUIkBVxfdRophjjb7TSZXMpWSseWvFUfeOhLs70v2WML3BbRv+dLsBdI
	NXgKi5EEMw3k3WgJHq5QMVM9bblzGcIlfSdDuKlFjVqBQ2ecphQ2KLJJTCtwW3fITlRzBa8EyCE
	LcAivwrCKhI+/sIXPVM9wJGBHkU19e/wG0sD2mbJI6lBWfGHfxEont0gu6Qq2TFTNavZByi52NK
	3zNyaZiMsGASQuQKJDNnyvoRcX/ky/Ruw5W5qSbCE568=
X-Received: by 2002:a05:600c:34c7:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4ba0233a41emr53483145e9.8.1794334736887;
        Tue, 10 Nov 2026 10:18:56 -0800 (PST)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe63e6sm121456885e9.7.2026.11.10.10.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 10:18:56 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <c0ccddbc-539c-4987-8685-ec996285f746@gmail.com>
Date: Tue, 10 Nov 2026 18:18:54 +0000
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
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com> <avHroNa1vcxmCIOs@lx-t490>
Content-Language: en-US
In-Reply-To: <avHroNa1vcxmCIOs@lx-t490>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mHZpGD8kyHvacYrtSD2O5A48"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mHZpGD8kyHvacYrtSD2O5A48
Content-Type: multipart/mixed; boundary="------------ULacv4ysiB0EGOGi4fngWV05";
 protected-headers="v1"; hp="clear"
Message-ID: <c0ccddbc-539c-4987-8685-ec996285f746@gmail.com>
Date: Tue, 10 Nov 2026 18:18:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
 <a20153cd-d148-4618-8089-ad81cb16fe23@gmail.com> <avHroNa1vcxmCIOs@lx-t490>
Content-Language: en-US
In-Reply-To: <avHroNa1vcxmCIOs@lx-t490>

--------------ULacv4ysiB0EGOGi4fngWV05
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/9/26 15:49, Ahmed S. Darwish wrote:
> Hi Julian,
>=20
> On Sun, 08 Nov 2026, Julian Braha wrote:
>> Cool tool =F0=9F=99=82
>>
> Thanks!
>=20
>>> If no ruleset is specified, the target prints the available rulesets:=

>>>
>>>     $ make checkconfig
>>>       Usage: make RULES=3D<profile> [OVERLAY=3D<overlay>] checkconfig=

>>>       Available RULES: preempt_rt
>>>
>>> The overlay mechanism allows distributions, CI systems, and Board Sup=
port
>> On the topic of distributions, this seems *a lot* like Canonical's
>> Annotations [1], albeit yours uses YAML and supports matching option
>> names with regex.
> The difference is not only in the implementation details. Please see be=
low.
>=20
>> As you say about PREEMPT_RT configuration not being
>> "one-size-fits-all", similarly there are 100+ Ubuntu kernels that need=

>> to adhere to a configuration "policy".
>>
>> So this seems to be a real problem that others are having.
>>
> Kernel configuration is definitely getting trickier.  That's why I've
> contributed the PREEMPT_RT kernel configuration guide earlier:
>=20
>    https://docs.kernel.org/core-api/real-time/kernel-configuration.html=

>=20
> Regarding the Canonical tool, it's the first time I see it.  From that
> announce e-mail, it seems that they're using it for generating a .confi=
g:
>=20
>    Starting with 22.04 (Jammy Jellyfish), Ubuntu kernels are now using
>    only annotations to /generate/ their corresponding .config.
>=20
>    ...
>=20
>    $ ./debian/scripts/misc/annotations --arch amd64 --flavour generic >=
 .config
>=20
> Yocto also provides a very light concept of .config generation:
>=20
>    https://docs.yoctoproject.org/kernel-dev/common.html#creating-
> configuration-fragments
>=20
> But this tool does not conern itself with generation.  That is, Canonic=
al
> can use this tool to validate that they've generated the right thing! =F0=
=9F=98=89

Yeah, Annotations also supports generation with --export.

But it does support validating a config with a policy using --check [1]

Anyway, the point was to provide context for the maintainers that this
problem is bigger than PREEMPT_RT. I want to see this functionality /
your tool in upstream.

[1]
https://git.launchpad.net/~arighi/+git/annotations-tools/tree/kconfig/run=
=2Epy?h=3Dmain#n117

- Julian Braha

--------------ULacv4ysiB0EGOGi4fngWV05--

--------------mHZpGD8kyHvacYrtSD2O5A48
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavNgDgUDAAAAAAAKCRDElYPCBXNxICmt
AQCnoePBJmblDtx791LwMw6vMN74dOGbn1riSxrX5t4lFwEA9U+EgthEgVL036QIb6Xcl3PkwtNL
NnsnRTbgzz+lNAI=
=mw7w
-----END PGP SIGNATURE-----

--------------mHZpGD8kyHvacYrtSD2O5A48--
