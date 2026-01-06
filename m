Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2856345CB2
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714264; cv=none; b=ak+1qsVLDIcnqB/rbcbXNU28Za3yz8hhWt7GiSvyUXjZte+4VBOMDfIYtTwGfhGVA+NlVPTTfwi2Rdc8fqRyZ52JW5yeQIQbls4qCe7JVBYs/x6LVBxI6uYr4A/FM3aW7v1IRyKzGzyorxy8QqYCxggAqh0Sj9j4YAc5+3ngpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714264; c=relaxed/simple;
	bh=wivJ7felNUHvUVLgibxXU9HP050SGeUS1In0+3vMtEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owOUJ8q/wPAnakK3Z9EetMJc6zXKZaNugdMuThW0dOFa81b/HCi/yapsAAXlsCc8fULk8qkZdf4CuHc8ZVgX0W0W2jnhBgFY7Rd3d2f6bbfsD2Fei05xhuXj0bLSJIxgQo6ASjEIEtQSNVZgozFznvoAiFqyprJfANI7S4jsP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=bRFYm7f3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="bRFYm7f3"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8bb6a27d390so72610985a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767714259; x=1768319059; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wivJ7felNUHvUVLgibxXU9HP050SGeUS1In0+3vMtEg=;
        b=bRFYm7f3tMLBzo5eA9AJO6T3wdV4xNb2E7zXMWoGLF5TY/GMAfzkA8ldXjcwa3Tx9S
         Mfl3YBMpWolM7mboiL5oxDJEB77+W/c7nh1BuOMnwA4DN9fDz943eQSNIPiWhojvXwfW
         qxcnoV6oYYC4QmMnIYH+SdsWBDtOXawHK1I428d6chIDd98oiTC6ZLev2Z2MoYBmeX6l
         VJ3mr9nJtX9L9lzYAW0FmxmQ47RmiLya46rjhqrDqSVfg97L0C4VEDG0WOCNF1wmgJ7O
         pQ7f00RG3sSeE6XLIrjo6pEnd16qw2gQ9HFte513HNmnGufohaeA5H5/NCf6djC3clrx
         E2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714259; x=1768319059;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wivJ7felNUHvUVLgibxXU9HP050SGeUS1In0+3vMtEg=;
        b=hsrpNZVDkw+HV7jRFVSpEXaVzPE2cQO3z+3heKNJ2YMz44xmkkAM64yq43HvQoOtnT
         /M+1g5sAJ6HB7ztZgB5UqQYRiYlBXei568saIl60sxhJKk33tQvhp5j3mkXGeabyrOZR
         GQTnWvRUC/dDYYOE5tDHKUAr3wi8KeA+ONI0WLjkSW0kI/gcgX6AhBpdindrAj3VNKM+
         R+uObIPjzY3ppRQDWfqFgLXbOu3YqM/cgL8YiYA996Ix91bpXc5vqq4neR7NAMJjIMd8
         cxF0cl/HrsLs/1Ffh1kud4Lhgv5DryLTfISJnVIvOYd+RpcUd/Juh2Qbz10/HCD9xWz0
         RPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR6vhxxklsI+83jgXlrxF1z/bL6JnUloQjIsYnymGAhtBAqFMulqYiMLsvwua40iMxt7dVMoXd7PEkfPjy5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyG2Qu1rKri3S7j2JgY+9mAK7mPnblzSL8ZKC/b/jCevM+22HLh
	x8w/10+cPDhtXAIBwyVB8xvhiZt6nkvelQoJrEmsx4CnQd7tBMercVwX1ZHf3rS7s1Y=
X-Gm-Gg: AY/fxX71GkdjMqSEw/3aUHUCh91G5MEM7+Xio4PgLU9Qe1LWdvwKxtdP8UjfvS6TEcq
	MLEy2i44HygyEdRiVhTzrMFSPVEmOBkpDwn3yNzblpEyDX+tTaK0gDkFri5Jt044xvG3n6oIigo
	KD95ozLK3UtRS6Zij+HUJC8koOf2LjXkfivapgEU5xqOtwEzwgUfr2fTjYWzbnCYrKtNKztsL/0
	ynz50wa/m8rdPVj/rMYUZOm0aFC2VnOTEPNGH/bPX8ZXDjaT9JOFS7/SbBHpQ0FfxJBV04ljvjy
	/tdMDrKLjh7XYh20p9VaEiG9HCWoun/R8TsVYtxLKo+ouLG4F9GyCbg6s9PxI9wtezwOh57OkqV
	JhxshGtDb102qs2CpgLbwA3c+cXWc6CLygFsN5YpIq6B23MB7Og5C8e3jCpIJjN5wnqPCbekYxF
	BG/bf3aIRJHRq2lSCkd5uGSctut14=
X-Google-Smtp-Source: AGHT+IH30kwxuPyB0HdKD45B3C5FJpr1+vJ0SQ87m9C7GJ87NTgkQBGmR4/iCOhQs5nEjUWqZnP+Ig==
X-Received: by 2002:a05:6214:e61:b0:888:87ea:c7db with SMTP id 6a1803df08f44-89075ee369bmr44553266d6.39.1767714258381;
        Tue, 06 Jan 2026 07:44:18 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm15274796d6.43.2026.01.06.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:44:17 -0800 (PST)
Message-ID: <5e6655351d22721344340d5227492bd55cd12a21.camel@ndufresne.ca>
Subject: Re: [PATCH 1/4] media: dw100: Implement V4L2 requests support
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stefan Klug <stefan.klug@ideasonboard.com>, Xavier Roumegue	
 <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt	 <rostedt@goodmis.org>,
 linux-media@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Hans Verkuil	 <hans@jjverkuil.nl>
Date: Tue, 06 Jan 2026 10:44:16 -0500
In-Reply-To: <20260106145939.GC26157@pendragon.ideasonboard.com>
References: 
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-1-65af34d04fd8@ideasonboard.com>
	 <40dfd12b585681d8edf9641967160c086cc120c3.camel@ndufresne.ca>
	 <20260106003302.GJ10026@pendragon.ideasonboard.com>
	 <176770897731.12184.12302111059048415045@localhost>
	 <7c514e1165f49c2e043b7f4ab5fcbd1003c517ae.camel@ndufresne.ca>
	 <20260106145939.GC26157@pendragon.ideasonboard.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-NKZAV5Xowi3wbKejnDM5"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-NKZAV5Xowi3wbKejnDM5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 06 janvier 2026 =C3=A0 16:59 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> > I'm stumbled on this one too, but I completely forgot what this callbac=
k was
> > about and assume something like this. I suspect it might be some left o=
ver
> > from
> > when we required all request to hold all the controls, we should find a=
 way
> > to
> > make that optional, and sort out this field thing, but I'd say its not =
a
> > problem
> > for this serie.
>=20
> Definitely not a problem for this series :-) Please see my other reply
> about using .buf_prepare(), let's avoid splitting the discussion.

I replied 22 minutes before you did, so to be accurate, you did split the
discussion.

cheers,
Nicolas

--=-NKZAV5Xowi3wbKejnDM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaV0t0AAKCRDZQZRRKWBy
9CPCAPwNlgOMCYz1GIjZeOfS+Fru6cfY2/EhiWeL/fmSUMB9fAEAsKSZI7IenrJq
kWi0l7O8c+VMwUl4/imkqmQrNA2HwgI=
=Ld/d
-----END PGP SIGNATURE-----

--=-NKZAV5Xowi3wbKejnDM5--
