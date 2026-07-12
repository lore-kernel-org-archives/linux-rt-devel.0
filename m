Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE022D792;
	Sun, 12 Jul 2026 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891041; cv=none; b=ToB1jxsoaxK2I3ADzwi29jppStI8U7rAi2MzSSzL+DnBHKUXkGvHcmO1z+wMRh+5XZCIefL5IOquX3L2DCApebf5rMFnkan3qVlDVv39OOR+LAY4T+kFGBqyFkcRcjvFjynyfMQhd7seZv9onjl8MmUpWNP8Qzqp2arNiiyuHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891041; c=relaxed/simple;
	bh=/6b2jTNQjZ/cc8Nv+AEt/GOccgx8Tui6Cw4/FX6wfGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M7uE5dW5TvU4gtyN9nHcRLvNaIDWp5X7J19MPb8ejA7dY8aOviQA+ldAgou5y1+Al22APmReaVvNGm6oOZzFQrBiHYKCHX1MqCyu5tKZWtdlFUhPhDs6D9vsZhayq2n4HGlqfOueSziUO5LFFFQtCtyFlNgtmDzK6J7gLdAJW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4h+JNb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4h+JNb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E9D1F00A3D;
	Sun, 12 Jul 2026 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891040;
	bh=8HS24st5/6ouw3RvThXAkuCmO7AQ6USBNd3I30PW+ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4h+JNb48H++uaAZaUVexsdiF86rSHGTJ3kyRUq82iOaSYYgOEH9Ey97zA8IZNMuN
	 q/Znl1gABmoxGEXSHrhVLWGZiNgufVDEdYawXyphz49i/86omsI8Pa0JBsRx1tuoUz
	 +dIpfA37rlovczFPNzHWCSWc7AT0m1KvIXNKdF+n7beVlj6ysCQCF4GoMafphzcQ0X
	 z5YqdM7swAQcvenmkKWftUTPLPXR7HuewQA9MlzGUObjoDMkN2mBDCa+EaFCFGHE/x
	 rSGIih9adYMwStICazhsNVMaML3vs3ayg9YhVaU0lcnp8KYenFXXUlljZ1Jm7EnZDy
	 uAm3AQHeZXWgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] coresight: Fix scheduling while atomic in
 coresight_device_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Ayman" <mohamedaymanworkspace@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 21:17:19 +0000
Message-Id: <20260712211719.E3E9D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Asynchronous device release via the global workqueue lacks module =
exit synchronization, leading to a Use-After-Free.

Pre-existing issues:
- [High] The patch commit message claims to remove a redundant raw_spinlock=
_irqsave guard, but fails to actually do so.
- [High] Deferring coresight_device_release does not make put_device() safe=
 to call from an atomic context.
--

--- Patch [1]: [PATCH] coresight: Fix scheduling while atomic in coresight_=
device_release() ---
commit c57af442711428cc5593c1e439fa97218ed23c0d
Author: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

coresight: Fix scheduling while atomic in coresight_device_release()

This patch attempts to fix a scheduling while atomic bug on PREEMPT_RT buil=
ds
by deferring coresight_device teardown to a workqueue. It also mentions
removing a redundant raw spinlock guard.

> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtra=
cing/coresight/coresight-core.c
> index 6d65c43d574fd..9dbdb29770260 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -165,13 +165,6 @@ void coresight_put_percpu_source_ref(struct coresigh=
t_device *csdev)
> =20
>  	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> =20
> -	/*
> -	 * TODO: coresight_device_release() is invoked to release resources when
> -	 * the device's refcount reaches zero. It then calls free_percpu(),
> -	 * which acquires pcpu_lock =E2=80=94 a sleepable lock when PREEMPT_RT =
is
> -	 * enabled. Since the raw spinlock coresight_dev_lock is held, this can
> -	 * lead to a potential "scheduling while atomic" issue.
> -	 */
>  	put_device(&csdev->dev);

[Severity: High]
This is a pre-existing issue, but the commit message states it will
"remove the redundant raw_spinlock_irqsave guard in
coresight_put_percpu_source_ref()". However, the diff only removes
the comment block.

Since the guard remains intact, won't put_device() still execute with
coresight_dev_lock held, continuing to trigger the atomic violation?

[Severity: High]
This is also a pre-existing issue, but is it safe to call put_device()
from an atomic context even if the release callback is deferred?

If this is the last reference to the parent device (such as an AMBA or
platform device), kobject_cleanup() can synchronously drop the parent
reference:

put_device()
  kobject_put()
    kobject_cleanup()
      kobject_put(parent)

If the parent's release function acquires sleepable locks, could this
still result in an atomic sleep bug? Would it be safer to defer the
put_device() call itself to process context?

>  }

[ ... ]

> +static void coresight_device_release_work(struct work_struct *work)
> +{
> +	struct coresight_device *csdev =3D
> +		container_of(work, struct coresight_device, free_work);
> +
> +	free_percpu(csdev->perf_sink_id_map.cpu_map);
> +	kfree(csdev);
> +}
> +
>  static void coresight_device_release(struct device *dev)
>  {
>  	struct coresight_device *csdev =3D to_coresight_device(dev);
> =20
>  	fwnode_handle_put(csdev->dev.fwnode);
> -	free_percpu(csdev->perf_sink_id_map.cpu_map);
> -	kfree(csdev);
> +
> +	/*
> +	 * This release callback can run with the last reference dropped
> +	 * from atomic/IRQs-off context (e.g. coresight_put_percpu_source_ref()
> +	 * called from the CPU_PM notifier). free_percpu() takes pcpu_lock,
> +	 * which is a sleeping lock under PREEMPT_RT, so defer the actual
> +	 * teardown to process context.
> +	 */
> +	INIT_WORK(&csdev->free_work, coresight_device_release_work);
> +	schedule_work(&csdev->free_work);

[Severity: High]
Could scheduling this work on the global system_percpu_wq lead to a
use-after-free during module unload?

If the coresight module is unloaded while there is pending release work,
coresight_exit() does not appear to flush this workqueue or wait for
pending tasks to complete.=20

If the module is unmapped before the asynchronous work executes, won't
the worker thread attempt to execute the unmapped=20
coresight_device_release_work() address?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712210446.1429=
0-1-mohamedaymanworkspace@gmail.com?part=3D1
