Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE094394780;
	Mon, 29 Jun 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742603; cv=none; b=P/ybiYn9XgCbVBuu18RxEhCkJtpWrVfJDgsQHUbEV9sqTfOneN1NsJgNBtVZCMN/zyJUG+mbMUETHwPDvN1jlZbfC3tbN4rlP5Kh8qAPHcG0I7X6ehyDtAJwzc3GHcp2EcZlGmgGfi4f4zO4cyzIXosTes9h6nvn+4a0tjXmfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742603; c=relaxed/simple;
	bh=jbJk0SKZSIaFmFIAPpf4cKGFA4Zb+6NuHW0aelsvUI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rm9xll0K+jAs/efKRyrIIzbfclTPTubngNpRCDlFSd4ob+XzXI3G0HRzxwMeJaVFlSlSMiPNNAnt2gUf0KLtW5HUv078dyUEtD4NPIto+k11agf94O3ku37MRGMEJUvH1gAQC5jIASoL0nnWMb3QR74DXrmfhusLsBaFwwQmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7gvsi4C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7gvsi4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628271F00A3D;
	Mon, 29 Jun 2026 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742602;
	bh=zLzkCNeE2S12rL8kle5DQBNdOr8By10ekZu76+ZaEwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7gvsi4C+KEFUjFNWWQhMacDUZmvODzCWaGlAgvMtwRlBc9HRGRzJWHpS7gdJ0tIs
	 7wD2G3j7Eh0dU4Dc/VVkQLys2z0iMPUHqU6asWuyfu4PqkXaFYBOWKi2Iw42BRDk9n
	 zl7r1W9BoMKJl3tbSX6vjX9jrzAVrdxNkM9dL68f/mZVDafeSMT+qbBCGRwoPWeqHX
	 3yJjvB/PAL7mXAWIuL7rTE5I+nbRKUhOJMqXYf1KrXOHqhUlomkir0mcYKcr1Zj27+
	 4G9AzaHz/+JoSzuYKm396zTWtSFkrSdjEfScdrh/h+KipRL21vt7/hTNWCoYQPCTJ9
	 61FLWG+DJX+/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/16] mm: Split out internal page_alloc.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260629-alloc-trylock-v3-4-57bef0eadbc2@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-4-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:16:41 +0000
Message-Id: <20260629141642.628271F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing inclusion of `page_alloc.h` causes build failures for multi=
ple configurations.
--

commit 34a7c3e538f8ec840a6b68715addef408e469ff0
Author: Brendan Jackman <jackmanb@google.com>

mm: Split out internal page_alloc.h
   =20
internal.h is a bit bloated, seems like time for a page_alloc.h.
This moves definitions supporting mm/page_alloc.c into the new header.

Link: https://lore.kernel.org/all/41e92bab-6882-401a-8de9-154adbdcfb36@kern=
el.org/

> diff --git a/mm/internal.h b/mm/internal.h
> index 8ce59c5664497..c22284f04fc9e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
[ ... ]
> -static inline unsigned int buddy_order(struct page *page)
> -{
> -	/* PageBuddy() must be checked by the caller */
> -	return page_private(page);
> -}

[Severity: Low]
Will this cause a build failure when shuffle page allocator or page reporti=
ng
features are enabled?

It looks like shuffle_valid_page() in mm/shuffle.c and page_reporting_drain=
()
in mm/page_reporting.c use buddy_order() but don't include the new
page_alloc.h.

[ ... ]
> -extern void __free_pages_core(struct page *page, unsigned int order,
> -		enum meminit_context context);

[Severity: Low]
Does mm/kmsan/init.c need to include page_alloc.h now?

It seems do_collection() uses __free_pages_core() and might fail to build
when the kernel is configured for kmsan if the header is missing.

[ ... ]
> -#define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */

[Severity: Low]
Could this break the build for migration and page reporting configurations?

I am noticing that migrate_balanced_pgdat() in mm/migrate.c and
page_reporting_process_zone() in mm/page_reporting.c use ALLOC_CMA but neit=
her
of these files appears to include page_alloc.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-alloc-tryl=
ock-v3-0-57bef0eadbc2@google.com?part=3D4
