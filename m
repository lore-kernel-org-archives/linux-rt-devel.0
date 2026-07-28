Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8229BD91
	for <linux-rt-devel@lists.linux.dev>; Tue, 28 Jul 2026 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201734; cv=none; b=OZ2NhFPzHxYY66+rFT/6qktuevAbcSGAVz1oLFJrDGupmX3jJtXZr/4WSXEfH4ZDessYG6GT/pnKLM4LT+c8MwZOL1y2ipYBf91UAramYBgHeyxJQTY0cM6fNUi0Vu27XdlQ7viS8bFZHZwdngjbEguyrt3SFIsFIkoh0Dm5Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201734; c=relaxed/simple;
	bh=KR3d4J6TdQmaXeU+C598kPlRAQnqek1rF2txBciKk5A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=DNgS+eKWw6rdg63JGtAjJaxdQHut0HZHRKUcOVLGIFaf7wmi5eJ6m9IAONKGeLpEDnLNpe9d5ycg9UtKcS76CvBWh2uK1kqadSuX3LVOUiEhMAUFz8HLGlqdvDEPdIMxoeAh9HI/rLEKWDOHCU4yT+q5L4tVJWYT3J6G6eYzZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tIu0V9Ai; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tIu0V9Ai"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso38448205ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785201732; x=1785806532; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jhdXb3S04B9c2xXxAlgzeVBHU0NJuj6Uw/SLtYwV8xw=;
        b=tIu0V9Ai8w7GkY4L26tYvNC1NS1l3BLipLXW+Fd86qsQ2noVvsh0h8d6mU9pSlQCf+
         wbervcYrwcQw4jwotMYQF3OdaDvR3v3D88/x2/R5ud11yUt91ba6oFjfYCUa37+Ebg5e
         6LyfiUJeHjnGMpFO2zCiGgz80f4KqLVUPCJEiwT6ns4p0zPWfyH3UH1zOzEUN2wkHuwo
         ZfaCV7TW6Sz3vms2lMd2+Ut6cS8mPztwPJAkZUPSK2q0gL118afRzAInkuMXhA3yf3bI
         OXdyNY5sMWTLMinFfbq582MTnaNELGQVuK9zaTgc0+H9yl8Sp0N2eBEav8DMPEay7ucv
         nNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785201732; x=1785806532;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jhdXb3S04B9c2xXxAlgzeVBHU0NJuj6Uw/SLtYwV8xw=;
        b=KrYhLGs0xgR39iFaAtFczDEVU3MZ7Q+6wLiZKBW73LM2VFjcZeZiq1xcuLxwtTCBFE
         cPie4uVik7TKaroUwS0enxeytRfnM4ROXKowI8JE44q8y+U1YV2AelIAYDW60wtkX/N9
         O0QeQbW1rhE8+bwZFe4pg1eihBr+D81XWzybpzYJGV6ZAK6ZMD5SjLXLdys3195jPpgb
         bomVeeVSIKoj4y3R1nhYIXb9pfAkraPvjcM74qLjZBQLCvJ4/n9O+f82vGxvx6MHivxR
         zuZJJ1bcTJKOUQYotgKeMWakK1KGM1LJYIU4vuxW0TrWNbEllhyVTI4RXOVaghjh7Jog
         h0dw==
X-Forwarded-Encrypted: i=1; AHgh+RrDzImBmMwtrutLUZAT7v378B/8ZQbfdt7V5OWLNgJGiqv1SDsllmRsgSPX5xNXAtND+j+p3vrZ/TAUC6JXTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIaN81RN6OUFwvhP7elcHWRrW+uhI/HIFZkXDcSWxtRUrWZg1z
	mMQT3A4ZADcEEU5BvgZaCNXqA0Rmt1xXSi6RNPzyo5ZzgRoJ8KAU9mv1vxpI0M6odp0=
X-Gm-Gg: AR+sD10NE+CnSxaggeE6iAGpsEkK0CuncTDio0SwG2r/y443D1cbzKjTvEOamCWSbWd
	4f/SwzzDsj+Q/S5mpyUUF0gOxfSPmlp9kViHnzv2NtWK//eN3EHXfq+a66cNijd7aVuZuOnqFX9
	mySiOWhTE7SWhPNi3LlC01Kr8HF4tKJemmfI/lHjXVUJ9qgwSm7hN+MLsBoRcAm+K33yorq3M6X
	g3+wBBBMEnEXHtihqav6wNOCrKopRpAjXMdqVWPqXJNKbg/UerSqkAaF4AWLwoAuvvVcmT0P5Y/
	R9Jie+DSGGU1p1tJupvc2UrXTgvEcub8ebFdzSZ9wD7UFGL+klqM/hLLWZ3K6n73n0uk/BYFwXj
	3XXZHf8LvIdZM77Gycqu4iSBw7drpBkBZzxXv6JPceoYoX63LObztpYOj57tTntV01QnXM2eEYI
	jqn5e4gZPT1QhteST2TCbT0yzqvUhs6E8vaiVavp2K0nqxwDt+qIuTx5XeFTeLPF2Dgk7J2LvlR
	twpxp6JcjI1S2qnIQ==
X-Received: by 2002:a17:902:d483:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d015ae2c72mr3010415ad.7.1785201731695;
        Mon, 27 Jul 2026 18:22:11 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdacsm43301665ad.47.2026.07.27.18.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 18:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 21:22:10 -0400
Message-Id: <DK9T753AD314.1K18DTGBR7OYN@etsalapatis.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page
 outside the lock
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260727062521.376231-3-jiayuan.chen@linux.dev>

On Mon Jul 27, 2026 at 2:24 AM EDT, Jiayuan Chen wrote:
> arena_vm_fault() allocated the page while holding arena->spinlock, so it
> could only use the non-blocking allocator. Once the memcg is at
> memory.max that allocation just fails, the fault turns into
> VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
> arena address. Hitting memory.max is routine (e.g. page cache from
> reading a big file), so this kills innocent processes.
>
> Preallocate the page before taking the lock, like do_anonymous_page()
> does, so the allocation can sleep and go through reclaim and the OOM
> path, and return VM_FAULT_OOM on failure so the memcg OOM handler runs
> instead of a fake segfault. Also tidy up the error labels.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 34f023a537fe..22a41e3c53b8 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
>  	struct bpf_map *map =3D vmf->vma->vm_file->private_data;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>  	struct mem_cgroup *new_memcg, *old_memcg;
> -	struct page *page;
> +	struct page *page, *new_page =3D NULL;
> +	vm_fault_t fault_ret;
>  	long kbase, kaddr;
>  	unsigned long flags;
>  	int ret;
> @@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
>  	kbase =3D bpf_arena_get_kern_vm_start(arena);
>  	kaddr =3D kbase + (u32)(vmf->address);
> =20
> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +	page =3D vmalloc_to_page((void *)kaddr);
> +	if (!page) {
> +		/*
> +		 * Preallocate outside the lock so the allocation can sleep and go
> +		 * through reclaim (both memcg and global), the way do_anonymous_page(=
)
> +		 * does. Under arena->spinlock only the non-blocking allocator is
> +		 * available, which never reclaims.
> +		 *

Can you add here that we're in process context which is why we make an
explicitly sleepable call? That also strengthens the explanation of why
we want to preallocate in the first place.

> +		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
> +		 * meaningful if the OOM machinery was actually engaged. A failure
> +		 * from the non-blocking allocator engages nothing, so the fault
> +		 * would be retried forever.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page =3D bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		if (!new_page)
> +			return VM_FAULT_OOM;
> +	}
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>  		/* Make a reasonable effort to address impossible case */
> -		return VM_FAULT_RETRY;
> +		fault_ret =3D VM_FAULT_RETRY;
> +		goto out_err;
> +	}
> =20
>  	page =3D vmalloc_to_page((void *)kaddr);
>  	if (page) {
> -		if (page =3D=3D arena->scratch_page)
> +		if (page =3D=3D arena->scratch_page) {
>  			/* BPF triggered scratch here; don't lazy-alloc over it */
> -			goto out_sigsegv;
> +			fault_ret =3D VM_FAULT_SIGSEGV;
> +			goto out_err_locked;
> +		}
>  		/* already have a page vmap-ed */
>  		goto out;
>  	}
> =20
> +	/*
> +	 * The lockless probe was racy: it saw a page, so nothing was
> +	 * preallocated, but the re-check under the lock finds it gone - a
> +	 * concurrent free must have run in between. There is nothing to
> +	 * install and we cannot allocate under the lock, so retry the fault
> +	 * and preallocate next time.
> +	 */
> +	if (!new_page) {
> +		fault_ret =3D VM_FAULT_RETRY;
> +		goto out_err_locked;
> +	}
> +
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
> -	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
>  		/* User space requested to segfault when page is not allocated by bpf =
prog */
> -		goto out_sigsegv_memcg;
> +		fault_ret =3D VM_FAULT_SIGSEGV;
> +		goto out_err_locked_memcg;
> +	}

Let's hoist this further up, I don't see why we're waiting to get so
much into handling the fault before checking if we're even allowed to
do it in the first place.

> =20
>  	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> -	if (ret)
> -		goto out_sigsegv_memcg;
> -
> -	struct apply_range_data data =3D { .arena =3D arena, .pages =3D &page, =
.i =3D 0 };
> -	/* Account into memcg of the process that created bpf_arena */
> -	ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
> -		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		goto out_sigsegv_memcg;
> +		fault_ret =3D VM_FAULT_OOM;

Can you add a comment that VM_FAULT_OOM is because the only way clearing
the tree can fail is if there is a failed range allocation?

> +		goto out_err_locked_memcg;
>  	}
> +	struct apply_range_data data =3D { .arena =3D arena, .pages =3D &new_pa=
ge, .i =3D 0 };
> =20
>  	ret =3D apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set=
_cb, &data);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		free_pages_nolock(page, 0);
> -		goto out_sigsegv_memcg;
> +		fault_ret =3D VM_FAULT_SIGSEGV;
> +		goto out_err_locked_memcg;
>  	}
>  	flush_vmap_cache(kaddr, PAGE_SIZE);
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> +	/* new_page was consumed */
> +	page =3D new_page;
> +	new_page =3D NULL;
>  out:
>  	page_ref_add(page, 1);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	if (new_page)
> +		free_pages_nolock(new_page, 0);
>  	vmf->page =3D page;
>  	return 0;
> -out_sigsegv_memcg:
> +
> +out_err_locked_memcg:
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> -out_sigsegv:
> +out_err_locked:
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	return VM_FAULT_SIGSEGV;
> +out_err:
> +	if (new_page)
> +		free_pages_nolock(new_page, 0);

> +	return fault_ret;

The out_err label is used only once. Can we replace the label with
the code itself, even if this means some mild duplication? Four
different labels are too many imo.

>  }
> =20
>  static const struct vm_operations_struct arena_vm_ops =3D {

pw-bot: cr
