Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD392749C1
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791008103; cv=none; b=jVYSFe3VYc9a3s3UT8m4q5t1t3pnTIssKDs/wknzzHpdDDwVi+J5v5u5QaZP0Sc205n6m2KrSvZPbcCO5sVzbAbaT4Y1d2rBU74D3Mh17hPjFTrshw63oMOLkKXfMv/Xe2mdkyGpGL9hcT+bAXX6n8UEXD6QgQPrspr9klFc+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791008103; c=relaxed/simple;
	bh=s9kZFHSbYH6xxZ+wa5s4OBi/IcF5OqKTelx1jTCneng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtF+uJFf7BsTQ2bqq6mk/Kef3YoJsPcNQAOsqKSxUhctAZ8WTJ8K06uA8wTNolVNLgf/xTxwhf6NLVgW/KTD4jisTZLvE+GAj/7CxE63YTvB+jCD0r/1mmoPumkd+IKl1LFzFVc8QWxHFFUh3ys003OR/25W/E00gizFw86peW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tdtWMj+0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tdtWMj+0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B882F;
	Fri,  2 Oct 2026 23:14:51 -0700 (PDT)
Received: from [10.57.8.170] (unknown [10.57.8.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 368623F763;
	Fri,  2 Oct 2026 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791008094; bh=s9kZFHSbYH6xxZ+wa5s4OBi/IcF5OqKTelx1jTCneng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tdtWMj+0nuZSaf8XobqRh11x8o4DDSjMezQMDxSv3tUScWLMx2YWZsTGGMFzxdm1B
	 zc0pv6czqwvYPwO/H5zIVh9Hr3gmpCO2R1pTBCeYj+vajVLL6cglw+3dkvI00/D80q
	 g0HhUmuOZtQE2a1MzQXzMmilOQtvNL1gmNokuII8=
Message-ID: <5ea4d985-d0ae-46a8-ad01-2ef6999f9ad2@arm.com>
Date: Sat, 3 Oct 2026 07:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v13 09/14] coresight: etm4x: remove s_ex_level from
 config
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, Mike Leach <mike.leach@arm.com>,
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-9-5d8a29aead95@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-9-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2026 03:52, Yeoreum Yun wrote:
> s_ex_level is a hardware capability rather than a configurable parameter.
> As such, it should not be stored in the configuration structure.
> 
> Remove s_ex_level from the config structure and pass etm4_caps to the

Checkpatch complains:

ERROR: code indent should use tabs where possible
#74: FILE: drivers/hwtracing/coresight/coresight-etm4x-core.c:1569:
+^I^I^I           const struct etmv4_caps *caps)$

ERROR: code indent should use tabs where possible
#83: FILE: drivers/hwtracing/coresight/coresight-etm4x-core.c:1576:
+^I^I^I            const struct etmv4_caps *caps)$

I have fixed them locally.

Cheers
Suzuki

> functions that need to access this capability.
> 
> Reviewed-by: Mike Leach <mike.leach@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 58 +++++++++++++---------
>   .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  2 +-
>   drivers/hwtracing/coresight/coresight-etm4x.h      |  5 +-
>   3 files changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4a8c1070bbcb..99d4e2d39e66 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -66,10 +66,12 @@ MODULE_PARM_DESC(pm_save_enable,
>   	"Save/restore state on power down: 1 = never, 2 = self-hosted. MMIO and DT only.");
>   
>   static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
> -static void etm4_set_default_config(struct etmv4_config *config);
> +static void etm4_set_default_config(struct etmv4_config *config,
> +				    const struct etmv4_caps *caps);
>   static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   				  struct perf_event *event);
> -static u64 etm4_get_access_type(struct etmv4_config *config);
> +static u64 etm4_get_access_type(struct etmv4_config *config,
> +				const struct etmv4_caps *caps);
>   
>   static enum cpuhp_state hp_online;
>   
> @@ -800,7 +802,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>   		config->mode |= ETM_MODE_EXCL_GUEST;
>   
>   	/* Always start from the default config */
> -	etm4_set_default_config(config);
> +	etm4_set_default_config(config, caps);
>   
>   	/* Configure filters specified on the perf cmd line, if any. */
>   	ret = etm4_set_event_filters(drvdata, event);
> @@ -1474,7 +1476,6 @@ static void etm4_init_arch_data(void *info)
>   
>   	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>   	caps->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
> -	drvdata->config.s_ex_level = caps->s_ex_level;
>   	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
>   	caps->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
>   	/*
> @@ -1557,19 +1558,22 @@ static void etm4_init_arch_data(void *info)
>   	cpu_detect_trace_filtering(drvdata);
>   }
>   
> -static u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> +static u32 etm4_get_victlr_access_type(struct etmv4_config *config,
> +				       const struct etmv4_caps *caps)
>   {
> -	return etm4_get_access_type(config) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
> +	return etm4_get_access_type(config, caps) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
>   }
>   
>   /* Set ELx trace filter access in the TRCVICTLR register */
> -static void etm4_set_victlr_access(struct etmv4_config *config)
> +static void etm4_set_victlr_access(struct etmv4_config *config,
> +			           const struct etmv4_caps *caps)
>   {
>   	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
> -	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
> +	config->vinst_ctrl |= etm4_get_victlr_access_type(config, caps);
>   }
>   
> -static void etm4_set_default_config(struct etmv4_config *config)
> +static void etm4_set_default_config(struct etmv4_config *config,
> +			            const struct etmv4_caps *caps)
>   {
>   	/* disable all events tracing */
>   	config->eventctrl0 = 0x0;
> @@ -1588,7 +1592,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
>   	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
>   
>   	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
> -	etm4_set_victlr_access(config);
> +	etm4_set_victlr_access(config, caps);
>   }
>   
>   static u64 etm4_get_ns_access_type(struct etmv4_config *config)
> @@ -1620,21 +1624,24 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>    * This must be shifted to the corresponding register field
>    * for usage.
>    */
> -static u64 etm4_get_access_type(struct etmv4_config *config)
> +static u64 etm4_get_access_type(struct etmv4_config *config,
> +				const struct etmv4_caps *caps)
>   {
>   	/* All Secure exception levels are excluded from the trace */
> -	return etm4_get_ns_access_type(config) | (u64)config->s_ex_level;
> +	return etm4_get_ns_access_type(config) | (u64)caps->s_ex_level;
>   }
>   
> -static u64 etm4_get_comparator_access_type(struct etmv4_config *config)
> +static u64 etm4_get_comparator_access_type(struct etmv4_config *config,
> +					   const struct etmv4_caps *caps)
>   {
> -	return etm4_get_access_type(config) << TRCACATR_EXLEVEL_SHIFT;
> +	return etm4_get_access_type(config, caps) << TRCACATR_EXLEVEL_SHIFT;
>   }
>   
>   static void etm4_set_comparator_filter(struct etmv4_config *config,
> +				       const struct etmv4_caps *caps,
>   				       u64 start, u64 stop, int comparator)
>   {
> -	u64 access_type = etm4_get_comparator_access_type(config);
> +	u64 access_type = etm4_get_comparator_access_type(config, caps);
>   
>   	/* First half of default address comparator */
>   	config->addr_val[comparator] = start;
> @@ -1665,11 +1672,12 @@ static void etm4_set_comparator_filter(struct etmv4_config *config,
>   }
>   
>   static void etm4_set_start_stop_filter(struct etmv4_config *config,
> +				       const struct etmv4_caps *caps,
>   				       u64 address, int comparator,
>   				       enum etm_addr_type type)
>   {
>   	int shift;
> -	u64 access_type = etm4_get_comparator_access_type(config);
> +	u64 access_type = etm4_get_comparator_access_type(config, caps);
>   
>   	/* Configure the comparator */
>   	config->addr_val[comparator] = address;
> @@ -1701,7 +1709,8 @@ static void etm4_set_default_filter(struct etmv4_config *config)
>   	config->vissctlr = 0x0;
>   }
>   
> -static void etm4_set_default(struct etmv4_config *config)
> +static void etm4_set_default(struct etmv4_config *config,
> +			     const struct etmv4_caps *caps)
>   {
>   	if (WARN_ON_ONCE(!config))
>   		return;
> @@ -1713,7 +1722,7 @@ static void etm4_set_default(struct etmv4_config *config)
>   	 * full instruction trace - with a default filter for trace all
>   	 * achieved by having no filtering.
>   	 */
> -	etm4_set_default_config(config);
> +	etm4_set_default_config(config, caps);
>   	etm4_set_default_filter(config);
>   }
>   
> @@ -1761,6 +1770,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   {
>   	int i, comparator, ret = 0;
>   	u64 address;
> +	const struct etmv4_caps *caps = &drvdata->caps;
>   	struct etmv4_config *config = &drvdata->curr_config;
>   	struct etm_filters *filters = event->hw.addr_filters;
>   
> @@ -1790,7 +1800,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   
>   		switch (type) {
>   		case ETM_ADDR_TYPE_RANGE:
> -			etm4_set_comparator_filter(config,
> +			etm4_set_comparator_filter(config, caps,
>   						   filter->start_addr,
>   						   filter->stop_addr,
>   						   comparator);
> @@ -1811,7 +1821,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   				   filter->stop_addr);
>   
>   			/* Configure comparator */
> -			etm4_set_start_stop_filter(config, address,
> +			etm4_set_start_stop_filter(config, caps, address,
>   						   comparator, type);
>   
>   			/*
> @@ -1847,7 +1857,8 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
>   	return ret;
>   }
>   
> -void etm4_config_trace_mode(struct etmv4_config *config)
> +void etm4_config_trace_mode(struct etmv4_config *config,
> +			    const struct etmv4_caps *caps)
>   {
>   	u32 mode;
>   
> @@ -1861,7 +1872,7 @@ void etm4_config_trace_mode(struct etmv4_config *config)
>   	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
>   		return;
>   
> -	etm4_set_victlr_access(config);
> +	etm4_set_victlr_access(config, caps);
>   }
>   
>   static int etm4_online_cpu(unsigned int cpu)
> @@ -2173,6 +2184,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>   	struct coresight_platform_data *pdata = NULL;
>   	struct device *dev = init_arg->dev;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +	const struct etmv4_caps *caps = &drvdata->caps;
>   	struct coresight_desc desc = { 0 };
>   	u8 major, minor;
>   	char *type_name;
> @@ -2202,7 +2214,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>   	if (!desc.name)
>   		return -ENOMEM;
>   
> -	etm4_set_default(&drvdata->config);
> +	etm4_set_default(&drvdata->config, caps);
>   
>   	if (etm4x_always_pm_save(dev, init_arg->csa))
>   		pm_save = true;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 9dd60fa67ef1..aa3deb15ba96 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -443,7 +443,7 @@ static ssize_t mode_store(struct device *dev,
>   		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
>   
>   	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
> -		etm4_config_trace_mode(config);
> +		etm4_config_trace_mode(config, caps);
>   
>   	raw_spin_unlock(&drvdata->spinlock);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 67071f7cbdbc..ae97c5c004bf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -956,7 +956,6 @@ struct etmv4_caps {
>    * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
>    * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
>    * @ext_inp:	External input selection.
> - * @s_ex_level: Secure ELs where tracing is supported.
>    */
>   struct etmv4_config {
>   	u64				mode;
> @@ -999,7 +998,6 @@ struct etmv4_config {
>   	u32				vmid_mask0;
>   	u32				vmid_mask1;
>   	u32				ext_inp;
> -	u8				s_ex_level;
>   };
>   
>   /**
> @@ -1117,7 +1115,8 @@ enum etm_addr_ctxtype {
>   };
>   
>   extern const struct attribute_group *coresight_etmv4_groups[];
> -void etm4_config_trace_mode(struct etmv4_config *config);
> +void etm4_config_trace_mode(struct etmv4_config *config,
> +			    const struct etmv4_caps *caps);
>   
>   u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
>   void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);
> 

