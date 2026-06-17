Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5F4BC012
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714973; cv=pass; b=Vw69EhjO24FLVOOfqtg1q2tyBBnNyEUUJ6oTfficReXXpTqiHCw0SjTM8MXmeS1NyXAagNWaJ/SwXx95o9FaTXsfgSnBdqH3B+MsioWOMMt4MtRTcvd3YNPixJ/NBPpAUxIlBmDG1+Hi7b7jGyVlIIEVM8ObaLWBubYtsZQsVTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714973; c=relaxed/simple;
	bh=xtL9bnImaINm/KVwg5PdKxHSN4qgMKj98xlXNabd98A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/VeiPd4XTh7YLglPT6WyibyjDwnX8AZkHwdfiu0aJ2tBwKRssv31qXGXXHVrKfrI1b7qbnq0XuqqGJS++mryyK3F/GH9T9N8YT3fyzJ5dPfNyIdRyRGPrn+VeY1sH4OdKNocTwZ2XU93D+lJB+I+I9obUn6bNdC8unTqM9kNh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNm2Nzse; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNm2Nzse"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51765531803so5701cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 09:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781714968; cv=none;
        d=google.com; s=arc-20240605;
        b=A34/qE3dbG/H4U1xMhU1H3gA7RPZLt1uyHYGi+YoCOm7Os9oDn/9QngIKSUwNZQqY4
         kBxnt0cEOAEUSzMKGu+v18vO8XKo4Chgizx8nm6F3XGQzV/T8SGZCI9EmDTOky81bcXA
         B1BBV4QprtSRK0ox6+0BAa4wK6624G2AK0/O1LOJkc425at25PwATpzdE8Qnt1JQZZN/
         HyU4OUQM36TppI8pldQ8Zfzd471Zj5UmzpiVlBFsuCDLxYoF9BE5AMfBTPMiC5D2NvN4
         0bcuf6qfGNlBNNBbIWhrwaBt5Gqy+QObFgDbL8RF/fs347eCPZb50L3GE6IC5MPGcKpR
         nQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hjLj3iacux1AS/bmTIaMS0iV5wW3cfNKCUWezx95djI=;
        fh=EM7n7ZHyjlgHsLUcDZ+8DcyB9iD71lpQL7Gl1+mFsWM=;
        b=Vhu+hKoILA4G8nZ/wVk1E5lSgMUkPABNU49BKu3G5Wj1+PuBuOwqepFuPbcwi7IqLm
         a+hpenWlErBNFbAH8TKLYVZe2AmMrgQSS0w6RCXZ0oy0c6bVNzPwgzrnaFzY3roqLz+c
         BPbwEpBWy/hi6jAWni+IIkxKJxlmH0kXBq/FDjWFEdpuckyvW7eCcOipmyE23oWpYAue
         +vde1d/WHzEHECCd1gpSQfiih84bKIDZsEbQtT0A/H/nGGZ/nMN5OOayk7V4RRT3Ef6z
         LDg4J/+CqLt+CxDnJISsUMxNprPCDFrcCtrsXUhcuJHOFyvbt7Vpb4k8w2Mow4VZlv9w
         CQuw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781714968; x=1782319768; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hjLj3iacux1AS/bmTIaMS0iV5wW3cfNKCUWezx95djI=;
        b=BNm2Nzseagk2wvL8yB4eby51aUHf9NDtDoFLFrhSVSEg/QdeaXrKRSPT3PByv9b4aY
         PUem3VTqMgH5uWmqSZjOhVBQUtMzQu5d3YBqn8KqUrJyD78jIQSUYQBksAUmuIS8ja1y
         BTQ/6dtku3JEkCfSc7ILSY5M1b6El3hzC6iIbGD9zlTvbE+b0htbNjt15BABbaaeG8Pu
         h/mKgjOYuYGAB4scnArJTg+Q/sjubMcgGDIHPdybtm4KO1t8Z0saMIrRY63YDfEIYmdT
         7tWwRk5WHGKDlKfzkKlcDBJGhzUz+qpkwmHW0liRH5wpLpintaULvLa9KLYmqDEBJ8ad
         7gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714968; x=1782319768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjLj3iacux1AS/bmTIaMS0iV5wW3cfNKCUWezx95djI=;
        b=Vp/S4DB7CtuVWJzAMu0A4rL4TW4BVci1s4eufmqW0Ba1uvknJ5cJ7nDxEgipISbe5F
         A1+OfuwqoTWB4RldQhKgH0147oDc/7xk+Eh+b3/6PH8DSPPY7pyxMAim9knIgaXe7ieJ
         ROHZdjJJA3r421EcKOjwXRMJro12xZfq9rsc4NIPPpDEe8lTilsIAjIxWJHGY3DydHa7
         KmfOs6At2lbFMygC0LpSzf3Tx8P+YDrwCzJKEu2Rst142yojf/inIHbZzFLG03LZDsMt
         qDkmrS/7ykswl+XXbMMeeBCHbE4rvffKTp1audw3Jnl/zeqOXJzcp3T6ZKAgd6oQN0OA
         oW9w==
X-Forwarded-Encrypted: i=1; AFNElJ/9S4Fr2G+D3LNVuIuFdcVjUocDuZgB07KBL4q4N4HPHeqk8TxXA0GMstZ9GAJbTo1sZ1Oxy/oNKVP3mavLgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzkP+y6cA2t7FmduqzGdIyqh/FMT52ygvBUbMCe2g4E2Rionnm
	e+1xBtlTuIj14xglbOdsgyZOYVhJy0mgsTTwCfx6MZj8Ehd9DdcwtY1IM9tgjWg+Dqvruw59y4y
	RpVXdhfP6xp08qRAAK7yoyMPLwtW7NHYOjeR9UqNw
X-Gm-Gg: Acq92OGVkuNitAeeJS+f5mJ+74yJH3L6Aga/Tt2npJfBjFuIN2t3VxVHNTiRM5bxjaP
	sUqIFIxYbhypV9PQF9AGeb805Ibsp4zXiWKs0le+dqhsrBm27rk4I3VbJNRkCkCnHTd5ftxWKm+
	MHOc9UZncULXeEQWglY+TOmCWFYpySlpS5JDQB/avLR0c2oJ7SZHoKUO2jH62bUTktqdP5b9NEc
	LkkdAzmyNhCinZtopl71A2lNlMfxN7zCtaC34RsupTcQuo6Q16iEAzhBK6Urb7qfKYRmXR2FrxL
	QMV1aNzUabdVezNrE2+L1XvTTAY=
X-Received: by 2002:a05:622a:250e:b0:516:4f62:85e6 with SMTP id
 d75a77b69052e-519adac6b29mr10242051cf.17.1781714966831; Wed, 17 Jun 2026
 09:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com> <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org>
In-Reply-To: <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 09:49:15 -0700
X-Gm-Features: AVVi8Cfg6wdezLztDcNJTPNVj-YEKDTVLMACrrV1qVxm_s3sW0PEorapr66K3S8
Message-ID: <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
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
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Hao Ge <hao.ge@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> +Cc Alexei
>
> On 6/17/26 17:29, Brendan Jackman wrote:
> > Currently the core allocator code is controlled by ALLOC_NOLOCK, but th=
e
>
> It's not, it's ALLOC_TRYLOCK! Thanks for proving that we need to rename i=
t
> to ALLOC_NOLOCK:
>
> https://lore.kernel.org/all/DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com/
>
> So you just won the job to do the rename :) I think it should be done bef=
ore
> this patch, so that the new usages and other _trylock names introduced he=
re
> can be done as _nolock outright.
>
> > main entry point function is significantly different from the normal
> > __alloc_frozen_pages_nolock(), this is tiring when reading the code.
> >
> > Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
> > an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only
> > exposed to mm/) and then turn the nolock variant into a thin wrapper
> > that just sets that flag (as well as handling NUMA_NO_NODE, similar to
> > how some of the wrappers in gfp.h do).
> >
> > Rationale that this doesn't change anything:
> >
> > 1. Simple bits: A bunch of the nolock-specific handling is just moved t=
o
> >    the new alloc_order_allowed(), alloc_trylock_allowed() and
> >    gfp_trylock.
> >
> > 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
> >    previously in the nolock variant:
> >
> >    a. Application of gfp_allowed_mask; this only affects early boot, an=
d
> >       only flags that affect the slowpath get changed here.
> >
> >    b. Application of current_gfp_context() - also only affects the
> >       slowpath
> >
> > 3. The slowpath itself: this is now just explicitly skipped under
> >    !ALLOC_TRYLOCK.
>
> I'll have to ponder it more closely.
>
> > Ulterior motive: adding an alloc_flags arg to the allocator's
> > mm-internal entrypoint can later be used to do more allocation
> > customisation without needing to create new GFP flags.
>
> Ack.

I think this change might also help us in removing __GFP_NO_CODETAG
introduced in [1] and being the only user of __GFP_NO_OBJ_EXT once
Vlastimil's patchset removing other __GFP_NO_OBJ_EXT users lands.
CC'ing Hao as he is brainstorming ways to remove __GFP_NO_CODETAG, and
this might be the answer.

[1] https://lore.kernel.org/all/20260604024008.46592-1-hao.ge@linux.dev/

>
> > No functional change intended.
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Besides the need to ponder unintended effects, mostly LGTM. Just not a fa=
n
> of the hardcoded '0' passed at various places. In the slab variant of thi=
s
> (the thread I've linked above) I went with SLAB_ALLOC_DEFAULT, so you can=
 do
> e.g. ALLOC_DEFAULT here?
>
> > ---
> >  mm/hugetlb.c    |   2 +-
> >  mm/internal.h   |   4 +-
> >  mm/mempolicy.c  |   8 +--
> >  mm/page_alloc.c | 175 +++++++++++++++++++++++++++++-------------------=
--------
> >  mm/slub.c       |   4 +-
> >  5 files changed, 99 insertions(+), 94 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 571212b80835e..619f6307dc98d 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1806,7 +1806,7 @@ static struct folio *alloc_buddy_frozen_folio(int=
 order, gfp_t gfp_mask,
> >       if (alloc_try_hard)
> >               gfp_mask |=3D __GFP_RETRY_MAYFAIL;
> >
> > -     folio =3D (struct folio *)__alloc_frozen_pages(gfp_mask, order, n=
id, nmask);
> > +     folio =3D (struct folio *)__alloc_frozen_pages(gfp_mask, order, n=
id, nmask, 0);
> >
> >       /*
> >        * If we did not specify __GFP_RETRY_MAYFAIL, but still got a
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 181e79f1d6a20..1043eb833836c 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -913,7 +913,7 @@ extern bool free_pages_prepare(struct page *page, u=
nsigned int order);
> >  extern int user_min_free_kbytes;
> >
> >  struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, in=
t nid,
> > -             nodemask_t *);
> > +             nodemask_t *, unsigned int alloc_flags);
> >  #define __alloc_frozen_pages(...) \
> >       alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
> >  void free_frozen_pages(struct page *page, unsigned int order);
> > @@ -924,7 +924,7 @@ struct page *alloc_frozen_pages_noprof(gfp_t, unsig=
ned int order);
> >  #else
> >  static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsign=
ed int order)
> >  {
> > -     return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NU=
LL);
> > +     return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NU=
LL, 0);
> >  }
> >  #endif
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 36699fabd3c22..dccff90682035 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2425,9 +2425,9 @@ static struct page *alloc_pages_preferred_many(gf=
p_t gfp, unsigned int order,
> >        */
> >       preferred_gfp =3D gfp | __GFP_NOWARN;
> >       preferred_gfp &=3D ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> > -     page =3D __alloc_frozen_pages_noprof(preferred_gfp, order, nid, n=
odemask);
> > +     page =3D __alloc_frozen_pages_noprof(preferred_gfp, order, nid, n=
odemask, 0);
> >       if (!page)
> > -             page =3D __alloc_frozen_pages_noprof(gfp, order, nid, NUL=
L);
> > +             page =3D __alloc_frozen_pages_noprof(gfp, order, nid, NUL=
L, 0);
> >
> >       return page;
> >  }
> > @@ -2475,7 +2475,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, u=
nsigned int order,
> >                        */
> >                       page =3D __alloc_frozen_pages_noprof(
> >                               gfp | __GFP_THISNODE | __GFP_NORETRY, ord=
er,
> > -                             nid, NULL);
> > +                             nid, NULL, 0);
> >                       if (page || !(gfp & __GFP_DIRECT_RECLAIM))
> >                               return page;
> >                       /*
> > @@ -2487,7 +2487,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, u=
nsigned int order,
> >               }
> >       }
> >
> > -     page =3D __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
> > +     page =3D __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, 0=
);
> >
> >       if (unlikely(pol->mode =3D=3D MPOL_INTERLEAVE ||
> >                    pol->mode =3D=3D MPOL_WEIGHTED_INTERLEAVE) && page) =
{
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0111cdbdb5321..fc4d07bbf44b5 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5253,24 +5253,98 @@ void free_pages_bulk(struct page **page_array, =
unsigned long nr_pages)
> >       }
> >  }
> >
> > -/*
> > - * This is the 'heart' of the zoned buddy allocator.
> > - */
> > -struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order=
,
> > -             int preferred_nid, nodemask_t *nodemask)
> > +static inline bool alloc_order_allowed(gfp_t gfp, unsigned int order,
> > +                                    unsigned int alloc_flags)
> >  {
> > -     struct page *page;
> > -     unsigned int alloc_flags =3D ALLOC_WMARK_LOW;
> > -     gfp_t alloc_gfp; /* The gfp_t that was actually used for allocati=
on */
> > -     struct alloc_context ac =3D { };
> > +
> > +     if (alloc_flags & ALLOC_TRYLOCK)
> > +             return pcp_allowed_order(order);
> >
> >       /*
> >        * There are several places where we assume that the order value =
is sane
> >        * so bail out early if the request is out of bound.
> >        */
> > -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> > +     return !(WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp));
> > +}
> > +
> > +static inline bool alloc_trylock_allowed(void)
> > +{
> > +     /*
> > +      * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which i=
s
> > +      * unsafe in NMI. If spin_trylock() is called from hard IRQ the c=
urrent
> > +      * task may be waiting for one rt_spin_lock, but rt_spin_trylock(=
) will
> > +      * mark the task as the owner of another rt_spin_lock which will
> > +      * confuse PI logic, so return immediately if called from hard IR=
Q or
> > +      * NMI.
> > +      *
> > +      * Note, irqs_disabled() case is ok. This function can be called
> > +      * from raw_spin_lock_irqsave region.
> > +      */
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > +             return false;
> > +
> > +     /* On UP, spin_trylock() always succeeds even when it is locked *=
/
> > +     if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> > +             return false;
> > +
> > +     /* Bailout, since _deferred_grow_zone() needs to take a lock */
> > +     if (deferred_pages_enabled())
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * GFP flags to set for ALLOC_TRYLOCK i.e. alloc_pages_nolock().
> > + *
> > + * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allo=
wed.
> > + * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
> > + * is not safe in arbitrary context.
> > + *
> > + * These two are the conditions for gfpflags_allow_spinning() being tr=
ue.
> > + *
> > + * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not a re=
ason
> > + * to warn. Also warn would trigger printk() which is unsafe from
> > + * various contexts. We cannot use printk_deferred_enter() to mitigate=
,
> > + * since the running context is unknown.
> > + *
> > + * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() bel=
ow
> > + * is safe in any context. Also zeroing the page is mandatory for
> > + * BPF use cases.
> > + *
> > + * Though __GFP_NOMEMALLOC is not checked in the code path below,
> > + * specify it here to highlight that alloc_pages_nolock()
> > + * doesn't want to deplete reserves.
> > + */
> > +static const gfp_t gfp_trylock =3D __GFP_NOWARN | __GFP_ZERO | __GFP_N=
OMEMALLOC |
> > +                             __GFP_COMP;
> > +
> > +/*
> > + * This is the 'heart' of the zoned buddy allocator.
> > + */
> > +struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order=
,
> > +             int preferred_nid, nodemask_t *nodemask, unsigned int all=
oc_flags)
> > +{
> > +     struct page *page;
> > +     gfp_t alloc_gfp; /* The gfp_t that was actually used for allocati=
on */
> > +     struct alloc_context ac =3D { };
> > +
> > +     /* Other flags could be supported later if needed. */
> > +     if (WARN_ON(alloc_flags & ~ALLOC_TRYLOCK))
> >               return NULL;
> >
> > +     if (!alloc_order_allowed(gfp, order, alloc_flags))
> > +             return NULL;
> > +
> > +     if (alloc_flags & ALLOC_TRYLOCK) {
> > +             VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> > +             if (!alloc_trylock_allowed())
> > +                     return NULL;
> > +             gfp |=3D gfp_trylock;
> > +     } else {
> > +             alloc_flags |=3D ALLOC_WMARK_LOW;
> > +     }
> > +
> >       gfp &=3D gfp_allowed_mask;
> >       /*
> >        * Apply scoped allocation constraints. This is mainly about GFP_=
NOFS
> > @@ -5291,9 +5365,9 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gf=
p, unsigned int order,
> >        */
> >       alloc_flags |=3D alloc_flags_nofragment(zonelist_zone(ac.preferre=
d_zoneref), gfp);
> >
> > -     /* First allocation attempt */
> > +     /* First allocation attempt (or, for trylock, only attempt) */
> >       page =3D get_page_from_freelist(alloc_gfp, order, alloc_flags, &a=
c);
> > -     if (likely(page))
> > +     if (likely(page) || (alloc_flags & ALLOC_TRYLOCK))
> >               goto out;
> >
> >       alloc_gfp =3D gfp;
> > @@ -5310,7 +5384,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gf=
p, unsigned int order,
> >  out:
> >       if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
> >           unlikely(__memcg_kmem_charge_page(page, gfp, order) !=3D 0)) =
{
> > -             free_frozen_pages(page, order);
> > +             __free_frozen_pages(page, order,
> > +                                 alloc_flags & ALLOC_TRYLOCK ? FPI_TRY=
LOCK : 0);
> >               page =3D NULL;
> >       }
> >
> > @@ -5326,7 +5401,7 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsi=
gned int order,
> >  {
> >       struct page *page;
> >
> > -     page =3D __alloc_frozen_pages_noprof(gfp, order, preferred_nid, n=
odemask);
> > +     page =3D __alloc_frozen_pages_noprof(gfp, order, preferred_nid, n=
odemask, 0);
> >       if (page)
> >               set_page_refcounted(page);
> >       return page;
> > @@ -7856,80 +7931,10 @@ static bool __free_unaccepted(struct page *page=
)
> >
> >  struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid=
, unsigned int order)
> >  {
> > -     /*
> > -      * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not=
 allowed.
> > -      * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of k=
swapd
> > -      * is not safe in arbitrary context.
> > -      *
> > -      * These two are the conditions for gfpflags_allow_spinning() bei=
ng true.
> > -      *
> > -      * Specify __GFP_NOWARN since failing alloc_pages_nolock() is not=
 a reason
> > -      * to warn. Also warn would trigger printk() which is unsafe from
> > -      * various contexts. We cannot use printk_deferred_enter() to mit=
igate,
> > -      * since the running context is unknown.
> > -      *
> > -      * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page(=
) below
> > -      * is safe in any context. Also zeroing the page is mandatory for
> > -      * BPF use cases.
> > -      *
> > -      * Though __GFP_NOMEMALLOC is not checked in the code path below,
> > -      * specify it here to highlight that alloc_pages_nolock()
> > -      * doesn't want to deplete reserves.
> > -      */
> > -     gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC =
| __GFP_COMP
> > -                     | gfp_flags;
> > -     unsigned int alloc_flags =3D ALLOC_TRYLOCK;
> > -     struct alloc_context ac =3D { };
> > -     struct page *page;
> > -
> > -     VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
> > -     /*
> > -      * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which i=
s
> > -      * unsafe in NMI. If spin_trylock() is called from hard IRQ the c=
urrent
> > -      * task may be waiting for one rt_spin_lock, but rt_spin_trylock(=
) will
> > -      * mark the task as the owner of another rt_spin_lock which will
> > -      * confuse PI logic, so return immediately if called from hard IR=
Q or
> > -      * NMI.
> > -      *
> > -      * Note, irqs_disabled() case is ok. This function can be called
> > -      * from raw_spin_lock_irqsave region.
> > -      */
> > -     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > -             return NULL;
> > -
> > -     /* On UP, spin_trylock() always succeeds even when it is locked *=
/
> > -     if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> > -             return NULL;
> > -
> > -     if (!pcp_allowed_order(order))
> > -             return NULL;
> > -
> > -     /* Bailout, since _deferred_grow_zone() needs to take a lock */
> > -     if (deferred_pages_enabled())
> > -             return NULL;
> > -
> >       if (nid =3D=3D NUMA_NO_NODE)
> >               nid =3D numa_node_id();
> >
> > -     prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > -                         &alloc_gfp, &alloc_flags);
> > -
> > -     /*
> > -      * Best effort allocation from percpu free list.
> > -      * If it's empty attempt to spin_trylock zone->lock.
> > -      */
> > -     page =3D get_page_from_freelist(alloc_gfp, order, alloc_flags, &a=
c);
> > -
> > -     /* Unlike regular alloc_pages() there is no __alloc_pages_slowpat=
h(). */
> > -
> > -     if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
> > -         unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) !=
=3D 0)) {
> > -             __free_frozen_pages(page, order, FPI_TRYLOCK);
> > -             page =3D NULL;
> > -     }
> > -     trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> > -     kmsan_alloc_page(page, order, alloc_gfp);
> > -     return page;
> > +     return __alloc_frozen_pages_noprof(gfp_flags, order, nid, NULL, A=
LLOC_TRYLOCK);
> >  }
> >  /**
> >   * alloc_pages_nolock - opportunistic reentrant allocation from any co=
ntext
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a2bf3756ca7d0..b9fb66071bd07 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3275,7 +3275,7 @@ static inline struct slab *alloc_slab_page(gfp_t =
flags, int node,
> >       else if (node =3D=3D NUMA_NO_NODE)
> >               page =3D alloc_frozen_pages(flags, order);
> >       else
> > -             page =3D __alloc_frozen_pages(flags, order, node, NULL);
> > +             page =3D __alloc_frozen_pages(flags, order, node, NULL, 0=
);
> >
> >       if (!page)
> >               return NULL;
> > @@ -5236,7 +5236,7 @@ static void *___kmalloc_large_node(size_t size, g=
fp_t flags, int node)
> >       if (node =3D=3D NUMA_NO_NODE)
> >               page =3D alloc_frozen_pages_noprof(flags, order);
> >       else
> > -             page =3D __alloc_frozen_pages_noprof(flags, order, node, =
NULL);
> > +             page =3D __alloc_frozen_pages_noprof(flags, order, node, =
NULL, 0);
> >
> >       if (page) {
> >               ptr =3D page_address(page);
> >
> > ---
> > base-commit: 1111012ec6508a38a39f8d20c213c8c9cf3c96c0
> > change-id: 20260617-alloc-trylock-14ad37dab337
> >
> > Best regards,
> > --
> > Brendan Jackman <jackmanb@google.com>
> >
>
