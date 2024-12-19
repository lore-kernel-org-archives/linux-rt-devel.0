Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21C224AFC
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611066; cv=none; b=kesTduh9D42/ApxtqqFPkgWgx0vqHJoEzt3oPfPQ+VqGmDDskLgmaklzxh1nb5TZZR7929iKIN6kL+CDPCsf3HHRgM93REs+i6KFk4D+i1JxrY1kBMSwXUvsCKo7RvUZ3QKsLI8ydaIhdHaPasYlQIVZz4SvYPgxGi6+3fPfGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611066; c=relaxed/simple;
	bh=onHqvg5SMvTm4by/Qrr6kLZGDLqddOqruGLN0PS8x7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtT67dpZBfpOx5ETNK0tekPMIvDGiVpG2W1JNXC4a8P62FDEdaCXzcp3XzbQfmXYYAGLaX2WHhyRESiGeIC6cVKGHrJLNvYD0/Bwb0+QvJcFcpsFKWj5fKofFjCTXrwW6EazxYzr77Cuh8o1iDGtq5lO1N5PrPfN0dWfmWxymCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLxCF4Ax; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLxCF4Ax"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef748105deso500286a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611064; x=1735215864; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5b7bstytnQq1P7Z9gwezKTvNEKKxlO7sEAeqWPB7bc=;
        b=xLxCF4AxhPwsmOJjv24T/ntmgX3yPoRFkGRgp9RkFU7+8srOLx6UOSqUURDzJbS6OR
         Ziil+O3CLV/P6TGJldrGJVCZgFKzAD1zFcENPpxihcGvqI3mY9fs4jdiTN92o4E29xpG
         SigqIrnVPWkTF5lHOhq5tg8qGVDmQ2LkQ74BivEttaee29dFKksGtuUTgoQJ4d8s8Irh
         S0HCT7eZSTnDZvPxUPWE/4Xdmr4utNgs2y5XI7YrtixRBdYXywqajYSouto1EicjNwFT
         E8ZSu/88zJWfIrjit38Z+eUIoJvg8HCgPvBvhXx126fQaIMBuU/7xcmV4uWIV9rCQygJ
         80yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611064; x=1735215864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5b7bstytnQq1P7Z9gwezKTvNEKKxlO7sEAeqWPB7bc=;
        b=vbw26HjA9tApn5XAl0froIT9PIfxO7Cddcr4tfD5Tr0fKS+O7Xmz+HS4Ko4DG1AJr4
         51k5eAw4Ut8kX35IT6Nc7FkrsMvL26EY0DBL5t5JICiIq/LVWQq1S2Ce9pDd43h/RHdx
         6LM0OsvGcdfCAVOCgKmQ/tliniyMX8/+8cYMRIbhVlvA/atrJXjmIqHQMxfxu9EneHql
         /aiwEfBpwCcZ4my7z2inhEe1y5RQ6Rk7h4dUAeYTkExJsY80oc78rLVjbnqAjdJOQtJn
         eUXAK8fWztNqfWjR1PvxYTCUtaN/WQi89TuHQsPeh0BpLH7Q2z5ilW5kncnw5QZxpBIg
         OeDw==
X-Forwarded-Encrypted: i=1; AJvYcCVYv9ZDLzld56ZUSplZ/SZ19z27Ns94MovQH5h4xK5M3orEZdSokgTDjssYaArgoiuGhVr6jsfHhPm/eI70Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUN/znwIn/fc4gXhzX4rDoSKjIIbySMIoxyw8hQHXItS5ijzWj
	CrKlAtMEXAonVZpb+HBaVATxba6H04YJWzqTfjksc1KllChB6qWO16i05lj78igMcfkhD0tI3Y3
	BN38GAzRY4V4ooCBS4/VDgW7ihBU0lSnY93d/tdvp3BD4XXjg
X-Gm-Gg: ASbGncugNJKHZNJowrQkuuGHG6LUfdu2311S4fTAWo0rYf1oETOqS/f8s/yt0/tVUh+
	DaxGTtQ8th9yOQb5XGmcw9P4BPX7CMr8z0sbVkSA=
X-Google-Smtp-Source: AGHT+IGcBCbuLCmV3kmUcL14B7VzN6UqU1NNdG3tDYR73kBLNjnGMp99Houcv/QQpR3jyfzDf//S5v8R9PAIILBmLkY=
X-Received: by 2002:a17:90b:6cb:b0:2ee:ee5e:42fb with SMTP id
 98e67ed59e1d1-2f2e91f0dd4mr8698005a91.13.1734611063998; Thu, 19 Dec 2024
 04:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-5-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-5-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:24:13 +0000
Message-ID: <CAJ9a7VgUMLR9cnY-QUqUcJj6ECfqxN0dD9QUqM8jmHj7t=Pd4g@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] coresight-cti: change cti_drvdata spinlock's type
 to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> In coresight-cti drivers, cti_drvdata->spinlock can be held during __schedule()
> by perf_event_task_sched_out()/in().
>
> Since cti_drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this, change type cti_drvdata->spinlock in coresight-cti drivers,
> which can be called by perf_event_task_sched_out()/in(),
> from spinlock_t to raw_spinlock_t.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  .../hwtracing/coresight/coresight-cti-core.c  | 44 +++++------
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 76 +++++++++----------
>  drivers/hwtracing/coresight/coresight-cti.h   |  2 +-
>  3 files changed, 61 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index d2b5a5718c29..80f6265e3740 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -93,7 +93,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>         unsigned long flags;
>         int rc = 0;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>
>         /* no need to do anything if enabled or unpowered*/
>         if (config->hw_enabled || !config->hw_powered)
> @@ -108,7 +108,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>
>         config->hw_enabled = true;
>         drvdata->config.enable_req_count++;
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         return rc;
>
>  cti_state_unchanged:
> @@ -116,7 +116,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>
>         /* cannot enable due to error */
>  cti_err_not_enabled:
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         return rc;
>  }
>
> @@ -125,7 +125,7 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>  {
>         struct cti_config *config = &drvdata->config;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         config->hw_powered = true;
>
>         /* no need to do anything if no enable request */
> @@ -138,12 +138,12 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>
>         cti_write_all_hw_regs(drvdata);
>         config->hw_enabled = true;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return;
>
>         /* did not re-enable due to no claim / no request */
>  cti_hp_not_enabled:
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>  }
>
>  /* disable hardware */
> @@ -153,7 +153,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>         struct coresight_device *csdev = drvdata->csdev;
>         int ret = 0;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>
>         /* don't allow negative refcounts, return an error */
>         if (!drvdata->config.enable_req_count) {
> @@ -177,12 +177,12 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>
>         coresight_disclaim_device_unlocked(csdev);
>         CS_LOCK(drvdata->base);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return ret;
>
>         /* not disabled this call */
>  cti_not_disabled:
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return ret;
>  }
>
> @@ -198,11 +198,11 @@ void cti_write_intack(struct device *dev, u32 ackval)
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>         struct cti_config *config = &drvdata->config;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         /* write if enabled */
>         if (cti_active(config))
>                 cti_write_single_reg(drvdata, CTIINTACK, ackval);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>  }
>
>  /*
> @@ -369,7 +369,7 @@ int cti_channel_trig_op(struct device *dev, enum cti_chan_op op,
>         reg_offset = (direction == CTI_TRIG_IN ? CTIINEN(trigger_idx) :
>                       CTIOUTEN(trigger_idx));
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>
>         /* read - modify write - the trigger / channel enable value */
>         reg_value = direction == CTI_TRIG_IN ? config->ctiinen[trigger_idx] :
> @@ -388,7 +388,7 @@ int cti_channel_trig_op(struct device *dev, enum cti_chan_op op,
>         /* write through if enabled */
>         if (cti_active(config))
>                 cti_write_single_reg(drvdata, reg_offset, reg_value);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return 0;
>  }
>
> @@ -406,7 +406,7 @@ int cti_channel_gate_op(struct device *dev, enum cti_chan_gate_op op,
>
>         chan_bitmask = BIT(channel_idx);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         reg_value = config->ctigate;
>         switch (op) {
>         case CTI_GATE_CHAN_ENABLE:
> @@ -426,7 +426,7 @@ int cti_channel_gate_op(struct device *dev, enum cti_chan_gate_op op,
>                 if (cti_active(config))
>                         cti_write_single_reg(drvdata, CTIGATE, reg_value);
>         }
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return err;
>  }
>
> @@ -445,7 +445,7 @@ int cti_channel_setop(struct device *dev, enum cti_chan_set_op op,
>
>         chan_bitmask = BIT(channel_idx);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         reg_value = config->ctiappset;
>         switch (op) {
>         case CTI_CHAN_SET:
> @@ -473,7 +473,7 @@ int cti_channel_setop(struct device *dev, enum cti_chan_set_op op,
>
>         if ((err == 0) && cti_active(config))
>                 cti_write_single_reg(drvdata, reg_offset, reg_value);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>
>         return err;
>  }
> @@ -676,7 +676,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>         if (WARN_ON_ONCE(drvdata->ctidev.cpu != cpu))
>                 return NOTIFY_BAD;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>
>         switch (cmd) {
>         case CPU_PM_ENTER:
> @@ -716,7 +716,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>         }
>
>  cti_notify_exit:
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return notify_res;
>  }
>
> @@ -743,11 +743,11 @@ static int cti_dying_cpu(unsigned int cpu)
>         if (!drvdata)
>                 return 0;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         drvdata->config.hw_powered = false;
>         if (drvdata->config.hw_enabled)
>                 coresight_disclaim_device(drvdata->csdev);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return 0;
>  }
>
> @@ -888,7 +888,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>         drvdata->ctidev.ctm_id = 0;
>         INIT_LIST_HEAD(&drvdata->ctidev.trig_cons);
>
> -       spin_lock_init(&drvdata->spinlock);
> +       raw_spin_lock_init(&drvdata->spinlock);
>
>         /* initialise CTI driver config values */
>         cti_set_default_config(dev, drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index d25dd2737b49..572b80ee96fb 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -84,11 +84,11 @@ static ssize_t enable_show(struct device *dev,
>         bool enabled, powered;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         enable_req = drvdata->config.enable_req_count;
>         powered = drvdata->config.hw_powered;
>         enabled = drvdata->config.hw_enabled;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>
>         if (powered)
>                 return sprintf(buf, "%d\n", enabled);
> @@ -134,9 +134,9 @@ static ssize_t powered_show(struct device *dev,
>         bool powered;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         powered = drvdata->config.hw_powered;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>
>         return sprintf(buf, "%d\n", powered);
>  }
> @@ -181,10 +181,10 @@ static ssize_t coresight_cti_reg_show(struct device *dev,
>         u32 val = 0;
>
>         pm_runtime_get_sync(dev->parent);
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         if (drvdata->config.hw_powered)
>                 val = readl_relaxed(drvdata->base + cti_attr->off);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         pm_runtime_put_sync(dev->parent);
>         return sysfs_emit(buf, "0x%x\n", val);
>  }
> @@ -202,10 +202,10 @@ static __maybe_unused ssize_t coresight_cti_reg_store(struct device *dev,
>                 return -EINVAL;
>
>         pm_runtime_get_sync(dev->parent);
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         if (drvdata->config.hw_powered)
>                 cti_write_single_reg(drvdata, cti_attr->off, val);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         pm_runtime_put_sync(dev->parent);
>         return size;
>  }
> @@ -264,7 +264,7 @@ static ssize_t cti_reg32_show(struct device *dev, char *buf,
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>         struct cti_config *config = &drvdata->config;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         if ((reg_offset >= 0) && cti_active(config)) {
>                 CS_UNLOCK(drvdata->base);
>                 val = readl_relaxed(drvdata->base + reg_offset);
> @@ -274,7 +274,7 @@ static ssize_t cti_reg32_show(struct device *dev, char *buf,
>         } else if (pcached_val) {
>                 val = *pcached_val;
>         }
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return sprintf(buf, "%#x\n", val);
>  }
>
> @@ -293,7 +293,7 @@ static ssize_t cti_reg32_store(struct device *dev, const char *buf,
>         if (kstrtoul(buf, 0, &val))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         /* local store */
>         if (pcached_val)
>                 *pcached_val = (u32)val;
> @@ -301,7 +301,7 @@ static ssize_t cti_reg32_store(struct device *dev, const char *buf,
>         /* write through if offset and enabled */
>         if ((reg_offset >= 0) && cti_active(config))
>                 cti_write_single_reg(drvdata, reg_offset, val);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>
> @@ -349,9 +349,9 @@ static ssize_t inout_sel_store(struct device *dev,
>         if (val > (CTIINOUTEN_MAX - 1))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         drvdata->config.ctiinout_sel = val;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_RW(inout_sel);
> @@ -364,10 +364,10 @@ static ssize_t inen_show(struct device *dev,
>         int index;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         index = drvdata->config.ctiinout_sel;
>         val = drvdata->config.ctiinen[index];
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return sprintf(buf, "%#lx\n", val);
>  }
>
> @@ -383,14 +383,14 @@ static ssize_t inen_store(struct device *dev,
>         if (kstrtoul(buf, 0, &val))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         index = config->ctiinout_sel;
>         config->ctiinen[index] = val;
>
>         /* write through if enabled */
>         if (cti_active(config))
>                 cti_write_single_reg(drvdata, CTIINEN(index), val);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_RW(inen);
> @@ -403,10 +403,10 @@ static ssize_t outen_show(struct device *dev,
>         int index;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         index = drvdata->config.ctiinout_sel;
>         val = drvdata->config.ctiouten[index];
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return sprintf(buf, "%#lx\n", val);
>  }
>
> @@ -422,14 +422,14 @@ static ssize_t outen_store(struct device *dev,
>         if (kstrtoul(buf, 0, &val))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         index = config->ctiinout_sel;
>         config->ctiouten[index] = val;
>
>         /* write through if enabled */
>         if (cti_active(config))
>                 cti_write_single_reg(drvdata, CTIOUTEN(index), val);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_RW(outen);
> @@ -463,7 +463,7 @@ static ssize_t appclear_store(struct device *dev,
>         if (kstrtoul(buf, 0, &val))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>
>         /* a 1'b1 in appclr clears down the same bit in appset*/
>         config->ctiappset &= ~val;
> @@ -471,7 +471,7 @@ static ssize_t appclear_store(struct device *dev,
>         /* write through if enabled */
>         if (cti_active(config))
>                 cti_write_single_reg(drvdata, CTIAPPCLEAR, val);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_WO(appclear);
> @@ -487,12 +487,12 @@ static ssize_t apppulse_store(struct device *dev,
>         if (kstrtoul(buf, 0, &val))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>
>         /* write through if enabled */
>         if (cti_active(config))
>                 cti_write_single_reg(drvdata, CTIAPPPULSE, val);
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_WO(apppulse);
> @@ -681,9 +681,9 @@ static ssize_t trig_filter_enable_show(struct device *dev,
>         u32 val;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         val = drvdata->config.trig_filter_enable;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return sprintf(buf, "%d\n", val);
>  }
>
> @@ -697,9 +697,9 @@ static ssize_t trig_filter_enable_store(struct device *dev,
>         if (kstrtoul(buf, 0, &val))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         drvdata->config.trig_filter_enable = !!val;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_RW(trig_filter_enable);
> @@ -728,7 +728,7 @@ static ssize_t chan_xtrigs_reset_store(struct device *dev,
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>         struct cti_config *config = &drvdata->config;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>
>         /* clear the CTI trigger / channel programming registers */
>         for (i = 0; i < config->nr_trig_max; i++) {
> @@ -747,7 +747,7 @@ static ssize_t chan_xtrigs_reset_store(struct device *dev,
>         if (cti_active(config))
>                 cti_write_all_hw_regs(drvdata);
>
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>  static DEVICE_ATTR_WO(chan_xtrigs_reset);
> @@ -768,9 +768,9 @@ static ssize_t chan_xtrigs_sel_store(struct device *dev,
>         if (val > (drvdata->config.nr_ctm_channels - 1))
>                 return -EINVAL;
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         drvdata->config.xtrig_rchan_sel = val;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>         return size;
>  }
>
> @@ -781,9 +781,9 @@ static ssize_t chan_xtrigs_sel_show(struct device *dev,
>         unsigned long val;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         val = drvdata->config.xtrig_rchan_sel;
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>
>         return sprintf(buf, "%ld\n", val);
>  }
> @@ -838,12 +838,12 @@ static ssize_t print_chan_list(struct device *dev,
>         unsigned long inuse_bits = 0, chan_mask;
>
>         /* scan regs to get bitmap of channels in use. */
> -       spin_lock(&drvdata->spinlock);
> +       raw_spin_lock(&drvdata->spinlock);
>         for (i = 0; i < config->nr_trig_max; i++) {
>                 inuse_bits |= config->ctiinen[i];
>                 inuse_bits |= config->ctiouten[i];
>         }
> -       spin_unlock(&drvdata->spinlock);
> +       raw_spin_unlock(&drvdata->spinlock);
>
>         /* inverse bits if printing free channels */
>         if (!inuse)
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index cb9ee616d01f..16e310e7e9d4 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -175,7 +175,7 @@ struct cti_drvdata {
>         void __iomem *base;
>         struct coresight_device *csdev;
>         struct cti_device ctidev;
> -       spinlock_t spinlock;
> +       raw_spinlock_t spinlock;
>         struct cti_config config;
>         struct list_head node;
>         void (*csdev_release)(struct device *dev);
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
