Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E03769F6;
	Fri, 11 Sep 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124851; cv=none; b=E1YYwX337doLtTnuaB9IwM3QkEGT/AJIRcCovSlj7I8NTRKNlcdLJZy928w460UpCc/Yps4cND8ar/QqlrbSVesUidaJ54ePKaPBeLGpiM/oSg0xcTvSaSt/hfWtUMtmkRc3iF5VC9HzXOqulfmX3HLjP/YM0Qg+KTNKBzz2t0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124851; c=relaxed/simple;
	bh=NB+IopsnwJvA1G+gFLjVvjAktLAWVovWk5IV/0u8sBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E7X/Hl2toiLUHavPnaAi102k+8De41tejTcDt2PPmy3cPa5WHY6L8A+6lyU+A5AFCXz757X1Y4NJa49y8BEnG0UVpztxap5uNLUe1jyH5P5nraINkf9J4yHdlf6sOYN9rg5fCou4sTRnP6e7izgc7sHC4k+eeqjlx0chbuaiPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb4FqTi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb4FqTi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCCD1F000FF;
	Fri, 11 Sep 2026 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124850;
	bh=Hp2jcrAHQh/XhQOemNwRXVsyNhqy75DZ3Jd0KrPo11M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wb4FqTi88n/D5ekJxqf/7FHQVG8TwcW04EX5IQfSjEWJaXlskXVU7NFWBoO821g8e
	 z8xyc1UnR6LQa/bNSFweXjMbD36dXoUqG3XVJnc5vp8xXDiGIWTg1ghYohYLcf1Q21
	 EKObf4wBhLUi4m3OkX1VL1WCjkSeyCaGEW1LwRYy5TpgRMbcMpUdPoCdTtvCBpGXgq
	 5B2OmthClkySr4t23RYlkBmKI0QGc7+pxDgCUQnTShqElAz3BhxcfI7UPsiO5xjc8G
	 fOZya61F9m6fw2mS6Ttkn98/en+7o+MdP1oT7ZBAd/XsEUtN4xUD4Myjppqkko1scY
	 acHnZ3C2GTiiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/8] coresight: etm3x: fix inconsistencies with
 sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-2-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-2-1b715d95927a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:07:29 +0000
Message-Id: <20260911110729.EBCCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Sysfs interface for post-trace hardware state returns stale data d=
ue to active_config separation (ABI Breakage).
--

commit 729c4f4f776d1cbadf2571ee6a6363ece19f7a91
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: fix inconsistencies with sysfs configuration

This commit resolves sysfs configuration inconsistencies by separating the
configuration state into an active_config (for the current session) and con=
fig
(the configuration set via sysfs).

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers=
/hwtracing/coresight/coresight-etm3x-core.c
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c

[ ... ]

> @@ -565,7 +569,7 @@ static int etm_enable(struct coresight_device *csdev,=
 struct perf_event *event,
>  static void etm_disable_hw(struct etm_drvdata *drvdata)
>  {
>  	int i;
> -	struct etm_config *config =3D &drvdata->config;
> +	struct etm_config *config =3D &drvdata->active_config;
>  	struct coresight_device *csdev =3D drvdata->csdev;
> =20
>  	CS_UNLOCK(drvdata->csa.base);

[Severity: High]
Does this introduce a regression in the sysfs interface for post-trace
hardware state analysis?

By switching to active_config here, the post-trace sequencer and counter
states are saved into drvdata->active_config during etm_disable_hw():

drivers/hwtracing/coresight/coresight-etm3x-core.c:etm_disable_hw() {
	...
	/* Read back sequencer and counters for post trace analysis */
	config->seq_curr_state =3D (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);

	for (i =3D 0; i < caps->nr_cntr; i++)
		config->cntr_val[i] =3D etm_readl(drvdata, ETMCNTVRn(i));
	...
}

However, when tracing is disabled, userspace reads from the sysfs interface
which still returns data from the stale drvdata->config:

drivers/hwtracing/coresight/coresight-etm3x-sysfs.c:seq_curr_state_show() {
	...
	val =3D config->seq_curr_state;
	...
}

Will this cause sysfs reads for seq_curr_state and cntr_val to return
stale or zeroed data instead of the actual hardware state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-separate_e=
tm_cfg_v2-v10-0-1b715d95927a@arm.com?part=3D2
