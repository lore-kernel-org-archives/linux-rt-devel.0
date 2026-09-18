Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A651AED7
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751625; cv=none; b=J7ay6Kk0Z1v8Ll2J1xPPNPmncV8VId8TGiqtwDexuup6H6T3JEJoa8H4HTs6AU0rUmCO0IPN4UIH69zRxDdjWXY8m2U9RhMMXFZNpktZnu975EICgMO/g1z6502NOeMfcB7Gdm6qVkpUF41t9DcoIfdsoGEgLUK+KZY2kZel4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751625; c=relaxed/simple;
	bh=Ms/jqumPWYrvRGJTG/Z56F1Qz1M33gn7nBCRUOb6mZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD0Z5OXZ5fAXg/7U2MWOmh1N4GCNBJcCijfCS/pM6ODLOAPGdhgm3tSZ3ml++zHJJ/Bjoox/u8KK8yQdbRX7MBLGb5aM2UN7ljU6CJL61IFaEoJ5o5rflITHOW9TQzpLMNFw6H18e6OccTVBIiPvoQh06yCE9ModyQVYvGsjpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZI2WIGVe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZI2WIGVe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F98E1476;
	Fri, 18 Sep 2026 10:13:38 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA343F7B4;
	Fri, 18 Sep 2026 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789751622; bh=Ms/jqumPWYrvRGJTG/Z56F1Qz1M33gn7nBCRUOb6mZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZI2WIGVeKsjpXSuLN4NekACETWzSdvEbW6bU+lbT80oqWk2eN6JPChnAzU38env2t
	 o9HA/7oz8XVMVYKjSAXw3TRFyyOzh16i3hHJuZXWv14V7M8dbuGISU2IRkA6zGRy4u
	 M56Elq59nJfO5GfvUsdDQeEGCxoBbXq3vfkz8lX4=
Date: Fri, 18 Sep 2026 18:13:37 +0100
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
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v11 7/9] coresight: etm4x: exclude ss_status from
 drvdata->config
Message-ID: <aq1xQdJpylvhZmff@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
 <32d15bef-4ecd-45eb-8d4e-1a4276eb6e15@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d15bef-4ecd-45eb-8d4e-1a4276eb6e15@arm.com>

> Hi,
> 
> Actually replied to v10 of this patch before I spotted v11. I'll repeat the
> comments here to keep them together.

Yeap. I confirmed but thanks again ;)

> 
> 
> 
> On 9/15/26 12:34, Yeoreum Yun wrote:
> > The purpose of TRCSSCSRn register is to show status of
> > the corresponding Single-shot Comparator Control and input supports.
> > That means writable field's purpose for reset or restore from idle status
> > not for configuration.
> > 
> > Therefore, exclude ss_status from drvdata->config and move it to drvdata.
> > 
> > Before this patch, clearing the PENDING and STATUS bits when enabling
> > a perf session could trigger multiple single-shot events within
> > the same session. This issue will be addressed in a future patch;
> 
> The hardware is designed to have multiple single shot events - the reset bit
> in TRCSSCCRn specifically programs this behaviour.
> 
> But the basic point is correct there is no need to have the status register
> as part of the configurable set of registers.

Agree and Thanks for clarification!

> 
> 
> 
> > this patch intentionally preserves the existing behavior.
> > 
> > Reviewed-by: Leo Yan <leo.yan@arm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c  | 20 +++++++++-----------
> >   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
> >   drivers/hwtracing/coresight/coresight-etm4x.h       |  7 ++++++-
> >   4 files changed, 20 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > index d24f533c623d0..098aabd2b922c 100644
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
> > index 70a5c0b4fad1c..9de0c268ff954 100644
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
> > @@ -1162,12 +1162,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
> >   				 drvdata, 1);
> >   	/*
> > -	 * Userspace may read ss_status and cntr_val through sysfs after
> > +	 * Userspace may read cntr_val through sysfs after
> >   	 * the sysfs-session has been disabled.
> >   	 */
> > -	for (i = 0; i < caps->nr_ss_cmp; i++)
> > -		config->ss_status[i] = active_config->ss_status[i];
> > -
> >   	for (i = 0; i < caps->nr_cntr; i++)
> >   		config->cntr_val[i] = active_config->cntr_val[i];
> > @@ -1525,8 +1522,9 @@ static void etm4_init_arch_data(void *info)
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

There was some review for this whether RES0 versus clarifies the bit
we see. TBH, I tend to agree it's redundant. So I'll restore it.

Thanks!

> 
> >   	}
> >   	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
> >   	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index f6d053f73264c..50ef2e957300f 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1833,8 +1833,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
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
> > @@ -1848,7 +1848,7 @@ static ssize_t sshot_status_show(struct device *dev,
> >   	struct etmv4_config *config = &drvdata->config;
> >   	raw_spin_lock(&drvdata->spinlock);
> > -	val = config->ss_status[config->ss_idx];
> > +	val = drvdata->ss_status[config->ss_idx];
> >   	raw_spin_unlock(&drvdata->spinlock);
> >   	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> >   }
> > @@ -1885,8 +1885,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
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
> > index ffde48b6b41b2..8c1c1364b1c44 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > @@ -213,6 +213,7 @@
> >   #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
> >   #define TRCSSCSRn_STATUS			BIT(31)
> > +#define TRCSSCSRn_PENDING			BIT(30)
> 
> Minor nit - PENDING is ETE only - worth commenting in case a reader is
> looking at the ETMv4 spec.

Thanks. I'll add a little bit of comment!

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

+1

Thanks!

[...]

-- 
Sincerely,
Yeoreum Yun
