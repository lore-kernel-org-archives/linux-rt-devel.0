Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9F35CB61;
	Fri,  3 Jul 2026 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071546; cv=none; b=R8/a5WJ2VLdHthIsss8yGVszndfl+wNlN3pYf8h+9Jl8V4KrTUSTlHcgRNisIux7C0MBMvN3ZEOQrzAHSzRZ9gFo8zUQfaYMDhv+eyNhbPkJOFVYk5uOgkPMdjsuvwLMIO5r36dHKVsEQFrAy3q4GW380bumGsnY/87PP5mrmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071546; c=relaxed/simple;
	bh=/jgWAf5SwPzlqhJKQG2/7AalkDHZJDG2niv0fSajwEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvJM59Vq5xbidenT3joFU95UUwnw8KUr5wUfG+0RQyRUTrOgeqlRm/s4wtBLpi1OLOC/q94aqkBlavbC1u87Hzs2Sabf+hXO7Zg3qmf7vKbN+DXQFFoVCvLvdgAIXHKQc7UcEq6nPOFF9qZXX4YZ4U8BB87pXNiyv+5yV2GUuao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIdjRc2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIdjRc2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FAB1F000E9;
	Fri,  3 Jul 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071545;
	bh=/jgWAf5SwPzlqhJKQG2/7AalkDHZJDG2niv0fSajwEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IIdjRc2Ff/MhGB0w5/vA6UjULptWQXsppua/eAUQJfQd5NdXeRV+p01OWY8Bt3MPx
	 4cCwYAFNdOfbaGdRUnh8JC/PEGaL921tNnsYvSZayZ03ymB3aeVliby82ll+FWzCaQ
	 SIsx2dDAR0T1X9mG4D83sJAUOi+NrbIxNf5WZxypCZ98bPyoxgMMd50YEOi7wKPZTQ
	 u7Q9/JcQ+aC7Aao4EcS84uEFUJCKZOucloXKmc1GFudydK99rNNkqs6AH6O1LYyaqq
	 8ssYDoFNn58jqKcwT3gORSPDYeyUS9bqj8DnoMb93ezoxbBc77dlKC0CeNbveMZYb2
	 A36yiTH0mN0NA==
Message-ID: <21ec3b5e-8e8a-4f8c-aad9-ff9b77bd6d6e@kernel.org>
Date: Fri, 3 Jul 2026 18:38:39 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] mm: factor out can_spin_trylock()
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
 linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com,
 Yosry Ahmed <yosry@kernel.org>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hFDyml7LY0WmvWczM3Ou39Mo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hFDyml7LY0WmvWczM3Ou39Mo
Content-Type: multipart/mixed; boundary="------------EMNg7VfEL9bzN6yUIrxUi2BK";
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
 linux-rt-devel@lists.linux.dev, derkling@google.com, reijiw@google.com,
 Yosry Ahmed <yosry@kernel.org>
Message-ID: <21ec3b5e-8e8a-4f8c-aad9-ff9b77bd6d6e@kernel.org>
Subject: Re: [PATCH v4 18/18] mm: factor out can_spin_trylock()
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
In-Reply-To: <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>

--------------EMNg7VfEL9bzN6yUIrxUi2BK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/2/26 6:49 PM, Brendan Jackman wrote:
> Deduplicate checks for whether the current context is safe for
> spin_trylock().
>=20
> Does this function really belong in mm/internal.h or is it generic? Not=

> sure. If someone ends up duplicating this logic elsewhere in the kernel=
,
> that would be a shame.

Wondering what BPF has been doing about it...

> But goes in some generic header, someone treats
> it as documentation about where it's guaranteed safe to spin_trylock(),=

> and then it emerges that there are other subtle preconditions that
> didn't affect the mm usecase, that would be worse. So, just be
> conservative and keep it local.

But yeah, agreed.

> Suggested-by: Harry Yoo <harry@kernel.org>
> Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@=
kernel.org/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks!

--=20
Cheers,
Harry / Hyeonggon

--------------EMNg7VfEL9bzN6yUIrxUi2BK--

--------------hFDyml7LY0WmvWczM3Ou39Mo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakeDHwAKCRCGXBN6rc5S
1qOoAP9X/oz3Te45ijX+oZqnExbf3F/cLVlMnCzGQzkprL5sGwD/VnLjX0AY95bV
/SjSfOk7aMvj/cla9N9FEs2kf6hCUQo=
=jFVY
-----END PGP SIGNATURE-----

--------------hFDyml7LY0WmvWczM3Ou39Mo--
