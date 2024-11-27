Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAB201258
	for <linux-rt-devel@lists.linux.dev>; Wed, 27 Nov 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725896; cv=none; b=i+AyuDwkF4/6jEOkT6ZKqBdN1acAqYtRySymTSFDGPTwjnb87uoe0DxOLBe/iNBDC8Y+ZEEQi7hj+9npayq3A5BCGyKXze+FPll2nhkJ2jhzbIrAsCX+To3izpFZqLCsi8NgrNkUeT0g0uMUD5F3YcBAarTC4Jf0pmSn0ZhX7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725896; c=relaxed/simple;
	bh=B0NJtAswW/ENp89+GUemsEmKD4nhWS8fdJGHlmvIv1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqlG8p5J5yvzcd2ZxL7Jj9fWpkv8xti8xmtrP7o24nR9bl4GBcVr8hNKFenLZruEb4BcY6z856J4lCBr/gH5M/KqZwALc4PW/G4pjMIYQQyMf4rDKwIZheLB++G17hjdhgJFMH6VRu0/ACpGtBYiPIN4Msj3WIXnH7nPiIJ9okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ep5TRTyb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ep5TRTyb"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df1e0641fso874564e87.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 27 Nov 2024 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732725893; x=1733330693; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fW8xExxeIKpIvS1coftBu84q3jUSvnzFCGKxsDAIRY4=;
        b=Ep5TRTybMx4pZZ9/d8MlXryschD0XjtCBtP+JYQPQXmExK1ySakH85EdUf0Zsq6/Kb
         kiDqjPdSHg1mI4zRMhjmub4pjbuTVMVoM56I5TV+c9HhO4TN8lN+6bzoukEDy2XpBJTb
         hCLGntf10wtQ2YLfmIq48Z+BsjKCXBgeAKfbShZC/d13mbyIKajGipfWZ8t/oB01Kgzq
         g5znuSMLRdWh8ZJneTOusW2W/kLDLrzf5udxsA5qAusgU+cn1GwnYndWml2uCaJnWQmK
         kg8Otvd66nA4DWeeddPhmsPPGhJQ/UivSF+cXd/rbTjv3Ym3/MQICWeH6J8NIR+/Rw7n
         h4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732725893; x=1733330693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW8xExxeIKpIvS1coftBu84q3jUSvnzFCGKxsDAIRY4=;
        b=hkWgEq1uWuKS75NHx0s+K+MYiXSF1UlDsPznFAhfVmTMjmYPRTGrdgfQ65/Oq4WQ60
         7Y9+TbL9yEir/vHotbhSNttsshiRy8KAE4TjpZ2/MAptGEBLz/rfd/0Fp4ecKfHm8851
         SfkG7/RREA3sBF8e2MRJL7qEx9o7B3eNZjF7u6yyashqxWInrWvTqw0RKUxxbGr6Ujed
         PixrmAycjTGazXGSQXU2eG5hJ8owUNUvqM19pYa9+e4eEk41XREeOdquXJhLRq34UheU
         e8kIZ3aPVK1fmBlpGTzAAZ1QnrrG+6IX0WflyogCrSjr9aYHdwStsPPEeRHPNjF1dr9K
         oU6g==
X-Forwarded-Encrypted: i=1; AJvYcCW7o0ZchyTzqFd265WCOvXB2vMR5XP+2GGCnWvdCenTz4K28x5hlPS+LWqlp/oZ6hwEi1MbqicDadZAxM+aUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiIaMOzCx2z3yKZZITomLkyrn8ExmSHBjv0wSuqonD9skIYjPK
	l/zr8/baLDT/qTcjOciS9gY1MevHSWhv1zWkozUtvVvO03Zipjm7lXGdDUP4dn0=
X-Gm-Gg: ASbGnctfmP6neKRWLu0jUJwjeyZo/ltqX/ycLt1LDvs+hoARtrIkQ4zDGkIlQLNedOL
	RrHscsy4/+ccDHUDvH/4O7r8SOyHZWxtBx9TYOs7ducHIxo2e4RF72FJ+OjoeYHBwwS2LDhV537
	0jV0I4+4qvdIbt0GrUXL8nDsqKYuQj1TgGWxAgjtdghbOGOz/6sOY4sg89xWgnSR9lE2U8ChbJw
	tJqR3nWPdlyI2ImCzzq3E4X3VQWQGMQVcjfrdiPTo6aGzBXY8WuGwv1VWle
X-Google-Smtp-Source: AGHT+IESX0M/mKeeOPEaJAvih6k+WhOExY781wFMg2q0kk+FhBaoTszX5Z/64SQGu7rfW5ScvTae1A==
X-Received: by 2002:a05:6512:2355:b0:53d:e5fd:a445 with SMTP id 2adb3069b0e04-53df00dd3ddmr2625559e87.32.1732725892585;
        Wed, 27 Nov 2024 08:44:52 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53a146fd0sm538629966b.143.2024.11.27.08.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 08:44:52 -0800 (PST)
Message-ID: <22ef761d-7a9c-46a2-8d61-3d16c2188c0c@linaro.org>
Date: Wed, 27 Nov 2024 16:44:50 +0000
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

Reviewed-by: James Clark <james.clark@linaro.org>

Somewhat related to this change, but not something that needs to be done 
now:

All of the spinlocks for the syfs store/read functions don't need to be 
raw spinlocks, or spinlocks at all. They're never called from the 
scheduling code and can be locked by coresight_mutex instead. 
coresight_mutex is held on the sysfs enable/disable path when those 
values are actually used.

Same point as here: 
https://lore.kernel.org/linux-arm-kernel/9a637e74-d81d-405c-bad0-c97ec1aa4b77@linaro.org/

Probably needs a review of which values in each device might be shared 
between perf mode and sysfs mode when they shouldn't be, as there was 
one in the link above.

I thought the only thing shared between sysfs and perf should be the 
'mode' which is taken with a compare and swap without locking anyway.

