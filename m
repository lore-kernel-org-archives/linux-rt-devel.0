Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9C2FF644
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Sep 2025 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186827; cv=none; b=T2qmLgBILmgcFPOrm+KYiG1lrwxQD3rg58wsWdNk/P7m8fi6YF0PJiuawkCRSNYwYdG+g59/OxtC7sh5ENTftRjHP7QsPjspAAXvhoNMWtD7O9wZjoc4KFP6gsH2qGh1Z68WRC+O1KMcIuEEEmBs7eQxwJv8bpffFh9e+SI5PyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186827; c=relaxed/simple;
	bh=v5M0KVbOs0+0BL/1Au1GWe2T0G2C337d/G6AKfJclMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWSY8yCG/BA0KM3pewzyk8CMk3rZKmy063eLn+2fx9zuS5Yxsn+/lap8WDY9Z+yD5Fe0YMkMvGJumNYDLxsRRWsZkVlXlLGi5XM4nPKZ2UO2nRCbvQiYrSOCViEg+8QzgOaf/jksF3tc9XQoH6BYASa9KUmBdbseqQqJfr8hDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwC2kYCD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kRC17PKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwC2kYCD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kRC17PKP"
Date: Thu, 18 Sep 2025 11:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758186822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rI6MarwTjIECPHNDT6nYXfKNfdgGybieY2MAwuVSSU=;
	b=VwC2kYCDnAmg7pqSUYgyWBaXT8jlTN+tC/5v2iKarJs6pN1KFhddN8J8PpMjDyfz3ooJpv
	vZjzaSw7uW+bPNTipxB1bN3vnaF0hNbBwIF5jjNEM4Sp6pMRIoZ8umTBnSr4FiMaxZ7K9v
	6NA+YTNS4rFP6sYbT4l9dhruFjVGmZsB1054tGZdqUA2cIlPa4tVAZtW+u0Rcqg7X7X+5M
	j7ZGu5ZwvZY6LXfCV7+EsKAqjmj+12qjk+b1U933BgFwpHYkb3DpS92Ov/nrbKBR6mgltG
	eofRjuOIXU0mBiVKNQTesPlEjeJkuB43yq9x1UKqOvY0CPCJ0cR8b6hSQsIY2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758186822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rI6MarwTjIECPHNDT6nYXfKNfdgGybieY2MAwuVSSU=;
	b=kRC17PKPNGrHDCN1JtgSeQoLHsDtQncZgecqJa9CX1g+vXf9/Nnh3VnRziDLfffITkhu9H
	xkp6B6izdQGy/fAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <20250918091341.n6_OgbOW@linutronix.de>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918084823.372000-1-dtatulea@nvidia.com>

On 2025-09-18 11:48:21 [+0300], Dragos Tatulea wrote:
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index ba70569bd4b0..404064d893d6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
>  		return false;
>  	}
>  
> +#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
> +	if (unlikely(!page_pool_napi_local(pool))) {

if you do IS_ENABLED(CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE) you could
avoid the ifdef.

A quick question, where is this allow_direct argument supposed to come
from? I just noticed that mlx5 does
   page_pool_put_unrefed_netmem(, true);

which then does not consider page_pool_napi_local(). But your proposed
change here will complain as it should.

> +		u32 pp_cpuid = READ_ONCE(pool->cpuid);
> +		u32 cpuid = smp_processor_id();
> +
> +		WARN_RATELIMIT(1, "page_pool %d: direct page release from wrong CPU %d, expected CPU %d",
> +			       pool->user.id, cpuid, pp_cpuid);
> +
> +		return false;
> +	}
> +#endif
> +
>  	/* Caller MUST have verified/know (page_ref_count(page) == 1) */
>  	pool->alloc.cache[pool->alloc.count++] = netmem;
>  	recycle_stat_inc(pool, cached);

Sebastian
