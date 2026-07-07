Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9D3859DF;
	Tue,  7 Jul 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452397; cv=none; b=VXdNHTU2k9hci6PeVTOmtYgtpIAtcfH2GMXcJhoB/kUN2SNC61hepiOeMA682HD3/U0kpEffcTLGYezoNP90NRGx9K3FG8ItuqNwjD2+IxAJ1UpfBtJWTZTVMWWIfbV7rdXIoHowYnCPH1iCrNYtAaYn9JsVCP+esv/PFmoObYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452397; c=relaxed/simple;
	bh=0/PYz8AAmDx6GuhrFyTeLVO7zjHVCWvDmL+dQgw4xUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbfUb7BKOyL8wyHO/lVFqN3draWL14ScL77zcaYOBG9/1D/hjcaegj9z4UK9p6PSav6tKXFBT60BtUxGTLaFPITffcwcp8QSaLvXFw00N6ZLLnyf254crugzgPtZUB4QM40h6e5HTOt27M/e9/QIjL7lvPlgRASO4dJVQ9FD59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAjyaq67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAjyaq67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ABD1F000E9;
	Tue,  7 Jul 2026 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783452396;
	bh=0/PYz8AAmDx6GuhrFyTeLVO7zjHVCWvDmL+dQgw4xUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jAjyaq67h3aIS9SIgV3N0ca/py7U5gGDJ5aC89MvU5eUoWjT2RFZfjUSEj1vuXR83
	 tYWNCEnr5HCkvXepgUF7RdE0QqgA+hLFANm2im06mOdZlQcmn4TfowtJpDxm3eBfr7
	 zDAmVP7b3JwKrQrbo06YmWuXRzbRckx7BIB/+uAQL9jG/n30RwCnt5DU+HNvCk7kNf
	 RAwD1VOkmng/NF3jVTWYOcqZJdpTQCzgZCsQ63cGVg4V6HfDGw8ighstkSVEHfejcx
	 YcPDR5ug8USqSHoAlzkOZmXGQdKb40oB3UtBvhhaOtk3sNbiEEnocRHWly7kr5H8+V
	 s/U/yP7WAP4rA==
Date: Tue, 7 Jul 2026 12:26:34 -0700
From: Drew Fustini <fustini@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>,
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
Subject: Re: [PATCH v4 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
Message-ID: <ak1S6stZ6Y1iLj2f@thelio>
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
 <20260706-dfustini-atl-sc-cbqri-dt-v4-8-e75c20201d64@kernel.org>
 <aky9S8A5dgIJjd7b@monoceros>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wBdm7NaO/F3mvZ63"
Content-Disposition: inline
In-Reply-To: <aky9S8A5dgIJjd7b@monoceros>


--wBdm7NaO/F3mvZ63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 10:48:32AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Jul 06, 2026 at 04:06:18PM -0700, Drew Fustini wrote:
> > +#include <linux/mod_devicetable.h>
>=20
> Please don't add new users for this header file. Only use those
> <linux/device-id/*.h> that you actually need (if any).

Thanks for the review. I will switch to just including device-id/of.h

Drew

--wBdm7NaO/F3mvZ63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCak1S5gAKCRDb7CzD2Six
DHlpAQDdGHQhtjb5i4voWvj8dOvD9/iBGOUI20Vlg8krBkESVQD8Dx9SgPodnTs4
Y2Jx/hpo8cNk9JmOdZ9qfpeGwS1pPAE=
=rAy4
-----END PGP SIGNATURE-----

--wBdm7NaO/F3mvZ63--
