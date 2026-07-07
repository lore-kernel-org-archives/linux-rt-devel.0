Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36A342C98;
	Tue,  7 Jul 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430035; cv=none; b=R5AJGfgPrWVH98cGYavEHc7Vj7LfRHP2tm12DxzVUbyOiAc4YKayuOzzOhXsrV32ahfZ5fQ/UjtgEb3izHQ+O3Kzn323TSdSqh/KIteJCk9Uv3tCi3SwHTELpOz/xdcRVosS2hyjD9Nss+oxEUQedhc3OaCQNRvc9yy9kq/CNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430035; c=relaxed/simple;
	bh=xAitH3aDXWLDaWqM7529xc1Ltiri5rQm73CYNN8av/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gj7Mvq9K1basxHz0c9qXFPiMRiB+SUv5916Y51oHnU+TRO6YlA+XTyipI5Kex64uPO+Pcvt06+SiOn4tY4eBpziQkjlvrNqQuY9lxNfJ7jUTDNFQy3j1g2j7wm0MiUydAhNGX3v252EnTUR2h31pRRcQpLROdsddBSL2p3Bm8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpIN40ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpIN40ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104F51F000E9;
	Tue,  7 Jul 2026 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430034;
	bh=Ix9CbG2GPnAg4U4Au+Oze43UDOHHE6aJAcxecH5uhqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpIN40uru1w40r8iZv0BmsrPaf1JtA3Y8udlrVn04gyRQr1EnAvmvdqhV6l+wBWUY
	 wy57TyEy1aI+1YqKBB5f5BNR5csP8eVSqYds8/K37egHXy8YwsE9SeO22hZpAu0YUi
	 U4LPfuC4kCKQO5eUrRNz+JDP1/R9zertlfLzyZCalw+v2TNnJPiEqNDyVlSeEBFQce
	 oM43KZ5H0r7EPSPuzsksNiZ/FbfUzzl5+dhbAABGCpufSddV3GJVAQVaa2waNcjNjf
	 SxcyZ+Ec7ncZU2f9KV+Mj669ywyXFQ2U/85avoDFQIsitdy4sqNtmCiDP+8LlbAc4A
	 E1Grj87NmPAUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] mm/mlock: wait for migration to finish when
 mlocking a folio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wandun Chen" <chenwandun1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260707125925.3725177-3-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-3-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:13:52 +0000
Message-Id: <20260707131353.104F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning ACTION_AGAIN from the PTE loop causes double-counting of=
 folio mlock_count, permanently stranding folios on the unevictable list.
--

--- Patch [2]: [PATCH v2 2/4] mm/mlock: wait for migration to finish when m=
locking a folio ---
commit 5e064939ab68367720d5bb81c64aebdb067992b6
Author: Wandun Chen <chenwandun@lixiang.com>

mm/mlock: wait for migration to finish when mlocking a folio

This commit modifies mlock to wait for migration entries when
compaction_allow_unevictable is false. This prevents spike latency in
RT kernels caused by page faults waiting on migration after mlocking.

Link: https://lore.kernel.org/lkml/c8793c0f-7156-4cb7-9e6e-7909397e2fff@ker=
nel.org/#t

> diff --git a/mm/mlock.c b/mm/mlock.c
> index 97e49038d8d33..ac65de40b22b9 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c

[ ... ]

> @@ -383,8 +393,17 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long=
 addr,
> =20
>  	for (pte =3D start_pte; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
>  		ptent =3D ptep_get(pte);
> -		if (!pte_present(ptent))
> +		if (!pte_present(ptent)) {
> +			if (unlikely((vma->vm_flags & VM_LOCKED) &&
> +			    !compaction_allow_unevictable() &&
> +			    softleaf_is_migration(softleaf_from_pte(ptent)))) {
> +				pte_unmap_unlock(start_pte, ptl);
> +				migration_entry_wait(vma->vm_mm, pmd, addr);
> +				walk->action =3D ACTION_AGAIN;
> +				return 0;

[Severity: High]
Does returning ACTION_AGAIN from within the PTE loop cause mlock_count to be
inflated for previously processed PTEs?

If the loop processes some present PTEs (calling mlock_folio() on them) and
then encounters a migration entry, it returns ACTION_AGAIN. This causes the
generic page table walker to restart the callback from the original PMD sta=
rt
address:

mm/pagewalk.c:walk_pmd_range() {
again:
	...
	if (ops->pmd_entry)
		err =3D ops->pmd_entry(pmd, addr, next, walk);
	if (err)
		break;

	if (walk->action =3D=3D ACTION_AGAIN)
		goto again;
	...
}

Because addr was not advanced in walk_pmd_range(), mlock_pte_range() will
process the earlier PTEs a second time, incrementing folio->mlock_count aga=
in.
When the VMA is later unmapped, mlock_count will never reach zero, permanen=
tly
stranding these folios on the unevictable list and leaking memory.

> +			}
>  			continue;
> +		}
>  		folio =3D vm_normal_folio(vma, addr, ptent);
>  		if (!folio || folio_is_zone_device(folio))
>  			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707125925.3725=
177-1-chenwandun1@gmail.com?part=3D2
