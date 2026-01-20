Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE49348466
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929611; cv=pass; b=ShcLYzaYdR4AiMZLVu2/RfIh1DaX+GRKfcN1/RY0Qbdn8fSWDVnyk0/I7iS6/xW0U7WFXu3ynMtm52lZSk64kuMiC6u/bzhww7dHQWS2JD0VITeP2tRUwSVIJHtEZlKLvRJ7egpKOztEgWCy2exEizdbLf3OvHrH74alHhwVKb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929611; c=relaxed/simple;
	bh=vmFE6Gem1lPQyoSciAtrzm28BM8NUKhCcyfRVDAVyfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkB1jywDwSExtvlCjDxDAwkzwpn5FVUSldQvtk7LwXMFvVrnDBCDbMdHIriOGyJi+fcAtD218U4xzh1RvY1tZxVR1QL0YJU9aVYi0U3tx7YEXG9MbXlEYQn7871+1xrkJgbqQA8aEC7Jf5P8RZKeZYq9vO+huxiNtntvAl3ipMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+MMG4qJ; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+MMG4qJ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50299648ae9so1458411cf.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 09:20:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768929608; cv=none;
        d=google.com; s=arc-20240605;
        b=aUp9mJzeay9rRJiCtU+3vtHvwKLgm7ubp+gSHsuHMHpH9gYd91OwHyu/QthFx5vY+4
         WaA5srMoRPerNez/I2DvespXl0i5jDhjTrXzotWU2UVRAIvBFkePbx57XhFx78f+4o03
         a5R1udP1n5pATPIYGF8heIPosSuA8nQeuOlkAYFf0jZsGbF2TmFipSYkSnWVwuXbGgl9
         EW4KkKDCpYBIqLbKq0gt/hRC9uXz0RZniBFI9YDUVV4vLjjnl+cwAjcoToxXB15NSj0C
         Llj5iKiGB9LYYpVgODBWWvRdMc5apN8IufcwK17Ps5sTiwlqxoqHN6XOzllawpOd6uAm
         fXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XjgInJxzHZA1FL2RVNq/kScJMYVHdTMpDmOcyNlB2Pg=;
        fh=8zDmdnWmgaX49axodhvaj2R8JHQASJNLoC4U6ZGS/4I=;
        b=IFBwvYYRyi6E5t9d9a7lBo6sWz3bUP4ukfnVNJbQRSX8M9XtriBJ45hWOJ5jD6vNaY
         bLsZzuz8F74oBHAJwCYxgxK13LU922fs9Qi152yBx3OvqcVpKt1HF1Xp9lqPaD6q778s
         z/K5y/TIOX/YIyK6C0jM4rM0Wuy2/5uy4vscvL1lYzyMnO7srgBVN/Jue6j1s/WMt1yK
         S4WqZZ5/PnB2IaefH1hPpvTo7J/Lr+tym5o95hBpMlXcUGBbLi0d6QUBE8SPoZ8UxfTd
         WoPkSid/3EMzUoeYROgOAoFf6W92qWxNBzQA1n1O1urVTzuOnTcxrbSwLnr7Y9hVF8D9
         8Lxg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768929608; x=1769534408; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjgInJxzHZA1FL2RVNq/kScJMYVHdTMpDmOcyNlB2Pg=;
        b=X+MMG4qJbgQ08s3y36ofGYBzU6JyfI7tZw8RQut4c+fYPPujNu11aWIU9KT8kVLw+C
         g9AcfF6xHROpwmqvkhbu/pGNmyuMuFuevQ4IsGnJ2yjO52EvovuEYT1UtpJfX1k1H2O6
         bHQWxn0geR26Tq05bwkxkkRLWo1ovsDj9EwhG5/pBKxUfl2xy5HZZG7j0C9uayB7aGWs
         RiyVrbwl7cspRCJGGsrJTFMwQRpAB8QqDT5juPhM3TI9kKMOUIAalVGsKU+vtV4BaGZC
         5zpjFtXHRDAB7CXGF/EvuZG1+Z0YAPfdA/60/I6xJYqCp/TFXlzZY6D9yPFOgfS+OB8r
         R2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929608; x=1769534408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XjgInJxzHZA1FL2RVNq/kScJMYVHdTMpDmOcyNlB2Pg=;
        b=RXNz7u+8Fxp4W8R1Gy2imB9WPHsFm0fXFaUjiWyyHUWcKj6BgokWBs+qOYMng/iWZp
         mdcGN4VRa1qES1cONbw20d02mrhOFSJ1XY6Jd9eCVAVi8s3zl5cJJ6/11o8SZOUNtxe/
         z1dlx1fkGVU4yAZdLxfE+gFDQ7VQSJKGB50cf1enABv8k8hel0CIanlbEOMb6u3fNTHK
         oBGr3UDmoqYEzGTFs/g7rdmxCzDJV6hsvxhG8bL8I08t4aIVD98NoYdsn3u8pFOf3hJY
         eD5020SSGM9EXNk7R/04XuJE7iuBZQxZKVSJuIVN31H2Nh4Gd91mBQ+eVOtmGJgqFl5H
         4AEg==
X-Forwarded-Encrypted: i=1; AJvYcCUme0xq3Ilgplja+Neudep+TbI1t+JVH8GF0hS14nv2hrL5cQ7wyjWzCExjv3nbljMMphaojFh1OLgr4e5CiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/ot5jrmVG/zNY/eN3AOEV4KwJssYbpFZRh6bS04Sq/kG9JVqR
	NnEkBN/effW+mVnHGGsQo67kOvOirZTlGxMbFOjmSR3COcaPpm9XBEno/2r5TO3Uk3gCfzVTkw8
	kO70nNiZKl4Ij23hvu5EHtbvbhwCywJ/IPnOc+A0R
X-Gm-Gg: AY/fxX6f0iuB9paRwj4wYu0hhEKAZv5bT4STJYuFA4ObDtE2yyYij8BXNY9kw0KG9rK
	+HFf/1aS8Jm3CecRZqYsCi5YudTuu/WnTrpPuuOaJuaJSYcztIdrJkOhg/bvFqdHKBDjY+DzXr9
	9YsC4d1Kz1ZQ7Vt9O9aaDpySd9Sbav5Ey0e/EEQKQ21WwlZUXvqAOMuwzCC5S9HnpmQo4c0aOtV
	qSoUYIKjrgsjVK1MvhVU7qw1JOJIJ1cr233STNsvoFKdBhNzsNRozut1v0jBIHy+shX42mTGOAc
	W6gl+6YHqtZg2y4wl5pWT0sD9nrC7SaZSA==
X-Received: by 2002:ac8:7f49:0:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-502b07275d9mr30014031cf.17.1768929607523; Tue, 20 Jan 2026
 09:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Jan 2026 17:19:56 +0000
X-Gm-Features: AZwV_Qi9JsdZs4u4zpyMKVEbr1yatFKMUCA5FvcV_dcEEUthHo8JPVRpfNJYn0g
Message-ID: <CAJuCfpErRjMi2aCCThHiS1F_LvaXjkVQvX9kJjqrpw8YnXoNBA@mail.gmail.com>
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

On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> At this point we have sheaves enabled for all caches, but their refill
> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> slabs - now a redundant caching layer that we are about to remove.
>
> The refill will thus be done from slabs on the node partial list.
> Introduce new functions that can do that in an optimized way as it's
> easier than modifying the __kmem_cache_alloc_bulk() call chain.
>
> Extend struct partial_context so it can return a list of slabs from the
> partial list with the sum of free objects in them within the requested
> min and max.
>
> Introduce get_partial_node_bulk() that removes the slabs from freelist
> and returns them in the list.
>
> Introduce get_freelist_nofreeze() which grabs the freelist without
> freezing the slab.
>
> Introduce alloc_from_new_slab() which can allocate multiple objects from
> a newly allocated slab where we don't need to synchronize with freeing.
> In some aspects it's similar to alloc_single_from_new_slab() but assumes
> the cache is a non-debug one so it can avoid some actions.
>
> Introduce __refill_objects() that uses the functions above to fill an
> array of objects. It has to handle the possibility that the slabs will
> contain more objects that were requested, due to concurrent freeing of
> objects to those slabs. When no more slabs on partial lists are
> available, it will allocate new slabs. It is intended to be only used
> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
>
> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> only refilled from contexts that allow spinning, or even blocking.
>

Some nits, but otherwise LGTM.
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 264 insertions(+), 20 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 9bea8a65e510..dce80463f92c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -246,6 +246,9 @@ struct partial_context {
>         gfp_t flags;
>         unsigned int orig_size;
>         void *object;
> +       unsigned int min_objects;
> +       unsigned int max_objects;
> +       struct list_head slabs;
>  };
>
>  static inline bool kmem_cache_debug(struct kmem_cache *s)
> @@ -2650,9 +2653,9 @@ static void free_empty_sheaf(struct kmem_cache *s, =
struct slab_sheaf *sheaf)
>         stat(s, SHEAF_FREE);
>  }
>
> -static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> -                                  size_t size, void **p);
> -
> +static unsigned int
> +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int=
 min,
> +                unsigned int max);
>
>  static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>                          gfp_t gfp)
> @@ -2663,8 +2666,8 @@ static int refill_sheaf(struct kmem_cache *s, struc=
t slab_sheaf *sheaf,
>         if (!to_fill)
>                 return 0;
>
> -       filled =3D __kmem_cache_alloc_bulk(s, gfp, to_fill,
> -                                        &sheaf->objects[sheaf->size]);
> +       filled =3D __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
> +                       to_fill, to_fill);
>
>         sheaf->size +=3D filled;
>
> @@ -3522,6 +3525,63 @@ static inline void put_cpu_partial(struct kmem_cac=
he *s, struct slab *slab,
>  #endif
>  static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
>
> +static bool get_partial_node_bulk(struct kmem_cache *s,
> +                                 struct kmem_cache_node *n,
> +                                 struct partial_context *pc)
> +{
> +       struct slab *slab, *slab2;
> +       unsigned int total_free =3D 0;
> +       unsigned long flags;
> +
> +       /* Racy check to avoid taking the lock unnecessarily. */
> +       if (!n || data_race(!n->nr_partial))
> +               return false;
> +
> +       INIT_LIST_HEAD(&pc->slabs);
> +
> +       spin_lock_irqsave(&n->list_lock, flags);
> +
> +       list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> +               struct freelist_counters flc;
> +               unsigned int slab_free;
> +
> +               if (!pfmemalloc_match(slab, pc->flags))
> +                       continue;
> +
> +               /*
> +                * determine the number of free objects in the slab racil=
y
> +                *
> +                * due to atomic updates done by a racing free we should =
not
> +                * read an inconsistent value here, but do a sanity check=
 anyway
> +                *
> +                * slab_free is a lower bound due to subsequent concurren=
t
> +                * freeing, the caller might get more objects than reques=
ted and
> +                * must deal with it
> +                */
> +               flc.counters =3D data_race(READ_ONCE(slab->counters));
> +               slab_free =3D flc.objects - flc.inuse;
> +
> +               if (unlikely(slab_free > oo_objects(s->oo)))
> +                       continue;
> +
> +               /* we have already min and this would get us over the max=
 */
> +               if (total_free >=3D pc->min_objects
> +                   && total_free + slab_free > pc->max_objects)
> +                       break;
> +
> +               remove_partial(n, slab);
> +
> +               list_add(&slab->slab_list, &pc->slabs);
> +
> +               total_free +=3D slab_free;
> +               if (total_free >=3D pc->max_objects)
> +                       break;

From the above code it seems like you are trying to get at least
pc->min_objects and as close as possible to the pc->max_objects
without exceeding it (with a possibility that we will exceed both
min_objects and max_objects in one step). Is that indeed the intent?
Because otherwise could could simplify these conditions to stop once
you crossed pc->min_objects.

> +       }
> +
> +       spin_unlock_irqrestore(&n->list_lock, flags);
> +       return total_free > 0;
> +}
> +
>  /*
>   * Try to allocate a partial slab from a specific node.
>   */
> @@ -4448,6 +4508,33 @@ static inline void *get_freelist(struct kmem_cache=
 *s, struct slab *slab)
>         return old.freelist;
>  }
>
> +/*
> + * Get the slab's freelist and do not freeze it.
> + *
> + * Assumes the slab is isolated from node partial list and not frozen.
> + *
> + * Assumes this is performed only for caches without debugging so we
> + * don't need to worry about adding the slab to the full list

nit: Missing a period sign at the end of the above sentence.

> + */
> +static inline void *get_freelist_nofreeze(struct kmem_cache *s, struct s=
lab *slab)

I was going to comment on similarities between
get_freelist_nofreeze(), get_freelist() and freeze_slab() and
possibility of consolidating them but then I saw you removing the
other functions in the next patch. So, I'm mentioning it here merely
for other reviewers not to trip on this.

> +{
> +       struct freelist_counters old, new;
> +
> +       do {
> +               old.freelist =3D slab->freelist;
> +               old.counters =3D slab->counters;
> +
> +               new.freelist =3D NULL;
> +               new.counters =3D old.counters;
> +               VM_WARN_ON_ONCE(new.frozen);
> +
> +               new.inuse =3D old.objects;
> +
> +       } while (!slab_update_freelist(s, slab, &old, &new, "get_freelist=
_nofreeze"));
> +
> +       return old.freelist;
> +}
> +
>  /*
>   * Freeze the partial slab and return the pointer to the freelist.
>   */
> @@ -4471,6 +4558,65 @@ static inline void *freeze_slab(struct kmem_cache =
*s, struct slab *slab)
>         return old.freelist;
>  }
>
> +/*
> + * If the object has been wiped upon free, make sure it's fully initiali=
zed by
> + * zeroing out freelist pointer.
> + *
> + * Note that we also wipe custom freelist pointers.
> + */
> +static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
> +                                                  void *obj)
> +{
> +       if (unlikely(slab_want_init_on_free(s)) && obj &&
> +           !freeptr_outside_object(s))
> +               memset((void *)((char *)kasan_reset_tag(obj) + s->offset)=
,
> +                       0, sizeof(void *));
> +}
> +
> +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct sla=
b *slab,
> +               void **p, unsigned int count, bool allow_spin)
> +{
> +       unsigned int allocated =3D 0;
> +       struct kmem_cache_node *n;
> +       unsigned long flags;
> +       void *object;
> +
> +       if (!allow_spin && (slab->objects - slab->inuse) > count) {
> +
> +               n =3D get_node(s, slab_nid(slab));
> +
> +               if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> +                       /* Unlucky, discard newly allocated slab */
> +                       defer_deactivate_slab(slab, NULL);
> +                       return 0;
> +               }
> +       }
> +
> +       object =3D slab->freelist;
> +       while (object && allocated < count) {
> +               p[allocated] =3D object;
> +               object =3D get_freepointer(s, object);
> +               maybe_wipe_obj_freeptr(s, p[allocated]);
> +
> +               slab->inuse++;
> +               allocated++;
> +       }
> +       slab->freelist =3D object;
> +
> +       if (slab->freelist) {

nit: It's a bit subtle that the checks for slab->freelist here and the
earlier one for ((slab->objects - slab->inuse) > count) are
effectively equivalent. That's because this is a new slab and objects
can't be freed into it concurrently. I would feel better if both
checks were explicitly the same, like having "bool extra_objs =3D
(slab->objects - slab->inuse) > count;" and use it for both checks.
But this is minor, so feel free to ignore.

> +
> +               if (allow_spin) {
> +                       n =3D get_node(s, slab_nid(slab));
> +                       spin_lock_irqsave(&n->list_lock, flags);
> +               }
> +               add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               spin_unlock_irqrestore(&n->list_lock, flags);
> +       }
> +
> +       inc_slabs_node(s, slab_nid(slab), slab->objects);
> +       return allocated;
> +}
> +
>  /*
>   * Slow path. The lockless freelist is empty or we need to perform
>   * debugging duties.
> @@ -4913,21 +5059,6 @@ static __always_inline void *__slab_alloc_node(str=
uct kmem_cache *s,
>         return object;
>  }
>
> -/*
> - * If the object has been wiped upon free, make sure it's fully initiali=
zed by
> - * zeroing out freelist pointer.
> - *
> - * Note that we also wipe custom freelist pointers.
> - */
> -static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
> -                                                  void *obj)
> -{
> -       if (unlikely(slab_want_init_on_free(s)) && obj &&
> -           !freeptr_outside_object(s))
> -               memset((void *)((char *)kasan_reset_tag(obj) + s->offset)=
,
> -                       0, sizeof(void *));
> -}
> -
>  static __fastpath_inline
>  struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags=
)
>  {
> @@ -5388,6 +5519,9 @@ static int __prefill_sheaf_pfmemalloc(struct kmem_c=
ache *s,
>         return ret;
>  }
>
> +static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> +                                  size_t size, void **p);
> +
>  /*
>   * returns a sheaf that has at least the requested size
>   * when prefilling is needed, do so with given gfp flags
> @@ -7463,6 +7597,116 @@ void kmem_cache_free_bulk(struct kmem_cache *s, s=
ize_t size, void **p)
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
>
> +static unsigned int
> +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int=
 min,
> +                unsigned int max)
> +{
> +       struct slab *slab, *slab2;
> +       struct partial_context pc;
> +       unsigned int refilled =3D 0;
> +       unsigned long flags;
> +       void *object;
> +       int node;
> +
> +       pc.flags =3D gfp;
> +       pc.min_objects =3D min;
> +       pc.max_objects =3D max;
> +
> +       node =3D numa_mem_id();
> +
> +       if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +               return 0;
> +
> +       /* TODO: consider also other nodes? */
> +       if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> +               goto new_slab;
> +
> +       list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> +
> +               list_del(&slab->slab_list);
> +
> +               object =3D get_freelist_nofreeze(s, slab);
> +
> +               while (object && refilled < max) {
> +                       p[refilled] =3D object;
> +                       object =3D get_freepointer(s, object);
> +                       maybe_wipe_obj_freeptr(s, p[refilled]);
> +
> +                       refilled++;
> +               }
> +
> +               /*
> +                * Freelist had more objects than we can accommodate, we =
need to
> +                * free them back. We can treat it like a detached freeli=
st, just
> +                * need to find the tail object.
> +                */
> +               if (unlikely(object)) {
> +                       void *head =3D object;
> +                       void *tail;
> +                       int cnt =3D 0;
> +
> +                       do {
> +                               tail =3D object;
> +                               cnt++;
> +                               object =3D get_freepointer(s, object);
> +                       } while (object);
> +                       do_slab_free(s, slab, head, tail, cnt, _RET_IP_);
> +               }
> +
> +               if (refilled >=3D max)
> +                       break;
> +       }
> +
> +       if (unlikely(!list_empty(&pc.slabs))) {
> +               struct kmem_cache_node *n =3D get_node(s, node);
> +
> +               spin_lock_irqsave(&n->list_lock, flags);
> +
> +               list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_lis=
t) {
> +
> +                       if (unlikely(!slab->inuse && n->nr_partial >=3D s=
->min_partial))
> +                               continue;
> +
> +                       list_del(&slab->slab_list);
> +                       add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               }
> +
> +               spin_unlock_irqrestore(&n->list_lock, flags);
> +
> +               /* any slabs left are completely free and for discard */
> +               list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_lis=
t) {
> +
> +                       list_del(&slab->slab_list);
> +                       discard_slab(s, slab);
> +               }
> +       }
> +
> +
> +       if (likely(refilled >=3D min))
> +               goto out;
> +
> +new_slab:
> +
> +       slab =3D new_slab(s, pc.flags, node);
> +       if (!slab)
> +               goto out;
> +
> +       stat(s, ALLOC_SLAB);
> +
> +       /*
> +        * TODO: possible optimization - if we know we will consume the w=
hole
> +        * slab we might skip creating the freelist?
> +        */
> +       refilled +=3D alloc_from_new_slab(s, slab, p + refilled, max - re=
filled,
> +                                       /* allow_spin =3D */ true);
> +
> +       if (refilled < min)
> +               goto new_slab;

Ok, allow_spin=3Dtrue saves us from a potential infinite loop here. LGTM.

> +out:
> +
> +       return refilled;
> +}
> +
>  static inline
>  int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t si=
ze,
>                             void **p)
>
> --
> 2.52.0
>
