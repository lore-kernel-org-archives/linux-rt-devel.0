Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200D477E24
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836535; cv=none; b=h632BLMb18nnaPZF02+9vtgjngA8sNnXzHd9gbFfV4x/zBd26f68RJZ2ajtnDdIV0VYmcJzpscpP85llonnprRQ2ToJgWvN/SDbPWwJq3fYlnhjQMpKROb8QS4WSSv5dXAsRxZpXsaA3nADlQ/ial2g1ugIN3iWopBz9InPCvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836535; c=relaxed/simple;
	bh=FKXhz8s3Vd+6bRKnI5aQiQgbkf0y8yxy+g2UiuewnfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD3gEJjd1Gpuz6kqOEF2H8Su/Ef1JOSXDz94WJj1OLPeJYmlyThztZMbWaPmKIPN7jC4gKBUx2YGQ2HuJ7V8SqwG5/HOsOvk/lK9SBtW6vCdQcJmfdgbksfcGN3aj9E/zPx+Y9leqaDsy/W9/1qWxOkUBup6k+JEmFeu7KhQep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTGCVosG; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTGCVosG"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a168dc590cso1487855eaf.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782836531; x=1783441331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acv2p4BFA8gRpGMf2Eyfsq9WFKOfOwtHU816xigiBjE=;
        b=HTGCVosG9oSF0wEgAY1J3YyXXXtYbM+vXztpU7O2hxBrrc3iM576tswjlVl/neAWkN
         /rH5+SMvFz29UuUxDptcQjG88KCg1EELxJimP5+HwTDntZy3ZDhc5HdI0D2pFJxTz0yP
         PsVVlH7SfF4rNc2Zd9XgjWIEHmPAqXq3iIPFIVxe+KyIyYpTAseymMp97kCghPvgmtSe
         NOABgycwQyOV+Nu2Pn8GTFDqOpgLbm1YahPAS71JYTtu7BZsgBjWzbvwW87K4iMdyKHK
         3237HsHJwrpfPK3b4m2R2tiAbC/uonwOGaxVI9PcyrU2sJuj8Pj9VTS+QT0gB/ETc+Q5
         RkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836531; x=1783441331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acv2p4BFA8gRpGMf2Eyfsq9WFKOfOwtHU816xigiBjE=;
        b=CQ+aLxOxNFa9Mwxm+l23k+HujPz0pl+hNWG/lFOf1DegStrGVLKHTeTGiiytX/IQlQ
         XMJ6GlDt6etK8yHEf1KI8fdUEBYwiu/b+30Wsnx78DltBWPzYFZfLnb7LQJbagA+ZweE
         iREaVdklUfqlII5qGH4mBD5ZW7k7GCinv+jh0+/HYDqSjwFMbxV8lO/4JSzrGSV+XeH1
         Bq1nTYzHIYu2hoo4SBuYxF4dbJ8IT2j5FXJRcLyru47uZVe4Bz6ap2yJU82RrSoJ4Iuh
         chyMTyiJ6RSjAkolp2edVAfI+xurt64wynpVrsXprc9ufwosTEul03x37sKMYLvw86tS
         XYjw==
X-Forwarded-Encrypted: i=1; AFNElJ80x5wxqGHH/ITF05VCnjMIlBEVr3vWpY7DB3VNeuZZ5cL0g9avZOBzVkgYDvK5dHDo9vfWEHC1xQEHIovk1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ1S9rLjpPBASu0YotZEBE46NEPeuYHoGHvXRjY3+l6N1n1Ayo
	23w8cW9dYCZ1Bk/ObNMZO7l424UWkuCl9DKUUW6LtVHRQbqBN28h3Dny
X-Gm-Gg: AfdE7cldh0zDctYU2ixVKWJCU2PXrJbsMjPKz7GSrUy4KEz/6FaJ6pzclVjglbF3dPq
	s2c8QlRNRb/JCQj4uFF7VThdP693rENqVB+3BYgnOs76o/HbUz9Iuml+Rld+gyGd35c/OBfLuU5
	tB5wxSvXNyt+ch9ENm6Nk6EebwmSENkCZrTKxbPdXQB2xlGH/Gsa7/MiOlwaQ9cZiR/ANbFmhEn
	d1V5x9D9msZscj0/x774DugWBsN6XVYnBDHE2ZBR8LFXctNNkBxB/X5Z4MA+alZuxPVPESWL9uv
	805C0BoxfJpxXh+amczn/6warqVTOg8HHFCGJoMDOGnHPNyIrzXO141uJHPNTrTFbRAhcWcHFD1
	bYtRxiMdJgaVsjlxGtaYoo176EHlQYZg6lUXBKSJwJxWfQos3J/prBCTyDo40/F1kTZItoPDZgt
	XzQmPnesFuwn+aYZQDsIsL7ZPL6DOkAI3yIdJKT37WJmA=
X-Received: by 2002:a4a:d2e1:0:b0:6a1:154c:8199 with SMTP id 006d021491bc7-6a1891d3bdemr2567738eaf.40.1782836530787;
        Tue, 30 Jun 2026 09:22:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:13::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a189493f93sm2155547eaf.14.2026.06.30.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:22:10 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RESEND PATCH v2] mm/memcontrol: Avoid stuck FLUSHING_CACHED_CHARGE on isolated CPU
Date: Tue, 30 Jun 2026 09:22:07 -0700
Message-ID: <20260630162208.1159952-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630070004.470181-1-hui.zhu@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 15:00:04 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:

> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> drain_all_stock() sets FLUSHING_CACHED_CHARGE before calling
> schedule_drain_work() to queue per-CPU drain work.  When the target
> CPU is isolated (cpu_is_isolated() == true), the work is silently
> not queued, but FLUSHING_CACHED_CHARGE stays set.  Every subsequent
> drain_all_stock() then sees the bit and skips this stock entirely,
> so the entry is effectively pinned until something else on that CPU
> runs drain_local_*_stock() and clears the bit -- which on a long-
> isolated CPU may never happen.

Hello Hui,

I hope you're doing well! Thank you for the patch. I've also been
thinking about memcg stock and specifically on how the flushing happens.

I haven't been thinking about the issue of isolated work taking a long
time, but I have been reworking memcg stock by getting rid of it and
pushing it down to the page_counter level [1].

I think that this patch is still important because of the obj_stock
portion, which my series doens't touch. I just wanted to bring this
to your attention! I don't think there should be any other problems.

Thank you again, have a great day!
Joshua

[1] https://lore.kernel.org/all/20260623180124.868655-1-joshua.hahnjy@gmail.com/

> The original idea was to actually perform the drain from the calling
> CPU on behalf of the isolated one, by adding a lock around the
> per-CPU stock so that a remote drainer could safely touch it.  In
> practice this turned out to be intrusive: the stock data structures
> and their fast paths (consume_stock(), refill_stock(), the obj_stock
> helpers) are deliberately designed around current-CPU-only access,
> and retrofitting cross-CPU serialisation onto them adds non-trivial
> locking and PREEMPT_RT concerns for very little gain.
> 
> Looking at the actual amount of charge that can accumulate in a
> single per-CPU stock, it is bounded and small, so leaving an
> isolated CPU's stock undrained for a while is not a real problem.
> The only real bug is that the stuck FLUSHING_CACHED_CHARGE bit
> prevents future drain_all_stock() callers from re-attempting once
> the CPU is no longer isolated.
> 
> Fix this minimally by clearing FLUSHING_CACHED_CHARGE when the work
> could not be queued because the target CPU is isolated.  The cached
> charge itself is left in place; it will be released the next time
> the CPU runs drain_local_*_stock() (e.g. after leaving isolation,
> or if the isolated CPU itself calls drain_all_stock() -- in that
> case cpu == curcpu causes drain_local_memcg_stock() to be invoked
> directly), and the next drain_all_stock() call is free to retry
> instead of skipping the stock forever.
> 
> Fixes: 6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated cpus")
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
> Changelog:
> v2:
> According to the comments of Waiman Long, updated fixes.
> 
>  mm/memcontrol.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6dc4888a90f3..2e66b4a2c25d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2256,7 +2256,8 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>  	return flush;
>  }
>  
> -static void schedule_drain_work(int cpu, struct work_struct *work)
> +static void
> +schedule_drain_work(int cpu, struct work_struct *work, unsigned long *flags)
>  {
>  	/*
>  	 * Protect housekeeping cpumask read and work enqueue together
> @@ -2264,9 +2265,22 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>  	 * partition update only need to wait for an RCU GP and flush the
>  	 * pending work on newly isolated CPUs.
>  	 */
> -	guard(rcu)();
> -	if (!cpu_is_isolated(cpu))
> -		queue_work_on(cpu, memcg_wq, work);
> +	scoped_guard(rcu) {
> +		if (!cpu_is_isolated(cpu)) {
> +			queue_work_on(cpu, memcg_wq, work);
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * The target CPU is isolated: the drain work was not queued.
> +	 * Clear FLUSHING_CACHED_CHARGE so that future drain_all_stock()
> +	 * callers can re-attempt instead of skipping this stock forever.
> +	 * The cached charge is left in place; it will be released the
> +	 * next time the CPU itself runs drain_local_*_stock() (e.g.
> +	 * after leaving isolation), or by a follow-up mechanism.
> +	 */
> +	clear_bit(FLUSHING_CACHED_CHARGE, flags);
>  }
>  
>  /*
> @@ -2299,7 +2313,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  			if (cpu == curcpu)
>  				drain_local_memcg_stock(&memcg_st->work);
>  			else
> -				schedule_drain_work(cpu, &memcg_st->work);
> +				schedule_drain_work(cpu, &memcg_st->work,
> +						    &memcg_st->flags);
>  		}
>  
>  		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
> @@ -2309,7 +2324,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  			if (cpu == curcpu)
>  				drain_local_obj_stock(&obj_st->work);
>  			else
> -				schedule_drain_work(cpu, &obj_st->work);
> +				schedule_drain_work(cpu, &obj_st->work,
> +						    &obj_st->flags);
>  		}
>  	}
>  	migrate_enable();
> -- 
> 2.43.0
