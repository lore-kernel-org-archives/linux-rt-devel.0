Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754530F7FF;
	Mon,  5 Oct 2026 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178895; cv=none; b=YHFV+EKf6ryTcf2PMtaNFULw2nhTbXjhqKQzukETKs+W5vj/vK8Fd72rNl7Y+sfSzIgrmfRjZdPYmU0Ta/J6darALR863uJ7YVLT4f0f6Edv8LnftGWeXfjsLSjMq2vOjeiY37T4TbCBvnnz6TNEZGvXymHsZN2HjorLHyLAvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178895; c=relaxed/simple;
	bh=hsw9NSPhz5CedlJYWGP0Mi1O/i0VaMefug0YlhuqREg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI8Vx7dKSJ6P7LFE8CeTsRLPFHOMsBMOu1PzzZm4gCVEjNzj9liCNDzhePbT5deaPhW62G6+ZIVTFSYWL/h/KkwpxpDEjmm+LQLPnFVnu+tcZQURCSNzE9gcVp2Kj+rDdMGQQDOIV8Fxr2omTD35ZTrQHA0Ju7moq0DxAizwEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXMeP0jW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXMeP0jW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5637D1F000FF;
	Mon,  5 Oct 2026 05:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791178894;
	bh=kEvPPDlseXzo0VIEtns5Uo5OEVsIzZ5vK243j+h4K6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jXMeP0jWqoqNrZhtOmvSchDhn3bNHe6vW/ozxHYYcIL5McnHyeVgS7Q95L6P+lEKE
	 1fmOaHh2gm2yH923I7eiWIAjkC8eu05eLFkokl+MZUoigplShMS4YdChUwy9yN+Kgr
	 F4NB7Tdf09vOzpaZgSDgxhpH/34X7zuG6kw0ga2bbbwRs4HAIMrLR/wbTBIfTzjIAu
	 OZ75zMRYuKhWsSjx8fRzNlQyenMiYLe66ADtlq/F66hxqt3/pQXG55E8oIIrB8hErL
	 9l9SEuzyCsvRdzK4gt5qgTyIaoPPmJjbDFmh1Th/DdGGDSW/xWHDb3D485A3m3jdOI
	 q6g47SDuM3kkA==
Date: Sun, 4 Oct 2026 22:41:24 -0700
From: Drew Fustini <fustini@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
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
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 4/5] dt-bindings: riscv: Add binding for CBQRI
 controllers
Message-ID: <asM4hITT4dNVIndy@x1gen8.tail89d63.ts.net>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-4-52fd8be98dcf@kernel.org>
 <20261004-fender-oink-1646de550f3b@spud>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="maNOYJSQl7XIC3wz"
Content-Disposition: inline
In-Reply-To: <20261004-fender-oink-1646de550f3b@spud>


--maNOYJSQl7XIC3wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 12:05:31AM +0100, Conor Dooley wrote:
> On Sat, Oct 03, 2026 at 12:12:29AM -0700, Drew Fustini wrote:
> > Document the device tree binding for RISC-V CBQRI capacity and bandwidth
> > controllers. Each controller is named by a device-specific compatible
> > followed by the generic compatible. The binding also describes the
> > common riscv,cbqri-rcid and riscv,cbqri-mcid properties, and the
> > optional riscv,cbqri-cache phandle that links a capacity controller to
> > the cache whose capacity it allocates.
> >=20
> > Assisted-by: LLM
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  .../devicetree/bindings/riscv/riscv,cbqri.yaml     | 97 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 98 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml b=
/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
> > new file mode 100644
> > index 000000000000..0924758ebdde
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/riscv,cbqri.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V Capacity and Bandwidth QoS Register Interface (CBQRI) co=
ntroller
> > +
> > +description: |
> > +  The RISC-V CBQRI specification defines capacity-controller and
> > +  bandwidth-controller register blocks that allocate cache capacity an=
d memory
> > +  bandwidth to resource-control IDs (RCIDs) and monitor usage per
> > +  monitoring-counter ID (MCID):
> > +  https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.p=
df
> > +
> > +  Allocation and monitoring share one register block, and a controller=
 may
> > +  implement either or both. A driver discovers which at runtime from t=
he
> > +  capabilities register, so the compatible names only the controller t=
ype. It
> > +  does not distinguish allocation-only, monitoring-only or combined
> > +  controllers, and no property declares monitoring support.
> > +
> > +maintainers:
> > +  - Drew Fustini <fustini@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - tenstorrent,ascalon-shared-cache-controller
> > +          - const: riscv,cbqri-capacity-controller
> > +      - items:
> > +          - {}
> > +          - const: riscv,cbqri-bandwidth-controller
>=20
> I think I lead you up the garden path here actually, it needs to be
> "- not: {}", "- {}" permits anything.

Ah, good point. I will change it to "- not: {}" in the next rev.

Thanks,
Drew

--maNOYJSQl7XIC3wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCasM4dwAKCRDb7CzD2Six
DHDzAPoDfbP02+kZlbXNjkO9p6YVGEPpNzVD/2lUwGTPtG8jrgEAmupMZOgQVR3D
O+0kZ5PUEUvEiYg7LLv7Xo/SkiA+fAo=
=sKfI
-----END PGP SIGNATURE-----

--maNOYJSQl7XIC3wz--
