Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E021FF2A
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316875; cv=pass; b=UyQ7iQO7A/M3T/uNQ4pm+I0KXU5sfCCajBmgUnnladTdBGfeG5R8xMmXDKjneLguUeS2MLdiZMsbLmzRKIylgEgDi+eQNch/bsumbNt1gbARiMc6d5ZMSTrl39Fox4uWh5bv0JJqdLMHkHVTKH9hxmBF81pY/QNfFRdNQJnGnrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316875; c=relaxed/simple;
	bh=sq8p+ZiDFtQCV4ubwy2fItwqU/uwCVS4QhCL9iGs5Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgwwENfN7lnD09LfKAe+4c3RUeYkXMeNBCaGgDHMYOO/AGJnmjlYDJGOkNlsgoq+3xl1Z+Gfzqt0hZFwooD0vhZYUuAKwYI9kwUG52gpBuZdfrNKOJkUOJSzs2cORwx+WeorfSEStHUg7WoORGN7Bn3QoJL3CjJ+6DXph2NyzEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0hcb9Pi; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0hcb9Pi"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177d1ff061so326781cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782316872; cv=none;
        d=google.com; s=arc-20260327;
        b=Wl7CKCrcia9IL2yfDNA189z8/gmWu9NOKA0B+Pg6rk80iclsuXLEeRo/Pd3aX9yXYm
         Rii8fD0pra9NEAfBP6+BV5dx1m7C/a4/v6+0ad/JfTmku1Bn+4llhuWxX3MvDXxp3B97
         Xnuk/zB3glCNEehE7vnNcTIqf2pMvcq5UgPREGWgh/HSSUxb9rv5OZfpcla6yS3bQGHH
         Ef6PadSsyTiCzML5bjc9qzCXmfNFeBmW+fwxAhYnEomeo9K2Djmk81b+nd41pkJ0txgb
         CuGvAZsfvpEZ3upUGXKAwIfRvNHZSrjwmLUr+WYjMHquOP/wwxyQ0w7NK6aIwFJF7ImC
         mipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0crqmBAoFv3Z4GgPIvpGFroTATsgJ+vxtDpZskBYhQ=;
        fh=9AzkM9lzcHPEcFR/aY57lEwUSxn78BSeJ81SLJAllZY=;
        b=Hhz8QBw2cZ151eW/ErSZtdZ740mreHDhuZPYgfCf/h2LAr8hkdLAmKdEzfZbhjgcNU
         E1gf5DsSeeNXXFh6pWbCXgBq0p2x++dQ8PAnwKNgzCXk2bFwttFviSVy9aecH/Ge1iHZ
         WN9tFTcdY2C1Avmpn5dGDwYBPFvYMnOycJCTIvLk2m5O2wIH+oj5Rn0aKmGeXVRNY3hx
         cuHchkoADpKCuKG5GsPXgt6QZYjpNGXtbIntYnMBvs5puuK9LEM3AiNQ123ImoBPWNK7
         xYPXZtuP5WNUZXyxiY02NZfdklfPyb+PmTDn3jAULQUhgv5jW2S3v035yu2IEO7P96MQ
         oQ4g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782316872; x=1782921672; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0crqmBAoFv3Z4GgPIvpGFroTATsgJ+vxtDpZskBYhQ=;
        b=f0hcb9PiM7O+W5owTNRqG5LZsR9RxqhiUiFxsCD5/RnA26Xnc2FsgLMt95OSQdM3JS
         CnTv7aIWnSDdBTD/m1cFx7obKzXeAoMkoJg1TPwF1uKYT3xWexdFe+Ccx25+rA+dEGeU
         ezd/reKFLO8P2NmVpxMkiNkYeMRB5W33+qJU9xvigMWdbSPQ7yTEd0jP8W1PKrbmYFSm
         V6CPcCkbZcsVc+N9Q+9XoqGOUxJlz6tFZFd+xZfE8QUqHAw4aDZM8Xjt9atg+OiqoGSb
         Lb8sUm3WkebRzUM/KcKkdQwE0uPqj7PDFyRdHb2cRXixx6XlmEjj92IzV1/i8d6EmyMI
         3WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316872; x=1782921672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0crqmBAoFv3Z4GgPIvpGFroTATsgJ+vxtDpZskBYhQ=;
        b=oUXRAUMU43dW48wlw8rJdyb+NNJnv+iB9Ftl1WXNqz3nrYKJPDBQJ+1iECBqr66slQ
         jE5plc1En1k6btWnNpiEElaoW3fpVNTQAeIFXSXPefarh2qpN5zaaZtveu/BohkR5OtY
         EcSSc9aLDG7BnSi3RhAw5GEtaFhWgSFLmp0aQyGBmfIbjDk+2K3utOYK7xRcDrHx9eVp
         T0/zHCSXukfzsJup2PwsKzZ1Ikt2p3PKOJmGkd8PwlRIRGMG4iqwmHLgL+OiDGTb5Qz6
         kY99dzObIkAzjHhwOR3wrbQ58+oa5i25Cbf4GNcN6PoCFc0G9Q/iT8DkVYKWV8DG3Au7
         WfZg==
X-Forwarded-Encrypted: i=1; AFNElJ8q3YGz98Fyi05UKOMzYYGzmPmMk5J4e33boa5x8Ugn9FyK6jtLNdqnjBdLyTA7gsdXedOjafwK7jExFddO8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPOhG0QiNqmqa0f/oZRO59koTnq/AqOln9Or3QtWpTQfqBi+7+
	mIHvLpI9hVxyBnZ9xnaipCrE36BY6aQFPyOezVJGY+L37b8q0pt2cvNb9oBAjx3VOxABlZZEAK0
	JouikbBi0+xx9eobrSaFTrZZuW8dxIL+33ZEGk7d4
X-Gm-Gg: AfdE7ckLWVLsd21n3Dte1knEmZCV501YXYGeHus95w1tAsJtLSWuogdPgw9uzXk/0FJ
	bVZkQBVDqTnJrbqviOQll7itZMEj5vhxzDKpS2uTVtcXU3Eqjk6fZ5KplJ0osjbsSZPuPfu87r7
	5/pGG7uYJS8OAsrdRxOm2VF9r+BVa0gaZtan9J18f6PxxBuao5YQAA0j9vGD/AEddcrMHfDBb0Z
	5MRkOglGLZq/Kw2mwy+Cr4FwFUzIWWXyHb/xMHl+VmAgYf0h+LplJ2NgvM1NgRVLTpP2sgSQZGR
	Ey0HK2XW7IiIf6g7TffaAA4EYMo=
X-Received: by 2002:ac8:590b:0:b0:517:99ea:ab79 with SMTP id
 d75a77b69052e-51a628b1f04mr9806651cf.25.1782316870622; Wed, 24 Jun 2026
 09:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <20260622-alloc-trylock-v2-3-31f31367d420@google.com>
In-Reply-To: <20260622-alloc-trylock-v2-3-31f31367d420@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:00:59 -0700
X-Gm-Features: AVVi8Cdv6pKmxpEnI9xiasIPnPCK-jdZ5ALtkKByHZ7f_PzXa-QK82QrMcBFDDc
Message-ID: <CAJuCfpE28TqZy2k5-X1ZEdd0HhTuc5i7+0kyxX5nXH4j+5JVfw@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:02=E2=80=AFAM Brendan Jackman <jackmanb@google.co=
m> wrote:
>
> Currently the core allocator code is controlled by ALLOC_NOLOCK, but the
> main entry point function is significantly different from the normal
> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>
> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only
> exposed to mm/) and then turn the nolock variant into a thin wrapper
> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
> how some of the wrappers in gfp.h do).
>
> Rationale that this doesn't change anything:
>
> 1. Simple bits: A bunch of the nolock-specific handling is just moved to
>    the new alloc_order_allowed(), alloc_trylock_allowed() and
>    gfp_trylock.
>
> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>    previously in the nolock variant:
>
>    a. Application of gfp_allowed_mask; this only affects early boot, and
>       only flags that affect the slowpath get changed here.
>
>    b. Application of current_gfp_context() - also only affects the
>       slowpath
>
> 3. The slowpath itself: this is now just explicitly skipped under
>    !ALLOC_TRYLOCK.
>
> Ulterior motive: adding an alloc_flags arg to the allocator's
> mm-internal entrypoint can later be used to do more allocation
> customisation without needing to create new GFP flags.

Looks like a nice overall cleanup.

>
> While adding this flag to a bunch of places, create ALLOC_DEFAULT to
> avoid a mysterious literal 0 in most places. alloc_frozen_pages_noprof()
> is defined above the alloc flags so just leave that as a slightly messy
> exception instead of trying to fully reorder mm/internal.h for that one
> case.

Moving the whole alloc_frozen_pages() block down seems simple enough
and would avoid special-casing this.

>
> No functional change intended.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/hugetlb.c    |   3 +-
>  mm/internal.h   |   8 ++-
>  mm/mempolicy.c  |  10 ++--
>  mm/page_alloc.c | 178 +++++++++++++++++++++++++++++---------------------=
------
>  mm/slub.c       |   6 +-
>  5 files changed, 110 insertions(+), 95 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835e..2ce6169ca0dfd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1806,7 +1806,8 @@ static struct folio *alloc_buddy_frozen_folio(int o=
rder, gfp_t gfp_mask,
>         if (alloc_try_hard)
>                 gfp_mask |=3D __GFP_RETRY_MAYFAIL;
>
> -       folio =3D (struct folio *)__alloc_frozen_pages(gfp_mask, order, n=
id, nmask);
> +       folio =3D (struct folio *)__alloc_frozen_pages(gfp_mask, order, n=
id, nmask,
> +                                                    ALLOC_DEFAULT);
>
>         /*
>          * If we did not specify __GFP_RETRY_MAYFAIL, but still got a
> diff --git a/mm/internal.h b/mm/internal.h
> index 1483a4fcdfce1..6bc89ec62e527 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -913,7 +913,7 @@ extern bool free_pages_prepare(struct page *page, uns=
igned int order);
>  extern int user_min_free_kbytes;
>
>  struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int =
nid,
> -               nodemask_t *);
> +               nodemask_t *, unsigned int alloc_flags);
>  #define __alloc_frozen_pages(...) \
>         alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
>  void free_frozen_pages(struct page *page, unsigned int order);
> @@ -924,7 +924,8 @@ struct page *alloc_frozen_pages_noprof(gfp_t, unsigne=
d int order);
>  #else
>  static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned=
 int order)
>  {
> -       return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NU=
LL);
> +       return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NU=
LL,
> +                                          0 /* ALLOC_DEFAULT */);
>  }
>  #endif
>
> @@ -1440,6 +1441,9 @@ extern void set_pageblock_order(void);
>  unsigned long reclaim_pages(struct list_head *folio_list);
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>                                             struct list_head *folio_list)=
;
> +
> +
> +#define ALLOC_DEFAULT          0
>  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
>  #define ALLOC_WMARK_MIN                WMARK_MIN
>  #define ALLOC_WMARK_LOW                WMARK_LOW
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 36699fabd3c22..40bbea614aced 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2425,9 +2425,11 @@ static struct page *alloc_pages_preferred_many(gfp=
_t gfp, unsigned int order,
>          */
>         preferred_gfp =3D gfp | __GFP_NOWARN;
>         preferred_gfp &=3D ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> -       page =3D __alloc_frozen_pages_noprof(preferred_gfp, order, nid, n=
odemask);
> +       page =3D __alloc_frozen_pages_noprof(preferred_gfp, order, nid, n=
odemask,
> +                                          ALLOC_DEFAULT);
>         if (!page)
> -               page =3D __alloc_frozen_pages_noprof(gfp, order, nid, NUL=
L);
> +               page =3D __alloc_frozen_pages_noprof(gfp, order, nid, NUL=
L,
> +                                                  ALLOC_DEFAULT);
>
>         return page;
>  }
> @@ -2475,7 +2477,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, uns=
igned int order,
>                          */
>                         page =3D __alloc_frozen_pages_noprof(
>                                 gfp | __GFP_THISNODE | __GFP_NORETRY, ord=
er,
> -                               nid, NULL);
> +                               nid, NULL, ALLOC_DEFAULT);
>                         if (page || !(gfp & __GFP_DIRECT_RECLAIM))
>                                 return page;
>                         /*
> @@ -2487,7 +2489,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, uns=
igned int order,
>                 }
>         }
>
> -       page =3D __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
> +       page =3D __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, A=
LLOC_DEFAULT);
>
>         if (unlikely(pol->mode =3D=3D MPOL_INTERLEAVE ||
>                      pol->mode =3D=3D MPOL_WEIGHTED_INTERLEAVE) && page) =
{
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bc05d75a41627..e31babe2181a1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5204,7 +5204,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>                 }
>                 nr_account++;
>
> -               prep_new_page(page, 0, gfp, 0);
> +               prep_new_page(page, 0, gfp, ALLOC_DEFAULT);
>                 set_page_refcounted(page);
>                 page_array[nr_populated++] =3D page;
>         }
> @@ -5253,24 +5253,98 @@ void free_pages_bulk(struct page **page_array, un=
signed long nr_pages)
>         }
>  }
>
> -/*
> - * This is the 'heart' of the zoned buddy allocator.
> - */
> -struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> -               int preferred_nid, nodemask_t *nodemask)
> +static inline bool alloc_order_allowed(gfp_t gfp, unsigned int order,
> +                                      unsigned int alloc_flags)
>  {
> -       struct page *page;
> -       unsigned int fastpath_alloc_flags =3D ALLOC_WMARK_LOW;
> -       gfp_t alloc_gfp; /* The gfp_t that was actually used for allocati=
on */
> -       struct alloc_context ac =3D { };
> +       if (alloc_flags & ALLOC_NOLOCK)
> +               return pcp_allowed_order(order);
>
>         /*
>          * There are several places where we assume that the order value =
is sane
>          * so bail out early if the request is out of bound.
>          */
> -       if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> +       return !(WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp));
> +}
> +
> +static inline bool alloc_trylock_allowed(void)
> +{
> +       /*
> +        * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which i=
s
> +        * unsafe in NMI. If spin_trylock() is called from hard IRQ the c=
urrent
> +        * task may be waiting for one rt_spin_lock, but rt_spin_trylock(=
) will
> +        * mark the task as the owner of another rt_spin_lock which will
> +        * confuse PI logic, so return immediately if called from hard IR=
Q or
> +        * NMI.
> +        *
> +        * Note, irqs_disabled() case is ok. This function can be called
> +        * from raw_spin_lock_irqsave region.
> +        */
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +               return false;
> +
> +       /* On UP, spin_trylock() always succeeds even when it is locked *=
/
> +       if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> +               return false;
> +
> +       /* Bailout, since _deferred_grow_zone() needs to take a lock */
> +       if (deferred_pages_enabled())
> +               return false;
> +
> +       return true;
> +}
> +
> +/*
> + * GFP flags to set for ALLOC_NOLOCK i.e. alloc_pages_nolock().
> + *
> + * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowe=
d.
> + * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
> + * is not safe in arbitrary context.
> + *
> + * These two are the conditions for gfpflags_allow_spinning() being true=
.
> + *
> + * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a reas=
on
> + * to warn. Also warn would trigger printk() which is unsafe from
> + * various contexts. We cannot use printk_deferred_enter() to mitigate,
> + * since the running context is unknown.
> + *
> + * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
> + * is safe in any context. Also zeroing the page is mandatory for
> + * BPF use cases.
> + *
> + * Though __GFP_NOMEMALLOC is not checked in the code path below,
> + * specify it here to highlight that alloc_pages_nolock()
> + * doesn't want to deplete reserves.
> + */
> +static const gfp_t gfp_nolock =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NOME=
MALLOC |
> +                               __GFP_COMP;

__alloc_frozen_pages_noprof() is the only user of gfp_nolock. Can we
move it into that function to limit its scope? (unless you plan to use
it elsewhere).

> +
> +/*
> + * This is the 'heart' of the zoned buddy allocator.
> + */
> +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> +               int preferred_nid, nodemask_t *nodemask, unsigned int all=
oc_flags)
> +{
> +       struct page *page;
> +       gfp_t alloc_gfp; /* The gfp_t that was actually used for allocati=
on */
> +       struct alloc_context ac =3D { };
> +       unsigned int fastpath_alloc_flags =3D alloc_flags;
> +
> +       /* Other flags could be supported later if needed. */
> +       if (WARN_ON(alloc_flags & ~ALLOC_NOLOCK))
>                 return NULL;
>
> +       if (!alloc_order_allowed(gfp, order, alloc_flags))
> +               return NULL;
> +
> +       if (alloc_flags & ALLOC_NOLOCK) {
> +               VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> +               if (!alloc_trylock_allowed())
> +                       return NULL;
> +               gfp |=3D gfp_nolock;
> +       } else {
> +               fastpath_alloc_flags |=3D ALLOC_WMARK_LOW;
> +       }
> +
>         gfp &=3D gfp_allowed_mask;
>         /*
>          * Apply scoped allocation constraints. This is mainly about GFP_=
NOFS
> @@ -5291,9 +5365,9 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp,=
 unsigned int order,
>          */
>         fastpath_alloc_flags |=3D alloc_flags_nofragment(zonelist_zone(ac=
.preferred_zoneref), gfp);
>
> -       /* First allocation attempt */
> +       /* First allocation attempt (or, for nolock, only attempt) */
>         page =3D get_page_from_freelist(alloc_gfp, order, fastpath_alloc_=
flags, &ac);
> -       if (likely(page))
> +       if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
>                 goto out;
>
>         alloc_gfp =3D gfp;
> @@ -5310,7 +5384,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp,=
 unsigned int order,
>  out:
>         if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>             unlikely(__memcg_kmem_charge_page(page, gfp, order) !=3D 0)) =
{
> -               free_frozen_pages(page, order);
> +               __free_frozen_pages(page, order,
> +                                   alloc_flags & ALLOC_NOLOCK ? FPI_TRYL=
OCK : 0);
>                 page =3D NULL;
>         }
>
> @@ -5326,7 +5401,8 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsign=
ed int order,
>  {
>         struct page *page;
>
> -       page =3D __alloc_frozen_pages_noprof(gfp, order, preferred_nid, n=
odemask);
> +       page =3D __alloc_frozen_pages_noprof(gfp, order, preferred_nid, n=
odemask,
> +                                          ALLOC_DEFAULT);
>         if (page)
>                 set_page_refcounted(page);
>         return page;
> @@ -7856,80 +7932,10 @@ static bool __free_unaccepted(struct page *page)
>
>  struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, =
unsigned int order)
>  {
> -       /*
> -        * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not=
 allowed.
> -        * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of k=
swapd
> -        * is not safe in arbitrary context.
> -        *
> -        * These two are the conditions for gfpflags_allow_spinning() bei=
ng true.
> -        *
> -        * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not=
 a reason
> -        * to warn. Also warn would trigger printk() which is unsafe from
> -        * various contexts. We cannot use printk_deferred_enter() to mit=
igate,
> -        * since the running context is unknown.
> -        *
> -        * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page(=
) below
> -        * is safe in any context. Also zeroing the page is mandatory for
> -        * BPF use cases.
> -        *
> -        * Though __GFP_NOMEMALLOC is not checked in the code path below,
> -        * specify it here to highlight that alloc_pages_nolock()
> -        * doesn't want to deplete reserves.
> -        */
> -       gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC =
| __GFP_COMP
> -                       | gfp_flags;
> -       unsigned int alloc_flags =3D ALLOC_NOLOCK;
> -       struct alloc_context ac =3D { };
> -       struct page *page;
> -
> -       VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
> -       /*
> -        * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which i=
s
> -        * unsafe in NMI. If spin_trylock() is called from hard IRQ the c=
urrent
> -        * task may be waiting for one rt_spin_lock, but rt_spin_trylock(=
) will
> -        * mark the task as the owner of another rt_spin_lock which will
> -        * confuse PI logic, so return immediately if called from hard IR=
Q or
> -        * NMI.
> -        *
> -        * Note, irqs_disabled() case is ok. This function can be called
> -        * from raw_spin_lock_irqsave region.
> -        */
> -       if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> -               return NULL;
> -
> -       /* On UP, spin_trylock() always succeeds even when it is locked *=
/
> -       if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> -               return NULL;
> -
> -       if (!pcp_allowed_order(order))
> -               return NULL;
> -
> -       /* Bailout, since _deferred_grow_zone() needs to take a lock */
> -       if (deferred_pages_enabled())
> -               return NULL;
> -
>         if (nid =3D=3D NUMA_NO_NODE)
>                 nid =3D numa_node_id();
>
> -       prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> -                           &alloc_gfp, &alloc_flags);
> -
> -       /*
> -        * Best effort allocation from percpu free list.
> -        * If it's empty attempt to spin_trylock zone->lock.
> -        */
> -       page =3D get_page_from_freelist(alloc_gfp, order, alloc_flags, &a=
c);
> -
> -       /* Unlike regular alloc_pages() there is no __alloc_pages_slowpat=
h(). */
> -
> -       if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
> -           unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) !=
=3D 0)) {
> -               __free_frozen_pages(page, order, FPI_TRYLOCK);
> -               page =3D NULL;
> -       }
> -       trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> -       kmsan_alloc_page(page, order, alloc_gfp);
> -       return page;
> +       return __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, A=
LLOC_NOLOCK);
>  }
>  /**
>   * alloc_pages_nolock - opportunistic reentrant allocation from any cont=
ext
> diff --git a/mm/slub.c b/mm/slub.c
> index a2bf3756ca7d0..b9c1284844a0a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3275,7 +3275,8 @@ static inline struct slab *alloc_slab_page(gfp_t fl=
ags, int node,
>         else if (node =3D=3D NUMA_NO_NODE)
>                 page =3D alloc_frozen_pages(flags, order);
>         else
> -               page =3D __alloc_frozen_pages(flags, order, node, NULL);
> +               page =3D __alloc_frozen_pages(flags, order, node, NULL,
> +                                           ALLOC_DEFAULT);
>
>         if (!page)
>                 return NULL;
> @@ -5236,7 +5237,8 @@ static void *___kmalloc_large_node(size_t size, gfp=
_t flags, int node)
>         if (node =3D=3D NUMA_NO_NODE)
>                 page =3D alloc_frozen_pages_noprof(flags, order);
>         else
> -               page =3D __alloc_frozen_pages_noprof(flags, order, node, =
NULL);
> +               page =3D __alloc_frozen_pages_noprof(flags, order, node, =
NULL,
> +                                                  ALLOC_DEFAULT);
>
>         if (page) {
>                 ptr =3D page_address(page);
>
> --
> 2.54.0
>
>
