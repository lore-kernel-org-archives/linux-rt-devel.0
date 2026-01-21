Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93338346783
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029124; cv=pass; b=ERMfNH4D8K58aEoBOjh11dXJDhMqHLE2aFeErzdneHjQu0h34Hyx/t9AlYXqzkOnKyWfg8I6WJwLBMFHiLgR4kzPwEsc2RwEMb+PUql1fC8uvq9xUwalgYVkrOXUhkoMyn1mhh5ehcKrmjV9AdXyOiKUtObJWRi6OyD+PPwBvlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029124; c=relaxed/simple;
	bh=YDyHEOSMn673X668lJYw+uyqdF+ziUDMh+gWKCZFRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJrY02e2/EhYZMYvNyHCZPFVi4ynRyLuKAvhgBjT3RGqMgowVH+x94C3zF9MN1uDfry5fzeTl3Da+hQHQj+xnAhDh7bygQGWBCrCWuvXsU9k6SfroKmg7dl8PrIAUL9Ai3cHqO/FiR+CEKFejGuQNeC8F4V9r9uXIHZ+Omt5KQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffy4BZ3w; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffy4BZ3w"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so126651cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 12:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029120; cv=none;
        d=google.com; s=arc-20240605;
        b=afS1pWViyhYVE3kjCy/7Z+cxOA17mBla9oeOB1Knet87Mz3RwaifH8zOx/QZK9xrev
         SMYqsrLq3pMCWH2xFwxL7acjYuaLRlzDtTZ9Q+09kA9NGSzd/qoNAP43a34a6ru7bIAg
         P3QLTe8Ko4IvGHMFMgFj2lfZIGDlOQ4ehO3eQV88IZhc8GpbKQcKHeO8WHkApgvhgFoJ
         GmgPO4ZljtH/t2HTAUmgpCLAitA6VZ2FWhjM95Yw8SREozQXo4YEjfFWV25yyLQeNHDU
         57z7sg1LJiGrmIw9Pr0ew6OMv52IN4cx0byvEkhV0F4j9MAziuZGpQApA6klih/1tUa7
         Raeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MeTYXI3uAiRssw+rn1c1/h9gP0ELwUJeF0lPi9KAVw=;
        fh=xPs8EqpO2POxQiqHk8R6oQFheS9l4a1KDGV49Z46H2g=;
        b=DX3kqiAYDKOikOxkcyW6Zsti6HhnRe1beaHddP3EvO979+5fRo/EsntlANByv99cxZ
         VT2KZsEMpJUQzYGTUbQr8udraLsNK1aa1Y3hZ6Lxv41YNPdprxCZHgqbG7AxQggqKB2x
         0NuJbZF9H2/vtvYMwz7Wv+Mbt47NVqee+KZWV7fruuf63YFk9G9H55gQIbRUoCpA94d5
         jQb8lsGY2s0NkHSxmWKsW/hUygWcXz63fxudWJDDbyEncyEay0TO+xcehLoO5pjVsIfv
         xI5ZnUgUNpYbxOUv07+hr43w02FD5u+lN+NWXL6IEf46zxj3g/LisQ4fwZLUMCi8PHTF
         gsBw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769029120; x=1769633920; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MeTYXI3uAiRssw+rn1c1/h9gP0ELwUJeF0lPi9KAVw=;
        b=ffy4BZ3wnLkoktzQjRqkOHOB9Cpx4lKAx1dBCQwmZ97y30MqAYLKfPTYpw+YwpHWXL
         zh2rFw4zwvhwiqt2zkDcAAGPm9pAFCl3eDDLDtJZa/am4/xbuHY3/RTk5tAI2KLgEwP2
         zx7OaSwOVvHc/9V0e2eyWMxnkXvaumLfb5kDblDUwfBtsctO4SpojbudEmZojm/n6ysM
         dBO6ujScPRc8C1IO+opbTiAbw/6zVTd7RfOUjsF6LH/SWEg03+omW2ITT/Cp4c1CrWY7
         QgB9kcEz7RHLZaG3D3fk+wilXPQMTBv0jHbSCkHLmH5riB0XB/fvm6buN7hheya7V8uP
         NXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029120; x=1769633920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MeTYXI3uAiRssw+rn1c1/h9gP0ELwUJeF0lPi9KAVw=;
        b=pujvXMWbLGt5NEfMRpR7B2cwPCgIVGj/fuy8zmr5codZQN2w76RRNUSYMDTIoGcucw
         yU+X15UAab3JsQybCTHr9voiGr/OzCiRCJY/tp2QKYhd5bWawhlR4p7zWeyxfXH1m6t/
         LsRkzsW7RLqcVGGvKcg1KlHjz0wvT0AOBT7L77ozSj5M+Q2bonNnUl08lZBfRNMUGPhz
         jeI5GXYRumq2FTjXyvYNKU6amS2ihZlFZZVqVMVoIfUahmk1VbgjCS5AslPyLKEhzn/b
         hOqsUuG9ThvWW7/MfnMbb2qLRNW7KxIsYvjlqTrbmdTPVliUOgoWm7Me0Ww2WpDCNUYB
         lAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68qQl6qmwqVpjvqMdNRVqLeB1tVwPQ6DkWiMPZRFQs57jTci0nmY+KM2yzVQ7NLSSB7kxL2DThrSFOsdakA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVDCg7VlmllyQiAKv8fxCg+6d05WAIIHvl+pYfv9OW3kAzMNRW
	OTlAqlIsuwqev27Cd1x+cdcge99tqUmMcen20aVdugVxQ5K8ZTqufOdqurCTWVX0htLMIPX/IRw
	W7mjBey8XrM4pi4AM5+xuxH9OzCGV3dMmRKPl3Pds
X-Gm-Gg: AZuq6aJQExMM0hFgXePbcHsBG6hwtm0J/etu9zqUHk+j5RDGJtvAbqFBLfvS3nhuzCk
	MHqyVtw+CM4KU848CLRX8JMODkmRN5V+tYqjslVYxdbLcuAgyCY+ywWldpAs4aErt8q4CyXfcYc
	jRjabqmiiAuLMC4DJOh6Jo/Rjm9prgO7o1g+vGJVL//ABUHbRtXIuwl/bU/6hr5g8MT4cGP2TcO
	ZSAuPDTFuRHj8xr5EvzemELqAQu70KD+WJqmg3CYsryMATSyEro9uSaSbmXuZBK1sJR+GYMd3lS
	kLfl1fem3zNjnMMyVyevY6g=
X-Received: by 2002:ac8:7d13:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-502ebd66753mr2584691cf.14.1769029119662; Wed, 21 Jan 2026
 12:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 20:58:27 +0000
X-Gm-Features: AZwV_QgyZJFEnbtAO31t9RJqeLgp-_C0IEAaScaHgOZ1k_x7UdBOLV4hvrPmpf8
Message-ID: <CAJuCfpHZ5xJwg8uvK4XJ1+oBuNYQv3XMO8LHt9eEj_tJE=WkpA@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] slab: update overview comments
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
> The changes related to sheaves made the description of locking and other
> details outdated. Update it to reflect current state.
>
> Also add a new copyright line due to major changes.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 141 +++++++++++++++++++++++++++++---------------------------=
------
>  1 file changed, 67 insertions(+), 74 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 2c522d2bf547..476a279f1a94 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1,13 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * SLUB: A slab allocator that limits cache line use instead of queuing
> - * objects in per cpu and per node lists.
> + * SLUB: A slab allocator with low overhead percpu array caches and most=
ly
> + * lockless freeing of objects to slabs in the slowpath.
>   *
> - * The allocator synchronizes using per slab locks or atomic operations
> - * and only uses a centralized lock to manage a pool of partial slabs.
> + * The allocator synchronizes using spin_trylock for percpu arrays in th=
e
> + * fastpath, and cmpxchg_double (or bit spinlock) for slowpath freeing.
> + * Uses a centralized lock to manage a pool of partial slabs.
>   *
>   * (C) 2007 SGI, Christoph Lameter
>   * (C) 2011 Linux Foundation, Christoph Lameter
> + * (C) 2025 SUSE, Vlastimil Babka
>   */
>
>  #include <linux/mm.h>
> @@ -53,11 +55,13 @@
>
>  /*
>   * Lock order:
> - *   1. slab_mutex (Global Mutex)
> - *   2. node->list_lock (Spinlock)
> - *   3. kmem_cache->cpu_slab->lock (Local lock)
> - *   4. slab_lock(slab) (Only on some arches)
> - *   5. object_map_lock (Only for debugging)
> + *   0.  cpu_hotplug_lock
> + *   1.  slab_mutex (Global Mutex)
> + *   2a. kmem_cache->cpu_sheaves->lock (Local trylock)
> + *   2b. node->barn->lock (Spinlock)
> + *   2c. node->list_lock (Spinlock)
> + *   3.  slab_lock(slab) (Only on some arches)
> + *   4.  object_map_lock (Only for debugging)
>   *
>   *   slab_mutex
>   *
> @@ -78,31 +82,38 @@
>   *     C. slab->objects        -> Number of objects in slab
>   *     D. slab->frozen         -> frozen state
>   *
> - *   Frozen slabs
> + *   SL_partial slabs
> + *
> + *   Slabs on node partial list have at least one free object. A limited=
 number
> + *   of slabs on the list can be fully free (slab->inuse =3D=3D 0), unti=
l we start
> + *   discarding them. These slabs are marked with SL_partial, and the fl=
ag is
> + *   cleared while removing them, usually to grab their freelist afterwa=
rds.
> + *   This clearing also exempts them from list management. Please see
> + *   __slab_free() for more details.
>   *
> - *   If a slab is frozen then it is exempt from list management. It is
> - *   the cpu slab which is actively allocated from by the processor that
> - *   froze it and it is not on any list. The processor that froze the
> - *   slab is the one who can perform list operations on the slab. Other
> - *   processors may put objects onto the freelist but the processor that
> - *   froze the slab is the only one that can retrieve the objects from t=
he
> - *   slab's freelist.
> + *   Full slabs
>   *
> - *   CPU partial slabs
> + *   For caches without debugging enabled, full slabs (slab->inuse =3D=
=3D
> + *   slab->objects and slab->freelist =3D=3D NULL) are not placed on any=
 list.
> + *   The __slab_free() freeing the first object from such a slab will pl=
ace
> + *   it on the partial list. Caches with debugging enabled place such sl=
ab
> + *   on the full list and use different allocation and freeing paths.
> + *
> + *   Frozen slabs
>   *
> - *   The partially empty slabs cached on the CPU partial list are used
> - *   for performance reasons, which speeds up the allocation process.
> - *   These slabs are not frozen, but are also exempt from list managemen=
t,
> - *   by clearing the SL_partial flag when moving out of the node
> - *   partial list. Please see __slab_free() for more details.
> + *   If a slab is frozen then it is exempt from list management. It is u=
sed to
> + *   indicate a slab that has failed consistency checks and thus cannot =
be
> + *   allocated from anymore - it is also marked as full. Any previously
> + *   allocated objects will be simply leaked upon freeing instead of att=
empting
> + *   to modify the potentially corrupted freelist and metadata.
>   *
>   *   To sum up, the current scheme is:
> - *   - node partial slab: SL_partial && !frozen
> - *   - cpu partial slab: !SL_partial && !frozen
> - *   - cpu slab: !SL_partial && frozen
> - *   - full slab: !SL_partial && !frozen
> + *   - node partial slab:            SL_partial && !full && !frozen
> + *   - taken off partial list:      !SL_partial && !full && !frozen
> + *   - full slab, not on any list:  !SL_partial &&  full && !frozen
> + *   - frozen due to inconsistency: !SL_partial &&  full &&  frozen
>   *
> - *   list_lock
> + *   node->list_lock (spinlock)
>   *
>   *   The list_lock protects the partial and full list on each node and
>   *   the partial slab counter. If taken then no new slabs may be added o=
r
> @@ -112,47 +123,46 @@
>   *
>   *   The list_lock is a centralized lock and thus we avoid taking it as
>   *   much as possible. As long as SLUB does not have to handle partial
> - *   slabs, operations can continue without any centralized lock. F.e.
> - *   allocating a long series of objects that fill up slabs does not req=
uire
> - *   the list lock.
> + *   slabs, operations can continue without any centralized lock.
>   *
>   *   For debug caches, all allocations are forced to go through a list_l=
ock
>   *   protected region to serialize against concurrent validation.
>   *
> - *   cpu_slab->lock local lock
> + *   cpu_sheaves->lock (local_trylock)
>   *
> - *   This locks protect slowpath manipulation of all kmem_cache_cpu fiel=
ds
> - *   except the stat counters. This is a percpu structure manipulated on=
ly by
> - *   the local cpu, so the lock protects against being preempted or inte=
rrupted
> - *   by an irq. Fast path operations rely on lockless operations instead=
.
> + *   This lock protects fastpath operations on the percpu sheaves. On !R=
T it
> + *   only disables preemption and does no atomic operations. As long as =
the main
> + *   or spare sheaf can handle the allocation or free, there is no other
> + *   overhead.
>   *
> - *   On PREEMPT_RT, the local lock neither disables interrupts nor preem=
ption
> - *   which means the lockless fastpath cannot be used as it might interf=
ere with
> - *   an in-progress slow path operations. In this case the local lock is=
 always
> - *   taken but it still utilizes the freelist for the common operations.
> + *   node->barn->lock (spinlock)
>   *
> - *   lockless fastpaths
> + *   This lock protects the operations on per-NUMA-node barn. It can qui=
ckly
> + *   serve an empty or full sheaf if available, and avoid more expensive=
 refill
> + *   or flush operation.
>   *
> - *   The fast path allocation (slab_alloc_node()) and freeing (do_slab_f=
ree())
> - *   are fully lockless when satisfied from the percpu slab (and when
> - *   cmpxchg_double is possible to use, otherwise slab_lock is taken).
> - *   They also don't disable preemption or migration or irqs. They rely =
on
> - *   the transaction id (tid) field to detect being preempted or moved t=
o
> - *   another cpu.
> + *   Lockless freeing
> + *
> + *   Objects may have to be freed to their slabs when they are from a re=
mote
> + *   node (where we want to avoid filling local sheaves with remote obje=
cts)
> + *   or when there are too many full sheaves. On architectures supportin=
g
> + *   cmpxchg_double this is done by a lockless update of slab's freelist=
 and
> + *   counters, otherwise slab_lock is taken. This only needs to take the
> + *   list_lock if it's a first free to a full slab, or when there are to=
o many
> + *   fully free slabs and some need to be discarded.
>   *
>   *   irq, preemption, migration considerations
>   *
> - *   Interrupts are disabled as part of list_lock or local_lock operatio=
ns, or
> + *   Interrupts are disabled as part of list_lock or barn lock operation=
s, or
>   *   around the slab_lock operation, in order to make the slab allocator=
 safe
>   *   to use in the context of an irq.
> + *   Preemption is disabled as part of local_trylock operations.
> + *   kmalloc_nolock() and kfree_nolock() are safe in NMI context but see
> + *   their limitations.
>   *
> - *   In addition, preemption (or migration on PREEMPT_RT) is disabled in=
 the
> - *   allocation slowpath, bulk allocation, and put_cpu_partial(), so tha=
t the
> - *   local cpu doesn't change in the process and e.g. the kmem_cache_cpu=
 pointer
> - *   doesn't have to be revalidated in each section protected by the loc=
al lock.
> - *
> - * SLUB assigns one slab for allocation to each processor.
> - * Allocations only occur from these slabs called cpu slabs.
> + * SLUB assigns two object arrays called sheaves for caching allocation =
and

s/allocation/allocations

> + * frees on each cpu, with a NUMA node shared barn for balancing between=
 cpus.
> + * Allocations and frees are primarily served from these sheaves.
>   *
>   * Slabs with free elements are kept on a partial list and during regula=
r
>   * operations no list for full slabs is used. If an object in a full sla=
b is
> @@ -160,25 +170,8 @@
>   * We track full slabs for debugging purposes though because otherwise w=
e
>   * cannot scan all objects.
>   *
> - * Slabs are freed when they become empty. Teardown and setup is
> - * minimal so we rely on the page allocators per cpu caches for
> - * fast frees and allocs.
> - *
> - * slab->frozen                The slab is frozen and exempt from list p=
rocessing.
> - *                     This means that the slab is dedicated to a purpos=
e
> - *                     such as satisfying allocations for a specific
> - *                     processor. Objects may be freed in the slab while
> - *                     it is frozen but slab_free will then skip the usu=
al
> - *                     list operations. It is up to the processor holdin=
g
> - *                     the slab to integrate the slab into the slab list=
s
> - *                     when the slab is no longer needed.
> - *
> - *                     One use of this flag is to mark slabs that are
> - *                     used for allocations. Then such a slab becomes a =
cpu
> - *                     slab. The cpu slab may be equipped with an additi=
onal
> - *                     freelist that allows lockless access to
> - *                     free objects in addition to the regular freelist
> - *                     that requires the slab lock.
> + * Slabs are freed when they become empty. Teardown and setup is minimal=
 so we
> + * rely on the page allocators per cpu caches for fast frees and allocs.
>   *
>   * SLAB_DEBUG_FLAGS    Slab requires special handling due to debug
>   *                     options set. This moves slab handling out of
>
> --
> 2.52.0
>
