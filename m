Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C441A779;
	Tue,  7 Jul 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430018; cv=none; b=qCK7LYciLZ9NEcue7m72AhRkPe8LevOWk1MoIWuxbzZKq0as8JDfj1lNj/LKLMKqstlRmyIw7HqXtGY3KWakVPzpFi53QvyXqAuJLSP4QJw4i3h/FBPkxI77DQFmrDCdNay1l9UrrW54j1xZHaOPDO2a6cfyjTm3sSc98KiK+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430018; c=relaxed/simple;
	bh=RGLceidLdGHnhIx3dtxS9QxpMFWAZWDH9JKP3dpCEgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uuWx53EabJfuQ24I1BouIuNL9tQHLCK09aIzy0MJl+5V3mN84aDqJjRmPON+CwvBHExh7fVTKFdupJ7Ey1aDpyFj9LzZqmVkUYm+8mlYzhDGUdtqoHoscL/186E3naGFcIAavRxkqtOnjOMr8zEX9/OgkJu76quPqqOoppZdIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lag9yjf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lag9yjf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41F11F000E9;
	Tue,  7 Jul 2026 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430017;
	bh=6muumCir5HKrQsLG/ih5q2KofcU3XiVZyikq7D4KocQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lag9yjf4gcVrDLIN2Ajk79bWNRL0Bg8yZ13X0nHCHpg+ghM5HDrJRiKReRQ3wYE3W
	 P5hzIaNfEp9dhK+GLAnUh62MCiPI0HvlHjT29mNwlCsi0KGZQzZhnWoE3SCCYYE7Ml
	 +fDrZXS8w4pMU4x2TpKybqOvpfWEH1FNkQ26mlmYGLEEsR0aR5AduUh5tfppqyaqUe
	 YkeH7Ppqgi7KTmlAnCQDGX4myIK5wXUpZh2z8pEldGNTCaVYABbtT2JN6m409XMZCx
	 Wgir4YN+B7qVLwVEnH86OZMeSRWNBsK0XiD4fCVpZDIpjjgrPzcY2TZ82IbXjp4M8w
	 jPHLgtp2GAWig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when
 mlocking a range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wandun Chen" <chenwandun1@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260707125925.3725177-5-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:13:36 +0000
Message-Id: <20260707131336.D41F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] The `is_migrate_cma_page` condition is inverted in the PTE loop, i=
solating non-CMA pages instead of CMA pages.
- [High] Setting `ACTION_AGAIN` on `pte_offset_map_lock()` failure creates =
an infinite loop.
- [High] Folios are isolated and added to a list without elevating their re=
fcount, causing Use-After-Free.
- [High] Recursive `mmap_read_lock` acquisition creates an ABBA self-deadlo=
ck risk.
- [High] Locking order inversion between `pte_unmap` and `spin_unlock` caus=
es a Use-After-Free of the spinlock.
- [Medium] Unbounded folio isolation aggregates too many pages off the LRU,=
 leading to resource exhaustion.
--

--- Patch [4]: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mloc=
king a range ---
commit 95a15b2b2b9bbf36b5f4e3a9dd716ec837e02900
Author: Wandun Chen <chenwandun@lixiang.com>
mm/mlock: migrate folios out of CMA when mlocking a range

This commit attempts to reduce latency spikes on RT kernels by migrating
CMA pages out of mlocked regions during the mlock setup path. It introduces
a page walker to collect migratable CMA pages and migrates them using
migrate_pages().

Link: https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=3DO9hbVeqricDjZ=
t8_pnN7a-kBQ@mail.gmail.com/#t

> diff --git a/mm/mlock.c b/mm/mlock.c
> index ac65de40b22b9..f56c685533f55 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
[ ... ]
> +static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long =
addr,
> +			unsigned long end, struct mm_walk *walk)
> +{
[ ... ]
> +	ptl =3D pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
[ ... ]
> +		folio =3D pmd_folio(*pmd);
> +		if (folio_is_zone_device(folio))
> +			goto out;
> +		if (is_migrate_cma_page(&folio->page))
> +			isolate_folio_to_list(folio, folio_list);

[Severity: High]
Does this code risk a Use-After-Free on the folio? In the PMD path of
mlock_collect_migratable_pte_range(), isolate_folio_to_list() is called
without first obtaining a reference via folio_get(). Once the page table lo=
ck
is dropped at the end of the function, a concurrent thread could unmap the
region, dropping the mapcount and freeing the folio while it is still on
folio_list. When migrate_pages() iterates over the list later, it might
access freed memory.

> +		goto out;
> +	}
> +
> +	start_pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	if (!start_pte) {
> +		walk->action =3D ACTION_AGAIN;
> +		return 0;
> +	}

[Severity: High]
Could this create an infinite loop? When pte_offset_map_lock() returns NULL,
which happens non-transiently for migration entries or empty PMDs, setting
ACTION_AGAIN unconditionally tells the page walker to retry the exact same
PMD forever. This could hang the kernel thread if mlock() races with another
operation that installs migration entries or zaps the PMD.

> +
> +	for (pte =3D start_pte; addr !=3D end; pte +=3D step, addr +=3D step * =
PAGE_SIZE) {
[ ... ]
> +		folio =3D vm_normal_folio(vma, addr, ptent);
> +		if (!folio || folio_is_zone_device(folio))
> +			continue;
> +		step =3D folio_mlock_step(folio, pte, addr, end);
> +		if (is_migrate_cma_page(&folio->page))
> +			continue;
> +		isolate_folio_to_list(folio, folio_list);

[Severity: High]
Is the logic inverted here? The condition causes CMA pages to be skipped
while erroneously isolating non-CMA pages for migration. Any mlock() call
touching regular memory might isolate and migrate those pages unnecessarily,
while skipping the CMA pages this patch was intended to target.

[Severity: High]
Can this lead to a Use-After-Free? Just like in the PMD path, the folio here
is isolated without a preceding folio_get() to ensure it survives outside t=
he
page table lock.

> +	}
> +	pte_unmap(start_pte);
> +out:
> +	spin_unlock(ptl);

[Severity: High]
Is there a lock ordering inversion here? Calling pte_unmap() drops the RCU
read lock, which means the page table page could immediately be freed by
concurrent teardown like tlb_remove_table_rcu(). The subsequent
spin_unlock(ptl) might then access the spinlock residing within the freed
page table page on architectures with split PMD/PTE locks.

> +	cond_resched();
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops mlock_collect_migratable_ops =3D {
> +	.pmd_entry	=3D mlock_collect_migratable_pte_range,
> +	.walk_lock	=3D PGWALK_RDLOCK,
> +};
> +
> +static void mlock_migrate_cma_range(unsigned long start, unsigned long l=
en)
> +{
[ ... ]
> +	if (mmap_read_lock_killable(mm))
> +		goto out;
> +
> +	walk_page_range(mm, start, end, &mlock_collect_migratable_ops,
> +			&folio_list);

[Severity: High]
Does this introduce a recursive mmap_read_lock acquisition that could result
in a deadlock? mlock_migrate_cma_range() explicitly acquires the
mmap_read_lock. It then calls walk_page_range() using the
mlock_collect_migratable_ops, which specifies PGWALK_RDLOCK. The walker will
internally attempt to acquire the mmap_read_lock again. If a concurrent
writer attempts to acquire mmap_write_lock between these two read-lock
acquisitions, it will block waiting for the first read lock to be released,
and the second read lock will block waiting for the writer, creating an ABBA
self-deadlock.

[Severity: Medium]
Is it safe to accumulate an unbounded number of folios into a single list
during this page walk? For example, mlockall() invokes this for the entire
TASK_SIZE range. Millions of folios could be isolated into folio_list,
removing them from the LRU and hiding them from memory reclaim, potentially
leading to soft lockups or OOM situations.

> +	mmap_read_unlock(mm);
> +
> +	if (list_empty(&folio_list))
> +		goto out;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707125925.3725=
177-1-chenwandun1@gmail.com?part=3D4
