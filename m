Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9431327D
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043269; cv=pass; b=fjFIinXV6XEENWLFspzbEh0fjyOKVypzUMVgcn0G1Wt+5hi3+pVbFJvw9QRlaLwqvRB/5fETFDM2AnchwO8wtC4MfyisI0rTKXSLnElGQPZEJRIGYQzyrXfWCqKjn+Eie/WA4Tc7811u433Ok3a3DyXCAAJvWNCoFjRkFKrvddA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043269; c=relaxed/simple;
	bh=eCNedl2PKMJiMiRk0LWzQqYYJO40z/8qt0BTukFMW4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua5UNY15fTW1ZwLhJuv63XzK7lDRtbHbRAT3Eoe5Pd4AN+6Q4vl3hjVewYfRhc3+jGVq21OgN5DYyTwOj5aPOA//TJReyeciv3DpKfv870YrISWFLSOP7u0T/3eZ8S6uduhfagede540c9JqQe0egpqxkPLL6KCosmZacIrwTzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhJckJiv; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhJckJiv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014b5d8551so100331cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769043260; cv=none;
        d=google.com; s=arc-20240605;
        b=iKrAeYppblthhkxX96Bs1jv3Nb0VT8k3Tzii/vtja/EwPZgUS3P7VLPraxoXzUv+0A
         PJVlm3ETrLXrBPV995lIAyG90nU40i5cbQTAE237MrfCOxamACv047YopKg/kZ0c94ub
         dRiW8CGtCARqegbm75jEkaNSehwm1l4C01qgIWHc4Mw2gHxw4WJiSa5lsqRlWVPQxhHU
         pIH2Y3fLu9WKmQnIpRYK89gO3skpsA6fkmwkSynQHkiMy5CvDxfHHwT1wvbNXKhIcHJi
         G4N6idfwj96ah6zMHJi1WdG1F28M7BYmoZuSZZ/X9Ujo9F33WWHBWcXXScAR0nj4rI0B
         H1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+NqFR4vEi17NIt2eo657HYzQ+UfH+loYG1rnphf1kfI=;
        fh=3/zUo7gyxbppsp5nXy4IV/wEDG16UeGLvBrXss3Q4mA=;
        b=YefBTGC6KAuM74sU+b8dqiXbLA2apklkhM6ZJOxZJmNvvFLecn3Y50cUSaCxGRBCQG
         iteMbF0j/1UOfk6uEkIcTL8/GJ/bNDPIzo6xz/8jp6HhNrWGuwnqn5klxsm8wdu9brPT
         yoDH02RBemzwoICLKIGjW19SJv6AQRGOLDBnM79q5aIwUyHMJTVuIcwmVUMEHJXnPZhL
         1oOUDGOSNFumB45ZIAjb5U56E9qX7o4FLC5LuHsv/RJvgYFWI4sefRPvjRNzGbD932Zh
         3X9xmFYT5SaSh1tj7T+LuYib/O5mkNYJ4p5AFiBjAWl2BR+xbz9lkA0zO4nX43SqvD3e
         TSCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769043260; x=1769648060; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NqFR4vEi17NIt2eo657HYzQ+UfH+loYG1rnphf1kfI=;
        b=BhJckJivfVFP1RjLPTiqa9Fddh30WLYgzfNm5LdfhjT5ZU6SW/I7lo7waAa5rN23C8
         cz5UCegIENbcYStuRqx6Yf5AhWp5l9pZmBfYnGH2yPYoq3iBRgWi/KycFgLGS67Lc/j3
         t5vgDBlopp55XLRsMkhqlHo9VhwWLDTmbk+G3MLkOqXRpU08IKHvtU5X/4Z3dCVFS4ZX
         POWrPWkNI4eHESxGoFti0+rHeRzkmyqs+LiHMEQZhFcTCf3mTgdzIoKVLBU+f4ytYb3c
         Hns3Pz0QFmuPR6ncxCkQahAzA/zi7311QfiWHP9OC71Zsmg+egs83gbamxkwqDsmWV5+
         vubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769043260; x=1769648060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NqFR4vEi17NIt2eo657HYzQ+UfH+loYG1rnphf1kfI=;
        b=JI5taRXmyPayHV7TAPFggG+TjHb0jIh2uRKGS7lNbl7MpWtDXMxxMNp7rbnemVU+/G
         SdyxVOHFGDOjPJv93KbK3MBn/W1dUhKazMd1aviIRqTcFHjv+6zFOJ07fk4cre+pmIut
         sDknQfzJWaZ8v7gxziT2mcuDZUnp56VhsBn5trWSh1XelW9uDloqIIN179bUGmXwjIix
         sVgi+CBvqEOy+r4OlNNLxD2NQMtq3aIO+5/wz5RdpnWtElByrM98K6jgXk3GHt6aiToB
         XP8uUyAqOslT8tmTG9+ipHhXqLSWTSCxbuDHs3tUaSbcqX4H0/WU1rFqi7dU5SlOumod
         xbBw==
X-Forwarded-Encrypted: i=1; AJvYcCV98e24HlenZj/boOKJqehBAZMsZ8AGcTSmtSTTrOxXb2UZTVGnYBWSKYhZOLPbUvcJtWGs7KQ3cqGxVtYSwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym76DBORttXz/96rzjmnHlLn2us0kRDFStoal8fEADVwwxzYPu
	IuOgQuKFoecMKi2LuvgwNBjEj3dRK7k5pMyTVJMIWQ7vsG+nrYNpzUkmeqgms0IF4DekeaM6oUj
	TE8Suw+shq0dOrBJtj4vihMZerzDO+/BaK+dMN3A3
X-Gm-Gg: AZuq6aKBNz7FVhWHldecO5RDEVyRRx5f4ejo7lTH/OgykgS81HPYC/2ilCVX16NuZF6
	rFbB4+D90GMSax6KP9ka+GKAyfaOpEqcMdr1prWgHghqWP+xkVKs+gNEkUbqEzKZw89aWxH/CYS
	Ivw+hGD4Hakc6uGw7Mga4A2xPUmlY+WZFzspWG4tDmcNPUYn0zodsZfR+GNWOW0xCBNR/r2Bao8
	ChGWDg19cgZoi19D/j1yWB4rrAI+qDGx0TdZangflNcybDGDQlpB3uwmmcB2qt+NYh47Rp641qy
	Ox1kAqxSKV7noLO+MUCcjmiuDR5zpuhaQg==
X-Received: by 2002:ac8:7f11:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-502ebd67f28mr5244541cf.8.1769043259374; Wed, 21 Jan 2026
 16:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 00:54:08 +0000
X-Gm-Features: AZwV_QiKaqX658yaaNclaMUDJFMuWaWyjwe3fGXZJxanEvpjJyRl1f7lSqjnfpQ
Message-ID: <CAJuCfpHggP+iefwGTOWnSxDma5U=uMROYNs8KS0A=u2w=1rq_w@mail.gmail.com>
Subject: Re: [PATCH v3 19/21] slab: remove frozen slab checks from __slab_free()
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
> Currently slabs are only frozen after consistency checks failed. This
> can happen only in caches with debugging enabled, and those use
> free_to_partial_list() for freeing. The non-debug operation of
> __slab_free() can thus stop considering the frozen field, and we can
> remove the FREE_FROZEN stat.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Functionally looks fine to me. Do we need to do something about the
UAPI breakage that removal of a sysfs node might cause?

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 476a279f1a94..7ec7049c0ca5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -333,7 +333,6 @@ enum stat_item {
>         FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
> -       FREE_FROZEN,            /* Freeing to frozen slab */
>         FREE_ADD_PARTIAL,       /* Freeing moves slab to partial list */
>         FREE_REMOVE_PARTIAL,    /* Freeing removes last object */
>         ALLOC_FROM_PARTIAL,     /* Cpu slab acquired from node partial li=
st */
> @@ -5103,7 +5102,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                         unsigned long addr)
>
>  {
> -       bool was_frozen, was_full;
> +       bool was_full;
>         struct freelist_counters old, new;
>         struct kmem_cache_node *n =3D NULL;
>         unsigned long flags;
> @@ -5126,7 +5125,6 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                 old.counters =3D slab->counters;
>
>                 was_full =3D (old.freelist =3D=3D NULL);
> -               was_frozen =3D old.frozen;
>
>                 set_freepointer(s, tail, old.freelist);
>
> @@ -5139,7 +5137,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                  * to (due to not being full anymore) the partial list.
>                  * Unless it's frozen.
>                  */
> -               if ((!new.inuse || was_full) && !was_frozen) {
> +               if (!new.inuse || was_full) {
>
>                         n =3D get_node(s, slab_nid(slab));
>                         /*
> @@ -5158,20 +5156,10 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>         } while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"=
));
>
>         if (likely(!n)) {
> -
> -               if (likely(was_frozen)) {
> -                       /*
> -                        * The list lock was not taken therefore no list
> -                        * activity can be necessary.
> -                        */
> -                       stat(s, FREE_FROZEN);
> -               }
> -
>                 /*
> -                * In other cases we didn't take the list_lock because th=
e slab
> -                * was already on the partial list and will remain there.
> +                * We didn't take the list_lock because the slab was alre=
ady on
> +                * the partial list and will remain there.
>                  */
> -
>                 return;
>         }
>
> @@ -8721,7 +8709,6 @@ STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
> -STAT_ATTR(FREE_FROZEN, free_frozen);
>  STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
>  STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
>  STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
> @@ -8826,7 +8813,6 @@ static struct attribute *slab_attrs[] =3D {
>         &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
> -       &free_frozen_attr.attr,
>         &free_add_partial_attr.attr,
>         &free_remove_partial_attr.attr,
>         &alloc_from_partial_attr.attr,
>
> --
> 2.52.0
>
