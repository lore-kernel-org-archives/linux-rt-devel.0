Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D056332916;
	Fri, 10 Jul 2026 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680827; cv=none; b=nHw7cKbO3HmeZ1VyWLXNK/6vYyDnrgOMvkxCI8gr3mXwk0cY2ESoLgDI+UzFeXmZjJ3NdVdbeubOvyZUODCxpg6tSWTgJJWBTPq0137T0K7t831tEz6dVRQb6uT3/bXcXeAOKg/L6SUWMqFRYYALqgQpBtO5b77i3UvwkS0B+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680827; c=relaxed/simple;
	bh=Vci7zlm0nvuZ7fUD2nfaFyeWgMfoAJQ++cY0u5YnoYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vv4omLrrfQSKWv80/Cb2hP405JNQvWvrjZO6f4sLVs298T2W8mxsEJbk1A+B4MCatqZu6qf7NJx2xKqjOXObdChpaTiZPDsjPVaeYgfOK5TX7ziqctwjxdnTkT7/Oithu8nc6iaoHYWgDKAQgcXV6fdQSah5662qPFeuhiwPUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNSG2DKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNSG2DKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA031F000E9;
	Fri, 10 Jul 2026 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680825;
	bh=wDxzpeLFblN7rLboFovZo8rbNeczTKGXK2Yvf6Vm5sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNSG2DKcZPWJaU+dnHF/TevFAPumzj3Nv2p1FsPpq7MJin6cHdPob8FH6XWxoDrPN
	 5f9O1cFM5nA7560txdXdRLSJ+yhY93X50rPjunU3Fs/TL2X91wNqkoaMu9uEoiqy3P
	 rqSkbjVRtPzWamdZKZrI8xYeYDqz/vmtL82Y8ViYKiOdI4QONHRdheAKqxMtrBVxoj
	 ixX3HQohO4Tt2Hk/PMBzduWa4Z+7nQMW6zuh2YUsvcTkftYsyk5nMbWIZMrc+75Xsz
	 T5PZaZYQNJyIM69d2Tc7+jbNwETv76/Lv/Y6asSykjQ9FCF9/lIrX8vTyDGfkF485j
	 8q0+sq6e9jdSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:53:43 +0000
Message-Id: <20260710105345.2DA031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] FPI_NOLOCK frees can trigger unsafe spin_trylock in NMI on PREEMPT=
_RT via high-order or MIGRATE_ISOLATE bypass paths.
--

--- Patch [2]: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK =
---
commit 57a8fbd6534fe3dfce75d671c889c4e1ae65159c
Author: Brendan Jackman <jackmanb@google.com>

mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
   =20
As discussed in the linked patch, there is some inconsistency between
trylock and nolock nomenclature, so this aligns it. Since nolock is
used in the public API, the FPI_ prefix is updated to match.
   =20
Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19d3@=
google.com/

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5fe1c11f919d7..ba8d882072de5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c

[ ... ]

> @@ -2979,7 +2979,7 @@ static void __free_frozen_pages(struct page *page, =
unsigned int order,
>  		migratetype =3D MIGRATE_MOVABLE;
>  	}
> =20
> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
> +	if (unlikely((fpi_flags & FPI_NOLOCK) && !can_spin_trylock())) {

[Severity: High]
This is a pre-existing issue, but does this bypass create a risk of executi=
ng
spin_trylock_irqsave() in NMI context on PREEMPT_RT?

Looking at __free_frozen_pages() in mm/page_alloc.c, if a page's block has
concurrently been marked MIGRATE_ISOLATE (e.g., by CMA or compaction), it
takes this path just before the can_spin_trylock() check:

		if (unlikely(is_migrate_isolate(migratetype))) {
			free_one_page(zone, page, pfn, order, fpi_flags);
			return;
		}

Similarly, if the allocation order is greater than pcp_allowed_order(), it
immediately delegates to __free_pages_ok().

In both bypass paths, they skip the !can_spin_trylock() check entirely and
unconditionally call spin_trylock_irqsave(&zone->lock, flags) via
free_one_page().

Could this lead to a deadlock or kernel panic if a BPF program or other
NMI-context code calls free_pages_nolock() and hits one of these conditions?

>  		add_page_to_zone_llist(zone, page, order);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-spin-trylo=
ck-followup-v1-0-affb5fe5ed00@google.com?part=3D2
