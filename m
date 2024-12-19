Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A41A2385
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611280; cv=none; b=HuLEu9op4hDSU8u4ry4uP4DKy+gljhobDPLfcq4Oif8RkYe5RJGnAB2nKet8kXLcubP7xmEeDMCHlYW3f8IuQQQVsXHEdPNFrCyl1PXzExJd628xb1D8zZSLWE3SyXzkcJH+mmqZPVD+4rY+EoBsci/B0fI2h9t1CbZY/XBBz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611280; c=relaxed/simple;
	bh=Y8mTEeIIJ6GKEG864RS98VrSAmc4pPrwLCmgKeY/91U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcB+v476YEquw4LD18ugwkPdEHlmHqRmqBPHmom3fTgM0SMDC/4roa0m49xMpxsq+di3SPojV/p+yw0meMoUThJCZYs4gK4WTNm1GPX1ANTxlILxsXRQ8L0EjkFwW+oLhPg91zbJwzHtzCVGJ3MSs9sFUWif3Hh0JApj7rpfUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cca8mkj3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cca8mkj3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166360285dso6325105ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611278; x=1735216078; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+G4RnOipPGTEyD7q6bqMNwoiHSF6nKA2Oy+mNN0MiQ=;
        b=cca8mkj3jOwG1RFIQNdafV6PECJBTDRPMx/rG8WA+CTlMgfJFLUIFyZ6fI2Sd6Yli9
         NOAffGMW1mdPJ51BF4BQBS6so2fpZrQE70Q1chBfUgOT8jinYSHIqfJSlVLypwKVhDZe
         r2po8UE4S18aFASwVMwQFX+9ooxdqF6j8M6xCihOEz2epip3voroJLHYOgRfN0wGq/cd
         6Qq5DDov95fqRCmihPD8+y9S5OG/M266Qtj8iu0dwvlUzY3NeQfeXEoimtop1oz7x29P
         7us5X7u2+O+FXH3lIFH33HfvyxZT0SLVIcH/22m522aVEKENF9ihLn1Jh0Poh7guLHZO
         mEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611278; x=1735216078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+G4RnOipPGTEyD7q6bqMNwoiHSF6nKA2Oy+mNN0MiQ=;
        b=Z5qKuHmjaQXZCpyJ2ypu90JqVRYSIwTvBemsGI9uqs9JyjVvDy6fVk1kpKw8rPblA8
         Xsyeq3MxDDW7vsgdrPbwbDqQAY5gAFpkMu/D34ujGJE3ianM3WlbG5Gkgzj/1cnGQPaE
         u09lkzPeopxEw8g3XtVnWARrjtHipE2bu5o40AdPMQFOFDmfDhBy4Q7UnCnmc0beZPs5
         ++JOF9urOOcJpjxH7qGt3jzKde37OqqgszHjqcD2HBvT7zP4IZG2DQpkGTWdkoQn+YpX
         w/IwDcRqCuw1hUGjryMiYjurvVJSPGhaK3en39zn7FIKtAI6FD+c93ieXXdBmNygCy10
         XdrA==
X-Forwarded-Encrypted: i=1; AJvYcCVCXHrA2F390g+LDikOj87znFX+LvfvAMgYTQueKPhp6ELlxLvjmpGePdqfXx3oFYrAvUvuc7lFF139Zdpw5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt+jWyxMQWqu+xh20pIXZssSYXtYMoI7KOG+npvusdJ4vFebWi
	p8I0FI+KYzp0baVrhCf5JwkHlU7utBRcGVbGxi7ESRcRPcRJpotSCZ6jPolMpU9aXbSlMJ/RQFp
	ArUek+ZHBu9EiAuAxxFlM3zc5ChR5DFBXCZ9IWw==
X-Gm-Gg: ASbGncsIhPRtMcK+AKurWkCTaYCHOMlPyzDygT7ND5vpYlYKbO9bRp9jH7OfEVuophw
	oOnetwIjUbWGM+EWI6Mai4NecFYewtFiy1gYjDvU=
X-Google-Smtp-Source: AGHT+IF25+bCsnh44Rs1BuWbDq3wwHppqFNiO2iYcxQwZpTeUDMqhwvZIXXNgbYCm6EGUjwyqFQPJqFyUIIpbLQ7emQ=
X-Received: by 2002:a17:902:e752:b0:216:70b6:8723 with SMTP id
 d9443c01a7336-218d726bce8mr82711205ad.44.1734611278280; Thu, 19 Dec 2024
 04:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-1-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:27:47 +0000
Message-ID: <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
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
>
> v2 to v3:
>     - Fix build error
>
> v1 to v2:
>     - seperate patchsets to change locktype and apply gurad API.
>
> Yeoreum Yun (9):
>   coresight: change coresight_device lock type to  raw_spinlock_t
>   coresight-etm4x: change etmv4_drvdata spinlock type to  raw_spinlock_t
>   coresight: change coresight_trace_id_map's lock type to
>     raw_spinlock_t
>   coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
>   coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
>   coresight-funnel: change funnel_drvdata spinlock's type to
>     raw_spinlock_t
>   coresight-replicator: change replicator_drvdata spinlock's type to
>     raw_spinlock_t
>   coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
>   coresight/ultrasoc: change cti_drvdata spinlock's type to
>     raw_spinlock_t
>
>  .../hwtracing/coresight/coresight-config.c    |   8 +-
>  .../hwtracing/coresight/coresight-config.h    |   2 +-
>  drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>  .../hwtracing/coresight/coresight-cti-core.c  |  44 +--
>  .../hwtracing/coresight/coresight-cti-sysfs.c |  76 +++---
>  drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
>  .../coresight/coresight-etm4x-core.c          |  18 +-
>  .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
>  drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>  .../hwtracing/coresight/coresight-funnel.c    |  12 +-
>  .../coresight/coresight-replicator.c          |  12 +-
>  .../hwtracing/coresight/coresight-syscfg.c    |  26 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  48 ++--
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  40 +--
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>  .../hwtracing/coresight/coresight-trace-id.c  |  22 +-
>  drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>  drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>  include/linux/coresight.h                     |   4 +-
>  21 files changed, 308 insertions(+), 308 deletions(-)
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Notably missing is the same changes for the etm3x driver. The ETMv3.x
and PTM1.x are supported by this driver, and these trace source
variants are also supported in perf in the cs_etm.c code.

STM is also missing, though this is not directly enabled via perf -
but could perhaps run concurrently as it can be a target output for
ftrace.

Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
