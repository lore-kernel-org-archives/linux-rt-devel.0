Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A32F3C07;
	Sat,  3 Oct 2026 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791002052; cv=none; b=AjmzbIHNqVu+yUXTZvVRd384jRu5AemlUSBIC210qo6n4jLNbPUltAG+f7QkaOHozd/v4DRJKGjjYpjYBAyetfe8xNCuJTdrmOrf90T6+X+zeKpFnMnb9aw09xWiB63kZDOStoV5EhbswDAftB8VnO3O5aD6eTQY0crs0upwTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791002052; c=relaxed/simple;
	bh=xbY/oD13/EkW8E8ahqA/imAPxNMGFwHqFmJ3d+CVls4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7h6PuquE6Y5cXKy9Yisua1WaaBJyFFx7ZdQpJ0UScWhFX1dQrKfMWHtZq3G001bmhUl8gNRy2ERgIBwqX3OCoWEYkJ10b/TYcXzQ+UW3HawP+z0sMN3IKWkF+m6w/XS473wYr3Bw0vULv/DxNjW4of/nTeaGeSnLuqJpfKxBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PCe+OnIg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PCe+OnIg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBC92F;
	Fri,  2 Oct 2026 21:34:06 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401073F763;
	Fri,  2 Oct 2026 21:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791002049; bh=xbY/oD13/EkW8E8ahqA/imAPxNMGFwHqFmJ3d+CVls4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCe+OnIgnqlkqYjebROj81OOas39Cl8iWPBl7sjm18BF3w5ihKOaWvehssK08Cpgm
	 EdWqfWtL5Ci9GVs6vgv/9XUk0i/GE0e4CmAn4DfUTcOKu/dOWnG1KuKKI4e8jASaaf
	 rIMQZ7d0AZGyKX5oRBvBUALVaNdBeEkVOXOkKLlo=
Date: Sat, 3 Oct 2026 05:34:07 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RESEND v13 03/14] coresight: etm3x: prohibit modifying
 cntr_val and reset while session is enabled
Message-ID: <asCFv0aaUectdMPY@e129823.arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-3-5d8a29aead95@arm.com>
 <20261003030639.07A511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003030639.07A511F000FF@smtp.kernel.org>

On Sat, Oct 03, 2026 at 03:06:38AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] coresight: etm3x: TOCTOU race in reset_store() allows trace ID release during active session
> --
> 
> commit e2e191629dd66da8998d4646f82c1d5c193cb283
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
>     
> This commit adds checks to prohibit modifying cntr_val and calling reset while
> a trace session is enabled by returning -EBUSY.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index b3c67e96a82a4..cdb70a4382eb8 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > @@ -75,6 +75,10 @@ static ssize_t reset_store(struct device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> > +	    coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> > +
> >  	if (val) {
> >  		spin_lock(&drvdata->spinlock);
> 
> [Severity: High]
> Does this code introduce a Time-of-Check to Time-of-Use (TOCTOU) race?
> 
> Since coresight_get_mode() is checked outside drvdata->spinlock, a concurrent
> sysfs write to enable_source could start a trace session (allocating a trace
> ID and starting the hardware tracer) immediately after the mode check passes.
> 
> Once reset_store() acquires the spinlock, it will unconditionally zero the
> sysfs configuration and call etm_release_trace_id().
> 
> Releasing the trace ID while the hardware tracer is actively emitting packets
> returns the ID to the global pool. Another source might subsequently allocate
> the same trace ID, leading to collisions at the CoreSight sink and
> unrecoverable trace data corruption. This structural race condition appears
> to remain unfixed through the end of the patch series.

The root cause of this, etm3's trace_id could be allocated via
trace_id_show() and this scenario is also possible while on concurrent
contention between reset vs enable -- reset take lock first, after
coresight path allocate trace_id and waiting the lock.

IOW, this is known issue but we don't take it seriously since
we don't expect user try to enable before it finishes to config.
Therefore, this is ignorable this this round. Might it much better to
remove the trace_id_show() interface.

> 
> >  		memset(config, 0, sizeof(struct etm_config));
> 
> [ ... ]
> 
> > @@ -744,6 +748,9 @@ static ssize_t cntr_val_store(struct device *dev,
> >  	ret = kstrtoul(buf, 16, &val);
> >  	if (ret)
> >  		return ret;
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> > +	    coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  
> >  	spin_lock(&drvdata->spinlock);
> 
> [Severity: High]
> Could the same TOCTOU race pattern apply here as well?
> 
> If a trace session is concurrently enabled right after the mode check, the
> counter value could be modified while the session is active, resulting in a
> lost sysfs write.

The puprpose of this to prevent modification after *session* is fully
enabled since the cntr_val is overwritten after disabled.

IOW, while enabling the cntr_val is not matter and this secnario
couldn't be resolved by the locking -- it's matter who take the lock first
while on concurrent contention between store vs enable also, it's
pre-exist behavior.

Since we don't expect user try to enable before it finishes to config.
Therefore, this is ignorable.

-- 
Sincerely,
Yeoreum Yun
