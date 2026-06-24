Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F53AD525
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313401; cv=pass; b=XbRwk16dDcYYohsdnbR1nfwMEitVj2UqF62VLUvEsXWgVuBuZA9VbNCynwEJzX9uLqGjvqWE88TxB4ntsgpQRYHFrQ/kKFKjTl0aWENXfbGK56fz0sn1215pRh5iA3wYwnV9cxsAUvBeRkvJiD2rzp07m3Q4i6c89e9lk0HA84Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313401; c=relaxed/simple;
	bh=9NmPCGpfOIJmHFO7SFtSx8Cswij+T5aCnwgD0ajtwSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iv9glOK+t5Q9dH1lEUZ183TW8320Bhzamg8RBbznBuehjrcsfcZzmrWaJq2SRmDATWl7LqCVLgZGBsNDFXKdsi5sBSOIrNYZqiMZZIKNMduTukfqSGgsf2ts98TLoanxf0qdhGPf4Li07dj4UpIjdS8TuwmlprIip7vF8O7i80c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isq7fmVc; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isq7fmVc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5177d1ff061so299421cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 08:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782313398; cv=none;
        d=google.com; s=arc-20260327;
        b=GNtjN018gPn8DSIonvp3v80bCLkteIgTmPqY+wPrB/K135AJQuznwCaCzmWjSaY2Uh
         rMX8GLmgX2cLhEIIo7tMIlLhB/vT+kstfFbAH9hCbm8HcVCaK/dEsdKjMMuRC1VxWBKq
         nhmiylHaf2Hx6Sq1BCMknzPvBPIzEvX+bznJRIs5vzWomPs4wazei75csEgcAENLT7Pe
         1JDZQTnf9w57x7EURprFw5nBHmFzna6OYV1g76H2NRYJV8rdsaYNSU21Swggd0n8F5a8
         0SipENmSnZy8ZdUKwZcNV2B5J2am+kPWZb8KabZlvg5dro0QUtnM1hyyWaWnViy2uEb2
         GBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlyV7kfKSj2GGDVWeOXvQhnQwHq/DAA8kHWMpboRygM=;
        fh=0zMGaKjpjd6a6IxHtg8BonjsLIG5AFTGg5L4XHpfxhA=;
        b=JTRpkQXcFYfX73ev09LjrP6//vlYMW3DfgWNIS8x/solCLEgeoTuL9nyFS218uSN/p
         cfNQU/F8MO/cQ7AgL0rt91OLTzoiFXDFrVlGzsEfAepJ1VI/Rur3Q6BYuE5i4331XeAA
         QWVplNlC/Z/C3jSoswHp8sA2TcHbFVdid1AoNtBzRn+TcFzId094a35vOBh5ySsqZBKd
         ARUDxLFkxfjsDm4BDbecR4eEJ0xVtr/XBN1aEKQdvU8oRP8u/XRErwNzpBWd0Eq+77eA
         IXmxl3VS6d5nRM76AtNAEGnaaFtM/uffwIsd/vFFhxkrIkPRm+uq+dJlIoEnxGoxYbu/
         XztA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782313398; x=1782918198; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dlyV7kfKSj2GGDVWeOXvQhnQwHq/DAA8kHWMpboRygM=;
        b=isq7fmVcFn1V+XIb2XU1FaLpAFl/svWhmMYHBheq/vcHy9N/m4lrCBz5M7MPYGOZJF
         X0ejXRO7uKkjG4x/HY7f/jpGieimmjZznkVTZ1LGgzwdi4lW702Ug6kNDS+xYiV96x4n
         Zvo/78ZTvj4kcp8/h+vNYz00DDxP8xwGwnC1Sb1Eo5PPjuGVVt29Kem4VMEK6QUoMaWx
         odUTQEBBCSZBSJ1HIWKgO7NzRPUGd5eFYuBslQ2TAcCYNXo7MnVCeN2ccGFQ4i9i30jJ
         j5a30Agze6xFyIKHxIAVEVtpCarIAWpkiluq3Os7jkEtFq/Lwt3wqoxb6V+XPfNFk9E7
         mKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313398; x=1782918198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlyV7kfKSj2GGDVWeOXvQhnQwHq/DAA8kHWMpboRygM=;
        b=mIxHW2xNK9d3OgyAz/VGPLlDiDbYv8dEwIgIiGJMumRRzh58mjVhjeUbVOVhTVspdW
         yt8ZqdlAgRYmPF68yERs7YX4s0O7IIoypIf9huU3LOgYjJgxXyYgQJmbeB5G7Q6edQJF
         /5DG6USBHQK06gaLmtjvfh9eSVQJoMqN6FsYJlwBLokcU9HVi5U52VJNmD76K9Ig104l
         IsRnC0/J69K5Und0FdVf0z4zZVXqG9uP07vPplTqpTvDy2Qf+IG4t9hh0zfSPxs/W6/i
         yBLfGfMbN/stDHpVZGcTu9xy3vuh/JzNXk5HiL85GmhI5jykqqNlsBIwCFb862Z52d3T
         1HLg==
X-Forwarded-Encrypted: i=1; AFNElJ//InJ0JTvqnNQ0MMdYhL29ruu/FY0z4b6+KwPapG1qznyPKl6aRpvHR5SmE2+jKWjB43g8M78DqUQ2pKod7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyohChdP/BQBMRU2eyr9ygXzywRfOv2zn3DBa14Wf8bVO9YYLKP
	k3TPjmAh51R8/++Co0vy0HjREr3wSYEcDU5y5fotgXGFtpHW4kE+oh3buhx1drJViOE5BZDXL7J
	Ob9FNFe2VKXupKTBclBgcbujgtge+isXe40+9AkGn
X-Gm-Gg: AfdE7cmLlVF0gtiPsOMSgRuNxrAQQhEqfd9gBMQifsjJvEEvA0UKNiHON5AV+QjHHco
	O9mpu+qR520pAHVqoYrAzoVNIJAt3L8mD5x1oJdnadrfWHdPmHe4VuJu+qu6DbYlf1riaf/kmYv
	nClH5xhUxNypusBKQBFjocJJK3w992yoW+0noz76ZSiAIrqxcZSx3FSmeHXjnRAHwYvnvkfU2D5
	VOw1wVla/6MrNPBXq56/8NQw4YrXNZcKlJJqucQd1KAMu6FQuDWdL7ZT43y5RVpivh/eMLFrRhA
	PmyTS76lscS7T9btoXMJwhTMnXE=
X-Received: by 2002:a05:622a:111:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-51a628921bfmr8601831cf.15.1782313397499; Wed, 24 Jun 2026
 08:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <20260622-alloc-trylock-v2-2-31f31367d420@google.com>
In-Reply-To: <20260622-alloc-trylock-v2-2-31f31367d420@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 08:03:05 -0700
X-Gm-Features: AVVi8CfyEwqAEU2r2L-YA31JVfrUZe0if-g-xPd3BqEiAahIxAzXLBzOfAkdwLA
Message-ID: <CAJuCfpGagFf4RaCNJqu4Y1oqOXXOWSkP1UGuT9LA-9EbDN4Njw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] mm/page_alloc: some renames to clarify
 alloc_flags scopes
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

On Mon, Jun 22, 2026 at 3:01=E2=80=AFAM Brendan Jackman <jackmanb@google.co=
m> wrote:
>
> It's pretty confusing that:
>
> - The slowpath and fastpath have a totally distinct set of alloc_flags.
>
> - gfp_to_alloc_flags() sounds generic but it only influences the
>   slowpath.
>
> - prepare_alloc_pages() is generic in that it sets up the
>   alloc_context, but the alloc_flags it generates are only used for the
>   fastpath.

I understand you want to clarify the usage but this particular point
seems to be an implementation detail. IOW, if tomorrow
__alloc_frozen_pages_noprof() is changed to use alloc_flags when
calling __alloc_pages_slowpath(), would we be renaming it back? So, I
would suggest keeping alloc_flags as is in prepare_alloc_pages() and
its callers. The rest LGTM.

>
> Rename some variables to highlight which alloc_flags are
> fastpath-specific. Rename gfp_to_alloc_flags() to highlight that it's
> slowpath-specific.
>
> gfp_to_alloc_flags_cma()'s current name is actually fine, but rename it
> anyway, just for consistency.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6c4eb6908bd95..bc05d75a41627 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3771,8 +3771,8 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp=
_mask)
>  }
>
>  /* Must be called after current_gfp_context() which can change gfp_mask =
*/
> -static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
> -                                                 unsigned int alloc_flag=
s)
> +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> +                                          unsigned int alloc_flags)
>  {
>  #ifdef CONFIG_CMA
>         if (gfp_migratetype(gfp_mask) =3D=3D MIGRATE_MOVABLE)
> @@ -4471,7 +4471,7 @@ static void wake_all_kswapds(unsigned int order, gf=
p_t gfp_mask,
>  }
>
>  static inline unsigned int
> -gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> +slowpath_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  {
>         unsigned int alloc_flags =3D ALLOC_WMARK_MIN | ALLOC_CPUSET;
>
> @@ -4508,7 +4508,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int ord=
er)
>         } else if (unlikely(rt_or_dl_task(current)) && in_task())
>                 alloc_flags |=3D ALLOC_MIN_RESERVE;
>
> -       alloc_flags =3D gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
> +       alloc_flags =3D cma_alloc_flags(gfp_mask, alloc_flags);
>
>         if (defrag_mode)
>                 alloc_flags |=3D ALLOC_NOFRAGMENT;
> @@ -4774,7 +4774,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>          * kswapd needs to be woken up, and to avoid the cost of setting =
up
>          * alloc_flags precisely. So we do that now.
>          */
> -       alloc_flags =3D gfp_to_alloc_flags(gfp_mask, order);
> +       alloc_flags =3D slowpath_alloc_flags(gfp_mask, order);
>
>         /*
>          * We need to recalculate the starting point for the zonelist ite=
rator
> @@ -4815,7 +4815,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>
>         reserve_flags =3D __gfp_pfmemalloc_flags(gfp_mask);
>         if (reserve_flags)
> -               alloc_flags =3D gfp_to_alloc_flags_cma(gfp_mask, reserve_=
flags) |
> +               alloc_flags =3D cma_alloc_flags(gfp_mask, reserve_flags) =
|
>                                           (alloc_flags & ALLOC_KSWAPD);
>
>         /*
> @@ -5017,7 +5017,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int=
 order,
>  static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int orde=
r,
>                 int preferred_nid, nodemask_t *nodemask,
>                 struct alloc_context *ac, gfp_t *alloc_gfp,
> -               unsigned int *alloc_flags)
> +               unsigned int *fastpath_alloc_flags)
>  {
>         ac->highest_zoneidx =3D gfp_zone(gfp_mask);
>         ac->zonelist =3D node_zonelist(preferred_nid, gfp_mask);
> @@ -5033,7 +5033,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_ma=
sk, unsigned int order,
>                 if (in_task() && !ac->nodemask)
>                         ac->nodemask =3D &cpuset_current_mems_allowed;
>                 else
> -                       *alloc_flags |=3D ALLOC_CPUSET;
> +                       *fastpath_alloc_flags |=3D ALLOC_CPUSET;
>         }
>
>         might_alloc(gfp_mask);
> @@ -5042,11 +5042,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_=
mask, unsigned int order,
>          * Don't invoke should_fail logic, since it may call
>          * get_random_u32() and printk() which need to spin_lock.
>          */
> -       if (!(*alloc_flags & ALLOC_NOLOCK) &&
> +       if (!(*fastpath_alloc_flags & ALLOC_NOLOCK) &&
>             should_fail_alloc_page(gfp_mask, order))
>                 return false;
>
> -       *alloc_flags =3D gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
> +       *fastpath_alloc_flags =3D cma_alloc_flags(gfp_mask, *fastpath_all=
oc_flags);
>
>         /* Dirty zone balancing only done in the fast path */
>         ac->spread_dirty_pages =3D (gfp_mask & __GFP_WRITE);
> @@ -5260,7 +5260,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp,=
 unsigned int order,
>                 int preferred_nid, nodemask_t *nodemask)
>  {
>         struct page *page;
> -       unsigned int alloc_flags =3D ALLOC_WMARK_LOW;
> +       unsigned int fastpath_alloc_flags =3D ALLOC_WMARK_LOW;
>         gfp_t alloc_gfp; /* The gfp_t that was actually used for allocati=
on */
>         struct alloc_context ac =3D { };
>
> @@ -5282,17 +5282,17 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gf=
p, unsigned int order,
>         gfp =3D current_gfp_context(gfp);
>         alloc_gfp =3D gfp;
>         if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac=
,
> -                       &alloc_gfp, &alloc_flags))
> +                       &alloc_gfp, &fastpath_alloc_flags))
>                 return NULL;
>
>         /*
>          * Forbid the first pass from falling back to types that fragment
>          * memory until all local zones are considered.
>          */
> -       alloc_flags |=3D alloc_flags_nofragment(zonelist_zone(ac.preferre=
d_zoneref), gfp);
> +       fastpath_alloc_flags |=3D alloc_flags_nofragment(zonelist_zone(ac=
.preferred_zoneref), gfp);
>
>         /* First allocation attempt */
> -       page =3D get_page_from_freelist(alloc_gfp, order, alloc_flags, &a=
c);
> +       page =3D get_page_from_freelist(alloc_gfp, order, fastpath_alloc_=
flags, &ac);
>         if (likely(page))
>                 goto out;
>
>
> --
> 2.54.0
>
