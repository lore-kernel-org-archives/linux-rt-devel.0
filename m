Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A41C5CC2
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532693; cv=none; b=oBmQ8q/MLiW/1jVBLrQXYFnIwOZOExUcYtMXs2lvYFP+igl6EPM/MO4oMP5464Aim9KDQTtbOYVwA1yC5rvxaxoRJSqWqe9VITugBseSCmBlpLbCMW64kjR00jLyDoBzcOsvjc6KMsgEG8hzm28OmDNzFcVyvQB8r537QpVhkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532693; c=relaxed/simple;
	bh=1reKVDfr1mOGKGQD71+NlPRXqgpOEBkEDjuhK16R16U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXiwy8eWuEoctwxpsRIWg8mw5UIs6U1JbZQG3oWb4LqUsw3jwXXEcoFPMiDeTI0tbzGus8tQ5hyD9OgHyq6erMsIv1m5HoqpcU1fTezLfSno9i89LhkKOhLGtpp8pLYduOvvULD/xPHT9vcyyd3Bh6b1ec8nUknHE6t0YZPwTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZO6/ggq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZO6/ggq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434e3953b65so46430295e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 06:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734532689; x=1735137489; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HghZUTdW0XXbFLWN1muFrcSsQ1ZihgfgslndjD0QVzU=;
        b=MZO6/ggqigryXQ2KR4BSJuZw6X4JylbdqtF2dcURUc7yy2Qd4XehV+hjAzebJBQuIB
         U+Sp4ggPPX9L/74sOdGqI+O/iidM/paQGtlOQvQCKYnROYm/mSQsgafkKYEQQR88p4ax
         rv2nktVbVZ0+D71x79WvRYJBv+FP73C9SzcMw5xbobWAmH1Utl6Kxb4kB9S8atnKMYBJ
         CiPWAJpkEy1//yaLDsbpMCWf5KxudD7sAi0+tpJm2nyaiVGa1Rsxy5VBvE5FK1YBKzQH
         nSWhXwA8ITQjrmWFzAHn26Tsq1bif+sKwS78S/IcU/viasKg7lZETFtXAzzXAkfN3VFI
         rhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532689; x=1735137489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HghZUTdW0XXbFLWN1muFrcSsQ1ZihgfgslndjD0QVzU=;
        b=hQV/lRWrA3LpXzAnfFxeAkDVGCELfgOs9RvffMjUUHMNSatQME5eLMuVqovvsbZj3b
         /KTXAkMdc9j+UsbZU9vrYldJPImVjl/xZBz7C0Qzfn7FvpSjgoWkcOw1h9PIzr4BgHiN
         9pHIPfVKqyk3glKMC7p1vyWXvsYykiwIYCOMvVI3DfFuw38FMRwDvRENOKUw7Eg/Y3VY
         8PG8oJkXXgwQ64Ay+rClxe1XJ8G6ipJvHz6uvXmb71CIKm6vvK/kiw6zgp0g4yFyL1kG
         hRN/JW23cmP9HJyBxPzHJw1xe8lGxnb4Vj2X31oQQ9DqYg5at78ggRfgcced2WIyW286
         SviA==
X-Forwarded-Encrypted: i=1; AJvYcCU7fFvi5g7KVD75YXoZDv/9E5CFK+oHcTP6RtUuDIUoRY2iFW/Ds0MuDhCsZqS8Si5mQ1HrRnHWNS0uJ3RTTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSGtypoKsO2IcuT4bRFI5vEhtTD9wCa9IqMdU5GwVOIXQJrBBc
	s0rAbVtbGXhrLjilygJBqWT88tp1o/ZdEQCcu6RqG2WKAjOObl6UIfFmOiICB7w=
X-Gm-Gg: ASbGncvpY+HOds3YhQUw2hYzMyVXOwVx7LK1RLDg2S9WXLRoqvJEn7QhlhCDuMOQkQs
	We1rJ1rdBxpzxB9g5ODN0L9qXWc2AM/l6EFotpszqoxWg+x2LFrNqDAQfghDgaYvG3h81w0DPCt
	IKPvMVMjbbI7hNIKFIkxQ2KTJPfnCHyX2hXVuLIIdxAu2wdw5tZzI66lk/iQZn301StsmlmH513
	XAwUv/Bm8fUunFLxg692d4Az/TGhcKtRyayrN/M16TtOoLz5IEI9uZK+92b6m5s9/w=
X-Google-Smtp-Source: AGHT+IF+yf8lOXI6vWUd8PEcKXkFdISeBDrUKk8fn98+vBPawVSHM5et30l0PCEbj2o6tGQL7Xglig==
X-Received: by 2002:a05:600c:4586:b0:436:1c04:aa9a with SMTP id 5b1f17b1804b1-43655370395mr29857435e9.14.1734532689484;
        Wed, 18 Dec 2024 06:38:09 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804a34fsm14393947f8f.76.2024.12.18.06.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:38:08 -0800 (PST)
Message-ID: <7a370fb3-f5eb-4d6a-a42d-b43960efb930@linaro.org>
Date: Wed, 18 Dec 2024 14:38:07 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
To: Mike Leach <mike.leach@linaro.org>, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, nd@arm.com
References: <20241203114942.697188-1-yeoreum.yun@arm.com>
 <CAJ9a7Vis9vcdJOzu9tvNQ4eAacmXkbhbZBaRYd1acOrd8G-ZUQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7Vis9vcdJOzu9tvNQ4eAacmXkbhbZBaRYd1acOrd8G-ZUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/12/2024 1:44 pm, Mike Leach wrote:
> This change seems to omit devices:
> 
> etm3x - which provides support for ETMv3 and PTM, both of which are
> valid trace sources in the cs_etm handling code.
> stm - can be integrated into the kernel STM via configfs providing a
> MIPI source for ftrace.
> 
> Mike
> 

Isn't ETMv3 32 bit only? arm32 is still missing ARCH_SUPPORTS_RT so we 
could technically leave the spinlocks as is. It might be better to 
update them anyway though or add !PREEMPT_RT to 
CONFIG_CORESIGHT_SOURCE_ETM3X.

> On Tue, 3 Dec 2024 at 11:49, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>>
>> In some coresight drivers, drvdata->spinlock can be held during __schedule()
>> by perf_event_task_sched_out()/in().
>>
>> Since drvdata->spinlock type is spinlock_t and
>> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
>> which is raw_spinlock_t (an unsleepable lock),
>> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>>
>> To address this,change type drvdata->spinlock in some coresight drivers,
>> which can be called by perf_event_task_sched_out()/in(),
>> from spinlock_t to raw_spinlock_t.
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
>> v1 to v2:
>>      - seperate patchsets to change locktype and apply gurad API.
>>
>> Levi Yun (9):
>>    coresight: change coresight_device lock type to raw_spinlock_t
>>    coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
>>    coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
>>    coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
>>    coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
>>    coresight-funnel: change funnel_drvdata spinlock's type to
>>      raw_spinlock_t
>>    coresight-replicator: change replicator_drvdata spinlock's type to
>>      raw_spinlock_t
>>    coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
>>    coresight/ultrasoc: change cti_drvdata spinlock's type to
>>      raw_spinlock_t
>>
>>   .../hwtracing/coresight/coresight-config.c    |  21 +-
>>   .../hwtracing/coresight/coresight-config.h    |   2 +-
>>   drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>>   .../hwtracing/coresight/coresight-cti-core.c  |  65 +-
>>   .../hwtracing/coresight/coresight-cti-sysfs.c | 135 +++--
>>   drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>>   drivers/hwtracing/coresight/coresight-etb10.c |  62 +-
>>   .../coresight/coresight-etm4x-core.c          |  71 ++-
>>   .../coresight/coresight-etm4x-sysfs.c         | 566 +++++++++---------
>>   drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>>   .../hwtracing/coresight/coresight-funnel.c    |  34 +-
>>   .../coresight/coresight-replicator.c          |  36 +-
>>   .../hwtracing/coresight/coresight-syscfg.c    |  75 ++-
>>   .../hwtracing/coresight/coresight-tmc-core.c  |   9 +-
>>   .../hwtracing/coresight/coresight-tmc-etf.c   | 195 +++---
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 199 +++---
>>   drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>>   .../hwtracing/coresight/coresight-trace-id.c  |  93 ++-
>>   drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>>   drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>>   include/linux/coresight.h                     |   4 +-
>>   21 files changed, 751 insertions(+), 838 deletions(-)
>>
>> --
>> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>>
> 
> 

