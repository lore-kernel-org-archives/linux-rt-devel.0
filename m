Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BA224B0E
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714974; cv=none; b=INlqebiDHiPbxz41wHYXu0cBsgpAPz9DZ4XOW3lTWlkk/lkpFbbXG8QmDOdobYWJ/FAAnlrsrYbR/JBYnTvHjr6pCbOnkXuTXpaCsbHGOiIpZpWNkGTi4hJjaqPCdQ/mkPN4Q/1Jp86XS9pZuyei0Pua4+kWkPcScr6jY1xyZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714974; c=relaxed/simple;
	bh=JWy3J0zt4DIlNc6L8QadHe8I+XVry0F0Z6dMfHWb2UM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HT6mORqCM8I2u0b6hCVhG0x+cpeCuP/JSAjyOxOJzb2EZ46F/j6AQOX6UHG/whCudvCcGUCdwXuuPQgiGamWevEB3dXgkYZw0TuCCPMLV6XNL6amIvDPztAeTX0gScoRAOclo/UcMpeJSY7LHe2myLDQcHXPAR7vmoUsMg4gngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=KkAeAtmJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="KkAeAtmJ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b31a665ba5so119037985a.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 07:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767714971; x=1768319771; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JWy3J0zt4DIlNc6L8QadHe8I+XVry0F0Z6dMfHWb2UM=;
        b=KkAeAtmJqfGUroNHFNAEZjy4Ui31lAEuhx9qhUBOQm/d6awiCjDO1an86SBmRdjujG
         oPEOyBIWJbdchzN1bDM+fIAMlPMHidW+D47N5ShlsLd85iRUF36Pd9MMIeUMVoT6juPz
         9PK+4Uwq1YL9hMN3qB9ROnHq3D8VEgW2RwO2oeZ3nqQJJ96wcRKRUgz+ySvEIQp+lkaq
         bdPoPpUSPjF5/Dtmm1gXse/Q9s5TQEgSDCve6uRV7j/erAesjnsbpIoQIVX20k5D4NXg
         itHgrp94G2IpwKzCnuKDbEcaTOoWE2Eq6qlZI7unD5kiY5ftXYu5GA41rRCeYkrSxsfR
         ESWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714971; x=1768319771;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWy3J0zt4DIlNc6L8QadHe8I+XVry0F0Z6dMfHWb2UM=;
        b=JltOEipXb66WR0F1K/R+KuC/mc9NSE6YWGlnqw/cUYgryYaHGVdJII2Ets/xygHCFX
         5GWUKxaT1flYRaeb3QcCjIZmrIvReZEJBiRqVsrTdfuqRhqXksaz4ws4eNXiNKab/gDj
         vyulJ2V7yH5fzKyAS+++oGqFVEmMSI9/yKRWkhCg592fTsQbMi1/zJz7VlKuOIpsz04Q
         CGjR+BbvQ9Y2J5qfEFsX32U8yEUdnsgzMbTd+xC857hNbz+3SccaJo6luGtapo/E+Yjp
         2gjd7/SeWCVgucCBVrYDlXkq4gyBHEEMNMRkRX7WTH92AUOAJZLbeysSeBeATP67+VgI
         HxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOrMZ0dKTnTah2Njr6JoKbifkCMi8xqVpuTDk0q0xadq4UCN68FYco/3puZrweqJEX2ELt72QOmtjJtaruvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv5xAW4gITraImyevZzETmXUT6GZdpN3Wy0spx9H2PYevHhn7w
	fJoSG7qRukSN4p6RPn0JgdDhRAsho0zODBmN9IUotrtRyCZuD+aMs0r7uPbstv8f3I8=
X-Gm-Gg: AY/fxX6kwhHVWsuEvcKOakWdZIxBgVKzHi6dOvpRa/Wb2/7BXChWDi57A6ThB+k4xh1
	g9T3asPCceGXmrdkKgVMe/ehWwaV+qg5yZKzYjqF1EVIIEs0HYBFMjA1euTaI+thYdZ2hslkDuL
	/BdT91gjDra/o8nQJGnWvsT6SqbTsB5VkbUhVrIiNqY5/w3aN89d1QbhzklXXa8Tgua/JexDMve
	nCzsttBCnJLc1ISgZYIuygte1AtXBHWBgaiRZQk/cwi/OJpTDW6C0V4yvTV3eQCD7m6Ku3wJzTz
	0uHHKsVwUpvzro8aROuiK3ppDK4M/6ekGJMwDmi1FeOQXJrfOLYgUuizvjtqHu9ot2gRBuAZ3bN
	m8+B00sWeNvC1LI9+kFJD+VJgiIsGcg0xi5nLysKamfD6sYv91vp9iX8XDgMfwURkXP8uSy99Qq
	VGzaHJb2oQdDOY4OKq
X-Google-Smtp-Source: AGHT+IFcJDnJW/Z0dC+HeS6Kko6LXBzoNKTMAqBHPfJPQt5lkEswSkCPkEH16jRQPqojEkS3QsGDOA==
X-Received: by 2002:a05:620a:2801:b0:8b2:f35c:16df with SMTP id af79cd13be357-8c37ebee315mr448710885a.79.1767714971505;
        Tue, 06 Jan 2026 07:56:11 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51b732sm184928185a.25.2026.01.06.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:56:10 -0800 (PST)
Message-ID: <c4f20e7f67f40b13469ea2504f0990ddbce59708.camel@ndufresne.ca>
Subject: Re: [PATCH 1/4] media: dw100: Implement V4L2 requests support
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stefan Klug <stefan.klug@ideasonboard.com>, Xavier Roumegue	
 <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt	 <rostedt@goodmis.org>,
 linux-media@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Hans Verkuil	 <hans@jjverkuil.nl>
Date: Tue, 06 Jan 2026 10:56:09 -0500
In-Reply-To: <20260106154517.GD26157@pendragon.ideasonboard.com>
References: 
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-1-65af34d04fd8@ideasonboard.com>
	 <40dfd12b585681d8edf9641967160c086cc120c3.camel@ndufresne.ca>
	 <20260106003302.GJ10026@pendragon.ideasonboard.com>
	 <176770897731.12184.12302111059048415045@localhost>
	 <20260106145354.GB26157@pendragon.ideasonboard.com>
	 <f4eef909a0f9b787dd4720fe005de0c4e41f5c5a.camel@ndufresne.ca>
	 <20260106154517.GD26157@pendragon.ideasonboard.com>
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
	protocol="application/pgp-signature"; boundary="=-0n+5qroluuyyHlNQ2ext"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-0n+5qroluuyyHlNQ2ext
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 06 janvier 2026 =C3=A0 17:45 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> > I explained it in another thread, it is only called if device_run() is =
not going
> > to be called, so only once. vb2 does not have access to the the control=
 handler,
> > so it can't call the v4l2_ctrl_request_complete() fonction directly.
>=20
> But the function is called per queue. If a buffer has been queued on
> both the capture and the output queue for a request, won't the operation
> be called twice with the same request ?

Only the OUTPUT queues allow for requests at the moment.

Nicolas

--=-0n+5qroluuyyHlNQ2ext
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaV0wmQAKCRDZQZRRKWBy
9Jn7AQDeyY4kjtpnZZG7JwEnqTOs+lyxO60lExoeWpE5drqSugD9HD7kzWveYVB0
UnBGGCZ6tW977jr9M+F4FcuB09TOmwk=
=F7kE
-----END PGP SIGNATURE-----

--=-0n+5qroluuyyHlNQ2ext--
