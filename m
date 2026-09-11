Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84543DEB3;
	Fri, 11 Sep 2026 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127529; cv=none; b=Yv7L29TESoP0wOC+Grmrb9RuRlPMRfAtoi1iyA655nToqsYo3/Kd7MJPagWJ6fnCXP1fyfnMtlDVOnJp6/V2S2VCS33D7J9Lw0QZTOc7RXNCFBx+BoCiQ3dw8QL8ga6sDWGB88A+XqPpWuY0h1I69ye42b4bvu2Z99cL6KHe64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127529; c=relaxed/simple;
	bh=HOs3irXqb78xMsUCXOb+Jgwn/pSJ8kPNLFdAknY9XQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMa8AKej/LYKO42rzXadMOXlhQYWWGXCX0nB/1MeYkMVG/duV2HtjI+LhVzyAFIk6vKSy8ubpq0k8vc/d9iMU/2VcCOXLqUV8oifwQW/IdBJ6VxhTd7p5Uymj/197G8DPmtTtmkHOVdJg46y0GQuS7/3R23OsIPfK4TDhko+/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sjW+52QV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sjW+52QV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E6641655;
	Fri, 11 Sep 2026 04:52:04 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D685B3F59E;
	Fri, 11 Sep 2026 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789127527; bh=HOs3irXqb78xMsUCXOb+Jgwn/pSJ8kPNLFdAknY9XQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjW+52QVTXOMCnmIOdpLQ+qEh0XqmSr9ZaI0CW6Fzz4FX5nFjScnUUQ1M5cswByK0
	 YDtaKqlrCHxuvk5zFLmZWP6Tkl8LBIDUrflIPil6zWq2nX1Qy+AoEUyDs0Qw0tm9Qk
	 XhHvWvXO6Fkb1Qr2Rt1+G7SBHrGT8KKoZ9q/vDYE=
Date: Fri, 11 Sep 2026 12:52:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/8] coresight: etm3x: change drvdata->spinlock type
 to raw_spin_lock_t
Message-ID: <aqPrZD-NLo7gZr55@e129823.arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-3-1b715d95927a@arm.com>
 <20260911111736.EBA341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911111736.EBA341F000FF@smtp.kernel.org>

[...]

> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index b3c67e96a82a4..0701edc094581 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > @@ -49,13 +49,13 @@ static ssize_t etmsr_show(struct device *dev,
> >  	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >  
> >  	pm_runtime_get_sync(dev->parent);
> > -	spin_lock_irqsave(&drvdata->spinlock, flags);
> > +	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
> >  	CS_UNLOCK(drvdata->csa.base);
> >  
> >  	val = etm_readl(drvdata, ETMSR);
> 
> [Severity: High]
> This is a pre-existing issue, but could this code cause a synchronous
> external abort if the device fails to resume?
> 
> If pm_runtime_get_sync() returns a negative error code (e.g., if the device
> is suspended and its clocks or power domains remain gated), the code proceeds
> unconditionally to dereference drvdata->csa.base in etm_readl(). 
> 
> Accessing unclocked or unpowered CoreSight registers on ARM can result in a
> kernel panic. Should the return value of pm_runtime_get_sync() be checked
> before accessing the hardware?

Valid. might in another patchset.

> 
> [Severity: High]
> This is another pre-existing issue, but can this sysfs read silently break
> concurrent hardware enablement?
> 
> Concurrent sysfs readers like etmsr_show() use drvdata->spinlock to serialize
> their own hardware accesses, issuing CS_UNLOCK and CS_LOCK. However,
> etm_enable_hw() executes via smp_call_function_single() and does not hold
> drvdata->spinlock while issuing its own register writes and CS_LOCK.
> 
> If a sysfs read occurs concurrently with etm_enable_hw():
> 
> Sysfs thread                           etm_enable_hw()
> etmsr_show()
>   raw_spin_lock_irqsave()
>   CS_UNLOCK()
>                                        CS_UNLOCK()
>                                        write to registers...
>   CS_LOCK()                            
>                                        write to more registers... (ignored)
>                                        CS_LOCK()
> 
> Will the sysfs read's CS_LOCK lock the CoreSight Lock Access Register (LAR)
> in the middle of etm_enable_hw()'s configuration sequence, causing
> subsequent register writes in etm_enable_hw() to be silently ignored?
> 
> [ ... ]
> 
> > @@ -76,7 +76,7 @@ static ssize_t reset_store(struct device *dev,
> >  		return ret;
> >  
> >  	if (val) {
> > -		spin_lock(&drvdata->spinlock);
> > +		raw_spin_lock(&drvdata->spinlock);
> >  		memset(config, 0, sizeof(struct etm_config));
> >  		config->mode = ETM_MODE_EXCLUDE;
> >  		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
> > @@ -86,7 +86,7 @@ static ssize_t reset_store(struct device *dev,
> >  
> >  		etm_set_default(config);
> >  		etm_release_trace_id(drvdata);
> > -		spin_unlock(&drvdata->spinlock);
> > +		raw_spin_unlock(&drvdata->spinlock);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this cause a trace ID
> use-after-free and corrupt the trace stream?
> 
> This resets the staging configuration and unconditionally calls
> etm_release_trace_id() without checking if the tracer is currently active
> (e.g., via coresight_get_mode()). 
> 
> If writing to this reset attribute happens while a tracing session is running,
> the trace ID is returned to the pool and can be reallocated to another
> CoreSight component while this device continues to emit hardware packets using
> the freed ID.
> 

I think we should allow the reset when coresight_get_mode() == DISABLE
only. @Leo?

> > @@ -722,9 +722,9 @@ static ssize_t cntr_val_show(struct device *dev,
> >  	struct etm_config *config = &drvdata->config;
> >  
> >  	if (!coresight_get_mode(drvdata->csdev)) {
> > -		spin_lock(&drvdata->spinlock);
> > +		raw_spin_lock(&drvdata->spinlock);
> >  		val = config->cntr_val[config->cntr_idx];
> > -		spin_unlock(&drvdata->spinlock);
> > +		raw_spin_unlock(&drvdata->spinlock);
> >  	} else {
> >  		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> 
> [Severity: High]
> This is a pre-existing issue, but can this race with a concurrent power down
> and cause a synchronous external abort?
> 
> The check for coresight_get_mode() bypasses both the spinlock and
> pm_runtime_get_sync(). If the device is active during the check, it jumps
> to the else branch to read the hardware register. 
> 
> If another thread disables the device (which calls pm_runtime_put() and
> powers down the hardware) concurrently, this will read from powered-off
> hardware.
> 
> Additionally, is it safe to read config->cntr_idx here without a lock?
> 
> [ ... ]
> 
> > @@ -940,13 +940,13 @@ static ssize_t seq_curr_state_show(struct device *dev,
> >  	}
> >  
> >  	pm_runtime_get_sync(dev->parent);
> > -	spin_lock_irqsave(&drvdata->spinlock, flags);
> > +	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
> >  
> >  	CS_UNLOCK(drvdata->csa.base);
> >  	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> 
> [Severity: High]
> This is a pre-existing issue, but as with etmsr_show() earlier, could this
> cause a synchronous external abort if the device fails to resume?
> 
> If pm_runtime_get_sync() returns a negative error, accessing the unclocked
> hardware register will cause a kernel panic.

@Leo, I think both of direct read from sysfs interface should be
synchronized via IPI. What do you think?

-- 
Sincerely,
Yeoreum Yun
