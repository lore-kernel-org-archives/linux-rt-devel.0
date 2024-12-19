Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30662248AF
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611062; cv=none; b=pzRrmNaDmx17XAqoi4urMNCUPIf6oPducL25A1NwDLOJb0Q1iaPE0idMjjc6/Nqc67gA5uLgoQmz1hGiGIfrbEZtcMEccf/tF77mVN6uqnFYUE0is+fdy5GWpsFNYVNP5o5j+EK9OMBNFeSpdH1K8z3HJrBrhZV/ZUdNT5X0vXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611062; c=relaxed/simple;
	bh=f0O+A3Ux4gLiJHDSKYVG5b2XJ3qws/dBSy86fghSmew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj808Vv2Yew4M6o91QAixa0vT2whbJ8HlDzcTtlmV05vqCUAK83T1rs+lSV/aWUSFzXDp3kjOLXDfcVrR56PMPLvk6URf6pxNUTqJv62tcvnUxuXdU8otbZW3E0BvyjpbC3WKPWtQVm8K74a9zxTWzW4r6mEXuwRGpu2jtLH/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbtfX2cI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbtfX2cI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso5533195ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611059; x=1735215859; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e81Vh4n5E44XmINm9ngPLGaHxgXFOdylY3YBTrbgY2E=;
        b=PbtfX2cIM2xNQeP71DPUHZCdHoPmooThtwQjJUWPcMwdYNta3hkvxfbdlprE1+R9ej
         QBtjJ+vtXOg3JnbtskUpsVDWsdXO2GaP/GaFBT7y1NgWabtIt6rvO5dtz0JO3zyxK7oT
         WKgtb5JedBcULn1N4i0ShfCwWNIwxVqHE7X05AfxJ5OlZ3Fp3FtVrPeIV7z2nO1aFLzH
         dVT1zUqRykIN0hFnoVUr7buwcsl/hzDmrTAtun0YY3go8L65e0GNpL4NA1nef4lkEsfg
         2QlbVBn+rUPUtsk11K/F6d2s1/Btk0uRo/ZMrBd2uJwsrzDjj4DD70cDxVtnbTm3rGbp
         ny6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611059; x=1735215859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e81Vh4n5E44XmINm9ngPLGaHxgXFOdylY3YBTrbgY2E=;
        b=VEFxJfeV58BNG96BDono2mlIa/1VAA3a3+aghzZv7L+FkVW1tXFXvCZKeD4jUVRiqZ
         C1oAgObN6SGNmtMBGXbbr+N1qaeETvGCyKbSCyljHVJlfLBpyWuzztX4UaqAxFLYpOE7
         dp0KyaIPdysnRSYa/CqIeOj7VKLUO4Cq9z2T65uqEw58B/M1ivbaCjeHpX7iCsNvzAoU
         Rm812YD7hYZzr1qt8Yq4Uxtng4Ap+S/1/cWzoH3N4b5w2jK31JbW3BXfZAwNQ1KUKJYS
         hfTjzCijCbYRRiQYH0sdDxxsCPfoiEe3UVdonEYURQOWL/1WAENz9WxP/78X1N3qWa4a
         pyeA==
X-Forwarded-Encrypted: i=1; AJvYcCVcIbIg8M50HlchoOCo2iDh4Ph2BmpawcvymyOU9ts5HusEPbrvRCCz0AHL4Ij1qrLkLy27mRDAWVGRJgHUlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YywXO89/HX/iXKdUqw30iIKHUDBhioqZxVXMsBWWgF0+rsgvSME
	xYXfJyEmUsbfibALLFHbdBDnEUc9ciI9w/T8RwXWsbYVI86qZ3mcIXUbmC0Y6cxQHjsPx409R+z
	mH9lE0kaKb9ez5TFbDP8xoTozXAG9CVZ6RGeTag==
X-Gm-Gg: ASbGnctgEbUUIXt+AI+hvLuqzE9aZrlS9EEyNQhaCl5RrzgpA3gJma5mdH8VmNxXdPS
	jkTraP3NUYEv/VI5RO1DY3fP6S5DE61VdGHoUTcY=
X-Google-Smtp-Source: AGHT+IHBn43pdX0pYf/rQYn2FYOzNPAA9risDSKTi00PJeRhVMrc0NPEChFuLLhTcXQ+q+xLrnxw0aDpCWiEidk7IpA=
X-Received: by 2002:a17:902:db04:b0:215:a2e2:53ff with SMTP id
 d9443c01a7336-219d9617e99mr38845615ad.11.1734611059237; Thu, 19 Dec 2024
 04:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-4-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-4-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:24:08 +0000
Message-ID: <CAJ9a7VhBkrggH9y1jqZZoXfhqiqKTkqU+U0aEm=659kpNUMj7Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] coresight: change coresight_trace_id_map's lock
 type to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> coresight_trace_id_map->lock can be acquired while coresight devices'
> drvdata_lock.
>
> But the drvdata_lock can be raw_spinlock_t (i.e) coresight-etm4x.
>
> To address this, change type of coresight_trace_id_map->lock to
> raw_spinlock_t
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c  |  2 +-
>  .../hwtracing/coresight/coresight-trace-id.c  | 22 +++++++++----------
>  include/linux/coresight.h                     |  2 +-
>  3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index ea38ecf26fcb..cc2d87b2f248 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1164,7 +1164,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>
>         if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>             csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> -               spin_lock_init(&csdev->perf_sink_id_map.lock);
> +               raw_spin_lock_init(&csdev->perf_sink_id_map.lock);
>                 csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
>                 if (!csdev->perf_sink_id_map.cpu_map) {
>                         kfree(csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index d98e12cb30ec..a6531869e9ec 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -16,7 +16,7 @@
>  static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
>  static struct coresight_trace_id_map id_map_default = {
>         .cpu_map = &id_map_default_cpu_ids,
> -       .lock = __SPIN_LOCK_UNLOCKED(id_map_default.lock)
> +       .lock = __RAW_SPIN_LOCK_UNLOCKED(id_map_default.lock)
>  };
>
>  /* #define TRACE_ID_DEBUG 1 */
> @@ -121,11 +121,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
>         unsigned long flags;
>         int cpu;
>
> -       spin_lock_irqsave(&id_map->lock, flags);
> +       raw_spin_lock_irqsave(&id_map->lock, flags);
>         bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
>         for_each_possible_cpu(cpu)
>                 atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
> -       spin_unlock_irqrestore(&id_map->lock, flags);
> +       raw_spin_unlock_irqrestore(&id_map->lock, flags);
>         DUMP_ID_MAP(id_map);
>  }
>
> @@ -134,7 +134,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>         unsigned long flags;
>         int id;
>
> -       spin_lock_irqsave(&id_map->lock, flags);
> +       raw_spin_lock_irqsave(&id_map->lock, flags);
>
>         /* check for existing allocation for this CPU */
>         id = _coresight_trace_id_read_cpu_id(cpu, id_map);
> @@ -161,7 +161,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
>         atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
>
>  get_cpu_id_out_unlock:
> -       spin_unlock_irqrestore(&id_map->lock, flags);
> +       raw_spin_unlock_irqrestore(&id_map->lock, flags);
>
>         DUMP_ID_CPU(cpu, id);
>         DUMP_ID_MAP(id_map);
> @@ -178,12 +178,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
>         if (!id)
>                 return;
>
> -       spin_lock_irqsave(&id_map->lock, flags);
> +       raw_spin_lock_irqsave(&id_map->lock, flags);
>
>         coresight_trace_id_free(id, id_map);
>         atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
>
> -       spin_unlock_irqrestore(&id_map->lock, flags);
> +       raw_spin_unlock_irqrestore(&id_map->lock, flags);
>         DUMP_ID_CPU(cpu, id);
>         DUMP_ID_MAP(id_map);
>  }
> @@ -193,10 +193,10 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
>         unsigned long flags;
>         int id;
>
> -       spin_lock_irqsave(&id_map->lock, flags);
> +       raw_spin_lock_irqsave(&id_map->lock, flags);
>         /* prefer odd IDs for system components to avoid legacy CPU IDS */
>         id = coresight_trace_id_alloc_new_id(id_map, 0, true);
> -       spin_unlock_irqrestore(&id_map->lock, flags);
> +       raw_spin_unlock_irqrestore(&id_map->lock, flags);
>
>         DUMP_ID(id);
>         DUMP_ID_MAP(id_map);
> @@ -207,9 +207,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>  {
>         unsigned long flags;
>
> -       spin_lock_irqsave(&id_map->lock, flags);
> +       raw_spin_lock_irqsave(&id_map->lock, flags);
>         coresight_trace_id_free(id, id_map);
> -       spin_unlock_irqrestore(&id_map->lock, flags);
> +       raw_spin_unlock_irqrestore(&id_map->lock, flags);
>
>         DUMP_ID(id);
>         DUMP_ID_MAP(id_map);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 924b58c343b3..6446ca1f09d8 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -233,7 +233,7 @@ struct coresight_trace_id_map {
>         DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
>         atomic_t __percpu *cpu_map;
>         atomic_t perf_cs_etm_session_active;
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>  };
>
>  /**
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
