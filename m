Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E82D594F;
	Sat,  3 Oct 2026 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996801; cv=none; b=ZLamgHpbhLN9bNi+muBWDBkthxSTA0pa6uGsbC7Uq+GQOr5OjN8NXblLOD3vJlUsVl+inADs1ugtKzULeAtHCqZwiwoWz6DyqwLK6zqliqDcOrfqpnZM1ivnU5Xt2UWGGSRrwDONtBeUdNf4U1DMM1RTg649HnvnuJugeN7rcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996801; c=relaxed/simple;
	bh=hU8o/FeXrVEIZlWk2VBhIBS8J5716J397K+/oBejUSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qI19eA/g4GUAUz9UCSUVPrALOi+dc92Gep92qbXvo0CxDxrJR0aNb2qmXCkb6ERwFABrrNh1J3yCEh4SfhsmbY61cH3GNNAI7dLhXSHBCVgwRsMwHzoWIr8UVvbhyam7gBcnSY/B+O9Zkf874o6XEe54NCCYmt22TbtCOKTsj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHk6GVTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHk6GVTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3AA1F00893;
	Sat,  3 Oct 2026 03:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996800;
	bh=us7Jl8Q2OzMsQmd8Xicoyt8+fANB/Q1I7LzhZTTDRrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IHk6GVTrb//3X7rxaTJ4O2op5I/LPo9K8Lq4GZWj8B3EOhLTv34ZSPgrfmRHz8Xjh
	 xRc/86BjB1+fMQGn+TcouVZCPc5bpIfR92prJg4U5ZkWdb/bj8Qp/h/ePfL5yvXjcu
	 fMxUT4u/HyBe0eEvLVFfZhJnK4u2Hnye5pTgyE/mDQIAvwHENY0I6baKenuOZaUYnx
	 lox52ICSYCesgG9lHylT4kmWlPlb3YWBdCz/soiVfoqLxdA9kx7Ge61mHDDcRYfbT+
	 vg7JcN/A9B37A6EACWQiMw4GtGlMtlxZIgjeNi3ADJjs5RB6qiGs/XH4RvPgyxaVH9
	 wGpa29+BttAtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v13 02/14] coresight: etm4x: prohibit modifying
 cntr_val while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-2-5d8a29aead95@arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-2-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 03:06:39 +0000
Message-Id: <20261003030639.BB3AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race in cntr_val_store due to lockless mode ch=
eck
--

commit da77274417a7a9a1e577464873f49041c777a7fc
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: prohibit modifying cntr_val while session is enabled

This commit adds a check in cntr_val_store() to prevent modifying the
cntr_val configuration while a Coresight session is enabled. It returns
-EBUSY if the session is currently active.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1615,6 +1615,9 @@ static ssize_t cntr_val_store(struct device *dev,
>  		return -EINVAL;
>  	if (val > ETM_CNTR_MAX_VAL)
>  		return -EINVAL;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> =20
>  	raw_spin_lock(&drvdata->spinlock);

[Severity: Medium]
Could this leave a race window before the state is modified?

Since the mode check is performed locklessly before acquiring
drvdata->spinlock, another process could enable the session concurrently. If
the session is enabled right after this check evaluates to false, but before
cntr_val_store() acquires the lock, the configuration update would be lost.

The concurrent enablement would set the mode and call etm4_enable_sysfs()
to program the hardware. If cntr_val_store() acquires the lock after this,
it updates the software state which is never flushed to hardware for the
active session, and will eventually be overwritten by the old hardware state
during session teardown.

Should the mode check be moved inside the spinlock critical section to
properly serialize with session enablement?

>  	idx =3D config->cntr_idx;
>  	config->cntr_val[idx] =3D val;
>  	raw_spin_unlock(&drvdata->spinlock);
>  	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-separate_e=
tm_cfg_v2-v13-0-5d8a29aead95@arm.com?part=3D2
