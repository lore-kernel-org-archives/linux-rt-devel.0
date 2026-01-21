Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99432B99D
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012523; cv=pass; b=R+rz3N0PuzJpdRgxsQXPgBPMxd6V1w6pICBu+DcYle7qvQv9mxpz9mOgSvPs1c9TzOSX6FXj8t2/eVs5MCGEt3IODAW4FO0zBWAF6SvYxhOPi1dikyn8EvNZWXsQl1bWPDHRe4c94HOy+UCSdm4a0SkNUv9tvsl+ZYtBWlrGHTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012523; c=relaxed/simple;
	bh=N8yg0sA6xeaJapH8x7dXFOQ5ATlqTNmQkFmcpp80GVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzgRpvLQZMwI+myTxI7WlcxGXQc0TCg+4xId4B13WA2GJhcQ7MPLa3pdLPIPI6tPTDuvpiCWC2KSou93Y5a8wfJ6c/EOn/kXPz7v6zN00pPQskBmgMHjIBaZmusdMvYB+pNR6NlBKA+kfeZdbFiho4nLbZbd8cNuur8vRxCP8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHSJLpA3; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHSJLpA3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-501511aa012so115651cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:22:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012520; cv=none;
        d=google.com; s=arc-20240605;
        b=WKyDRG4mO+nTPwf/OBtGk6FfnHgUVYRQv5wh8YL/lFuHxZjJyGb6mhKn6xs8ddOLuO
         bBDamsBlBrFb14ayuK/Z0+E/Jw6o1KfD+X18rW7EigZVQhb2jHjvK0tuPKhnflODZzyQ
         dOj2fA99a4O2j4MynsxWHdn0SeCKWFfD1qxYTx0Aw15YLwCIfZkKF+BlcDb+cy/dCdlA
         hf3gQtDzUhbWxvZunnGdIZh+f0BUdvUwl8vPcoiHKA3QraywMkYePkVv75UjD+JUQM8B
         DvwgggmYSKLrGFjtswQoJhKy5FyTcC4bPesEpANVBEdhU/P8Bt43/1JZ4Rl2YpvR/0nP
         arSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VdVLEMD28EfX+5P0zrv2LIUEohcfDySK6bn0IJ0lRR4=;
        fh=ClkIRkUhUY/S7q0mXeFcjgpTOgrxSULdJMvOw5FXQhs=;
        b=Koz8WDPX2ODMWnL3jiGcfxYfqExOW0nZYOBC1lROIx7AVajNG6qcfVtTzkTs0h44vH
         fSFQLTgBncMdJlPCMFB4xpkanvj241NbLL3XuhGe1pI8wYTgTkucFHoahYKkVgSJTh3U
         FKBXI9XuNNkRt9gkz0zsDfejWpwxR6BG1C8yIa/3Fg9Lu04EjzL7u5tqsDXWwkdIPQN8
         4sQUjYRbLKyx+lXd7Ce/3usFmBNsXStA/lhtR1Y6nMDO+bu/0DC+s6AprWcQgQGqNrdu
         4RP03oO3HA569xmxGB7Y3tRmZINJZdRvaw/rj/ZoTziGUf/lx5ttlJAb3WBI+mNbjnyN
         ytCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012520; x=1769617320; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdVLEMD28EfX+5P0zrv2LIUEohcfDySK6bn0IJ0lRR4=;
        b=BHSJLpA3zT46ySdrfL1kesTG24PIbm9wHPLbI/sfRQfQx5sDfA/x0H/dIZO6kwM8CL
         9K/ODtZ3xdQf7ZyVLer5RjvdskWyUQyhHuJw3momWaEUCafNYguhLScu83ecgWfrgB1z
         JEhak2kjEVR1Zc+EpTpGNslFV9mrrZAwpQxWcOx3pgQDXZb+TNj6afGDN0dYdoakP933
         o33MNghrKDqbqhMmBDsAYcrNaZIg3MrOpkrFn30C8zuS+ipTgK00esp/ueGLWGIN/UwK
         rc7dQ457fGiDF9VSwdlRCzWHBC6D85CXoQEiZ7Ly7pq9AWJqizw5haPZA8RI+FXwEE00
         CyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012520; x=1769617320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdVLEMD28EfX+5P0zrv2LIUEohcfDySK6bn0IJ0lRR4=;
        b=ULM64Ll1SB5aHk/1CJ/09l+/o527rTMZBxMRFgdBgZNqpVC+UCrEhJcng6dQXu55+B
         Tk5IIeSzZ9f2wFbXK2WVlUel+gNjfnc8e2kxm8UGYH2fg3nj7wtzUEuwkXoVHAwdBTLO
         otUd384Okzrjw/0pmGZvV4Qx8qidIFiNly7YGny5IXiacJ+ltwW2Yf15SlrtUYKBaR+N
         RH/AXKYik0U1AiZQrZCS5i2BRCRpeoZLYwqV9uM56ZoHxwCW8zFmhg1UaLtiBoKo4JdD
         W74SDA/HORhS71iPcQruWPvs2prEkPfxldzl/iSLn0n5lqhx7Dt5WeL7ir1erVBJUJlk
         j1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWXcsDMjiGrvBCid4fqc2vZ3mX6n4EiFoFX0+AVK2mSzyiBXMYOMzq6Xg46vvSwGUwoiujZHvUUeXex6nvk2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/R2zORRhCvRgXc87v4oxkQI5CNs6dMefQsOtKxqmB+OXy64a4
	d8xr6n8g0+XudV7GlbxkyPoPtjYcXNhdGoHlei4xmh5ZaqU+aGIYE5eAO9VTlLl14mwzNexz87I
	sCf0NeVmACVSYVpOjVBr5f2H2Zw6cMtLSqizQeroN
X-Gm-Gg: AZuq6aK3EmXA2YzhVVLErTtoDB9nAav5JTfwQGJ/1oWTOzst9cf4coLDtE4/xodZaA6
	wBg3T9hE20RO630T3/RhlGO/oh4On1dq4PzETqkE11LHtflmdfac3IM81TiA941We76T3KDGfUS
	9pXRqxsJJSV8LaVzX3WDZBs5XbgymcyTyI5CXWFnYL+1RWWCl1WsQZRdV711eqH+R/4KPNja8+P
	alrCJLll6N+SokLK81/PVEAkY2tCA/LnbucXPyX89tt6wu0KhvZ0bDX1VSBdInaH3OeCxlRXwlG
	+hwoHe0nGtz42whidrAEO1Pf0ZOIHOR5Mg==
X-Received: by 2002:a05:622a:1998:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-502e1a7f7b3mr11247441cf.7.1769012519794; Wed, 21 Jan 2026
 08:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz> <CAJuCfpHaSg2O0vZhfAD+61i7Vq=T3OeQ=NXirXMd-2GCKRAgjg@mail.gmail.com>
 <aXAkwLsGP9rqamKL@hyeyoo>
In-Reply-To: <aXAkwLsGP9rqamKL@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:21:47 +0000
X-Gm-Features: AZwV_QhmIp5S8mEMP1h6Gx-TWCdfCxovy5QQV_d0u6153x3grZV0j2owhClsj2k
Message-ID: <CAJuCfpFiLnvXF-yOVmLDNqQ9ZoJC1uKz3J7UNawhp5Epev=eNQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:59=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Tue, Jan 20, 2026 at 10:25:27PM +0000, Suren Baghdasaryan wrote:
> > On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > > @@ -5744,10 +5553,9 @@ static void __slab_free(struct kmem_cache *s, =
struct slab *slab,
> > >
> > >         /*
> > >          * Objects left in the slab. If it was not on the partial lis=
t before
> > > -        * then add it. This can only happen when cache has no per cp=
u partial
> > > -        * list otherwise we would have put it there.
> > > +        * then add it.
> > >          */
> > > -       if (!IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && unlikely(was_full=
)) {
> > > +       if (unlikely(was_full)) {
> >
> > This is not really related to your change but I wonder why we check
> > for was_full to detect that the slab was not on partial list instead
> > of checking !on_node_partial... They might be equivalent at this point
> > but it's still a bit confusing.
>
> If we only know that a slab is not on the partial list, we cannot
> manipulate its list because it may be on a linked list that cannot
> handle list manipulation outside function
> (e.g., pc.slabs in __refill_objects()).
>
> If it's not on the partial list, we can safely manipulate the list
> only when we know it was full. It's safe because full slabs are not
> supposed to be on any list (except for debug caches, where frees are
> done via free_to_partial_list()).

Ack. I guess I'm reading the above comment too literally. Thanks!

>
> --
> Cheers,
> Harry / Hyeonggon
