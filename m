Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254616;
	b=c6L6EiWNyyDIm9qBl9k4CChaSVo5EivdDmYjpvjzT7UVlqfB/hD62EzxL+v7GL9EX7da
	 1gQlMfkGeLsnNwZHsfsf7x3i3Ho/1j6AxvpaaHt67nltAbXltCMX2fAriBAPxqaa7TTRz
	 4QJK/8UaVifyX62u3knmG4W9RcV1uKXGOXadVdIrBM6FvHO87f6oH1BqKCBXxKzz+atOK
	 QTBNWMbffGX3Z5OkSySonSbLvqBH108RTww7gCss+GW3ExcyqWtBbAaXDt0XDlzYZa9IV
	 +gQtSS4ypZiVHG0zt3joUXWHBkFsMOEoOdBhW5wOF/67JOUShp7H1ZcdtGcVtpNJEyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hO10aJTqcdq/ahujE/caCvdQLD1fV3nWWuPROud/Q5U=;
	b=SIfXZSZcShluhGBWGvVnzNSEYqVn2S4HXCTviKlxxoklpF4CDIt0VTJ4rWdaBp3EzcuM
	 pZWEyCEms1Be5I9UEuSF2kugfoLPD2pJzwwlDRLwJV57Ol3So3qeEEMTX3UuDilQZNsgY
	 COMiPFGld/Zzbo0huu4AbFKrfg953032+ZgQaCo5ZMqmh6HHkmR+nfrtZV1k4U8cwEG2F
	 pmwWRJvna8iBQBTADL2AlZQnLtEiw8ZT0iNQvgbBrv9gCaDlAe0tKMPTLDVye4sxZ7kMi
	 sqcPu11zz12GUMaWivC9IncM94imZtZBtAF+gLQdMWxuSE05DSEobODLDo1FydB00fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJhEDcOb;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E307F606A31C
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 20:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E307F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJhEDcOb
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e3b22e971so702576f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 12:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794254614; x=1794859414; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hO10aJTqcdq/ahujE/caCvdQLD1fV3nWWuPROud/Q5U=;
        b=mJhEDcOb24PyM0txSPKlgcyRsPUYX+nyjdj7f63XLdOxLo5V1gZSOy06oTPLPX2nUO
         xG3c1okXoEcGDvn059A1fLMh2V07m+xweWeFBNNqk34i+nQKm5JdwqfeGI+sJ38hyUdP
         mVLRc4sMsP+qlC0wIBg55EaAUcbbYpZZrUFAM/xsv/Mz97Mi7it3VKAHu8US+eM8RdUv
         aUYgrKfXJ01ef3UQlItZV7Aqt7ff0+8SN1qI6Fsn7011exvyO0LdjFOBFfmJDNM/9dF4
         Y5fmoU+mLd+3HjwHcvN0bWeVTybbpTmNQVyy2gozFBY38gO5bOVhVi5oM7hCmMKXlVDG
         JPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254614; x=1794859414;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hO10aJTqcdq/ahujE/caCvdQLD1fV3nWWuPROud/Q5U=;
        b=Juj0yjQO8uAA5+5fKEpaZ28xt/aYfo5/Vkpdlf8mGo8gvbqY0aWlIZ34AEU6ev8V/q
         FOQaSUSv0/aryw5vga6nkk0nPRRFXJ1duNzD48+1iYC1rGZcKFcKx2y1Af/hR9P8Q2Dd
         7/dXSj8tVCa/LHGbnRRf2N2Ma4ifuIrfCofj+YiVi76i8F5tHSv5kKOiM8s/TDLGAFCt
         ESDlemkESPmikRVwS+X0oe+vh/MgwTGPSNiU5d0PZEHPDCy5LF8fPE8wuEdlmJUBGggH
         LGXjgSSu6Sj1V7Q+y9iS6WSJOqec16nT+R8bJ6XuJ+h/liqGJWzav3pa4PMMo2tfs/Gk
         8+TA==
X-Forwarded-Encrypted: i=1; AL+hErGxeyVpOV9Brpz7hf6kbJBU01jo5erlIAk4TN7mF0lBFxYC+5vVut+2vDZpU34KTUhs+6Q8zlim/Ey3JYS0mA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+bikVgZgkcn7xONxmakNp4ZEBK8Cmn4GVblczMgUMRhn5ZtJ4p
	vtNiciHbbEtuPXpNKHA/YkL1S8Jwg1mOX7z7+3+Mv/e++ToDVqISbVGHYEwHSds+
X-Gm-Gg: AYBFou0bTSXQJHeRmizKRHWH47jG98D+JA+iZd3mvqsNXuLa00ZmofDsMDJKkJ8jwgQ
	34rQ0yFTIjn3gCfM9rlIAxy9znsB13/7MmxuvgZuu8iqKq6MFAP6MGrOE/iUTdgkQhCCvOmee3F
	yiZuwGTRohkOaw2dv0rPptBx2xw3jO7PMrsGuU0kzzHGXl7XawWj2skyVI6hpM6Avgk934YdzDL
	90KaXdN2YbUIii6VIyS8a2lU3xFnt9vnhzG/ptU45mxq9alDHkpeldShQytkwmKQy/h5LNQhzXj
	gCK100IFzT4SwIlXsvgw+/Qsnnvk9LQCtJYgMwxLzSrU7WES/C7qyywuYsG0tEBX/yJkG1/2J7A
	j7thSFb0PUMVh3sMH+oWMCy3hqPNBe0G5OGNN7VjQJA3Fd9vP5w01Fa6Oa9dKXjnTD3d5A1iVrP
	r5A67jTgLgSi12BPC7caEhTrbrWt1GBBxMiioLgyysrfgoJBGzIWGFE/C6KqyaTVvc6VgGIk7FP
	mxze6+SkZVdmNka/l0aBUTr+tdZIpjEz8QWJvZwW/Xoj3utTGS9121A4fbgtVecvZWsOMolS4xA
	3lHuEcHHn2q8/FnKFuyyLyB4UO+2nF/osl4Z58/TaVgN44CIQbCuPd/fJiv3pEpK
X-Received: by 2002:a05:6000:4549:b0:492:b5e9:4916 with SMTP id ffacd0b85a97d-4982f874041mr553519f8f.24.1794254614069;
        Mon, 09 Nov 2026 12:03:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835858f64sm874068f8f.16.2026.11.09.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 12:03:33 -0800 (PST)
Date: Mon, 9 Nov 2026 20:03:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 rostedt@goodmis.org
Subject: Re: [PATCH v3] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Message-ID: <20261109200332.52e2fc0e@pumpkin>
In-Reply-To: <20261109180748.33682-1-haoranwangsec@gmail.com>
References: <179241614797.5916.13928836073297916808@whr>
	<CANZ3JQQrrntu0TefPZC79pKSmsOfwAngRJyuaVm81DYaJNFHFQ@mail.gmail.com>
	<20261109180748.33682-1-haoranwangsec@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Nov 2026 18:07:48 +0800
Haoran Wang <haoranwangsec@gmail.com> wrote:

> ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
> current CPU's pool with per_cpu_ptr(), then acquires the pool's
> spin_lock_bh() while preemption is still disabled, and finally put_cpu().
> 
> On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
> (rt_spin_lock), so the task may sleep with preempt_count elevated:
> scheduling while atomic, reported as a BUG by CONFIG_DEBUG_ATOMIC_SLEEP
> and a deadlock once the lock is contended.  Any iSCSI offload I/O
> through a Chelsio NIC that reaches ppm_get_cpu_entries() triggers it.
> 
> Read the current CPU with raw_cpu_ptr() without raising preempt_count,
> and derive the global index base from pool->base (initialised when the
> pools are allocated) instead of cpu * pool_index_max, so the base
> always matches the pool that was locked.  The owning CPU remains in the
> debug output, now derived from pool->base.

I think you really need to explain why it doesn't matter that the pool
for the 'wrong' cpu is used.

You don't need a big explanation of why you can't call spin_lock_bh()
with preemption disabled, it is probably enough just to say that you
can't (the most reason would be 'can sleep on PREEMPT_RT kernels).

This is separate from any issues of acquiring the wrong lock.
I'm not sure about the trace, if you are tracing the cpu the data belongs
to - then that should be what you call it.
Once you hold the lock I think the cpu is fixed (even under PREEMPT_RT)
so you could trace the actual cpu as well - especially if anything 'funny'
might happen because the data wor the wrong cpu is being used.

Of course, it the code is just trying to avoid lock contention (and maybe
reduce cache line bouncing) it may not matter at all which copy of the
data you get.
In fact one for each cpu may be excessive - think of systems with 1000s
of cpu not single digits.

David


> 
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
> 
> ---
> (Resent with the complete Cc list; the earlier copy reached only you.)
> 
> Hi Sebastian,
> 
> thanks for the review.  v3 below addresses your comments:
> 
> - The commit message now describes what the patch does; the review
>   rationale moved into the changelog below the --- separator.
> - PREEMPT_RT spelled out.
> - pr_debug() keeps printing the owning CPU of the pool, derived as
>   pool->base / ppm->pool_index_max; the global index stays
>   i + pool->base.
> - Tested on: x86_64, compile-tested with CONFIG_PREEMPT_RT=y and
>   CONFIG_DEBUG_ATOMIC_SLEEP=y; no Chelsio hardware at hand, so the
>   change is not exercised on real offload I/O.
> 
> Changes since v2:
> - Keep the owning CPU in the pr_debug() output, derived from
>   pool->base / ppm->pool_index_max (suggested by Sebastian).
> - Reword the commit message to describe what the patch does and move
>   the review discussion into this changelog; spell PREEMPT_RT.
> 
> Changes since v1:
> - Drop the cpu variable: read the global-index base from pool->base
>   (initialised at pool allocation) instead of a cpu captured before
>   the lock, so the base is always consistent with the pool that was
>   locked.  The per-CPU pools are shards of the global ppod index
>   space and not tied to the running CPU (ppm_unmark_entries() derives
>   the owning pool from the index itself), so locking another CPU's
>   pool after a migration is a cache-locality matter, not a
>   correctness one.
> 
>  drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> --- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> +++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
> @@ -119,16 +119,13 @@
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
>  
>  	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
>  				    pool->next, count, 0);
> @@ -145,10 +142,10 @@
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
> @@ -375,6 +372,7 @@
>  
>  		memset(ppool, 0, alloc_sz);
>  		spin_lock_init(&ppool->lock);
> +		ppool->base = count;
>  		count += ppmax;
>  	}
>  
> 

