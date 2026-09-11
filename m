Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69F26ED40;
	Fri, 11 Sep 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125651; cv=none; b=gv+xLL/+97XdQJPQVWQ0sFZo2mJKRC8Bk76LXz3KQYoZJwrEUhER+yQE9X+Ag6+AuLSw4Htugzx7yxYKJud3iS8uA0YrrqGo4LkNbvyzksIAK/0c08EaQ9996J0d7s/zK93jbqfLDnX3Z5tzmOjoRTHVQJ1gCBPgaeDS3TdOVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125651; c=relaxed/simple;
	bh=icIONMInXrL/p90Pj9NLJHS15BrvyMWt/kQ6lVZ+gyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJP1pfvoFbUwJ3dHEivFwz4JVUyQbjrda/Qbcb7TrB7GUBFP9mzJfxIZvFHts68wiHyVR8bjHE2bdtL89aqaG0Y0ryvZ0sii+NIFLfrj4uqCiEiL7XQF2a+ZqwaOJyXdE7c2ENUsYyMJtlmBw9RM+jMAv2Juj0aBKCzY0Dfi4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLakOJpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLakOJpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1AD1F000FF;
	Fri, 11 Sep 2026 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125649;
	bh=kLuPFk82kf4VOfdjuo9sUsImXN4bylmeBB661Hgy+9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLakOJptqfvBPnt6JyFh6vFyjPoNSRdHesSXRfQNLPafl59XwV6Yshi9i7UOsCIhx
	 oW3B5bzdmWjVlbW/CUNCODtE8mY2vJ53ShdtalVfIRQEq91dalJbmlcWczjcq3nHrc
	 18L+Jw8N6ICO+sLNBu+evvpnYKYkicUZA1HTuxUfxz+WtsVQgg918D3IxdvtOJJGVA
	 bqbUwBqKc0AuyDPtSuPve94vv2a7G0bFRg/BXGZaqcwKvwyhlgPjPfg5V/5h1Iswq5
	 Z/rwteNUr2p0dh4wsqeRXo93xPqAsNrdxjd67BvWBiVsEernESgVAEvJyJ54gV2gTq
	 foslTcWt0aG4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/8] coresight: etm3x: introduce struct etm_caps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-8-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-8-1b715d95927a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:20:48 +0000
Message-Id: <20260911112048.CA1AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The local variable `caps` in `cntr_val_show()` is declared and init=
ialized but never used, leading to a compiler warning.
--

commit 95d091834d6fbb955b9c3143fee9373f3398b6c9
Author: Yeoreum Yun <yeoreum.yun@arm.com>

    coresight: etm3x: introduce struct etm_caps
   =20
    Introduce struct etm_caps to describe ETMv3 capabilities
    and move capabilities information into it.

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 0701edc094581..6c911b8c1be96 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
[ ... ]
> @@ -719,6 +724,7 @@ static ssize_t cntr_val_show(struct device *dev,
>  {
>  	u32 val;
>  	struct etm_drvdata *drvdata =3D dev_get_drvdata(dev->parent);
> +	const struct etm_caps *caps =3D &drvdata->caps;

[Severity: Low]
Is this caps variable necessary? It appears to be declared and initialized
but never used in cntr_val_show(), which might cause a compiler warning.

>  	struct etm_config *config =3D &drvdata->config;
> =20
>  	if (!coresight_get_mode(drvdata->csdev)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-separate_e=
tm_cfg_v2-v10-0-1b715d95927a@arm.com?part=3D8
