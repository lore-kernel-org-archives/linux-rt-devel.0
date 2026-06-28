Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45A800;
	Sun, 28 Jun 2026 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782682065; cv=none; b=a+r+C/46w8Fttc6tHS3F5QRTqyhB0UG5pMO6FVjhQj/cTopaoFtraFb6FPIGC5fiCcsvoK3zWp72EpYRNoa8ujatrukpyqzQjXPPwNgchMfm3yrykra9ll6S9Xu8JDzp51CoKqvGS6dgZw3yi2livr04e5zEp71icgEjFr4HkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782682065; c=relaxed/simple;
	bh=ea4dVpezw/EbJhxV8uNz4U0rkQjeKs7ZqYUIWXA+CWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jFEbb9jg4799NPOjk6pbPx+72Xh4h2y+WeyUXrwd777+/tRYM+aWdZVA/feEf5/EkvKOzFFFlzsIAyyIfrleqEfugHbugfxlwKG9wVquPfQR9hinJk/swngCV4zOzBGp6bJalhDdUbdCcdmKa1KXhiTSUuISNCByIEQzRdu0DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/IgHEmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/IgHEmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD731F000E9;
	Sun, 28 Jun 2026 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782682064;
	bh=fJjer/LANUC2XilTj8XXLUPwp+ksw00Opp0yEV6FzSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/IgHEmf3j1aDMZs+8FhWrvXXCGlJNBGmSdIdpWAWV8tONEIKdXzv5r2hLaKGDZJJ
	 hqGjZGAAg/EdtAKBYHAD43cI1Xv4+n/7dZ5y/Ldp2M9c5138PvnyVv3BP/xgiTSXIY
	 W2Ygnn/oh0xcjrqx+OSJBMBSIBbavQrtNs8doyJSsr8mPXwZno+eWAzE1O3YOmIt9w
	 qL09uzA/4nY3p2hWqPLuZTU5ZCBk4wiw6MhMnWP4+alAY2o0MBJQjURjW917yKs5T+
	 XpSndCxiAhDf8mdIOTOSq902hpRA+NsbmSMK2pF/5nu4mH3oyNZFgPkFcBkrMqIi9X
	 /fwXHdHv3+UUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-8-c9c1342fe3cf@kernel.org>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-8-c9c1342fe3cf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 21:27:43 +0000
Message-Id: <20260628212744.1AD731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cbqri_capacity_probe() incorrectly uses get_cpu_cacheinfo_level(=
) to find the cacheinfo, which will fail for split caches (e.g., L1I/L1D).
--

commit 1a6b06fa1768e5d101b318b8e5167a959fc10696
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add CBQRI capacity allocation platform driver

This commit adds a device-tree platform driver for the RISC-V CBQRI capacity
controller. It reads the cache level from the device tree and matches it
against the system's cacheinfo to get the resctrl domain ID and shared hart=
s.

> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_cap=
acity.c
> new file mode 100644
> index 0000000000000..2172432eb3287
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_capacity.c
[ ... ]
> +static int cbqri_capacity_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/*
> +	 * Associate the controller with its cache instance via
> +	 * cacheinfo. The matching cache provides the cache id and the
> +	 * set of harts that share the cache.
> +	 */
> +	cache_id =3D -1;
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct cacheinfo *ci =3D get_cpu_cacheinfo_level(cpu, cache_level);

[Severity: Medium]
Could this fail to match split caches, like an L1 data cache?

The get_cpu_cacheinfo_level() function unconditionally returns the first
cacheinfo leaf it finds at the requested level and stops searching. If the
given level has multiple leaves (for example, L1 instruction and L1 data),
and the device tree node refers to the second leaf, this loop will miss it.
This would cause the fw_token check to fail and the probe to return -ENODEV.

> +
> +		if (ci && ci->fw_token =3D=3D cache_np) {
> +			cache_id =3D ci->id;
> +			cpumask_copy(cpu_mask, &ci->shared_cpu_map);
> +			break;
> +		}
> +	}
> +	cpus_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-dfustini-a=
tl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org?part=3D8
