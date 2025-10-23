Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D948337118
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Oct 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232891; cv=none; b=YgOv/91Hbk/hEYag/a/QNimFSPmL+O+1rnPMEIpYUFbPW8fkxCdLFMIcIwJggyFN7yuJ5JPt/dDbNF4g/3O8b3g4yPYbsn3rf4nNK6UCnCTKYgeWbkwmzC4Ob001wALVxJMb8tb4gATcYF4qNxMqsiSVIiYAfYre1zNzwq4Mf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232891; c=relaxed/simple;
	bh=GkL9WA5K+ltHnePlGyw1wMGJQ1UFA0pchGig9Ct/wWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llgeEi1XIa1YxhyhVitsW4wZvwc59BJVN9opXNHArJmYz0HC52zJoy5uyAp8T8Q1AI18/yvT6Rr3htYZRGZAXDghwf5/qOL9x8dTDk0imWI62ecG9areR5iJJjmFX5K6fwY4kN8zpnRsXBOouKD/JcoF7PPT2YtSjwNQRIqvTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0Q+aeFV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0Q+aeFV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so9112575ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 23 Oct 2025 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761232888; x=1761837688; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2jwrgWQY1h1RtIcpPrpzP6Qz2BnEli8aRyjgsdjGiM=;
        b=U0Q+aeFVqKrLB5t+UKWIIP0GGzghgNIrxpM5RnCsKfy9d+85mof5fY0ffSdVvPlAqV
         exUUEFAEC/Plp6SqNUN7d/6S5z9pWizdPyGX4SRfiLF5e8OYkx6RID1tTQl7O4Faxsn0
         TWjLb0OkPyCoBLOH4X5SbHTOJoeLymYO6LYpk4lo4PThF6QIzfFJOJYOfQzkjtuiPOhA
         nCHJTHtxMh41AssJASM8WfEFgtSdZDdrR1sVsJe8YcUpFQIewHxO+FmHvoRz70jg3klo
         wttLwAK7USlwlAAT0JhM4cky9vylKcvA1LSBr2ArJh5YSr04k2bKrFOCm19076XUd1v6
         usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232888; x=1761837688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2jwrgWQY1h1RtIcpPrpzP6Qz2BnEli8aRyjgsdjGiM=;
        b=m4pcAvMFkVNaHhf851daSwXGlgCsJnDY6OUVWM9dLP1I/M7mBKqi6Wb5MTbnGBr4uA
         7Lq7NnYZ2yQtSqn2PJ7H04JGj2d1hiShlsIMecAFv8H7yauSqtURoUGUqDU7/aIEOQQh
         px9oVH2ECwpJC1a1PpK1U+ND2XGY8JjEOW0t5l6lv/i/klwSSF70iegjlia36ZxN8lR8
         79ifXrGHqe8IGFxxCNFhnzkf/sO8c4aurlnesv14AYlfVPpf2qENCPGfax4+MPBaQ2JO
         YF4FxQ7kF442vJari7d1pkw0Nas7UfYlQKO3naJe4Q78w4bwioCIA09OVl19a64MKA+m
         jBsw==
X-Forwarded-Encrypted: i=1; AJvYcCX1TXRzSPGuVf5wS/EBNcU2K1KI+GbLCQIApTT7nGiGmbC0BBvc/ahjyD80FdmWJNRtleY8Rn+ZT4rm0fBCGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxiMaFG5PTzOxFbASexTXOOHozJfP8Va3403qBBYqoeD4UqF34
	fMyzlHyIDBnpd5lboSXI7+QS3DUMkHd/XxFyCNErDVkb79CQo3LjFG+lI2GichfbCtqxKLb3H/r
	RsI6/9mPLJ1UL34jIk2k/WBL4HBASK/KbQYEPRkaz
X-Gm-Gg: ASbGncvXiOz4rtNAC/wMEylwebTTYrdNzZ7lZIxVN38nObBSSfIWKk4GlPa2hguC07m
	YixKcRsom0Zmn1A82V1xalAerLMKpkTSUR5/2SjeRDvi0vz14UW42qvmGysUopTq0hQgmIQ9Pn4
	7SkykGXJ+LljgBMpOXHMlNfTnHRlOwCuDagQLbwMq86c4+U27OmlnjbYfzYypacbTOpseQ7X9tv
	zleBn37S12HUJavroytNToU/9t9beg8zLo1TOqSEMERVuiHpjkt2RiP8Y1bMolGW2j3sa/ylQfJ
	4s73/igy/fz+yBJgqWRJEIfWQLJdL5D+VK2g
X-Google-Smtp-Source: AGHT+IEWgZ7UzgS2PohV24hBKhF9JtPcksvlA1uoFSx8c8CFEwNgsBYtAGAlA8K3H24IvkOMh8whAfHS8cAKsM7wQww=
X-Received: by 2002:a17:902:e746:b0:28d:195a:7d79 with SMTP id
 d9443c01a7336-290c9c897cemr312219295ad.5.1761232888223; Thu, 23 Oct 2025
 08:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
From: Marco Elver <elver@google.com>
Date: Thu, 23 Oct 2025 17:20:51 +0200
X-Gm-Features: AS18NWBMguvD9NqZ0MBG1ww1DA9Wez_eaadFg_kTQ6tj-ZGocLoyPMGw450Hbw4
Message-ID: <CANpmjNM06dVYKrraAb-XfF02u8+Jnh-rA5rhCEws4XLqVxdfWg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/19] slab: move kfence_alloc() out of internal bulk alloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:53, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> but it's conceptually the wrong layer, as KFENCE allocations should only
> happen when objects are actually handed out from slab to its users.
>
> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> was refilled with KFENCE objects. Continuing like this would also
> complicate the upcoming sheaf refill changes.
>
> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> to the places that return slab objects to users. slab_alloc_node() is
> already covered (see above). Add kfence_alloc() to
> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> prefilled sheafs, with a comment that the caller should not expect the
> sheaf size to decrease after every allocation because of this
> possibility.
>
> For kmem_cache_alloc_bulk() implement a different strategy to handle
> KFENCE upfront and rely on internal batched operations afterwards.
> Assume there will be at most once KFENCE allocation per bulk allocation
> and then assign its index in the array of objects randomly.
>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 87a1d2f9de0d..4731b9e461c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5530,6 +5530,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>   *
>   * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>   * memcg charging is forced over limit if necessary, to avoid failure.
> + *
> + * It is possible that the allocation comes from kfence and then the sheaf
> + * size is not decreased.
>   */
>  void *
>  kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
> @@ -5541,7 +5544,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>         if (sheaf->size == 0)
>                 goto out;
>
> -       ret = sheaf->objects[--sheaf->size];
> +       ret = kfence_alloc(s, s->object_size, gfp);
> +
> +       if (likely(!ret))
> +               ret = sheaf->objects[--sheaf->size];
>
>         init = slab_want_init_on_alloc(gfp, s);
>
> @@ -7361,14 +7367,8 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>         local_lock_irqsave(&s->cpu_slab->lock, irqflags);
>
>         for (i = 0; i < size; i++) {
> -               void *object = kfence_alloc(s, s->object_size, flags);
> -
> -               if (unlikely(object)) {
> -                       p[i] = object;
> -                       continue;
> -               }
> +               void *object = c->freelist;
>
> -               object = c->freelist;
>                 if (unlikely(!object)) {
>                         /*
>                          * We may have removed an object from c->freelist using
> @@ -7449,6 +7449,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>                                  void **p)
>  {
>         unsigned int i = 0;
> +       void *kfence_obj;
>
>         if (!size)
>                 return 0;
> @@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>         if (unlikely(!s))
>                 return 0;
>
> +       /*
> +        * to make things simpler, only assume at most once kfence allocated
> +        * object per bulk allocation and choose its index randomly
> +        */
> +       kfence_obj = kfence_alloc(s, s->object_size, flags);
> +
> +       if (unlikely(kfence_obj)) {
> +               if (unlikely(size == 1)) {
> +                       p[0] = kfence_obj;
> +                       goto out;
> +               }
> +               size--;
> +       }
> +
>         if (s->cpu_sheaves)
>                 i = alloc_from_pcs_bulk(s, size, p);
>
> @@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>                 if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
>                         if (i > 0)
>                                 __kmem_cache_free_bulk(s, i, p);
> +                       if (kfence_obj)
> +                               __kfence_free(kfence_obj);
>                         return 0;
>                 }
>         }
>
> +       if (unlikely(kfence_obj)) {

Might be nice to briefly write a comment here in code as well instead
of having to dig through the commit logs.

The tests still pass? (CONFIG_KFENCE_KUNIT_TEST=y)

> +               int idx = get_random_u32_below(size + 1);
> +
> +               if (idx != size)
> +                       p[size] = p[idx];
> +               p[idx] = kfence_obj;
> +
> +               size++;
> +       }
> +
> +out:
>         /*
>          * memcg and kmem_cache debug support and memory initialization.
>          * Done outside of the IRQ disabled fastpath loop.
>
> --
> 2.51.1
