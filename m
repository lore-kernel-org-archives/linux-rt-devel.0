Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46F377567;
	Sat,  3 Oct 2026 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991225; cv=none; b=P5wiDi2YwUgx+Vcet5te5M214rtRX1NtbbpuMEXJV4S5+F5osGo0/+k9py31XV1PHCF3/XRAPh+8TThiKEvfVVEyE7y3ysLdTNDbk9X9CdjLDRdVNwQiKGyjfDrvEIhVLMLToHYi+g8mXh6BwzL1Y7O4u7GmLm9kk0J47p2bnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991225; c=relaxed/simple;
	bh=SeyoBi0Z9pOjpjWu0V/otATUHMEXXuNOg0ZbCjx0kDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P+55FkPpPGm4pXxQ/ttkYMD1y55eFK46py8ReIaTfFRLB3tRlBGTHHUq8sARkWI1Tu5jBfTD3qgGFlcOowM/LqfnvLcJ/FljkcwW9+RiqUT9bIcQTnPxvoRSQr+bTOjfZiCQzXRWkvY181LGp4BjBv/WUAP9UTaM/8L1qzEAfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQMJ98uH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQMJ98uH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BF71F00893;
	Sat,  3 Oct 2026 01:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991224;
	bh=moMeKzWuOSbjB06jQNX43MiX9gA8SyuAclHRj0D1MPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQMJ98uHvfLdj+GnxxRAwLyXs79SX+/mKtt/70FWNBJ3eEWIrkEyOrxaG6CwGP0+W
	 p+Hbbyp6/ckN+4wPWF5AfnbnJLkjhFijFcQExDy8i3G/5Ox2ngFl9P2htI7ubxxbYF
	 TG+xKp95Jq2mGBI0JVUzqdpzBuLauM6LkcC50EjkbM8hLUwAoYynd46/LH1D4WI/9S
	 Jibho1Lhbql+cCUMLUDCDI6akb57SwAP6cWwBTzq1l8CX6YG5658EGzNQJhmUymstX
	 cZfHu/3ZnXCthK45L0eE+xXow6qCnwwy/paWsOFx7USQQhtd0pG/YQ+0QrsVQTmKhI
	 p1/YKrUpiIBxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/14] coresight: etm4x: exclude ss_status from
 drvdata->config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-8-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-8-fe429d8d96fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:43 +0000
Message-Id: <20261003013344.22BF71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: etm4x: state leakage of single-shot comparator status=
 in perf sessions
--

commit 3d98ebedda262d5221467f55a32e0267bdd2e584
Author: Yeoreum Yun <yeoreum.yun@arm.com>
coresight: etm4x: exclude ss_status from drvdata->config

This patch moves the single-shot comparator status (ss_status) from the
configuration structure to the driver data structure. It updates the usage
of ss_status to clear both TRCSSCSRn_STATUS and TRCSSCSRn_PENDING bits
before writing to the register.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> index 3900b96e9c7cc..4a8c1070bbcbb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c

[ ... ]

> @@ -572,11 +572,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drv=
data)
>  		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> =20
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		/* always clear status bit on restart if using single-shot */
> +		/* always clear status and pending bits on restart if using single-sho=
t */
>  		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> -			config->ss_status[i] &=3D ~TRCSSCSRn_STATUS;

[Severity: Medium]
Will this bypass the manual clearing of the TRCSSCSRn_STATUS and
TRCSSCSRn_PENDING bits during perf sessions?

Since enabling a perf session uses a zeroed configuration, config->ss_ctrl[=
i]
and config->ss_pe_cmp[i] will evaluate to false. Previously, this wasn't an
issue because the entire config structure was zeroed via memset. Now that
ss_status is moved to drvdata, bypassing this check means the bits are not
cleared.

> +			drvdata->ss_status[i] &=3D ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>  		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));

Does this write a stale, unmasked drvdata->ss_status[i] directly to the
TRCSSCSRn hardware register during perf sessions?

If the manual clearing above is skipped, this could cause state leakage and
trigger unintended hardware trace behavior.

>  		if (etm4x_sspcicrn_present(drvdata, i))
>  			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-separate_e=
tm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=3D8
