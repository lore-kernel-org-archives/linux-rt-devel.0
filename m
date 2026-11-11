Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413295;
	b=fJxcTJpR0S9/j94aVA4pnDLtkojYQWzyKKU5e09ZFXxoif0imepKi2DffcI8Ovn71ykG
	 UiPjY7+zy0w7yuddfyriGo/TnXRMmNU3D0NBGVzbCgKAr/ulqTsFGWuduYBQmkuIVKmlZ
	 6bAFoda6RFnjMGD3xP3+htEi2zCrnRHgZ6U8utoR7Wl8dZJl35fxint7XBscvIbMbpe7c
	 kdEc+5JwJx5O5eSfO9LG790yfpa1iPW2Kx8tWNzZANts9nbtogR4wYLaslAdMTYJlRjPI
	 KUUG+/UjSIKdTg7AN2ykFIbSf7uAEUB6LQJ4CdpmuCJwovIpLPnBmEuiYAUFG56hN+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413295;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bqR+F5Cu2cpA5OZAVf1AXWWlYtWd7xJLjOh702/W4M8=;
	b=UeFE9AorQfjnX+DL1ooMFh7ToLtQWaHQrJcyIPzNgjoioTUkBBoR8hGPtG246Tkgebvz
	 VkAgN49Y4tbCwUTFLIy6q8HxqEMt6u0kHZBr93+hYiVJhKM7IY2H4lyAADW87hSGYJ8tz
	 2ukrNE5z0qaajtaxYXtrZTGz+TqkO6c81i1HFK4SN/rg7tJqwlE6epsHoE0E8Pjst366Y
	 NDcMITmKUf3YxjVp0re/kR42NznivloXnk6eBW2M3oHvi4PtwrMm9GtOk0qqTpD6Gn/WR
	 kLzSddQeen8ntai4gJgiPOnrLBMmbszlmrRVFNSglsm6YjYbziiLdjTubzHRuK92MPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWx0jylW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75310606A321;
	Wed, 11 Nov 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWx0jylW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0A31F00A07;
	Wed, 11 Nov 2026 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413295;
	bh=bqR+F5Cu2cpA5OZAVf1AXWWlYtWd7xJLjOh702/W4M8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dWx0jylWZSrsY/6pvcQw2KjLLIT/sFqNulj9Q3oSOlS3VkE/LN1p+2124qDB3+kc+
	 yF/9BugE86YznVa4A4huWrcyNqnO1cMlL9D4cK4XV7fQwSuzSa4p4jBB5gVNbR9wc7
	 Y0gRq4FyPWrEHdQ+6UvOPXrCAuVONfAsZ2ntNLJvprLe8tYim50xzqmPbC6EHs+uVV
	 dd2gtaMcyoeJeof8Vj3xPZ7a8ooiFXd4EIAJAngv+WjgQF0IHp0TVfu1tiqeydcCSL
	 lNlQd/ys5aaUVulcNG7Z+MvLP+jqlvEmLm8K7ynrs60UxzQq6xw/XsjvyLbaiRNJA9
	 OCReJ69uGWJzg==
Subject: Re: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
From: netdev-bot+sashiko@kernel.org
To: haoranwangsec@gmail.com
Cc: bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Date: Wed, 11 Nov 2026 16:08:14 +0000
Message-ID: <179441329408.2199510.4180666422903927699@kernel.org>
In-Reply-To: <20261109180748.33682-1-haoranwangsec@gmail.com>
References: <20261109180748.33682-1-haoranwangsec@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch changes how ppm_get_cpu_entries() encodes the global
  ppod index but leaves the release path decoding it the old way.
- [Low] The commit fixes a user-visible PREEMPT_RT bug in
  ppm_get_cpu_entries()…

--

libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()

The commit removes the get_cpu()/put_cpu() pair around spin_lock_bh() in
ppm_get_cpu_entries(), so the code no longer takes a sleeping lock with
preemption disabled on PREEMPT_RT. It reads the pool with raw_cpu_ptr().
It also builds the global ppod index from a new pool->base, set in
ppm_alloc_cpu_pool(), instead of cpu * pool_index_max.

> diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> index 2e3973a32d9d1..7fb6c8a41e98f 100644
> --- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> +++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> @@ -119,16 +119,13 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
>  			       unsigned long caller_data)
>  {
>  	struct cxgbi_ppm_pool *pool;
> -	unsigned int cpu;
>  	int i;
>  
>  	if (!ppm->pool)
>  		return -EINVAL;
>  
> -	cpu = get_cpu();
> -	pool = per_cpu_ptr(ppm->pool, cpu);
> +	pool = raw_cpu_ptr(ppm->pool);
>  	spin_lock_bh(&pool->lock);
> -	put_cpu();

[Severity: Low]
This isn't a bug, but should the patch have a Fixes: tag? The sequence
get_cpu(); per_cpu_ptr(); spin_lock_bh(); put_cpu(); dates back to the
original page pod manager, before the file moved to libcxgb:

Fixes: 47da7e62b391 ("cxgb4: add iSCSI DDP page pod manager")

>  
>  	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
>  				    pool->next, count, 0);
> @@ -145,10 +142,10 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
>  	spin_unlock_bh(&pool->lock);
>  
>  	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
> -		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
> -		pool->next);
> +		 __func__, pool->base / ppm->pool_index_max, i, count,
> +		i + pool->base, pool->next);
>  
> -	i += cpu * ppm->pool_index_max;
> +	i += pool->base;
>  	ppm_mark_entries(ppm, i, count, caller_data);
>  
>  	return i;
> @@ -375,6 +372,7 @@ ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)
>  
>  		memset(ppool, 0, alloc_sz);
>  		spin_lock_init(&ppool->lock);
> +		ppool->base = count;
>  		count += ppmax;
>  	}

[Severity: High]
Does the new encoding still match the release path?

ppm_alloc_cpu_pool() walks the pools with for_each_possible_cpu(), so
pool->base is the CPU's position in cpu_possible_mask times ppmax. It is
not cpu * ppmax. ppm_get_cpu_entries() now returns i + pool->base.

ppm_unmark_entries() is unchanged and still treats that value as a CPU
id:

drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:ppm_unmark_entries() {
    ...
		cpu = i / ppm->pool_index_max;
		i %= ppm->pool_index_max;

		pool = per_cpu_ptr(ppm->pool, cpu);
		spin_lock_bh(&pool->lock);
		bitmap_clear(pool->bmap, i, count);
    ...
}

If cpu_possible_mask has no holes, position and CPU id are the same.
If it has holes, they differ.

With possible = {0,2,3}, CPU 3 is at position 2. So
cxgbi_ppm_ppod_release()->ppm_unmark_entries() clears CPU 3's entries in
CPU 2's pool:

- CPU 3's bits are never freed.
- CPU 2 can hand out an index that is still in use, so two live DDP tags
  could share one hardware page pod.

With possible = {0,2}, CPU 2's entries decode to cpu 1, which is not a
possible CPU. per_cpu_ptr(ppm->pool, 1) then points at a slot that was
never memset() or spin_lock_init()'d. The code takes a lock in it and
clears bits in it.

The new pr_debug() above also prints this position as "cpu".

The v1 changelog says "ppm_unmark_entries() derives the owning pool from
the index itself". After this patch, the index it decodes no longer
matches how ppm_get_cpu_entries() builds it.

Should ppm_unmark_entries() be updated as well? For example, it could
find the possible CPU whose [base, base + pool_index_max) range holds
the index, or the owning CPU could be recorded.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109180748.33682-1-haoranwangsec%40gmail.com
