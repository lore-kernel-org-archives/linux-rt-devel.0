Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427492;
	b=cwdsb8efqHEEfODozkDWLsOZBYMuw42W6Rgbqqta0ekmqyoc+on5PMoyW8j7cpRIAFbY
	 z5v/ZCGYG+wnUW45VxRzbbFENKh1VDL8/8EbSRuHWKGnxQg6kMY8BK8UJW2bDU/nLVn5m
	 UuBhBmjrZvCx7ARkFPqZwY1A1ZYRex6kYWsNAi1UE/x7MqYrDhCpXv50pF9GDDE7RSEKe
	 2VYIBNj7aNlzCnx1SUE6iZqUkqSnTMW8ZCdpUiZuNZgb9e/ItxKQ18amIFauSnW926G3A
	 CMtaA7nU4g4HSnje5oGlKPHGW0KqCP/fCCjXoMWTCvPyXpEU+QMgipUa6qiRnhtgBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427492;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OxNLSkFk8Y5cB7ol8XF126M3ZjDkbAL+tIa/C0CcN54=;
	b=29Pc6qcEb0uIlJTX5yLRlCksR5Oo0vTFljfoq12yw+d7xYjTNjDRnbcuDVRIDgmwMkxz
	 z4kp+iXmLmgR6qXr8OceCHuVSzlEi1zDW4sB6D7msPj9UfpchGSv2XqaJYrsDiSiFDPDJ
	 9iuWGUI/ReRc4kquvPqqP/9arFkxDDGw1oPkD+L/NhHGucZsEa0qho0xxRZwZ6k/JUCv2
	 cJpYIg0X81vKWsc/xrNOalvAUlAv38U6jO5rymc2ZwuMzFpto84z+EvZGh9M3GS9FelC3
	 RwxENya7u+AG/IpoggnbYuPnTtZjR/p5fUhgoscvnVWyQ7dQS1fisRxA+yxlkzji/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mV90rbyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F55C606A31A;
	Mon, 23 Nov 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mV90rbyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6AF1F000C6;
	Mon, 23 Nov 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795427491;
	bh=OxNLSkFk8Y5cB7ol8XF126M3ZjDkbAL+tIa/C0CcN54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mV90rbyg/SZC/gcRySu0H3M6+HmUvEPiTaN5oE8pUT/I5b7pSAM8vh1r5mYBnv1Ae
	 NHKK6eegICAg3gq4EGol495w6hNHx2l1on6m6uJBIhbG4+QQzcUDkvFwOJ7vqmLbK7
	 cniwjhgeN84a/DkBVBZBOv7K1I3ENl5PnNCH5p4dpBLG7WjoCjwZnDa3IrNJSYTh5r
	 TTHYlOcecJrv0d5VTLAnb87oJgEmclp9FfGxQRJ5p//u91V9vqzXUYYO0PckF0nIAm
	 5NjrHjdyroI2zTgG7ZgMNss1znOTgXXCbz68lYuqkmNr6EIOc4/EJpk00tNcLgvQjX
	 ezm36itsTL6eA==
Subject:
 Re: [PATCH net v5] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
From: netdev-bot+sashiko@kernel.org
To: wanghr2026@mail.zgclab.edu.cn
Cc: david.laight.linux@gmail.com, bigeasy@linutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Date: Mon, 23 Nov 2026 09:51:30 +0000
Message-ID: <179542749046.3135.7766812948211328242@kernel.org>
In-Reply-To: <179508121445.22600.6953098503196332718@mail.zgclab.edu.cn>
References: <179508121445.22600.6953098503196332718@mail.zgclab.edu.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes the allocation and free paths in
  drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c compute a pool's…

--

libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()

This patch replaces get_cpu()/per_cpu_ptr()/put_cpu() with raw_cpu_ptr()
in ppm_get_cpu_entries(), so spin_lock_bh() is no longer taken with
preemption disabled on PREEMPT_RT. The task can now migrate before the
lock is taken, so the global index base comes from a new pool->base
field set in ppm_alloc_cpu_pool() instead of cpu * pool_index_max.

> diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> index 2e3973a32d9d1..837bdf4128370 100644
> --- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> +++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c

[ ... ]

> @@ -144,11 +141,11 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
>  
>  	spin_unlock_bh(&pool->lock);
>  
> -	pr_debug("%s: cpu %u, idx %d + %d (%d), next %u.\n",
> -		 __func__, cpu, i, count, i + cpu * ppm->pool_index_max,
> -		pool->next);
> +	pr_debug("%s: pool cpu %u, idx %d + %d (%d), next %u.\n",
> +		 __func__, pool->base / ppm->pool_index_max,
> +		 i, count, i + pool->base, pool->next);
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
>  

[Severity: High]
Does this base still match the decode in ppm_unmark_entries() when
cpu_possible_mask is not contiguous?

count is a running counter over for_each_possible_cpu(). That makes
pool->base the CPU's position among possible CPUs times ppmax, not
cpu * ppmax.

ppm_unmark_entries() was not changed, and it still reads the quotient as
a CPU id:

drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:ppm_unmark_entries() {
    ...
		cpu = i / ppm->pool_index_max;
		i %= ppm->pool_index_max;

		pool = per_cpu_ptr(ppm->pool, cpu);
		spin_lock_bh(&pool->lock);
		bitmap_clear(pool->bmap, i, count);
    ...
}

As an example, take cpu_possible_mask = {0, 2, 3}. cpu 2 gets
base = ppmax and cpu 3 gets base = 2 * ppmax.

An index from cpu 2's pool (ppmax + k) decodes on release to cpu 1. cpu 1
is not a possible CPU, so
cxgbi_ppm_ppod_release()->ppm_unmark_entries() would take a lock and
clear bits in a per-CPU slot that was never set up.

An index from cpu 3's pool (2 * ppmax + k) would be freed into cpu 2's
bitmap. Could that clear a bit cpu 2 still has in use, so the ppod is
handed out again while the adapter still holds the first DDP tag? cpu
3's own bit would also never be cleared, so those entries would leak.

The old code was already wrong on sparse possible masks, because
cpu * pool_index_max could go past pool_rsvd. This patch changes how it
fails: it now writes into a non-possible CPU's per-CPU area and frees
into another CPU's pool. Sparse masks do happen. For example,
arch/sparc/kernel/prom_64.c sets possible CPUs by firmware cpuid.

The commit message says:

  The free path, ppm_unmark_entries(), re-derives the owning pool from
  the global index rather than from the running CPU and takes that same
  lock, so any thread can service any shard.  Derive the global index
  base from pool->base so it always matches the pool that was locked.

That only holds if pool->base == cpu * pool_index_max. Would it work to
have the free path look up the pool by its stored base? Another option
is to use cpu * ppmax everywhere, including when computing the total.

The new pr_debug() in ppm_get_cpu_entries() has the same problem.
pool->base / ppm->pool_index_max gives the position in the possible
mask, not the CPU id.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179508121445.22600.6953098503196332718%40mail.zgclab.edu.cn
