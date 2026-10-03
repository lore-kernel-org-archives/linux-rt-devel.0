Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFF344DAA
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007674; cv=none; b=kNX3cfAWPxPBZf6LiHdSp34Acb/p1f7oQa5nKLjzBNhutY1juoem0Ex+NtSUg1fvZ9MPb1v/N8VE9ULfkKsIaSrPW1uVgAqhtE94Bhxc4ITZm+pskl0oWR3sdld4L64g/xU2xHbliFniptN3//LwzpFKyE51mBmoMLHbqGU1UmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007674; c=relaxed/simple;
	bh=wa4AOlE/1uBwYq+kAPl6VeapNdrQNjEjASltYH2rCe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clbFE9Y+ZFBmsNPYT1g8hs/9v/bcbwcNDnDbuqMV6tVbmJ/sb+6S4EiU4k8d5F4OkRnvkxYtnNRLVpEEZWECm1g85IsfjRy5TUKMy+ubk+9hU9MNhe6m26JSkxrtd43wgCkvvBdl1JndSMVeIIoXFEc62qzNemmgOPCTmgNC/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cKtNs0Ad; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cKtNs0Ad"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6E72F;
	Fri,  2 Oct 2026 23:07:48 -0700 (PDT)
Received: from [10.57.8.170] (unknown [10.57.8.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 083CD3F763;
	Fri,  2 Oct 2026 23:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791007672; bh=wa4AOlE/1uBwYq+kAPl6VeapNdrQNjEjASltYH2rCe4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cKtNs0Ad+gPzljAYfBw3MY8W50cx+46/M1zvmGn4FNCRcFRoJGGsIjbi97XNkrpL/
	 TdIj29XCbK5Zi3bYlIgkm1XVxAAo3J8Q0Dm0qeJNVx7+hxO8kiGff/M7uJGgtrbQav
	 EQCkJy/sz4j8VaS7pTcdFjNm0Hb0tk0iIHenhGBI=
Message-ID: <beae08c7-798b-4314-8335-5303af23d513@arm.com>
Date: Sat, 3 Oct 2026 07:07:42 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v13 01/14] coresight: etm4x: read-back TRCSEQSTR at
 disabling and prohibit modifying seq_state while enabling.
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
 <20261003-separate_etm_cfg_v2-v13-1-5d8a29aead95@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-1-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Levi


Please run checkpatch on your submissions.

The subject is too long, I have changed that to :

coresight: etm4x: Prohibit TRCSEQSTR modifications while tracing enabled

On 03/10/2026 03:52, Yeoreum Yun wrote:
> TRCSEQSTR can be changed by the ETM while a session is active. Its value
> therefore needs to be preserved when a sysfs session is disabled so that
> users can read the current sequence state after the session ends.
> 
> This means that any changes made to TRCSEQSTR while the sysfs-session is active

Please stick to 75 spaces. I have fixed this up.

Cheers
Suzuki

> would be lost when the session is disabled.

> 
> Copy the TRCSEQSTR value when disabling a sysfs session, and prohibit
> modifying seq_state while the session is active.
> 
> Suggested-by: Mike Leach <mike.leach@arm.com>
> Reviewed-by: Mike Leach <mike.leach@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c  | 4 ++++
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 2247ad55d444..9ca03a5913a3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1073,6 +1073,10 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
>   	}
>   
> +	/* read back the sequence state */
> +	if (drvdata->nrseqstate)
> +		config->seq_state = etm4x_relaxed_read32(csa, TRCSEQSTR);
> +
>   	coresight_disclaim_device_unlocked(csdev);
>   	etm4_cs_lock(drvdata, csa);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index cc6cdd3ae29d..4945d577ceab 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1435,6 +1435,8 @@ static ssize_t seq_state_store(struct device *dev,
>   
>   	if (kstrtoul(buf, 16, &val))
>   		return -EINVAL;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) || coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
>   	if (val >= drvdata->nrseqstate)
>   		return -EINVAL;
>   
> 

