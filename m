Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B870261B83
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542340; cv=pass; b=tYlQQCegixXQVklNJWDNmn5fsoLruSLEYcJoR7PcZtu/raw9R6q2oRsNeIP6Y+9J4gUymofEfn9RenJUUtKoeyCWGXSk6FJrqxF+zjWz4IOZnO1aHlRLe+bXQpKdk8rcG1gQz44mTJhiOCQIsWyji2u92NQEkyg9ZOQKQQlHAU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542340; c=relaxed/simple;
	bh=O7GOd0Lhv+RwGmCCcJI3vXg56EI/++xWS58YgV3u1t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tstsTB//ThN0WqytdeGzgID4XEIK8Y5CehxwBHBvp8hQcIbHwfQcABJE9iD4mbnBDEUHgA/3HVO5KdVEkDq0fkajukd9Ggcik+oQo1dJ5k6ojF3naikRo9dqro0HPuJcyJPsqD5jnTCNQ+b+a+MdYEWaXCNj3XYBPFgtSqREna4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26PEHiJO; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26PEHiJO"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-501511aa012so241311cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 21:45:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768542337; cv=none;
        d=google.com; s=arc-20240605;
        b=fOp1RwgGP8yuEegLiLzPNwZS7YETvLGT1nMnyMJofhhAQkjLx//m9a/LlOUWdc+2qx
         eiCWmFQomtzSUzs+jUzGNoj+g8a489w4VPHLnki3w7RRl9KVm/2ddePJY7Xy2xbqZhut
         wXzka3G/twpC+cogon+MnfMCgVK+Eg2ls9ypLosooTHHoyVZ0sRWnENLoPXrvg+5sAxK
         9e2v0kW+gc+jeGpc9c9GgKSXGlaaBo/mpkeGtN2q7k92G9DMNiTwOoyQFmh+5zu+v8Eq
         G/ngI5zjltV4+yGn9MvTpZLU0mXf5w1VRyjlI18Q0+wxPzZWZzNoxdxybnT77JWpdcpB
         35KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oD4lKTyPruUjM+2ZGAjFWRV4Lq8q1KPCB1ITiVRP8FE=;
        fh=QLbuhgC7A3aNTU/bctXvZnGbj7flntypP4gIV3KW0Nw=;
        b=gad0yckcmwHZlDl2UQWgctTHxI0SsXuSuf0ZgZuWFw0vPh+FFyIUN4W8CmA70Q5HQW
         Brb1QBnp9Y54WsJLYGJrP2+9+VjhaOLn4uKZliEYWj9Q9AcIDqOlHK6UXCcYzyhwq2Va
         dCMsLIBL9ZPx9bdRugWDZ8WPdJQzbvGw87PMoa9WmIINBnuKdv1yBAMpe18O1MP65awp
         RGm3HQXGzfR6t7sCfQN6GrUJ4Gk0njIbeNVmJFUYZYeO5ci/pVQOnbFY0ZlEckCBGRha
         38IJJM0dWmoDxT0u1+Q7B8jHzd9aBj1fS+dORAXXtv+JyDPqEZKjJ9lh6cwotuGAiK+u
         Mb8A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768542337; x=1769147137; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD4lKTyPruUjM+2ZGAjFWRV4Lq8q1KPCB1ITiVRP8FE=;
        b=26PEHiJOkXfGEgjKP/n5WWLaDT8Zw3gOKWTzlr7dH0G6xKyEtHafg8dNyAsGvY6sSt
         TCFPpXDt+MaiVyuo8vnTsykWPtAjQUj+e0NfjUtzFa15OcuqH7kFtRQkqIC6m2rxnMJj
         13RY2dGJmLsAMUTPzHb9Vq3SMA62SbG030jyoQnZzCb8pmjbj8IsrWJASx6cwfwp9f+5
         mWofynLNgkYyjPwtv8ddOQ96tQc1+x3YA1c1/yZcMa3GThIJ9E/Ftlckf2yAFq3k8pLv
         u7825kBN6qUb/Qd6BvAcJyN274fK6xuS5Au3efgzrqPeHZXSpMgf2pSXj8wXanjgggOx
         bPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768542337; x=1769147137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oD4lKTyPruUjM+2ZGAjFWRV4Lq8q1KPCB1ITiVRP8FE=;
        b=nzbQACIk/jZEheFuRwVS1PPLVeRtbUUnECw2Pe88XAVddmz+LuZcu+utJOMH4Ewt2T
         GK4eYajmL8lu4iChT5JGd2SUagduhU8DykjToCxo4a+sUqCRrC7UC3RbkLT4iAUh3wy+
         NHv0Z6biJ3trNg5xYjunIqvce/q4wJAhN6qHCfpf4z8quMXwYsKK8HxqP57V36cbK7Zu
         si/KSKMhsl99UqC/Ncnj+bQdFZsODOSIA6o3CQ1iJlq93kK5Q7ZqM9lOyz7dItHptSSH
         Cb21EFc/R+mJG9p/UUBiR0xCv9UdJjejOcJZE4/Sz02ulg8rqetzCKfH+rmjQOMahBRq
         TlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGmUrZsHvF/8+E5+kBMKfEXbRc9TgGGR/6u+hq09BsT+rOmN+iJrRLrlj5hKYpzlwVbrpS4bl0z7LA3uU81g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy445RUvnerEM0FbYpXAjpvdUiXQnwbLOOmIFhCyMoKiM0/p+eg
	ensO+I6a9Mvq3d/kh7RjIg4lvO+eopzBofz/vYv9VC5qciVrG91DS/N1VHBapFWBpvJkFpV/NmC
	2O1kY/bep6pCwwp5LZ1l+f5yahfIqtTs5+rypOy+B
X-Gm-Gg: AY/fxX7TCsoc+VGwWG2jEe2hVPwNHjPhyN8V9bX8PYL2AuCQOgPNUgtXjRvgB0iPMq5
	M4vgEckjcuRhuye5aE2aw4FU45ohZsy57ekB8YC8IRvltMCzZiEAyBXqxa8Goc5M3A3UCaf39oB
	R58Zcf2/lcPwgRrqr94FK40eeqFtdfd54lI9jPLcBpjWkocct9TrPnXBeZx7T2B+EzINp15ylhp
	2yCT9hr9M3qX3U04W1m+glNJgN8vVM9+J54guCEdf32lht1zn2/UFplTiibL3uTCmPa76j/q6pb
	A+7v6ZDA81FwFVljDnWu70pPWF/+cwlLfg==
X-Received: by 2002:ac8:5a93:0:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-502a23ba0bemr6815851cf.12.1768542336851; Thu, 15 Jan 2026
 21:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz> <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 05:45:26 +0000
X-Gm-Features: AZwV_Qj313U65TQKJGcZKomalyp4G4s3S9dwtw3N-deAJ8pCUFL8HFCSglYguDc
Message-ID: <CAJuCfpFKKtxB2mREuOSa4oQu=MBGkbQRQNYSSnubAAgPENcO-Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/20] slab: add sheaves to most caches
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

On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> In the first step to replace cpu (partial) slabs with sheaves, enable
> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum,
> and calculate sheaf capacity with a formula that roughly follows the
> formula for number of objects in cpu partial slabs in set_cpu_partial().
>
> This should achieve roughly similar contention on the barn spin lock as
> there's currently for node list_lock without sheaves, to make
> benchmarking results comparable. It can be further tuned later.
>
> Don't enable sheaves for bootstrap caches as that wouldn't work. In
> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
> even for !CONFIG_SLAB_OBJ_EXT.
>
> This limitation will be lifted for kmalloc caches after the necessary
> bootstrapping changes.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

One nit but otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/slab.h |  6 ------
>  mm/slub.c            | 51 ++++++++++++++++++++++++++++++++++++++++++++++=
+----
>  2 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 2482992248dc..2682ee57ec90 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -57,9 +57,7 @@ enum _slab_flag_bits {
>  #endif
>         _SLAB_OBJECT_POISON,
>         _SLAB_CMPXCHG_DOUBLE,
> -#ifdef CONFIG_SLAB_OBJ_EXT
>         _SLAB_NO_OBJ_EXT,
> -#endif
>         _SLAB_FLAGS_LAST_BIT
>  };
>
> @@ -238,11 +236,7 @@ enum _slab_flag_bits {
>  #define SLAB_TEMPORARY         SLAB_RECLAIM_ACCOUNT    /* Objects are sh=
ort-lived */
>
>  /* Slab created using create_boot_cache */
> -#ifdef CONFIG_SLAB_OBJ_EXT
>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_BIT(_SLAB_NO_OBJ_EXT)
> -#else
> -#define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
> -#endif
>
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> diff --git a/mm/slub.c b/mm/slub.c
> index 8ffeb3ab3228..6e05e3cc5c49 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7857,6 +7857,48 @@ static void set_cpu_partial(struct kmem_cache *s)
>  #endif
>  }
>
> +static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
> +                                            struct kmem_cache_args *args=
)
> +
> +{
> +       unsigned int capacity;
> +       size_t size;
> +
> +
> +       if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
> +               return 0;
> +
> +       /* bootstrap caches can't have sheaves for now */
> +       if (s->flags & SLAB_NO_OBJ_EXT)
> +               return 0;
> +
> +       /*
> +        * For now we use roughly similar formula (divided by two as ther=
e are
> +        * two percpu sheaves) as what was used for percpu partial slabs,=
 which
> +        * should result in similar lock contention (barn or list_lock)
> +        */
> +       if (s->size >=3D PAGE_SIZE)
> +               capacity =3D 4;
> +       else if (s->size >=3D 1024)
> +               capacity =3D 12;
> +       else if (s->size >=3D 256)
> +               capacity =3D 26;
> +       else
> +               capacity =3D 60;
> +
> +       /* Increment capacity to make sheaf exactly a kmalloc size bucket=
 */
> +       size =3D struct_size_t(struct slab_sheaf, objects, capacity);
> +       size =3D kmalloc_size_roundup(size);
> +       capacity =3D (size - struct_size_t(struct slab_sheaf, objects, 0)=
) / sizeof(void *);
> +
> +       /*
> +        * Respect an explicit request for capacity that's typically moti=
vated by
> +        * expected maximum size of kmem_cache_prefill_sheaf() to not end=
 up
> +        * using low-performance oversize sheaves
> +        */
> +       return max(capacity, args->sheaf_capacity);
> +}
> +
>  /*
>   * calculate_sizes() determines the order and the distribution of data w=
ithin
>   * a slab object.
> @@ -7991,6 +8033,10 @@ static int calculate_sizes(struct kmem_cache_args =
*args, struct kmem_cache *s)
>         if (s->flags & SLAB_RECLAIM_ACCOUNT)
>                 s->allocflags |=3D __GFP_RECLAIMABLE;
>
> +       /* kmalloc caches need extra care to support sheaves */
> +       if (!is_kmalloc_cache(s))

nit: All the checks for the cases when sheaves should not be used
(like SLAB_DEBUG_FLAGS and SLAB_NO_OBJ_EXT) are done inside
calculate_sheaf_capacity(). Only this is_kmalloc_cache() one is here.
It would be nice to have all of them in the same place but maybe you
have a reason for keeping it here?

> +               s->sheaf_capacity =3D calculate_sheaf_capacity(s, args);
> +
>         /*
>          * Determine the number of objects per slab
>          */
> @@ -8595,15 +8641,12 @@ int do_kmem_cache_create(struct kmem_cache *s, co=
nst char *name,
>
>         set_cpu_partial(s);
>
> -       if (args->sheaf_capacity && !IS_ENABLED(CONFIG_SLUB_TINY)
> -                                       && !(s->flags & SLAB_DEBUG_FLAGS)=
) {
> +       if (s->sheaf_capacity) {
>                 s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_sheave=
s);
>                 if (!s->cpu_sheaves) {
>                         err =3D -ENOMEM;
>                         goto out;
>                 }
> -               // TODO: increase capacity to grow slab_sheaf up to next =
kmalloc size?
> -               s->sheaf_capacity =3D args->sheaf_capacity;
>         }
>
>  #ifdef CONFIG_NUMA
>
> --
> 2.52.0
>
