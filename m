Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82CF1C84B8
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478996; cv=none; b=IWMxRxYKl57AUtLN8Eb9LLslIB30gsCQ+Ia9BnU1Lk7KZFdO2kZzijn0MTxcL2Qw4r6dKAKkncUKNiNi4S97YUp8sbBFQomiVAH5KwUYWJ37mo8b35sqRb+t1xUzY0QZR7s1H2heSE6DnwZ7ZER2Yieq4cqWPso7JVpGGs/nmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478996; c=relaxed/simple;
	bh=qKlWRtNrajd/YdtKpLrdrrnz1q6SGJXyGwZI/WrYG8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXbwMU/drAtuGrNFJIo5dKvTFe8axa8zMzL7OztHb5ZxvBb54F7KmC5GJCcVtB5XTWSYjiuqUHCWvIMz1mIlSThLYiPUuakmlLzLxE/Ytgf6i6tbGANdIBwScL2z+BG++e1kqbh95ADSrkQwAvdKWFbSS0RKZ+Q46pyMO/4ml9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7714C1516;
	Tue, 25 Feb 2025 02:23:30 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3BA43F6A8;
	Tue, 25 Feb 2025 02:23:12 -0800 (PST)
Message-ID: <6c00cf65-af68-49fb-b762-675186f45abe@arm.com>
Date: Tue, 25 Feb 2025 10:23:11 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>, james.clark@linaro.org,
 alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, mike.leach@linaro.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20241220104521.809071-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241220104521.809071-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Levi,

On 20/12/2024 10:45, Yeoreum Yun wrote:
> In some coresight drivers, drvdata->spinlock can be held during __schedule()
> by perf_event_task_sched_out()/in().
> 
> Since drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
> 
> To address this,change type drvdata->spinlock in some coresight drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

This doesn't apply cleanly on coresight next branch. Please could you 
rebase on coresight /next ?

Cheers
Suzuki


> 
> Yeoreum Yun (9):
>    coresight: change coresight_device lock type to  raw_spinlock_t
>    coresight-etm4x: change etmv4_drvdata spinlock type to  raw_spinlock_t
>    coresight: change coresight_trace_id_map's lock type to
>      raw_spinlock_t
>    coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
>    coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
>    coresight-funnel: change funnel_drvdata spinlock's type to
>      raw_spinlock_t
>    coresight-replicator: change replicator_drvdata spinlock's type to
>      raw_spinlock_t
>    coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
>    coresight/ultrasoc: change smb_drv_data spinlock's type to
>      raw_spinlock_t
> 
>   .../hwtracing/coresight/coresight-config.c    |   8 +-
>   .../hwtracing/coresight/coresight-config.h    |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>   .../hwtracing/coresight/coresight-cti-core.c  |  44 +--
>   .../hwtracing/coresight/coresight-cti-sysfs.c |  76 +++---
>   drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>   drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
>   .../coresight/coresight-etm4x-core.c          |  18 +-
>   .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
>   drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>   .../hwtracing/coresight/coresight-funnel.c    |  12 +-
>   .../coresight/coresight-replicator.c          |  12 +-
>   .../hwtracing/coresight/coresight-syscfg.c    |  26 +-
>   .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
>   .../hwtracing/coresight/coresight-tmc-etf.c   |  48 ++--
>   .../hwtracing/coresight/coresight-tmc-etr.c   |  40 +--
>   drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>   .../hwtracing/coresight/coresight-trace-id.c  |  22 +-
>   drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>   drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>   include/linux/coresight.h                     |   4 +-
>   21 files changed, 308 insertions(+), 308 deletions(-)
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

