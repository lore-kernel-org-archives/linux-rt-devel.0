Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1716318BA6
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043531; cv=pass; b=EHIOr7YjegjOLQEH4CzJL44m/UdXjFZpmFt5wyJlsbZ6MXlnhZtlpKtVygEjKvRhZIm2755WMz6k6NsBhdDphtbm50g3+eBVsqLgx/ymN7QifCyIBV0C6W/s6kuVVdngzKit3GZg1gSisE1QQy6FgFx3Zkov81tj98AK8yOc6x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043531; c=relaxed/simple;
	bh=L1upYqSEg2R1rGPOoSBbKrDshAj7eVpBoVI5FeRyGPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhZ5nIl6FVf4v8DNiJ7ES0O+MmX9a/U2p0XnAx+gMRcFRTNHwe5swydP0kdl9B2UkiKLyL9UvyHiQfixOs4VdeHttasgTxnPsdn/ntspxYtV+MNmHwAQU2lU0qTEAiy+LtXcvOVoxxMVWiLfNSbtMtGmHDG/41N67OPBarXgWdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6mgvKZX; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6mgvKZX"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50299648ae9so73321cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:58:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769043528; cv=none;
        d=google.com; s=arc-20240605;
        b=CWTaGyrWXIkq5cw1Ak76wTm/ljM5E8M3RlM99l//UYVYDzodELk04VYmiPjHh0O5XK
         HEsCQvDl4v6xudPlmP19HI1wgx4rAEjqc3EC1u1whN/izCuUvSjkZNnlcDgirXTK0Djy
         OdeXjcz0kvwK/sO1K8E7LRexoUGMWcRsLMZK0sYgb1Kwgr9Efr2BYIeuAjoDfk0xqkL4
         JhP7VmirPiKN1xfcqMEZmRJjGmI6T8JNi0jgxeJ51rPi8jHif0svka1qO0krrmBEza8M
         zmOVdv/uXyd7DrqiQRMmmBobwRfcvJ0wVSiIAlh71vFoWlcCu2JRPRvj5lpmiq3Jo4zl
         YSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLIh79S7FhXMOMoT5i8cYC6nflwvZaP3UE034p5mOJs=;
        fh=A2EC/3SnJPh3FWUSXCx0kHxmO2h124Bzf5sNdBG70+c=;
        b=MteTj6pfqy3vVsTv2wH3FJmR6Xv8eSCpTn3+tgUt4/H5HZIrYXkitTf7UwIvfq8KE7
         wIBsQ4rNR7zhAwHO5f+WfIhx8AFjs28/kz75eZpK+0bsLDmXkzb327Tf2PDqhS1BoAMF
         T6XI+XatXWDXJXdC6bXntVh3nFNWn1bJOadSvdoh51Lbptc5VXrOK60ARsEH0tUslxkh
         w8/+Hir5StoYW5qowPmflAdxQJRKppjw+sup6q/D/qmSUR1p/pmmrqquUKDypgcJ7ly5
         Tqt1Hy4Mynx3bAWXJbStzhaUS6e0g0Cf1QA3amtxnm99HIu1MvqmTH8QCzZsg2W+nNoB
         I3aQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769043528; x=1769648328; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLIh79S7FhXMOMoT5i8cYC6nflwvZaP3UE034p5mOJs=;
        b=z6mgvKZXGONtFZaSyhBlfud8/R1L+KbHKYSyPvgZ0Yx/tEBTrbUZFsQOjCzBtJZScz
         IijMKmBFo858pTftl+nmpdoSSfN03v3w7l9AjFaHox6ECgWp/hh6/O8wic0ecVcexvU0
         wE09S79JYNIKf/L92y7bDLuxZNRht+bonTVWMUVti9HCIiOFDITSwrZBlyI/ZCZypALz
         tDT1m/aPMJB/V+TFUt/EkP8iUS6JcsoyAzOU4SnRzo1lliezIBDSDc8ey84TpZDJxDh8
         TcEHcVwnhZq34ADINzV5tZ+wtc+MyqWe0HC73Ytw7SQf4uLPn6BAo9Crt2Akar9Dshc9
         W5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769043528; x=1769648328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLIh79S7FhXMOMoT5i8cYC6nflwvZaP3UE034p5mOJs=;
        b=BgPYJjwWNbWu1IlfPDap2D+SUTCRFl4JuTsdGYP5d1KKFidCKX96fIfXZtFq19nOVj
         11dKb6qyprZQjMQGjtU4rG0Sc0j4gbHmr5G/l9ASWuMDW3Frx4r03bPOW1kTfmbdHJpB
         NTjVbqRiynXonCO/e+1b9bmwftUXz74ZyqzGnXrYf42F4hm4dpxrCUzzInaidNs1x1HM
         HkoZB9vP1vFPj34pi3rd2ZN9J6n+txeoSrE+AwTh6E9Z96tCqtHZWiLjRRx/5nIWuAFJ
         7i1OXS6immMNr5xBqK6jk7/bTedEfU+Ri1i/jnyhgOk61rg2iVDrND1e0/VXwI/mPOBn
         o4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6AvBHQQi2YZFPbOMRbPT2ByUDn9SADLtPw34OoqhbVOMxxT0MvSboZOgE+70JqiL2qRHLHb6jW9WdPbPLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl/Z8OJ/R9cvO7An3+AbzTFiE9GXpWJwyYPEOC+auNgmLeWBy3
	8gVHXisg8YpyfCEtc6pyrBXXWAngmf3qGj1yDNNt68A+h4b2+A7/BXAvVWItSjScwbdAsJOPeCd
	4JbvdAtK4vl5pPy4EC5nxb/HEX5z3XNWB8Bak0Efw
X-Gm-Gg: AZuq6aJVFYulSp2SEUH7KwMb8xATVtGwShpGCCZTIJw3ptqocPP78rpMfRXG6nA+Tc2
	JoFJnBHRMjsLWEOa7xZFVYBEfeuqoSB+23UcWIu/hT+CJQLRKp5SOvHNZNl2w3wEd+bTihYk/AE
	zsGMMh9nc8GVW/cVaaC4H95tCmPY3llqV2V2Ez+9w/3pv6iRnUDzGLZGJhVTZwwAz1yQMzjPuVf
	Ah+j+7lPHF5KH4u1ApZDwtymap/MEPE7YGGdnG2q9zT8YXe+vx8a/VfJGmBaXHuHtRlUzhf6fr/
	m2JYtCI81AgMdpLw0dwK1e0=
X-Received: by 2002:a05:622a:15cb:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-502ece4dbc5mr3059331cf.17.1769043527916; Wed, 21 Jan 2026
 16:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-20-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-20-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 00:58:36 +0000
X-Gm-Features: AZwV_Qgalo5BT2cF8nB5P98paznJER_XoJhiYL5n6D0vsto2yVGgbP9TwAgaUBk
Message-ID: <CAJuCfpF8xYb2j57HzO_-cfaTrOd-+jyv8pr4uFV1KwaSxKvghg@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] mm/slub: remove DEACTIVATE_TO_* stat items
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:41=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The cpu slabs and their deactivations were removed, so remove the unused
> stat items. Weirdly enough the values were also used to control
> __add_partial() adding to head or tail of the list, so replace that with
> a new enum add_mode, which is cleaner.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Same question about UAPI breakage, but otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 7ec7049c0ca5..c12e90cb2fca 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -324,6 +324,11 @@ static void debugfs_slab_add(struct kmem_cache *);
>  static inline void debugfs_slab_add(struct kmem_cache *s) { }
>  #endif
>
> +enum add_mode {
> +       ADD_TO_HEAD,
> +       ADD_TO_TAIL,
> +};
> +
>  enum stat_item {
>         ALLOC_PCS,              /* Allocation from percpu sheaf */
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
> @@ -343,8 +348,6 @@ enum stat_item {
>         CPUSLAB_FLUSH,          /* Abandoning of the cpu slab */
>         DEACTIVATE_FULL,        /* Cpu slab was full when deactivated */
>         DEACTIVATE_EMPTY,       /* Cpu slab was empty when deactivated */
> -       DEACTIVATE_TO_HEAD,     /* Cpu slab was moved to the head of part=
ials */
> -       DEACTIVATE_TO_TAIL,     /* Cpu slab was moved to the tail of part=
ials */
>         DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects =
*/
>         DEACTIVATE_BYPASS,      /* Implicit deactivation */
>         ORDER_FALLBACK,         /* Number of times fallback was necessary=
 */
> @@ -3268,10 +3271,10 @@ static inline void slab_clear_node_partial(struct=
 slab *slab)
>   * Management of partially allocated slabs.
>   */
>  static inline void
> -__add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
> +__add_partial(struct kmem_cache_node *n, struct slab *slab, enum add_mod=
e mode)
>  {
>         n->nr_partial++;
> -       if (tail =3D=3D DEACTIVATE_TO_TAIL)
> +       if (mode =3D=3D ADD_TO_TAIL)
>                 list_add_tail(&slab->slab_list, &n->partial);
>         else
>                 list_add(&slab->slab_list, &n->partial);
> @@ -3279,10 +3282,10 @@ __add_partial(struct kmem_cache_node *n, struct s=
lab *slab, int tail)
>  }
>
>  static inline void add_partial(struct kmem_cache_node *n,
> -                               struct slab *slab, int tail)
> +                               struct slab *slab, enum add_mode mode)
>  {
>         lockdep_assert_held(&n->list_lock);
> -       __add_partial(n, slab, tail);
> +       __add_partial(n, slab, mode);
>  }
>
>  static inline void remove_partial(struct kmem_cache_node *n,
> @@ -3375,7 +3378,7 @@ static void *alloc_single_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>         if (slab->inuse =3D=3D slab->objects)
>                 add_full(s, n, slab);
>         else
> -               add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               add_partial(n, slab, ADD_TO_HEAD);
>
>         inc_slabs_node(s, nid, slab->objects);
>         spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -3996,7 +3999,7 @@ static unsigned int alloc_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>                         n =3D get_node(s, slab_nid(slab));
>                         spin_lock_irqsave(&n->list_lock, flags);
>                 }
> -               add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               add_partial(n, slab, ADD_TO_HEAD);
>                 spin_unlock_irqrestore(&n->list_lock, flags);
>         }
>
> @@ -5064,7 +5067,7 @@ static noinline void free_to_partial_list(
>                         /* was on full list */
>                         remove_full(s, n, slab);
>                         if (!slab_free) {
> -                               add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +                               add_partial(n, slab, ADD_TO_TAIL);
>                                 stat(s, FREE_ADD_PARTIAL);
>                         }
>                 } else if (slab_free) {
> @@ -5184,7 +5187,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>          * then add it.
>          */
>         if (unlikely(was_full)) {
> -               add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +               add_partial(n, slab, ADD_TO_TAIL);
>                 stat(s, FREE_ADD_PARTIAL);
>         }
>         spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -6564,7 +6567,7 @@ __refill_objects_node(struct kmem_cache *s, void **=
p, gfp_t gfp, unsigned int mi
>                                 continue;
>
>                         list_del(&slab->slab_list);
> -                       add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +                       add_partial(n, slab, ADD_TO_HEAD);
>                 }
>
>                 spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -7031,7 +7034,7 @@ static void early_kmem_cache_node_alloc(int node)
>          * No locks need to be taken here as it has just been
>          * initialized and there is no concurrent access.
>          */
> -       __add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +       __add_partial(n, slab, ADD_TO_HEAD);
>  }
>
>  static void free_kmem_cache_nodes(struct kmem_cache *s)
> @@ -8719,8 +8722,6 @@ STAT_ATTR(FREE_SLAB, free_slab);
>  STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
>  STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
>  STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
> -STAT_ATTR(DEACTIVATE_TO_HEAD, deactivate_to_head);
> -STAT_ATTR(DEACTIVATE_TO_TAIL, deactivate_to_tail);
>  STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
>  STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
>  STAT_ATTR(ORDER_FALLBACK, order_fallback);
> @@ -8823,8 +8824,6 @@ static struct attribute *slab_attrs[] =3D {
>         &cpuslab_flush_attr.attr,
>         &deactivate_full_attr.attr,
>         &deactivate_empty_attr.attr,
> -       &deactivate_to_head_attr.attr,
> -       &deactivate_to_tail_attr.attr,
>         &deactivate_remote_frees_attr.attr,
>         &deactivate_bypass_attr.attr,
>         &order_fallback_attr.attr,
>
> --
> 2.52.0
>
