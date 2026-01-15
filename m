Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F61291C33
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768450464; cv=none; b=VoeWtw9gZfK0g0yaPOb17GuzlB/wVrSWCjoyvgUDcpf3RCrnT6i9Rt0N53bmke58307jY40UzqFrY1Ub6xod6ph9J7v1gY/VFg0UFc27rZHPKuBnhgpF2En629Yh/3LVX/aS8aoEQBEhjnC0QBTMcUWf1KSQsk3FL9uwo6aXoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768450464; c=relaxed/simple;
	bh=iQXAcib2oRD600WPIfM+1RfvWKx32iOPMF/YK+XRJ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeiI9UzrkxvXZ+pCrSkZNWRm0/pVyrgXRhpBBEw1rh6LqU+hulZHoirdMotYbOkHci9auAW3mdvXhn2DqzfgESHb3oMwSnXse1OAtZk+alVOFGHGc/2YhyaUDcoYRreNqZSWxiY+Tt/L43rbmpiAgnMTHqJGQ3TbvPh4ozrhEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DayIyr8A; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DayIyr8A"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0f3f74587so3710635ad.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 14 Jan 2026 20:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768450462; x=1769055262; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttW/0VPnzpmGU5Uwq1WgWZISL693I/ws1/HEZYT9FVc=;
        b=DayIyr8AwlHqWYnDwqy4CD2swvhZzmk4VnRcHKkEncxPIJptWME/Qe+iKC71ZXddfB
         D8WJgoG27jd7zhirv/GFntw07WZ23KZK/P31EjXowwNnD5MoG0NSzVR7GgE2wxnmPPMm
         Ezh73VH8ElipotztiLH8myYuGPWKDi8xgLQC5xeaZst/c7G9SrBIN3efpm7KRN/FfyIR
         TNRuwLMgAMttYDJWifkWZWprm+Xx9Br9ZebI2BQJfWzet7Udr5rmYWIhtHc1gt+WXj/k
         mTU+4lLq58G30rTQUIF56jwrRDlTYLKT9XPZYUKU9YS8yBAEbeEIk+eqgs9pXyqhYjZy
         V2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768450462; x=1769055262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttW/0VPnzpmGU5Uwq1WgWZISL693I/ws1/HEZYT9FVc=;
        b=kgtaWN8KDIggyq9DiA+8Oi/R3zd4RyujKd0XhusZSwT/l/nNihjxMt/Fjegxy+i359
         JDCCeW38orJGFD4G0OsehndkaAYVxXhUmqWoInDfBZ8EmURW5YCrfcs0oOSShNMyRqxY
         jdCaSuumvbQ3nA8RGSNzj1s6UpsNP//H4lJfvT5u9nTO4afirogAX/85j8kPOhoxEdu3
         Hn2NlDFtRjDgAh5bzqZhbrpkQTn5rGxmLrW0cpagzNO2lxHDsrKcWdneyzpg0dQ6VYie
         u7/voQwoWjGECTDIwFpm6P/4SqS61FonsWlMitHYlIfSrdhB5mV34E+PmhVAnP7MU0mC
         PveA==
X-Forwarded-Encrypted: i=1; AJvYcCXs96M3f/Ibw5ItBZaG0ziX5+Wwgm+YjUXufjoYXWpmkulh6O8QHbaIUEKReOMqH8bRHb96bGU/LE4OcXtoQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXQ09bSYPBgUMSv92TZ6sU6pYOipNpn0D3l0O1/tUntkNbnO2n
	EaHgyMcAq4xoTCa6jTPmpgEXClWWdUiYcAIE6PlInsywETpBqLaA2HPIbh9pkAZwgYA=
X-Gm-Gg: AY/fxX6S6vrEc7gEg0d6c9SSZGF6zKIukfROcjB31ZqcU563rQ3MpNTS8E7pZ/Exrff
	N4JV+QSmwqaM+09AZJ3b6FBNvEaD2DYjVxET53OMkeeF7THIY1z/b01Zu1/zJ6FwVXHUp/6wPcY
	kcGO6W8lHmkDFUQ2MxyOgR8FaPI4+TifNpuglqBOcB+ohngnIG/HwcwGO21+RA4XV2LuREpp9Sv
	z+sUz+v8SzRQu0bvxvWllG211Id3Y6TMj5XgmDRPb97a9S6rbG8BuRVcO6E5MP15pRfLMmMUeR8
	szZoAyUzy2oJFADE6o78/vDvdB866e1pQ1Bxin9BFWSEABgpAWL3iRpa2h/+E6z7jB8xS7hsenG
	qVWZRjkDDxiDwauh966FIuq65sbWrr/DU0/3anxG4ivMto2oXR/5L9Z4d/OhnOAGh8edOaomIV0
	0aZaDd9IPr8So=
X-Received: by 2002:a17:903:189:b0:298:4ee2:19f3 with SMTP id d9443c01a7336-2a599e51d5fmr51014125ad.49.1768450462206;
        Wed, 14 Jan 2026 20:14:22 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2d6csm242276725ad.64.2026.01.14.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 20:14:21 -0800 (PST)
Date: Thu, 15 Jan 2026 09:44:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
Message-ID: <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
 <20260114085113.21378-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114085113.21378-3-kprateek.nayak@amd.com>

On 14-01-26, 08:51, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
> 
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
> 
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".
> 
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
> 
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Ahh, you need to fix the Rust binding as well. Minor change there.

-- 
viresh
