Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4472378D7B;
	Sun, 28 Jun 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782682091; cv=none; b=WUard6mwL0A6T1fNwXszdfnPKrFKbFoz5FVp8hrG5TXRKVe/leX50jV7Z6SF1jK2x6p+dC6RHt1ZsIB/dUUgM3XL474NQqMg2Z5k/G8T6sd/DjVkKY+Y+uy40YulfQVawckbMz5NM2yqFmcSp3egLyXp6fYO1WDIFp9BhKxtXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782682091; c=relaxed/simple;
	bh=zh1wV1w2CSzhEBh36AUux1ZueOfi7KYx1AdrWJV5pRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gbk76IjizPi7PFLkw/p9fSCIlxR+rMoavsh1teUd34PpvS8tBkLBlbxa0GLbOl9/v5xDvmC2SqQXTySq+NS+SWodwRz5UP64xOZMSweRe6SogVJg06szOL5MEfttbrRJR0FUarD6wyLzEU2l4BQZIZDPEr6IQYdKd3GC1DIbtBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPOCLWIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPOCLWIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F6D1F00A3A;
	Sun, 28 Jun 2026 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782682090;
	bh=ZWPWh1c+XXN96cK0WI3TPZzyv0n7L4OvLl1E1EanNpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPOCLWIpolOEfsluMRJ1DNGprvgTUG5cTdwsTn9Vg+yUXwYY9je7luATe9f1FgD+K
	 4j8HdjAxNS+cGJaz2o592xdxQnDSJXL0fnrgPqtk8QMM/DS9hMnnAQ0hSJOr8cfzC7
	 wL6G7gXo7HKinmrvI3xg0HS/GeENcyMRKXzu+7YcvQdPHRCgrPzlEDA/F9H5aM6vyY
	 vwsp/xo0CG4+hl04ofTQohwlV2c6PhAgwqKikTH3It6okJXwskGnGAkZQFxUSSU0b9
	 7itAtts3H3tg749iWpaBzlDp3PhMvsLJBRLqZ4PO5Fr1b77a1PcM16ogfA0dFCzH9g
	 O1M+p2Uvq5iyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] riscv_cbqri: Add capacity controller probe and
 allocation device ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-4-c9c1342fe3cf@kernel.org>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-4-c9c1342fe3cf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 21:28:09 +0000
Message-Id: <20260628212810.05F6D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unspecified evaluation order in `cbqri_readq` causes a torn read=
 during hardware polling, leading to false AT capability detection.
--

commit a52377aec62b1aa81e5439ad733c3839af6693c6
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add capacity controller probe and allocation device ops

Add support for the RISC-V CBQRI capacity controller. A platform driver
passes a cbqri_controller_info descriptor together with the cache level
to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
to the controller list.

> diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devi=
ces.c
> new file mode 100644
> index 0000000000000..69df46e07df17
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_devices.c
[ ... ]
> +static u64 cbqri_readq(void __iomem *addr)
> +{
> +	return (u64)readl(addr) | ((u64)readl(addr + 4) << 32);
> +}

[Severity: Medium]
Could the unspecified evaluation order here cause a torn read during hardwa=
re
polling?

Since the C standard does not specify the evaluation order of the operands
to the bitwise OR operator, the compiler may emit the lower 32-bit read
before the upper 32-bit read.

During the polling loop, if the final iteration reads the lower 32 bits
while the busy flag is still set, and then the hardware completes the
operation and clears the busy flag before the upper 32-bit read executes,
the loop will terminate and return this torn value.

[ ... ]
> +static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_of=
fset,
> +			       int operation, int *status, bool *access_type_supported)
> +{
[ ... ]
> +		writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +		if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +			pr_err("BUSY timeout setting AT field\n");
> +			return -EIO;
> +		}
> +
> +		/*
> +		 * If the AT field value has been reset to zero,
> +		 * then the AT support is not present
> +		 */
> +		at =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_AT_MASK, reg);
> +		if (at =3D=3D CBQRI_CONTROL_REGISTERS_AT_CODE)
> +			*access_type_supported =3D true;

[Severity: Medium]
Does the torn read from cbqri_readq() result in misdetecting capability
support here?

If cbqri_wait_busy_flag() returns a torn value with a stale lower half, the
driver may incorrectly detect Access Type support on hardware that does not
support it.

This could break cache allocation isolation guarantees, as the driver will
split capacity blocks into CODE and DATA masks, but the hardware will silen=
tly
treat them as a single pool.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-dfustini-a=
tl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org?part=3D4
