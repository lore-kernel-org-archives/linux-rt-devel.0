Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC01BD9C9;
	Sat,  3 Oct 2026 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996893; cv=none; b=hJanAvweEqwZitxYmWOzvlpqtigLrLphtSFxucQgDrisxmpRa/fC6CHGix+/PmPjq5RCdHL9Zo7aWlIhw+rJKaUTgdYtUnFlqUTyLkkV5Gz2YkxCrq3iyvv4rFeJP2tSIs/+dk9U6apCtZah+uqgOjHDVXhQPH7nZqa16aPcY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996893; c=relaxed/simple;
	bh=rhSpvA5IPr44zHUXq/k9BiaSSGTiwCbq5aAn2Lelx1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=teYd37pFf2KZRez09X6gjWTy3WNVf/g8AhuosvVcveIK9J++12sFwF8xEh1VjLFc1fnxxckQG0wBoRObnZ3Aeb/bPd/WS4bTKxZvuf8vLXlW7YlHEasvFRgEX68ecPCDO8CcMbbG9TcchzssLaiPZp0hoLbis+aLvN1rQhPh6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4/10JHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4/10JHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35331F000FF;
	Sat,  3 Oct 2026 03:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996891;
	bh=b+g+O0PVrAFu2Jn2vfo6X+HGHfU6RM1j+Fvq4PM1eZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4/10JHlsJCXl7DOJ5H63foJ+AKDnsneiMo04LGtwcx14241bP8WkqcvfFQ2zDw4D
	 4hP5jT51Udn7/HRQJ0oiSfCHZ/wxdIkKbyT4sKS6rv8BYYYehVKc9C4yqsDdWdXWs2
	 6YunfZnBSVrb4+vYX0sTMRxPftNvfFp3+Jj2pmQ+2i1agax96ePmM4zQVmGbbEVVHz
	 Pm+rWWeRP/2aaGbgq1Jr5Tx5moiwkw9Y+eG9QtzzJBeB0dpWy9RYhgK1MM9g2BCCtH
	 +SS+3Jdui0mqf/MyD8GOUF2XUWUcqStqAEOb6qRo1e25VsOBtER21mdEErRkm8Q1Pz
	 q2vkXQI8VzHkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v13 01/14] coresight: etm4x: read-back TRCSEQSTR
 at disabling and prohibit modifying seq_state while enabling.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-1-5d8a29aead95@arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-1-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 03:08:11 +0000
Message-Id: <20261003030811.B35331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race in seq_state_store bypasses active-sessio=
n guard
--

commit 750a64ecfab03057a253043e06b3def402bb7137
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying s=
eq_state while enabling.

TRCSEQSTR can be changed by the ETM while a session is active. Its value
therefore needs to be preserved when a sysfs session is disabled so that
users can read the current sequence state after the session ends.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
> =20
>  	if (kstrtoul(buf, 16, &val))
>  		return -EINVAL;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) || coresight_get_mode(drvdata->csdev=
))
> +		return -EBUSY;
>  	if (val >=3D drvdata->nrseqstate)
>  		return -EINVAL;
> =20
>  	config->seq_state =3D val;
        ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Could this active-session guard be bypassed due to a Time-of-Check to
Time-of-Use race?

If a user-space write to seq_state and an enable_source call occur
concurrently, is it possible for enable_source to succeed immediately
after this mode check passes?

If coresight_take_mode() succeeds in the racing enable_source call, it
would take drvdata->spinlock to copy the configuration for the active
session. This seq_state_store() write would then proceed without a lock,
modifying the configuration after it was already checked.

When the sysfs session is later disabled, wouldn't the old state read
from hardware overwrite the user's new value?

Should raw_spin_lock(&drvdata->spinlock) be taken around this mode check
and the configuration assignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-separate_e=
tm_cfg_v2-v13-0-5d8a29aead95@arm.com?part=3D1
