Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54CA3BE643;
	Tue, 15 Sep 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475821; cv=none; b=XqKaf8K5gTo1aw5nmigdHUHldKsalLmWxUTc1zygi3JDbXvZd8vlZoOw7VJa/Te2lwmmRt89mRH81CwqGbNVMi1turTwc/ol1DvV/9UiC3EM1FaL7ASa3knTDhYEGzhswRNDzcf8GVX1rBCTGw3dxcUHxoZYzcW8vhw/OY0jUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475821; c=relaxed/simple;
	bh=2En1tkcYieizct0scFPBIPhCAsUypbyJIy3vv+9QV2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od8rCkmlk0NmqUuSaKJkAuaGEK1NFn2fNdYaqJPTmHarLm8msBg/1yPg27G2Wq9M2pTvxz0SBDq1U6mNIO7r+oRCLPHxTPP9+31Uw5vqOFJGgZoDW8kCDkJYuQWh0NE+MGSKIX/fFhP5hPV+GxXbNKIzOjQ4481e6O3Dxl8QwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IQ0+G0IW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IQ0+G0IW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9E615A1;
	Tue, 15 Sep 2026 05:36:55 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3DFC3F882;
	Tue, 15 Sep 2026 05:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789475819; bh=2En1tkcYieizct0scFPBIPhCAsUypbyJIy3vv+9QV2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ0+G0IWNjEDik9LAW6yU/PzXxWhLWi4zQUzXbcCK5XqLhj6lDWSM8hB6D0JiZ4bN
	 NU0gbK5cIj56bh1fYUXq+unggEHsax6mvWiBsP4lkdNjJlCPYvsERKqSSyjvhjWb7d
	 J+L0HwGTvJWX+OjlOMzkw+E9bwjE7AulN6u+vDM4=
Date: Tue, 15 Sep 2026 13:36:56 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/9] coresight: etm4x: fix inconsistencies with sysfs
 configuration
Message-ID: <aqk76O2J6Ni7prxW@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-3-d2b258d51747@arm.com>
 <20260915115334.49FB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915115334.49FB91F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 11:53:33AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] coresight: data race when updating cntr_val in etm4_disable_sysfs()
> - [Medium] coresight: feat_csdev_lock macro fails to disable IRQs when __lock is NULL
> --
> 
> commit 5571e5128409a42536b24f594b727e037107f3f4
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: fix inconsistencies with sysfs configuration
> 
> This commit separates the active configuration applied to the current session
> from the sysfs configuration to resolve inconsistencies. It applies configfs
> settings after taking the appropriate mode and removes the lock/unlock around
> sysfs enable/disable paths except when accessing config fields.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index 90fd937d3bd83..ae6295e308131 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> 
> [ ... ]
> 
> > @@ -259,4 +260,25 @@ void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev);
> >  /* reset a feature to default values */
> >  void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
> >  
> > +#define feat_csdev_lock(feat_csdev, flags)				\
> > +	do {								\
> > +		raw_spinlock_t *__lock = feat_csdev->drv_spinlock;	\
> > +		typecheck(unsigned long, flags);			\
> > +		if (__lock)						\
> > +			raw_spin_lock_irqsave(__lock, flags);		\
> > +	} while (0)
> > +
> > +#define feat_csdev_unlock(feat_csdev, flags)				\
> > +	do {								\
> > +		raw_spinlock_t *__lock = feat_csdev->drv_spinlock;	\
> > +		typecheck(unsigned long, flags);			\
> > +		if (__lock)						\
> > +			raw_spin_unlock_irqrestore(__lock, flags);	\
> > +	} while (0)
> 
> [Severity: Medium]
> Will these macros fail to disable IRQs when __lock is NULL?
> 
> The intent is to let cfg-configfs operate without grabbing the drv_spinlock
> when it is NULL. However, raw_spin_lock_irqsave() also saves and disables
> IRQs. If the lock is bypassed completely here, IRQs are left enabled.
> 
> Could this lead to reentrancy bugs or deadlocks if generic coresight configfs
> routines like cscfg_csdev_enable_active_config() are called from contexts
> where IRQs are enabled? Should there be a fallback like local_irq_save() when
> __lock is NULL to ensure the critical section remains protected from
> interrupts?

It was discussed with Leo but we couldn't find any issue for this.

> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 2247ad55d4442..2df7f592bb5cf 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> 
> [ ... ]
> 
> > @@ -1140,9 +1152,17 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
> >  	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
> >  				 drvdata, 1);
> >  
> > -	raw_spin_unlock(&drvdata->spinlock);
> > +	/*
> > +	 * Userspace may read ss_status and cntr_val through sysfs after
> > +	 * the sysfs-session has been disabled.
> > +	 */
> > +	for (i = 0; i < drvdata->nr_ss_cmp; i++)
> > +		config->ss_status[i] = active_config->ss_status[i];
> >  
> > -	cscfg_csdev_disable_active_config(csdev);
> > +	for (i = 0; i < drvdata->nr_cntr; i++)
> > +		config->cntr_val[i] = active_config->cntr_val[i];
> 
> [Severity: Medium]
> Does this create a data race with sysfs operations?
> 
> The etm4_disable_sysfs() function removes drvdata->spinlock but continues to
> copy active_config values into config->cntr_val locklessly.
> 
> Meanwhile, concurrent sysfs show and store functions access these fields under
> the spinlock:
> 
> cntr_val_store() {
>         ...
>         raw_spin_lock(&drvdata->spinlock);
>         idx = config->cntr_idx;
>         config->cntr_val[idx] = val;
>         raw_spin_unlock(&drvdata->spinlock);
>         ...
> }
> 
> If etm4_disable_sysfs() runs while another thread concurrently reads or
> writes cntr_val through sysfs, can it corrupt the configuration state?

The store is prohibited at when sysfs sessino is enabled.
So This is not true.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com?part=3

-- 
Sincerely,
Yeoreum Yun
