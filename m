Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6D2248A5
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611079; cv=none; b=tlgGfNqDYmLkdtpp1jeBHPCQHQ0tHPngSQgRZiLLyNTGOP1t5b+vJLyBzslMKDgQCLW6xj6fnGZnrLqHjstJgs8shKnidGPpNSSQciqK0gSoo15lO/fhWf4uQdY/VYkV85VcStcgA/b9bpmcThS7zibc9O8hvE5Mvni+9Mski58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611079; c=relaxed/simple;
	bh=SWDJmUAhv1X8WuD1WZB/B7+PPFz3tN6BVz20qs6eXR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hX8rbKBBJZzv5CgbDni4ZGmcguZ2MYdtSQOJ0hPOa1mburmXwYKNHrYF5fv8jMVJkttVvAdTSSjFyHosRybgEIlzDE91NbkkWeEQCZztjBA2pTj6dSOow740TL4Bymry6uobYQogiEgeNlkpAvgkqgx4iENpUqOVs83RafLA70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qt3xcj7g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qt3xcj7g"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2162c0f6a39so16807625ad.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611077; x=1735215877; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMD1W6cpsE4dlGftuAN55ixpGuMA3g4YGiIJBVrtChc=;
        b=Qt3xcj7gr1lG8yLplyVJPK4L7SrJ3z876xqei+xl95C3SNfo9oha4NDueBUYewZ9Sv
         x/BSnUbYKnStrYCsjDiFq1XKZ1b2GPzHYrdxZXmY4NazTDWCbybp3s4jQpXVcr/UpNFE
         AAQicI0O+1EXEufWQ//h17Neuki7duJ2KhO8HXvXvnXNEPa/pH7lYhp/+Ytgz03b4BGp
         R2FKj+dnds50/fMzn9AJUsOP2LeEqt6JvBBIil8kOtzV1dPFt1CqMlaf1ntcggwOn9vc
         rsWAwZLMkgh70jN4FMBQXLjD3gAB5ObuVRbPZLyYkYTelRGFI29elkh2L2Jtv13fnPNY
         KUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611077; x=1735215877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMD1W6cpsE4dlGftuAN55ixpGuMA3g4YGiIJBVrtChc=;
        b=qXixtso3eYgmcufUw8tILJmVLgHrhw/RvmgsKXdrJZVeATdTPjb6t77vApz342ScBG
         90r1gB6eu415V9jsb17rLDoaVMBQGVgZYtmv6NaCQaAcSp7PgUbY1afc2NLyhFdCdroh
         nN4GwM2GJQYka4qy56XXpLmPwFG+LyTbrAj0G5jGotXEClV3lh+8eDFNaldVoLcr3ut1
         UthOh9yM3WEPaPiYBrtsYGRhNkWa+k1qF3v7pFD18nmuBwmm/OduZxzAtB2h8xYrbCtV
         MNgQ8lSfa1Vq5bB/TCdTVF2qwncKygV9+Nd048VbMpjf7ALd44sAepYmiBWHkByv7G1i
         BmRg==
X-Forwarded-Encrypted: i=1; AJvYcCV3u+4mJsC7+Ml8QAIxjadJ/D7G/oVRgcHHqlkdSQ8pH2SxqH+mfIqvR1g5xLbQwE68vRRqiviZ1G4g1+/TFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYZoF75Lno+aI6+Z9N3M3tsueE5kPPQzv9WLdvEAAc5s7TbjjJ
	Y45of7NqO7isEARkBIw/4E4INkBEHC3kJF1ouoYzmlsV9ZBTvPalL2eKW4YQeMwnd+54hempqmp
	c4uMSOOQSAEf9P0W5QAEv1opooaNFwGcT5zOknaby2nOjKeyx
X-Gm-Gg: ASbGncv1mzBUJ6D7cDBT+rCm3I2XpxJh6AfamitfhcZDFdC3redhnRyMloGxhFoQ7PF
	ZKxD4Px5oKL8tyKnlcGqhHVj2ONdnSNlF/7kHBzQ=
X-Google-Smtp-Source: AGHT+IG7EkxyS4TQVkuiVVr+U0GafJQCULAaD0tMNyJzz6oqJuxymrmgecG5I0N5Jw8IQhcm61gXWaBDUODf0G/ZCRs=
X-Received: by 2002:a17:90b:548c:b0:2ef:e063:b3f8 with SMTP id
 98e67ed59e1d1-2f4435abac6mr5262624a91.7.1734611077500; Thu, 19 Dec 2024
 04:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-10-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-10-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:24:26 +0000
Message-ID: <CAJ9a7ViC+ZSzNYTo+mKK4UYw=GBO9TCyJ2WHN879=hO-tq8JvQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] coresight/ultrasoc: change cti_drvdata spinlock's
 type to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Title of patch - this patch has nothing to do with cti_drvdata.

Mike


On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> In ultrasoc-smb drivers, smb_drv_data->spinlock can be held
> during __schedule() by perf_event_task_sched_out()/in().
>
> Since smb__drv_data->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this, change type smb_drv_data->spinlock in ultrasoc-smb drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/hwtracing/coresight/ultrasoc-smb.c | 12 ++++++------
>  drivers/hwtracing/coresight/ultrasoc-smb.h |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index dc3c9504dd7c..26cfc939e5bd 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -98,7 +98,7 @@ static int smb_open(struct inode *inode, struct file *file)
>         struct smb_drv_data *drvdata = container_of(file->private_data,
>                                         struct smb_drv_data, miscdev);
>
> -       guard(spinlock)(&drvdata->spinlock);
> +       guard(raw_spinlock)(&drvdata->spinlock);
>
>         if (drvdata->reading)
>                 return -EBUSY;
> @@ -152,7 +152,7 @@ static int smb_release(struct inode *inode, struct file *file)
>         struct smb_drv_data *drvdata = container_of(file->private_data,
>                                         struct smb_drv_data, miscdev);
>
> -       guard(spinlock)(&drvdata->spinlock);
> +       guard(raw_spinlock)(&drvdata->spinlock);
>         drvdata->reading = false;
>
>         return 0;
> @@ -245,7 +245,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
>         struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>         int ret = 0;
>
> -       guard(spinlock)(&drvdata->spinlock);
> +       guard(raw_spinlock)(&drvdata->spinlock);
>
>         /* Do nothing, the trace data is reading by other interface now */
>         if (drvdata->reading)
> @@ -280,7 +280,7 @@ static int smb_disable(struct coresight_device *csdev)
>  {
>         struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>
> -       guard(spinlock)(&drvdata->spinlock);
> +       guard(raw_spinlock)(&drvdata->spinlock);
>
>         if (drvdata->reading)
>                 return -EBUSY;
> @@ -378,7 +378,7 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
>         if (!buf)
>                 return 0;
>
> -       guard(spinlock)(&drvdata->spinlock);
> +       guard(raw_spinlock)(&drvdata->spinlock);
>
>         /* Don't do anything if another tracer is using this sink. */
>         if (csdev->refcnt != 1)
> @@ -563,7 +563,7 @@ static int smb_probe(struct platform_device *pdev)
>
>         smb_reset_buffer(drvdata);
>         platform_set_drvdata(pdev, drvdata);
> -       spin_lock_init(&drvdata->spinlock);
> +       raw_spin_lock_init(&drvdata->spinlock);
>         drvdata->pid = -1;
>
>         ret = smb_register_sink(pdev, drvdata);
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
> index a91d39cfccb8..c4c111275627 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.h
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
> @@ -115,7 +115,7 @@ struct smb_drv_data {
>         struct coresight_device *csdev;
>         struct smb_data_buffer sdb;
>         struct miscdevice miscdev;
> -       spinlock_t spinlock;
> +       raw_spinlock_t spinlock;
>         bool reading;
>         pid_t pid;
>  };
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
