Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9922D4E9;
	Sat,  3 Oct 2026 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791002453; cv=none; b=ddZBB3l42gnveUKzNE2iQr8qcMOSdcVM469SxJgrtdMcKXK0GiNIx9LUIExmYzGuf8CPtnRwjEGMu+oAtdh/kRX2dLDIH6eDCYVCsq1HSpPL/yrttaBDmTgTRJS/7bVEtM1BVy8cC/t3/RHvESqDDSB7F20gbNqekpBpVY3BxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791002453; c=relaxed/simple;
	bh=rcyhw3eDgk/zGOOJCULt1I8dSAqR1AYAN4zkv3JVIMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCP31I52PUCIUwEcCgihhD9B0xVeBpX6rjFzqdooi3YE3FDyv51yBLNvTnsqc0AmZ4cUObB2+hrrvSdEG17SvuyTHbhxPHkYokGdtOpnV9Kg3CkpDjMf+l2wD5KXyQsj850vuFwVzNhv8CBnmN8EfdGo5asrXNGcSYKjzkucjew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q2LN6qZS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q2LN6qZS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6702F;
	Fri,  2 Oct 2026 21:40:47 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01F2C3F763;
	Fri,  2 Oct 2026 21:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791002450; bh=rcyhw3eDgk/zGOOJCULt1I8dSAqR1AYAN4zkv3JVIMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2LN6qZS58jdwQfXoU0Vg/ADKDkcJyuKKKubDt1D2xaFCGhItjX8jviJW4+aqWo2W
	 jOuqEJ1HqNlzpIiOG8acAT+o/Ayby3k5Z4RO9DPO0L29wXHsStDEonUPRsgOkkXaT8
	 gX1S3Aoev/2axLTGjdvZAp1pco2kpAjEpBAh9+V0=
Date: Sat, 3 Oct 2026 05:40:47 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v13 04/14] coresight: etm4x: fix inconsistencies
 with sysfs configuration
Message-ID: <asCHT6F8ZeVIY9XJ@e129823.arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-4-5d8a29aead95@arm.com>
 <20261003030633.477A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003030633.477A61F000FF@smtp.kernel.org>

On Sat, Oct 03, 2026 at 03:06:32AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: data race in etm4_disable_sysfs() due to missing spinlock
> --
> 
> commit 047fa1646a004922cd9c2e2d801758f38062c7c6
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> Subject: coresight: etm4x: fix inconsistencies with sysfs configuration
> 
> This commit separates the ETM4x configuration into a session-specific 
> curr_config and a sysfs-set config to prevent corruption and inconsistency. 
> It also removes drvdata->spinlock coverage from the enable/disable paths 
> except when explicitly accessing configuration fields.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> 
> [ ... ]
> 
> > @@ -1134,8 +1142,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
> >  static void etm4_disable_sysfs(struct coresight_device *csdev)
> >  {
> >  	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > -
> > -	raw_spin_lock(&drvdata->spinlock);
> > +	struct etmv4_config *config = &drvdata->config;
> > +	const struct etmv4_config *curr_config = &drvdata->curr_config;
> > +	int i;
> >  
> >  	/*
> >  	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
> > @@ -1144,9 +1153,19 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
> >  	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
> >  				 drvdata, 1);
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
> Does this modification to the config fields require drvdata->spinlock
> protection?
> 
> The commit message notes the intent to remove the lock "except when to
> access config fields", which is correctly followed during sysfs enable
> via scoped_guard. However, sysfs readers expect this spinlock to be held
> when reading these arrays.

This is not matter. Since cntr_val and seq_sate wouldn't be
modified before disabled and ss_status' write purpose is clearing
the PENDING and STATUS bits, lockless read is fine so it's intended.

Therefore, this comment is ignorable.

-- 
Sincerely,
Yeoreum Yun
