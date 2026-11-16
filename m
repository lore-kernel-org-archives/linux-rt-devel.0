Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817598;
	b=S1DzDsWZE8JJTGMLeM/2WXmU1YHZYRVEbrcXp9qFaiIxepYsBdzuLE8GB1IGYnUaW1GF
	 pzfb2xAE/WsZIW1L7Ndu0ElJOEx3kNu1rKsNsSHAu8jWWJ4HwQcyUwdXgCJFkhW8eLSOt
	 ZNkOi6p0O5R8TuZ13yG2ZGe2LJzWATMIpFyvMDRcCNSn8/9wHU2m9g258mlE8COdmxFbC
	 XJkSNDqMfISmEG6/h7gkgIIh/k4u6Fkh6r64TdfKdt72dDnT0OmknrZTKmdg+peptZnLX
	 Jj8XvOqbbfDFOWiYIy1scnvhiBvzQcaKxBqjkB6pJ9NmZwbe6AIhX+qMovkwBD3NgNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R9PifZRQnewXQetRO7yz7EFCcVTd91hjaN9ZPi5pB7w=;
	b=3SN7mwW/8kxyDEs5zdpr8AZuA1K+3RxmcygwAJ0K1qoSMheSRoMPaWRFry7WnYDPzNrg
	 6S/P6ty/d6iCwRkO739IIgNx/JgilN8whTHQtWAdCs8GpwDxi7PKyJUnO/3LCwY9FmA3J
	 VmeUqlYs/1zWInzCpyyRzJIwr3KPZa7fcPy5QqjTvwkvQQIcnSteyCKl6Lwh71b+HNo3b
	 vY8UOv50+HbUIHdWDlaOHVuDpPJImPgofAXWATVzweDaxyUnhhIbZXVtxRZ/3qZjG1AHs
	 j8PtIyHkVreCSKT5XG+vAeMxQ0+QngaadrWHnl9myjL0nsz+UkdLV2XPDSVm2VLwNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDBeVwic;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE606A31C;
	Mon, 16 Nov 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDBeVwic
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755871F000C4;
	Mon, 16 Nov 2026 08:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794817598;
	bh=R9PifZRQnewXQetRO7yz7EFCcVTd91hjaN9ZPi5pB7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDBeVwicMuOouy5ioYurQ4R5Y2QnBqb9DOjlKiwZPRdqG8DP2WVwJZSPxTxjy/Kmx
	 cixn5t6S9wWvB1YplL2GH5QU9DNaezWKC9lL+BJGNhoQZHeRTyoTFJdaO+7WcDTvCh
	 A69CXN3296JoUkc8yn8+DWeE1iizxgH9bFU0/AYGoOh/DBApqb+X9aIn2U10SNYrE0
	 b6/kz7Y1SWcq1RQiAHJVt03vXSMpI/rln5HnW0W1wUAPssi1BbLra6w0oW8ccD1b85
	 dhEOop4CqS8A0yU+y5UDOnLTXx49RMQ4DnJYTEgp/E6UKYK4J6KTF+A/eZqFXxvKJ6
	 J85or3aD43mBw==
Message-ID: <sashiko-outbox-216530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 3/7] mm/slab: handle SLAB_FREE_NOLOCK in
 slab_free_hook() instead of open coding
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChNZXRhKQ==?= <harry@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Hao
 Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark
 Williams" <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>
Cc: kernel-team@meta.com, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261115-kmalloc-nolock-fixes-v3-3-9034dd4ecaab@kernel.org>
References: <20261115-kmalloc-nolock-fixes-v3-0-9034dd4ecaab@kernel.org>
 <20261115-kmalloc-nolock-fixes-v3-3-9034dd4ecaab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:26:37 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/slab: kfree_nolock() leaves KASAN free_meta in init_on_free
  objects
--

commit f5f03c7c446bcbe50fa191f0cf60accc8ad01ac9
Author: Harry Yoo (Meta) <harry@kernel.org>

mm/slab: handle SLAB_FREE_NOLOCK in slab_free_hook() instead of open coding

This commit moves SLAB_FREE_NOLOCK handling into slab_free_hook() and repla=
ces
the open-coded free hooks in kfree_nolock() with a call to slab_free_hook(),
enabling SLAB_FREE_INIT when slab_want_init_on_free() is true.

> diff --git a/mm/slub.c b/mm/slub.c
> index 761dc2affea27..7c0adc1049880 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -2775,8 +2790,11 @@ bool slab_free_hook(struct kmem_cache *s, void *x,=
 unsigned int free_flags)
>  		set_orig_size(s, x, orig_size);
> =20
>  	}
> -	/* KASAN might put x into memory quarantine, delaying its reuse. */
> -	return !kasan_slab_free(s, x, init, still_accessible, false);
> +	/*
> +	 * KASAN might put x into memory quarantine, delaying its reuse.
> +	 * Skip quarantine when spinning is not allowed as it uses a spinlock.
> +	 */
> +	return !kasan_slab_free(s, x, init, still_accessible, !allow_spin);
>  }
[ ... ]
> @@ -6949,33 +6968,12 @@ void kfree_nolock(const void *object)
> =20
>  	memcg_slab_free_hook(s, slab, &x, 1);
>  	alloc_tagging_slab_free_hook(s, slab, &x, 1);
[ ... ]
> +
> +	if (slab_want_init_on_free(s))
> +		free_flags |=3D SLAB_FREE_INIT;
> +
> +	if (unlikely(!slab_free_hook(s, x, free_flags)))
>  		return;

[Severity: Low]
When CONFIG_KASAN_GENERIC and init_on_free are enabled, does kfree_nolock()
leave non-zero KASAN free_meta in the object after slab_free_hook() zeroes =
it?

After slab_free_hook() zeroes the object for SLAB_FREE_INIT, it calls
kasan_slab_free() with no_quarantine set to true (!allow_spin):

mm/kasan/common.c:__kasan_slab_free() {
    ...
	poison_slab_object(cache, object, init);

	if (no_quarantine)
		return false;
    ...
}

In Generic KASAN, poison_slab_object() -> kasan_save_free_info() writes
struct kasan_free_meta at offset 0 of the object when free_meta_offset =3D=
=3D 0.
Normal frees clear this in-object metadata upon quarantine eviction in
qlink_free(), but returning early for no_quarantine skips quarantine and
never zeroes free_meta before the object is reused.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-kmalloc-no=
lock-fixes-v3-0-9034dd4ecaab@kernel.org?part=3D3
