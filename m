Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD41399036;
	Thu, 16 Jul 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784239510; cv=none; b=JWI/VsgdDGW+ByKikbhjUz6DiuTlBTRTagTt+sK/OiyYsYhVzOxGHEZ8WCpz9/XVHLm9riydYbMwBApgGRxzCSPWQJItIqYvLXKvja1HYw0TyuPr0gd/v7gzFbHJTpS8eaBfWM1ZseRiLABLXjyjpGuHunkruMoe8jf9yZKrPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784239510; c=relaxed/simple;
	bh=mNX2JgMFhHkbvtRdTeXlNQ+vNeVP3SZ/f4IV89WyCDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OFlmlczrmPF0K7RM8+nh80upML7yMd6kncEWcyqdMtNuzW1f4EzuovFd83PZMKqXkrvBwDKV3ADAGnETPz7dYjQOSHXzN89AncufswrWUF8J+DMQHDY+83pC8tnnqqIhkQu+DtQbxWhXU3qQnKWVbImHyH0PwH5oCL9KpnVFtSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUQlujQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUQlujQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351B01F000E9;
	Thu, 16 Jul 2026 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784239509;
	bh=lADguX+dBlNKBLyBsaqNQCIBX+3p/iMhxBJddg7aHBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUQlujQSNbSaS6zHpSXd9AmKmS5tOi4IaLl9FuiuP0L5TnUit9wz+XeMCKWq63Cuk
	 nzUoLnkZz423GuOve+FS7G51qrz69LJuFytMam1sRcfsi8eOkgVKU5YIavpYeFPJBs
	 eXVNolKWhA/7WaFb9pw6wdPJronWl6JJDeffvHTYzX2SlWjrc22s0ZPLSN33cKyFAZ
	 CaRCuvCkf4tAsNeaCS+nJOhF8hBeS7w3s6CEXKlXgVXacUU6yIrDSjf5RBV+mJpbhM
	 shsW10UYqhcczB8kdD0/cWcVFfeNbxShATV0uBqPEm3ppgsoe0pdbn0XBynm7Y2UzX
	 y1VKcGr1886vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] coresight: Fix scheduling while atomic in
 coresight_cpu_pm_notify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Ayman" <mohamedaymanworkspace@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 22:05:08 +0000
Message-Id: <20260716220509.351B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling put_device() inside a raw spinlock atomic context in cores=
ight_put_percpu_source_ref() causes a system crash on PREEMPT_RT.
- [High] Double-decrement of hardware refcounts for links/sinks when a devi=
ce is unregistered while the CPU is idle.
--

--- Patch [1]: [PATCH v3] coresight: Fix scheduling while atomic in coresig=
ht_cpu_pm_notify() ---
commit cbdaaaf0779f6cae5c8595e4a2bcad24b819e017
Author: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

coresight: Fix scheduling while atomic in coresight_cpu_pm_notify()

This commit modifies coresight_cpu_get_active_path() to avoid calling
coresight_get_percpu_source_ref() and coresight_put_percpu_source_ref()
during CPU PM transitions. Instead, it reads the per-cpu source pointer
directly under the coresight_dev_lock raw spinlock to prevent potential
sleeping in atomic context on PREEMPT_RT.

> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtra=
cing/coresight/coresight-core.c
> index 6d65c43d574fd..713bcff53bf4f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1850,25 +1850,15 @@ static void coresight_release_device_list(void)
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
This isn't a bug introduced by this patch, but while this change fixes the
issue for the PM notifier by removing the get/put dance, does the same
"scheduling while atomic" problem still exist in
coresight_put_percpu_source_ref() for other callers?

In coresight_put_percpu_source_ref():

	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
	...
	put_device(&csdev->dev);

This unconditionally acquires coresight_dev_lock as a raw spinlock and calls
put_device(). If concurrent device unregistration occurs, this put_device()
call can drop the final kobject reference, triggering
coresight_device_release().

This calls free_percpu(), which acquires sleepable locks on PREEMPT_RT,
causing a panic. Are there plans to address this remaining put_device()
call under a raw spinlock?

> +	source =3D per_cpu(csdev_source, smp_processor_id());
> +	if (source && (coresight_get_mode(source) & mode))
> +		path =3D source->path;
> =20
> -	/*
> -	 * It is expected to run in atomic context or with the CPU lock held for
> -	 * sysfs mode, so it cannot be preempted to disable the path. Here
> -	 * returns the active path pointer without concern that its state may
> -	 * change. Since the build path has taken a reference on the component,
> -	 * the path can be safely used by the caller.
> -	 */
> -	return is_active ? source->path : NULL;
> +	return path;
>  }

[Severity: High]
This is a pre-existing issue, but does this PM logic cause a permanent
double-decrement of hardware refcounts if a trace device is unregistered
while the CPU is idle?

When the CPU goes idle, coresight_cpu_pm_notify() runs CPU_PM_ENTER and cal=
ls
coresight_pm_save(path). This disables components along the active trace pa=
th
and decrements their reference counts.

If the trace driver is concurrently unbound on another CPU,
coresight_unregister() clears the csdev_source per-CPU pointer.

When the idle CPU wakes up, coresight_cpu_pm_notify(CPU_PM_EXIT) calls
coresight_cpu_get_active_path(). Because the pointer was cleared, this
returns NULL.

Consequently, coresight_pm_restore() is skipped, and the hardware refcounts
are never incremented back:

	struct coresight_path *path =3D
		coresight_cpu_get_active_path(CS_MODE_SYSFS | CS_MODE_PERF);
	int ret;

	ret =3D coresight_pm_is_needed(path); // returns 0 if path is NULL
	if (ret <=3D 0)
		return ret ? NOTIFY_BAD : NOTIFY_DONE; // Skips restore

When the trace session is later explicitly closed, coresight_disable_path()
executes and decrements those refcounts again.

Does this cause an underflow that permanently disables shared hardware
components for all cores?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716214155.2049=
564-1-mohamedaymanworkspace@gmail.com?part=3D1
