Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0343C05E;
	Mon, 29 Jun 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748599; cv=none; b=pYgS5gO5GpYstVXcpwNyhiMPRQ0NGquqxdg1aMiueHtxMIFvFRx+/WAq2S0hfBQOXzF+dpPgvQJ4fZS8neFTdGikYOp62SOgQ01vxUwSVzKmC514AF7QXtna/z/a/Ow6jJuTY7PWbyBusWM08WbtbRe12M/XwukrrrwTpU14dV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748599; c=relaxed/simple;
	bh=2BWmNo513r5Erz6S/WvDW9FX8RUzpP0oQ28AW2iJmbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5VKSxPvmyyVdpxVUlLL6BMlH1aDhrdgFbngpcI/kOULP+iXmR+XQKkWiIgDqERYp4tS7CGf7r5y8urlH2r3GONIPvqBwXnaXX7Id/ktWPoi81OtMDszvtfNuYpjHbH+Wg5Vyv3Ok4q3JI2UEeCLKaNS68TPPWruo3v0MMtifE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9MlnRSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9MlnRSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59241F000E9;
	Mon, 29 Jun 2026 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748598;
	bh=+RA//nF8BS9Zmzf6a7KqQvL13jY9h722KbK+O9qZC0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9MlnRSL3j8Oqx1wWcJ13CznUaQS+0drQY6bEUdXgBeDtK3sBYZj44eO6nQLKa04B
	 O185wJWBSrun3h4qb7qOc/3LOcGQg4Ga1F/xyAoW1q0nC3YwmdmIpi5GxHgKBw8dAS
	 j015jVMX9sCDffuwW6ZWi9yEWHs4gI4lLL8sH2rNOfmK8qDYG5ebrZWp8dDk+jZ1wk
	 47veZ1eZc7E1qcClbN22BVMzWGjQa1Ebxfu/kjaJXNk6KXCKr/E3hj8gBwukKgJ+nR
	 3+GgoI0aw2sV1ayDYcf5aSIQzRUlfqQexas8M9xr5QiY0yJQOCpfEWVH4Te7FcMFLD
	 tPqW0HEbzC54g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/16] mm: replace __GFP_NO_CODETAG with
 ALLOC_NO_CODETAG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260629-alloc-trylock-v3-15-57bef0eadbc2@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-15-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:56:36 +0000
Message-Id: <20260629155637.A59241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The fallback `#else` definition of `pgalloc_tag_add` was not update=
d to accept `unsigned int alloc_flags`.

Pre-existing issues:
- [Critical] TOCTOU race in `__alloc_tag_add_early_pfn` leading to an out-o=
f-bounds array write.
--

commit ccee7f6d4bcf9d00da38c878e97dd852c5e649b3
Author: Brendan Jackman <jackmanb@google.com>

mm: replace __GFP_NO_CODETAG with ALLOC_NO_CODETAG

This commit replaces the mm-internal __GFP_NO_CODETAG flag with a
new alloc_flags bit, ALLOC_NO_CODETAG. It plumbs alloc_flags through
several allocator functions to allow passing this flag directly to the
alloc_tag code.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index d9be1cf5187d9..a32a94e759b94 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
[ ... ]
> @@ -806,7 +795,8 @@ static void __init __alloc_tag_add_early_pfn(unsigned=
 long pfn)
>  	do {
>  		pool =3D READ_ONCE(current_pfn_pool);
>  		if (!pool || atomic_read(&pool->count) >=3D PFN_POOL_SIZE) {
> -			struct page *new_page =3D alloc_page(__GFP_HIGH | __GFP_NO_CODETAG);
> +			struct page *new_page =3D __alloc_pages(__GFP_HIGH, 0, numa_mem_id(),
> +							      NULL, ALLOC_NO_CODETAG);
>  			struct pfn_pool *new;

[Severity: Critical]
This is a pre-existing issue, but is there a time-of-check to time-of-use
race condition here?

If multiple CPUs are active during the deferred init window, could they
concurrently observe the same remaining capacity?

CPU1:
    if (!pool || atomic_read(&pool->count) >=3D PFN_POOL_SIZE)

CPU2:
    if (!pool || atomic_read(&pool->count) >=3D PFN_POOL_SIZE)

If both see 1 remaining slot, won't they both proceed to call
atomic_fetch_add() on the pool counter further down in this function?
This could cause an out-of-bounds array write at pool->pfns[PFN_POOL_SIZE].

[ ... ]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 026f33f217036..803b32e5a5e47 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
[ ... ]
> @@ -1263,17 +1263,17 @@ void __pgalloc_tag_add(struct page *page, struct =
task_struct *task,
>  		alloc_tag_add_early_pfn(page_to_pfn(page), alloc_flags);
>  		if (task->alloc_tag)
>  			alloc_tag_set_inaccurate(task->alloc_tag);
>  	}
>  }
> =20
>  static inline void pgalloc_tag_add(struct page *page, struct task_struct=
 *task,
> -				   unsigned int nr, gfp_t gfp_flags)
> +				   unsigned int nr, unsigned int alloc_flags)
>  {
>  	if (mem_alloc_profiling_enabled())
> -		__pgalloc_tag_add(page, task, nr, gfp_flags);
> +		__pgalloc_tag_add(page, task, nr, alloc_flags);
>  }

[Severity: Low]
Does this change miss updating the fallback definition of pgalloc_tag_add()
when memory allocation profiling is disabled?

If the kernel is compiled without mem-alloc profiling, the dummy function
signature appears to still use the old type:

static inline void pgalloc_tag_add(struct page *page, struct task_struct *t=
ask,
                   unsigned int nr, gfp_t gfp_flags) {}

Since callers like post_alloc_hook() are now passing an unsigned int
for alloc_flags, won't this cause a Sparse type mismatch warning because
gfp_t is a restricted bitwise type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-alloc-tryl=
ock-v3-0-57bef0eadbc2@google.com?part=3D15
