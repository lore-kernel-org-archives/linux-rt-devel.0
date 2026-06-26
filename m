Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778043E6DEC;
	Fri, 26 Jun 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464485; cv=none; b=B0hj9bFVYUuGamAXTj5Gek2GjmOqI0Sc4g6fWkiRhezevLF4A7rgAPsvNRYeoUWgzWtdDxmjlWZe3dddVjpY0HLPpXj59y2BnCMPMqDFydAlwcdKcfPv6dhQ0BkzpJA2+dhYxbdZlhXC4MhOD3pc93GxFLDzLfZeZdj7vnV74b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464485; c=relaxed/simple;
	bh=oljwZFEHyQbS4dJbZnrrRQZYBmFAfUoVQ0TPQ0VSX5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUUQrd4/uimPBZvbh4wmrWa7XRjetJveI22XEjAZnqtEB04OEXdgKH1T54n2W/fsfUZELSCBy3cm10MHASY2GLCM7p4NkmGHOd7rTuOSR0gFapozqxHdGIdbHAh1oeRdqWNoqJd918I+kWIHOV9E5gE2h88aK9n79YhVkLRo9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhrDWg3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhrDWg3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98501F000E9;
	Fri, 26 Jun 2026 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782464482;
	bh=oljwZFEHyQbS4dJbZnrrRQZYBmFAfUoVQ0TPQ0VSX5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KhrDWg3IRbYGeQXE8WE2dG1VgG5rq13frn5oMFczMwZ8bAB0zZ/OLITmYPJkLGyrq
	 9Kat7cxtdTdaL2fT4yGxBSN3RxTcxQlLXsZM2EwYnPvqRTvXmXX+37TpXQmZ5K5b11
	 p9kT/J+vtWRvGfsha0agfpDCLf6Np9k4Z4uEGf4kv/qN0sCOeGAJNXQIAwGukefLfn
	 lCzajdw/0rMK/wmhNKgNoC7RwieOB3da+MMJ5gxO0lpTr6K+GfUe9y5ainEOzkpIn9
	 JLdO4jiQPzi1u2TzznmE5i7CiH4jxlvisl9pMr3r/pfaFpSU3hY93Oak4b58j3XzwO
	 nIenQfDkYvt+g==
Message-ID: <47711372-fe2e-4072-8b23-cf3fa09eb201@kernel.org>
Date: Fri, 26 Jun 2026 18:01:06 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] mm/page_alloc: rename ALLOC_TRYLOCK ->
 ALLOC_NOLOCK
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
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-1-31f31367d420@google.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260622-alloc-trylock-v2-1-31f31367d420@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1TM52njjKfSDr01RWPlc5SOq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1TM52njjKfSDr01RWPlc5SOq
Content-Type: multipart/mixed; boundary="------------XDSSJxToBp7oeVvqN0zGo8UF";
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
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Message-ID: <47711372-fe2e-4072-8b23-cf3fa09eb201@kernel.org>
Subject: Re: [PATCH v2 01/13] mm/page_alloc: rename ALLOC_TRYLOCK ->
 ALLOC_NOLOCK
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-1-31f31367d420@google.com>
In-Reply-To: <20260622-alloc-trylock-v2-1-31f31367d420@google.com>

--------------XDSSJxToBp7oeVvqN0zGo8UF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/22/26 7:01 PM, Brendan Jackman wrote:
> It's confusing that the function is called "nolock" but the flag is
> called "trylock", align them.
>=20
> The function's terminology is more visible and has more mindshare so us=
e that.
>=20
> Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> Link: https://lore.kernel.org/linux-mm/2399b3ad-4eac-4a14-94c3-27e9f079=
72a1@kernel.org/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------XDSSJxToBp7oeVvqN0zGo8UF--

--------------1TM52njjKfSDr01RWPlc5SOq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4/0gAKCRCGXBN6rc5S
1gyOAP96IylFQ68CSoQPVkjZreEapB0lAuT4SaO71TRUd9IrEgEApOqW/shMrU18
8ZWxkyQmKqte3Fat2T/ICqmmF6okdQY=
=Etyv
-----END PGP SIGNATURE-----

--------------1TM52njjKfSDr01RWPlc5SOq--
