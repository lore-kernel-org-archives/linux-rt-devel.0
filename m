Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427081;
	b=wyzjwsCqwo2lHIof5fPgLvg5nfWANExaA24sarqQVqR1rZ+A2c6CHWyTNO0yY/UKROxp
	 Ht15QTMa2EFYmFNGZZ/c1Isrfy+yVD63j5PgjPZAp19/iyDpxpKxkiiiCCbDp19T6txn8
	 omVN37EIloBskjUy1pq6PCYypPA22m4paFWxbPdxD0shk6TVqPd3wvlaSgLHwYK64a9pY
	 3IGo/7dPvjjwkmJ1/lcV+V4QdCGGA/4TmCJWW6uyitmI+jQmfvTgzoel3thoLb6CR1aiU
	 H6lugP4znaqLiBiv/ZK+cMSsYjW4FiQ+dsQEDGUnTPEXY5XeqAhjDjyTQ91FhtP3e9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427081;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=xAxLPoFVOttISvwgpfOSavI0p5jbaEraXXlYnTTJXKY=;
	b=08Z5rNE3Gm5A8vR+wuADCYGZA/bzMDYD56EjQBxaT7KNT+JpRor9uBnMr2qP8DR6m2ER
	 X9R4xQs8yN1SAITxpk9KatlfcTAx3r8byveKPdftMsuoGbSGKNuoasOXxV7DokoK01uMx
	 6lYX5L372EduCRxqTaX1XDEnlLb9TAu91GgFYs8oArvrjZHgfLYLzuDPtLKmiGVdbwTAa
	 hEUfZNnzcQlbTodpBlLtM6C6GVpOCXpfVFoBxcoit03APXNAFvpJDn2q0DIsf8Lutac96
	 inX7Pe3VGaibJT/a3ijVC9nEZbm1y77l+gtmR5O56p+ooohhSITxp+ggDJAOGBP6AFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dogmpWC5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8C606A31B;
	Mon, 19 Oct 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dogmpWC5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE2C1F000C4;
	Mon, 19 Oct 2026 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427081;
	bh=xAxLPoFVOttISvwgpfOSavI0p5jbaEraXXlYnTTJXKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dogmpWC50DIS1qBFqzPbRaNvKY0754TV0/u4XKf502zbagtd3zJSCoWLxgnxMpXtx
	 buZjOC2Alp1abVjoSAi6W7D/QrKZ9p3Dpd1NE1jm/LJfaA00g9F52hPcrREfzP12YZ
	 95YNOby4oTVop67BXZkD1RTmev7A9MdyS+ykdefHglsVsAugIE9xlHeQWT+Xfx2zg5
	 vLzx0W5pujfb6vDkjiaLAwXplRTL8+BMTKby5uG0uzqtN3IBAh8IEo2q3+3AB7tbyq
	 78/gI/z7q6fhM/45GfG6k5lGjw1CwF8g9VEJfonsuEsWM4cQlZhMYlono5t0LjSFo7
	 Db8nubBn+L+Uw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id E5D3A1AC57D0; Mon, 19 Oct 2026 17:24:38 +0100 (BST)
Date: Mon, 19 Oct 2026 17:24:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ilia Lin <ilialin@codeaurora.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 0/3] soc: qcom: several fixes for SAW handling
Message-ID: <atZERpNxrP26VAHQ@sirena.co.uk>
References: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1DsZrlLUsEX0miaB"
Content-Disposition: inline
In-Reply-To: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
X-Cookie: Pushing 30 is exercise enough.


--1DsZrlLUsEX0miaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 05:39:18PM +0300, Dmitry Baryshkov wrote:
> The Qualcomm MSM8996 / MSM8998 / SDM660 platforms use SPM / SAW core to
> handle lower-power modes and to program core voltage regulators. Apply
> several small fixes to drivers for that core.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (3):
>       soc: qcom: spm: fix the SDM660 silver L2 AVS control value
>       soc: qcom: spm: don't clobber the SAW control registers
>       regulator: qcom_spmi: don't take a sleeping lock in the SAW IPI

Are there any actual dependencies between the patches here?  Please
don't create cross tree serieses unless there are dependencies, it just
makes it harder to figure out how things will get merged.

--1DsZrlLUsEX0miaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatZERgAKCRAv73Ows9A4
ibbPAP48TokB0MoOR1H4xglV3MhpwUQt3GcHobhuQM1N0JDL/QD/bhntbMOa1/+u
UprgOPQCJjQaKHwyavlnfpZvQ3JYTg4=
=ZRbz
-----END PGP SIGNATURE-----

--1DsZrlLUsEX0miaB--
