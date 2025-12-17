Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732235A93E;
	Wed, 17 Dec 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979897; cv=none; b=eAegkynpaeGY1txwSlwdkdsz9HtGuf5eqoP0avJ3qoZqzzLTSh/XdppkhpMUDP+yEH1x/+CzKjepNHKn9oAbnTqkIPUycKU9VDHYOpfnGXlulNJXjZEn4yvIyeeX74W3h/Gco0S+hbyZrQTa6L7LERheG8QEebXD6awqZvSkDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979897; c=relaxed/simple;
	bh=RLTtIHL+8ssdN0LOd4IbIYWj6sDtUvnRVhgT5giRWvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED+c6Nq9/33gPAH2Mo30bxL3RVwgPHUofZMQ+JIFfLs7jb5w09gA2/rmqpp30+inK6j3KxR77NCN7r/9FaoZ9aNhua4FQXBjkJMdKZhc3opIp5GnVVaBQK+YobXgHM4x0MmNBfS+Proy2HWdZGKlYZ3+iAZoutxUwNi25pF/fkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVh4d34v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVh4d34v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCCBC113D0;
	Wed, 17 Dec 2025 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765979896;
	bh=RLTtIHL+8ssdN0LOd4IbIYWj6sDtUvnRVhgT5giRWvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVh4d34v4rcetfDxZF8EY1b6h03VGuxyXkney0hjtyTsW+mh9/l1gEM9k4l1oApmn
	 LvdZiKzsPcR1+OBB2LWpzj6sAXEUnE3pOZ4h8g+HKgkEKbd8AJGLel9K+cSUPijW19
	 Ia4/hzAgXhZ2/7Af3TXsMa1mapptBuk+NjN7mtquV05OkLr46c2cxKq6wXWhU7wU3u
	 0qQYHz8jna0Vs/OurSumAhUJo9pnr5sEpbTIIfFU7R2Ga9JnOtLpFAjLK7rJXO0Zgt
	 oTcjd+YXY2QhQUNrljDKP462RP7G2IaeQwAUGPvK2f3JGFTny5oBxm965W4YXlkUFe
	 xhjHTlQAMG49Q==
Date: Wed, 17 Dec 2025 13:58:09 +0000
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
	Emil Svendsen <emas@bang-olufsen.dk>
Subject: Re: [PATCH 02/11] ASoC: tlv320adcx140: fix null pointer
Message-ID: <0a1c34ae-16f2-4e03-b8e6-6a27c811a1e5@sirena.org.uk>
References: <20251217-sound-soc-codecs-tvl320adcx140-v1-0-293dea149d7b@pengutronix.de>
 <20251217-sound-soc-codecs-tvl320adcx140-v1-2-293dea149d7b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s/+9y65xb/fH6ROY"
Content-Disposition: inline
In-Reply-To: <20251217-sound-soc-codecs-tvl320adcx140-v1-2-293dea149d7b@pengutronix.de>
X-Cookie: Big book, big bore.


--s/+9y65xb/fH6ROY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 17, 2025 at 02:54:52PM +0100, Sascha Hauer wrote:

> Kernel OOPS:
> [  438.223704] Unable to handle kernel read from unreadable memory at virtual address 0000000000000018
> [  438.232776] Mem abort info:
> [  438.235569]   ESR = 0x0000000096000004
> [  438.239326]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  438.244646]   SET = 0, FnV = 0
> [  438.247764]   EA = 0, S1PTW = 0
> [  438.250906]   FSC = 0x04: level 0 translation fault

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--s/+9y65xb/fH6ROY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCtvEACgkQJNaLcl1U
h9Clogf9E8YzNWLUTsIMpec9hGJ5U1pdxlIZ33R0El8wCw3ujTH+Hxlgv6wuSwSt
jf+VFkjbqo5KwbWxp6I+Kmh2IEMeTvD8sZil2KuTHwMryZrCJlQvnpDKODBA67ct
m4qxqD6Ev4SuYMkkW2GvOChPD9ejFJWLLVWRRlrrU7XA07WfZl1kCRKtaMW8PnQ7
ZYJM/7e94ch95aeAJQNF8CrBnbaGLPo5Eefjwk/6lQjVpImnkYQETrmMKkmaAtyI
kjwO4mUvVvjm5lsmwYxiIuCRW87860ZO8vpqFHkIXr67NwvEIwOXSf4sxyZQZEum
CJV9QC7nFoSqHKP3vm53GX6JRRgCWQ==
=XMq/
-----END PGP SIGNATURE-----

--s/+9y65xb/fH6ROY--
