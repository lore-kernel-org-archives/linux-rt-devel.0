Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849D360EF0;
	Fri,  2 Oct 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961360; cv=none; b=mEDxx/lry0h2FE0G8jn4MjNK6yzZmqp4INdOIwugDnQFK34YHK13kkHNpwUSoDTU+T3Bmh116iwoapXnDMDYSAfRkXDGbTbEqD8S+saLjjZOUvI+M4aC8eIoRi+XtweHdEA6KtQVPBqLfPY7zLkcDGFv5zSj9H4U9e4H5VkfU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961360; c=relaxed/simple;
	bh=ec85ORVem5py7VTjOncDrEpUpBZcjSUQaNl3sI9NJm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzILvl1twVhhOVpD2UDO2T2PEvs94/fYXLfLhOyohka8QW98Ps0QxzyD03OcQ6aCQHJ4OO06uZ1zPvAiViXdz7slBSk7T9z1gSH5RNXtkJ885sSpPz75IFx9ov6i+4ErSt2dY31uTioF7eP0B4N5tivH6fpCHz8t7glHxtixMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QFUlaY3S; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QFUlaY3S"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB7872F;
	Fri,  2 Oct 2026 10:15:45 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C963F85F;
	Fri,  2 Oct 2026 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790961349; bh=ec85ORVem5py7VTjOncDrEpUpBZcjSUQaNl3sI9NJm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFUlaY3SMkx5TGW8aUu4tUv35KxpJokLeVqIGAC5sh4cpYbmwiggbktuF7HH4NlJa
	 V5orCUD266hiIj1NYaXTiPLiQ0HfNd0kMNNqkx48cU5kkaVS3Z7Tz7AgULqH+POof+
	 Fbg4RGBvh6U1o5KFsezAhsKly8tYAjg39JhfZI5E=
Date: Fri, 2 Oct 2026 18:15:46 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 08/14] coresight: etm4x: exclude ss_status from
 drvdata->config
Message-ID: <ar_mwj_W0p6VjwIZ@e129823.arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-8-a2b41d2f7c2b@arm.com>
 <20260924182135.8286E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924182135.8286E1F000FF@smtp.kernel.org>

On Thu, Sep 24, 2026 at 06:21:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] coresight: etm4x: patch fails to preserve perf single-shot clearing behavior
> - [Medium] coresight: etm4x: data race on drvdata->ss_status during sysfs update
> --
> 
> commit 9755069e34bb3af0812d8f23f42579079827c7ca
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: exclude ss_status from drvdata->config
> 
> The patch moves ss_status out of drvdata->config and into drvdata directly.
> It aims to separate configuration from reset and restore states, while
> intentionally preserving existing single-shot clearing behavior.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> [ ... ]
> > @@ -572,11 +572,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> >  		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> >  
> >  	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		/* always clear status bit on restart if using single-shot */
> > +		/* always clear status and pending bits on restart if using single-shot */
> >  		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> > -			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
> > +			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> 
> [Severity: Medium]
> Is it safe to perform a lockless read-modify-write on drvdata->ss_status
> here? This can race with or interrupt sysfs stores.

As Mike said, the purpose of ss_status's writing is to clearing the bit.
So, It is ignorable.


> 
> >  		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> > -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> > +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
> 
> [Severity: Medium]
> Does this change preserve the previous behavior for perf sessions as
> intended?
> 
> When a perf session starts, the configuration is zero-initialized. Before
> this patch, the code skipped the bit clearing (since config->ss_ctrl[i]
> and ss_pe_cmp[i] were 0) but still wrote config->ss_status[i] to
> TRCSSCSRn(i). Because ss_status was zero-initialized, this wrote 0 and
> effectively cleared the bits.
> 
> Now, it writes drvdata->ss_status[i], which might retain previous hardware
> state (potentially 1s). Doesn't this leave the bits uncleared and alter the
> hardware state configuration instead of preserving it?

No, the matter for writing bit allow is for STATUS and PENDING bit.
other bits are for RO and RES fields. so it's not true.
> 
> >  		if (etm4x_sspcicrn_present(drvdata, i))
> >  			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
> >  	}
> [ ... ]
> > @@ -1078,7 +1078,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
> >  
> >  	/* read the status of the single shot comparators */
> >  	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		config->ss_status[i] =
> > +		drvdata->ss_status[i] =
> >  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> 
> [Severity: Medium]
> Can this lockless write in hardirq context race with the RMW sysfs stores,
> leading to torn updates on drvdata->ss_status?

This is the same for last comment. sysfs's clearing while session
disable (before sysfs return) is not expected. User should wait
the sysfs return for disable and this problem is ignored by former too.

> 
> >  	}
> >  
> [ ... ]
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> [ ... ]
> > @@ -1835,8 +1835,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
> >  	raw_spin_lock(&drvdata->spinlock);
> >  	idx = config->ss_idx;
> >  	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> > -	/* must clear bit 31 in related status register on programming */
> > -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> > +	/* must clear bit 31 and 30 in related status register on programming */
> > +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> 
> [Severity: Medium]
> Can this read-modify-write be interrupted by the hardware PMU path?
> 
> If a user writes to the sshot_ctrl or sshot_pe_ctrl sysfs node concurrently
> with a perf session stopping (e.g. during a task context switch),
> etm4_disable_hw() can trigger in interrupt context.
> 
> Because the sysfs path uses raw_spin_lock() rather than an IRQ-safe variant,
> the PMU interrupt can preempt this sequence. Won't this lead to lost updates
> or corrupted hardware status capability bits when the sysfs thread resumes?
> 
> >  	raw_spin_unlock(&drvdata->spinlock);
> >  	return size;
> >  }

that's why the curr_config and sysfs_config is separated. This is not
true.


-- 
Sincerely,
Yeoreum Yun
