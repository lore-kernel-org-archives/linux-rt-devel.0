Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9D37A498;
	Mon, 29 Jun 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747178; cv=none; b=sYPODN4He+E9WnlatMHXZWM6oHeuGV7zoXIHd+V2ocB0tPIXiJrZE5aCQrcTcMr0WJGSSytUnSeALdlEPCz11m+ojjb/tIaxeJ6NPQtPQcycBGKBGqr/fS/N3aiE+8u9/qNDymGtad6W7tEDqSFnUki+CjS/wjEt5Q21Azu2DBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747178; c=relaxed/simple;
	bh=mnhHFQLWlBMk0jiGzanVa/9YxlSEiaiSag4o7iJqZ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKZ/IYyHFxazid4zEyPzVORvxewV5L95qkViRusOJ1NRvo6CB/RXDV1Yev7AqCLC9RKQdaDrQB94H+PbYDDQTBsIpXemSuMw/ZYU5/TcLcRpliQa5Tzh9dNDnpXrw7UlZiKeeGoZDK7r9P4DpwykvUDMN13wOWU3whSAd10Uw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh0eAxl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh0eAxl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEF01F000E9;
	Mon, 29 Jun 2026 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782747177;
	bh=mnhHFQLWlBMk0jiGzanVa/9YxlSEiaiSag4o7iJqZ3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kh0eAxl+BBoLZPsPIn17XfRi1X7McxKBvvQVYpAdbon0kRXRW+clGhx6RvpySqumF
	 jG8KHflJej6TDLujfuh5yv2JJP0dJ1RgDuQv1gCv9TIYOizT70Xn9mRI5vA/A4Bs2t
	 PP4aJ14LUJxYvnWtb/WK6EXvI38pRXQ159jH3Yo7xlmbk0H5NEE2xKQGh88MnOT8BR
	 QlUSxe6TwS99s8eM/jBdk+EM5fsqAJx7K2RNqiifeJdoVP3y5hn1cfPKBbmLUXUMDE
	 09HuRGd9M1bOtJD1D7RutTR60d1Pere18Eoi0B2S6Kp4VtaESPRZAB/n53hou0VCI9
	 xw2n06k3Qj+kw==
Date: Mon, 29 Jun 2026 16:32:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Newman <peternewman@google.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: riscv: Add binding for CBQRI
 controllers
Message-ID: <20260629-modulator-backlog-931a4600f567@spud>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-7-c9c1342fe3cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Rzri6Paspuk7yh4l"
Content-Disposition: inline
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-7-c9c1342fe3cf@kernel.org>

--Rzri6Paspuk7yh4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 02:18:18PM -0700, Drew Fustini wrote:
> Document the device tree binding for RISC-V CBQRI capacity and bandwidth
> controllers. Each controller is named by a device-specific compatible
> followed by the generic compatible. The binding also describes the
> common riscv,cbqri-rcid and riscv,cbqri-mcid properties, and the
> optional riscv,cbqri-cache phandle that links a capacity controller to
> the cache whose capacity it allocates.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Rzri6Paspuk7yh4l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakKQIAAKCRB4tDGHoIJi
0mPIAQDBagOfetNCVnYvlw3izyi8K+IDSYeG2DHQ5aFVQ93VOAD+MS7oATLWI06S
TGQz48qb5siY3bfMvtFbjmx4zT+eGgk=
=idfr
-----END PGP SIGNATURE-----

--Rzri6Paspuk7yh4l--
