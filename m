Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43F39061C;
	Sat,  3 Oct 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014036; cv=none; b=iYHqYKessTaNo0srkjq2ehShLkjcVPdN9p38lsDLFoIbDbctxP/rgP/aS+8kGeYiFwawiHj2/4La8Z0cAyez4RH2rp+DJH9FsopB5j2faoGB7Ep1hWuPx0yKTIVUJZjAECkROTdW5P2nGuJ/Wa3gwuPLX5XNoHFnkBvbbdtOdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014036; c=relaxed/simple;
	bh=V6/iesYll4WGuGiYWijoaH3N65XNXaEOB+q4etnOqlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkbsAqkGAi1fdICjGQuxGiOfoezgKhatJt3mLbSgrWvq3F/a0oJbZ6mwFavBVRiB+4YaLnhSwAeFt5wrNcRpdPd0mTZ8NcUzEowrhngl2KVxIFjTOeSb9IPxd3/dIfiOL/LdsN0cf7iHdx6l6kFAjWLoHNTDqY+QYrHk3LeQXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPBt+pBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPBt+pBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0401F0089B;
	Sat,  3 Oct 2026 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014035;
	bh=azoYULOWEmDVVWIav3ExlsZBBsYtE38HW0TqKqZhIc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPBt+pBMRhfbxueN47SoIKL+z2lZUy1d6enjkhUycfilzDG3+sJOfH5NebtnfpKhq
	 CcSDgl4AqOEQGaxDUFLWZBi1B8LdZ9RzeG79RRXQtk/fDyTF9fE+3t+f6EQ7hpIJRP
	 TrIOViIQ2TTpAELejEM3uUwRTouY+oDtpYEA7uuOClVkPQ3uybKOkkFxjyBJWOFXi3
	 zRI2kGQGvMjemGSUK0FOLjvLBTU57oOeW6JMYo9FxNMjKMBh2BUXmJy1R07Fkna4ya
	 SXcqyyobihgrsnVpNcwdfoWmuCGOiIt9GskCVMYOP7mHww0q36f6CzYkXCg6mkMAqW
	 bDdS3P5KlW5jQ==
Date: Sat, 3 Oct 2026 00:53:53 -0700
From: Drew Fustini <fustini@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/5] dt-bindings: riscv: Add binding for CBQRI
 controllers
Message-ID: <asC0kQ3xQYEjOm6c@x1gen8.tail89d63.ts.net>
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-4-52fd8be98dcf@kernel.org>
 <20261003071910.DF22E1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003071910.DF22E1F0089C@smtp.kernel.org>

On Sat, Oct 03, 2026 at 07:19:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] dt-bindings: riscv: cbqri properties unconditionally required against intent
> --
> 
> commit 5dcd168e7171a1ca9e65e913bdb55cea23dc0357
> Author: Drew Fustini <fustini@kernel.org>
> 
> dt-bindings: riscv: Add binding for CBQRI controllers
> 
> This commit introduces the device tree binding for RISC-V Capacity and Bandwidth
> QoS Register Interface (CBQRI) controllers. The binding covers capacity and
> bandwidth controllers, including properties for resource-control IDs,
> monitoring-counter IDs, and cache phandles.
> 
> > diff --git a/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
> > new file mode 100644
> > index 0000000000000..0924758ebdde6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
> > @@ -0,0 +1,97 @@
> 
> [ ... ]
> 
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: riscv,cbqri-capacity-controller
> > +    then:
> > +      required:
> > +        - riscv,cbqri-rcid
> > +        - riscv,cbqri-cache
> 
> [Severity: Medium]
> Does this code introduce a regression by unconditionally requiring these
> properties for all capacity controllers?
> 
> The commit message explicitly describes the riscv,cbqri-cache phandle as
> optional.
> 
> Additionally, the binding description notes a controller may implement only
> monitoring without allocation capabilities, meaning it would lack RCIDs for
> allocation operations.
> 
> Because the allOf block rigidly requires both properties for any
> riscv,cbqri-capacity-controller, this appears to contradict the hardware
> flexibility and will cause schema validation to fail for valid device trees
> describing monitoring-only or non-CPU-cache capacity controllers.

This is not an issue.

riscv,cbqri-cache is optional for the binding as a whole because a
bandwidth controller has no cache to point at. For a capacity
controller, it is required because the cache level and the harts sharing
the cache are taken from that node.

The required properties describe the hardware that currently exists. A
monitoring-only capacity controller would have no RCIDs to describe, and
the binding can be extended to cover it when such hardware exists.

Drew
