Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CF242910
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318282; cv=pass; b=gg7E2WUGysaXwytSWBFQ3egVSQq9WcyeHB2vBaiU4wXsiEYUkAZoverYzWGRLhoivHt5yIrnUs8xKg+ITm95TOqunjYY96SPBSDPrgfwPO12ImtCIZuWAZoVQmt1TxqCoCWltcBApY8G3fSk9FleYYDoUsuWrkufj4U9CFFfHvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318282; c=relaxed/simple;
	bh=NQ3690bs9eqYTNlWQwsPYRW5w5ui/sXhsQZJ1rGOByc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZccGqA8zusW5yD9JbEJYeMlVG9YLWD2hVWjEw625hNkdrH6af/hBmSvjC4mcVtcx9HRQ89NVTdOYXUvp4VKakRXw6BK/Rz7u0kH756XnTI0rRsSHJ96bDVPIBctdLvLx53UYtgmi2rSKogKOUKYsIzqnNEllFvIhdA2wt7po0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNd8rG7P; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNd8rG7P"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51765331535so300501cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782318280; cv=none;
        d=google.com; s=arc-20260327;
        b=lyUUdaIYNAqIRz4A/o+2uELRs8pKP2w7FEqNqqAwog/HVFgfMl4p0dhxPUzzUZA4Uq
         pbhKH+F8wpb6icdfKpE9mSuJB66SCz1YKXacetvf0pwf9dtLSkD2vcSgc2Ug0bCDJU52
         0lBksPnHVeMHlGuY0ZCNepakzwcEOuTi2lV8VqwaV8Kg4PbhAf/GMq6HVBdEC4ZEhH9e
         ekmvlIKHKgYUWtnZSictQD6yR/dLrCcXeTf+sYR//ER/ORFFKeU20/cvbZ5SbeL9dLZE
         Oa1rfnVV73l9os6API7nHFhrdMhOpQ9gUeGX9NfZD5sPqhBP1acnVzytg0OV8us/YTT0
         Koxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HzwnEhqWJZImCC+tqBDdx1M1NrB2lLpdw9IVLibHq6E=;
        fh=xVfBLHbkt/Bx263VHMqOTARRggzWchXAe0oDc+pQyVA=;
        b=G0XxNSVOGMfuWVZX78wGVCDzO06OURZg1+gAEJ/7R2R62My+jdhic2W7/G2x4KooFA
         INJr67qoc9khASAO0bgM+XlX+bzdn+FWI2Q5WtVa3s1agphnRoDqR5FehDPLzvcP4E4N
         k3+q17iZHaj+notUnrv2TpDFrT4hFwEhSiTr/u2NCp05vuiwYOFATNqbe9nO6Z9CmKAT
         kb12b4XXh4jiV8Km8YR0a6MIFGkKhNy3vTfHAJgTv1ze9Gr2W9xtx/uYP783i7vKSZ3Y
         +6pI+bZW7CmLKrboIF8MIaag8yxkp+2AR5LLF5Aaru9hLFXIri7kRjGB8s6pK2gsVZeM
         2eBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782318280; x=1782923080; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzwnEhqWJZImCC+tqBDdx1M1NrB2lLpdw9IVLibHq6E=;
        b=sNd8rG7PIVm7lyxyZFzqYCHFat1+SD/2fDhihQMHDn2i3ZAvNkOT8pFBCP2YYj7jyn
         xmVuafKI4AgFIZ5LVGhIp/WqFGIENCNgvCDxyVMeDT878NJrMOoPymsVi+5a0xxyQZfP
         eUeNPnBjSOhziOyGN/IzWID7vjSWq980GMk3KUWGPFWHzEAL5F23BRXNtFGXnuKUnX9N
         xfcMcactLp/S48+jcLSBTUmz4LmcTOaUE4Ms5Bhr4dCD1t1k/CL4f0AH4wd9pp+3R+Pp
         wCb0Y9ivD9R/NZm2tkeCJLRTsylr5Zy8EOBuWTsJZDxdV4iTVb6gy6QQAX4U1//LA11T
         B/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318280; x=1782923080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzwnEhqWJZImCC+tqBDdx1M1NrB2lLpdw9IVLibHq6E=;
        b=C3SPIlG5GAuT0UZIREw0Kz2M0AvfrRU8hoq5rfxO8U37luJefetg3ZoAKGaHtIDc/r
         liAF9nyX/ymyDWdjPvSlc1sEcFMMCrjDKTDklGxC/zTURAltI9B3kdAnh3avDmTrVg4h
         ba8G2apX0pe7TfnvyX3gSZtsY09RqvbPZPPPjrFQ7sxfDQ2v4iNYQmDzocaK7bRy2hvi
         m4T9XB2F/JvP1nJKkDS/CX2IJQFeGM0hDeXuftrYhXOIb7ioVJgqzkFCIfkR7WcTZVz+
         CLs1pIBRm4e5Ci8vru7KWv/8TFcVpbUDFIYZBzI+P0RTqB0qlNZj3XFkBNNXy2WyKVO5
         lQeA==
X-Forwarded-Encrypted: i=1; AFNElJ9v5RlOYmfroUlnkiaAdeCvzD1e2IW0r8O/ecHaAYmh00dDNgBbqq592gzeUr91zFMr3L1vqeDJcI4txDbojQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY4zFvpuxIJxyh2N+/P2pFhK2za8PB9OFC2Vzj2QTvRC1bC16w
	/OLoIFEhk+Keh9curMbivrr7eHogb1A4edy8xDO5M3NI5K101DVfZbeznX3yXF1nskhUle1QHcJ
	cYcTMiILoNkJNr5IVrICaugdR6+QKEC4BXE0An2gd
X-Gm-Gg: AfdE7cmpxHa0yqj5q5yAkn4vTDK5f6yEdDlI4pQEsWSILfx671GjF4cGWQX3CmkNzq+
	Em18rzWDSd8rxcLz9+GVTAa1jFpmnVsbYZevHeY9fXK9xo2cKHhKFe5/k5y6V9s1ovAdRHyQCDG
	U+Dor4hYK8phrpoPjT/Cfy62+/88eaSfDeVjHIQmeRVCj8CElE4QGp41h48LveV6XBZGhFQi9M+
	/qwQ+REx03yYUCWFU8mYe1VyGGq6hXkOTSahv3awUj/6LZQwQdxkytN4xkazhJx1+9lVAZptfcT
	YwNTD7yOO5T6rgZDpCb257Wilbw=
X-Received: by 2002:a05:622a:1b16:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-51a627e946emr9157051cf.1.1782318279473; Wed, 24 Jun 2026
 09:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <20260622-alloc-trylock-v2-10-31f31367d420@google.com>
In-Reply-To: <20260622-alloc-trylock-v2-10-31f31367d420@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:24:28 -0700
X-Gm-Features: AVVi8CdYUDI7odKsPpvoYQFWpGl84aGN92XZlpKXNN_3eXgP7NaHVsZe3wDvsVI
Message-ID: <CAJuCfpHqYWAKjMSdhngvCaAp5htkEhd_RVj1OJf8+HUbWRNNjg@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] mm: Remove __alloc_pages_node()
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:01=E2=80=AFAM Brendan Jackman <jackmanb@google.co=
m> wrote:
>
> There were only a few users, which have been removed. The only advantage
> of this API over alloc_pages_node() is avoiding a single conditional
> branch. The disadvantages are:
>
> 1. More API surface, more sources of confusion, more maintenance.
>
> 2. Worse impact of CPU hotplug bugs: most users of __alloc_pages_node()
>    were using the result of cpu_to_node(); if the CPU gets hotplugged
>    out this will return NUMA_NO_NODE. If one of these paths fails to
>    protect against a concurrent hotplug then page_alloc.c will use
>    NUMA_NO_NODE as an index into NODE_DATA() and cause some horrible
>    memory corruption or other. With alloc_pages_node(), the code might
>    just work fine.
>
> Ulterior motive: this frees up the __* variants of the allocator APIs to
> serve specifically for use as mm-internal API.

Ah, that's what motivated all that churn! :)

>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/gfp.h | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index cdf95a9f0b87c..7edcc2e0be9ce 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -278,21 +278,6 @@ static inline void warn_if_node_offline(int this_nod=
e, gfp_t gfp_mask)
>         dump_stack();
>  }
>
> -/*
> - * Allocate pages, preferring the node given as nid. The node must be va=
lid and
> - * online. For more general interface, see alloc_pages_node().
> - */
> -static inline struct page *
> -__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
> -{
> -       VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> -       warn_if_node_offline(nid, gfp_mask);
> -
> -       return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> -}
> -
> -#define  __alloc_pages_node(...)               alloc_hooks(__alloc_pages=
_node_noprof(__VA_ARGS__))
> -
>  static inline
>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, i=
nt nid)
>  {
> @@ -315,7 +300,10 @@ static inline struct page *alloc_pages_node_noprof(i=
nt nid, gfp_t gfp_mask,
>         if (nid =3D=3D NUMA_NO_NODE)
>                 nid =3D numa_mem_id();
>
> -       return __alloc_pages_node_noprof(nid, gfp_mask, order);
> +       VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> +       warn_if_node_offline(nid, gfp_mask);
> +
> +       return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>  }
>
>  #define  alloc_pages_node(...)                 alloc_hooks(alloc_pages_n=
ode_noprof(__VA_ARGS__))
>
> --
> 2.54.0
>
