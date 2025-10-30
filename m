Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F82FB998
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839969; cv=none; b=hWrRZqrhCuDwvx+r+zzK6GkRTNvDACDcbZd9OiQu+9VicGqUrc5OK9b7kL4upQFR8ZF39fl0sg1KqwXSf4MsG+U09ThfeuJxG4/MK0RxGPo3rUsyR9I/AmdmITkeu9SXqNV8C3sUAiToyDg8W3UG3ETs6m11Gi1Dou7LiTSSKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839969; c=relaxed/simple;
	bh=GVsbUlHFWCq7tqkotWM97De3YjcY6mfm4lT5ylPlQUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VABpZ3Nl9j9H3Euq3MAXcjeipMsg4JPRL3nAlPP22+keJcsw10bQ5HmL6ExCyAZuwGdF6X0MmzEqThlkoSuuwB1B20vQOp6iEKanoV1wSOASSsf8oWR81p2GwWTqtVJJedbxJUWRKZvwvF70/BzMZyz22OinD+3RFmoB6061nCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqUB2qiv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqUB2qiv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d402422c2so246028166b.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839966; x=1762444766; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtYLD87/tbnWpFhxZoXLkwutGQwHC9HiwVV2d797j9U=;
        b=aqUB2qivZpZYoI2WdOqUbZBnt9r+HRLPhbF1kDiKFo/CebglHPgsWPu6FwbkKxCwbL
         phJavwrPbFnrPJS7r9DytEUHTU9cklsKDJFZh3c6boYi5r8FURHQCFEFjlSfPw/OrXHR
         wHjxt6J8LNbPyVvJRS0jTABXDtam7PW7QJY84ET1x9JVe0ulkGfiSWVMLrjtCjK3dcWS
         W4QEiDN8YoLelTMVLJVkX5M2cceIaVAxI5UpTOrlAV07iKJaTDbvLGl4iGA9W+9p4bGR
         K5c5aXv+E58uGqjea76WRtPTw0EUemFypa2tyGRYUleivq6zm5avK1DPccMZ7Uyh9eHQ
         zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839966; x=1762444766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtYLD87/tbnWpFhxZoXLkwutGQwHC9HiwVV2d797j9U=;
        b=r9S7nXsCZLbeUFwSLYS7eTjA1oqihc0qwEH5AANvX0kzKYo4v0HQyopCxANNCCP6aX
         qgm97yHN89aMa2UA/sNlS4Pay6tChoki88dOimCVVG5yvXyyEDxBfz0JAGI3r/UfdjFB
         1J8SpcCJbfWS/3Hm1LibcrvxHFyjiY12kfkKXZKqi1Hudavwikfz7jL2DSZ3GdAKbmui
         1qjMJPNLzEuc3wgE36hcrDYmcZIl3ur9D3ljsS5B7OU9RBnFJmaxaO6KTI+NfU7romQc
         EFkevi/b+g02xdhbDx95Np8mGNqbZg2EeSH1c+8DklcNAgrxGP7YHsXGHk+qMxPeZs4X
         vIwA==
X-Forwarded-Encrypted: i=1; AJvYcCXDFgpCgMoRW5lqyIkUbl7LeCqwtURrK5dRz9PA3RvPD5bcwkCn2sfcNJLbupkwXU0phjLFX62KCDtmTr+F2A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+3BlRvhGf3leqoHv2YCmQgxkx5hayVlRYMALBFdQ9MviAQqed
	NHV7C9mGzg7c3HEAW+lHAVt2x8QFfAfcaMDptNtA/Q8eISXazfLWMuR3C3TVykHBBiSMuN3haeU
	j7XJnzLTQLePJUdn5IMncN0NN6sLGfc0=
X-Gm-Gg: ASbGnct7vbZ8E3Vpvxydkvy1uuJtAdhSSdQgN3tSnD3WBHlq4GwCUW7mIGugT20MZwd
	fA4FVpFgXN/BBQ185QE65iSiWu7Nj3MNNrGuLLUnGEyrrU/YHikiQuNKNa7rLPZ0jhBluzGLmqX
	7uVUacBKe9b23hVWJauMsHeCyn0XH328beI/A6cgcNp/XUFigmPeHSku5aTY93oMLIMunhvc7VH
	xU5w0z7+12qh0KY9x02ktMDio4ehdn4yfRpvN0QDj85eoFf8wYmxX+cN6p3+RO1N9LyOWOP6c+L
	/brBKIRKZvk=
X-Google-Smtp-Source: AGHT+IGNEehD/IbzmT/eYnqMidws6XqejIuodVpG5l4cgolJSh8b964GFDYeXBLMdMY3NgBpsNfX2tZZfLZTiPrySFg=
X-Received: by 2002:a17:907:7f22:b0:b0c:b51b:81f6 with SMTP id
 a640c23a62f3a-b7053e45459mr371911866b.43.1761839965702; Thu, 30 Oct 2025
 08:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz> <aQLqZjjq1SPD3Fml@hyeyoo>
 <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz> <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
 <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
In-Reply-To: <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 08:59:14 -0700
X-Gm-Features: AWmQ_bkWAOmvQoKcQyr_zcqHDGMRrBlm9dDGveiPgB0Mj-QwDfGlE8jGMTlojF0
Message-ID: <CAADnVQJ_yzOGAT__EG=eBTHbWeiFgEZ--fHFQNprsX9o0vEQkA@mail.gmail.com>
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 16:27, Alexei Starovoitov wrote:
> > On Thu, Oct 30, 2025 at 6:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 10/30/25 05:32, Harry Yoo wrote:
> >> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
> >> >> diff --git a/mm/slub.c b/mm/slub.c
> >> >> index e2b052657d11..bd67336e7c1f 100644
> >> >> --- a/mm/slub.c
> >> >> +++ b/mm/slub.c
> >> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cach=
e *s, gfp_t gfpflags, int node,
> >> >>
> >> >>      stat(s, ALLOC_SLAB);
> >> >>
> >> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> >> -            freelist =3D alloc_single_from_new_slab(s, slab, orig_=
size, gfpflags);
> >> >> -
> >> >> -            if (unlikely(!freelist))
> >> >> -                    goto new_objects;
> >> >> -
> >> >> -            if (s->flags & SLAB_STORE_USER)
> >> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
> >> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
> >> >> -
> >> >> -            return freelist;
> >> >> -    }
> >> >> -
> >> >> -    /*
> >> >> -     * No other reference to the slab yet so we can
> >> >> -     * muck around with it freely without cmpxchg
> >> >> -     */
> >> >> -    freelist =3D slab->freelist;
> >> >> -    slab->freelist =3D NULL;
> >> >> -    slab->inuse =3D slab->objects;
> >> >> -    slab->frozen =3D 1;
> >> >> -
> >> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
> >> >> +    freelist =3D alloc_single_from_new_slab(s, slab, orig_size, gf=
pflags);
> >> >>
> >> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))=
 {
> >> >> -            /*
> >> >> -             * For !pfmemalloc_match() case we don't load freelist=
 so that
> >> >> -             * we don't make further mismatched allocations easier=
.
> >> >> -             */
> >> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist))=
;
> >> >> -            return freelist;
> >> >> -    }
> >> >> +    if (unlikely(!freelist))
> >> >> +            goto new_objects;
> >> >
> >> > We may end up in an endless loop in !allow_spin case?
> >> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
> >> > held in the process context on the same CPU)
> >> >
> >> > Allocate a new slab, but somebody is holding n->list_lock, so tryloc=
k fails,
> >> > free the slab, goto new_objects, and repeat.
> >>
> >> Ugh, yeah. However, AFAICS this possibility already exists prior to th=
is
> >> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we shou=
ld fix
> >> it in 6.18 then.
> >> How? Grab the single object and defer deactivation of the slab minus o=
ne
> >> object? Would work except for kmem_cache_debug(s) we open again a race=
 for
> >> inconsistency check failure, and we have to undo the simple slab freei=
ng fix
> >>  and handle the accounting issue differently again.
> >> Fail the allocation for the debug case to avoid the consistency check
> >> issues? Would it be acceptable for kmalloc_nolock() users?
> >
> > You mean something like:
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a8fcc7e6f25a..e9a8b75f31d7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
> > *s, gfp_t gfpflags, int node,
> >         if (kmem_cache_debug(s)) {
> >                 freelist =3D alloc_single_from_new_slab(s, slab,
> > orig_size, gfpflags);
> >
> > -               if (unlikely(!freelist))
> > +               if (unlikely(!freelist)) {
> > +                       if (!allow_spin)
> > +                               return NULL;
> >                         goto new_objects;
> > +               }
> >
> > or I misunderstood the issue?
>
> Yeah that would be the easiest solution, if you can accept the occasional
> allocation failures.

yeah. not worried about the slub debug case.
Let's reassess when sheav conversion is over.
