Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE61B0405
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529497; cv=none; b=aLthu1aqNES54vtzn/fjzyjOJSwXaurZs3Jr3yZZTFC+fF48qcM+ImqEAX3KvQOScziCMYrTYW6PV/oIEZ2LVwnyU4FD0bWmFqbfYtPazQAmBy15MFcGd0S8Z7inQ5QAhQ0fwqNKnbjicrHZ0dN5+1DnlhckBE45i0eQFaJTprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529497; c=relaxed/simple;
	bh=5D5ZajUSqd3YMPRYo/gLcYdWA4nSjemjjidDW8W9C1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euhhIKtRRDdytVreus4f27wgYQmTUZODQnQmqon2Xf65ROM9HZVUSEgPvdUewLbOSeQo7M6TfxCTHLZyb/xPq/DI9SgXuDE7vofEZcECunq9U8SnMxkToQI5hwtx2pNdAxAy2dGvth93LEx1MzIwjT/44e/FQtibra2R4KLHlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2lUfX11; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2lUfX11"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f4623df7so5845404b3a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Dec 2024 05:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734529494; x=1735134294; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ul3jV26q/OyEv82Q0FmpZheBVp/UPEqN3sZqLd2am5k=;
        b=F2lUfX11fZxm5n3ncWS/MkfhHuWMzjGyWeG2s8hitAa+EjPYUftcc7oUr7Pl14M3DN
         H3BJG1rrUUU+N2iBpeHbd3pwPY6BouocaQXTOhhy6XAly16NBefyK8/q08jTgsy9yNI0
         rXrccbm7o+jgOl8eicWUuAnmL1s/m9ypTfY2pW0ySejNOSVzAs2O/hhPD7lmAzrrKMtP
         oEQZmriF98KL7lfhuonEzTAJuya9CohMKtt0H/m8+lfX8RefnOR7UQSBloj/x1Xf1MYa
         HfiZ3EQTFoyCfZpTNN5hlAErjJI8Zh0DU4fjHX7qz5CTH9r6yM67EtlCW7F2Dvk9aiKv
         OA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734529494; x=1735134294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul3jV26q/OyEv82Q0FmpZheBVp/UPEqN3sZqLd2am5k=;
        b=SN6AoV+lqoSJfIhU+MI20eNg050UJw4Cy4xgD6dH8+WeQQBVXWfTkU6M2dRHeYRf+N
         epV5xyKn3rV/l2JZTlT7Hz0yRvY7Ho+SDwThT531bGDwRM+S+t1HmptiEekf2J5y7B7J
         LvgMPxgFss5nCWhX8eVt5bFomevSj7UVRib92ffxQ/AOoUGhyKOJTzoL27P9b2TQ5rHv
         HnYhC9a/8Lrtos05hqydP21WFLp4JRHxkkqbpQdV4aIaJc0fFbcO49Ux8FznieGLCNFQ
         VmeP96m4z2yWq+2jIPtkB2yd0eDgJqo9tZx54dgilGVrTIb015QKxuNMFo0aMv1lmElP
         KMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4MDMmTcgxlVvYOodMjl7K9iim8naumX7niBTeFiqcvdVTzVeGwwQD2Ixa/N36K1ZNZbXs8S+jlOdqpT47w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxENgbFErpJi3K7QzdL/uSCBgSmRo2vzW6Izwd4YRJmunCcXO2
	Ay44Z1wCgnkHRwZBQbhh3e+FoVL/FvviX1XSsaiqHMLpfpp9p/NnrlawDfjSzKCj9TaRiTJq0gJ
	hANqqBkw9ZaVk/HL334ge1BugdXV/YElWGiN3ZQ==
X-Gm-Gg: ASbGncsTVe9j/VFt4/wdRjIjGy2olV7q8d5J2k6bYiUtdFmpydu3JDlsDlXIMaXISBn
	zHWfgWP1sCnFWJEKfXlaxwhTHd9/kDBeRX5MXPWE=
X-Google-Smtp-Source: AGHT+IGsoXTWsZd2EEH9lplUvC3+MNK93cd4idsL7abuAi1JyYAl22P2kd0k3H8ZJ1NCDnSk3wgNv/EGdrZus4stKfo=
X-Received: by 2002:a17:90b:5251:b0:2ee:4b8f:a59c with SMTP id
 98e67ed59e1d1-2f2e91fe20bmr3713758a91.22.1734529492703; Wed, 18 Dec 2024
 05:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203114942.697188-1-yeoreum.yun@arm.com>
In-Reply-To: <20241203114942.697188-1-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 18 Dec 2024 13:44:41 +0000
Message-ID: <CAJ9a7Vis9vcdJOzu9tvNQ4eAacmXkbhbZBaRYd1acOrd8G-ZUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] coresight: change some driver' spinlock type to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, nd@arm.com
Content-Type: text/plain; charset="UTF-8"

This change seems to omit devices:

etm3x - which provides support for ETMv3 and PTM, both of which are
valid trace sources in the cs_etm handling code.
stm - can be integrated into the kernel STM via configfs providing a
MIPI source for ftrace.

Mike

On Tue, 3 Dec 2024 at 11:49, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
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
> v1 to v2:
>     - seperate patchsets to change locktype and apply gurad API.
>
> Levi Yun (9):
>   coresight: change coresight_device lock type to raw_spinlock_t
>   coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
>   coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
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
>  .../hwtracing/coresight/coresight-config.c    |  21 +-
>  .../hwtracing/coresight/coresight-config.h    |   2 +-
>  drivers/hwtracing/coresight/coresight-core.c  |   2 +-
>  .../hwtracing/coresight/coresight-cti-core.c  |  65 +-
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 135 +++--
>  drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
>  drivers/hwtracing/coresight/coresight-etb10.c |  62 +-
>  .../coresight/coresight-etm4x-core.c          |  71 ++-
>  .../coresight/coresight-etm4x-sysfs.c         | 566 +++++++++---------
>  drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
>  .../hwtracing/coresight/coresight-funnel.c    |  34 +-
>  .../coresight/coresight-replicator.c          |  36 +-
>  .../hwtracing/coresight/coresight-syscfg.c    |  75 ++-
>  .../hwtracing/coresight/coresight-tmc-core.c  |   9 +-
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 195 +++---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 199 +++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
>  .../hwtracing/coresight/coresight-trace-id.c  |  93 ++-
>  drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
>  drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>  include/linux/coresight.h                     |   4 +-
>  21 files changed, 751 insertions(+), 838 deletions(-)
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
