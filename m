Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB444D008
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011990; cv=pass; b=lia4l4rHa3wcHVr3EJ568r6e2RbHfITWW0LRtQNm6+qZ0OHjrM5DZZTkLJ0ve0g7y5PMJofQGvViNs8veIb4C6LH+17V7quOPcwMY/jlmCaF0eVfPj9fiNsGZpfeRpxIugqAXgCrq4zg7EvrOo6CGpXBeY0Gg7R3fpvxnXvLHQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011990; c=relaxed/simple;
	bh=09NOKDVJj6trxa1kaSXP8kGXrD3k9fvCUVw5NqQHsJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptEPlOzRDBW0qZMAOv1ZsrR+DXLFvY1D+rUhV3ctBpp8S6tQJrWbLmjCjfkQwyeeqru6w8VDnZt3eOGml48biDwt8AEr0LMKdMFjHsMaE0HL9y7W8CIxoZCOl+M87RRwXTshfOXLYiglyF9hN+IMH8ohSGy/2MPFCfwH96PtV3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhEKQejn; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhEKQejn"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014acad6f2so88771cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769011986; cv=none;
        d=google.com; s=arc-20240605;
        b=KglTWq8wqdmwfCbNJnkXoA6G12KIOcMiTDi9dKCsifdQnNHx6Fa7YxtyJ2z7cONlq5
         GK0pWEFms+iqqrrctgA/q2krx0ZPINkBGuJVJm4eEfFbJGb0IsIoOj1YIINptLpQkq8f
         tgqgRjuECw8yfEvlDAJcGxziZo/b/zv44s6RX9HlzObRKOqtjfe6Abt3DhfeQbTzcwlA
         WUumywgLB7/cL54xb4asy1cWgiVEgBvOua+biKble9+7GVxuapZqJe25Eju8EwggIczC
         YKJTtoHvUP1eSC/sAQrWGhYy7dX1w/QIKTDAr07sOueTF//PzQsMgt3qYBKt8oyTms53
         PC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1GwHpmSY+Ssuo+YrlkBnP/wYaSl4q4+E3mKjKXYR/c=;
        fh=ea4QqNEWwbSeTK7gIbjbFg4aVAP2BEdqAznnV1GJLDs=;
        b=H+EzuqCDFTJ9rsjHmQuDRph+J+sBVmcvbNPeSwu8QkTcOJFXqgwwtQ7Vw4hsxMRZ1U
         rNvQnvfDS7jppPgLvEDShb1TSZ19noHDzNJ3ti6UHlvB31eVcm/tOCQrKhBrvQMk1DHM
         EMjGU0DaDNyLBdDtz7xOQrc8rrQeuXoEo7AB+xx66NCIDRSSxcpcPNjLJwU4a0hj7wDS
         ApYoI8QFlOXM1vPLEFU201lW3LETAaYQJMNP9/dhSXj0Xyr3ny4kQKRufFdB+pvqUrZb
         Rwl48HYffVZ8zJp4bCeh45son5fDFae0gMN+LBM7ITVjP4MHOG17jklD/PmDuHebMwJ4
         K3rw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011986; x=1769616786; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1GwHpmSY+Ssuo+YrlkBnP/wYaSl4q4+E3mKjKXYR/c=;
        b=RhEKQejnKsYZzMUfU6Z+UaSnif3RmzdXmgQm2yOow6dU8gcWuPdzdySU+T9lzoVhCi
         ma4QeeLWt1KmYinb9NlgkjJxBAfQ0junxgZD6mUY3pPddc4LRLHzVzZ4VI5I7DZUv4Kq
         cU9caTt+WN29Y0GnTqxndXlXjgmWaxOWqc7oycBZClcDjpcq7KV+8pfuVHB1v4sj3g4N
         LV0JYZGeVugOWEbdYg/mBaTtmvoS72NVkZdznuiVN/VpbgPCAkTvKjQeC3oMGuLO07dw
         zkD60vt1LYRi0C+c1F5B5dE7V7vBEYPa9g6SJt7Vhhct3/Hx+5YDFEDRsyv4Cgtsv+Ls
         BCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011986; x=1769616786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1GwHpmSY+Ssuo+YrlkBnP/wYaSl4q4+E3mKjKXYR/c=;
        b=dpDagfEJGlDxV7Q2rlbpcxNKzsHeHeao/T8yA+BV05QujOY/mg16aJ+bRxOlZvvIQK
         EBigGWIFvuAmn2+ph54qqKTtBVzwPkYwVCVKPLmwbu+wbkP2ugM3r4ITmduYnPzGb10u
         DTsmcSycpy19epufo8E0GzYaR7tm+cOXU/3J4QmQ71vKNGqqxg2UhxhHvZaXFAIABwI/
         dKAnQovZd4xZwzeTiJ+2gSmQ8octjaG/4Ui06KCopl16Tjsw9cbTr7uXjMmkUvXiaE0Q
         Dzxup9b38Ieorzf9B7DKB2UfYQs226wToGIEY4cae0UPMU4/1nKoclK5pmjhBV/2oHWf
         hPew==
X-Forwarded-Encrypted: i=1; AJvYcCUd+QVWoHEZjNfVMonioiMDDAuVsz0lPGdn8xqV6sELlqSi40jDhWg7DmXDkd3xTriEBn9ztWCLYv7OWcQnNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ14fBLDhvLDkFSnHeB/pPHNbpwQO3Xl7UTpBN5FRDQkw7BUDF
	TtMiUWKrIRnBQ7ypKVrhU8LEKj7nHRwa4l1bDvypJB8E8tNBHETcYPJ2YtWwju28kuxsGrlNYRw
	QJ4XQE7xkiGhNtYYzFalB8BrIrHBoaFXHpE3lzfYl
X-Gm-Gg: AZuq6aIWYzMboANRE494o5T21p28ya3xgSF02za+Rj+JJZFQRP+MsDMbb4+wzmkSKFP
	LLcksUm94wBqWfNS7TtUVQLpCFplmTUEC0U5TWpKSmvyxfB8BTrCaFz51Q0i12MdN0tqT79oHND
	/9StkeZ/g5sm3dOzSBBc1WNJdP4SJrsBh/KNS6LXxV0Niu9x7mp+zi3lokYFZ3pgBKmwNAKojWb
	3Ep1szXRNSEwipRXa3rKAcVOJJSvwKhy5Qk3NMSeZpypBoyKNRWAZjSH6ykZ8zWcDwA2ffVRD3C
	HzGCK2H7qaLKvTzEliaz8894a7T0PYXg0g==
X-Received: by 2002:a05:622a:1888:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-502e1a18978mr11594511cf.1.1769011985614; Wed, 21 Jan 2026
 08:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz> <CAJuCfpErRjMi2aCCThHiS1F_LvaXjkVQvX9kJjqrpw8YnXoNBA@mail.gmail.com>
 <fec4ed92-32e1-4618-99d6-0eac77da1ff3@suse.cz>
In-Reply-To: <fec4ed92-32e1-4618-99d6-0eac77da1ff3@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:12:54 +0000
X-Gm-Features: AZwV_QiSjzEmuwsWdtzV6KlI2OJ4fFRrfgPi7_dAQ80cVBUvpM4Z4I7qS0kyx9I
Message-ID: <CAJuCfpFzZnbZBX84xTTtTHmKebVxWXUXjFe5AQRTGnu-9AnRLA@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial list
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

On Wed, Jan 21, 2026 at 1:22=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/20/26 18:19, Suren Baghdasaryan wrote:
> > On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> At this point we have sheaves enabled for all caches, but their refill
> >> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> >> slabs - now a redundant caching layer that we are about to remove.
> >>
> >> The refill will thus be done from slabs on the node partial list.
> >> Introduce new functions that can do that in an optimized way as it's
> >> easier than modifying the __kmem_cache_alloc_bulk() call chain.
> >>
> >> Extend struct partial_context so it can return a list of slabs from th=
e
> >> partial list with the sum of free objects in them within the requested
> >> min and max.
> >>
> >> Introduce get_partial_node_bulk() that removes the slabs from freelist
> >> and returns them in the list.
> >>
> >> Introduce get_freelist_nofreeze() which grabs the freelist without
> >> freezing the slab.
> >>
> >> Introduce alloc_from_new_slab() which can allocate multiple objects fr=
om
> >> a newly allocated slab where we don't need to synchronize with freeing=
.
> >> In some aspects it's similar to alloc_single_from_new_slab() but assum=
es
> >> the cache is a non-debug one so it can avoid some actions.
> >>
> >> Introduce __refill_objects() that uses the functions above to fill an
> >> array of objects. It has to handle the possibility that the slabs will
> >> contain more objects that were requested, due to concurrent freeing of
> >> objects to those slabs. When no more slabs on partial lists are
> >> available, it will allocate new slabs. It is intended to be only used
> >> in context where spinning is allowed, so add a WARN_ON_ONCE check ther=
e.
> >>
> >> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> >> only refilled from contexts that allow spinning, or even blocking.
> >>
> >
> > Some nits, but otherwise LGTM.
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks.
>
> >
> > From the above code it seems like you are trying to get at least
> > pc->min_objects and as close as possible to the pc->max_objects
> > without exceeding it (with a possibility that we will exceed both
> > min_objects and max_objects in one step). Is that indeed the intent?
> > Because otherwise could could simplify these conditions to stop once
> > you crossed pc->min_objects.
>
> Yeah see my reply to Harry, it's for future tuning.

Ok.

>
> >> +       if (slab->freelist) {
> >
> > nit: It's a bit subtle that the checks for slab->freelist here and the
> > earlier one for ((slab->objects - slab->inuse) > count) are
> > effectively equivalent. That's because this is a new slab and objects
> > can't be freed into it concurrently. I would feel better if both
> > checks were explicitly the same, like having "bool extra_objs =3D
> > (slab->objects - slab->inuse) > count;" and use it for both checks.
> > But this is minor, so feel free to ignore.
>
> OK, doing this for your and Hao Li's comment:

Sounds good. Thanks!

>
> diff --git a/mm/slub.c b/mm/slub.c
> index d6fde1d60ae9..015bdef11eb6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4505,7 +4505,7 @@ static inline void *get_freelist(struct kmem_cache =
*s, struct slab *slab)
>   * Assumes the slab is isolated from node partial list and not frozen.
>   *
>   * Assumes this is performed only for caches without debugging so we
> - * don't need to worry about adding the slab to the full list
> + * don't need to worry about adding the slab to the full list.
>   */
>  static inline void *get_freelist_nofreeze(struct kmem_cache *s, struct s=
lab *slab)
>  {
> @@ -4569,10 +4569,17 @@ static unsigned int alloc_from_new_slab(struct km=
em_cache *s, struct slab *slab,
>  {
>         unsigned int allocated =3D 0;
>         struct kmem_cache_node *n;
> +       bool needs_add_partial;
>         unsigned long flags;
>         void *object;
>
> -       if (!allow_spin && (slab->objects - slab->inuse) > count) {
> +       /*
> +        * Are we going to put the slab on the partial list?
> +        * Note slab->inuse is 0 on a new slab.
> +        */
> +       needs_add_partial =3D (slab->objects > count);
> +
> +       if (!allow_spin && needs_add_partial) {
>
>                 n =3D get_node(s, slab_nid(slab));
>
> @@ -4594,7 +4601,7 @@ static unsigned int alloc_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>         }
>         slab->freelist =3D object;
>
> -       if (slab->freelist) {
> +       if (needs_add_partial) {
>
>                 if (allow_spin) {
>                         n =3D get_node(s, slab_nid(slab));
>
