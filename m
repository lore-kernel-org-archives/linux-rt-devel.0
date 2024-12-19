Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7322371E
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611049; cv=none; b=JO1RiU0OJUAx8eL8w0i4mL8W+Mz6mzusnWxOd3cywYq98W0zr5Ekzkc00wig2ORSsat0u936yGvFTrOlomadOoAP8qF4403yHmKiFtDpPDMfhB/fAg+vLIRS8LCyUM2ElpXxnE72hVHZCQo7RkOmA4DvACnX5qiHf5VCrjHZeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611049; c=relaxed/simple;
	bh=L7HvtyA7+OLQTq2Z1xkUUmUTdlbT+X3uOZa0hhOvGg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJvrU+BNPKusA0Hz8DHhfMAnRwl/CDvRHAx20rLUyQAdT4l0/CpEoRipENcfoEtjgoHI+JFNznCzQ7B6Y0eqUxd+Wdsm2NFJF6cHl1P9aw00F63Z5h63P9QBXe8UCHsqAerknMm3H1MmZ1N6pmFfVzVfTYsrWRZFWFnC8GEvED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zSuRIteE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSuRIteE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so661009a91.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611046; x=1735215846; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys18WnBkglanp1sG+Ft/swdVhnnKfXQLN44jZUIpgWY=;
        b=zSuRIteEjEsum4JCRbe8gSqp72y/zj6o+4KpmR8McetFYUZXjed4EKGNUXQO4YX5Je
         Tp387T4wwsXUg1Z9MhftVrpLvJfGZGCjcdzk51URB+rAFwcXM/PrAMDsy1582zn1d/YS
         NLMo9PGpHcApwEgVyYATdpvDajEShrJy9ph/curFiXHGSu4frmA8upROI2XkF+HdkJGi
         xyMt6A53w/2rqZLUYNonWJomR1VkELoe7twIbGAQ+6aHhrQJeEV7L55fpXXprjIg0FZO
         dECNSHnsoeUJ4CKziZBCS4vhQ5Jq2NzM5m9tW3DwEAdWWQplBj23yceSgBceilD28QDb
         S+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611046; x=1735215846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ys18WnBkglanp1sG+Ft/swdVhnnKfXQLN44jZUIpgWY=;
        b=EIAki+h5X1rkH16StJ/ZlSKpTwUsjF3wrDYAILpAfKH5Ia+kpsukmDpD2A41QbHsYz
         eL0pXFK9xJBf9rd9GlswONP3RGVbbJJHRhcxdNixomMT9JVxFwhIQxcHrGQ2o6c3P0Py
         5NmMPOvEfEyTFWhK0Bg/ROgM31vPbc3R0WTedEvJ5D8dOVJgLCGm3wMvqzrFoosj/7A0
         Kuny/ha0hRdt5I78SCkaagoPPocqZ2LOXx1d2ltoboc5FoYZ+ZK9ynUbRromy7nQM725
         gWTovfDNhmDq+TAosJkrT/m0+YlLFKLQ1XwvZ7zCulek2XvFa6x21/+D6f0XqdiZjK8v
         PshA==
X-Forwarded-Encrypted: i=1; AJvYcCUUWn6QDFh/jkrtMh1655tmHd10/E/rNl+1cX94dw8z+V+2H5mcw4/0tVgaf5+hwNzGXa0nBhoLJrmRoBCaRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwerFOCQGivNxYkMRQwyO6uTa/oFYoHjf2FXMORMx0WFS02nmwG
	3dBPFbYNRxvLROiJPGSxVrMJmrvxZXIiah/6wxPKIQpoTRZsoy9EAzu+DCWDNBO7mR22suONR52
	t9jDUqZqb0pncmKeu90ccQKLjHNElh9JzdSxHVA==
X-Gm-Gg: ASbGncv8KZS0VRhamp/8TuAUT9Rspvhe1fU3cy5TkrknQTizdgNMcybFRfU/mub1lIZ
	DALfE222udlNFYHBCClO4ZGLZR/R3M3Z0ty9wzY4=
X-Google-Smtp-Source: AGHT+IHyJ75kkKZcotZKRSWO3KXec2uxN2Q3jqJQ3MCYrpXRl4utw/3Mvc8xC9SaLOCdJtKK9KirKR0oNAZIGcXXpx8=
X-Received: by 2002:a17:90b:5244:b0:2ee:cddd:2454 with SMTP id
 98e67ed59e1d1-2f443ced9e5mr5053806a91.15.1734611046351; Thu, 19 Dec 2024
 04:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-2-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-2-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:23:55 +0000
Message-ID: <CAJ9a7VgJNLJK2oa9Us9bFAEiEmi8_u+NJ1zNrnd5WhhHgxhPxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] coresight: change coresight_device lock type to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> coresight_device->cscfg_csdev_lock can be held during __schedule()
> by perf_event_task_sched_out()/in().
>
> Since coresight->cscfg_csdev_lock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this, change type of coresight_device->cscfg_csdev_lock
> from spinlock_t to raw_spinlock_t.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  .../hwtracing/coresight/coresight-syscfg.c    | 26 +++++++++----------
>  include/linux/coresight.h                     |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 11138a9762b0..a70c1454b410 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -89,9 +89,9 @@ static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
>         }
>         /* if matched features, add config to device.*/
>         if (config_csdev) {
> -               spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +               raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>                 list_add(&config_csdev->node, &csdev->config_csdev_list);
> -               spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +               raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>         }
>
>         return 0;
> @@ -194,9 +194,9 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
>
>         /* add to internal csdev feature list & initialise using reset call */
>         cscfg_reset_feat(feat_csdev);
> -       spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>         list_add(&feat_csdev->node, &csdev->feature_csdev_list);
> -       spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>
>         return 0;
>  }
> @@ -765,7 +765,7 @@ static int cscfg_list_add_csdev(struct coresight_device *csdev,
>
>         INIT_LIST_HEAD(&csdev->feature_csdev_list);
>         INIT_LIST_HEAD(&csdev->config_csdev_list);
> -       spin_lock_init(&csdev->cscfg_csdev_lock);
> +       raw_spin_lock_init(&csdev->cscfg_csdev_lock);
>
>         return 0;
>  }
> @@ -855,7 +855,7 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
>         struct cscfg_feature_csdev *feat_csdev;
>         unsigned long flags;
>
> -       spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>         if (list_empty(&csdev->feature_csdev_list))
>                 goto unlock_exit;
>
> @@ -863,7 +863,7 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
>                 cscfg_reset_feat(feat_csdev);
>
>  unlock_exit:
> -       spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
>
> @@ -1059,7 +1059,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>          * Look for matching configuration - set the active configuration
>          * context if found.
>          */
> -       spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>         list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
>                 config_desc = config_csdev_item->config_desc;
>                 if ((atomic_read(&config_desc->active_cnt)) &&
> @@ -1069,7 +1069,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>                         break;
>                 }
>         }
> -       spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>
>         /*
>          * If found, attempt to enable
> @@ -1090,12 +1090,12 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
>                          *
>                          * Set enabled if OK, err if not.
>                          */
> -                       spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +                       raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>                         if (csdev->active_cscfg_ctxt)
>                                 config_csdev_active->enabled = true;
>                         else
>                                 err = -EBUSY;
> -                       spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +                       raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>                 }
>         }
>         return err;
> @@ -1124,7 +1124,7 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
>          * If it was not enabled, we have no work to do, otherwise mark as disabled.
>          * Clear the active config pointer.
>          */
> -       spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
>         config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
>         if (config_csdev) {
>                 if (!config_csdev->enabled)
> @@ -1133,7 +1133,7 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
>                         config_csdev->enabled = false;
>         }
>         csdev->active_cscfg_ctxt = NULL;
> -       spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +       raw_spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
>
>         /* true if there was an enabled active config */
>         if (config_csdev)
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index c13342594278..924b58c343b3 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -296,7 +296,7 @@ struct coresight_device {
>         /* system configuration and feature lists */
>         struct list_head feature_csdev_list;
>         struct list_head config_csdev_list;
> -       spinlock_t cscfg_csdev_lock;
> +       raw_spinlock_t cscfg_csdev_lock;
>         void *active_cscfg_ctxt;
>  };
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
