Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3AC33A9FE
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319651; cv=pass; b=JUcGfYln15UEVtnQwDVEbCrDbLfRp9qAgo78Fh9ItH/S78VbBJUai6xb0uUE0AhLVENRQzQ+ZIEac2MnqB61vItvAtV3oftHor1ZrOKlDApWBI/U1Nl7eX7/mstu7s8+zBp+lWr2DwQW89gKPKqss7/8ACjGChUWO5SqbF+Szxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319651; c=relaxed/simple;
	bh=fGvlN4MPOfDcpKkxh4XCs2TPI5muQCwOP49LHTFMP58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMaMUzlhwLgjMR/9cf3tDI0SZZhOam4YIl5Ngl6Bwa2ddmBfgE0mGgfodDTvwSW4uawcrKoqUA5R/dTTwkb3ZiOZhv1XVwzkhER+xUF1bafEj0L7msZPY+INSH99EoLMShmOkK0cCT1UeB9qaAOrx6gbyDRt7o8+2+dZ27Jc/q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=coO6rsqB; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coO6rsqB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5177d1ff061so344691cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782319647; cv=none;
        d=google.com; s=arc-20260327;
        b=iSpE+rqDRQtdWnUB3WQutqXq7ycTGT0VW3cvXqzc1QHfXHrrqXN8BMz2xtWySGRtK7
         jp1ZGbklIqV4dC06y6IRbByYv/1YZB7UefPcxa2LIGB4A9HQthf4WXT+cF/qOQKgu6KV
         gvoMokPaTZA8VnDBJgRRUfKYbFhfToWDCJGQ8R4vhF8f1SWuHYO8u0SPotuWuT8WozgH
         irtXluiQg1wWEYIivec4GHY/X3S0EZJ9GFGn3Nm/QGBL5Q/IPKJ+f0OrYF7IvJWrxSSU
         PdCj1rL/+0hrFhdt3dgqD/zud2tkDGYQYkfxDaui4sw3AXELl2xjqV70NpR833xzXmzb
         AstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8+9Je2o9tTfENlu3j1udpfuNRxN2OWHhCJKeRxmpxgw=;
        fh=riEpGBfCNXN+mKWTYL9saWgitRYmj4jQhT4UPWyoFog=;
        b=m7xjrwp8ehSQCEoq3a7JqUWvAtdZOxStBijTGLdSrpFniel4o8dZRInCtAZACmB+Fp
         SfxgwIbvDYasbQlZlVvbO7Q5sdqnl3lpGCgM/1WQ9DhkTSPkrm24xN23KEeUs/YvMANw
         arcALQ2EQPSqb+E3UOWx7szQJd1chiSeVh53xrMuv7sDskuJ+p6NhyGBZvuvDps1C7+1
         RuiBt6c8jVDylvXkPOUgap5bRgEatsm8T1U90PhYgCuIa0Nx0VU0mJqXDjMNs6SpSr2i
         RhPscmGCo2lkpTeEW7ZghRb2Rzagcf2AzTpbkDrrJh2XtwWFfXG1ZhPI59ptuCOgtjH7
         jNfw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782319647; x=1782924447; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8+9Je2o9tTfENlu3j1udpfuNRxN2OWHhCJKeRxmpxgw=;
        b=coO6rsqB5EdS+GaK8z/8sqjxcjILknjG9ScgUWjtOqV79qdeiWW4cqEkmMXaydYhFk
         Eb66GX6/Z0XZZacDQ4Nm2A53AHPVv90vezFMmViKzuncotjPyfgTHRInEhkYTpTmMPgI
         1yGqB6LtAO6KoU5dk9TxhlWx8WQ02+b2Wcb0I+K8UHaOvUe7PcGLU0HXD8XGzO2oqUo/
         O44LFItMef37mVJ221YGd7xNtI21XHI2HnljsFKGrvnZK0jSQ/78e9aHrlhyXetj+HAF
         V+jky2YGsFTLKKZoEvCTSpWWMXdipoCqorRpvy+yAWRF8weUsvPnpriZFPUGzv7NWI6p
         FBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319647; x=1782924447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+9Je2o9tTfENlu3j1udpfuNRxN2OWHhCJKeRxmpxgw=;
        b=jD5yL6syLX+YCVgttsjfHh1RqHOF1olCmqHZCBl5KiUv6qXK1FG8AFuxh6zqLjVuxq
         vj81SFu08+mNKOkK8+G6YjAuc2dpPmEB/OT2WyaTs6ZvnQFv9Gelropkk3zwaiewv0on
         gneeYx6XTZHMx2hHeumxWsYBLbPYov8yI9Q0KEbc9S20GXL1CeH83l58VSyTp2CjZdR7
         /lLMQ4xSWoC7WDGdaCdhwLHjVtE+shMeSDwfy0n9ompBQlfC6kqT6imOogCxI7akbEYs
         BIig5d2nHze7EgfTi7DUJUddD9ujM7sLsamKEgp3E5lxlYm6+NuwtamoQixlQKC2HXg0
         Gc9w==
X-Forwarded-Encrypted: i=1; AFNElJ9KMh3RxMTl4o9F+Jd516kdsUwDrzMnDr1RWriAXetC9HKOWL52H8BcQHNk8JAPL85oBi4b7oiMUk+Go+mvOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYH4DxiuXtI4kIjWQBFFZzFjssrWncv8MsOkHYof71Bus00px7
	ivMichpqDwTSKZpdIL5p4wMhspYKbdWj0QadfBEpPQR9c3goOP6b50hbHgbhw/hFB7TQoaDt8lL
	mT82hn9NHtiZn+wmOycsvxA35fi2Z19qdfLlpB6Ra
X-Gm-Gg: AfdE7cluoYP31S19Ervm37NnlETLpQdYZjq5zkw02xkvui3aM79kYdXao9JywFxF9vb
	G+B8sUQEpocpCDxW8QI7NDOeQVHOEObbfylaQn9lCIsXS4nyYbv/F+hN1Tb26RMTZPvpVuQP91e
	3f71rbkVkEU4p4TEseIRnUTGGRgBXa7MT+CdfuyPigQHjrblQebAxdy7HATb3xlTOvfJGx4Al4/
	tZfPeyCgxHLC475UP8F+mYf4cVSAYgFaNFCpnKs7uSTDW3Lh1UEkpC4Kp094/gid3WqBJHVA1S1
	B42gwikxJWDyRHKNXFDuySR0aaU=
X-Received: by 2002:a05:622a:60a:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-51a62873f9fmr8907821cf.7.1782319645769; Wed, 24 Jun 2026
 09:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-13-31f31367d420@google.com> <6e312b15-d2b5-4137-aa3f-720ec214c7ab@linux.dev>
In-Reply-To: <6e312b15-d2b5-4137-aa3f-720ec214c7ab@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:47:14 -0700
X-Gm-Features: AVVi8CcoPlV9iEQoX6YLmAnyKKjtQFFDDFPv2rTtxc_qS18Jw0c0_advHmaKHFw
Message-ID: <CAJuCfpF9-CS-gt1S=tRNaK10yNnnod9DLEe-Y5L3ad5u60Gagg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] mm: remove __GFP_NO_CODETAG
To: Hao Ge <hao.ge@linux.dev>
Cc: Brendan Jackman <jackmanb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Alistair Popple <apopple@nvidia.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:57=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Brendan
>
>
> On 2026/6/22 18:01, Brendan Jackman wrote:
> > Now that alloc_pages has an entrypoint that allows passing alloc_flags,
> > we can take advantage of this to start removing GFP flags that are only
> > used for mm-internal stuff.
> >
> > This requires also plumbing the alloc_flags into some more of the
> > allocator code, in particular __alloc_pages[_noprof]() gets an
> > alloc_flags arg to go along with its callees, and we now need to pass
> > those flags deeper into the allocator so they can reach the alloc_tag
> > code.
> >
> > To try and keep the new ALLOC_NO_CODETAG's scope nice and narrow, don't
> > define it in mm/internal.h, instead just define a "reserved bit" and
> > then use that in places that don't care about what it means.

I don't understand why you want to narrow down visibility of one of
the alloc_flag bits. We don't do that for any other flags, and this
seems like an unnecessary complexity.

> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
>
> Nit: The title says "remove __GFP_NO_CODETAG" but the flag isn't really
> removed =E2=80=94 it's migrated from gfp_t to alloc_flags as
>
> ALLOC_NO_CODETAG. Something like "mm: replace __GFP_NO_CODETAG with an
> alloc_flag" would be more accurate.
>
>
> Additionally, as Lorenzo pointed out in another thread, you will likely
> need to rebase this series later.
>
> I noticed Vlastimil has already landed the slab changes removing
> __GFP_NO_OBJ_EXT into mainline:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
id=3D335c347686e76df9d2c7d7f61b5ea627a4c5cb4c
>
> For v3, it might make sense to fold in Vlastimil's patch so the full
> removal of __GFP_NO_OBJ_EXT can be completed end-to-end
>
> https://lore.kernel.org/all/20260609-slab_alloc_flags-v1-15-2bf4a4b9b526@=
kernel.org/

I think Vlastimil's patch will be merged before this one, so this
patch could remove __GFP_NO_OBJ_EXT complely, saying that its last
user (__GFP_NO_CODETAG) is gone.

>
>
> > ---
> >   mm/alloc_tag.c       | 18 ++++++++++--------
> >   mm/compaction.c      |  4 ++--
> >   mm/internal.h        |  8 ++++++--
> >   mm/page_alloc.c      | 42 ++++++++++++++++++++++++------------------
> >   mm/page_frag_cache.c |  4 ++--
> >   5 files changed, 44 insertions(+), 32 deletions(-)
> >
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index d9be1cf5187d9..61a6cba32ff35 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -15,6 +15,8 @@
> >   #include <linux/vmalloc.h>
> >   #include <linux/kmemleak.h>
> >
> > +#include "internal.h"
> > +
> >   #define ALLOCINFO_FILE_NAME         "allocinfo"
> >   #define MODULE_ALLOC_TAG_VMAP_SIZE  (100000UL * sizeof(struct alloc_t=
ag))
> >   #define SECTION_START(NAME)         (CODETAG_SECTION_START_PREFIX NAM=
E)
> > @@ -785,16 +787,15 @@ struct pfn_pool {
> >                                        sizeof(unsigned long))
> >
> >   /*
> > - * Skip early PFN recording for a page allocation.  Reuses the
> > - * %__GFP_NO_OBJ_EXT bit.  Used by __alloc_tag_add_early_pfn() to avoi=
d
> > - * recursion when allocating pages for the early PFN tracking list
> > - * itself.
> > + * Skip early PFN recording for a page allocation.  Used by
> > + * __alloc_tag_add_early_pfn() to avoid recursion when allocating page=
s for the
> > + * early PFN tracking list itself.
> >    *
> >    * Codetags of the pages allocated with __GFP_NO_CODETAG should be
> >    * cleared (via clear_page_tag_ref()) before freeing the pages to pre=
vent
> >    * alloc_tag_sub_check() from triggering a warning.
> >    */
> > -#define __GFP_NO_CODETAG             __GFP_NO_OBJ_EXT
> > +#define ALLOC_NO_CODETAG             __ALLOC_ALLOC_TAG
> >
> >   static struct pfn_pool *current_pfn_pool __initdata;
> >
> > @@ -806,7 +807,8 @@ static void __init __alloc_tag_add_early_pfn(unsign=
ed long pfn)
> >       do {
> >               pool =3D READ_ONCE(current_pfn_pool);
> >               if (!pool || atomic_read(&pool->count) >=3D PFN_POOL_SIZE=
) {
> > -                     struct page *new_page =3D alloc_page(__GFP_HIGH |=
 __GFP_NO_CODETAG);
> > +                     struct page *new_page =3D __alloc_pages(__GFP_HIG=
H, 0, numa_mem_id(),
> > +                                                           NULL, ALLOC=
_NO_CODETAG);
> >                       struct pfn_pool *new;
> >
> >                       if (!new_page) {
> > @@ -837,7 +839,7 @@ typedef void alloc_tag_add_func(unsigned long pfn);
> >   static alloc_tag_add_func __rcu *alloc_tag_add_early_pfn_ptr __refdat=
a =3D
> >       RCU_INITIALIZER(__alloc_tag_add_early_pfn);
> >
> > -void alloc_tag_add_early_pfn(unsigned long pfn, gfp_t gfp_flags)
> > +void alloc_tag_add_early_pfn(unsigned long pfn, unsigned int alloc_fla=
gs)
>
>
> alloc_tag_add_early_pfn is actually declared in include/linux/alloc_tag.h=
,
>
> so we need to update this header in sync as well.
>
> include/linux/alloc_tag.h:166:void alloc_tag_add_early_pfn(unsigned long
> pfn, gfp_t gfp_flags);
> include/linux/alloc_tag.h:170:static inline void
> alloc_tag_add_early_pfn(unsigned long pfn, gfp_t gfp_flags) {}
>
>
> >   {
> >       alloc_tag_add_func *alloc_tag_add;
> >
> > @@ -845,7 +847,7 @@ void alloc_tag_add_early_pfn(unsigned long pfn, gfp=
_t gfp_flags)
> >               return;
> >
> >       /* Skip allocations for the tracking list itself to avoid recursi=
on. */
> > -     if (gfp_flags & __GFP_NO_CODETAG)
> > +     if (alloc_flags & ALLOC_NO_CODETAG)
> >               return;
> >
> >       rcu_read_lock();
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index b776f35ad0200..e90ebd2c54f48 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -82,7 +82,7 @@ static inline bool is_via_compact_memory(int order) {=
 return false; }
> >
> >   static struct page *mark_allocated_noprof(struct page *page, unsigned=
 int order, gfp_t gfp_flags)
> >   {
> > -     post_alloc_hook(page, order, __GFP_MOVABLE);
> > +     post_alloc_hook(page, order, __GFP_MOVABLE, ALLOC_DEFAULT);
> >       set_page_refcounted(page);
> >       return page;
> >   }
> > @@ -1850,7 +1850,7 @@ static struct folio *compaction_alloc_noprof(stru=
ct folio *src, unsigned long da
> >       }
> >       dst =3D (struct folio *)freepage;
> >
> > -     post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
> > +     post_alloc_hook(&dst->page, order, __GFP_MOVABLE, ALLOC_DEFAULT);
> >       set_page_refcounted(&dst->page);
> >       if (order)
> >               prep_compound_page(&dst->page, order);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 0847b55bfc147..a45bedb9ada5f 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -684,6 +684,8 @@ struct alloc_context {
> >        */
> >       enum zone_type highest_zoneidx;
> >       bool spread_dirty_pages;
> > +     /* Only flags that are global to the whole allocation go here. */
> > +     unsigned int alloc_flags;
> >   };
> >
> >   /*
> > @@ -907,7 +909,8 @@ static inline void init_compound_tail(struct page *=
tail,
> >       prep_compound_tail(tail, head, order);
> >   }
> >
> > -void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_=
flags);
> > +void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_=
flags,
> > +                  unsigned int alloc_flags);
> >   extern bool free_pages_prepare(struct page *page, unsigned int order)=
;
> >
> >   extern int user_min_free_kbytes;
> > @@ -1481,6 +1484,7 @@ unsigned int reclaim_clean_pages_from_list(struct=
 zone *zone,
> >   #define ALLOC_HIGHATOMIC    0x200 /* Allows access to MIGRATE_HIGHATO=
MIC */
> >   #define ALLOC_NOLOCK                0x400 /* Only use spin_trylock in=
 allocation path */
> >   #define ALLOC_KSWAPD                0x800 /* allow waking of kswapd, =
__GFP_KSWAPD_RECLAIM set */
> > +#define __ALLOC_ALLOC_TAG      0x1000 /* Reserved bit for use by alloc=
_tag code */
> >
> >   /* Flags that allow allocations below the min watermark. */
> >   #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHA=
TOMIC|ALLOC_OOM)
> > @@ -1956,7 +1960,7 @@ bool may_expand_vm(struct mm_struct *mm, const vm=
a_flags_t *vma_flags,
> >                  unsigned long npages);
> >
> >   struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int =
preferred_nid,
> > -             nodemask_t *nodemask);
> > +             nodemask_t *nodemask, unsigned int alloc_flags);
> >   #define __alloc_pages(...)                  alloc_hooks(__alloc_pages=
_noprof(__VA_ARGS__))
> >
> >   #endif      /* __MM_INTERNAL_H */
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d99e4ea8307ea..d50fd9c77a2e8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1246,7 +1246,7 @@ void __clear_page_tag_ref(struct page *page)
> >   /* Should be called only if mem_alloc_profiling_enabled() */
> >   static noinline
> >   void __pgalloc_tag_add(struct page *page, struct task_struct *task,
> > -                    unsigned int nr, gfp_t gfp_flags)
> > +                    unsigned int nr, unsigned int alloc_flags)
> >   {
> >       union pgtag_ref_handle handle;
> >       union codetag_ref ref;
> > @@ -1260,17 +1260,17 @@ void __pgalloc_tag_add(struct page *page, struc=
t task_struct *task,
> >                * page_ext is not available yet, record the pfn so we ca=
n
> >                * clear the tag ref later when page_ext is initialized.
> >                */
> > -             alloc_tag_add_early_pfn(page_to_pfn(page), gfp_flags);
> > +             alloc_tag_add_early_pfn(page_to_pfn(page), alloc_flags);
> >               if (task->alloc_tag)
> >                       alloc_tag_set_inaccurate(task->alloc_tag);
> >       }
> >   }
> >
> >   static inline void pgalloc_tag_add(struct page *page, struct task_str=
uct *task,
> > -                                unsigned int nr, gfp_t gfp_flags)
> > +                                unsigned int nr, unsigned int alloc_fl=
ags)
>
>
> The pgalloc_tag_add() stub in the non-CONFIG_MEM_ALLOC_PROFILING build
> could use the same parameter types for consistency

Umm, correction. It *should* use the same parameter type. It's
unfortunate that the compiler doesn't catch this...

>
>
> Thanks
>
> Best Regards
>
> Hao
>
>
> >   {
> >       if (mem_alloc_profiling_enabled())
> > -             __pgalloc_tag_add(page, task, nr, gfp_flags);
> > +             __pgalloc_tag_add(page, task, nr, alloc_flags);
> >   }
> >
> >   /* Should be called only if mem_alloc_profiling_enabled() */
> > @@ -1807,7 +1807,7 @@ static inline bool should_skip_init(gfp_t flags)
> >   }
> >
> >   inline void post_alloc_hook(struct page *page, unsigned int order,
> > -                             gfp_t gfp_flags)
> > +                             gfp_t gfp_flags, unsigned int alloc_flags=
)
> >   {
> >       const bool zero_tags =3D gfp_flags & __GFP_ZEROTAGS;
> >       bool init =3D !want_init_on_free() && want_init_on_alloc(gfp_flag=
s) &&
> > @@ -1858,13 +1858,13 @@ inline void post_alloc_hook(struct page *page, =
unsigned int order,
> >
> >       set_page_owner(page, order, gfp_flags);
> >       page_table_check_alloc(page, order);
> > -     pgalloc_tag_add(page, current, 1 << order, gfp_flags);
> > +     pgalloc_tag_add(page, current, 1 << order, alloc_flags);
> >   }
> >
> >   static void prep_new_page(struct page *page, unsigned int order, gfp_=
t gfp_flags,
> >                                                       unsigned int allo=
c_flags)
> >   {
> > -     post_alloc_hook(page, order, gfp_flags);
> > +     post_alloc_hook(page, order, gfp_flags, alloc_flags);
> >
> >       if (order && (gfp_flags & __GFP_COMP))
> >               prep_compound_page(page, order);
> > @@ -4773,8 +4773,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned =
int order,
> >        * The fast path uses conservative alloc_flags to succeed only un=
til
> >        * kswapd needs to be woken up, and to avoid the cost of setting =
up
> >        * alloc_flags precisely. So we do that now.
> > +      *
> > +      * Can't just or alloc_flags if it contains WMARK bits, but those=
 flags
> > +      * shouldn't be set in ac->alloc_flags.
> >        */
> > -     alloc_flags =3D slowpath_alloc_flags(gfp_mask, order);
> > +     VM_WARN_ON(ac->alloc_flags & ALLOC_WMARK_MASK);
> > +     alloc_flags =3D ac->alloc_flags | slowpath_alloc_flags(gfp_mask, =
order);
> >
> >       /*
> >        * We need to recalculate the starting point for the zonelist ite=
rator
> > @@ -4816,7 +4820,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned i=
nt order,
> >       reserve_flags =3D __gfp_pfmemalloc_flags(gfp_mask);
> >       if (reserve_flags)
> >               alloc_flags =3D cma_alloc_flags(gfp_mask, reserve_flags) =
|
> > -                                       (alloc_flags & ALLOC_KSWAPD);
> > +                             ac->alloc_flags | (alloc_flags & ALLOC_KS=
WAPD);
> >
> >       /*
> >        * Reset the nodemask and zonelist iterators if memory policies c=
an be
> > @@ -5218,7 +5222,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, =
int preferred_nid,
> >       return nr_populated;
> >
> >   failed:
> > -     page =3D __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
> > +     page =3D __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask, AL=
LOC_DEFAULT);
> >       if (page)
> >               page_array[nr_populated++] =3D page;
> >       goto out;
> > @@ -5326,11 +5330,13 @@ struct page *__alloc_frozen_pages_noprof(gfp_t =
gfp, unsigned int order,
> >   {
> >       struct page *page;
> >       gfp_t alloc_gfp; /* The gfp_t that was actually used for allocati=
on */
> > -     struct alloc_context ac =3D { };
> > +     struct alloc_context ac =3D {
> > +             .alloc_flags =3D alloc_flags,
> > +     };
> >       unsigned int fastpath_alloc_flags =3D alloc_flags;
> >
> >       /* Other flags could be supported later if needed. */
> > -     if (WARN_ON(alloc_flags & ~ALLOC_NOLOCK))
> > +     if (WARN_ON(alloc_flags & ~(ALLOC_NOLOCK | __ALLOC_ALLOC_TAG)))
> >               return NULL;
> >
> >       if (!alloc_order_allowed(gfp, order, alloc_flags))
> > @@ -5398,12 +5404,12 @@ struct page *__alloc_frozen_pages_noprof(gfp_t =
gfp, unsigned int order,
> >   EXPORT_SYMBOL(__alloc_frozen_pages_noprof);
> >
> >   struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
> > -             int preferred_nid, nodemask_t *nodemask)
> > +             int preferred_nid, nodemask_t *nodemask, unsigned int all=
oc_flags)
> >   {
> >       struct page *page;
> >
> >       page =3D __alloc_frozen_pages_noprof(gfp, order, preferred_nid, n=
odemask,
> > -                                        ALLOC_DEFAULT);
> > +                                        alloc_flags);
> >       if (page)
> >               set_page_refcounted(page);
> >       return page;
> > @@ -5418,14 +5424,14 @@ struct page *alloc_pages_node_noprof(int nid, g=
fp_t gfp_mask, unsigned int order
> >       VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> >       warn_if_node_offline(nid, gfp_mask);
> >
> > -     return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> > +     return __alloc_pages_noprof(gfp_mask, order, nid, NULL, ALLOC_DEF=
AULT);
> >   }
> >
> >   struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int=
 preferred_nid,
> >               nodemask_t *nodemask)
> >   {
> >       struct page *page =3D __alloc_pages_noprof(gfp | __GFP_COMP, orde=
r,
> > -                                     preferred_nid, nodemask);
> > +                                     preferred_nid, nodemask, ALLOC_DE=
FAULT);
> >       return page_rmappable_folio(page);
> >   }
> >   EXPORT_SYMBOL(__folio_alloc_noprof);
> > @@ -7107,7 +7113,7 @@ static void split_free_frozen_pages(struct list_h=
ead *list, gfp_t gfp_mask)
> >               list_for_each_entry_safe(page, next, &list[order], lru) {
> >                       int i;
> >
> > -                     post_alloc_hook(page, order, gfp_mask);
> > +                     post_alloc_hook(page, order, gfp_mask, ALLOC_DEFA=
ULT);
> >                       if (!order)
> >                               continue;
> >
> > @@ -7312,7 +7318,7 @@ int alloc_contig_frozen_range_noprof(unsigned lon=
g start, unsigned long end,
> >               struct page *head =3D pfn_to_page(start);
> >
> >               check_new_pages(head, order);
> > -             prep_new_page(head, order, gfp_mask, 0);
> > +             prep_new_page(head, order, gfp_mask, ALLOC_DEFAULT);
> >       } else {
> >               ret =3D -EINVAL;
> >               WARN(true, "PFN range: requested [%lu, %lu), allocated [%=
lu, %lu)\n",
> > diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> > index d2423f30577e4..d9573170e0719 100644
> > --- a/mm/page_frag_cache.c
> > +++ b/mm/page_frag_cache.c
> > @@ -57,10 +57,10 @@ static struct page *__page_frag_cache_refill(struct=
 page_frag_cache *nc,
> >       gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> >                  __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >       page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
> > -                          numa_mem_id(), NULL);
> > +                          numa_mem_id(), NULL, ALLOC_DEFAULT);
> >   #endif
> >       if (unlikely(!page)) {
> > -             page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
> > +             page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL, ALLOC=
_DEFAULT);
> >               order =3D 0;
> >       }
> >
> >
