Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585D225772
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611089; cv=none; b=MgZFIQIpd+wHqkiK1qyX3yc+cX/8YszMlQ/slhSqZKk1sit9sPGaPu9HcaFteTeYWOLtxFN5x2nrPjxBdHH3hugSaVkhacXx/tV0VoHyhOJwDEa+ki+kC1u5hKFmxtu5U1//GMfs4POFB6Hl+tlurTIGOFxzO7/ApNpZB6XqOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611089; c=relaxed/simple;
	bh=ZXDGsyRBh4alTcW4VAf13AoHXW2SXWyYVh/i27mMyzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixwBBNA4SMYg14BBJCtBcyrDsa/C6OtHO1Hbm5T2qWtLe26ofUA5dIb0CenLvAUbC1+BTOMvZ7Eg0YuzIGq3Fuu7DypBbO3bfircsviRGTpebizV3WIjEXepW6Hg9PFN5/2BpPwuzTIZrOcxQ5OJZrpLyYMdmSvqZOPvvDSsJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2ncOyKV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2ncOyKV"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso279007a12.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Dec 2024 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734611086; x=1735215886; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qPhnUtMLyr5G8et/r1L4ymfoOV5ZxQgWku1qfbf+ZXc=;
        b=G2ncOyKVEzeN71Nq8BfHZwdjIfxxOk8/POyrhH5sU80WS+eISinA4A8pthics1o25i
         5tRg507uFejKkG2p3f+fCsvRxAP1ogSA2xgk/ZgPmcnQETQcnCGt0IBsdHXIJmdMYr6f
         XQ0CWnjpWP1juf+6WuYhlfGxN0aA60dfN+jkC6gj3iL6GmSfGNQGMUB/FlaQ42ZxNwFU
         Qyjd0F4/pO7luvglZT1xzL1CoUaoIYH9IfQ1k5gJAeRG48Si8Ojt3oQpb70foAhXhBXO
         1L7QNmbUXF8iPqfCKmIa4x/K+yKl3zUzWj/kbpRslXdq9AQVe1WI+bSP6JJnqQcYQMnr
         1J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734611086; x=1735215886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPhnUtMLyr5G8et/r1L4ymfoOV5ZxQgWku1qfbf+ZXc=;
        b=MyvTlvs+DOQH8QJzZLHxKPz+cBO/PZAqsjFw1YaAN1Cpgpx4OISLXDQnR460aCA3oR
         XTPlexCHwUQ1KqKpdWmEWSTOlJr2YZFV5yGe/1jTXV9cD7gXN/aOgoN1LTn6VkYWokOi
         kTAcSqI37qBofv3aBGxxdfhZPFTDbhwlgdyY+AzSuodzec9eBXRjhVAHDMcYJA3QNwEy
         fUOf2UqpUkePxKcUrSCi6zvRQngoVkqaT7kulzZqMrXOhizO7g3strt7AJKjUuTpUbws
         mD3eBLrQupWpMETeYZXT3zvUqXj+uJfvHzXNyG8sv1SwwB0dwUc8nII26a7rs0aKdGG/
         qarQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwJwgab6csHMRuBXPZgjU1Sy9fBZE965we9YwYRrk7tswtktFv8WLP8rboqU2yHBpN+VYRS6KrGPyMwosivw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaNAsVNLH4PbtnQc15MB281VmZKIQBbtUYvBN1vrUjqt8z6LFR
	zap6Lm6WOvUcAVjGXplIndxs9iBbWp9mfXLqm5WYTpKK05LA1858ix7PBsmcI9Pw0vZEREz2kzC
	lDsMZX9Jn11r5Lo6MN5JGJpbD+tjpIcadGjfE1A==
X-Gm-Gg: ASbGncuIs48rk9nRn9DWT3G+pQ53e2G1P7OILZgoYstkhRIeUQdjL2dE6JlKN84Hscj
	VfoymeeBzF9XQZwuSn0XRXIylFcMqVMaV2fS+AZg=
X-Google-Smtp-Source: AGHT+IEXrnCbNYeFkWiIA/RLHv1xEbIWgazA/JzIYdtX2wvrqVKmCi0J7WAM81CbK37oe0D/Sc7DQYvm4jqinUtmcQc=
X-Received: by 2002:a17:90b:50cf:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2f443d45527mr4651753a91.24.1734611085853; Thu, 19 Dec 2024
 04:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241216115006.415861-1-yeoreum.yun@arm.com> <20241216115006.415861-8-yeoreum.yun@arm.com>
In-Reply-To: <20241216115006.415861-8-yeoreum.yun@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 19 Dec 2024 12:24:34 +0000
Message-ID: <CAJ9a7Vg_vyyG7A8N=+oUiE2MCPFR4+XGqZBe+Mq8c222Wq6Q8w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] coresight-replicator: change replicator_drvdata
 spinlock's type to raw_spinlock_t
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: suzuki.poulose@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 11:50, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
>
> In coresight-replicator drivers, replicator_drvdata->spinlock can be held
> during __schedule() by perf_event_task_sched_out()/in().
>
> Since replicator_drvdata->spinlock type is spinlock_t and
> perf_event_task_sched_out()/in() is called after acquiring rq_lock,
> which is raw_spinlock_t (an unsleepable lock),
> this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.
>
> To address this, change type replicator_drvdata->spinlock in
> coresight-replicator drivers, which can be called
> by perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-replicator.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 0fba87de6d1a..7d36fe2176cc 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -41,7 +41,7 @@ struct replicator_drvdata {
>         struct clk              *atclk;
>         struct clk              *pclk;
>         struct coresight_device *csdev;
> -       spinlock_t              spinlock;
> +       raw_spinlock_t          spinlock;
>         bool                    check_idfilter_val;
>  };
>
> @@ -125,7 +125,7 @@ static int replicator_enable(struct coresight_device *csdev,
>         unsigned long flags;
>         bool first_enable = false;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (atomic_read(&out->src_refcnt) == 0) {
>                 if (drvdata->base)
>                         rc = dynamic_replicator_enable(drvdata, in->dest_port,
> @@ -135,7 +135,7 @@ static int replicator_enable(struct coresight_device *csdev,
>         }
>         if (!rc)
>                 atomic_inc(&out->src_refcnt);
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         if (first_enable)
>                 dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
> @@ -179,14 +179,14 @@ static void replicator_disable(struct coresight_device *csdev,
>         unsigned long flags;
>         bool last_disable = false;
>
> -       spin_lock_irqsave(&drvdata->spinlock, flags);
> +       raw_spin_lock_irqsave(&drvdata->spinlock, flags);
>         if (atomic_dec_return(&out->src_refcnt) == 0) {
>                 if (drvdata->base)
>                         dynamic_replicator_disable(drvdata, in->dest_port,
>                                                    out->src_port);
>                 last_disable = true;
>         }
> -       spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +       raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         if (last_disable)
>                 dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
> @@ -277,7 +277,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>         }
>         dev->platform_data = pdata;
>
> -       spin_lock_init(&drvdata->spinlock);
> +       raw_spin_lock_init(&drvdata->spinlock);
>         desc.type = CORESIGHT_DEV_TYPE_LINK;
>         desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
>         desc.ops = &replicator_cs_ops;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
