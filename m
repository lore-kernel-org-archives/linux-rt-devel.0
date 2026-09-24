Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5353F6AF;
	Thu, 24 Sep 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271973; cv=none; b=cp0v/oDtbdoj1gFWLjg6IM5ekPCAe6OsqqbZ2nYjugkrOSsEyLKXxZCaDZhdWXvOMQb6Af0B6c5j+BceHjCrbkmkL2UXc4477s4KkZQWw0PAKiR2FNS2+x3b+W6IdNleG5yNkXDI4GHnIRpuBpqADfbSnht6JAxuyBMTDJme02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271973; c=relaxed/simple;
	bh=dmv/7C03BljaSagFnU0uHhye7fUWmKJXvCB2yVLpu/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqCLezqCARCTjuzIdEbQEzaWFdINCD+LWRHFFxCqJlcjWzicYxQB13sOBo6Q4F8408jtWsaOUotTm8l0GLSj/WgsGtffvfmaxUM9qk87M22A/dCdLhaEH3UVUovGzkAPE/K9iLX1ZjQt50h7paDfD8M4QlahZqh751Y86hZXJLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMEKR1SK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMEKR1SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917571F00893;
	Thu, 24 Sep 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271971;
	bh=bqbiuMLU9y7UrgBS5Nv/rDDBjPKYQMJhkZicLky4BVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMEKR1SKNbJnjVy8kB7ZLovSRhXK2QyfEbP4NOkgraYtv7Ww5q4o+7MLs3Y/G0yVN
	 DH63vEmFybbj7IFb29JgkEUiTWczGl1/LQX/+1RJk4ucBoqEYUOG0xgI9gjXzdpRrT
	 2X1jqTor6hhTJpQmAReiTFNh8UJPOSpYTX5g4Mldc4C3f0PiyC/Xj4PsvYk0XWA6Uh
	 5LKFX7nRiwdzD1yM17lIT2FU+gwrBOMQQuZTSC+xbQmONTGGB+XttKvAz/8TDil3hQ
	 mjrG5oxTjLwmljQRABaPR7tKBW2xZ77sVYIPpDE579mtxjn3a0uDY3FYEVdv3n0huM
	 3/vQoWUrr9adA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-1-a2b41d2f7c2b@arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-1-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:46:11 +0000
Message-Id: <20260924174611.917571F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race in seq_state_store lockless mode check
- [Low] coresight: misplaced IS_ERR_OR_NULL(drvdata) after dereference
--

commit fb240199cfa6db080873efbe2c007beb70c01070
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: read-back TRCSEQSTR at disabling and prohibit modifying s=
eq_state while enabling.

TRCSEQSTR can be changed by the ETM while a session is active. Its value
therefore needs to be preserved when a sysfs session is disabled so that
users can read the current sequence state after the session ends.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> index cc6cdd3ae29d5..db3cf4ad6806c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1437,6 +1437,8 @@ static ssize_t seq_state_store(struct device *dev,
>  		return -EINVAL;
>  	if (val >=3D drvdata->nrseqstate)
>  		return -EINVAL;
> +	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;

[Severity: Low]
Does this code introduce a regression by checking drvdata for NULL after it
has already been dereferenced?

Looking at seq_state_store(), drvdata is dereferenced during the check for
val >=3D drvdata->nrseqstate before IS_ERR_OR_NULL(drvdata) is called.

While drvdata is fundamentally guaranteed to be valid in this sysfs context,
making the check technically dead code rather than a reachable crash, should
the validation be moved before the dereference if it is kept?

> =20
>  	config->seq_state =3D val;

[Severity: Medium]
Could this lockless mode check cause a regression?

A concurrent thread could enable the trace session immediately after the
lockless coresight_get_mode() check evaluates to disabled. This would allow
config->seq_state to be modified while the session is actively starting or
already active, completely defeating the patch's stated goal of prohibiting
state modification during an active session.

Should raw_spin_lock(&drvdata->spinlock) be held across both the mode check
and the subsequent state update to prevent this regression?

>  	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-separate_e=
tm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com?part=3D1
