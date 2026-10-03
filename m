Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4937E5DB;
	Sat,  3 Oct 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791011952; cv=none; b=NHGnjhm40f0+u8Wa6K65fhREfud02SvLHNUOPLyd1jtxRw8TodqTTr6x0EJE03ms5b6ro7RX66Cuwl59+bmekX6gz8atGg2q5+6o37U6zpM4Mvo09LzayRZNi2uHq+Q+SrqOZFz9Elv1xi9h9RMXgZw4S4ZlPt8RJh/11c8ghvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791011952; c=relaxed/simple;
	bh=XOR15HJMuhOU7rchj1oZfMyLgji64tblsTWwSmI8G2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NxcazWFlRH/KsP90HrJREZP3SJShp4IQ40WmWCgwNpboSnfGzTZFPtkaRleDbWAAOozeZ6tcbMaYimhiakPqUkbs6rvg45KrFEM+evk71CnmlMAiwyLJ/rqIIVpEBzqN7IcfrhQY/p4njPkbVvgEltzLjFfw09W+wzDmG+fczZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXpX1kQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXpX1kQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF22E1F0089C;
	Sat,  3 Oct 2026 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791011951;
	bh=WO8SoAYmR/PnOcHnhHmzwFDxcKmkbBVhDCS7aQ71nbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXpX1kQOv2qNzHz71CTAhhjoJr+INqHci4fhsdHPjnrc+e6vN2Hc/xM1jOhIp6032
	 xUKbayXkNbQ8YVP68UWVVeu9L5DvOi8mszp27D8sCmDO6pcHHmizL8EqgZH/pS+YoC
	 Aozm6HXblMJHsEUsUlleTd1iNMssd3jQLGPJqL72uDa1GEdeYzHHvLB44VLC4gQz4y
	 fXtHHuWDFedIvvYcvBrfxvNNssJHgjwKGghZLWt1qjH4W5odxldfwXNnZtEYOpq+hu
	 6nEVIUNJjT/xQdEqAVGEtm3a0xbKvqGnKmRKPMzafowbEm0RB/mImMpbRM4lwZaeRI
	 NIWCDkZdnV//w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] dt-bindings: riscv: Add binding for CBQRI
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261003-dfustini-atl-sc-cbqri-dt-v9-4-52fd8be98dcf@kernel.org>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-4-52fd8be98dcf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:19:10 +0000
Message-Id: <20261003071910.DF22E1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: riscv: cbqri properties unconditionally required ag=
ainst intent
--

commit 5dcd168e7171a1ca9e65e913bdb55cea23dc0357
Author: Drew Fustini <fustini@kernel.org>

dt-bindings: riscv: Add binding for CBQRI controllers

This commit introduces the device tree binding for RISC-V Capacity and Band=
width
QoS Register Interface (CBQRI) controllers. The binding covers capacity and
bandwidth controllers, including properties for resource-control IDs,
monitoring-counter IDs, and cache phandles.

> diff --git a/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml b/D=
ocumentation/devicetree/bindings/riscv/riscv,cbqri.yaml
> new file mode 100644
> index 0000000000000..0924758ebdde6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
> @@ -0,0 +1,97 @@

[ ... ]

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: riscv,cbqri-capacity-controller
> +    then:
> +      required:
> +        - riscv,cbqri-rcid
> +        - riscv,cbqri-cache

[Severity: Medium]
Does this code introduce a regression by unconditionally requiring these
properties for all capacity controllers?

The commit message explicitly describes the riscv,cbqri-cache phandle as
optional.

Additionally, the binding description notes a controller may implement only
monitoring without allocation capabilities, meaning it would lack RCIDs for
allocation operations.

Because the allOf block rigidly requires both properties for any
riscv,cbqri-capacity-controller, this appears to contradict the hardware
flexibility and will cause schema validation to fail for valid device trees
describing monitoring-only or non-CPU-cache capacity controllers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-dfustini-a=
tl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org?part=3D4
