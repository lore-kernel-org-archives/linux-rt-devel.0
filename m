Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008237E2E2;
	Sat,  3 Oct 2026 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991227; cv=none; b=cQhEGIzQ3wdjO4c+2uYD2XN/66PeCtRgzMs1AxhDtKheoUKJC8tqzQLLEuHkE4LaT5csWBHavWi4m7MIZWPSJREf1QomlQfX2I4tzHChdSzyJj4aDbtjyYEz0AZxPKGYmN1FPiHhASjbtduZ55TqOjH0Ms1XSRroHDeXmi5U93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991227; c=relaxed/simple;
	bh=ooddlcuKch0mPWKNAd6fwoOdX17gNXa3exd2YOwCeX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CRrT4pwX1IGIO3IDzHWVv1+n5whJ9LmPxvOZ1lrFQxSOfx5E1OeTuaY+cuZjpcgInSRTsoz4+XuqPO0/dXGi0hyuE9hxsgf4xPZdg3qBGUwbLEsp/Srm7ZcKtT+uQ3HYqUuJwyZKdsqs0YEPoGLmQeMIZpoRSb6qjOYwjJfKPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZWrp4/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZWrp4/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB71F000FF;
	Sat,  3 Oct 2026 01:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991225;
	bh=qQTH7Jjoipp1TE4xPgERjjkTA3ouUIxwXgceu0tjyHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZWrp4/e1yPZH3NtkV+c79V/QcHB+M60Ok1yuaO8grUdJKj5w66H2JolELqBYqgWJ
	 DdEVzwuFpdWg5vg55abumkdI1zDc+zSW5ZjoVAbnwDcLCDpjRWu2/xtHWxD9ksLbAe
	 8d5tqOFjfqDTfqIOTS9rBtcXI/otbqe+Kd/KvU4mfeebRFZG44UhNwLpJCWuCsjW5v
	 hpZtRDxyt/7b7PEdfyrlmSjFSsj5RTTVnHtYLOwFkPjVliGRPeMfTfpQ5Kvf14hZI9
	 g8mIdv0ABwt7HlzR1yKBCKyLgb81EZduHkeI7ThNldlz68Dv757yPcVqmF2PwEfWjw
	 w3zNLw1Rj14aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-1-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-1-fe429d8d96fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:45 +0000
Message-Id: <20261003013345.9CAB71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] null-deref: NULL pointer dereference in seq_state_store() during p=
robe
- [Medium] race: TOCTOU race in seq_state_store() due to missing spinlock
--

commit be18b7cdd3b23e4d67d68cc4591ca50a52fb8ee1
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying s=
eq_state while enabling.

This commit copies the TRCSEQSTR value when disabling a sysfs session. It a=
lso
prohibits modifying seq_state while the sysfs session is active to prevent
those changes from being lost when the session is disabled.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> index cc6cdd3ae29d5..2c72ea831fe65 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
> =20
>  	if (kstrtoul(buf, 16, &val))
>  		return -EINVAL;
> +	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))

[Severity: High]
Is there a risk of a NULL pointer dereference on drvdata->csdev during devi=
ce
probe?

coresight_register() exposes sysfs files via device_register() before
returning the csdev pointer to etm4_probe(). If a user process accesses
the seq_state sysfs file during this window, drvdata->csdev will still
be NULL.

Because IS_ERR_OR_NULL(drvdata) does not check drvdata->csdev, calling
coresight_get_mode(drvdata->csdev) may dereference a NULL pointer.

> +		return -EBUSY;
>  	if (val >=3D drvdata->nrseqstate)
>  		return -EINVAL;
> =20
>  	config->seq_state =3D val;

[Severity: Medium]
Could this assignment result in a TOCTOU race condition?

The mode check and assignment are performed without taking drvdata->spinloc=
k.
If a user writes to the seq_state sysfs file while another thread
simultaneously enables the trace session, the lockless assignment could
overwrite the state even if the session becomes active.

Other store functions in this driver correctly use
raw_spin_lock(&drvdata->spinlock) when modifying configuration state.

>  	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-separate_e=
tm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=3D1
