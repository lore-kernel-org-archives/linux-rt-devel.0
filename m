Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D208003D
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049370; cv=pass; b=Fjhg/hUFBbwwR6LYM9DzD2n0WsLLqOF+ugFvVMHBvosF7V4vo78CKkGcJ3fH4uXjKLxZH5KZ4JJu/D0KY6u4A+D4RH1SAkAHyuI3j2o6yNY1taLtjBiUqiOGEYbiHvwHLf7wamvcVq/lfXf4tnfhk1W+0uLY8nGxN7+a7V4OxOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049370; c=relaxed/simple;
	bh=o57sw7Eq2Ffbqvkcn4WNXFGDm5I8fi/7+2OZKFDhkk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT491Ebtatql0lk33/IB/F8n3STtV01FmNjwctXMxrcRZOGcfRWHISg0zKUIAkvPZE81Nwm38MpVnQ6/Hn+8Ow0feUH1WR7Q+rXQQWbNYdvsObZhnRKu1dCMz5GcP6i5W25xVTR2vG/DKKYXtsrgMbJ8KNnf6fEBbMkmz3v2juw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FiglX138; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiglX138"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50299648ae9so104691cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 18:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769049363; cv=none;
        d=google.com; s=arc-20240605;
        b=Zmlo6g1CaeUlHXxzN/n0XAakFsEhLrjlLBeFafwWoyl5AO+AXFRRtrp4DnUyTgZMLN
         sVsO+PG2zJPpT+0AldfelP4AX6uS1okXNnEka+XvD1rn0qsHX7uWBDg76wKEzKkgDceJ
         qM6nhP3dHQHf89vOrPoDJOka+GDp85l05bhF4jlGhHH+UCAPuzrx4uH+zKSCGRj2ZIP7
         mTyq+wP3oaFGwnH86FHoKR8/+385PzLadxnoV8wElyEhbVno9FCldr3E3U0dTS2ut0WX
         Ch2ji8Ut0aNzL7rFR5X23h9qP0dqsKa8mlYJOvgRlcI1YlO0U5UhuwZAeqejl7V6vpFo
         7xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W1ztD/wqbKPGcB/OK5g1Xm5cGzV1LC64G0Uj3l4VYPc=;
        fh=jLxqQ5FktaXfZzOkyAoWmhdK+7+d1RZntDGQE0XCVLw=;
        b=W/NuDMGZs3wo6QcYXU5LX4bJ8cuRtTPOVxBvUSeZzjqUF+3TLk6TCU/s/voF6VLdKU
         3yfk2dGErDIw1I+ux5tTHUyVnc0xDlXRKihNzmlWbnibxP9yX/Yh7OZhRFhXmBjLH6kr
         7HKM9vX5DwtyReHwN1ehJ7LVG6sJ5Zppi7AS/GkTV03cDICb8rnq3yXCdX1HhAXMDYAI
         RPsafiwfXkjJWlVd+tWxjHlb6kqgkL1JjCqDzk3EYhbccZKV6M4ObYoNrVlfsv+8RArv
         ajPWeKPx0KxwqDHOdHZixzTECBiCw8bKizwpOZzbAs3cN6hNfUNZfJe5Kbf86ACGqTDv
         FHAg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769049363; x=1769654163; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1ztD/wqbKPGcB/OK5g1Xm5cGzV1LC64G0Uj3l4VYPc=;
        b=FiglX138tGzNXfFVt1iF3vTBuSGzWB63gEc21l4Ds4p9Te2SoDLYLu2NxQWaN3aeml
         NCkoo5EAY7mgcC7CwRhl057jSAlu0HIZt0zPPiplQYgNvE+gPoUbqAPhAJmL/YuzR3Kn
         ZV4wmWXq+wKph2/Mkj670XrKkuy2EO0xB8vM+tD9dI+YSN2fOUgegu/IaHv6BnQiAhwL
         CtL1R5Veyj9L3DbNP9V9VAC5mV9XafbBkDnf4/ibvindqXtGuF4QctJUdizT55mRWsO4
         mhpA0SdQ89N6HnyOVblbwjN42RX6OKwbMozJ9p6dcz4pXFYcJjP2hgbERbjm4HxN5/VA
         YcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769049363; x=1769654163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1ztD/wqbKPGcB/OK5g1Xm5cGzV1LC64G0Uj3l4VYPc=;
        b=kIGi8ZB5kGg5QAdacOXFGItdgVCVterH0kZfXTGuwbSMXKiSPwO2mOtLLHrpD0BWpk
         tAg4NtLIFytsI+rboDXcZO+JLYUkLcK0eI54MNlqZtt9OXUFbzgQXjiCVn+b8UDlMRbw
         fNstM6ZVPIp+Ov6jyIO+ixDg92tLBkUe9DRUWDoQuhOJtnTQpjMM2kUyhLmfUbUkjupm
         i/2AYP8Zde2fuM7/mwD13D/KKMnJjf9DJ6aCx3/kIhFRsYBQllFswx6OBRVcUTy/Z0gp
         IOtHF1ZVUFZOfRRdMij6GVmTbX+o8NfctzPqNOwhDpcqWLxHA7+YP1YWJ0FW9NVpb/89
         wi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuIp4lguePKsCsktsasQrEmEJV5DEAHcMQGIjbN7qdSEh4wuXQHWuFoZ7ih8/xoysgcYjmyds9UZrSeSuhUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFuSc0NPjcw73Ul7WaXlTJFeV4EtFvaGhpuPzUbRy/7DtZhVY+
	qtLN1s+6AGbgkiVGOjqpznPkGocqSpLAYUTT8Dubwg58yzLEST8DRWA50c7dJxK67BQSz6pJtj+
	BEEPZxmE2o2OOVnWtlJXtNqDmcaJr+65sa6dpr4nn
X-Gm-Gg: AZuq6aJ1nq/NQLtWjkdNtpmrV6qHQdjVcliMxJvWd86WlauF0Ub2IX7XrdczF6jKF5D
	DXy2tSHuvIHIcANkSPAHTI6pUvWrxvtAee8IU9Wm4GeCAv76YsBAUCfwEILRl3lOg1Cj54kPcFL
	gIv53AoEl9msVSC0Qvj2XgMq4aZE/yZzz3nfk8AOYhrkxVM5JLz64WwPsx6bTkQaHDVjOuHCC1T
	YPmUzM/ddJQeH3jh9aB3hmXVivcOapHqbhLkV9XNAC3N8tmSM7Hw9Hb6bwv7SqK5MlIMA==
X-Received: by 2002:ac8:7d13:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-502ebd66753mr6535371cf.14.1769049362800; Wed, 21 Jan 2026
 18:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-21-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-21-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 18:35:51 -0800
X-Gm-Features: AZwV_Qh9DJqdsygnR2vDEt2pFl_xN2VFuNuBwsJB6lM8tVfE5ettz4wsz-RroIY
Message-ID: <CAJuCfpHg9YfkVwtfCUvLH_0HNWzUgx1ekQ-QMyYBW_Qeqt=WjA@mail.gmail.com>
Subject: Re: [PATCH v3 21/21] mm/slub: cleanup and repurpose some stat items
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

On Fri, Jan 16, 2026 at 6:41=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> A number of stat items related to cpu slabs became unused, remove them.
>
> Two of those were ALLOC_FASTPATH and FREE_FASTPATH. But instead of
> removing those, use them instead of ALLOC_PCS and FREE_PCS, since
> sheaves are the new (and only) fastpaths, Remove the recently added
> _PCS variants instead.
>
> Change where FREE_SLOWPATH is counted so that it only counts freeing of
> objects by slab users that (for whatever reason) do not go to a percpu
> sheaf, and not all (including internal) callers of __slab_free(). Thus
> flushing sheaves (counted by SHEAF_FLUSH) no longer also increments
> FREE_SLOWPATH.

nit: I think I understand what you mean but "no longer also
increments" sounds wrong. Maybe repharase as "Thus sheaf flushing
(already counted by SHEAF_FLUSH) does not affect FREE_SLOWPATH
anymore."?

> This matches how ALLOC_SLOWPATH doesn't count sheaf
> refills (counted by SHEAF_REFILL).
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 77 +++++++++++++++++----------------------------------------=
------
>  1 file changed, 21 insertions(+), 56 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c12e90cb2fca..d73ad44fa046 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -330,33 +330,19 @@ enum add_mode {
>  };
>
>  enum stat_item {
> -       ALLOC_PCS,              /* Allocation from percpu sheaf */
> -       ALLOC_FASTPATH,         /* Allocation from cpu slab */
> -       ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab *=
/
> -       FREE_PCS,               /* Free to percpu sheaf */
> +       ALLOC_FASTPATH,         /* Allocation from percpu sheaves */
> +       ALLOC_SLOWPATH,         /* Allocation from partial or new slab */
>         FREE_RCU_SHEAF,         /* Free to rcu_free sheaf */
>         FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
> -       FREE_FASTPATH,          /* Free to cpu slab */
> -       FREE_SLOWPATH,          /* Freeing not to cpu slab */
> +       FREE_FASTPATH,          /* Free to percpu sheaves */
> +       FREE_SLOWPATH,          /* Free to a slab */
>         FREE_ADD_PARTIAL,       /* Freeing moves slab to partial list */
>         FREE_REMOVE_PARTIAL,    /* Freeing removes last object */
> -       ALLOC_FROM_PARTIAL,     /* Cpu slab acquired from node partial li=
st */
> -       ALLOC_SLAB,             /* Cpu slab acquired from page allocator =
*/
> -       ALLOC_REFILL,           /* Refill cpu slab from slab freelist */
> -       ALLOC_NODE_MISMATCH,    /* Switching cpu slab */
> +       ALLOC_SLAB,             /* New slab acquired from page allocator =
*/
> +       ALLOC_NODE_MISMATCH,    /* Requested node different from cpu shea=
f */
>         FREE_SLAB,              /* Slab freed to the page allocator */
> -       CPUSLAB_FLUSH,          /* Abandoning of the cpu slab */
> -       DEACTIVATE_FULL,        /* Cpu slab was full when deactivated */
> -       DEACTIVATE_EMPTY,       /* Cpu slab was empty when deactivated */
> -       DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects =
*/
> -       DEACTIVATE_BYPASS,      /* Implicit deactivation */
>         ORDER_FALLBACK,         /* Number of times fallback was necessary=
 */
> -       CMPXCHG_DOUBLE_CPU_FAIL,/* Failures of this_cpu_cmpxchg_double */
>         CMPXCHG_DOUBLE_FAIL,    /* Failures of slab freelist update */
> -       CPU_PARTIAL_ALLOC,      /* Used cpu partial on alloc */
> -       CPU_PARTIAL_FREE,       /* Refill cpu partial on free */
> -       CPU_PARTIAL_NODE,       /* Refill cpu partial from node partial *=
/
> -       CPU_PARTIAL_DRAIN,      /* Drain cpu partial to node partial */
>         SHEAF_FLUSH,            /* Objects flushed from a sheaf */
>         SHEAF_REFILL,           /* Objects refilled to a sheaf */
>         SHEAF_ALLOC,            /* Allocation of an empty sheaf */
> @@ -4347,8 +4333,10 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t g=
fp, int node)
>          * We assume the percpu sheaves contain only local objects althou=
gh it's
>          * not completely guaranteed, so we verify later.
>          */
> -       if (unlikely(node_requested && node !=3D numa_mem_id()))
> +       if (unlikely(node_requested && node !=3D numa_mem_id())) {
> +               stat(s, ALLOC_NODE_MISMATCH);
>                 return NULL;
> +       }
>
>         if (!local_trylock(&s->cpu_sheaves->lock))
>                 return NULL;
> @@ -4371,6 +4359,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p, int node)
>                  */
>                 if (page_to_nid(virt_to_page(object)) !=3D node) {
>                         local_unlock(&s->cpu_sheaves->lock);
> +                       stat(s, ALLOC_NODE_MISMATCH);
>                         return NULL;
>                 }
>         }
> @@ -4379,7 +4368,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p, int node)
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat(s, ALLOC_PCS);
> +       stat(s, ALLOC_FASTPATH);
>
>         return object;
>  }
> @@ -4451,7 +4440,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, gfp_t gfp, size_t size,
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat_add(s, ALLOC_PCS, batch);
> +       stat_add(s, ALLOC_FASTPATH, batch);
>
>         allocated +=3D batch;
>
> @@ -5111,8 +5100,6 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>         unsigned long flags;
>         bool on_node_partial;
>
> -       stat(s, FREE_SLOWPATH);

After moving the above accounting to the callers I think there are
several callers which won't account it anymore:
- free_deferred_objects
- memcg_alloc_abort_single
- slab_free_after_rcu_debug
- ___cache_free

Am I missing something or is that intentional?

> -
>         if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>                 free_to_partial_list(s, slab, head, tail, cnt, addr);
>                 return;
> @@ -5416,7 +5403,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object=
, bool allow_spin)
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat(s, FREE_PCS);
> +       stat(s, FREE_FASTPATH);
>
>         return true;
>  }
> @@ -5664,7 +5651,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat_add(s, FREE_PCS, batch);
> +       stat_add(s, FREE_FASTPATH, batch);
>
>         if (batch < size) {
>                 p +=3D batch;
> @@ -5686,10 +5673,12 @@ static void free_to_pcs_bulk(struct kmem_cache *s=
, size_t size, void **p)
>          */
>  fallback:
>         __kmem_cache_free_bulk(s, size, p);
> +       stat_add(s, FREE_SLOWPATH, size);
>
>  flush_remote:
>         if (remote_nr) {
>                 __kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
> +               stat_add(s, FREE_SLOWPATH, remote_nr);
>                 if (i < size) {
>                         remote_nr =3D 0;
>                         goto next_remote_batch;
> @@ -5784,6 +5773,7 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>         }
>
>         __slab_free(s, slab, object, object, 1, addr);
> +       stat(s, FREE_SLOWPATH);
>  }
>
>  #ifdef CONFIG_MEMCG
> @@ -5806,8 +5796,10 @@ void slab_free_bulk(struct kmem_cache *s, struct s=
lab *slab, void *head,
>          * With KASAN enabled slab_free_freelist_hook modifies the freeli=
st
>          * to remove objects, whose reuse must be delayed.
>          */
> -       if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
> +       if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt))) {
>                 __slab_free(s, slab, head, tail, cnt, addr);
> +               stat_add(s, FREE_SLOWPATH, cnt);
> +       }
>  }
>
>  #ifdef CONFIG_SLUB_RCU_DEBUG
> @@ -6705,6 +6697,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t size,
>                 i =3D refill_objects(s, p, flags, size, size);
>                 if (i < size)
>                         goto error;
> +               stat_add(s, ALLOC_SLOWPATH, i);
>         }
>
>         return i;
> @@ -8704,33 +8697,19 @@ static ssize_t text##_store(struct kmem_cache *s,=
               \
>  }                                                              \
>  SLAB_ATTR(text);                                               \
>
> -STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> -STAT_ATTR(FREE_PCS, free_cpu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
>  STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
> -STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
>  STAT_ATTR(ALLOC_SLAB, alloc_slab);
> -STAT_ATTR(ALLOC_REFILL, alloc_refill);
>  STAT_ATTR(ALLOC_NODE_MISMATCH, alloc_node_mismatch);
>  STAT_ATTR(FREE_SLAB, free_slab);
> -STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
> -STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
> -STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
> -STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
> -STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
>  STAT_ATTR(ORDER_FALLBACK, order_fallback);
> -STAT_ATTR(CMPXCHG_DOUBLE_CPU_FAIL, cmpxchg_double_cpu_fail);
>  STAT_ATTR(CMPXCHG_DOUBLE_FAIL, cmpxchg_double_fail);
> -STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
> -STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
> -STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> -STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  STAT_ATTR(SHEAF_FLUSH, sheaf_flush);
>  STAT_ATTR(SHEAF_REFILL, sheaf_refill);
>  STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
> @@ -8806,33 +8785,19 @@ static struct attribute *slab_attrs[] =3D {
>         &remote_node_defrag_ratio_attr.attr,
>  #endif
>  #ifdef CONFIG_SLUB_STATS
> -       &alloc_cpu_sheaf_attr.attr,
>         &alloc_fastpath_attr.attr,
>         &alloc_slowpath_attr.attr,
> -       &free_cpu_sheaf_attr.attr,
>         &free_rcu_sheaf_attr.attr,
>         &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
>         &free_add_partial_attr.attr,
>         &free_remove_partial_attr.attr,
> -       &alloc_from_partial_attr.attr,
>         &alloc_slab_attr.attr,
> -       &alloc_refill_attr.attr,
>         &alloc_node_mismatch_attr.attr,
>         &free_slab_attr.attr,
> -       &cpuslab_flush_attr.attr,
> -       &deactivate_full_attr.attr,
> -       &deactivate_empty_attr.attr,
> -       &deactivate_remote_frees_attr.attr,
> -       &deactivate_bypass_attr.attr,
>         &order_fallback_attr.attr,
>         &cmpxchg_double_fail_attr.attr,
> -       &cmpxchg_double_cpu_fail_attr.attr,
> -       &cpu_partial_alloc_attr.attr,
> -       &cpu_partial_free_attr.attr,
> -       &cpu_partial_node_attr.attr,
> -       &cpu_partial_drain_attr.attr,
>         &sheaf_flush_attr.attr,
>         &sheaf_refill_attr.attr,
>         &sheaf_alloc_attr.attr,
>
> --
> 2.52.0
>
