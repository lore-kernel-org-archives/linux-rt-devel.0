Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C0373BE8;
	Fri, 11 Sep 2026 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125625; cv=none; b=pO4DbErrmWtpIfOcdXbWKbr3aJ3B4F7BPeTPSK6lP9pU4tS9R651HwZx81J0rd2UAEZZZmPRVNVQakx2trTnH6dQe0l0Z1kEDb3LVBMbdmhWY03qO9+MKPHi0fwQebklsdpvIupADA270wu7ts7brVbLLyKbFDG/mPLyhNvK4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125625; c=relaxed/simple;
	bh=sFNM82QJx4NJSgdS1IHPMef1nDP7wdNVeB300erAegg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VMJLKQmrHke1F/3UhW7OBjwVNKRlAuBorn+XKGYkg/yn1sACqSdCICZMxyCPvmfZ0D+B8rYug4SrOaEia8eFcRrBPS95nO9vH3kuF5DBJq6xvi3fMVRPfS8Onz3WT5GFwiCI0XQu5du7uIVRi0zdU2p6v6gVY2x7aaGjpKc7LwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncmz+rWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncmz+rWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F161F000FF;
	Fri, 11 Sep 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125623;
	bh=s/ZBAEyLoD7LT2gpmEHkxBLgC785yZiW7+GCWkFRwo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ncmz+rWs2T4jUAOWo6F1XgFLxCbeEX4C94fIdzF1xoaJ0BTk8z44Mm9Ejkz7m/S6X
	 z0qmRusu9oQa+YjN9s+JkUh+eJjN7Uf/h5Jsa7DzYfTFaijHt3r10hNyq3V1420zGB
	 TyKJHE+//vfsgs2i6ZAcOVXR9wG6iAk5u+egGHee87AmmSQshicsgQvTBAvzc9HXKM
	 5H3YLx8WtdVb835UMgKTHKPxPjbtDnVjtHU5GQp4aHy3Nf47broFYvRFAIZZsnznwr
	 63EAlQEp3rR5gGhFxx7ddthGETOwB/AS+KtySqlf8cS9VfGhb0V9/RZO3DbXyLpgA1
	 g3QDP28/gL7Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/8] coresight: etm4x: introduce struct etm4_caps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-5-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-5-1b715d95927a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:20:22 +0000
Message-Id: <20260911112023.31F161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Hardware-reported capability counts are used as loop limits wi=
thout being checked against static array capacities, leading to heap buffer=
 overflows.
--

commit 1fb7a47435872f1b7f11824178d098d0258effdc
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: introduce struct etm4_caps

This commit introduces struct etmv4_caps to encapsulate ETMv4 capabilities=
=20
and migrates the relevant capability information out of struct etmv4_drvdat=
a=20
into it.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
[ ... ]
> @@ -1491,43 +1501,43 @@ static void etm4_init_arch_data(void *info)
[ ... ]
> -	drvdata->nr_ss_cmp =3D FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
> -	for (i =3D 0; i < drvdata->nr_ss_cmp; i++) {
> +	caps->nr_ss_cmp =3D FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
> +	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
>  		drvdata->config.ss_status[i] =3D
>  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>  	}

[Severity: Critical]
This is a pre-existing issue, but does this code overflow the ss_status[]=20
array if the hardware reports a capability count greater than the static ar=
ray=20
capacity?

In etm4_init_arch_data(), caps->nr_ss_cmp is read directly from the TRCIDR4=
=20
hardware register. The architecture allows this field to be up to 15, but t=
he=20
arrays like ss_status are fixed in size to ETM_MAX_SS_CMP. Using the=20
unvalidated hardware capability as a loop limit can lead to a heap buffer=20
overflow.

[ ... ]
> @@ -1892,57 +1903,56 @@ static int etm4_cpu_save(struct coresight_device =
*csdev)
[ ... ]
> -	for (i =3D 0; i < drvdata->nr_ss_cmp; i++) {
> +	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
>  		state->trcssccr[i] =3D etm4x_read32(csa, TRCSSCCRn(i));
>  		state->trcsscsr[i] =3D etm4x_read32(csa, TRCSSCSRn(i));
>  		if (etm4x_sspcicrn_present(drvdata, i))
>  			state->trcsspcicr[i] =3D etm4x_read32(csa, TRCSSPCICRn(i));
>  	}

[Severity: Critical]
This isn't a bug introduced by this patch, but does this loop risk corrupti=
ng
the dynamically allocated etmv4_save_state structure?=20

Similar to the initialization path, etm4_cpu_save() relies on the unvalidat=
ed=20
caps->nr_ss_cmp bound to write into state->trcssccr[] and state->trcsscsr[]=
.=20
If the hypervisor or hardware provides a larger count, this will overflow t=
he=20
save state buffers on suspend and resume paths.

[ ... ]
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
[ ... ]
> @@ -2059,7 +2090,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
[ ... ]
>  	mask =3D config->ctxid_mask0;
> -	for (i =3D 0; i < drvdata->numcidc; i++) {
> +	for (i =3D 0; i < caps->numcidc; i++) {
>  		/* mask value of corresponding ctxid comparator */
>  		maskbyte =3D mask & ETMv4_EVENT_MASK;
>  		/*
>  		 * each bit corresponds to a byte of respective ctxid comparator
>  		 * value register
>  		 */
>  		for (j =3D 0; j < 8; j++) {
>  			if (maskbyte & 1)
>  				config->ctxid_pid[i] &=3D ~(0xFFUL << (j * 8));

[Severity: Critical]
This is a pre-existing issue, but could this sysfs-triggered write also=20
overflow the ctxid_pid[] array?

In ctxid_masks_store(), caps->numcidc is used as the loop bound for updatin=
g=20
config->ctxid_pid[i], which is dimensioned by ETMv4_MAX_CTXID_CMP. Without=
=20
clamping the hardware-reported capability, writing to this sysfs node could=
=20
result in out-of-bounds memory accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-separate_e=
tm_cfg_v2-v10-0-1b715d95927a@arm.com?part=3D5
