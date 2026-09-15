Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5EE3C3F54;
	Tue, 15 Sep 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479352; cv=none; b=m6gXn8KueR/Pvg2agU/ZbNXY0eaBX6QOAMhJW/lVaJOpy1onj5nbTwUR7+N0VZdWggbyi6qOPiSV9h/gT+TBmd7tKyN7eZTWTlIusvcOvlls740eLiRK8RoDl3lOKAN52yS2/VdR4YRnnsusMNesijVZmeSjG8tzOHCPSIKr8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479352; c=relaxed/simple;
	bh=ivHWy0zpM06EWX3bQlbrWhF3ivrtWE9QnS/QrGq9+Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+zAtTu3ocUVfdlIbOkk8rZOgJMH5+rJOd/yFJ4kg8umvWXaHZ3RbMztUqhv73fBMfr5JGkef0IPq/h8t1N3AWaOGoCfYzID0MbdAMrQ69WtR+Xj4kZRgtCUVgrofOegmp2Hd3ynZ3pYIZGb+TDyjqcyPAPl3mv/uYlNhfJRW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hckTRaWx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hckTRaWx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2218515A1;
	Tue, 15 Sep 2026 06:35:45 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178493F7B4;
	Tue, 15 Sep 2026 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789479348; bh=ivHWy0zpM06EWX3bQlbrWhF3ivrtWE9QnS/QrGq9+Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hckTRaWxwM3/d+3kpLpZTq+tDSiNDQ/0jHldKmtLxd/oJeG/c11FHs8Ny/cfd+xp6
	 /P+qDtDI7QikJ5KltmG/QsmVbKunzGZm3Qzh3FpF5f/FGv4UA0y8qzIa4g1TmiLFVq
	 nrTurMZjYUhTZHg0awQM6iR4CSHR7YDDGMoZywns=
Date: Tue, 15 Sep 2026 14:35:45 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v11 7/9] coresight: etm4x: exclude ss_status from
 drvdata->config
Message-ID: <aqlJsXWMUJgvEXCg@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
 <20260915114959.1A22A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915114959.1A22A1F00893@smtp.kernel.org>

On Tue, Sep 15, 2026 at 11:49:58AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] coresight: data race and state leak in shared ss_status array
> - [Medium] coresight: contradictory bitmask change introduces unhandled behavior
> --
> 
> commit 1a408a1bbc8676e137115f3c8798cfbd8a499e15
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: exclude ss_status from drvdata->config
>     
> This patch moves the ss_status array out of the session-specific configuration 
> structures and into the shared etmv4_drvdata structure. It aims to preserve 
> existing behavior regarding single-shot comparator events while cleaning up 
> the configuration data.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 70a5c0b4fad1c..9de0c268ff954 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> [ ... ]
> > @@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
> The commit message states that this patch intentionally preserves the existing
> behavior regarding the clearing of PENDING and STATUS bits. However, the
> pre-patch code only cleared TRCSSCSRn_STATUS. By explicitly adding
> TRCSSCSRn_PENDING to the bitmask here, does this code actively introduce the
> behavioral change it claims to defer?

No perf do always clean, just make the same for right now.

> 
> [ ... ]
> > @@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
> >  
> >  	/* read the status of the single shot comparators */
> >  	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		config->ss_status[i] =
> > +		drvdata->ss_status[i] =
> >  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> >  	}
> 
> [Severity: High]
> When a perf session stops, etm4_disable_hw() writes the hardware state
> directly into the shared drvdata->ss_status array without holding
> drvdata->spinlock.
> 
> Since a concurrent sysfs session could be writing to this same array in
> sshot_ctrl_store() under the spinlock, can this lockless write cause a data
> race?
> 
> Additionally, does this overwrite leak the perf session's single-shot state
> into the shared array, allowing a subsequent sysfs session to inadvertently
> observe or re-inject the leftover perf state?

perf uses active_config directly, sysfs only uses config. so this is not
true.

> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index f6d053f73264c..50ef2e957300f 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> [ ... ]
> > @@ -1833,8 +1833,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
> >  	raw_spin_lock(&drvdata->spinlock);
> >  	idx = config->ss_idx;
> >  	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> > -	/* must clear bit 31 in related status register on programming */
> > -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> > +	/* must clear bit 31 and 30 in related status register on programming */
> > +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> >  	raw_spin_unlock(&drvdata->spinlock);
> 
> [Severity: High]
> As seen here, sysfs modifies the same shared array under the spinlock.
> Is it safe to move ss_status to the shared drvdata struct without
> synchronizing the hardware stop paths or segregating the session state?

It checks the mode first. So it's fine.


-- 
Sincerely,
Yeoreum Yun
