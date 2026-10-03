Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE171FF7C8;
	Sat,  3 Oct 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790994626; cv=none; b=j2ihWb0FhaqgJI1SoMs4pySjUqV0EjNNUXV3BKlSi+8CsUBYTBWVb3mrq65vOM3ovRfea8SGM9/ck39I4wXHKPDaHGBG7tIT2FTjoU4Rmq+7TKRLUAxPHLLJ/s8kbl2J46VzkU+P+Y6ho/tQBVWlEMJIrO4wdbe3O0Vsth5eRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790994626; c=relaxed/simple;
	bh=bOZ8zCdpPujZhaWmDqARnL6IPmO6aZcDhybIp53bYX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgAIE75xTHHJLRR+aTksLyNW5VAuJgpsTnZV3Ny2NUP0TmyFrRSf9npaNI8lsj7Mk6ZDpEgUztd2tnK7Cjx5zL5f+doM1PVP22JQV5cENfZx+BNjz+4Yf6tZPl+nCebHW+E5X8xdf7pxcHH4b4yg3Agh48GHF7itm0rA0BZMBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BmutJxP9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BmutJxP9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 108D72F;
	Fri,  2 Oct 2026 19:30:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F9C3F763;
	Fri,  2 Oct 2026 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790994624; bh=bOZ8zCdpPujZhaWmDqARnL6IPmO6aZcDhybIp53bYX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmutJxP9pK9fwDpfn/EZVE2MJbnoAb5YcW2R7T4JLVuYNzopInBGNz8KXYT7GvgX/
	 bHvIVhR2liGBK7G0tzaz2CZ/cWNmLdS5jClfsTgn6rJaSSNatI9ykXEztniJrdn44h
	 XW9xzmR1UE10zDzLOFABlzxNepf/q+Fyly+bb3zk=
Date: Sat, 3 Oct 2026 03:30:21 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v13 04/14] coresight: etm4x: fix inconsistencies with
 sysfs configuration
Message-ID: <asBovdmuZRDF5r8c@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-4-fe429d8d96fb@arm.com>
 <20261003013347.0E07E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003013347.0E07E1F00899@smtp.kernel.org>

On Sat, Oct 03, 2026 at 01:33:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] coresight: etm4x: data race in etm4_disable_sysfs() due to missing spinlock
> - [Medium] coresight: etm4x: resource leak when disabling sysfs tracing on an offline CPU
> --
> 
> commit 431ca53aed38063c4c77184079a32f5fbbb5b69b
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: fix inconsistencies with sysfs configuration
> 
> This commit separates the configuration into curr_config and config to prevent
> inconsistencies when modifying via sysfs during an active perf session. It
> also removes the lock/unlock from the sysfs enable/disable path and
> startup/dying_cpu, except when accessing config fields.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1090,8 +1097,9 @@ static void etm4_disable_sysfs_smp_call(void *info)
> >  
> >  	etm4_disable_hw(drvdata);
> >  
> > +	cscfg_csdev_disable_active_config(drvdata->csdev);
> > +
> >  	drvdata->csdev->path = NULL;
> > -	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> >  }
> 
> [ ... ]
> 
> > @@ -1144,9 +1153,19 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
> >  	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
> >  				 drvdata, 1);
> 
> [Severity: Medium]
> If smp_call_function_single() fails (for instance, if the target CPU is
> offline), it will return -ENXIO and bypass the callback entirely.
> Since cscfg_csdev_disable_active_config() was moved into the SMP callback
> etm4_disable_sysfs_smp_call(), does this mean we could permanently leak the
> active configuration when the CPU is offline? This could leave the module
> reference count (active_cnt) leaked and active_cscfg_ctxt dangling.

This is totally wrong. since sysfs seesion is disabled before *offline*
by coresight_dying_cpu().

> >  
> > -	raw_spin_unlock(&drvdata->spinlock);
> > +	/*
> > +	 * Userspace may read ss_status and cntr_val through sysfs after
> > +	 * the sysfs-session has been disabled.
> > +	 */
> > +	for (i = 0; i < drvdata->nr_ss_cmp; i++)
> > +		config->ss_status[i] = curr_config->ss_status[i];
> >  
> > -	cscfg_csdev_disable_active_config(csdev);
> > +	for (i = 0; i < drvdata->nr_cntr; i++)
> > +		config->cntr_val[i] = curr_config->cntr_val[i];
> > +
> > +	config->seq_state = curr_config->seq_state;
> 
> [Severity: Medium]
> Is it safe to copy curr_config to config here without holding the
> drvdata->spinlock?
> 
> Sysfs writers (like reset_store()) and readers (like cntr_val_show()) do
> not check if the device is currently in CS_MODE_SYSFS; they rely solely on
> the spinlock for synchronization.
> 
> Could this create a data race where concurrent sysfs operations are
> overwritten by this lockless loop, corrupting the sysfs-exposed state?

It's okay since the ss_status's purpose is to clear the PENDING and
STATUS bit otherwise, RES and RO field.

> 
> > +
> > +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> >  
> >  	/*
> >  	 * we only release trace IDs when resetting sysfs.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=4

-- 
Sincerely,
Yeoreum Yun
