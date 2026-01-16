Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF693090C9
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582701; cv=pass; b=iE7QdAjx26YZKRs6KfCB0K+/Un7vuNBxf8bLqIvWIWs+K3Qw+8GNhePtXfY2tIL/NHilvDc/yj998IJTOY/NG6tWPcKJUWR9BlxovN0Kp5SK/O9XFzDcV8uFd/tBsg08NyDMHF0RT5sO4dcZFBd2qvpEmYyYW6xckvXw0HnaSjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582701; c=relaxed/simple;
	bh=u2xorRoykCJYfBHwt/70olFyGaH+Wieq9MkT2DW/j1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqPcDZ/u6QeEjAOdY/djOU/CaWZaA2k1q1Dv5TcrDSmAooGCXFJ4im4zeRe5yrWO2AFpJvtJwyVHZl0ohG7bnEHGBHu43Ka3wDyHoaKpiO0Saz8WSPFar4X8F1O+BgyZv3JDTeChWQIcEOOdH1uWVizfBIGJlApOm8SV56nNbzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD1E4/N3; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD1E4/N3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014acad6f2so537181cf.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 08:58:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768582699; cv=none;
        d=google.com; s=arc-20240605;
        b=VQqDW4EyXROymncUucJ1Ii9Ko+DtY1uIIWovEvQMVmWKJJaxxvy6Hi9lcbWmPzkedy
         +RmRk+4QBhW5wdYIGl9JVkyQGn/ZLOtHZ6I+nxpfwDrcCbJH9dbMy5lGbOs0opVpdZVx
         lgoMF/ItLyfprP/72p/rV1cr5NUDv85445bUVw4fJ+S5eaKrQj4y7W41tflBnS9nFNwc
         M8nnR+BSFW/SczBMS+jVbI9H9zQsK1WDRe7rlsNHp5aGhi1og/qDI8JLFMdl6lWF7ptG
         O8kDVQWqi13dzYxptSC/4UOWefUNhAXzHizTJibkEXfdk9Nl+ODWimV3jJAFDPKv/RCR
         ZQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UaTAsxPYTCPWjwQ4mQCkSgV5i6jSjH4fHwMIaU55o8I=;
        fh=U1ZX6UDCR6imw8fuPOuNu689px9+rF/ODUgHULWog+0=;
        b=KrV0oonwJ2HgJ+JXrUDAQUa0FhwoxhPeXgdkRHHb5GM5P50brKbKHr7G/N/43tGhGC
         e+w0EcvVmdZ+jPv/kW7pBKK4XdzJXiQ9w2yKG/XCGu0FVoyw7muoPAJzXgdQNymBzZld
         LIgkDEKDL0xIZX/YeZ38cWqUlvklvnkG/1KgDbk+FKNYzA7P2TWJ+Vsw4ylwqwyIEHXT
         1uRq9bX18x5h8SegGzGxIKV1aKQfjohcECpPn8vrdkFFA6ct/KQjyz89NPtvKdhkV/eu
         1SdQeRqZonVxz4VxEAXGSCasYNO84AqOe+BbKyheRbqWyRylMf55TNrGIGQV3ybflEy2
         Ug+A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768582699; x=1769187499; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaTAsxPYTCPWjwQ4mQCkSgV5i6jSjH4fHwMIaU55o8I=;
        b=fD1E4/N3bX+eeAT86aSJPio0cpDCX//Rx1Hw04/9tJa53PbUeGlypjXA8VGkas1auV
         dPuvh5UTHbprgZWTGOnIhhnecSncdRej3T4vEPZBftygN2qZ+94czMUXhCYvMtfex32O
         rN5ThGMH0oo7b5lA8cNMc/9yTNog5umJDY30/0tCZAKkIN5VLowXbDsWwNzgjP37QR6P
         oxIXGOb25u3J13QLKdUa5IOrvcezpHWm6SPqKgVyHkWYNdIspEQqT4uBbfuvBeyOTu7D
         CkApLLyeisBFRRjITzsPt1U8fqcFr9qwr4wJpEwNRo4VEVh7DOlYzyw7kgD+SIazXjfV
         XGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582699; x=1769187499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaTAsxPYTCPWjwQ4mQCkSgV5i6jSjH4fHwMIaU55o8I=;
        b=YpW5XvS8sWEuhTeZ8JwQXjVKeXTeEjEv74drtsBLJsCJIRlaOra1ObPJ+wQWAf15gI
         3PuSMjdlNunIiBbCtc+AEkzXTwze10hK4mKCZH62qTlC4gmnd3qHuhQ/h5TWWq5LtPn8
         3miWEL+shq4qAa2zrc9Xo4Jf4xO7PhR5156s/bFjH4ODhEjFD6joMhQQaQUV0Y/C0S0D
         3hmyJsNeclYaPCKL9KEf0CM0M6//VClQeb3WnLsiny4v2o0WDnBJHFsjWNYZbTeqU/9p
         4SApaROKqSLwsz+V2ZObXtJ/Q+hpmGcHecXNi30QDmPk2W5gO4rdJfTyik3gbmzS21vL
         E4sA==
X-Forwarded-Encrypted: i=1; AJvYcCXEMrFWgUtlVfy8AkEB2PZMpXZj3c9Lvk1uyquNjVE6TYvXXTErHBrAhe1iJjcHtj5HSiWB+5U0R1aaQg3hOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd4Ej71AHy7XB6HsOWLZDZiPnbBw4+SUA78xReNnNaYtHfjQi9
	aI3W+fC/n0UhcwgTHWwLdTZi4DCUH+qHKjQYqbGTIzrgpEbbTyESI3/gZb2jXKNsKFT4s2vujmP
	gGrDxIA09BxgK0duyCzAwyYouS8J8KY8drXFpBjE6
X-Gm-Gg: AY/fxX4EvOkGTrIXu4KVCA+4DgmnJavWSwrhX4SuBHW7HuouuumtYxcf3V2sOGThg5C
	4EyzpbQGHuehFbsLRPgyU1xEHovieAK1nS2E7F6OFnx7ErnHvT4LmMdS10SZgfhbjRE30XL606k
	3vLd9hWs3GO4k0hd3yIafQEGwcW4e2tse5u00AzD2FoGYku1GdQXh5mSYmlteClRB9pfOyQmdZ/
	5WqJm4ewBIkYEisIyZ/pt70N9tKp8pUnn7w/6MNupzdCHxgHFhUHOLTzLlROFhvMKf3EQ==
X-Received: by 2002:a05:622a:4c6:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-502a36feeefmr9677951cf.9.1768582698713; Fri, 16 Jan 2026
 08:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz> <CAJuCfpHowLbqn7ex1COBTZBchhWFy=C3sgD0Uo=J-nKX+NYBvA@mail.gmail.com>
 <4e73da60-b58d-40bd-86ed-a0243967017b@suse.cz>
In-Reply-To: <4e73da60-b58d-40bd-86ed-a0243967017b@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 08:58:07 -0800
X-Gm-Features: AZwV_QiGfwWS_a1m6Zzi_yFSpjGioLT9sSjsdK1eWkPIvYtSYBlLySU-l0-N1MQ
Message-ID: <CAJuCfpGikJpueGo1hW8ONimHOALnpftT22F7xYuL5CpnphJu+A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/20] mm/slab: make caches with sheaves mergeable
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

On Thu, Jan 15, 2026 at 11:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 1/16/26 01:22, Suren Baghdasaryan wrote:
> > On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> Before enabling sheaves for all caches (with automatically determined
> >> capacity), their enablement should no longer prevent merging of caches=
.
> >> Limit this merge prevention only to caches that were created with a
> >> specific sheaf capacity, by adding the SLAB_NO_MERGE flag to them.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/slab_common.c | 13 +++++++------
> >>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index 52591d9c04f3..54c17dc6d5ec 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -163,9 +163,6 @@ int slab_unmergeable(struct kmem_cache *s)
> >>                 return 1;
> >>  #endif
> >>
> >> -       if (s->cpu_sheaves)
> >> -               return 1;
> >> -
> >>         /*
> >>          * We may have set a slab to be unmergeable during bootstrap.
> >>          */
> >> @@ -190,9 +187,6 @@ static struct kmem_cache *find_mergeable(unsigned =
int size, slab_flags_t flags,
> >>         if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
> >>                 return NULL;
> >>
> >> -       if (args->sheaf_capacity)
> >> -               return NULL;
> >> -
> >>         flags =3D kmem_cache_flags(flags, name);
> >>
> >>         if (flags & SLAB_NEVER_MERGE)
> >> @@ -337,6 +331,13 @@ struct kmem_cache *__kmem_cache_create_args(const=
 char *name,
> >>         flags &=3D ~SLAB_DEBUG_FLAGS;
> >>  #endif
> >>
> >> +       /*
> >> +        * Caches with specific capacity are special enough. It's simp=
ler to
> >> +        * make them unmergeable.
> >> +        */
> >> +       if (args->sheaf_capacity)
> >> +               flags |=3D SLAB_NO_MERGE;
> >
> > So, this is very subtle and maybe not that important but the comment
> > for kmem_cache_args.sheaf_capacity claims "When slub_debug is enabled
> > for the cache, the sheaf_capacity argument is ignored.". With this
> > change this argument is not completely ignored anymore... It sets
> > SLAB_NO_MERGE even if slub_debug is enabled, doesn't it?
>
> True, but the various debug flags set by slub_debug also prevent merging =
so
> it doesn't change the outcome.

Yeah, I thought that would not matter much but wanted to make sure.

After finishing the review I'll have to remember to verify if that
comment on slub_debug/sheaf interplay stays true even after
args->sheaf_capacity becomes the min sheaf capacity.

>
> >> +
> >>         mutex_lock(&slab_mutex);
> >>
> >>         err =3D kmem_cache_sanity_check(name, object_size);
> >>
> >> --
> >> 2.52.0
> >>
>
