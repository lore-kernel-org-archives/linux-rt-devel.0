Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BD29CE9;
	Wed, 17 Dec 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980806; cv=none; b=ic2IjHuUsW+unCEf7wXeMAC2u6LRSArQWTqwP7iX+/gh1nITr9DCQKgW8SQ5KhtMoLEQbKD1TBdwcMb5Kej+bnFGTQ5okq9oTijj0X0lqz4WQ25ZCZvN9X083PIrHNb1v2lRZmLmxaQPh990fMzmX5tX4LmMMmBwmabyX7CGLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980806; c=relaxed/simple;
	bh=DOQltobG24SgRnUHNr9M0mUhUbL6yajzrJXvZBi/4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4A0PTq1FelMMUoz5FEeeq4y3+ae7KhMief6GxMxKleseuxjyG67DNAk+tBf75pyTIAe5Sqng3fQQa7weI2WAXCp4pNcvy3hMBukuUR5nkOu/if9gHpuB4agbXFVT8IULkHQLZvmdX6E/phjfvN1sSbK+gTtdDUdNXEIie+pEfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3XE7ijk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3XE7ijk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34878C4CEF5;
	Wed, 17 Dec 2025 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765980805;
	bh=DOQltobG24SgRnUHNr9M0mUhUbL6yajzrJXvZBi/4f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3XE7ijktFnuiVk39Bexd0NNryeuFqk+toXzMB/4wW7Kfus9CMZQQjcBgNzlhjvyg
	 A5comP4sgenefmWze2OpQJxp/zocApm6QYlhtMt5PhUvDwwCCL0pHPKi3xOE9htRzI
	 OCfNKM78hx7IhvPyPhjIYNKp3JyKMt+DO0G8U2Lv1Xedv/Ms20/xMhPzqoPl1JOpfl
	 vdaV+o5bSI0UMuOB/L6E5MGE/4TLMNwXYLJCmS2iHRn3gL+bfFHJpQvu4q3K/AC2Ps
	 fjRoefCRWcCfSvF3OaB555KyjSTmasLNbQaREZ8R9My98VRVjwQbCLey/876gV45aK
	 yAXC+4U3AAsWQ==
Date: Wed, 17 Dec 2025 14:13:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Dan Murphy <dmurphy@ti.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Lu <luminlong@139.com>,
	linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org,
	Andreas Sloth <anps@bang-olufsen.dk>,
	Andreas Pehn Sloth <anps@bang-olufsen.com>
Subject: Re: [PATCH 09/11] ASoC: tlv320adcx140: Add kcontrols for TDM Slot
 assignment
Message-ID: <4fd3114a-6073-4067-8767-d8b0c46b6f4a@sirena.org.uk>
References: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
 <20251217-sound-soc-codecs-tvl320adcx140-v1-9-293dea149d7b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0YHIsgwqsZxM36Tv"
Content-Disposition: inline
In-Reply-To: <20251217-sound-soc-codecs-tvl320adcx140-v1-9-293dea149d7b@pengutronix.de>
X-Cookie: Big book, big bore.


--0YHIsgwqsZxM36Tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 02:54:59PM +0100, Sascha Hauer wrote:
> From: Andreas Sloth <anps@bang-olufsen.dk>
>=20
> Signed-off-by: Andreas Pehn Sloth <anps@bang-olufsen.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

This is obviously bogus, we have an API for controlling TDM.

--0YHIsgwqsZxM36Tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCun0ACgkQJNaLcl1U
h9DE7Qf+PRG32p6QVVZo8eLx3Kf5ZmJDsB6PG/t9A8o2GlbM20OTrLUwZohd7RNA
aRGtIwgZL+FZvBLfnGC+/aR4ulMvyq2L+KGTV2zePpWQVa84fcFiDzlk69jYvZs4
EQPi5PtG1wjNUYthzCYa1p46e25ECXJIB0St0l31zeV7yqTe5xJeQ9TjBlr0gu21
e9LVokL3XheCUP0kaxMIVlwS6Jr91eWuaHlfEXHumr7kmog679kTGfpwTqFWezYV
J11/8pGO+Vp4bvNGDCRiPExcRKFEM/T7pcyX4f5LtGbX+Nh8WBgN3EC3r3oqrL0S
wfbA+p9WwVJDP8LsIxT/NRkDsWp9pg==
=wJAA
-----END PGP SIGNATURE-----

--0YHIsgwqsZxM36Tv--
