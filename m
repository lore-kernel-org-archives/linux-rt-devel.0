Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0A2F12C1
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522975; cv=pass; b=SpAif8VrOVmsxHspaAftmFvU7PGt28Pqsn44ee/JTNPAV+MeG8zXwzWgi4LinRvRINM10Vdnpn0+m66+Va2o++9momHrBQiN1RFo0vZSxP4fc/hm7/QjkY6RQRlYEiDoLNfiikx6blAqxC43zjmUhvGbaGbj8ynjekYYhYeGq+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522975; c=relaxed/simple;
	bh=7IjaKVr9Qjs79eTGTTDTXYnTpcN3WgBNmCFA4kCF0BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cINfWy1py2TRHA0Sj4NaDJNIcxfr9E+14ZTWNDH6+ARi122ufZPY+rNm/ZX6EGqSirRVPNok8HqS/rYcN0cs0CHZlZnUAaLqUrzr1jByoXIfwEsBmTVRpQs/8eQnIvbvzVkTFI1UXLMMYqQ230FkAzfCpsq3OJcbDHzYq+RTvWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7JNN3mW; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7JNN3mW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50299648ae9so103621cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 16:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768522973; cv=none;
        d=google.com; s=arc-20240605;
        b=aTZzEymp0bjt9KkMp5HdLKa4R5IG6wTZmt/QTn4R/VDfpAEvYYNzOEddr1Rz9ecXz/
         QU4c0w2GJx/hV0EzXE9BmK6SNgFl3QvF4e0AKNsTl+mtjlswQomxNdmVF0aNECFHsniD
         S3zTUaYTqXiAUryD8FIxHNagh3hlPhiDhIye6cU8b6IuKAqm2g1OT00GjJtltb1XBHmr
         7ecIAihr2yjlOGhuTFiY3hdVKFIWy6CCbwVk6CRX+Rv7d+dQZOxHtBw5CzVMIL/AQfMK
         ow7Xd70f12MCFVRLm/QyhHYCrm3uFH2O6zxH9GPorZ9EQ89KA6fXogNKND822R2RafCm
         D11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DW/ITMg56jRAZJtQnAt5F58BDqK/01GQKI49GCbQ0F8=;
        fh=UsKN0k1sQnN8HRNZOEqJrIGbZHyIMi2CTFGHOqj8DTM=;
        b=iN5CLajRJUeTzLB2qeedvbSoWf4cwmf390lZK6ptjouMk88VCjKxHNeQwFpy2Ks0h/
         3g/ySuhTIMXly9oxNkrcYDKnqJRx9Cj3YNRe4uCkgGbhGvnpS8rVDLcu6QCiHx25grWt
         nDy9Vm1/9HcE9ibP4RsAmp7GPi62SvdxmJGlcPqTqHyd8BMKm4JLgzktxMvmdDsk+pVq
         ndNUDJkV+VyGgXkSNgwrLqxYPA+VRpTfDvcB72S/s2uxKjiM25ORgFmULtUzExtoo4jQ
         xTWCk+EwsEg2eB8WxdqtmNhmgK5aYBelcIFnDUp4vdAAgMHCvBYAEJ7frBvE62PPxttJ
         QegA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768522973; x=1769127773; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW/ITMg56jRAZJtQnAt5F58BDqK/01GQKI49GCbQ0F8=;
        b=D7JNN3mWi0LEgUDvkNp29zJ1ZFoAjIPw2LdkrDvLchqdAO5V0WdyOvhdlk0HgtuEKE
         2T/7y0qq+dEbXX0Xt5/fHjRSFzId70psng7Z07JTb3oSKgrWltXnaf2Dx93j+SD8U8Li
         BeaMrVneDPkCS/wENnHWi7M6ZioPFStkbX5J0gmS37041UVgNr6Pnr970Xjjs1bCWLIb
         MHqkTGePJRS9HesexE/PLLm2TOe/NbZSQFcMWqvY6HOEzWabryKLva0udCBqoffkW/Wg
         mBwNs9Jra4Hc4m6Oi8VAba8aJPnMkKmTvA5uMYP0dJRb9Ox+mlUw0H61MyNBxlnlrRzd
         XCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768522973; x=1769127773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DW/ITMg56jRAZJtQnAt5F58BDqK/01GQKI49GCbQ0F8=;
        b=VrMs9twZ1lkw54s8qln37xfS3VQ0x557TdMugwK+tQ2Jx0AUzRMcIiJvxf4ek7g5ih
         GmdFeEHsEVSimkHdNS+hKfXJdVSqtOvLFhRgGNVwy3qcfCzwx/hkthKz4jdPGsM52ZY2
         TDrMsMOLLPyLUju+iwoXRTnfBmUVtJK3FoKflpZLXvVEwXzNEmd1HwTe/uf2IAVAf9nK
         MrpFg5gJMQXHs9udcuiUPvCglf5jbKEWd7Hatt/otMUfxxS+NBi7aTLIyApV5xXUjScz
         Kcv8hCUGEjlPKqfD8Jm3MkIM5eR2JNV+HLxCoL4O5UiJKnEL8lLmTT8XXJ/oSZBk+9CS
         ulyw==
X-Forwarded-Encrypted: i=1; AJvYcCWCHaY3SMevTzbtCA6R2mL5mXtnkBoxKXRbklD+VwERerDbZ/nYrXaaqM2PO/o5ayDhboGeoDcyyY/Juj9G4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL/WGTXxnOFyPcaf7zEWeq+r8pMHRPhgMg7+EaoJEJUlrgaGrP
	dvUAuILdOSOMa6NAtAYN3VjWh3olOdzQxdxZYQJJc2C8TZflX1Uvkh3J4/+oPbIMqMbtt2cBo0o
	yT4PmQ3Esdc/aWyDVLIVxDpnKaVeuWY16CXFcXlag
X-Gm-Gg: AY/fxX62EU9y2v0gekqj2WbqEo6G06jvnVSuHoTIve9wPrl9P46dZ/cQcelSmECsq9y
	7wG6OyV1l1Mhl9LUPX/eP2wHYgsajTAeD2l6DHz/RsWWw8PpEjpfp608j+kGLgNlaXvVnuzDV0S
	YwbOHW9tbMFhpF7wjuC1gBLLn27fnOfLOX/tfKR5rkj0VKvnmfUj76nNU7bcAmZrikD+5nggJ/H
	5aRoKapE8zZnjMUxZVAgvo4ix6d/qJA5Sej1lVCwG21MD1Ee5RjD1HW+NyySSxQG8DIBsbmi6jw
	xGtEW+RMzohItzD7pV3e9fw=
X-Received: by 2002:ac8:7d0b:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-502a367742fmr2431351cf.1.1768522972940; Thu, 15 Jan 2026
 16:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz> <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-3-98225cfb50cf@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 00:22:42 +0000
X-Gm-Features: AZwV_Qi0xiGM2d4FuoLFqXrZf077B4nd0NZeqj4924Qs7epHRHPkVirBgIQQHEM
Message-ID: <CAJuCfpHowLbqn7ex1COBTZBchhWFy=C3sgD0Uo=J-nKX+NYBvA@mail.gmail.com>
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

On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Before enabling sheaves for all caches (with automatically determined
> capacity), their enablement should no longer prevent merging of caches.
> Limit this merge prevention only to caches that were created with a
> specific sheaf capacity, by adding the SLAB_NO_MERGE flag to them.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab_common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 52591d9c04f3..54c17dc6d5ec 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -163,9 +163,6 @@ int slab_unmergeable(struct kmem_cache *s)
>                 return 1;
>  #endif
>
> -       if (s->cpu_sheaves)
> -               return 1;
> -
>         /*
>          * We may have set a slab to be unmergeable during bootstrap.
>          */
> @@ -190,9 +187,6 @@ static struct kmem_cache *find_mergeable(unsigned int=
 size, slab_flags_t flags,
>         if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
>                 return NULL;
>
> -       if (args->sheaf_capacity)
> -               return NULL;
> -
>         flags =3D kmem_cache_flags(flags, name);
>
>         if (flags & SLAB_NEVER_MERGE)
> @@ -337,6 +331,13 @@ struct kmem_cache *__kmem_cache_create_args(const ch=
ar *name,
>         flags &=3D ~SLAB_DEBUG_FLAGS;
>  #endif
>
> +       /*
> +        * Caches with specific capacity are special enough. It's simpler=
 to
> +        * make them unmergeable.
> +        */
> +       if (args->sheaf_capacity)
> +               flags |=3D SLAB_NO_MERGE;

So, this is very subtle and maybe not that important but the comment
for kmem_cache_args.sheaf_capacity claims "When slub_debug is enabled
for the cache, the sheaf_capacity argument is ignored.". With this
change this argument is not completely ignored anymore... It sets
SLAB_NO_MERGE even if slub_debug is enabled, doesn't it?

> +
>         mutex_lock(&slab_mutex);
>
>         err =3D kmem_cache_sanity_check(name, object_size);
>
> --
> 2.52.0
>
