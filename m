Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525273;
	b=PxTGmiIX720Cjxk5/yhmJHTarMwRH/dzvEz14LNei2RA9UxlJYgfhyWDIz2K+Qv5r8DX
	 Tn+PCnRjvawp67YPWnQpKgVRVP9xPUPaIIIsjsGrdfsA9RvAtGdC2VdZxWx7IEOK8JC0V
	 xlo1/m6PuMd+n2/SJ2kn/KPLFy5/QzSCg7X9UPT7LFyzRJ6hG2ktBtbouK47CDaFlCK2c
	 dpcKiLzajVN9sl8K2cZjgFI1fJbmNZzoIVaIPrzC9CbtF3y/pPBoDpLx7+mQzrU6xtGwS
	 3HXnKc9daVR6DMVvdmlwooYbuMxahMMpNbCO9bQThzO4vNSObQ49FDy8wITPpML3jLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type;
	bh=DN/qNmYDsOB9nL6rphMvlGN6Wu4Xb8ATnikeAxhxNfo=;
	b=3JSVqOeNichBSQ1MdPup8HFpm+s5m/Cd+F6XYSDzVxKVcDxLDeRFzuYqMjixXMNnLtzj
	 UUbzSqbRpAWnH2H8zBbokOAaLMERye0HsfiMpQqafFViPUNEMpzz76qrJdEamESBsI0sv
	 XZVoo+uWR9waaZTiEESBQR5ZHyDH6uGsRK9/mzQSRujyVLukktCPCCB7Kl4GqwATa3TGU
	 09LxiKow6U5AQFWT1aJfyg1xsjnyX2B8y50ZuDGi6ysLFezYX/mJJrSnrhPUloMFLpAp7
	 iBMca35V7/oMZPyhBRdRd5VnfmrxDFPtTYJpL1af5QqVM8Ti159rSQU6veRXM8irJ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUVcpp7p;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79325606A323
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 23:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79325606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUVcpp7p
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so2291115e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 15:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794525272; x=1795130072; darn=lists.linux.dev;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DN/qNmYDsOB9nL6rphMvlGN6Wu4Xb8ATnikeAxhxNfo=;
        b=QUVcpp7pGgbx9haejfyIdJ4xqiVI/iQHid9gS/7lDhbM2p7pkpUaa/CvQ+aM6gpItQ
         ZV3fYI0otvpjMzPBcNGck9surJM2hEsMVHPEMxi9YRUm68oKU0dvDSyE+AYkY+XA5MiW
         mb/bBhXNWG6EfYYy89yPQbxHuz603pi6l17pQAX3TEOxxHyqejjP27Y1Ky5aqHqZk5CF
         XUlZz1ZLRpTYAhBcKIXFp61h1a1RGvnwqSHiS/RYywqU8rA4V8EZtGThWSsqPxduhWx4
         mJFv5MfhTF7cGLa30nQU+Vur0rzBs/1Xbeh8CjRmYfzmEsv2S194Pr0RTbqSKayDiMAB
         MXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525272; x=1795130072;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN/qNmYDsOB9nL6rphMvlGN6Wu4Xb8ATnikeAxhxNfo=;
        b=xYtkiNTqb7oTQes3BnYrKIg8ymEpiym057RkqfQugXXg/sHKepPmqfVkGkBXL6KZ4g
         0jI4YA4CF0kCUImttPKLBMYaUgznJN2X50kGI2+r6vHFx+FlnXedlXm/wXjUuoA0Kktb
         d5WDDl3C3LBpmAHDFTuuVF2dGTdU267MbyQca7l9CzLP40FpavU18s7M91EjF2uu3lUQ
         bsue2M24eOYu4cgV1vqtCGd9UIGs4+z78mBR5Zr/jkid4oaWh+hDd+TssLlefRzJGhG6
         CqGxkit+zbC1GawmrUyItm3hXh2l6v3qO6tsbsiClYOC+D7QG0PuC0EL4aQvBelipHw3
         OFKw==
X-Forwarded-Encrypted: i=1; AL+hErFVdmd6xQ+V1PGtdiawoREklsa22U4YMdz4hx7UJPTYxc8DFinxe1A9aO0XqWQLDW41bZgj7W73pqPB16HvgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ZBeEgG/txK0YbNCbvEA4yc7MrI33DY8B/nhMxa+5OoZg7cfMq
	zG6VnEwTA5kR8TTdiR/mahSPtOPzrlo3jq/PfAfnDaAYm41pwKw++AIQ
X-Gm-Gg: AYBFou3O1rJ1pHKD/JRFuJkCVxED+YsNWPO6xso9y9JzduRJdoTQeOeWzsTJZuszTjx
	E0LXr3GdF07rboJ9brzxPcYqlJXwC0gaqSgXBUAuUU1+/TGWeKgFJoaLj0fP0rbB3m8FgDmWaKd
	lZZ3Tl7Nf+HhKcM7AtOJQwXsP2coMwWJkvbKITHFk2syCE7LvnNcLJxJboJgjqWO68ZKqQzIx8a
	KpTUgEJQWk3Kuuflscs+S5wX8HaElm7rQ/5onYZ2In/h4UNHTkxRYdXH8dgZ5ju39BZS7Y9dUaX
	cI97+HUxgCiFdVR88yJqpmsZHvd6vOx/Whvrbk6DVvzsMB4tLmXA031ZiJkLQZVPqDpRfp6iLOD
	geMvls/4E2D+/KmB9/hADLXUgSh8qnlwdFM/PcoYP21GPgoBFv6qsZvDEiAmOijFnXwDTWtDjNL
	9ycdOCC5dC6JoP43Gs5AGYOQs6yrmba9gdoMQRh8L3IoYqZjppSKV3aYb/IIDffWeRT61S5WU7Y
	FvjBFoy0KLhCezENd7XlTa5fDnzEkslWHEbWZ0/Pa3q+4GCyXHNLoawLZgwFJsYUeHrWjCUZjZ9
	G9M111ebVknYOvJ3mFtMxRn+AZCsK4atXWPH3C9vUaqEZIBOhaCWCNfUuwPMu0PjzrJZm3IIub+
	dreTFqww4xHBoKsilWg==
X-Received: by 2002:a05:600c:46d5:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4bb55a8329amr13702305e9.13.1794525271736;
        Thu, 12 Nov 2026 15:14:31 -0800 (PST)
Received: from [192.168.0.41] (bl22-190-205.dsl.telepac.pt. [2.83.190.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2acf81sm96030325e9.14.2026.11.12.15.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 15:14:30 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <2226c85e-2902-4964-858a-2d1603263252@gmail.com>
Date: Thu, 12 Nov 2026 23:14:28 +0000
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
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Nicolas Schier <nsc@kernel.org>
Cc: Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
 <avQNdicGzL3De556@derry.ads.avm.de> <avWy2r1BcDatzwo1@lx-t490>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <avWy2r1BcDatzwo1@lx-t490>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------K2GKi8S106PfrZNN3W4EREbC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------K2GKi8S106PfrZNN3W4EREbC
Content-Type: multipart/mixed; boundary="------------onQYsP5IVHvnHSUuO3vsIGv7";
 protected-headers="v1"; hp="clear"
Message-ID: <2226c85e-2902-4964-858a-2d1603263252@gmail.com>
Date: Thu, 12 Nov 2026 23:14:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Nicolas Schier <nsc@kernel.org>
Cc: Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
 <avQNdicGzL3De556@derry.ads.avm.de> <avWy2r1BcDatzwo1@lx-t490>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <avWy2r1BcDatzwo1@lx-t490>

--------------onQYsP5IVHvnHSUuO3vsIGv7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/12/26 12:36, Ahmed S. Darwish wrote:
> Hi Nicolas,
>=20
> On Wed, 11 Nov 2026, Nicolas Schier wrote:
>> Thanks!  I know some people who are definitly interested in such a
>> config policy checker.
>>
> Great, thanks!
>=20
> I hope this leads to more mainline kernel configuration policies as wel=
l.
>=20
> On the user-space side, it's one of the reasons I'm versioning the sche=
ma
> in v2.  This way, projects like systemd can ship their own kernel polic=
y
> file, and that policy will be guaranteed to work with all future versio=
ns
> of this tool.
>=20
> So it's all mainline-first; both kernel upstream and userspace downstre=
am.
>=20
>> Please prepare a new MAINTAINERS entry in a respin.
> Sure.
>=20
> Beside a separate entry for the checker itself, I'll also add:
>=20
>     F: tools/kconfig-audit/policies/preempt_rt.yml
>=20
> to the 'Real-time Linux (PREEMPT_RT)' entry.
>=20
>> Are you planning to maintain it after inclusion?
> Yes, I'll be happy to maintain it.
>=20
> Would it be OK if one or two people from the Kconfig side also step-up =
as
> reviewrs?  Julian? Nicolas? Nathan?

I will politely decline the official title, but I will (unofficially)
watch and review some patches if merged :)

- Julian Braha

--------------onQYsP5IVHvnHSUuO3vsIGv7--

--------------K2GKi8S106PfrZNN3W4EREbC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavZIVQUDAAAAAAAKCRDElYPCBXNxICgY
AQCrg7omkjFSbzIwDbf86DhWih90vS9Sw1cD5XogAdL8JQEAugMEfkQyo0VYrMXEMxzxjaqaD4Dv
40JhZXotRyfJ9A8=
=Wy7B
-----END PGP SIGNATURE-----

--------------K2GKi8S106PfrZNN3W4EREbC--
