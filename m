Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D80253B61;
	Tue, 11 Feb 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291164; cv=none; b=WF2U/OMvxnxfX14cG5Hvpcfwh5DvzJeCHtGBuwmXy5sYyFtFk6YJsX30HUE5tZOTWmGoZenUtvKh8oRocK+Tu0Z19AFQRnlU1/pRTaRoh/5O4kU5nsABEgWxc1Kt6+ZLnNarkhWx4Yo2arD89nKSBDfOpCBMmwZc/z2LUrKGPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291164; c=relaxed/simple;
	bh=bhRsq0b5reECDJvaMAqhTXpua3kqM/0rBeuBIVouF+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7vrOWlZrZf4wEcPiaq691VSl7OfLQQxJ1AwIA+i0vCExOoCNZpd8Bg6P5jnuXwCn9AWDE8LHrUNeln4MgS6hAIvABcHwFDldKYDKgSsXWtnI1pSZjxEx2v224ZYVxSgrwi6fqRV8e4ZSaZXADLUEV6FEUkPhWKdWQvTVTMGxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtOLM+mW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtOLM+mW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64A1C4CEDD;
	Tue, 11 Feb 2025 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739291164;
	bh=bhRsq0b5reECDJvaMAqhTXpua3kqM/0rBeuBIVouF+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtOLM+mWfmLAttg7/2FG74ZO8YFOUBB4a1hGPkGh/8QJwdfj29Iyj0exaQplJjqiD
	 2GtyHmFM0BH394XNuKUuxUUR9RN4jXsDrih2hhlXYEjipqA6pByNfPzsLwyqnpFy1V
	 A4djSjSIsGLDqhHjvNqPICppJ+a8sbOGi+P+4EWisjPy7j/mp27YuLd1bKU7+rozBI
	 YI/mhOHopQibgpaj7dVeJBBy8ANpZAjFsf3G2V2AkkBMuVV7nydtUPedgsANMjkPKs
	 miyjf0Vjo5lilSpluU6+2CFDn+HiU4nJ0INjU4rJ4UqJFBpmsHa7op+MUbthPdomR0
	 Tun4u8K63/DOw==
Date: Tue, 11 Feb 2025 16:26:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Gustavo Padovan <gus@collabora.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kernelci <kernelci@lists.linux.dev>,
	linux-rt-devel <linux-rt-devel@lists.linux.dev>,
	stable-rt <stable-rt@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
Subject: Re: PREEMPT_RT testing on kernelci
Message-ID: <c357446d-6df3-4e29-a9d2-fb4f94e34ac3@sirena.org.uk>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F5A77GSB2tRzHk7e"
Content-Disposition: inline
In-Reply-To: <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
X-Cookie: Printed on recycled paper.


--F5A77GSB2tRzHk7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:50:47PM -0300, Gustavo Padovan wrote:

>  > The architectures, that support RT are what you see in=20
>  > | git grep ARCH_SUPPORTS_RT arch/=20

>  > so this does not include arm at current stage for instance. So in=20
>  > general, if you can't select CONFIG_PREEMPT_RT you can skip the=20
>  > config/ build/ test.=20

>  > RiscV on the other hand is supported.

> Right. Let me look at how we can limit this to x86 only.
> Unfortunatelly, we don't have much RISC-V hw support in KernelCI yet.

We should enable it on arm64 as well, there's plenty of boards for that.
The current list of supported architectures is arm64, loongarch, riscv
and x86.

I'd be happy to have it running in my lab for the boards I've got
multiples of. =20

--F5A77GSB2tRzHk7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmerehcACgkQJNaLcl1U
h9AXUQf9H91n4wKdeyjpiFDBhd7BTmf92KidIyz24azYCXZsFnIQYBLLNLHFFsA+
AxU/8lxmeQAVJZ7+sbLtmc/4c/HeBT2FJ6wFZe/hvXcgGyqfs6vSRSK8EGMlNKGA
QQbXagxbmrHbhjgMEFjzvLKiuGm9B1KuKdNe1qYk2JSIFy2SAacArCaXLjJxkQ8P
/1lDOMsksQPZy7LseLSZhfMdIZ4hwRtftz7Tnrn6QUlEywVlPKnUy158pkuATdsD
ZG/4alb5KBSDMJi97d+IIOztsbzHZjKGMyzzntPa2dXljWYkalts6I9LLP/1jE2+
VVzMZ23Ysk4A81WDQ4CzW/Pr2mi2RA==
=N8Hz
-----END PGP SIGNATURE-----

--F5A77GSB2tRzHk7e--
