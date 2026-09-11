Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB944160D;
	Fri, 11 Sep 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126171; cv=none; b=f02/89hpQJVxlQtwYvKjTjY1enjZx4qP8vj9x0XmHhFR0wu7z9/iXCqPycs5lPi/OSr9SoHrrwBlAJf0Q6LW34Kp4LE6Qf8K7gx0RElb72/R2++ljQtJ/WoVkmFYof19SKuDxwhcarv3zRmYZYQGvc3SaBTRPI4IuPM35NvSNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126171; c=relaxed/simple;
	bh=dylT5QwD+5iw6+xBMDDSZWueFSXPCVlmrXhdgxIr6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqzmBRsuqGQKZn8hXx4UWE0dzMtAnqv5yNhjLpuq0okKuptzUWjAhzSwSwmaCAFQK7g40ybAT/sHxbBNc61IKZB1u/ITHSTJPjQgwtxCBieKo/LZ200vJn60/vs2Cq10DYJR8Yadzc19AbDEP00D8QsvEVVA3vQkD4j8QreOULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NXaoff/c; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NXaoff/c"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4527516F2;
	Fri, 11 Sep 2026 04:29:20 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DDA13F86C;
	Fri, 11 Sep 2026 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789126163; bh=dylT5QwD+5iw6+xBMDDSZWueFSXPCVlmrXhdgxIr6b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXaoff/cPBT+KcaxMNnp6ng/KdjGDZ8NwVG4kDz1agyAR6lLAZ7S0WZN1BolhOVOo
	 pxd4aCI7G3O5nJ37ny4mKcYdRlvPuUFPXCixpv+FBKRHCnH3G9NmbimgsRe9JKTUXK
	 +qzkv/rYynzV7dg0/vgkCNJwdAX9AGs4GSc95QDo=
Date: Fri, 11 Sep 2026 12:29:20 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v10 1/8] coresight: etm4x: fix inconsistencies with sysfs
 configuration
Message-ID: <aqPmEPRDUFE1hNXM@e129823.arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-1-1b715d95927a@arm.com>
 <20260911112144.8EC3F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911112144.8EC3F1F000FF@smtp.kernel.org>

On Fri, Sep 11, 2026 at 11:21:44AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Hardware counter values (`cntr_val`) read back during trace disable are saved to the temporary runtime `active_config` instead of the sysfs-visible `config` structure, permanently losing the post-session hardware state.
> --
> 
> commit 293039b149bb540c924b83cd181604cbff99de4c
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: fix inconsistencies with sysfs configuration
> 
> This commit addresses inconsistencies in ETM4x sysfs configuration by
> separating the configuration into an active_config for the current session
> and a config for sysfs. It updates the enable/disable paths to use the
> active session configuration to prevent corruption from concurrent access.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> 
> [ ... ]
> 
> > @@ -1044,7 +1054,7 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
> >  static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
> >  {
> >  	u32 control;
> > -	struct etmv4_config *config = &drvdata->config;
> > +	struct etmv4_config *config = &drvdata->active_config;
> >  	struct coresight_device *csdev = drvdata->csdev;
> >  	struct csdev_access *csa = &csdev->access;
> >  	int i;
> 
> [Severity: High]
> Does this change cause the post-session hardware counter values to be lost?
> 
> Later in etm4_disable_hw(), the hardware counter values are read back from
> the device:
> 
> 	/* read back the current counter values */
> 	for (i = 0; i < caps->nr_cntr; i++) {
> 		config->cntr_val[i] =
> 			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> 	}
> 
> Because config now points to drvdata->active_config, the updated counter
> values are saved to the temporary active session configuration instead of
> the primary sysfs configuration.
> 
> When a user subsequently reads the counter value via the sysfs interface
> in cntr_val_show():
> 
> 	struct etmv4_config *config = &drvdata->config;
> 	...
> 	val = config->cntr_val[idx];
> 
> they will read from the static drvdata->config, which never receives these
> read-back values and will instead return the initial configuration value.
> Should the read-back hardware state be synchronized back to drvdata->config
> when the trace is disabled?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com?part=1

The same for etm3. I'll fix it in next round.

-- 
Sincerely,
Yeoreum Yun
