Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF740B39C;
	Wed, 22 Jul 2026 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695505; cv=none; b=UrtM2VNFJG4ac+MoVXA/eys+0lVKG5N/gBnScxQS6IsuwduNZ1eoHZVz3jYxN2xE2/W5+vyDZXEXRKOW10gA7jqjBgHy4L8Qd9Zi2aa4ct4dqVydbg9esq74KCc/lWGkbJArtx4C+gimj3rPXqiWgoQJ6rPRpli2cCHrt+xvCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695505; c=relaxed/simple;
	bh=OIvU/SdC9UiA8d9JAIJ04kbcuozc93NtOD7eEDB1xVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hG8Dca3jDXi/BDwfXEza8+sgAwe3tq3vETnGecQtajmK95j2NQrxCCMyYcFb4KuLv/q2PDYMj+921PDGAzAjWIqgm4mtAA9Sz9bEN5eEqoBulobnm0UwCMyGZlwvmlOU8G7x40+uhhi5RB1Tfe9V18kWeQJrJVOSGBTbTUW96Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekDGHCiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekDGHCiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEF31F000E9;
	Wed, 22 Jul 2026 04:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784695504;
	bh=B2e2cik/Y33x910idZ3spODTF0Rr2Njbxf9CJjGqHNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ekDGHCiAQSXrX/4dk/xJLCAAJ6D/iACoBh4a2MlZvmLmIc8wVXWVXryUGbOIRLtZy
	 uu8KaKrFGQoZQGD7+dUCdtgi+aSwukAe+sQFw39c/g9QHmZvX5Os2hSW0GGuvDRM0l
	 X3mBdlUltv2VCnrtk4eRNHNLsdho55g7+fzfJ1y8yqkxMqvZpJaJC4PZn6qmoL9fzh
	 1/R/v2VqBrJsA8N8q7X8yBjPpqrKf1tA0T8UA2/HnxyJQgcj7qs3IcwRL5lLgfiXkg
	 CCV0tv2vjf6aU7Dp71aTpylfHWxscy6U4HY8nGcSFKkopRjBtGvsuTh7uX13b4CeUf
	 fEL34igJ1lq7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] coresight: Fix scheduling while atomic in
 coresight_cpu_pm_notify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Ayman" <mohamedaymanworkspace@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260722043023.6978-1-mohamedaymanworkspace@gmail.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260722043023.6978-1-mohamedaymanworkspace@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:45:03 +0000
Message-Id: <20260722044503.BCEF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The 'scheduling while atomic' bug remains unfixed in `coresight_pu=
t_percpu_source_ref()`, which can still trigger a system panic on PREEMPT_R=
T for other callers.
--

--- Patch [1]: [PATCH v4] coresight: Fix scheduling while atomic in coresig=
ht_cpu_pm_notify() ---
commit ced604f31de6d94adb2f729f01f491fe1766f6d1
Author: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

coresight: Fix scheduling while atomic in coresight_cpu_pm_notify()

This commit addresses a "scheduling while atomic" bug on PREEMPT_RT in the
PM notifier path. It removes the get/put kobject reference dance, and inste=
ad
reads the per-cpu source pointer directly under the coresight_dev_lock.

> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtra=
cing/coresight/coresight-core.c
> index 6d65c43d574fd..9461fac9f1a3d 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1850,16 +1850,13 @@ static void coresight_release_device_list(void)
>  static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode=
 mode)
>  {
>  	struct coresight_device *source;
> -	bool is_active =3D false;
> +	struct coresight_path *path =3D NULL;
> =20
> -	source =3D coresight_get_percpu_source_ref(smp_processor_id());
> -	if (!source)
> -		return NULL;
> -
> -	if (coresight_get_mode(source) & mode)
> -		is_active =3D true;
> +	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> =20
> -	coresight_put_percpu_source_ref(source);

[Severity: High]
This is a pre-existing issue, but while this patch avoids the bug in this
specific PM notifier path, does coresight_put_percpu_source_ref() still
contain the exact same "scheduling while atomic" vulnerability for other
callers?

Looking at coresight_put_percpu_source_ref() in
drivers/hwtracing/coresight/coresight-core.c:

    guard(raw_spinlock_irqsave)(&coresight_dev_lock);

    /*
     * TODO: coresight_device_release() is invoked to release resources when
     * the device's refcount reaches zero. It then calls free_percpu(),
     * which acquires pcpu_lock =E2=80=94 a sleepable lock when PREEMPT_RT =
is
     * enabled. Since the raw spinlock coresight_dev_lock is held, this can
     * lead to a potential "scheduling while atomic" issue.
     */
    put_device(&csdev->dev);

If put_device() drops the final reference concurrently with device
unregistration, it synchronously triggers the release function
coresight_device_release(). This cascade eventually calls free_percpu(),
which on PREEMPT_RT attempts to acquire the sleepable pcpu_lock.

Because coresight_put_percpu_source_ref() holds coresight_dev_lock (a raw
spinlock) via the guard during the put_device() call, could acquiring the
sleeping lock still cause a kernel panic if other callers hit this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722043023.6978=
-1-mohamedaymanworkspace@gmail.com?part=3D1
