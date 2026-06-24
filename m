Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50530216D
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312015; cv=pass; b=btlzTVtbgR/xc6xQ0sHKl1yV4VGYoT3uopvTQV4nABy/KI+Erz2ZQSDQhgwooyvTsknFNNQxq6oYJY6OLL5rMZkfkS3tTZbSVOVDG+S1r85JeqyBiYSqhv6C6qe22akuQnLJOp4lr3S0gXccvQNGv7zgUgeRvl+maSIadKSrC1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312015; c=relaxed/simple;
	bh=rQjKqpK/pADofmC9Seqon2e8BEuvKOKKH9tLJkWpm9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkzqHQjmQmlG/OTuMdY9UunB1aU8O2KmxZRUG/5ipFtjxdSnssudfeToTkrCm9KrD+4mFF6suYyOMQA3bf7v3K4CDTK3RrvZ1cfVhCUEBMcyWB94SZpLNsl/Uw4AyCCTxE8acnXJxWR20WDtA8tJjbi0ypGJPXSKVIfJMhjm8RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+d9IiD+; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+d9IiD+"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-695469b574eso9497a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782312012; cv=none;
        d=google.com; s=arc-20260327;
        b=iN0x7MhlKUD6bI0joaTE8T7Fyok1RjvnoYBE5wKa+WJhHEkSQTxpg4mnZci4denKku
         FArNaqeA6SIPmYsbSEOXVUNuAeuUAG71lrZ7gdEha4P5wORRc4gWBUOqXo1IFm5sC8zp
         XW75gTfyqfCDcTRehyZOSqoTeonc3Or1WXdcnUhQTHL0kWS2TkJczF16hH8VBF77t3/Z
         J3Zd97TWTCLyDEvzTUZXHCdWhuMhq9yv2WGu9h+L16LSdvI8RbH3V1eLsOCDaA7OeTIN
         0QfA8TdeKQ8aYqnA7Ns/Mkuqc50CvW0X70gu5ARCKfdeXoF5nKu9QK9U/Al92LXWpMSr
         Op4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FWKf6qA0xOoZavhdVF11AAUEP+ZjFUXbTVi5tLLPk6w=;
        fh=ZOF2dMubUAmcb9Ri6Q1CJ9F6gR7b92cKpd0sA2DlpG0=;
        b=Epk+CEF/ude2o4n7MgW+cZiYt4/4JHEJNJckmsMRXRE88gg3otVwKo5WjSfCSOpzHu
         PPQVeQ6H5Am04vsFuuXt92ZI01kmI5Uu/JzwimS4QXJ/vxxFNE/0wwCmgWEcN+9imlDD
         O0TRdN5fWJIQcSS/sA+B6iN/JOG9GFDGmVDRVl2kIjjzNHImm7dzdJK2uotYWDs1vr7h
         0hENAaaEnm+Ob1vk81KBHFJSwU4LuY1G2dykHeInEWKEucks5SQm4takzKFIcfYnLkXL
         0+mhWPFrUUq13M2B7VXw4I14Fr15yrlBrLmNnegb37bg1o1qLQCgI861Sa+TW0hebbiV
         xmMw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782312012; x=1782916812; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FWKf6qA0xOoZavhdVF11AAUEP+ZjFUXbTVi5tLLPk6w=;
        b=k+d9IiD+TA1LiQuXUe5kkcNks18oB+jfZXdRhn35eYUP5e1KtM9kTR3reP8HnN2yfK
         YkGQK17ino7Cn0JEtReqVc3YGEPelZjb0+qQwc5NSpVOpZXng9BdnPU5r4bujs2kT301
         YUZsCGUw4YcH2xlLqGPpWm7PIIttGwEduRTv/EuSSBQEFyKZGGesd/5jR/V9kuiXZQ4+
         aGn+ABOsm4t1yoXIRlIMqKtilyT4guY/lEFV81fSUXdd42GvhabipoeBwFSc0CyuKoMn
         VCPPU62s3uJnXJEcdZ2r59ckD3cLhkhR0pWxF3PCmUsIgffwAuKGvAKZeSlYH+G6sBoD
         4p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782312012; x=1782916812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FWKf6qA0xOoZavhdVF11AAUEP+ZjFUXbTVi5tLLPk6w=;
        b=Mv9OTfCzSISfvN47WU8/4AEKuyjOttek8SvxqhcwfmRJPR6s2JUueOBfvWu/AFwdtO
         f09vIH5jb6+tBUrPZjRkGCNJkoXnFcdMusTmf7JFexIwm/JTDBkg+pEYZdzSQSN7sFQ2
         +HbDmN6ELwuytaR14DS2uaTq8TQC3Rp7MLbETKV0J6zmAbqH7a5zmM19gLGPTO8tC6XD
         XSBwbWWiK7+0dGvJNh/CZRPuD65b4i1/z8vrclxsZH2owg1FtbRV0TSsD3r91JeWdCNh
         dEEHrNIuzyei0W0dM6p/zxodgI3bCc6zW4EmUgeEwmdzAte6eU7tmDlTY34yHuEJosLH
         2FBA==
X-Forwarded-Encrypted: i=1; AHgh+RowK+/f64NJp2v5Ht6NdTWIx7pCIi4Lokm8xpqoklgOzK0ryBCJjdya6TmmIKFHzvnF/UeFUzrbzvkl+xJBAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYUB82W86UUPUEGNJKTWE9pCY4IEe1cV6uVHs5Aexv1r7dWTP5
	5bfzzPfJKCY+chNeXXkiSHiRMp7CGUgnO0FaqyF+pi0lpxqSETFiDY+MltP2EKaTfwq+8qtJPst
	rXl+IxKQltFeY6Sdfoaa+rEAyTHgcD188y3lBJTes
X-Gm-Gg: AfdE7cnZhwdS2rJj4LSblZedtES4+WmupAuffPb7ibpXXWqVXSHbm3PbdjGm0ZKoxdo
	ndHVvsHQyNFo4aE0AAocvYEsvrtW8Ml9M5iC1DFVRDapIe3YiYxiIoAOfHfj1Fkbf9PSTVz8LMi
	jbZHwqnA/xb7Fmed26h8KFQijGpmtMU7GWHKZkad+qA6sF47PzgXUlVKJDfxiilL9eccGCfFfPy
	OPHV03UkOTny3Z57B8DxgnblLGjVIDbn66+4OKfeAeEq+R8u2nFQeDrZ+tA6Uoq5FQVR6hdeMW1
	qQ+sC1r+ANyT3hZBppXQDabQmw==
X-Received: by 2002:a05:6402:21d2:b0:698:a99:445 with SMTP id
 4fb4d7f45d1cf-6980a990b18mr2980a12.5.1782312011716; Wed, 24 Jun 2026 07:40:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <20260622-alloc-trylock-v2-1-31f31367d420@google.com>
In-Reply-To: <20260622-alloc-trylock-v2-1-31f31367d420@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 07:39:56 -0700
X-Gm-Features: AVVi8CfeFSgyEnsm1Ac-SNfll3gB7dPsvM-OhL8M7_84xc3d-jjBQh-OL4XyQHk
Message-ID: <CAJuCfpHrxk+fA8WsSh3mG9Fj9ttrLrf4RH=BtVbJwmAgE2ZSZQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
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
> It's confusing that the function is called "nolock" but the flag is
> called "trylock", align them.
>
> The function's terminology is more visible and has more mindshare so use =
that.
>
> Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> Link: https://lore.kernel.org/linux-mm/2399b3ad-4eac-4a14-94c3-27e9f07972=
a1@kernel.org/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

That comment for ALLOC_NOLOCK about only using spin_trylock in the
allocation path could be rewritten to say that no locking or spinning
is allowed but it's a minor detail.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/internal.h   |  2 +-
>  mm/page_alloc.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 181e79f1d6a20..1483a4fcdfce1 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1475,7 +1475,7 @@ unsigned int reclaim_clean_pages_from_list(struct z=
one *zone,
>  #define ALLOC_NOFRAGMENT         0x0
>  #endif
>  #define ALLOC_HIGHATOMIC       0x200 /* Allows access to MIGRATE_HIGHATO=
MIC */
> -#define ALLOC_TRYLOCK          0x400 /* Only use spin_trylock in allocat=
ion path */
> +#define ALLOC_NOLOCK           0x400 /* Only use spin_trylock in allocat=
ion path */
>  #define ALLOC_KSWAPD           0x800 /* allow waking of kswapd, __GFP_KS=
WAPD_RECLAIM set */
>
>  /* Flags that allow allocations below the min watermark. */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0111cdbdb5321..6c4eb6908bd95 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2528,7 +2528,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned=
 int order,
>         unsigned long flags;
>         int i;
>
> -       if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +       if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
>                 if (!spin_trylock_irqsave(&zone->lock, flags))
>                         return 0;
>         } else {
> @@ -3216,7 +3216,7 @@ struct page *rmqueue_buddy(struct zone *preferred_z=
one, struct zone *zone,
>
>         do {
>                 page =3D NULL;
> -               if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
> +               if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
>                         if (!spin_trylock_irqsave(&zone->lock, flags))
>                                 return NULL;
>                 } else {
> @@ -5042,7 +5042,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_ma=
sk, unsigned int order,
>          * Don't invoke should_fail logic, since it may call
>          * get_random_u32() and printk() which need to spin_lock.
>          */
> -       if (!(*alloc_flags & ALLOC_TRYLOCK) &&
> +       if (!(*alloc_flags & ALLOC_NOLOCK) &&
>             should_fail_alloc_page(gfp_mask, order))
>                 return false;
>
> @@ -7786,7 +7786,7 @@ static bool cond_accept_memory(struct zone *zone, u=
nsigned int order,
>                 return false;
>
>         /* Bailout, since try_to_accept_memory_one() needs to take a lock=
 */
> -       if (alloc_flags & ALLOC_TRYLOCK)
> +       if (alloc_flags & ALLOC_NOLOCK)
>                 return false;
>
>         wmark =3D promo_wmark_pages(zone);
> @@ -7878,7 +7878,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t=
 gfp_flags, int nid, unsigned
>          */
>         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC =
| __GFP_COMP
>                         | gfp_flags;
> -       unsigned int alloc_flags =3D ALLOC_TRYLOCK;
> +       unsigned int alloc_flags =3D ALLOC_NOLOCK;
>         struct alloc_context ac =3D { };
>         struct page *page;
>
>
> --
> 2.54.0
>
