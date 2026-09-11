Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC0443C0B;
	Fri, 11 Sep 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125172; cv=none; b=fYsNzFL3pHax+Ma2jtYSzko6/akq64Xk2h73v1DgxBbVkzJPyA0XrgDGi0gv1vQHW8xO2TmRYWD+xt51pAqqoypz3KgCx5SnoFHELnKTWyycBoNjRMG3BKKOGjwdcgYc2MoGSjtmBL+Ys0Ij/EaiW9+oFo36SzQFUhINe5VD+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125172; c=relaxed/simple;
	bh=c2VdgDz4gG+3u6yKq16IcAV6P0easUQD3R6uIOQyBEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SeKf/jUwvui52ZQalW/RmqawVM4VyIbtEna2MZm1i+nZUzty3oCfu4ZUfdfjCZDD5gq68/5hrnDyzY8Kyi7N/JUGsPZU9lO7E2ZxiE5i0+gC3zXh52+XyJ7GMHiALDLEtsEBqlSqdpqg1RbGM5aOQyu7F9lWnECskPIDFy4AyrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOjtjQqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOjtjQqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5321F000FF;
	Fri, 11 Sep 2026 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125168;
	bh=EfQMPp0/X31NPvcoI08UbEJh7H/B/AHP6wlsiCmefKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOjtjQqYoK2XfSc70rgvymSd8vH3Wf6hHPDADKF+gcGfyL5oLJuNLQKisPUKbYW2n
	 ui0v+R77vmMylIm62eEfNK1ddnCKl0ImSFy3a/m/nRWYoglLKRUZKDbzMrMfOfnBFs
	 imUTxwOM82U4fA0hz/mp3HSqrprUy4/mpUFIhqAsB2y71PqvugtQTl/Yph2j6KEpkb
	 +KmeEOh/ikW/04x2MOVtui0R0J+1LEscfg+R1ddZCpCGWckYapoGnTOJb7gsCyBX5N
	 a4J3aAq08on7VGRr6HrUvTUanN6qqsUzkpc7MBvW566RKzjem85AVYDhAoJLXwVTjw
	 varKkg5nCM3Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/8] coresight: etm4x: exclude ss_status from
 drvdata->config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-6-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-6-1b715d95927a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:12:47 +0000
Message-Id: <20260911111248.0D5321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Data race on `drvdata->ss_status` between sysfs and concurrent t=
race sessions.

Pre-existing issues:
- [High] Pre-existing out-of-bounds array access due to missing hardware ca=
pability limits check for single-shot comparators and other resources.
- [High] Accessing trace registers after clearing the TRCPDCR_PU power-up b=
it.
--

commit 3c75fe92e961cdf21f5bd940d7b63e650ac76819
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: exclude ss_status from drvdata->config

The purpose of TRCSSCSRn register is to show status of the corresponding
Single-shot Comparator Control and input supports. This patch excludes
ss_status from drvdata->config and moves it directly into drvdata. It also
intentionally preserves existing behavior for single-shot events within the
same session.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> index 6d64a3fbdea4a..68aa99e8135d9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
[ ... ]
> @@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drv=
data)
>  		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> =20
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		/* always clear status bit on restart if using single-shot */
> +		/* always clear status and pending bits on restart if using single-sho=
t */
>  		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> -			config->ss_status[i] &=3D ~TRCSSCSRn_STATUS;
> +			drvdata->ss_status[i] &=3D ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);

[Severity: High]
This is a pre-existing issue, but does this loop in etm4_enable_hw() blindly
rely on the uncapped hardware count caps->nr_ss_cmp? If the hardware report=
s a
value larger than the statically sized array (8 elements), could this resul=
t in
an out-of-bounds access to the ss_status array in kernel memory?

[Severity: Medium]
Is there a potential data race here in etm4_enable_hw()? This patch moves
ss_status to the global drvdata structure, making it shared state. It appea=
rs
this modifies the array without acquiring drvdata->spinlock, which could ra=
ce
with concurrent sysfs operations like sshot_ctrl_store() modifying the same
array.

[ ... ]
> @@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *d=
rvdata)
> =20
>  	/* read the status of the single shot comparators */
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		config->ss_status[i] =3D
> +		drvdata->ss_status[i] =3D
>  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));

[Severity: Medium]
Does this overwrite the shared ss_status array from hardware in
etm4_disable_hw() without acquiring drvdata->spinlock? A concurrent sysfs
write could clobber these updates.

[Severity: High]
This isn't a bug introduced by this patch, but does this read a trace regis=
ter
at offset 0x2A0 after power removal has been requested? In etm4_disable_hw(=
),
the trace unit power-up request (TRCPDCR_PU) is cleared prior to this loop.

According to the architecture specification, software must not access any t=
race
registers outside the management registers after TRCPDCR.PU is cleared, whi=
ch
could lead to a system hang or unpredictable behavior.

[ ... ]
> @@ -1511,8 +1511,9 @@ static void etm4_init_arch_data(void *info)
>  	 */
>  	caps->nr_ss_cmp =3D FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		drvdata->config.ss_status[i] =3D
> -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +		drvdata->ss_status[i] =3D etm4x_relaxed_read32(csa, TRCSSCSRn(i));

[Severity: High]
This is a pre-existing issue, but does this initialization loop in
etm4_init_arch_data() blindly rely on the uncapped hardware count
caps->nr_ss_cmp? Because drvdata->ss_status is a statically sized 8-element
array, could an unusually large hardware value cause an out-of-bounds write
here?

[ ... ]
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 2d8a8f64a0386..ac290f446c51e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
[ ... ]
> @@ -1829,8 +1829,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>  	raw_spin_lock(&drvdata->spinlock);
>  	idx =3D config->ss_idx;
>  	config->ss_ctrl[idx] =3D FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &=3D ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &=3D ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);

[Severity: High]
This isn't a bug introduced by this patch, but does this write in
sshot_ctrl_store() use a potentially out-of-bounds idx to access the
undersized ss_ctrl and ss_status arrays?

Since user input for the index in sshot_idx_store() is bounded to the hardw=
are
capability count rather than the software array boundary, could an attacker
use sysfs to trigger an out-of-bounds write resulting in kernel memory
corruption?

[Severity: Medium]
While the spinlock is held here in sshot_ctrl_store(), does it adequately
protect drvdata->ss_status if concurrent trace sessions in etm4_enable_hw()
and etm4_disable_hw() modify this shared status array without acquiring the
lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-separate_e=
tm_cfg_v2-v10-0-1b715d95927a@arm.com?part=3D6
