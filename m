Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68F246BD8
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491606; cv=none; b=McAP4ivXwVYTAcs/rf+DsBQwzgu1Y2PsB0hRh2i7PCA2DXWgdTazFEyJfJuZ/nE3itYe8XYM1+NNxGzEMSG0QXI2MpLI2r99HxmFbLFYafX7R/PCJgya5WGy2k81o07M4aH0JTVhQpvnMoWYy4tBMYxDCvMK6a8BkNeK+YY33NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491606; c=relaxed/simple;
	bh=ZA5jvG8pGJZD7/FvjspI+R76IwjgXaVGgj+MLHimBqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXKT2OelEtpTpI8FGN+D+fDWe85tziGnyKZ8fpwSXGIzJMBU1RU8tV6fRUDjcQ6UaGB0c4GmGxBculeJWpTNnEGbSdToELUuwGK9nSgSEI+UCKhdyl/bSMhHdXmI0sKQRLksAXDcoCxHIwlIrN5QcgN86D7iPiOLlk2uWPtjeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tGsd54jN; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGsd54jN"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e75668006b9so4096696276.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752491604; x=1753096404; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iYsZgpGyc92tylgoOl1ueE7I+vTEL4X4JFlPanY31ls=;
        b=tGsd54jNJjUkkkZ6v7iEjAK5KCSEPOfW9goK3sJc9YcVJl8cLLsxEjsUqfP8Ja92lq
         pAX0jYyokAPDiPc8gyszH46jFolLpmR021WCBAYDz27FjBgoMGafkol+SNDVVGSlticr
         u/X40gJAFtwFVQJkvQ3rDxBmxfVqde0wKW0qHmrjzJWDD6YjXPJCRQ6SzyTyTOCVsjTe
         0g6AaTje197flQT/X5KJmnU7yOLX2/JpE8q6ndI/ZiJBvJGddB6oZsgGTs0pGLxzxnCH
         5H4Q/lZPMabyhVk3pAfsl0gftJwQ5CLArBdW3EU3k/BOUjbJynoz3C5VcIFaToIXiUTV
         8O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752491604; x=1753096404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYsZgpGyc92tylgoOl1ueE7I+vTEL4X4JFlPanY31ls=;
        b=cP7JIod6oH7lDD3/miEntfh7QTUp+LEWccXsIQ5uDFzz/Bu7nNkjLTW2qsoar9yP6k
         2/ToKl3GiBM3j6xcWXuxoTnCrdutBfgLYTm/didv4rhvkncTNrUX2uS0acH4xvH9mPQw
         z/6831JnZ2a0xKii1HtghrLMG3ZDur7R1p9AqF8sXpG618S7IxqdE5BD8SnDzjtaRhqp
         IQelYR++0BKdCb/Qv8WagWZhxv/zW+3BAN50JJ+eGoLLu1CW5RPVcf1mkXFJzdI60F7K
         zPzUVKT2xKsNLDaDmR/sQQdjDPm1tHY7qYK8DguEqkuU+GaPPAOMMn6WaU0xYKWUP+Xi
         es2w==
X-Forwarded-Encrypted: i=1; AJvYcCUl5zZdqrDVzgmpMpubfAtT2h5IyKqlOEt1yPSZ4UgrGC6QylUNqinWSoxvrWtQj3uWb7zEIVmFiyMHfnjbjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySdw04uFcoVe2DLyNMmJeKQuFy++m1gJl7ElpfXqxkHus4shRL
	M+0wL1p76sPXqFtgeFV12VRe0dl1ELEla64TkY+AnbY4t1cSGSiRFZL5ls3AuhQsQi88tpDvCQy
	cWVg7yARY8APVCDCnQPFf741PN4LKP6fd9Ryq8Z07Ow==
X-Gm-Gg: ASbGncsWDRND8pbUR4HwIbCtw/oarz72qV6Zm5ZLOMx5AE1QeNo2Rf78KejrzULQYTA
	rmuZjlVuNchGkOwyytRNPRE6WqIANa6B/NsyiECXtWw2Qt2HBUiVPQHpwSnIreBbDxUrGyjL/9t
	esNLVrkNNFB9ERzavwnkORZu5Bu8so0XTH2rqfW8jm7jex+ps2IGqinHrh2vW+Wr3oRvZTO293q
	I8x3rEL
X-Google-Smtp-Source: AGHT+IEo5nowTE/kmucDEHrishTa1XrYiiyuTFtayRgTTm+E8uO5OzwI/Scst1QOoi4vBiyg+Oy6sxmd+YJaGyA1WnM=
X-Received: by 2002:a05:690c:d19:b0:70d:ffaf:48df with SMTP id
 00721157ae682-717d786dda1mr175760437b3.3.1752491603539; Mon, 14 Jul 2025
 04:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
In-Reply-To: <20250709154728.733920-1-daniel.lezcano@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jul 2025 13:12:47 +0200
X-Gm-Features: Ac12FXxaeX7OXBuCkXJ-j03hUCK21Ze9ZEebSgiQ5mn7RsuZUrOhhvlhJZv3Zm8
Message-ID: <CAPDyKFp9up-okoVZf5j+LFvpCOFgLjS8FY1eEqoaDU8remD8Hg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, sudeep.holla@arm.com, linux-pm@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Raghavendra Kakarla <quic_rkakarla@quicinc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 17:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
> not supported because the underlying generic power domain functions
> used in the cpu hotplug callbacks are incompatible from a lock point
> of view. This situation prevents the suspend to idle to reach the
> deepest idle state for the "cluster" as identified in the
> undermentioned commit.
>
> Use the compatible ones when PREEMPT_RT is enabled and remove the
> boolean disabling the hotplug callbacks with this option.
>
> With this change the platform can reach the deepest idle state
> allowing at suspend time to consume less power.
>
> Tested-on Lenovo T14s with the following script:
>
> echo 0 > /sys/devices/system/cpu/cpu3/online
> BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
> rtcwake -s 1 -m mem;
> AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
> if [ $BEFORE -lt $AFTER ]; then
>     echo "Test successful"
> else
>     echo "Test failed"
> fi
> echo 1 > /sys/devices/system/cpu/cpu3/online
>
> Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
> Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 4e1ba35deda9..b19bc60cc627 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>  static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
>  static bool psci_cpuidle_use_syscore;
> -static bool psci_cpuidle_use_cpuhp;
>
>  void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
>                            u32 state)
> @@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
>  {
>         struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
>
> -       if (pd_dev)
> -               pm_runtime_get_sync(pd_dev);
> +       if (pd_dev) {
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       pm_runtime_get_sync(pd_dev);
> +               else
> +                       dev_pm_genpd_resume(pd_dev);
> +       }
>
>         return 0;
>  }
> @@ -135,7 +138,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
>         struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
>
>         if (pd_dev) {
> -               pm_runtime_put_sync(pd_dev);
> +               if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +                       pm_runtime_put_sync(pd_dev);
> +               else
> +                       dev_pm_genpd_suspend(pd_dev);
> +
>                 /* Clear domain state to start fresh at next online. */
>                 psci_clear_domain_state();
>         }
> @@ -196,9 +203,6 @@ static void psci_idle_init_cpuhp(void)
>  {
>         int err;
>
> -       if (!psci_cpuidle_use_cpuhp)
> -               return;
> -
>         err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
>                                         "cpuidle/psci:online",
>                                         psci_idle_cpuhp_up,
> @@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>          * s2ram and s2idle.
>          */
>         drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>                 drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
> -               psci_cpuidle_use_cpuhp = true;
> -       }
>
>         return 0;
>  }
> @@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
>
>         dt_idle_detach_cpu(data->dev);
>         psci_cpuidle_use_syscore = false;
> -       psci_cpuidle_use_cpuhp = false;
>  }
>
>  static int psci_idle_init_cpu(struct device *dev, int cpu)
> --
> 2.43.0
>
