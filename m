Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB84E5322
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726547; cv=none; b=hiAySHIVk/TBlYDcgnQVhAT8rGPES2IJGOpE0JFAXLNFBnNjLui0f5NoUEZA+BX2sRrPhCDTvNnP4wR5EVXbEagXzQ+UzGPXpbU/5cqZEPycOZMESmtFTBDjAPpeuEHLz2iFc1VkC+5cWw6nzj7IsVAXmCzdCPWh/Vl197m6ZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726547; c=relaxed/simple;
	bh=KtHkCCp2ZJR4LBAx51tVzEC/Q5vrKoLnFu0a9w80TAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyDFZljLYqbcjlV0CTHKQGoZCHY/g30N7JngCh6dKoHxUbI18hhYRH4DVjo8JOOuApfNWb57aslqhwWi4K30SBP8lOWYq4luWZoRnTa44vc96+Jr79zUEv/pxRsTqc5iIk6D91F9aXZyQLObeyT85ydQ3pG9NnXjGXigK1CA1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IYNKN1y8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IYNKN1y8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142742F;
	Fri, 18 Sep 2026 03:15:39 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4588E3F86F;
	Fri, 18 Sep 2026 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789726542; bh=KtHkCCp2ZJR4LBAx51tVzEC/Q5vrKoLnFu0a9w80TAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYNKN1y8FvUqtRoTmCJN84zHFuSHI66hCK7SmrRDccWSAA6kPUPRyCM86KWZopKwm
	 1MY7mRlqvOkyOEuMfABKU63QmNm6Jy9o3ocITyRl0IAoMNuKM0upzyIY4pK+X8ty4i
	 RzZgJ4HTwQtLV7OQSMxxgK2vrK6ps7sMbyFb/yd4=
Date: Fri, 18 Sep 2026 11:15:37 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, nd@arm.com
Subject: Re: [PATCH v10 6/8] coresight: etm4x: exclude ss_status from
 drvdata->config
Message-ID: <aq0PSbrA5n0mb8WG@e129823.arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-6-1b715d95927a@arm.com>
 <784ab977-0247-410e-a2f0-b24962b2579b@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784ab977-0247-410e-a2f0-b24962b2579b@arm.com>

Hi Mike,

> Hi,
> 
> On 9/11/26 11:56, Yeoreum Yun wrote:
> > The purpose of TRCSSCSRn register is to show status of
> > the corresponding Single-shot Comparator Control and input supports.
> > That means writable field's purpose for reset or restore from idle status
> > not for configuration.
> > 
> > Therefore, exclude ss_status from drvdata->config and move it to drvdata.
> > 
> > Before this patch, clearing the PENDING and STATUS bits when enabling
> > a perf session could trigger multiple single-shot events within
> > the same session.
> 
> The hardware is designed to have multiple single shot events - the reset bit
> in TRCSSCCRn specifically programs this behaviour.
> 
> But the basic point is correct there is no need to have the status register
> as part of the configurable set of registers.
> 
> This issue will be addressed in a future patch;

Acked. Thanks for your review ;)

> > this patch intentionally preserves the existing behavior.
> > 
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c  | 15 ++++++++-------
> >   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
> >   drivers/hwtracing/coresight/coresight-etm4x.h       |  7 ++++++-
> >   4 files changed, 19 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > index d24f533c623d..098aabd2b922 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > @@ -86,7 +86,6 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
> >   		off_mask =  (offset & GENMASK(11, 5));
> >   		do {
> >   			CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
> > -			CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
> >   			CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
> >   		} while (0);
> >   	} else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 6d64a3fbdea4..68aa99e8135d 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -95,7 +95,7 @@ static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
> >   	const struct etmv4_caps *caps = &drvdata->caps;
> >   	return (n < caps->nr_ss_cmp) && caps->nr_pe_cmp &&
> > -	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
> > +	       (drvdata->ss_status[n] & TRCSSCSRn_PC);
> >   }
> >   u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
> > @@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> >   		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> >   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		/* always clear status bit on restart if using single-shot */
> > +		/* always clear status and pending bits on restart if using single-shot */
> >   		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> > -			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
> > +			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> >   		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> > -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> > +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
> >   		if (etm4x_sspcicrn_present(drvdata, i))
> >   			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
> >   	}
> > @@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
> >   	/* read the status of the single shot comparators */
> >   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		config->ss_status[i] =
> > +		drvdata->ss_status[i] =
> >   			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> >   	}
> > @@ -1511,8 +1511,9 @@ static void etm4_init_arch_data(void *info)
> >   	 */
> >   	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
> >   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> > -		drvdata->config.ss_status[i] =
> > -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> > +		drvdata->ss_status[i] = etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> > +		drvdata->ss_status[i] &= (TRCSSCSRn_PC | TRCSSCSRn_DV |
> > +					  TRCSSCSRn_DA | TRCSSCSRn_INST);
> 
> The unused bits in this register are RES0 - rendering this masking
> redundant.

Agree. I'll restore it.

> 
> >   	}
> >   	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
> >   	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index 2d8a8f64a038..ac290f446c51 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1829,8 +1829,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
> >   	raw_spin_lock(&drvdata->spinlock);
> >   	idx = config->ss_idx;
> >   	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> > -	/* must clear bit 31 in related status register on programming */
> > -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> > +	/* must clear bit 31 and 30 in related status register on programming */
> > +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> >   	raw_spin_unlock(&drvdata->spinlock);
> >   	return size;
> >   }
> > @@ -1844,7 +1844,7 @@ static ssize_t sshot_status_show(struct device *dev,
> >   	struct etmv4_config *config = &drvdata->config;
> >   	raw_spin_lock(&drvdata->spinlock);
> > -	val = config->ss_status[config->ss_idx];
> > +	val = drvdata->ss_status[config->ss_idx];
> >   	raw_spin_unlock(&drvdata->spinlock);
> >   	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> >   }
> > @@ -1879,8 +1879,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
> >   	raw_spin_lock(&drvdata->spinlock);
> >   	idx = config->ss_idx;
> >   	config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
> > -	/* must clear bit 31 in related status register on programming */
> > -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> > +	/* must clear bit 31 and 30 in related status register on programming */
> > +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
> >   	raw_spin_unlock(&drvdata->spinlock);
> >   	return size;
> >   }
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > index ffde48b6b41b..8c1c1364b1c4 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > @@ -213,6 +213,7 @@
> >   #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
> >   #define TRCSSCSRn_STATUS			BIT(31)
> > +#define TRCSSCSRn_PENDING			BIT(30)
> 
> Minor nit - PENDING is ETE only - worth commenting in case a reader is
> looking at the ETMv4 spec.

Okay. I'll spell out.

> 
> 
> >   #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
> >   #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
> > @@ -730,6 +731,9 @@ static inline u32 etm4_res_sel_pair(u8 res_sel_idx)
> >   #define ETM_DEFAULT_ADDR_COMP		0
> >   #define TRCSSCSRn_PC			BIT(3)
> > +#define TRCSSCSRn_DV			BIT(2)
> > +#define TRCSSCSRn_DA			BIT(1)
> > +#define TRCSSCSRn_INST			BIT(0)
> 
> These new defs are redundant if the masking above is redundant

Acked. will remove this defines. 

Thanks!

[...]

-- 
Sincerely,
Yeoreum Yun
