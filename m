Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A43A9D92
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Apr 2026 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496305; cv=none; b=vE1M9RTPbxd+xvnL75W6weYJUNDNqtJAVZglZ6RvgdU+D6ZFXm/JPYUxglUQ5KlXy9ui4Dp1zW/Sn9vgToPCoFOluVyDUhohi1iiLmWNMRJ6jdNkE/ounPu1HWddXzTuh3V5ska4UIOcXLXDt0ZBN3G8C+sUoo5NzUSLzLMCPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496305; c=relaxed/simple;
	bh=H4PfGyMnPiSQn1my4AwccDfLneDKKhcFDfiOgWxT+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afKSNhLjeDCwVF8Wbcz8x8EfcskoPCRFD+f69qBVjfpGZ5DpcqbtbJV9hA0feKnX79sGg5NzwMvVtHfft8/iJVB7HHCY4bqrIQc4KZy1QTqeeeTvZwuXc8EAfdnlO++agekMz3dtGwqe7TFpGocIqu676Xm3VnRV98APg5q6ZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwELQeCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwELQeCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777496303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1NyF1QURy3vdICAxiB0jl9JGp6DuWbQaRj+rdabH/M=;
	b=VwELQeClfzSWB9Q623xKqWRnflhnnh1xzWO3Htg8xwEz4zbg60GMFSc3bRp+B2dvhUGDNR
	SkU0ClDHYRq6HiuYXpeKPLnqitBK5lcfh3fEPfYM+89Y7iO5fG0G8ZDI6ZML7PCtSh9/zF
	PXNNEn+L8oAFLCpQ8QOxZwH7X9IVYDU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-rBBwcJqwPxeaG3FBplukoA-1; Wed,
 29 Apr 2026 16:58:18 -0400
X-MC-Unique: rBBwcJqwPxeaG3FBplukoA-1
X-Mimecast-MFC-AGG-ID: rBBwcJqwPxeaG3FBplukoA_1777496295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D94C118002C0;
	Wed, 29 Apr 2026 20:58:13 +0000 (UTC)
Received: from [10.22.65.94] (unknown [10.22.65.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3F75300019F;
	Wed, 29 Apr 2026 20:58:10 +0000 (UTC)
Message-ID: <68ba05da-7052-406a-9ddd-b324a349ca80@redhat.com>
Date: Wed, 29 Apr 2026 16:58:09 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memcontrol: Avoid stuck FLUSHING_CACHED_CHARGE on
 isolated CPU
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <20260429022723.133833-1-hui.zhu@linux.dev>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260429022723.133833-1-hui.zhu@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ouRojLS1bBFLuLbfvqM1irCrMwxXF7zr7l-y7bXgukk_1777496295
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 10:27 PM, Hui Zhu wrote:
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
>
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
> Fixes: 2d05068610a3 ("memcg: Prepare to protect against concurrent isolated cpuset change")

I don't think this is the right commit to blame as it didn't really 
change the logic other than adding RCU locking. I think commit 
6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated 
cpus") is the right one as this is the commit that adds the 
cpu_is_isolated() check first.

Other than that, the patch looks good to me as the list of isolated CPUs 
is runtime changeable.

Cheers,
Longman

> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   mm/memcontrol.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f..cee77b0a95f5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2219,7 +2219,8 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>   	return flush;
>   }
>   
> -static void schedule_drain_work(int cpu, struct work_struct *work)
> +static void
> +schedule_drain_work(int cpu, struct work_struct *work, unsigned long *flags)
>   {
>   	/*
>   	 * Protect housekeeping cpumask read and work enqueue together
> @@ -2227,9 +2228,22 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>   	 * partition update only need to wait for an RCU GP and flush the
>   	 * pending work on newly isolated CPUs.
>   	 */
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
>   }
>   
>   /*
> @@ -2262,7 +2276,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>   			if (cpu == curcpu)
>   				drain_local_memcg_stock(&memcg_st->work);
>   			else
> -				schedule_drain_work(cpu, &memcg_st->work);
> +				schedule_drain_work(cpu, &memcg_st->work,
> +						    &memcg_st->flags);
>   		}
>   
>   		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
> @@ -2272,7 +2287,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>   			if (cpu == curcpu)
>   				drain_local_obj_stock(&obj_st->work);
>   			else
> -				schedule_drain_work(cpu, &obj_st->work);
> +				schedule_drain_work(cpu, &obj_st->work,
> +						    &obj_st->flags);
>   		}
>   	}
>   	migrate_enable();

