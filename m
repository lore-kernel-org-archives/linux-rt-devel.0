Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E83BB682
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317059; cv=pass; b=lFeLbI+sWUT2PTbwQsKgCTewPiPz7nLBie+Vqu39FakpPhnzm2v88FUazXNVqEA5+iA/9Et6IgUIbhUfwgZ9rqzb2G+fgq6s/pXyDab87Ph8PtkwILqRaB9Jno8JY0OA9RHWxATdW0Vf9/lv/JV5jd1pyHIDvAuHFw7Z5bgomPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317059; c=relaxed/simple;
	bh=NtTPRwOqjk3SHQ7hzmE+v2ahi79vpIZnc98UGO5/+HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmqgTZEztAW4H4/i7MOSif8txPRM2FBTWAJPhI9FkxjHdbd2GvTVFE68pIJdgb0RnLA+JaVthj+msXH2r9dzLIBZtrIudd4W6Uc5o6/vKzyk/beGZjn2QGkf396buwJRiUuF+afY5V2lQdJEH7AByUBLIQh8BZ8b+PIWH8ZTzlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTNl1ycw; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTNl1ycw"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-519ed52bcc6so330411cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782317057; cv=none;
        d=google.com; s=arc-20260327;
        b=cimFhnVe+oj+QX2+mFbmN8Q14soSDFSutBamCHHUeC1422GocwGDAT1GODiDT8PEJd
         1Z4vYM3fGLorNWvJN0NNgbnnHFmodhSPFJIBUApBJ4FTJV0GF6WGy133fjmXE+8LMoHG
         ClAUsvEWpxTcOGmdk3NaPgHtzg5456/PwH9kLuC4xO353vHBs7bsjxlqReptLBAEItXv
         cQw8IMlrP10P+HnAbfCf1k9GB/4eeZ+ewJzTHxAuxzKvwlysPB7ed9+Mzc3mG+ShB1FI
         v50z6S7XoLuMLINIR26ghGUh1ja/i6iiNHUgDv7F7pRzcBlKLnjun7FmqRzdrUC+J4bL
         a97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhiS7oy2LfTCZ3XodtRawKKdXn1sLVFN3zBm3POyKAE=;
        fh=/NJyhWRa0T+r8jcvLl/81uYawveLM8xnaqX5Epc7npU=;
        b=gUjMt0hP6oBVsgwgds9adzhIDrSqiVig+BYPMQ8E7EivF31k6mZFhlLOUIl0zW5cZW
         26YJjZjx/pg/fBhXXXeI6f+n0kQqqJ5sz3mLa0FAEmTRshhtwmeK2wVv6yF0xszJmRFD
         vPjLHaeVWQInALj9N/PAD2QePtqlf3BIiJL7PI08LrXuy5HhNSwz2sHbCiGqJyZS5ERj
         ypId8yYJaYo0d4xQU36jzxHUlvnbO9B/9v1i+3AMaG1drPjVUHED8Yc3sh/xbh3FAG0H
         GpR8fAOOh7sWyfYnOwR49lOJVD/vt1kgWYrvMgh9eVGvGsKIv+MQXJ0TwjHKzvokkLfI
         HhAQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782317057; x=1782921857; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZhiS7oy2LfTCZ3XodtRawKKdXn1sLVFN3zBm3POyKAE=;
        b=TTNl1ycwX6t1Hi3BdTl93R90HhyiZvT5B9f1ZovgPIdiZkqniUa6AKXBjgM5iax80f
         K4NKpzsRstXilQpdWZipG+EXKqu9ltZDSBSzAcj7PwyQ/EzVKYU4Flm+15M2GlduXBnm
         1LZZlRMZePZAWvOSa1KVfUNSFre4lemh4dPuhjvRlTrvMGspaIOIYPEnATmruqoXnTZI
         Rez537bsYaxiYY7d4XFckSpmEUS/fiR1SI9G0G2RYTR5toINsDbh+Hw+2eKP2tlphRMD
         JjgdIZegSNIT0/RaDLJOlvHxxEs4w3so8LOvPedYUE5Rikri+uOXL+3GYG1nlxfoQsYW
         ZrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317057; x=1782921857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhiS7oy2LfTCZ3XodtRawKKdXn1sLVFN3zBm3POyKAE=;
        b=jBu3rl4aLjZJfzRvA+Q11M8s95gPBEu9lRvJxjvxS7lQhke2QPF2Cb7I3EUwy7qI/s
         TU74FQAEUCFfqx8qyxEKivlTcBAE+4L/XlDgxTeTfzgnNjs3tJhgV2ESuUGrPizCAi2M
         Rb515mW36n8oDetXMkfvhd90CFQ0IJP43533ztJoVvm2xJ+sRewwJt0sD6UJ43mOl5sj
         cUtJ+v/j0WS20/pNWuRN88tZst4HKRPdiRzQ+Spq5Zq6Ic4xUXfhlizOdEDtfZ30RCTJ
         Ja9A/VTH1nIPrSvYAxOapIo6xby/iImO+0QGbtEdKl/bCmEEHSDm+0z41M/4188rkEzU
         aUIg==
X-Forwarded-Encrypted: i=1; AFNElJ+j/gKsn8B4zbYSG5k/5+dC1Bf7A5+zZqTfxNWCBLbxpyVxt7Mvp45yA2qld0hKFfKaOyuSOWK+IEK/u6AcBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8BGo7WK2flisbENhSbWBOHtwVxUL5wO7qjXPIpnKkrkQAirzh
	8THGIsxwfH+2oQmaF+gb1Eeox3J/FAv3CGNgr+HkHupl9oSObWKFuG7BJlPViHc9hPBhPFzCp86
	T9efRmLUBVIhOYmVGLcu4G3jBGj6fHuvRjxEM4ksr
X-Gm-Gg: AfdE7cnq6tCoA/KVvTk+ihGROV8VxT427AXO5QolEmkFwcdGK7x/POAIY4jzsKNZS7Y
	p/qni0SL1XNFCNc+A2s7BAG3aJz8ibSrvHcApH8DL7GTv9TmPXySMDkeaKmtWYVS+uk4b9OlpH4
	qG/EfrgAiL1HXjgcKIuCErmAD3SLMqji1bC2umGE5sWIxQnRYuTcsgmzgQHMyRLPeDGlRfOLX5Q
	DC9TpiFUW5Ygq/dgclkK0RH2IC4vjSa/lx4TeDSLk9JsiL1MEG6XehmjOEaWoFBBZe9CYqBtjOg
	mnyImDVLvZJWc5zcMeyFSw37/b0=
X-Received: by 2002:ac8:5987:0:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-51a618d11d3mr10106971cf.16.1782317056213; Wed, 24 Jun 2026
 09:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com> <20260622-alloc-trylock-v2-4-31f31367d420@google.com>
In-Reply-To: <20260622-alloc-trylock-v2-4-31f31367d420@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Jun 2026 09:04:05 -0700
X-Gm-Features: AVVi8Cd6lslf4L8Pa56jgYl7vha7nodZ13IZY76_KASlAg5iU8NzS-0fLnwiqjc
Message-ID: <CAJuCfpHCPr7Wy0XQ4UG3X61KjdNH14FiB=J7dvdUkMrGxN0Fbw@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] mm/page_alloc: relax GFP WARN in nolock allocs
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
> This WARN forbids setting other flags than __GFP_ACCOUNT but we
> unconditionally set the ones in gfp_nolock so they are certainly fine
> for the caller to set.
>
> There are other GFP flags that are almost certainly fine to set here;
> Willy noted GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE and GFP_HARDWALL. But,
> nolock allocation is rather special, so be conservative to try and
> ensure we have a chance to think carefully before nontrivial new
> usecases arise.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/linux-mm/ajS96fWbG4dzP3u3@casper.infradead.=
org/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e31babe2181a1..074e007bf1bc3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5337,7 +5337,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp,=
 unsigned int order,
>                 return NULL;
>
>         if (alloc_flags & ALLOC_NOLOCK) {
> -               VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> +               /* Certain other flags could be supported later if needed=
. */
> +               VM_WARN_ON_ONCE(gfp & ~(__GFP_ACCOUNT | gfp_nolock));
>                 if (!alloc_trylock_allowed())
>                         return NULL;
>                 gfp |=3D gfp_nolock;
>
> --
> 2.54.0
>
