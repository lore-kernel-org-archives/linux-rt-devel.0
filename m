Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D1298CAF;
	Fri, 11 Sep 2026 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126342; cv=none; b=NL/vKqh4CQdiV8SkI8pdamraq+Zru6ryJ36d+0yXKciyj/nyeolYiEUvYrvfvNf0rNyRIb3ysTjB0cUY0U10kkBZZuoN1Z8deAAXaIO7zNPVIeGFX4IN/c94CkfNmYEbpJTQY3mk7YxTNDzHHueOKzpGXbDhSnLr7dCjbBVhXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126342; c=relaxed/simple;
	bh=s/ODydIxsCcvKM3SXUbVkIRCg0OzptzpI7rs77XtcrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGByfOUklh56aZbYaAfF8RoqZGjoxk65DvVhGhCxvyKJbCQ6AQbJ5vuEVYjkRZVdBSLF8lRFl51zC1oGFJicp6mlxEz5tkn/X+zeINppsHnFAOXZMVN/RtcyO7DQ3aY3BPIBubegCNzfdg1NKUq53WcJDlE/aeGwTy15wbC06ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y92TFKNZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y92TFKNZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D05216F2;
	Fri, 11 Sep 2026 04:31:49 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682373F59E;
	Fri, 11 Sep 2026 04:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789126313; bh=s/ODydIxsCcvKM3SXUbVkIRCg0OzptzpI7rs77XtcrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y92TFKNZvfTwl+6EOT3Q+GXm7iz/4IKg439KIr0LLt9U0UArtOzJrRXGuIrYarK5b
	 ZrEhX9NcAczEWXWKhymUFV/Ion39MzjQwNV4C41dh74r+NMFbjpa5Lax5PyGdNuVod
	 1h25MyOm4HFPuendHZz6mVb1HwF9frFJ+z4NF7A0=
Date: Fri, 11 Sep 2026 12:31:50 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 5/8] coresight: etm4x: introduce struct etm4_caps
Message-ID: <aqPmpuIxWosNsfFd@e129823.arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-5-1b715d95927a@arm.com>
 <20260911112023.31F161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911112023.31F161F000FF@smtp.kernel.org>

On Fri, Sep 11, 2026 at 11:20:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Hardware-reported capability counts are used as loop limits without being checked against static array capacities, leading to heap buffer overflows.
> --
> 
> commit 1fb7a47435872f1b7f11824178d098d0258effdc
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: introduce struct etm4_caps
> 
> This commit introduces struct etmv4_caps to encapsulate ETMv4 capabilities 
> and migrates the relevant capability information out of struct etmv4_drvdata 
> into it.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> [ ... ]
> > @@ -1491,43 +1501,43 @@ static void etm4_init_arch_data(void *info)
> [ ... ]
> > -	drvdata->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
> > -	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> > +	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
> > +	for (i = 0; i < caps->nr_ss_cmp; i++) {
> >  		drvdata->config.ss_status[i] =
> >  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> >  	}
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this code overflow the ss_status[] 
> array if the hardware reports a capability count greater than the static array 
> capacity?
> 
> In etm4_init_arch_data(), caps->nr_ss_cmp is read directly from the TRCIDR4 
> hardware register. The architecture allows this field to be up to 15, but the 
> arrays like ss_status are fixed in size to ETM_MAX_SS_CMP. Using the 
> unvalidated hardware capability as a loop limit can lead to a heap buffer 
> overflow.
> 
> [ ... ]
> > @@ -1892,57 +1903,56 @@ static int etm4_cpu_save(struct coresight_device *csdev)
> [ ... ]
> > -	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> > +	for (i = 0; i < caps->nr_ss_cmp; i++) {
> >  		state->trcssccr[i] = etm4x_read32(csa, TRCSSCCRn(i));
> >  		state->trcsscsr[i] = etm4x_read32(csa, TRCSSCSRn(i));
> >  		if (etm4x_sspcicrn_present(drvdata, i))
> >  			state->trcsspcicr[i] = etm4x_read32(csa, TRCSSPCICRn(i));
> >  	}
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does this loop risk corrupting
> the dynamically allocated etmv4_save_state structure? 
> 
> Similar to the initialization path, etm4_cpu_save() relies on the unvalidated 
> caps->nr_ss_cmp bound to write into state->trcssccr[] and state->trcsscsr[]. 
> If the hypervisor or hardware provides a larger count, this will overflow the 
> save state buffers on suspend and resume paths.
> 
> [ ... ]
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> [ ... ]
> > @@ -2059,7 +2090,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
> [ ... ]
> >  	mask = config->ctxid_mask0;
> > -	for (i = 0; i < drvdata->numcidc; i++) {
> > +	for (i = 0; i < caps->numcidc; i++) {
> >  		/* mask value of corresponding ctxid comparator */
> >  		maskbyte = mask & ETMv4_EVENT_MASK;
> >  		/*
> >  		 * each bit corresponds to a byte of respective ctxid comparator
> >  		 * value register
> >  		 */
> >  		for (j = 0; j < 8; j++) {
> >  			if (maskbyte & 1)
> >  				config->ctxid_pid[i] &= ~(0xFFUL << (j * 8));
> 
> [Severity: Critical]
> This is a pre-existing issue, but could this sysfs-triggered write also 
> overflow the ctxid_pid[] array?
> 
> In ctxid_masks_store(), caps->numcidc is used as the loop bound for updating 
> config->ctxid_pid[i], which is dimensioned by ETMv4_MAX_CTXID_CMP. Without 
> clamping the hardware-reported capability, writing to this sysfs node could 
> result in out-of-bounds memory accesses.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com?part=5

Nacked. All of above is false positive. array size is staticlly set as
MAXIMUM size in coresight-etm4x.h.

-- 
Sincerely,
Yeoreum Yun
