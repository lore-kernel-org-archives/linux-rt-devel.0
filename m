Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20E38236F;
	Tue,  1 Sep 2026 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302556; cv=none; b=vDzsJt/MSl/K3dmHT+//ADZk2EML/gcWRtI9wFdlGyiHM65Jj/Jjw+1Tk7OYaV6K0mJ8XX6zjBSLqt/hCYybvWMZKmZPfm8x+r0Nr64UIe43ng1aOe1MD40wj7S+osk5dGkBLg6eKOh1ueZW05cHobVKWldFO5Esd+Y9tuiz2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302556; c=relaxed/simple;
	bh=4Gu+GxXbnszRxwsBDA1ayJASorMO+ed6C1C+IdfeYgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMbU/kUoodrkdvrMaYzxWQZTDQEo/WzJuBa4usuKtZTVkUWyLweMVnt1osRXGq5mBandg/fX2xd3QOl+iroFydgjIldVacxaopzs3CZvQFx5Ocr+8NS/ljnuZJfjdLeG8RxGMZ2zDT+9kYZtiNNpIdn+8sYl+Mvt+vVx3fgFjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXaKfB3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXaKfB3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFDD1F000E9;
	Tue,  1 Sep 2026 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788302555;
	bh=vWFDR7WSW59o0OW9OfXOYZYDWXxKOFzNEPKaZ+It97U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXaKfB3nyLaBKttLRm2a5mdveQYw4vQs9Zm535NQ8MeLW5CHYm2WPBmHugsHUHWAt
	 UNE/ZM45R/671wO/zfVbk1bkw7kY0PojDInXM8nt3oa/4lgKux1N4wICe7qaPNZcxy
	 BnnFeegwS3qctNxOUYpHTCARqZM0WVWqLUWCjiKZNxxrCWfRa8zUudOiNMpqywizvp
	 T3boi910149ypbSUGeQAnp1nCcsvm4Ob19NDyVyS6LSx/XcqVJR1FGMFJKVymN8RWs
	 qqwv1utWRBm7lDn49rbOr5mau965k6DZk6VnRMDzXn07OSddj0B0UShuQ/n0hIFWt6
	 rDF9eFTKL0YOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] riscv_cbqri: Add capacity controller probe and
 allocation device ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260901-dfustini-atl-sc-cbqri-dt-v7-1-ca2935d85622@kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-1-ca2935d85622@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 22:42:34 +0000
Message-Id: <20260901224234.DAFDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardware race condition: writing staging registers before verify=
ing BUSY =3D=3D 0
--

commit e6f3519d6bbd7a39edfda72f253929a5410c1ed9
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add capacity controller probe and allocation device ops

This commit adds support for the RISC-V CBQRI capacity controller. It provi=
des
a platform driver that probes the controller and registers allocation devic=
e ops
with the resctrl filesystem.

> diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devi=
ces.c
> new file mode 100644
> index 0000000000000..e93261dfa4fa9
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_devices.c
[ ... ]
> +int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +			     const struct cbqri_cc_config *cfg)
> +{
> +	bool need_at_mirror;
> +	u64 saved_cbm =3D 0;
> +	int err =3D 0;
> +	u64 reg;
> +
> +	mutex_lock(&ctrl->lock);
> +
> +	need_at_mirror =3D ctrl->cc.supports_alloc_at_code && !cfg->cdp_enabled;
> +
> +	/*
> +	 * Capture the cfg->at half CBM before any write so a partial
> +	 * AT-mirror failure can revert and keep the two halves consistent.
> +	 * Pre-clear cc_block_mask so a silent firmware no-op (status
> +	 * SUCCESS but staging not updated) shows as a zero readback
> +	 * rather than carrying stale data from a prior op.
> +	 */
> +	if (need_at_mirror) {
> +		cbqri_set_cbm(ctrl, 0);
> +		err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
> +					closid, cfg->at);

[Severity: Medium]
Does this overwrite the cc_block_mask staging register before verifying the
hardware is idle?

If a previous operation timed out but the controller is still actively
processing it, modifying the CBM register here before cbqri_cc_alloc_op()
checks the BUSY flag could corrupt the in-flight operation.

> +		if (err < 0)
> +			goto out;
> +		saved_cbm =3D cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +	}
> +
> +	/* Set capacity block mask (cc_block_mask) */
> +	cbqri_set_cbm(ctrl, cfg->cbm);
> +	cbqri_clear_cunits(ctrl);
> +
> +	/* Capacity config limit operation for the AT half implied by cfg->at */
> +	err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT,
> +				closid, cfg->at);

[Severity: Medium]
Similarly, does this overwrite both the CBM and CUNITS staging registers
before verifying the hardware has finished any previous operations?

cbqri_cc_alloc_op() waits for BUSY =3D=3D 0, but this happens after these
staging registers have already been written. If a previous caller's
operation timed out and the hardware is still busy, could this cause
the new operation to use corrupted staging data or disrupt the pending
operation?

> +	if (err < 0)
> +		goto out;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dfustini-a=
tl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org?part=3D1
