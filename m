Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7633A1E62;
	Wed, 17 Dec 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980691; cv=none; b=F6v8uNrWCjMpJkcx5wlxgPxipRur2ymt2WUSznGbSMXlyoY0zO7ik6YDJTkXkdom/IIzb95DLJRrS4DKk01YqBMT6DHhp7aXKxDw6zvyPEHPjPyFFSTWXdRJNMh+grK8Gj3aQFTnaKMsiMAcPPsHiV50EfpqpPEQbmH9iAdxw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980691; c=relaxed/simple;
	bh=a1X23O2Ea/uTr4dYufyBnlbvAwj7YoNS1KKFnGey3Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grhOJA/EktcE4h1BP1IDFhBw+LjuIgrGzLoTBCFYEwdeXtlYdVPky6WI7rIVlfow/X1ZtxeMziMWFrbQOZzMijhivtHIJlcHh46rDCQinVrvW5l7nZQb6bz2CivtazUU2VCSoDLXW/EBSnfcwFcE1cg1N4YgpDIw2Gk/jmAygBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrkvJohN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrkvJohN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE98C4CEF5;
	Wed, 17 Dec 2025 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765980690;
	bh=a1X23O2Ea/uTr4dYufyBnlbvAwj7YoNS1KKFnGey3Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrkvJohN73JXpWWiAq4U3djyYe9zjMLxWQGOkk4DIGq0aY0ToQRNC1s1i7PnKKG1j
	 ccMXoCCqlKVLArYtwg1zLuDYLVImyB42sySfN6hUGq34tAphYNgCaLj5+WlWW01NST
	 aD6Ss8BqQ4sAcM4UxAwX+LkPGZLGTJBRrou/CnOY5JAGjYChkZPL5GTMOB21B/57IF
	 SNiOYNAAX+8mwHkGX+rxfF2hrNOCxNp6bzj6fGrdhMjeMWyreYKzlzu6GB3sJ4SqE8
	 /2C/BHrSJfaREiIdwXpR7WD7H6sFhUVKKGlGBNNPBWd4S4/imapZVY7m18orV0gITk
	 5c/F/YYh84ueA==
Date: Wed, 17 Dec 2025 14:11:23 +0000
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
	Emil-Juhl <emdj@bang-olufsen.dk>
Subject: Re: [PATCH 05/11] ASoC: tlv320adcx140: implement register caching
Message-ID: <8fe80735-dc06-4629-acc3-d6529e61d959@sirena.org.uk>
References: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
 <20251217-sound-soc-codecs-tvl320adcx140-v1-5-293dea149d7b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jH04PJFKinfLyZh3"
Content-Disposition: inline
In-Reply-To: <20251217-sound-soc-codecs-tvl320adcx140-v1-5-293dea149d7b@pengutronix.de>
X-Cookie: Big book, big bore.


--jH04PJFKinfLyZh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 02:54:55PM +0100, Sascha Hauer wrote:

> The tlv320adcx140 can be connected to controllable AVDD/IOVDD regulators
> which when disabled will reset the registers to their default.  In
> preparation for adding support for them implement register caching.

This patch doesn't actually enable register caching, there's no cache
type specified.  Indeed, the driver already has a register cache which
for some reason is REGCACHE_FLAT (which seems rather bogus and will have
defaulted most of the registers to 0 which may or may not be a good
idea).  This looks like it's a substantial improvement but the change
doesn't correspond to the changelog.

--jH04PJFKinfLyZh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCugsACgkQJNaLcl1U
h9AjIwf/X5qlWU0vYPRGkmI1ca9ohgGzS8WJUThDAZ6tFqHl/Xne3bG2Rtp2eftp
51QiepBePgX+0bo3IiMzz10WVw/vGi7NULLEiVvh4Vw4mGoVdIqdb+zf06my7Yhr
EbAiBC/Hjn8xK+w5gRN3vGzvs4ULfEn+BpLJiYcBJO+FiqLrGJ84chNcLG1z3t/v
FWsKnDGQoa5LlWUETwghJm7fw30x+uEuuiBsQ2k5413u8wLH8s8D3J7DjR9dweOI
cBYrSIzMYVMA5xIk8mW4mKNjtby55Q085udpCdzZp/4jGRuSvGfYMTRdas/FZHp0
6MVVOXMMfE2JQ6hw2zwmTnb50Z137g==
=hBIM
-----END PGP SIGNATURE-----

--jH04PJFKinfLyZh3--
