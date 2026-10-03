Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877C8635D;
	Sat,  3 Oct 2026 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995652; cv=none; b=Wt4uN85OvmEFKzGZUzY8lIWzF+/ZC7FsyLTZDqrPx+rdbp1yFaMMBk1l+EKWaqY2r8UJLk3ia3MVwMcKly4a6FhGlhdHvAYCyYrps/6wZBioR0k1RY8D9qM3JpGQqYMG8FHscLfDVBOZKFF7sLPfLvFSBqkySkYlPnrNFM/I94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995652; c=relaxed/simple;
	bh=y+0NtXlehyKhG/xFGaoMX/guiBPv8mMY3ywUHbrygHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSEQ5nIrZ29jVHoB+zT4IBxeFlxhy3iBFChVQCWc8udNkIzeZoxyfrY9+5/1rBM2dCmMzPbW0n7CLY2tmoIDXPrMn9OlADYcdwLVzhk72nnLFZ54t4/mIL0XiTM2bIynLwtiGo1Ak1qERDvJ/sL7FMohgwXMVrlqjIdM/Jmdekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q0EsKV53; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q0EsKV53"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7ED2F;
	Fri,  2 Oct 2026 19:47:24 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70FBE3F763;
	Fri,  2 Oct 2026 19:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995648; bh=y+0NtXlehyKhG/xFGaoMX/guiBPv8mMY3ywUHbrygHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0EsKV53MfPmTyJdBqDUSpHVt7DLowYVI63HhPOvPD0R9tXHAhAgXf8gul7WuBuJr
	 eclm4sMUmIOvNFjENwUO8LmZbVbxRAW4exHS8F7CERjB5YSQCfBIM5CgjDrEaLFEfz
	 PrARTVMhHJgz0M0JhyZe2oV1/CU9ATNLNNNHqCG4=
Date: Sat, 3 Oct 2026 03:47:25 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v13 05/14] coresight: etm3x: fix inconsistencies with
 sysfs configuration
Message-ID: <asBsvTTuYXSLT4Zn@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-5-fe429d8d96fb@arm.com>
 <20261003013344.D438A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003013344.D438A1F00898@smtp.kernel.org>

On Sat, Oct 03, 2026 at 01:33:44AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] coresight: etm3x: race condition exposes powered-down hardware reads
> - [Medium] coresight: etm3x: data race on cntr_idx in sysfs read
> --
> 
> commit 6e8889b8f94797194e00dbd7c1a4354b7b49c21d
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm3x: fix inconsistencies with sysfs configuration
> 
> This commit separates ETM3x configuration into curr_config and config to
> resolve inconsistencies when modified via sysfs during an active perf session.
> It also removes the spinlock from sysfs enable/disable paths and uses IPIs to
> read registers on the proper CPU.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > index 862ad0786699c..dcadcc3830123 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> [ ... ]
> > @@ -640,7 +641,14 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
> >  	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
> >  				 drvdata, 1);
> >  
> > -	spin_unlock(&drvdata->spinlock);
> > +	/*
> > +	 * Userspace may read seq_curr_state and cntr_val through sysfs
> > +	 * after the sysfs-session has been disabled.
> > +	 */
> > +	for (i = 0; i < drvdata->nr_cntr; i++)
> > +		config->cntr_val[i] = curr_config->cntr_val[i];
> > +
> > +	config->seq_curr_state = curr_config->seq_curr_state;
> >  
> >  	/*
> >  	 * we only release trace IDs when resetting sysfs.
> > @@ -649,6 +657,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
> >  	 * prior trace id allocation method
> >  	 */
> >  
> > +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> > +
> 
> [Severity: High]
> Can this expose a window where hardware registers are read while the device
> is powered down?
> 
> The commit removes the drvdata->spinlock that previously serialized sysfs
> reads against enable/disable paths. In etm_disable_sysfs(), the hardware is
> powered down via smp_call_function_single(), but the mode is not changed
> to CS_MODE_DISABLED until much later here.
> 
> During this window, could a concurrent sysfs reader like
> seq_curr_state_show() observe coresight_get_mode() as CS_MODE_SYSFS and
> proceed to call etm_readl_cslocked()? Reading from hardware registers such
> as ETMSQR when the ETM power-down bit is set can lead to bus faults (SError)
> or return garbage.

This is not true. etm_read_cslocked() caa pm_runtime_get_sync() and
then try to smpcall to read the hardware register.


> 
> >  	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
> >  }
> >  
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index cdb70a4382eb8..284998f180170 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> [ ... ]
> > @@ -730,7 +765,10 @@ static ssize_t cntr_val_show(struct device *dev,
> >  		val = config->cntr_val[config->cntr_idx];
> >  		spin_unlock(&drvdata->spinlock);
> >  	} else {
> > -		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> > +		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2);
> 
> [Severity: Medium]
> Is it safe to read config->cntr_idx here without holding drvdata->spinlock?
> 
> Concurrent updates from cntr_idx_store() via sysfs could change this value
> mid-execution. Since the spinlock was removed from this branch, could this
> data race cause the lockless read to fetch an inconsistent index and target
> an unintended counter register?

This is ridiculous anyway foremerly too who got the lock first affect 
the result.when *concurrent* enable and store together.
So it's igrnoable since we don't expect user config somthing while
enabling session.


> 
> > +		if (ret)
> > +			return ret;
> > +		val = val2;
> >  	}
> >  
> >  	return sysfs_emit(buf, "%#x\n", val);
> [ ... ]
> > @@ -946,15 +985,10 @@ static ssize_t seq_curr_state_show(struct device *dev,
> >  		goto out;
> >  	}
> >  
> > -	pm_runtime_get_sync(dev->parent);
> > -	spin_lock_irqsave(&drvdata->spinlock, flags);
> > -
> > -	CS_UNLOCK(drvdata->csa.base);
> > -	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> > -	CS_LOCK(drvdata->csa.base);
> > -
> > -	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > -	pm_runtime_put(dev->parent);
> > +	ret = etm_readl_cslocked(drvdata, ETMSQR, &val);
> 
> [Severity: High]
> This is where a concurrent reader could read a powered-down register due to
> the window mentioned above in etm_disable_sysfs().

no. etm_readl_cslocked() calls pm_runtime_get_sync().
> 
> > +	if (ret)
> > +		return ret;
> > +	val &= ETM_SQR_MASK;
> >  out:
> >  	return sprintf(buf, "%#lx\n", val);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=5

-- 
Sincerely,
Yeoreum Yun
