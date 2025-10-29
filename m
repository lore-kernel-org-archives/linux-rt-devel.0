Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09561314A8F
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751841; cv=none; b=goLVhOkuX3KfvrAei/8OvS/z/dFoTKDImLdmNVHMEwvnHO/pJPZbHw+Q4mDjwetpC40+rJ6b956rJIyetrVubEU1rSa6FY1KPTrGucdPdpZrMfy/X414ZXBhyOvV07A7UfYmvV+ZQMOQXHFW8Uzs4g+h7yyn32ddjmSES9/pEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751841; c=relaxed/simple;
	bh=guB4QovAHT8kMie0PLZYLo2KFTfB2kqXlrVCoekHzzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjvQWQ4/oJOTbEf4zk53EmEBjDKSE1t6xfIcIxdGLugkphqjUizcICdnPUntFGj1S1lsOip4t4HsG/zyCC8Hl7DO6/d7Dvt8ef7i11OYaxSybU2KiReYU+QmMC/fM3/oKvtHf8sP79xwKm0xIjWFRQ4T7b2iMnZbTiYDj4mH1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiqL4CUM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiqL4CUM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e074dso77702475ad.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751839; x=1762356639; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/Chhgm7KMivLaP7UfXKsNLQx2xR5ZnzWFQSYqKYSi8=;
        b=fiqL4CUMgmeKITeEkzKeU43tnObHYqnarCyxqt02D2SCaOMmpzzdf0BgsTIKcP7PP+
         TwjnanV9A4YweVoODvJmWK+RuzYsz7Ss/CK9/25qXMEjpQTfPJV41sWPjco0wwpusx5c
         xD8wQYSiOAPN7VRi1eHGH4UWgPUZhGfBz95Iml4wHsxYn5EHFF9oBh6TNVdBkW4e8Pwv
         pR00Cy2DZA1KL8xpEoTVEgKR01LSvvGwhA6lKRJhuA+Eo0xqxvTPFVPFLxBcBeigLeSu
         IcCD5Piwvj1h63q0+ikLR8muD7ZYlxvGmOTBcI8QT4XR+Bs9eYydD5mb45u6C4p0ycN3
         z7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751839; x=1762356639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/Chhgm7KMivLaP7UfXKsNLQx2xR5ZnzWFQSYqKYSi8=;
        b=KxxErNh0NptMSDYwU7PKJwOwOj+3KX/nKuJ58zF0v4Zx2AAgYUicIrC0h5g02RS5d0
         pll5iNyFtyizBW0JRdQcU9rd3ohbpIlwEFw3s3G/7lPak6C7tueArpTc/yRfLALC1gZo
         XcUpl7/y7mbt7366dvdjcuSAdYs+q8PNy3mXRkjZv7tOjN22OLkSeJiApTgAtJ4TwM/9
         MtJRsnlPPSfQ81TiqqQeg9Oat4X/WfYhz1RLiwv7PmO60gECdbgVOdoopzsp+uxlK6MH
         +JyCD3xCCT3xrIxuTjRiER2aTtU7dWX7saoc/NKEToZUS8HIA0WhY8dP+RvJkZzkpLAQ
         3Tmw==
X-Forwarded-Encrypted: i=1; AJvYcCXbz82S7K+l7fhAW07UMQ4Dd2wNf6KtZaEKFNKUUTCzqzOBCXDiEQ2LuwOGk6hpuQwPX/DSswlzupdXEr3Unw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMws1y/JpVvdUysgsaI/3MxySywxGmcOyA4ee/Wd5m+53ThJCp
	/kaPIDvT8Dlp8zFKW7REI+wHoBJ6nIBRxKeqSWSTC17Rk0Qv2tsPDqW3slgJhKsmt1FWQ0ZxKnK
	KnZ1vOUBVcEjTaE4cfgF7JaClEFQVnyGDpSNqxjw+
X-Gm-Gg: ASbGncvKuJSK84jAaNOYBg2bHddqJf3oF0hB0vWClEa/G4NoH1vBd4mAT0hOBoCJvNJ
	SQz66ki4wYN2AP49v0JJdm0TRperfF+TdOGlKMqhuVCnP71VBUPZMKSw3Ifgype4FsMymaVEAjR
	fZ9rQVSPesSHYW8HQuLcIOnb68LVIkvryrlbnQs4N7QzLSmIWli6mwcuMMclmy5ZKM0YFIZGIMS
	mZIJJVIvTOBf1F++s4uxl8AQVFJP551zDva2LbrOtdX40vnlhSwfWIXZqXZvBi76kHDoDpnY++Q
	bfRKrwRCR+ymHHrFxmy5IId02A==
X-Google-Smtp-Source: AGHT+IH8xvowD+kYXQ7z5quxP2h2xDBqXwlebiin7tKEs9t726w7tT592s456fkeCdpk2YUZnOu4Up+XSy1ZFsm9bRU=
X-Received: by 2002:a17:902:d4ce:b0:28c:2db3:b9ab with SMTP id
 d9443c01a7336-294dee25ef7mr46936785ad.26.1761751838802; Wed, 29 Oct 2025
 08:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz> <CANpmjNM06dVYKrraAb-XfF02u8+Jnh-rA5rhCEws4XLqVxdfWg@mail.gmail.com>
 <0f630d2a-3057-49f7-a505-f16866e1ed08@suse.cz>
In-Reply-To: <0f630d2a-3057-49f7-a505-f16866e1ed08@suse.cz>
From: Marco Elver <elver@google.com>
Date: Wed, 29 Oct 2025 16:30:01 +0100
X-Gm-Features: AWmQ_bkcozjdjluUvttU4Roh8Mm8XDdSh0qCy1zW1YFReOaqG1YdYoXpHqK6R8Y
Message-ID: <CANpmjNOtocYUyX4HEB9GELeDVb1LbgESea98+UH5LCuYVoZbCw@mail.gmail.com>
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

On Wed, 29 Oct 2025 at 15:38, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/23/25 17:20, Marco Elver wrote:
> > On Thu, 23 Oct 2025 at 15:53, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> >> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> >> but it's conceptually the wrong layer, as KFENCE allocations should only
> >> happen when objects are actually handed out from slab to its users.
> >>
> >> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> >> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> >> was refilled with KFENCE objects. Continuing like this would also
> >> complicate the upcoming sheaf refill changes.
> >>
> >> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> >> to the places that return slab objects to users. slab_alloc_node() is
> >> already covered (see above). Add kfence_alloc() to
> >> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> >> prefilled sheafs, with a comment that the caller should not expect the
> >> sheaf size to decrease after every allocation because of this
> >> possibility.
> >>
> >> For kmem_cache_alloc_bulk() implement a different strategy to handle
> >> KFENCE upfront and rely on internal batched operations afterwards.
> >> Assume there will be at most once KFENCE allocation per bulk allocation
> >> and then assign its index in the array of objects randomly.
> >>
> >> Cc: Alexander Potapenko <glider@google.com>
> >> Cc: Marco Elver <elver@google.com>
> >> Cc: Dmitry Vyukov <dvyukov@google.com>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >> @@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>         if (unlikely(!s))
> >>                 return 0;
> >>
> >> +       /*
> >> +        * to make things simpler, only assume at most once kfence allocated
> >> +        * object per bulk allocation and choose its index randomly
> >> +        */
>
> Here's a comment...
>
> >> +       kfence_obj = kfence_alloc(s, s->object_size, flags);
> >> +
> >> +       if (unlikely(kfence_obj)) {
> >> +               if (unlikely(size == 1)) {
> >> +                       p[0] = kfence_obj;
> >> +                       goto out;
> >> +               }
> >> +               size--;
> >> +       }
> >> +
> >>         if (s->cpu_sheaves)
> >>                 i = alloc_from_pcs_bulk(s, size, p);
> >>
> >> @@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>                 if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
> >>                         if (i > 0)
> >>                                 __kmem_cache_free_bulk(s, i, p);
> >> +                       if (kfence_obj)
> >> +                               __kfence_free(kfence_obj);
> >>                         return 0;
> >>                 }
> >>         }
> >>
> >> +       if (unlikely(kfence_obj)) {
> >
> > Might be nice to briefly write a comment here in code as well instead
> > of having to dig through the commit logs.
>
> ... is the one above enough? The commit log doesn't have much more on this
> aspect. Or what would you add?

Good enough - thanks.

> > The tests still pass? (CONFIG_KFENCE_KUNIT_TEST=y)
>
> They do.

Great.

Thanks,
-- Marco
