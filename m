Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5F7404E;
	Tue, 30 Jun 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827577; cv=none; b=f7H8S6ugSgQGCFDrPJpIq/qNffstJW/FWMGU6XHQQTsI3zniV3nlTznZz448ls2+8qcDd5IytmIBI8mI3rsbQgMYm7n8rbxcB2/+BPgBMrM2gynMDwJmQPr2EWoY5ofUynz1IRNfEJn8Mh8DHZ78a2aCZeH24InxUyei50Iv74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827577; c=relaxed/simple;
	bh=rJ9Rjx2oxCe13upyd34kkQk5EfFLNjaZEIfhLMJe8gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNCR4Ss6nEfdQcnK9vYyDCRt4P/AhtZhwHvcaPju+kMoKnINMKmfdaQC9ojM3y2pKKbS3VCx/z0UzoM8SlWhDQkGu5n8IItbFZOfdL6uR2h2XEWs+vZejQw2Danc2wdDeJ63TGc6Th1NFAeN04WkpSAgMHkP2fTEczFxcv7uEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltadpJyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltadpJyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEFD1F000E9;
	Tue, 30 Jun 2026 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827576;
	bh=rJ9Rjx2oxCe13upyd34kkQk5EfFLNjaZEIfhLMJe8gA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ltadpJyYu3rwXi5ugStfrcSEp69FAPdq2VEPHGQLdp+7ipYYrNM64wgZZk/nP7E/v
	 E3zu/crrDTc+8seyxMUwHPiBvZBVuEPNL0/UgjaCS6j5EuEtKJi+OEoH/WVZWKEkSm
	 vHqW4uwZirUe2XYDp+UMVQWhyQGS1A/kLpwIK9/SxAsZ92QqPha8wgsTsW9B/dAwqr
	 w4Ta0nxQ5QAvYUNnCizawK4dhMaMs5vbcepg2cSuySREG11W33O+2DAXAZs2R2eEnV
	 st9V2Wbs7ALSqouXeWerL6U9NzKDM9DxyFhHRTGGmD4+G9gdXxqZBRLOdLvmRD7uHc
	 1XbpqjMtKJFaw==
Message-ID: <06739dfc-8a30-4361-a8f6-6e81c99f2ea0@kernel.org>
Date: Tue, 30 Jun 2026 22:52:46 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] mm/page_alloc: relax GFP WARN in nolock allocs
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
 <20260629-alloc-trylock-v3-6-57bef0eadbc2@google.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260629-alloc-trylock-v3-6-57bef0eadbc2@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------65nHck7GCYTvNegZbzJ7HuGa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------65nHck7GCYTvNegZbzJ7HuGa
Content-Type: multipart/mixed; boundary="------------DCICTPcniII3mGZVq7GuAR9T";
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
Message-ID: <06739dfc-8a30-4361-a8f6-6e81c99f2ea0@kernel.org>
Subject: Re: [PATCH v3 06/16] mm/page_alloc: relax GFP WARN in nolock allocs
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-6-57bef0eadbc2@google.com>
In-Reply-To: <20260629-alloc-trylock-v3-6-57bef0eadbc2@google.com>

--------------DCICTPcniII3mGZVq7GuAR9T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/29/26 10:11 PM, Brendan Jackman wrote:
> This WARN forbids setting other flags than __GFP_ACCOUNT but we
> unconditionally set the ones in gfp_nolock so they are certainly fine
> for the caller to set.
>=20
> There are other GFP flags that are almost certainly fine to set here;
> Willy noted GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE and GFP_HARDWALL. But,
> nolock allocation is rather special, so be conservative to try and
> ensure we have a chance to think carefully before nontrivial new
> usecases arise.
>=20
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Link: https://lore.kernel.org/linux-mm/ajS96fWbG4dzP3u3@casper.infradea=
d.org/
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------DCICTPcniII3mGZVq7GuAR9T--

--------------65nHck7GCYTvNegZbzJ7HuGa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCakPKLgAKCRCGXBN6rc5S
1sd2AP99B6lM/xRZNKq6HnXzak/9iQUkPa0fEXXgFpsu4yrecQD/XhpasXq5hRP3
/+MYghKl+3c5wsQObsmWJNub2XvDtQM=
=+zJI
-----END PGP SIGNATURE-----

--------------65nHck7GCYTvNegZbzJ7HuGa--
