Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163FF41C92
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Mar 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256743; cv=none; b=qQWtoH8B0nMqL/2wP/RMqRtSYx4epptmNFwJlH8Azc7GOoiIef3NJQIAFpWjyNbZqhE5OLR/WX1/o/b/J5ikiPxjdiIU4OnvyA3GTu0VsMve+w8aL4ZZL1RY1meSjSxPX1OF9xEWk/28TZrnBASWVjvEoEB+tSyiuq5OreP4DiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256743; c=relaxed/simple;
	bh=9Iy1vxwzlKdINfMnixt4K0ILolOToVWO7GfNZe4JiQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmzAAeyzfLGvJ1j9T4NCc3JpV9beWdov4U/vMVsXZtidF/zgLVenpZ8xLBzbA+n2+PSShk5XmIx2dOanan4G+Eub8OSCZ95CY51I8a9xWYVrbezat0oyh++zqI47Wu1m/cjyhZBB66LEF4uQy8HceVVKGQrDBV0Qya8Mw+lT3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B0DFEC;
	Thu,  6 Mar 2025 02:25:53 -0800 (PST)
Received: from [10.57.38.145] (unknown [10.57.38.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC8053F66E;
	Thu,  6 Mar 2025 02:25:38 -0800 (PST)
Message-ID: <c7a142ee-d34f-494a-b4f9-921d739aeb59@arm.com>
Date: Thu, 6 Mar 2025 10:25:37 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] coresight-tmc: change tmc_drvdata spinlock's type
 to raw_spinlock_t
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, mike.leach@linaro.org,
 james.clark@linaro.org, alexander.shishkin@linux.intel.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250306094800.1082950-1-yeoreum.yun@arm.com>
 <20250306094800.1082950-9-yeoreum.yun@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250306094800.1082950-9-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Levi,

On 06/03/2025 09:47, Yeoreum Yun wrote:
> In coresight-tmc drivers, tmc_drvdata->spinlock can be held
> during __schedule() by perf_event_task_sched_out()/in().
> 
> Since tmc_drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
> 
> To address this, change type tmc_drvdata->spinlock in coresight-tmc drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>


Unfortunately, this still doesn't cover the current coresight next 
branch. I get build errors as below :

"[PATCH] coresight-tmc: change tmc_drvdata spinlock's type to" has style 
problems, please review. This is because, we merged the coresight panic
trace support in the coresight next, on 21st Feb.


NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
   CALL    scripts/checksyscalls.sh
   CC [M]  drivers/hwtracing/coresight/coresight-tmc-core.o
   CC [M]  drivers/hwtracing/coresight/coresight-tmc-etf.o
   CC [M]  drivers/hwtracing/coresight/coresight-tmc-etr.o
   CC [M]  drivers/hwtracing/coresight/coresight-catu.o
In file included from ./include/linux/mmzone.h:8,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/slab.h:16,
                  from ./include/linux/resource_ext.h:11,
                  from ./include/linux/acpi.h:13,
                  from drivers/hwtracing/coresight/coresight-tmc-core.c:7:
drivers/hwtracing/coresight/coresight-tmc-core.c: In function 
‘tmc_crashdata_open’:
drivers/hwtracing/coresight/coresight-tmc-core.c:361:20: error: passing 
argument 1 of ‘spinlock_check’ from incompatible pointer type 
[-Werror=incompatible-pointer-types]
   361 |  spin_lock_irqsave(&drvdata->spinlock, flags);
       |                    ^~~~~~~~~~~~~~~~~~
       |                    |
       |                    raw_spinlock_t * {aka struct raw_spinlock *}
./include/linux/spinlock.h:244:34: note: in definition of macro 
‘raw_spin_lock_irqsave’
   244 |   flags = _raw_spin_lock_irqsave(lock); \
       |                                  ^~~~
drivers/hwtracing/coresight/coresight-tmc-core.c:361:2: note: in 
expansion of macro ‘spin_lock_irqsave’
   361 |  spin_lock_irqsave(&drvdata->spinlock, flags);
       |  ^~~~~~~~~~~~~~~~~
In file included from ./include/linux/mmzone.h:8,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/slab.h:16,
                  from ./include/linux/resource_ext.h:11,
                  from ./include/linux/acpi.h:13,
                  from drivers/hwtracing/coresight/coresight-tmc-core.c:7:
./include/linux/spinlock.h:324:67: note: expected ‘spinlock_t *’ {aka 
‘struct spinlock *’} but argument is of type ‘raw_spinlock_t *’ {aka 
‘struct raw_spinlock *’}
   324 | static __always_inline raw_spinlock_t 
*spinlock_check(spinlock_t *lock)


Cheers
Suzuki

