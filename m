Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544274D4895;
	Fri,  2 Oct 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961777; cv=none; b=JI6JD4SUgPFwsrclTJmWX8oAv8FHU1p8sUm7Zs0nK+L7GhYyDhUcpqEzzGIEdBBlRmTybciM6HlajZ2jnJs4G0YdXK7Oc1e8GN4t10ILHr3LST7E2xRRVcEcQwFpJ+oB1KS2W5BazOFoRTnHTGsdr1Odd6yRfpvfBrg/SPibzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961777; c=relaxed/simple;
	bh=YV1fKXXlbrVEfg5rJqDQn8ml/2AWIsJ5rBnjXuO+yQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiImdys0cvaRmY8q0RhB8rTLs3TSYSYU7ziOKqi1xocEfyID8GWdz4/ZKZDsRrngoU/rV+XqsEDpdawX94ntRj4pftMc/Vdt8I65KVasvyVWvr3pazttqUTIlXmtBtihLZKaqPPugjedGGnT7HhikNa59A1lCpuUADJUrdIsyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=anuOlyj4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="anuOlyj4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F8E11476;
	Fri,  2 Oct 2026 10:22:47 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412C43F85F;
	Fri,  2 Oct 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790961771; bh=YV1fKXXlbrVEfg5rJqDQn8ml/2AWIsJ5rBnjXuO+yQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anuOlyj4w7vvlNbQeAHudLgHTr+uuwN88+w9QXN87X6poDNv5/zb8dnNKju7JT/pc
	 hVr/b6srJCTTiRfidK+3uz/EOFXIdmGWMc7TWAYaBr1/+HHxJZrg+AAOGz8X80Yo9+
	 wh3gT7I54GCLgYcoAA1H0gBVoZu65kPZh+h+JOCk=
Date: Fri, 2 Oct 2026 18:22:48 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v12 03/14] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Message-ID: <ar_oaMevzmxSxNwN@e129823.arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-3-a2b41d2f7c2b@arm.com>
 <20260924175814.9AFC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924175814.9AFC01F000FF@smtp.kernel.org>

On Thu, Sep 24, 2026 at 05:58:14PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race bypasses session-enabled check in sysfs stores
> --
> 
> commit 0c7e96565d9330c7133fb31d646be9050f666c48
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
> 
> This commit prevents cntr_val and reset from being modified while a
> Coresight ETM session is enabled. Changes to cntr_val would be lost when
> the session is disabled, and reset should not be invoked during an active
> session.
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
> 
> [Severity: Medium]
> Is there a race condition here since the mode check happens outside the
> spinlock?
> 
> If thread A executes this check and sees the mode is disabled, thread B
> could then enable tracing (acquiring drvdata->spinlock, applying config to
> hardware, and updating the mode). 
> 
> When thread A proceeds, it will acquire the spinlock and zero the
> configuration while the hardware is actively using it. When thread B later
> disables tracing, it would partially overwrite the zeroed configuration with
> hardware register values.
> 
> Should the coresight_get_mode() check be moved inside the spinlock to
> prevent this time-of-check to time-of-use race?

TBH, reset interface seems awful and the same problem already pre-exists.
But this kinda was relief we don't think user wouldn't try to enable
before finishing the reset and return its result.

So this is ignorable.

> 
> >  	if (val) {
> >  		spin_lock(&drvdata->spinlock);
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
> 
> [Severity: Medium]
> Does this have the same vulnerability as reset_store()?
> 
> The configuration could be corrupted if tracing is enabled by another thread
> immediately after coresight_get_mode() returns but before the spinlock is
> acquired.
> 
> >  
> >  	spin_lock(&drvdata->spinlock);
> >  	config->cntr_val[config->cntr_idx] = val;

Same above and others

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com?part=3

-- 
Sincerely,
Yeoreum Yun
