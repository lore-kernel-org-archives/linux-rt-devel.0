Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524169;
	b=Sb+f3yqHp1VE6BZh5RYMUUNXDjSqqSD6XJJ5mSdifrIsPWQIEHrIgIQdNVPNK1A2+NbE
	 X8/ByeiXHmFDa+JjiV95OVay+WQ4ZuwBeQS09MSpuIGxSMA5+GJm8KNhmEZN63WOCDrCc
	 q6ij0xG01TlzzlcVr8JBYNsY5n2bBQClSiZ8YDzSEeK48smZsUwhc2TyKPFmXmE2CAK8u
	 9ymAAIuLmOLCDx6gYinPMmxlYPC9me6l+bwwOg/NMpw/UNz3WGI+t5urx+DumpU4QnN3y
	 k1+2jIVWgAy1CetH8H5bAJwk5SpdGdTP6oCcsyGaJapTYo/4MQSV7jayoWN+iVuPodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type;
	bh=ZxJf8bmNk9QYTuWMTZ/K0FYOKOyHJkvCDvBuAHHFKsk=;
	b=ECxBOnHoKPXgej56axrXdq1gZFAuV1uK83GmR4zQ+vywpiclbWBbAEQyXPMimHkyTHci
	 s6MO0uVEuWlgF5rwva1LiQO/pPdoXU81Sh3Sjae60sfmM091RvQn7GTYwtE6XY8nUt5jY
	 21xXLN2UTMViIIjzeG2znNVWgZWHyEce8S3p3TMRUoVL4c4zJJunqN0DVivSX4TqN6b2q
	 KyW24Es7nEwFRtmu1b+ysaKTF7hwtvmlUbDUmIJW7gCm/rXhJvc9TO+FeLZjMgv1Vz5M3
	 y49jHcz30XNFJWbL+StS8HmEslxtoCS8dZFajdiSP85I0O/M98rQYPAMKxDuQvpXXfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lqmqz/MF";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71B606A8B5
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 22:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB71B606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lqmqz/MF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so1581735e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 14:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524167; x=1795128967; darn=lists.linux.dev;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZxJf8bmNk9QYTuWMTZ/K0FYOKOyHJkvCDvBuAHHFKsk=;
        b=lqmqz/MFrxmOxxNzaQ1isf5UR7ZZnD2hwPkw5YrZSa5ntf/W0eSM3eBY8S6zA/Pc0G
         pH3aHAv00CCh31aXpLqM7kMDGc08C5yOCCjZUX75zXovt5HsVi0BCjioFKvUbhH5JELz
         1xvWrmpQz2Je37H8qvhmsEcc3dQqiVrnZAPzBlVONatOGEfoHv+hTFyLeB4JXB1kR8tT
         eYUAkDYDsRwgE3saZ6Nuepc0DYVDVeDoThi7GjDH9HxBILN4iSXiQrbKCGMUxm+scQ95
         w1AdZlShkeGZbfAb//uyWgdYyolrUI+nApeoYutShayoag/KHP2d5+k94uKHhUlfOXmM
         LG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524167; x=1795128967;
        h=content-type:in-reply-to:content-language:references:cc:to:subject
         :from:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxJf8bmNk9QYTuWMTZ/K0FYOKOyHJkvCDvBuAHHFKsk=;
        b=eGwxG9dHcIHuwRTXMND1epjgWHpqMSrZ3VfX3AGVigklwgjuyaAT2ZLD1HBKvllm87
         1kdWTj/PVsvy/d+EfPH87qJm7nf8ix8ERn7O/fkr2ys6etHocY1Jw2TS3swAdEhScYi9
         7IKLtPkWBWGJBbZtNk6FI9gWPCwRbzjlUgtIW1fPfYk6xyQGmZrP8SukGt/TJOmJMat/
         NPiRAXFTZVMrxb7oExFFZxDk8Xklsut2pUaCFYXkSA5VGe7IsV7lDzROyXqcQz2npxF1
         y12Xlqw87NsXdR+2tYDVE6vuUynWUy5DmsPy17fhre1UjEeQF4r9/WOOZdTj6nOi/+sw
         2WFg==
X-Forwarded-Encrypted: i=1; AL+hErF3HFZPjyOQVuR4BA8AVoCQbXv/dBFgK+/FiSoZKhVQBM8HVXtnqhPSO0T1/10c8xjbY53JJEPJZ4q6GRZk0A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/QS4tTdG8+pKsc5NzXY5A1i8OdRtAxnTIMPH8Y0Kp47BReTfq2
	Vs5Ez5RSf1KgmA8UNceaiM6odPQs02P9PyLtK8/qapuBfwAJGLNAXMiy
X-Gm-Gg: AYBFou36gGIoh2U4Fo+i7lwqwPAhn8mlClCfepTjiB1E7gQVjY1kO4Bq8gyYmUyUJx5
	v+54oy52ur6LGyKfj5VJ1fAUrdtVtSKPAkcOqKrhkNcsz5qmjyZ9eMArAb8OO41SSHKuj6GNbvC
	bWDW6TAU/D6lBOtp8S9kzArTv0KnujmPHhp2zwJqLbp6i9OqDidoBjtVfdLjNa85XITi6QmvEBv
	NWC6JDtu4JowWzG/JsNn913k16HXXM0iTlCAhxBJOgrc5TO8IjjMWU4O7E6IC8TY1S9yqwiPutk
	IbAc1x6wI7Y/kRR6brVGTZ0Z1ciUpHwx5FUor3ika0h2LsmKNeT05Ku5JU5asRrvZAltHAyWLd5
	NtG15ZZNVjQzgZbbujNrTx53psk/958LEOyXok1G/5YFLNdrxIFtg1H3jGEW1GQLVstk+IOg1nY
	JECaV0kXhxTPzIQB6lvrtUFWjpMRCzAFyIPmKZKLrWzvcDry0BS0xiYgkfNhdMS4aF7LGPGe3Qg
	V9Xm4nh1Nxv1Otvn5diQPJdT1iz3aFv2HuvFhzL+QLHfKR4oDgHAPG5VKbMDRRrzT8kZo+UhVjy
	+cWmAZvmgm+ZGGeUNJXkxRjefxlB0ql783TcElfM6PcP0K9XnEOMU/gzcod7ymHs8MRsHhAlWfA
	Fi0MW2sLQMNIh8dQ7+A==
X-Received: by 2002:a05:600c:46d5:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4bb55a8329amr12879245e9.13.1794524166792;
        Thu, 12 Nov 2026 14:56:06 -0800 (PST)
Received: from [192.168.0.41] (bl22-190-205.dsl.telepac.pt. [2.83.190.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2a9bsm14024995e9.14.2026.11.12.14.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:56:05 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <81c91813-79ff-4d36-92e6-8c0ecc1772c7@gmail.com>
Date: Thu, 12 Nov 2026 22:56:02 +0000
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
 <20261106091922.7560-4-darwi@linutronix.de>
 <9729a4c6-22f9-4102-b62f-c76a75488240@gmail.com> <avHD-3JwbQofpJdH@lx-t490>
Content-Language: en-US
In-Reply-To: <avHD-3JwbQofpJdH@lx-t490>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VdvWlLDeG07vMoPV8nhx8PYM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VdvWlLDeG07vMoPV8nhx8PYM
Content-Type: multipart/mixed; boundary="------------Rga8Q7Rmd8rON8aXdAwiRZDL";
 protected-headers="v1"; hp="clear"
Message-ID: <81c91813-79ff-4d36-92e6-8c0ecc1772c7@gmail.com>
Date: Thu, 12 Nov 2026 22:56:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v1 03/10] kconfig-checker: Add the configuration checker
 code
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
 <20261106091922.7560-4-darwi@linutronix.de>
 <9729a4c6-22f9-4102-b62f-c76a75488240@gmail.com> <avHD-3JwbQofpJdH@lx-t490>
Content-Language: en-US
In-Reply-To: <avHD-3JwbQofpJdH@lx-t490>

--------------Rga8Q7Rmd8rON8aXdAwiRZDL
Content-Type: multipart/mixed; boundary="------------0BXEV3ylG2oOQNRGA3FZ8ghK"

--------------0BXEV3ylG2oOQNRGA3FZ8ghK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/9/26 13:00, Ahmed S. Darwish wrote:
> On Sun, 08 Nov 2026, Julian Braha wrote:
>> On 11/6/26 09:19, Ahmed S. Darwish wrote:
>>> +
>>> +class KernelConfig:
>>> +    """.config file parser"""
> ...
>>> +
>>> +    def _parse_symbols(self) -> dict[str, str]:
>>> +        """Extract CONFIG_* symbol assignments from .config"""
>>> +        symbol_set =3D re.compile(r'^(CONFIG_[A-Za-z0-9_]+)=3D([ym])=
$')
>>> +        symbol_unset =3D re.compile(r'^# (CONFIG_[A-Za-z0-9_]+) is n=
ot set$')
>> What does this do for Kconfig's int, hex, and string options?
>>
> So far, the tool only supports stating whether an option is enabled,
> disabled, or have a neutral 'allowed' policy.
>=20
> But there's nothing stopping us from supporting something like:
>=20
> - name: CONFIG_PANIC_TIMEOUT
>   expected: int
>   expected_value: 10
>=20
> - name: CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE
>   expected: hex
>   expected_value: 0x1
>=20
> - name: CONFIG_NLS_DEFAULT
>   expected: string
>   expected_value: "utf-8"
>=20
> In v2 of this series, I'll make the schema explicitly versioned.  This =
way,
> new features like the above can be cleanly added.

Adding schema versioning would be great.

>=20
> P.S.,  I can definitely implement such support, but I'm a bit hesitant =
to
> adding features that are not yet needed by the existing mainline polici=
es.

I suppose it's not necessary to support these option types at the start,
as there are few of them, relatively speaking. But it would be good to
add some input validation in case a user attempts this.

So I've finally had some time to sit down and test this:

I created my own policy with these other types, and sure enough, if I
specify them as 'disabled' in the policy like this:

    rules:
      - name: CONFIG_LOG_BUF_SHIFT
        expected: n
        severity: high

      - name: CONFIG_PHYSICAL_START
        expected: n
        severity: high

      - name: CONFIG_DEFAULT_HOSTNAME
        expected: n
        severity: high

and my .config has these values:
    CONFIG_LOG_BUF_SHIFT=3D17
    CONFIG_PHYSICAL_START=3D0x1000000
    CONFIG_DEFAULT_HOSTNAME=3D"example"

then the config passes the check -- but it would probably be better to
provide a warning or something about these options.

Also, if I modify my policy to set 'expected' to 'y' for these, it
reports "not in .config" (which would likely be confusing to the user).

This regex stmt should match all int, hex, and string options for you:
    unsupported =3D re.compile(r'^(CONFIG_[A-Za-z0-9_]+)=3D[0-9a-fA-F"-]'=
)
by checking the first character of its value.

The included preempt_rt policy worked as expected (nice).

- Julian Braha
--------------0BXEV3ylG2oOQNRGA3FZ8ghK
Content-Type: application/pgp-keys; name="OpenPGP_0x0664101D2FC252D1.asc"
Content-Disposition: attachment; filename="OpenPGP_0x0664101D2FC252D1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEapsKOBYJKwYBBAHaRw8BAQdA3mvh6nlHEvnMtdMGgqCAaM3Nsvuf8218NgEp
UYZ3GanNJEp1bGlhbiBCcmFoYSA8anVsaWFuYnJhaGFAZ21haWwuY29tPsKWBBMW
CgA+FiEE3vXonTpsa3w5RQqpBmQQHS/CUtEFAmqbCjgCGwEFCQPCZwAFCwkIBwIG
FQoJCAsCBBYCAwECHgECF4AACgkQBmQQHS/CUtFZJQEA1KusHq55e97aMeBrp7e7
UVBW/KSQwD74hTv5flHpEioA/REUaia815i+qzvft2b2k6OklqL7Nk5vXcmEZS7e
VRwBzjMEapsLWBYJKwYBBAHaRw8BAQdA9/bcRDPCvFzqqx4b3LVPDeOF6sju1/WR
4h3ldYdesrXCwDUEGBYKACYWIQTe9eidOmxrfDlFCqkGZBAdL8JS0QUCapsLWAIb
AgUJA8JnAACBCRAGZBAdL8JS0XYgBBkWCgAdFiEE+qo5ZfvrSBcRfE1DxJWDwgVz
cSAFAmqbC1gACgkQxJWDwgVzcSCsFgD/U4j7hwSEh61Oa4s7R4tUW7Rk4QXJ5QYs
vcIagFNebLEA/2pJH0zmbz5SKUKctYslxZ5kIwmTwHv1WrpJkp+LQKcEmMIBAO/h
CxaCZqrsGDSNflfIV9VyUMEPLbCvfTBYjNwdsPCYAQCoTYODxyxaV961a6Jq0E70
Js0eCdlqdx90XMjUDQBOAs44BGqbC2kSCisGAQQBl1UBBQEBB0CfrYRXqZGPNhdK
Db1uwVFrlLz9hAa3mhsuj1l00A5JbAMBCAfCfgQYFgoAJhYhBN716J06bGt8OUUK
qQZkEB0vwlLRBQJqmwtpAhsMBQkDwmcAAAoJEAZkEB0vwlLR4B4A/AmkIlpPLSZ0
C6yjqhpnDw4h5sIMu9fzfY+wpyONkYB9AP0a3QyeX2lCHdqdEsNX3ubF/ulc2DYS
0cxeDFVX3Sz7BM4zBGrJT6UWCSsGAQQB2kcPAQEHQGX2XtPmGz+dyR78C2db90ry
FJ4j/ekbwHQ41WdLi26jwngEGBYKACAWIQTe9eidOmxrfDlFCqkGZBAdL8JS0QUC
aslPpQIbIAAKCRAGZBAdL8JS0YE4AQCrPL7T+dv83/SgWVsa2LwUxJiLbiTCctzc
5rISDmWHAgD/TnBEQkxYBXJTgnvjVmuMGSSl0SQZ5z6hVZvH4mU7zQ0=3D
=3Dyg1h
-----END PGP PUBLIC KEY BLOCK-----

--------------0BXEV3ylG2oOQNRGA3FZ8ghK--

--------------Rga8Q7Rmd8rON8aXdAwiRZDL--

--------------VdvWlLDeG07vMoPV8nhx8PYM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCavZEAwUDAAAAAAAKCRDElYPCBXNxIMuZ
AQDMrrOgssYsmZu7r97D0KltSrsj4rjS9lQpoKvtgWkLgQD/QUf7yjdW3ke5GhASowk8x+G76gpu
WHV+5iNnSCYOfwM=
=KhF2
-----END PGP SIGNATURE-----

--------------VdvWlLDeG07vMoPV8nhx8PYM--
