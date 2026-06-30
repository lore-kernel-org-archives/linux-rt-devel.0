Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389EFBE1;
	Tue, 30 Jun 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826611; cv=none; b=f4GpnxycSNuvzP74uMgAvLVxFWgJuT3Qv9zmd9Lrwqd+eVP23oqrVVtaF7MBtYLu1w38HGLDpDGITplfM76wTpdWMrHTgqERlGhc6fHgLn99zid3eVp9u1avLiFFj915kHC9OGJvMzbT7/09UJY6T/2BvtjyB89kVbesCpcVj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826611; c=relaxed/simple;
	bh=z/u97Z5KiRTy2Bd5j0OxNnDZrGreVME2Th7Hp/iyURo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfpUoal/9uQ0QMcmyZAMDR1J7241HIOt95p4Hqltt5amwTDMfyYWC2aHhsezZtz3OUmTb2AgWR3pzn4GL9FZ811iT4NpFcp53odnYd5qJ9NYpQMMpIFLyBivexDP4ybSCWBCqOp7FEITDl0BHs1Z7lXLKVLDu4i90Yh72XsDRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsbIJ98J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsbIJ98J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847991F00A3A;
	Tue, 30 Jun 2026 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826609;
	bh=rZflGQJS3FWpjYu4dYWAWBhwPCYPbtF0UmvWSAM0HV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WsbIJ98JyveatiVMgaG89aeUfDpM5QH9T5IfgCTdbeBZWWjJLcqjmGQTpnSZuNBt6
	 98gvqjJXSHoA7Z0PHIQBt75wTs5WxfQwjL/deZMVY0Ndz8Li4IdqHVDbqDb/K51fHw
	 3ygxGtLWwwHLqpwBSEEKx+m8rKGdPLbZjpha6+Rhi6octO85ACSBx54qRKZq+bpXrJ
	 ee5o3nZS4G30BbSUtg1FZtmufOC9wnvMzwxfd4+fAPjTz+q2qfMmtXzKF3J/qC4jSI
	 GxtNV+esj9QUKKYStEl5geJnitBkLqjPnp29qjtc1tXEJTUiIKqW/sE8/LxVwfv2Yl
	 9fltdC5Udp1xw==
Message-ID: <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
Date: Tue, 30 Jun 2026 22:36:37 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DAJrgx3byH7JZ1FULOuCCYr3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DAJrgx3byH7JZ1FULOuCCYr3
Content-Type: multipart/mixed; boundary="------------m7KBxX00h08SRQw398FDtdbb";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Message-ID: <397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org>
Subject: Re: [PATCH v3 05/16] mm/page_alloc: unify
 __alloc_frozen_pages[_nolock]_noprof()
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>
In-Reply-To: <20260629-alloc-trylock-v3-5-57bef0eadbc2@google.com>

--------------m7KBxX00h08SRQw398FDtdbb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/29/26 10:11 PM, Brendan Jackman wrote:
> Currently the core allocator code is controlled by ALLOC_NOLOCK, but th=
e
> main entry point function is significantly different from the normal
> __alloc_frozen_pages_nolock(), this is tiring when reading the code.
>=20
> Plumb the ALLOC_NOLOCK control one layer up in the call stack: create
> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is only=

> exposed to mm/) and then turn the nolock variant into a thin wrapper
> that just sets that flag (as well as handling NUMA_NO_NODE, similar to
> how some of the wrappers in gfp.h do).
>=20
> Rationale that this doesn't change anything:
>
> 1. Simple bits: A bunch of the nolock-specific handling is just moved t=
o
>    the new alloc_order_allowed(), alloc_trylock_allowed() and
>    gfp_trylock.

Right.

> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
>    previously in the nolock variant:
>=20
>    a. Application of gfp_allowed_mask; this only affects early boot, an=
d
>       only flags that affect the slowpath get changed here.

gfp_allowed_mask clears __GFP_RECLAIM, and that means now allocations
with GFP_KERNEL during early boot would see
gfpflags_allow_spinning() =3D false.

The helper is not used in in the page allocator, but used in
memcg/stackdepot/page_owner.

>    b. Application of current_gfp_context() - also only affects the
>       slowpath

PF_MEMALLOC_PIN affects the fast path, but ALLOC_NOLOCK users
won't be affected.

What about alloc_flags_nofragment/nonblocking()?

> 3. The slowpath itself: this is now just explicitly skipped under
>    !ALLOC_TRYLOCK.

Right.

> Ulterior motive: adding an alloc_flags arg to the allocator's
> mm-internal entrypoint can later be used to do more allocation
> customisation without needing to create new GFP flags.
>=20
> While adding this flag to a bunch of places, create ALLOC_DEFAULT to
> avoid a mysterious literal 0 in most places.
>
> alloc_frozen_pages_noprof() is defined above the alloc flags

The function is defined below the alloc flags, no?

> so just leave that as a slightly messy
> exception instead of trying to fully reorder mm/internal.h for that one=

> case.
>=20
> No functional change intended.
>=20
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/hugetlb.c    |   3 +-
>  mm/mempolicy.c  |  10 ++--
>  mm/page_alloc.c | 178 +++++++++++++++++++++++++++++-------------------=
--------
>  mm/page_alloc.h |   6 +-
>  mm/slub.c       |   6 +-
>  5 files changed, 108 insertions(+), 95 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a3ba63c7f9199..8d409d075e3e9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5271,24 +5271,98 @@ void free_pages_bulk(struct page **page_array, =
unsigned long nr_pages)
>  	}
>  }
> =20
> +static inline bool alloc_trylock_allowed(void)
> +{
> +	/*
> +	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
> +	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the curre=
nt
> +	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() wi=
ll
> +	 * mark the task as the owner of another rt_spin_lock which will
> +	 * confuse PI logic, so return immediately if called from hard IRQ or=

> +	 * NMI.
> +	 *
> +	 * Note, irqs_disabled() case is ok. This function can be called
> +	 * from raw_spin_lock_irqsave region.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		return false;
> +
> +	/* On UP, spin_trylock() always succeeds even when it is locked */
> +	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> +		return false;

Except for deferred_pages_enabled(), it's not specific to the page
allocator. SLUB has

	/*
	 * See the comment for the same check in
	 * alloc_frozen_pages_nolock_noprof()
	 */

=2E.. and repeats the same thing as above.

Perhaps let's factor it out into a helper
rather than trying not to forget to update the other place?

> +	/* Bailout, since _deferred_grow_zone() needs to take a lock */
> +	if (deferred_pages_enabled())
> +		return false;
> +
> +	return true;
> +}


--=20
Cheers,
Harry / Hyeonggon

--------------m7KBxX00h08SRQw398FDtdbb--

--------------DAJrgx3byH7JZ1FULOuCCYr3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakPGZQAKCRCGXBN6rc5S
1uM9AP0b8nxpK1UPhYD74o0aXVmWCANPMI2Kt4IVvWBfqhL29QEAsz2kewM/Jeko
rpsZ1Z3pZrepKYfV19kO4xwfYc2Q/wU=
=fiVY
-----END PGP SIGNATURE-----

--------------DAJrgx3byH7JZ1FULOuCCYr3--
