Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A747DF88;
	Thu,  2 Jul 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995303; cv=none; b=Jl29ccKhDElX3ue/3kny0AvsfRXUwk39jD/GpYa0zzziP9Y0H8xnthE5KyLLRYDzlmamAxbyX2JrHmS1BPsjFkbm8qbrUaM7DHy0F811xYsJKhvTzn1bJGzyiUayxcnOACfKHHqhWpVBhcWWI/ZZVd8iJFAvsCz5T7cZBvSNSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995303; c=relaxed/simple;
	bh=KCpRa4CyCN4XF10a4aBVFr6IqtEwHteXO/0kw11Kark=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jl69c7KD/47cwQfhlBpj7zRv4r0865yC/ie8NauMVZKjxSv3iy05UQ4XDB+nJDktpZmvIFNYj/g5/qLDEQBoj1ZhEyLybCK9PYQfJYoHwmp8tEsRi8qeoP0fypDaLKPzd8+L47Mve9/2WP7geLgHjtKFUwuuyyDCTszLRHM3cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipz0sVX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipz0sVX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562721F00A3A;
	Thu,  2 Jul 2026 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782995302;
	bh=KCpRa4CyCN4XF10a4aBVFr6IqtEwHteXO/0kw11Kark=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipz0sVX7xPIEFGse5k7UKMjxhs/rfhC6bwqHsQmYZQPBFRHstjRr+jjX/Cn6yuwpG
	 kUb/NJIeek6LKgJ25IAFx0C8bkG+F6Lh2eFhZOc7ixARNKXeomsoX+vgfyG9fFsDb1
	 3uy//sVtCB1dJYHSvK9JltQqd1mp9h3hmm/5QPscf0BdupxDKgvL5oyNbBq4MEVl9g
	 kq81VZZ2Ebhb39R4DTacT32HrQKtPsg17SGE7iVUxEXtOAKD2nsip8urC6ywMPPuU3
	 mYwpGZt6q/yFZdz4q2uCWRiBZEO/2KktzbhR1cDgIHRI2UvO6iDkdZzg82afQSt0OO
	 pXLHI9tUBcd1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/18] mm: factor out can_spin_trylock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:28:21 +0000
Message-Id: <20260702122822.562721F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The refactoring to deduplicate spin_trylock safety checks into can=
_spin_trylock() missed __free_frozen_pages(), leaving a pre-existing UP NMI=
 corruption bug unpatched.
--

Note: The format of this report has been altered to provide a free-form
summary of the findings due to recitation restrictions.

commit a99a7a468132ab177e1233c7e2f5644523ace0a7
Author: Brendan Jackman <jackmanb@google.com>
Subject: mm: factor out can_spin_trylock()

This commit introduces can_spin_trylock() to deduplicate checks for whether=
=20
the current context is safe for spin_trylock(). It updates=20
alloc_nolock_allowed() in mm/page_alloc.c and __kmalloc_nolock_noprof() in=
=20
mm/slub.c to use this newly factored helper.

Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@kern=
el.org/

[Severity: High]

This isn't a bug introduced by this patch, but the deduplication refactorin=
g=20
appears to have missed an open-coded check in __free_frozen_pages() in=20
mm/page_alloc.c.=20

Could this open-coded check also be updated to use the new=20
can_spin_trylock() helper to resolve a pre-existing UP NMI safety issue?

When __free_frozen_pages() handles FPI_TRYLOCK, it explicitly checks for
CONFIG_PREEMPT_RT and NMI/hardirq context. On UP systems where CONFIG_SMP=20
is disabled, spin_trylock() and its variants are defined to unconditionally=
=20
succeed because there is no actual lock state tracked.

If a caller invokes free_pages_nolock() from an NMI context on a UP system,=
=20
the current RT-specific check fails. The execution then falls back to=20
free_one_page(), where spin_trylock_irqsave() falsely succeeds even if the=
=20
NMI interrupted another task that was actively modifying the free list unde=
r=20
the zone lock.=20

This allows concurrent modification of the free list, which can lead to=20
corruption and kernel panics.

Updating the check in __free_frozen_pages() to use !can_spin_trylock()=20
would catch the UP NMI case and safely route the allocation to the lockless=
=20
add_page_to_zone_llist() path instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-alloc-tryl=
ock-v4-0-0af8ff387e80@google.com?part=3D18
