Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F6B3B442B;
	Tue, 15 Sep 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479746; cv=none; b=CgmfViIy3d5cePkssaSiqnO+bCZEH/uYKQMSpPeRP//JFb/DxDl5Z/4y5AItwz85TnEZ1fEXNbW+Ucc05eETOSET3hciKcXlAMxTzYaF29Mo49MtjrnEMDXOUvx5enxdtzOIYs8sne2fsMWBcWVkkMBiAmbUgwDJH8GdLgmC+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479746; c=relaxed/simple;
	bh=9YTsmmxojBKn5k9+traIkr0BS02IGwTO6X2F0Kl1kAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ese5yTSwHVL7rCtwoYHYtNcxETnSuK5axSmNUJVWh/ACpB8KHgeGWOUkaYerRqblz5pMKGgBrNp+4XleiowCD1DlLkCitJPtocy3syzOVR756tOKfRTq61Cyd6JP3/pmEgYiBk+ckZUZ9VpMtwE/sqvSXNsV9/4j1qeo44YM4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=norFOxFS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="norFOxFS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FCD15A1;
	Tue, 15 Sep 2026 06:42:20 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE6B33F7B4;
	Tue, 15 Sep 2026 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789479744; bh=9YTsmmxojBKn5k9+traIkr0BS02IGwTO6X2F0Kl1kAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=norFOxFSxTj6e9E4p/c/6D6b/qiIaMxqniJKmVM/jqdK4wLqhq+W9nk6dKDuaQX5p
	 LwBTDy2GIU2eV1szl7pKwdh12n8CXex3wqhc67fJTPl72E71/OGcJXqJP3jBN5v0Ku
	 n6yh9uWHnwMHKh8oQBestUkOR7ovyMUOwiQy9BPQ=
Date: Tue, 15 Sep 2026 14:42:21 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v11 4/9] coresight: etm3x: fix inconsistencies with sysfs
 configuration
Message-ID: <aqlLPUsSqpbSNf9A@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-4-d2b258d51747@arm.com>
 <20260915114757.8743B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915114757.8743B1F00893@smtp.kernel.org>

On Tue, Sep 15, 2026 at 11:47:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race in sysfs read paths exposes powered-down hardware
> - [Low] coresight: benign data race on config->cntr_idx in cntr_val_show
> --
> 
> commit 7fbfa36b293dee9eea85d0d29da9faaa208abb46
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm3x: fix inconsistencies with sysfs configuration
> 
> This commit splits the sysfs configuration into active and mode
> configurations to fix inconsistencies during active perf sessions. It also
> avoids locking around some sysfs paths and uses IPIs to read registers
> directly on the appropriate CPUs to reduce lock scopes.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > index 862ad0786699c..fd76a57e5f861 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> [ ... ]
> > @@ -630,8 +632,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
> >  static void etm_disable_sysfs(struct coresight_device *csdev)
> >  {
> >  	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > -
> > -	spin_lock(&drvdata->spinlock);
> > +	struct etm_config *config = &drvdata->config;
> > +	const struct etm_config *active_config = &drvdata->active_config;
> > +	int i;
> >  
> >  	/*
> >  	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
> > @@ -640,7 +643,14 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
> >  	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
> >  				 drvdata, 1);
> >  
> 
> [Severity: Medium]
> When thread A disables tracing via etm_disable_sysfs(), it sends an IPI to
> power down the hardware here. Could a concurrent reader (like Thread B in
> cntr_val_show()) see the mode still set to CS_MODE_SYSFS, and issue its own
> IPI to read the hardware? Since the hardware is already powered down by
> Thread A's IPI, Thread B might read a stale or garbage value instead of the
> correctly saved trace state, breaking post-trace analysis.

In that case, no IPI is shown, and the last Thread B see the
Thread A's saving value of cntr_vals where is saved in the config.

It doesn't break anything.

> 
> > -	spin_unlock(&drvdata->spinlock);
> > +	/*
> > +	 * Userspace may read seq_curr_state and cntr_val through sysfs
> > +	 * after the sysfs-session has been disabled.
> > +	 */
> > +	for (i = 0; i < drvdata->nr_cntr; i++)
> > +		config->cntr_val[i] = active_config->cntr_val[i];
> > +
> > +	config->seq_curr_state = active_config->seq_curr_state;
> >  
> >  	/*
> >  	 * we only release trace IDs when resetting sysfs.
> > @@ -649,6 +659,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
> >  	 * prior trace id allocation method
> >  	 */
> >  
> > +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> 
> [Severity: Medium]
> The software state is updated here, creating a race window between the
> hardware disable above and the mode update here where the hardware is off but
> the mode is still CS_MODE_SYSFS. A similar window exists during
> etm_enable_sysfs().

Non-sence.

> 
> > +
> >  	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
> >  }
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index d4846d6364945..2c8c129228589 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> [ ... ]
> > @@ -719,7 +752,9 @@ static DEVICE_ATTR_RW(cntr_rld_event);
> >  static ssize_t cntr_val_show(struct device *dev,
> >  			     struct device_attribute *attr, char *buf)
> >  {
> > +	int ret;
> >  	u32 val;
> > +	unsigned long val2;
> >  	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >  	struct etm_config *config = &drvdata->config;
> >  
> > @@ -728,7 +763,10 @@ static ssize_t cntr_val_show(struct device *dev,
> >  		val = config->cntr_val[config->cntr_idx];
> >  		spin_unlock(&drvdata->spinlock);
> >  	} else {
> > -		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> > +		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2);
> 
> [Severity: Low]
> Does reading config->cntr_idx without locking here create a data race? It
> appears it can race with concurrent updates in cntr_idx_store(). While this
> is likely benign since it is an 8-bit integer and bounded by
> cntr_idx_store(), preventing out-of-bounds access, could it still trigger
> sanitizer warnings when accessed by authorized users?
> 
> [Severity: Medium]
> This reader accesses the hardware assuming it is active, based on a lockless
> mode check in the if condition. If this races with etm_disable_sysfs()
> powering down the hardware before the mode is updated to CS_MODE_DISABLED,
> could this read return garbage values?
> 
> > +		if (ret)
> > +			return ret;
> > +		val = val2;
> >  	}
> >  
> >  	return sysfs_emit(buf, "%#x\n", val);

Ignorable.

-- 
Sincerely,
Yeoreum Yun
