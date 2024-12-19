Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6D224B12
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611072; cv=none; b=TogQsMuFYeuqSES2E1lG8dA0rCus65EHG0EZdm3SVEzIJ5T8FvCdKEmZbJEcJr8QU1gwAA+tE6MHYTVhxq+PvVNG77xIYOMyZrrwmPdfRwwzb3xnodAlP9sG0HuwZO69c4PNWSJJJFUwLSCIrZEvSkWhfR7Y0sd30ds9Oo0WH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611072; c=relaxed/simple;
	bh=kG2K6QyjujxGod8tfzBLgk1/17M2naR/aT0sevQjv7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF38ARGvE6rfGlIT+PlpdtOzUPPjJKFQ9gJvbG4qW+hWkC22M7uuyNQHhjuTKoGiANhLixV9r7j6BFgyt2zxQISxU/D7jxoZ5us1gSzjWIKL5ga7S22rz7JorW74n6TurhYAQCQwWI0cnxNnU4988qWo/KcCB7DiwawTkM9+FNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxdW0z9L; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxdW0z9L"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7265c18d79bso843951b3a.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611070; x=1735215870; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hdfCCrlFzDpcoehZbLJW7DJrz1012DE3QLb9varfMtw=;
        b=DxdW0z9LxakqyLU8KVl4W6epNdHV4htdq4g24qAQTJUM0B8E8ztrWjyhpr5jplCiwB
         Z0VkvoPJGn7RgdPRrjPXBixH7KZkA+RoToKQ3nLdTmOyriKJQZXJkdKFZlntOXGI3psk
         dcNYxkgrvCXaYRojjVG9o7yFqtGKsV8ioTYhpnkD+SeNSuVqoB07lkbZH/JOpI7DDfSK
         8DUU8CISkVNv+RysqKx/JiP7opVxs1TwNPIjY/lzsbKiMPiX3WyONIZrdeZCLklCv4w0
         WszSW6r9FGBMyPzuZ6iYHxO91ni7cMeq/KWsEe7ZE6jCU76BYVOAPrLPwDSwdSdP/Bki
         +grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611070; x=1735215870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdfCCrlFzDpcoehZbLJW7DJrz1012DE3QLb9varfMtw=;
        b=nWuAbYPADhPVP8PUHb/Ode1nm1y90sXkd8pP3MRGB15mMVdohVD5Uf4FuIA3ZfSdbQ
         zhaGOdKnReL/xsTvxtKMfIekGJb41i/BNM51TnnfNeUZYlj2wAkCffU+K3VL7+Aq9mvt
         mdJwgWudPwxY2o2Czn25LtUPoQBT5vHmDH1URIlgeCl+ubPCAyxrzcoQm0s8UTeZFh0u
         NjCVW9XYoBLmD166WDQ2rnYCvpcmWTkdrHgVo0T1TX9FfDOrrJIqp4Yem0O1L5N31rsB
         IfDNPsse2M26xqqZP0XhJXHO89Y2c/RO5Qz3+5DsYn5xBMHgqMrbf4pQRLqCqm9k0rAm
         0OhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjG5AqNy7cBC8KapBc1BD1UOvj32HJLpq4d7Kj/vUf3zWVbSPOZnQkj777nctG42ZzyBRvMZzDrpzZJz0+5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxfaBOjzIEmiEZQlQYJ5I4yAsjvS4L5saSq87z34BJdqNgUBRZ
	Z3a8GDDIQE3jAsmvotO+hqpXRvRCLy/5Z9vtNpMOhNTkJdt7H6ywNtvD6tJLS04UAODgnu4BUw2
	mmB5hu+0fV1k1mVlAOyU3RV3g9DPO/UAoXQF9DA==
X-Gm-Gg: ASbGncsby4qEbqznQRyl+Z/bwFsSvsIyNLh8WPwGAu/7wIaqOA/Z3U/8nC4N/gnnzJ7
	dCSnfikdMVW0VMh6eVRDwVysDRzXkPe7IIeMhC6c=
X-Google-Smtp-Source: AGHT+IEh4nFwnQ7C0/qsYeQxsTWNOLqEtnDVajywM5YD8mjZhUzATndI0YwIopyvnfT6SubgcEziunhoLCi6mo6uzE0=
X-Received: by 2002:a17:90b:254b:b0:2ee:7870:8835 with SMTP id
 98e67ed59e1d1-2f2e9397ab7mr10124072a91.33.1734611069803; Thu, 19 Dec 2024
 04:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-6-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-6-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:24:18 +0000
Message-ID: <CAJ9a7Vhzoynt69+O1zya8LM3dOPhar9YxQXqHygbeKQC8CfHtg@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] coresight-etb10: change etb_drvdata spinlock's
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
> In coresight-etb10 drivers, etb_drvdata->spinlock can be held
> during __schedule() by perf_event_task_sched_out()/in().
>
> Since etb_drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this, change type etb_drvdata->spinlock in coresight-etb10 drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 26 +++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index aea9ac9c4bd0..7948597d483d 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -84,7 +84,7 @@ struct etb_drvdata {
>         struct clk              *atclk;
>         struct coresight_device *csdev;
>         struct miscdevice       miscdev;
> -       spinlock_t              spinlock;
> +       raw_spinlock_t          spinlock;
>         local_t                 reading;
>         pid_t                   pid;
>         u8                      *buf;
> @@ -145,7 +145,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
>         unsigned long flags;
>         struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         /* Don't messup with perf sessions. */
>         if (coresight_get_mode(csdev) == CS_MODE_PERF) {
> @@ -163,7 +163,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
>
>         csdev->refcnt++;
>  out:
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         return ret;
>  }
>
> @@ -176,7 +176,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
>         struct perf_output_handle *handle = data;
>         struct cs_buffers *buf = etm_perf_sink_config(handle);
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         /* No need to continue if the component is already in used by sysFS. */
>         if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
> @@ -219,7 +219,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
>         }
>
>  out:
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         return ret;
>  }
>
> @@ -352,11 +352,11 @@ static int etb_disable(struct coresight_device *csdev)
>         struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>         unsigned long flags;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         csdev->refcnt--;
>         if (csdev->refcnt) {
> -               spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +               raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>                 return -EBUSY;
>         }
>
> @@ -366,7 +366,7 @@ static int etb_disable(struct coresight_device *csdev)
>         /* Dissociate from monitored process. */
>         drvdata->pid = -1;
>         coresight_set_mode(csdev, CS_MODE_DISABLED);
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         dev_dbg(&csdev->dev, "ETB disabled\n");
>         return 0;
> @@ -443,7 +443,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>
>         capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         /* Don't do anything if another tracer is using this sink */
>         if (csdev->refcnt != 1)
> @@ -566,7 +566,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
>         __etb_enable_hw(drvdata);
>         CS_LOCK(drvdata->base);
>  out:
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         return to_read;
>  }
> @@ -587,13 +587,13 @@ static void etb_dump(struct etb_drvdata *drvdata)
>  {
>         unsigned long flags;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
>                 __etb_disable_hw(drvdata);
>                 etb_dump_hw(drvdata);
>                 __etb_enable_hw(drvdata);
>         }
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         dev_dbg(&drvdata->csdev->dev, "ETB dumped\n");
>  }
> @@ -746,7 +746,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>         drvdata->base = base;
>         desc.access = CSDEV_ACCESS_IOMEM(base);
>
> -       spin_lock_init(&drvdata->spinlock);
> +       raw_spin_lock_init(&drvdata->spinlock);
>
>         drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
