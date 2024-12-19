Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22633EA
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611083; cv=none; b=o6szXIsSW/ajwYHStMPEZm6E85oFxkdIlq+dYDuwtxkUAlGQWa64NKAW0VxWC+0V9KtEI/bjGE016vmzbGyjlVseAEqbGkeV5UpH+gDLtfLA5kbudQtoo3TypCzFI+m43wyu0j+ipaBYYE/+qDTh6G7J7QTSGloGY6r84FSCbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611083; c=relaxed/simple;
	bh=l74UctE2YfKm5b8pADcxi3PHa/24D9MUt0y8aS/wsY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCNFGYG5SBS0sMYWNq96KapyaRaCynbALApMTGX/K72kjqb4rWR3+gvMXtWvTvN7m0MSxz6TRbH2U8IufIObFVUWoDBg4NDM5WcHd3MRamZ78k7HyyboLK4tJPV30/9hgUwKXKE4QY01MFq1IQRMDq0myMJao4uLn03umYZAbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CKdGaKcv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKdGaKcv"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so614178b3a.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611081; x=1735215881; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNo7fVqZjlOZbRAISsnKYdQDkPnwQuUoIK88hKTmk0=;
        b=CKdGaKcvC5NXdDXz+1mVtg+Fehw2u/ymr/fl/ZhU4VmWLukCqqumRTZCqbhqx/yRlD
         /RNMwUjKCvjdtrcDvIR7rgnh09za2OWDRyQUKSAT1VBp+WaJsCTyK+xChaWfu6pmzl46
         bYCVife//Vbi5QWq59OV6GgyCVopOsepzhePXvQWOA/ZqeoRpql/y65fCNoyyS6Nb2w3
         tRLN0rz2TdHe5IzwoXgytaV7r1tHhMPWzBsWVrTnXYqN9bGpCu+ouZqRP7Jd3vgAt/lq
         yWzU+H6o3A1APNLbgsNuDqTlwgs5Bof6yCIOdHoF4oKjqDzuED2boEXShfpNY/q/ZtKM
         sNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611081; x=1735215881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtNo7fVqZjlOZbRAISsnKYdQDkPnwQuUoIK88hKTmk0=;
        b=IYPk7aW8GZeh+OiuaL1KgPKJ+bEVCly6I/yBI1t4x3YCxpe8ggvIhYhmHWDfyjevOK
         aeI4bgy18W/idRAFTKUpgN5D75cU7LDastpwQ3ZBx5q+gwz77Fh4mkgsPR6sL+VgBL6w
         /rGBRil2bj+MTrGjnprFi00PR1j2jYQ8bRil6hJWaZwRoec+J4p6JoMY2DN+aIrgvyGx
         tkz5Q1f5Y3vi7X04+lLNJjuu4c3LtB4ds8vO0NC22pNu3t5sNGWN2nJ07Zo33Dp8oXgi
         aQ8r124CR9YBb72zH8CEky1DhAxCAEpvRKFIDPXauyaTpD6IccDpe9HSjeM4vDUinGoU
         zWKg==
X-Forwarded-Encrypted: i=1; AJvYcCWfDlMyl47vGrskD2ie3zYpjQMz/vIdxs1LTgmohAVQGxidQ8J26D2YhiRA9WJ/RmOk+zAHNg3+iwQ+flcULQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkQ4WguAXuWnKluowocrbxsIhrh1i3kvHFzAB3JM9Blp/48dns
	p5XDL0CHFIMUfJqziczUEAiiYH+X7QM2leuyTQb01neMLIqJYUJF+mCO7sOpeoEdtrq+acjkpvW
	pSSzMX+qhlvzv6f+JyTSlnNT7pjS6X30ejIaSLg==
X-Gm-Gg: ASbGncvma5n2FmBCNKhpwQazpK1j1WJBg+0gVuDEoOGjXnj4GvBUhtYxOACLUvbrqyy
	7CdMEWQKHKoV7c8NiWmXK7Ag6wXGxiy7yPMLIvTI=
X-Google-Smtp-Source: AGHT+IEnAE2LzN4jVXimihufrQh1R5X23VGf0CFWVYGPAXTFsBCfa1ulDrdzBMCcon7eqUbj2eF9Ww1xrtYDsBX/wSQ=
X-Received: by 2002:a17:90b:2802:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f2e91c2d85mr9619666a91.3.1734611081049; Thu, 19 Dec 2024
 04:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-7-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-7-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:24:30 +0000
Message-ID: <CAJ9a7Vju8N=i5s=OUTXdCu8j2d95ZsqYT43jR54v6rui8o3DYw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] coresight-funnel: change funnel_drvdata spinlock's
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
> In coresight-funnel drivers, cti_drvdata->spinlock can be held
> during __schedule() by perf_event_task_sched_out()/in().
>
> Since funnel_drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this, change type funnel_drvdata->spinlock in
> coresight-funnel drivers, which can be called by
> perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 33efe1acbef7..a566c8854327 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -47,7 +47,7 @@ struct funnel_drvdata {
>         struct clk              *pclk;
>         struct coresight_device *csdev;
>         unsigned long           priority;
> -       spinlock_t              spinlock;
> +       raw_spinlock_t          spinlock;
>  };
>
>  static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
> @@ -85,7 +85,7 @@ static int funnel_enable(struct coresight_device *csdev,
>         unsigned long flags;
>         bool first_enable = false;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (atomic_read(&in->dest_refcnt) == 0) {
>                 if (drvdata->base)
>                         rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
> @@ -94,7 +94,7 @@ static int funnel_enable(struct coresight_device *csdev,
>         }
>         if (!rc)
>                 atomic_inc(&in->dest_refcnt);
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         if (first_enable)
>                 dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
> @@ -129,13 +129,13 @@ static void funnel_disable(struct coresight_device *csdev,
>         unsigned long flags;
>         bool last_disable = false;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (atomic_dec_return(&in->dest_refcnt) == 0) {
>                 if (drvdata->base)
>                         dynamic_funnel_disable_hw(drvdata, in->dest_port);
>                 last_disable = true;
>         }
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         if (last_disable)
>                 dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n",
> @@ -266,7 +266,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>         }
>         dev->platform_data = pdata;
>
> -       spin_lock_init(&drvdata->spinlock);
> +       raw_spin_lock_init(&drvdata->spinlock);
>         desc.type = CORESIGHT_DEV_TYPE_LINK;
>         desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
>         desc.ops = &funnel_cs_ops;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
