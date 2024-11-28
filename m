Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF41917E4
	for <linux-rt-devel@lists.linux.dev>; Thu, 28 Nov 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791364; cv=none; b=FaTfaE4y+dYa9ihBytSdH44lfIGaRjSYVi/MiZtznBFD1snQy8pvY5GiEyWa35cBqj/pNdx9kfWhQzxv0UXukYZ61tIXCrxDDEnI0GGlsEO4W4njzHdE2spmbXERtbW+fu1acaUc8l38leFsHRYSDeuGxrqU2HmSNg5cHapEQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791364; c=relaxed/simple;
	bh=sNl8pXR3Ebgfz60+ljXMS9IQkAzupjib/Jfyu0z6Yps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ps7+iVB6nY0mx1o0F9M6CC+hEZvl0tspDHfIs8Bxy7SpZJrtVBGowiOZRTpITJZ+aMSt6GScgRd6dOTnyTjL16nUCSmd/VkiEErHhfAZ8/BL7xt9N3u/wIEu46xfGCK96sIXBumtFTtXUiuRfDsiiuiklfrXl05pJFq7pyJC9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQMcQmAU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQMcQmAU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1328266a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 28 Nov 2024 02:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732791361; x=1733396161; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqpsi2rhTNaEAfBxryPApXcrOr2+7ywjD7Fk+1YK40o=;
        b=OQMcQmAUXNL2n8rTIM8dgdr63scghRxlzXM5uu+7S5dbFeprLeo8m3drZGX2FUcFSt
         kCE+wh07i/P6Fp/WnPqiltc9GSEEyvmzFMZ/0MvuBfdqzNeI649p2Un+JR1qO/iWOn9v
         uBgKekMuFnM1/drYYszTW95vMurO/3+n12bvxHfEsbAjr7oFGbnuSpDI2oILLT767O7z
         uAAz53IIcNZjdMinvjEiPxuo1va5c/yyG7ZIhFp69RG6kXREsvWEdq1hAI4FMSqGkm96
         XNG7S1Q88OcWFoACzRJ+omxV44Epkjov/GqgS1l+Y3GLWEVh/mLv7p0/XOBDCWKZa7Bi
         hocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791361; x=1733396161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqpsi2rhTNaEAfBxryPApXcrOr2+7ywjD7Fk+1YK40o=;
        b=WcXNsCzfFiVlSyTvK6dLtEqf4Tk+VdhlcF0umHyC02GDTtrFuhfaAjF2YXaPwR5Hpg
         RAqZFeqK2HxZVIloNpSgmlFy1khqkOXW3Jf58cuQDo0PRIc8AHdrehaz5khxOBEdQlv8
         V23VtkglDu5AmRO9P0QI0K6hImx2pGKqNMhLkdwB6GvTTt/lS3GAsjQpVv27R0SR/m7i
         18fgT+IngQSyfwqLpq7HTxzTNoSR/WrUucAuQNvBZkyYexpP3+PQMSQbTFQhs0a4e21A
         97REK1lsODqcloxL42wOaJ+l6YyCVtaoSBL4sgkTmrfqy7NjqZCYXVPvf79VkSUWpLli
         gcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpHXRNwj7FinFZ59Uh/m8udxLGX26HHX0devZnECcpbeSguXRnUpkRv1BIqXdS2ZQ2EJh5bou/S3xEZoVaLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1Z+wrRf04M1prTGUBNSgYBNbdyjDqpJUblsrBf0gf4FPVDZH9
	EzOFxAGAK9ulmMXUtY79W9ZXONTZ1pp2L3v5HPV6DuoCgw0i4Z2MTz8IuTKKFGQ=
X-Gm-Gg: ASbGnctlJy1RK+GWlDIUyP5HXfsKkL03LX47OprjCpNUY8TfWp4vHyNzyWYw2W2Rkiv
	zssRlf3K4ZoGNOajLeTbJM0+mYGeAIx3jRqVTsQDqWIFKceu2CE2bCoLeIqHLq2r24OENSQjyDg
	2QUik/pkqqnCDbs/bcashRHJnDffA/lesdw0HBmMJqY2DfeY8uFrw8aE/c2xHeRsIID2DYrzdEQ
	R3q9lGy6s1sHa1tcNrt1O0NUmQ50dGpJLFcBVub2ZZq2M7udTZjyVSgfYPu
X-Google-Smtp-Source: AGHT+IEnjxh9ZBhFyGvzawlD+/dtL6pKTEdS19cAB25msc9FJ2UvOItsJK1YudpESRUS0TPKtq58ow==
X-Received: by 2002:a05:6402:510b:b0:5d0:96db:dd96 with SMTP id 4fb4d7f45d1cf-5d096dbe865mr1728463a12.0.1732791361409;
        Thu, 28 Nov 2024 02:56:01 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8dcfasm626237a12.67.2024.11.28.02.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 02:56:00 -0800 (PST)
Message-ID: <6468302c-f1f1-4edb-a6b6-ca248944cbbf@linaro.org>
Date: Thu, 28 Nov 2024 10:55:58 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>, suzuki.poulose@arm.com,
 mike.leach@linaro.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, nd@arm.com,
 alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241125094816.365472-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/11/2024 9:48 am, Yeoreum Yun wrote:
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
> Levi Yun (9):
>    coresight: change coresight_device lock type to raw_spinlock_t
>    coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
>    coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
>    coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
>    coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
>    coresight-funnel: change funnel_drvdata spinlock's type to
>      raw_spinlock_t
>    coresight-replicator: change replicator_drvdata spinlock's type to
>      raw_spinlock_t
>    coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
>    coresight/ultrasoc: change cti_drvdata spinlock's type to
>      raw_spinlock_t
> 
>   .../hwtracing/coresight/coresight-config.c    |  21 +-
>   .../hwtracing/coresight/coresight-config.h    |   2 +-
>   drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>   .../hwtracing/coresight/coresight-cti-core.c  |  65 +-
>   .../hwtracing/coresight/coresight-cti-sysfs.c | 135 +++--
>   drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>   drivers/hwtracing/coresight/coresight-etb10.c |  62 +-
>   .../coresight/coresight-etm4x-core.c          |  71 ++-
>   .../coresight/coresight-etm4x-sysfs.c         | 566 +++++++++---------
>   drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>   .../hwtracing/coresight/coresight-funnel.c    |  34 +-
>   .../coresight/coresight-replicator.c          |  36 +-
>   .../hwtracing/coresight/coresight-syscfg.c    |  75 ++-
>   .../hwtracing/coresight/coresight-tmc-core.c  |   9 +-
>   .../hwtracing/coresight/coresight-tmc-etf.c   | 195 +++---
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 199 +++---
>   drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>   .../hwtracing/coresight/coresight-trace-id.c  |  93 ++-
>   drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>   drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>   include/linux/coresight.h                     |   4 +-
>   21 files changed, 751 insertions(+), 838 deletions(-)
> 
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

Can TPIU be used as a sink with Perf? If so that one is missing the update.

Makes me wonder if something like a "perf_component" flag in 
coresight_device or a #define would make sense. Then the lock type gets 
auto picked. Seems like in a few years we will have completely forgotten 
why some of the coresight locks are raw and others aren't.

