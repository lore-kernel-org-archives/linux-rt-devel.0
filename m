Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355A435A8B;
	Fri, 11 Sep 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125468; cv=none; b=Ww9LZZXWmx5TVMHOGuqxTlUvqv286am4aeVrPIX2GhGztqAUyFU+SanUs+sv39/vkkrYocaN7mojKRnorjSZ4KQxODagahk64D19IdJ2Z2GPxdt2TPAOfDLtbhyK9LQdEZLXbNZkWrUljFg4DDBmAG/D8aIf4Uar3OZmhkhaOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125468; c=relaxed/simple;
	bh=POnShUs6XlJ9aFI4Ltfx5xi814FdeTic37YCGBgByeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LoOafbdARTNsCk/c965kwx10bBAO6XAlxUqIPfcObMxuGepgsAo/oAru0B14KYQpcKdVuflz9v0WVR17jbAmsv0lzY55yFZdimoCcuGM7+8tyjdQo11pLuv3jgJLZGRtP2u7/yedvim2cyZcXLeReR319QmbzZsOBUIOlssJkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9CSfLqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9CSfLqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA341F000FF;
	Fri, 11 Sep 2026 11:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125457;
	bh=O+HlISK15Z3GQgQDAzFaXu34aBMcWzGjWdr6eLyJosE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9CSfLqB+mxju02C7ZVaZD2UA91p7XbhAGE7S9YlAIaYqv2YARanBgzq5n05pQ8Gs
	 26TD0dHwaf80noxxUASEMc1f/s/lurdZEw6GaN8Dt+/DjlivFLUJ+AsDdQX1W4+erm
	 igmBSyOXqrN2x1HFttyIu8AEzOHxn0t44L1EcN8LRIxXIoqomrJVx65TEU/MkjO5vu
	 z0pgTsw7GX0lkwcphiSiqKXK0BpHeqScVjgLy3o4xmlrNfIYN2NDF9nHTNuN/EidCV
	 63Iu4hk3Qw8/z1q/g4hcI14u3s+zQRccUWu2gLA6Utq2Ac88rIugwgulaDvAGzePiX
	 AMVxzCBQdtpUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/8] coresight: etm3x: change drvdata->spinlock type
 to raw_spin_lock_t
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-3-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-3-1b715d95927a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:17:35 +0000
Message-Id: <20260911111736.EBA341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Unwarranted conversion to raw_spinlock_t degrades PREEMPT_RT lat=
ency based on a false premise.

Pre-existing issues:
- [High] Ignored return value from pm_runtime_get_sync() in sysfs handlers =
can lead to synchronous external aborts.
- [High] Concurrent sysfs read can lock CoreSight registers during hardware=
 enablement, causing silent configuration failures.
- [High] Trace ID use-after-free and stream corruption via sysfs reset whil=
e tracing.
- [High] TOCTOU race in `cntr_val_show` leads to reading from powered-off h=
ardware.
--

commit 7ed6c9cd3b008064253e2672ab61ffedfc528361
Author: Yeoreum Yun <yeoreum.yun@arm.com>
Date:   Fri Sep 11 10:56:02 2026 +0000

coresight: etm3x: change drvdata->spinlock type to raw_spin_lock_t

This commit converts the etm3x driver's spinlock to a raw_spinlock_t to
avoid issues with sleepable contexts in PREEMPT_RT. It updates the spinlock
initialization and all usages across the core and sysfs code.

> coresight: etm3x: change drvdata->spinlock type to raw_spin_lock_t
>=20
> etm_starting_cpu()/etm_dying_cpu() are called in not sleepable context.
> This poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

[Severity: Medium]
Does the etm3x driver actually use these hotplug callbacks?

The etm3x driver does not appear to implement etm_starting_cpu() or
etm_dying_cpu(). Its only CPU hotplug callback is etm_online_cpu, which is
registered at CPUHP_AP_ONLINE_DYN and runs in the sleepable cpuhp/%u kthrea=
d.

Since drvdata->spinlock is primarily used to protect sysfs configurations
that run in process context, converting to raw_spinlock_t forces sysfs
operations to run with preemption disabled. Can this degrade PREEMPT_RT
latency unnecessarily?

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm3x-sysfs.c
> index b3c67e96a82a4..0701edc094581 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -49,13 +49,13 @@ static ssize_t etmsr_show(struct device *dev,
>  	struct etm_drvdata *drvdata =3D dev_get_drvdata(dev->parent);
> =20
>  	pm_runtime_get_sync(dev->parent);
> -	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>  	CS_UNLOCK(drvdata->csa.base);
> =20
>  	val =3D etm_readl(drvdata, ETMSR);

[Severity: High]
This is a pre-existing issue, but could this code cause a synchronous
external abort if the device fails to resume?

If pm_runtime_get_sync() returns a negative error code (e.g., if the device
is suspended and its clocks or power domains remain gated), the code procee=
ds
unconditionally to dereference drvdata->csa.base in etm_readl().=20

Accessing unclocked or unpowered CoreSight registers on ARM can result in a
kernel panic. Should the return value of pm_runtime_get_sync() be checked
before accessing the hardware?

[Severity: High]
This is another pre-existing issue, but can this sysfs read silently break
concurrent hardware enablement?

Concurrent sysfs readers like etmsr_show() use drvdata->spinlock to seriali=
ze
their own hardware accesses, issuing CS_UNLOCK and CS_LOCK. However,
etm_enable_hw() executes via smp_call_function_single() and does not hold
drvdata->spinlock while issuing its own register writes and CS_LOCK.

If a sysfs read occurs concurrently with etm_enable_hw():

Sysfs thread                           etm_enable_hw()
etmsr_show()
  raw_spin_lock_irqsave()
  CS_UNLOCK()
                                       CS_UNLOCK()
                                       write to registers...
  CS_LOCK()                           =20
                                       write to more registers... (ignored)
                                       CS_LOCK()

Will the sysfs read's CS_LOCK lock the CoreSight Lock Access Register (LAR)
in the middle of etm_enable_hw()'s configuration sequence, causing
subsequent register writes in etm_enable_hw() to be silently ignored?

[ ... ]

> @@ -76,7 +76,7 @@ static ssize_t reset_store(struct device *dev,
>  		return ret;
> =20
>  	if (val) {
> -		spin_lock(&drvdata->spinlock);
> +		raw_spin_lock(&drvdata->spinlock);
>  		memset(config, 0, sizeof(struct etm_config));
>  		config->mode =3D ETM_MODE_EXCLUDE;
>  		config->trigger_event =3D ETM_DEFAULT_EVENT_VAL;
> @@ -86,7 +86,7 @@ static ssize_t reset_store(struct device *dev,
> =20
>  		etm_set_default(config);
>  		etm_release_trace_id(drvdata);
> -		spin_unlock(&drvdata->spinlock);
> +		raw_spin_unlock(&drvdata->spinlock);

[Severity: High]
This isn't a bug introduced by this patch, but can this cause a trace ID
use-after-free and corrupt the trace stream?

This resets the staging configuration and unconditionally calls
etm_release_trace_id() without checking if the tracer is currently active
(e.g., via coresight_get_mode()).=20

If writing to this reset attribute happens while a tracing session is runni=
ng,
the trace ID is returned to the pool and can be reallocated to another
CoreSight component while this device continues to emit hardware packets us=
ing
the freed ID.

[ ... ]

> @@ -722,9 +722,9 @@ static ssize_t cntr_val_show(struct device *dev,
>  	struct etm_config *config =3D &drvdata->config;
> =20
>  	if (!coresight_get_mode(drvdata->csdev)) {
> -		spin_lock(&drvdata->spinlock);
> +		raw_spin_lock(&drvdata->spinlock);
>  		val =3D config->cntr_val[config->cntr_idx];
> -		spin_unlock(&drvdata->spinlock);
> +		raw_spin_unlock(&drvdata->spinlock);
>  	} else {
>  		val =3D etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));

[Severity: High]
This is a pre-existing issue, but can this race with a concurrent power down
and cause a synchronous external abort?

The check for coresight_get_mode() bypasses both the spinlock and
pm_runtime_get_sync(). If the device is active during the check, it jumps
to the else branch to read the hardware register.=20

If another thread disables the device (which calls pm_runtime_put() and
powers down the hardware) concurrently, this will read from powered-off
hardware.

Additionally, is it safe to read config->cntr_idx here without a lock?

[ ... ]

> @@ -940,13 +940,13 @@ static ssize_t seq_curr_state_show(struct device *d=
ev,
>  	}
> =20
>  	pm_runtime_get_sync(dev->parent);
> -	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
> =20
>  	CS_UNLOCK(drvdata->csa.base);
>  	val =3D (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);

[Severity: High]
This is a pre-existing issue, but as with etmsr_show() earlier, could this
cause a synchronous external abort if the device fails to resume?

If pm_runtime_get_sync() returns a negative error, accessing the unclocked
hardware register will cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-separate_e=
tm_cfg_v2-v10-0-1b715d95927a@arm.com?part=3D3
