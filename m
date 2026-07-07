Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07612416122;
	Tue,  7 Jul 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430047; cv=none; b=l8KpQsYkTo8VPZaXnlGTpHE29AMPCoWGjYKTgmCvNzkp+RMNht7nYJ+dpC2pPMmTuEA1FGbLYH6n1Vg9vCug0jXqXKh+HWq+l/5aFCXZ+CJjjJwMQ74AHd/W9HVGbcD9BFeBsiKQPmyuUa2nktHnbpS6Pj+R5xyJYzYXIWFShCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430047; c=relaxed/simple;
	bh=D//v5x8Pz7L8CeYnTsMtLL1ZA7M+MkH96S7K+3CjUe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M0dQvsGAdzYCutmH+czSBn9afhsHgcgS+TzmgXZ+hDFkg0O61L0lAWB/Ae79aS/Jk0vb+atGp/NpiErdOguYqywT1lBYSGWIIvU4m8IiJJFo2zvY4c4JyOOadE/ib50Cu3LaIq0qr51RpjeXCG48YbiiyV6KqLN+LeA4t22TJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv850DiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv850DiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541091F000E9;
	Tue,  7 Jul 2026 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430045;
	bh=1j2NI2ZvTIsW9BRlO5e6nGJ+h1FFgH//jhc0kuPX62Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hv850DiVuzHPFVW7rpV1b9iVDdFe4fKtm/vR8Ja84kILykdQ8jo2dzQGzWlcNeWWR
	 zYYnW7Bg6kUPxikypxU+dZjAA8NHjCI6u4H7HUBSVZr+5iTh1SsJA2NYachS6HfZm+
	 9iT07rfPOjjAAWaJfcjIGVGIEyZfTM/QLsg3gm9bOy+1+YfsqrhHUUhd60/eibC+GU
	 XYr5uQ9Ed/5RFR7nrJx5vvUbFBlpQqLtpe0st6TA5vTIAR8b3X8iVz+eDyDu0HHE3i
	 w6YDE7UPL2dd9YeoB3vDxvESkV0t+QT3Q11Ux0I0h2pfAQkaBVvQYkTxA01IPFKG50
	 /yA0/3n8wmcmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] mm/migrate: add tracepoint for folios unmapped
 during migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wandun Chen" <chenwandun1@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260707125925.3725177-4-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-4-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:14:04 +0000
Message-Id: <20260707131405.541091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning ACTION_AGAIN from inside the PTE loop in `mlock_pte_rang=
e` causes double-counting of `mlock_count` for folios processed earlier in =
the same PMD.
--

--- Patch [3]: [PATCH v2 3/4] mm/migrate: add tracepoint for folios unmappe=
d during migration ---
commit 66d2b427e02176d2cc56e534e84b38ba838aacba
Author: Wandun Chen <chenwandun@lixiang.com>

mm/migrate: add tracepoint for folios unmapped during migration

This commit adds the mm_migrate_unmap_folio tracepoint to try_to_migrate_on=
e().
The tracepoint records the PFN, address, and flags when a folio's mapping is
replaced by a migration entry, aiding observation of mlocked folios under
migration.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index d99499ae338f9..d911e6ca62e5b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2723,6 +2723,10 @@ static bool try_to_migrate_one(struct folio *folio=
, struct vm_area_struct *vma,
>  			hugetlb_remove_rmap(folio);
>  		else
>  			folio_remove_rmap_pte(folio, subpage, vma);
> +
> +		trace_mm_migrate_unmap_folio(folio_pfn(folio), address,
> +					     folio->flags.f, vma->vm_flags);
> +

[Severity: High]
When try_to_migrate_one() replaces a mapping with a migration entry here, c=
an
this cause a double-counting issue during concurrent mlock() calls?

If mlock_pte_range() encounters this migration entry midway through a PMD
range, it sets walk->action =3D ACTION_AGAIN and returns 0:

mm/mlock.c:mlock_pte_range() {
	...
	for (pte =3D start_pte; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
		ptent =3D ptep_get(pte);
		if (!pte_present(ptent)) {
			if (unlikely((vma->vm_flags & VM_LOCKED) &&
			    !compaction_allow_unevictable() &&
			    softleaf_is_migration(softleaf_from_pte(ptent)))) {
				pte_unmap_unlock(start_pte, ptl);
				migration_entry_wait(vma->vm_mm, pmd, addr);
				walk->action =3D ACTION_AGAIN;
				return 0;
			}
			continue;
		}
		...
		if (vma->vm_flags & VM_LOCKED)
			mlock_folio(folio);
	...
}

Because the page walker handles ACTION_AGAIN by restarting from the beginni=
ng
of the PMD without advancing addr, will the folios processed earlier in this
PMD be processed again?

Could this cause mlock_folio() to artificially inflate their mlock_count for
each duplicate pass, permanently stranding the memory in the unevictable LR=
U?

>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707125925.3725=
177-1-chenwandun1@gmail.com?part=3D3
