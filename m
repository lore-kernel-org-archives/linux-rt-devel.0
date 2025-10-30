Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E7363349
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838089; cv=none; b=fA4UyDMC0yihsWY3cGS8sYXnmEjTDQ2hZ2HgFNyJHh5yq24aVrwEKdBheQbMQqa0YUW55hZj4tmVioofCFa8kxiY69zreEpbRnotUtwcStmW5BFNWtAdNqDAoeJkHpphJr2h9S2O2CfigdVGSxPYhs1zFP+vq65UtSAr3Y8osEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838089; c=relaxed/simple;
	bh=ECIWqf/VCNCzPTY80OhIw37324pVyeiFSTePderg26o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvCUd1ODsos23CeMLp0ZdUIFZTeajpi76yctIl9yXNfUhgRcfsXyyfISokACnudnYD+xfL1BrvW1bUlpfAnvs4Xawo6g8uPrBqOnqGgc1r0PM7hHJKQPOZPeeHLZ/CfEGKsgCa9UV3FBcsAKHYtMi1NbISM4O8OTOZ/DDe3ve6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM27NXRz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM27NXRz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429bb95a238so338402f8f.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761838083; x=1762442883; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17s53pVmMkcMZT8ne5HIpndSpVg+pfPjrs/QsaSS0o4=;
        b=BM27NXRzuKe4A2D7IzuulxUNL/+03vrSaEmGOgM8oCujSvLqskGrgKXWmdjvIFsx8o
         gS3ZSl4JyrbjRBcDItsmTEeYpCRJDEwlEl21udt5DEXlzaHsXghdht2QrpD4As0uY0e9
         JfiJyIrXtz+uayM/zZ9z49L4Bwfu9fFdLAiXoMLNR9/Om6km+jQzYB06gLkYZ6SyYRew
         b37cfOKaZPmGJ6eSBQ14yDGueJKdMvcxybMTwZqBZId2gS3Oo6qd92bPIEyS0ORe/ZsO
         8ftbtE92h28ioKNrizT2nqDFoERpOCZ7rYBGQ1PLzi9P3866xpJFV4LO+64cdPsGBOsw
         PoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838083; x=1762442883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17s53pVmMkcMZT8ne5HIpndSpVg+pfPjrs/QsaSS0o4=;
        b=rJVAhw8St9RT32Tk5UFS9poRoTTko1sQIiKWoY3Zsx6k0MZblzCw23+3WVma3H+i47
         bNDA+cobQAJOhzxCwgJ5dxiFznGe4NRfr4vwpBFKBn5ubfHhy/vjOo991FsOpdkwQAC3
         9Fb3Fz/aBFuc41O2AF95HavlLAKQunmJt8fYvOW8kL10Q9LfcNVc0mJ+wTjIjHx7bRGO
         9mHajJIHzjBeaviN1xGSmsrMgGJQrWmtFFVsxEXkTt33g0pBqdn6AN+mx8GoPCGJUsQL
         ZSVAL4ZsdBTg2a4kZRCw8bXpHO2zX1cot0kKIcO9mVHdxxZprWFL8FOACoFvEutlM+1R
         50Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXMW9QGcrMlCI6COrEEZv86uOCMbE2/PJm+YGZmzyy65fgNSIGJM4ZOYcJwBf9401Xg/luZXdJbBwO6BEdv4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUyGVNRn4KAN4z9/FxUQFaFajTsO/gWKS7DADkI2npiSNb/EzF
	clhptqz2AQQMc/OZB9Shvz5io7k151SAT9zO1rEIMZ3to39nmDyln0oiCctbvAQ1LvahMwvB/qZ
	lqNqRGWmhN8dbkutcP25N5+iazUY3znY=
X-Gm-Gg: ASbGncvQ/qaLkyyVl/UBAmCfPHfCfMAn86laioXi3gFOcLdlqTmdr6Zkt8r+/4rFq4M
	P60IQyl4WliQRCyI2eYwk2mXo/cjODIfg2/wWk90HyQ7OE8rSqUzlswrt+xT+3pQdg9fvPHsJWA
	7gBO/l85tF985xW9ITMRRi9utf7Bvl1wGK+BN3d04RGVpxIDHQsW4nb0x993hobDUocqNm36Xj8
	P1ihzH4FlZlDgepy+QxH3j3KCnpKTDBQRwqEXNBPfVLXTQUQmdYJ7EO151HYdO+3nkI7hRDQLmm
X-Google-Smtp-Source: AGHT+IGXaWxPk/3M+cKYU/Pj7lpnExCAg79uXAbYfhqPsFtqXmL801omvA7wJAIBtF+VQCS8C9jbNQcSyBX5V1IM/6A=
X-Received: by 2002:a05:6000:2006:b0:427:847:9d59 with SMTP id
 ffacd0b85a97d-429b4c9ee68mr3815611f8f.45.1761838083095; Thu, 30 Oct 2025
 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz> <aQLqZjjq1SPD3Fml@hyeyoo>
 <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
In-Reply-To: <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 08:27:51 -0700
X-Gm-Features: AWmQ_bnX5zwf36gXg3U_L6nD0Y-OhNsAUiH1Wv4xcOqbTsg1lnruV_RapPX3X1o
Message-ID: <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
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

On Thu, Oct 30, 2025 at 6:09=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/30/25 05:32, Harry Yoo wrote:
> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index e2b052657d11..bd67336e7c1f 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cache *=
s, gfp_t gfpflags, int node,
> >>
> >>      stat(s, ALLOC_SLAB);
> >>
> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> >> -            freelist =3D alloc_single_from_new_slab(s, slab, orig_siz=
e, gfpflags);
> >> -
> >> -            if (unlikely(!freelist))
> >> -                    goto new_objects;
> >> -
> >> -            if (s->flags & SLAB_STORE_USER)
> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
> >> -
> >> -            return freelist;
> >> -    }
> >> -
> >> -    /*
> >> -     * No other reference to the slab yet so we can
> >> -     * muck around with it freely without cmpxchg
> >> -     */
> >> -    freelist =3D slab->freelist;
> >> -    slab->freelist =3D NULL;
> >> -    slab->inuse =3D slab->objects;
> >> -    slab->frozen =3D 1;
> >> -
> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
> >> +    freelist =3D alloc_single_from_new_slab(s, slab, orig_size, gfpfl=
ags);
> >>
> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
> >> -            /*
> >> -             * For !pfmemalloc_match() case we don't load freelist so=
 that
> >> -             * we don't make further mismatched allocations easier.
> >> -             */
> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist));
> >> -            return freelist;
> >> -    }
> >> +    if (unlikely(!freelist))
> >> +            goto new_objects;
> >
> > We may end up in an endless loop in !allow_spin case?
> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
> > held in the process context on the same CPU)
> >
> > Allocate a new slab, but somebody is holding n->list_lock, so trylock f=
ails,
> > free the slab, goto new_objects, and repeat.
>
> Ugh, yeah. However, AFAICS this possibility already exists prior to this
> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we should =
fix
> it in 6.18 then.
> How? Grab the single object and defer deactivation of the slab minus one
> object? Would work except for kmem_cache_debug(s) we open again a race fo=
r
> inconsistency check failure, and we have to undo the simple slab freeing =
fix
>  and handle the accounting issue differently again.
> Fail the allocation for the debug case to avoid the consistency check
> issues? Would it be acceptable for kmalloc_nolock() users?

You mean something like:
diff --git a/mm/slub.c b/mm/slub.c
index a8fcc7e6f25a..e9a8b75f31d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
*s, gfp_t gfpflags, int node,
        if (kmem_cache_debug(s)) {
                freelist =3D alloc_single_from_new_slab(s, slab,
orig_size, gfpflags);

-               if (unlikely(!freelist))
+               if (unlikely(!freelist)) {
+                       if (!allow_spin)
+                               return NULL;
                        goto new_objects;
+               }

or I misunderstood the issue?
