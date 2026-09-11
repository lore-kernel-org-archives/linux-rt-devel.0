Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E1457E40;
	Fri, 11 Sep 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125709; cv=none; b=F66wdySXPF0lfWpT6aNBL+MknD3s2dQXXv9rwfOYbaQ4SNRn7SVheG2J8iPLQkYvE0TgP5kx7pCU5z1EvhiA7uK06pHLyJ+O6V4Aqpp9EhQ9gOY45VDQoYVmt6E7Z2Eigs8dFPv3+dceu8cGQfN39nIS9Vblx+TOsAAfkjrqfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125709; c=relaxed/simple;
	bh=U0uqeX8zjZmm8OzGTnuvDazj/KS2QfPD4Kczm2VS9r4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KNQ0NqgylGzJEJgCFGho68SNVZNTAK/CSvbOuVJuI+yvDGalxRBe7v9iIIerJ8VXXtHHv25ix1Z5eoGXrZCJH4kbQZayIQ2SncVKpjedbbwhJesTE6Y0IeLlb4me8+iM2ntHzKh1vCrTSgRiEeqsFQUjiDfClGFIMS6KeXO5zkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp/dgcvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp/dgcvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC3F1F000FF;
	Fri, 11 Sep 2026 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125704;
	bh=FUuyIOdaCSVB6Q6+FnhJHrufYlYSxc7UyO1FDKD9AZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dp/dgcvDjj2QoA8u0Xw9JksvXFc4MZaOLt8IEHm3UKMOaVghAeam9xy+uEvmlHyGH
	 ixk/y3kHgbPAosqtBH9kKVafY2g13PumL645/utBz2tbMpIJNymEopH5S5nuFVxgIl
	 STeN2raw8cA82GFCgUaWET8JMfWT+0k52d2d5vZ3FoG6BDi8tEHwmbE8O3Bi3++OrJ
	 t3fR3e3mNAwRFOTbvkXKPXscVZiPVBhPL1kPye/9/e+OqtZ1b++wvdWZbCz2t4xpDU
	 F2xFoRTq2OLv/RDFRjCMid5Hrxk/nSL2TguK0OkEKAeBYaJq0ifnalFU9RYlpaWfxY
	 xGuO53YBicEvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/8] coresight: etm4x: fix inconsistencies with
 sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-1-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-1-1b715d95927a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:21:44 +0000
Message-Id: <20260911112144.8EC3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware counter values (`cntr_val`) read back during trace disabl=
e are saved to the temporary runtime `active_config` instead of the sysfs-v=
isible `config` structure, permanently losing the post-session hardware sta=
te.
--

commit 293039b149bb540c924b83cd181604cbff99de4c
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: fix inconsistencies with sysfs configuration

This commit addresses inconsistencies in ETM4x sysfs configuration by
separating the configuration into an active_config for the current session
and a config for sysfs. It updates the enable/disable paths to use the
active session configuration to prevent corruption from concurrent access.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c

[ ... ]

> @@ -1044,7 +1054,7 @@ static void etm4_disable_trace_unit(struct etmv4_dr=
vdata *drvdata)
>  static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	u32 control;
> -	struct etmv4_config *config =3D &drvdata->config;
> +	struct etmv4_config *config =3D &drvdata->active_config;
>  	struct coresight_device *csdev =3D drvdata->csdev;
>  	struct csdev_access *csa =3D &csdev->access;
>  	int i;

[Severity: High]
Does this change cause the post-session hardware counter values to be lost?

Later in etm4_disable_hw(), the hardware counter values are read back from
the device:

	/* read back the current counter values */
	for (i =3D 0; i < caps->nr_cntr; i++) {
		config->cntr_val[i] =3D
			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
	}

Because config now points to drvdata->active_config, the updated counter
values are saved to the temporary active session configuration instead of
the primary sysfs configuration.

When a user subsequently reads the counter value via the sysfs interface
in cntr_val_show():

	struct etmv4_config *config =3D &drvdata->config;
	...
	val =3D config->cntr_val[idx];

they will read from the static drvdata->config, which never receives these
read-back values and will instead return the initial configuration value.
Should the read-back hardware state be synchronized back to drvdata->config
when the trace is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-separate_e=
tm_cfg_v2-v10-0-1b715d95927a@arm.com?part=3D1
