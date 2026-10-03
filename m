Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AA378D8B
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007810; cv=none; b=tO/XBzD3Ua7tmeC+6nGbm9X7GfME4X/w17sT+256JcLroRvIqNNbYdEPvJxM3RgNc1DJ2KPQfPQRtUIDgCieDswbYHu16TnVtA6kD0T1rzBUoSI5YMBOSjfNk8x1dDGiT10N3BAfBs4DFxyGsnnGUpC/qw6EQ8wgifGw2HytF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007810; c=relaxed/simple;
	bh=Q88K6c2p+V4U9XzYzl+P/XsCq4/B0X4qU3qU4p8xVnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQtCz7uocrww+UY9HmRcxw5677ATtXxpEcFxDdqcyAj5KI4dUyWt5KuWqsXBVB0uKPjJ6WURh7b/0s4215no1yRM/n5AAV6dKf66++eNa63OqD18fxHWr8ADJs48fpBWjwTnez2uPDb3W37/zPQwg79oWg4kr5xY4e23QrrpvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tBT5G2DI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tBT5G2DI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D4B92F;
	Fri,  2 Oct 2026 23:10:04 -0700 (PDT)
Received: from [10.57.8.170] (unknown [10.57.8.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AFDB3F763;
	Fri,  2 Oct 2026 23:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791007807; bh=Q88K6c2p+V4U9XzYzl+P/XsCq4/B0X4qU3qU4p8xVnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tBT5G2DIgzL1ccv4x26BwoZyvujNVbTt5W37TYDCRmwiYao13lwP0PFQjLNauJOR4
	 vRLUNPJxU7ShBkFlhZNUM7Pdy/uoELx9psdqI+7X7QalRn0tvcrMALxJQ5e+5MPqsQ
	 0tIRFLNl8T0zEycDv284LDrqDn35ga4XBy9RtcnY=
Message-ID: <ed658964-bdf2-4258-946e-0fc115d33975@arm.com>
Date: Sat, 3 Oct 2026 07:10:01 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v13 03/14] coresight: etm3x: prohibit modifying
 cntr_val and reset while session is enabled
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
 <20261003-separate_etm_cfg_v2-v13-3-5d8a29aead95@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-3-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2026 03:52, Yeoreum Yun wrote:
> cntr_val are overwritten with the values read from the corresponding
> registers by etm_disable_hw() when the session is disabled.
> 
> This means that any changes to this value made while the session is
> enabled would be lost when the session is disabled.
> 
> Also, reset shouldn't be called while session is enabled.
> 
> Therefore, prohibit modifying cntr_val and reset while the session is enabled.
> 

Same as the other one, fixed subject and the above line

Cheers
Suzuki

> Reviewed-by: Mike Leach <mike.leach@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index b3c67e96a82a..cdb70a4382eb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -75,6 +75,10 @@ static ssize_t reset_store(struct device *dev,
>   	if (ret)
>   		return ret;
>   
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> +
>   	if (val) {
>   		spin_lock(&drvdata->spinlock);
>   		memset(config, 0, sizeof(struct etm_config));
> @@ -744,6 +748,9 @@ static ssize_t cntr_val_store(struct device *dev,
>   	ret = kstrtoul(buf, 16, &val);
>   	if (ret)
>   		return ret;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   
>   	spin_lock(&drvdata->spinlock);
>   	config->cntr_val[config->cntr_idx] = val;
> 

