Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452342;
	b=pQbL0+QEdVyIFcjBlB4u/Evi916K5qv0TuAyHeBYT+8e+8j+uX186QvcQnH3TfO5KYRR
	 KEm2R+eCDQyLTnsYNbUz8+9pSqT+WErQ0Uk57rkoVVRxysjQveCuGh2jgzoYXJS/jmZxG
	 Q9iNrYduz3gzdudt4Mp4cBZoylhICy36EutA0e04tLO9vagTJUim4c/EDTHZB26zYwo0l
	 MiXyS0ymiHMxUu69EDHBGH9iIJoH60rMGKpJ7n+6MsqGuSRhUb4lD6TPGZB3qUaiGXFvE
	 v8m/fXSXjVTrAZMw9uhdB+EM4c3u66IjkQEW0aQE/17OEpuEOVzbCiq5LyQG3Qx/TQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452342;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OvSQxUXvoz37Xllfghfy1IjhVE1RB1eaqEabCAt8sVA=;
	b=dlnLmJGSj6C/k7TGjWNN+NcLALE2CrIh6o/D2BILWQ+lNRFP2DZu4QhWaZuqt+LOeJ5m
	 oAFe/2PU9vj/lSI4WObN1crmOIUyKiOiAXs11NoYhcyzkpHH28bA8vi/Epux5xTeTa37z
	 QcGDcxpXtoNLZVDfq7RX2dbq4FoAu3lFW+jIe245iVrG5sjuxojNj5hibBnah10mdQalO
	 OkHSOKqsVQS2oXVm/rF/EThw5k6KVqtuQuTEcqsDRATFZW7uFLDHEgWrBi3eySDOAFh3M
	 AqcfqMgrqsf8d8EdkX/WjB/lEARm/mJFyrkUzt6HI22J0tT/xt4IDRoOW0nVk4iJCFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fs/8clVc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674F606A31C;
	Thu, 12 Nov 2026 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs/8clVc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0693E1F00A05;
	Thu, 12 Nov 2026 02:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452342;
	bh=OvSQxUXvoz37Xllfghfy1IjhVE1RB1eaqEabCAt8sVA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fs/8clVcZqko7ldeGcwJNDFqDWofg9kjfst0zEzNw0qXziPS9DSkBeMnMrIra48A7
	 bK9BAO89OCoi1jCBNnKxpb16dRwn/0d05p4yKedW00icfBykV/PH1OKNPj6ok7yINY
	 5HWfz5+Fp5gXiyfC4gdsLXugDwZnkGzmW+nsJbaKA3r/GqZr10XckE7tWV44DOGac1
	 3cMwuyybZeSi7x1YuMDdO8f37TtCpGSaGYrHms2mnf8E1d5wJW/4+sVDFDT7F/e9jv
	 +IivaL44c5QcQEtg4E1xXI0DStis4br1wuq2/qXDMG9jFh37C20VXlzwdLjavQbqrx
	 LfTK9QcWxJD0Q==
Subject: Re: [PATCH v4] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
From: netdev-bot+sashiko@kernel.org
To: haoranwangsec@gmail.com
Cc: david.laight.linux@gmail.com, bigeasy@linutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Date: Thu, 12 Nov 2026 02:59:01 +0000
Message-ID: <179445234141.2199510.13802580450865869960@kernel.org>
In-Reply-To: <20261110165742.1204-1-haoranwangsec@gmail.com>
References: <20261110165742.1204-1-haoranwangsec@gmail.com>
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

- [High] The allocation and free paths no longer agree on how a per-CPU
  pool index is encoded.
- [Low] The commit fixes a user-visible PREEMPT_RT bug: `spin_lock_bh()`,
  which is a sleeping rt_mutex-based lock on RT, is taken inside a…

--

libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()

This patch replaces the get_cpu()/per_cpu_ptr()/put_cpu() sequence in
ppm_get_cpu_entries() with raw_cpu_ptr(). As a result, spin_lock_bh() is
no longer taken with preemption disabled on PREEMPT_RT. It also stores a
base index in each per-CPU pool in ppm_alloc_cpu_pool(), and builds the
global ppod index from pool->base instead of cpu * pool_index_max.

> diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> index 2e3973a32d9d1..708013623c2f7 100644
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
Should this patch have a Fixes: tag? The get_cpu(); per_cpu_ptr();
spin_lock_bh(); put_cpu(); sequence appears to come from:

Fixes: 47da7e62b391 ("cxgb4: add iSCSI DDP page pod manager")

Commit a248384e6420 later moved it into libcxgb_ppm.c. Without the tag,
it is harder for stable maintainers to tell which trees need this fix.

[ ... ]

> @@ -144,11 +141,12 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
>  
>  	spin_unlock_bh(&pool->lock);
>  
> -	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
> -		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
> -		pool->next);
> +	pr_debug("%s: cpu %u, pool cpu %u, idx %d + %d (%d), next %u.\n",
> +		 __func__, raw_smp_processor_id(),
> +		 pool->base / ppm->pool_index_max, i, count, i + pool->base,
> +		 pool->next);
>  
> -	i += cpu * ppm->pool_index_max;
> +	i += pool->base;
>  	ppm_mark_entries(ppm, i, count, caller_data);
>  
>  	return i;
> @@ -375,6 +373,7 @@ ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)
>  
>  		memset(ppool, 0, alloc_sz);
>  		spin_lock_init(&ppool->lock);
> +		ppool->base = count;
>  		count += ppmax;
>  	}

[Severity: High]
Do the alloc and free paths still agree on the index encoding when
cpu_possible_mask has holes?

for_each_possible_cpu() sets base from the pool's position in the
possible mask (0, ppmax, 2 * ppmax, ...), not from cpu * ppmax.
ppm_get_cpu_entries() now returns i + pool->base. ppm_unmark_entries()
was not changed, and it still decodes the index as a cpu id:

drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:ppm_unmark_entries() {
    ...
		cpu = i / ppm->pool_index_max;
		i %= ppm->pool_index_max;

		pool = per_cpu_ptr(ppm->pool, cpu);
		spin_lock_bh(&pool->lock);
		bitmap_clear(pool->bmap, i, count);
    ...
}

Take a possible mask of {0,2}. CPU 2's pool gets base = 1 * ppmax, and
the release path through cxgbi_ppm_ppod_release()->ppm_unmark_entries()
computes cpu = 1. CPU 1 is not possible. setup_per_cpu_areas() in
mm/percpu.c only fills __per_cpu_offset[] for possible CPUs, so
per_cpu_ptr(ppm->pool, 1) does not point into this allocation.

Can spin_lock_bh(), bitmap_clear() and the pool->next store then write to
unrelated kernel memory?

Now take a possible mask of {0,2,3}. Entries from CPU 3's pool
(position 2) would be released into CPU 2's real pool.

Could that clear bits that CPU 2 has already handed out? If so, the same
page-pod index could be given to a second DDP tag while the first is
still in use, and CPU 3's bits would never be cleared.

The commit message says:

  the free path ppm_unmark_entries() derives the owning pool from the
  index instead of from the running CPU, so any thread can service any
  shard.

That only holds while pool->base / pool_index_max equals the cpu id. The
new "pool cpu" label in pr_debug() makes the same assumption. The 2-CPU
stress test runs with a contiguous mask, so it would not reach this case.

The old cpu * ppmax encoding was also wrong on sparse masks, because it
could run past pool_rsvd into the general pool. Would it work to either
update ppm_unmark_entries() to map the index back to the pool in the
same way, or keep base = cpu * ppmax and size pool_rsvd from nr_cpu_ids?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110165742.1204-1-haoranwangsec%40gmail.com
