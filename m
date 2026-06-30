Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107D3DCDB8
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840328; cv=none; b=AdedpouQ36QT89qBEOmG5faTekgXxv3/hvSxSspxTuK4q883SA6Cn2ss61oD1Da+sNWhuHgR5gS0Isg9M76JLCaJNk9x8NJysDy3G6GEW4JqA2y6ZM2ErEjSlCDhpvtXZXUURKT/YglBanARVMJ/zxedt8H0rmnPgGdcQvpCAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840328; c=relaxed/simple;
	bh=ZlAySTkxz1oRSlkDzZABgBgr1Z2dH65iwyuqMthYEO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Xe0uiV7hpzZ8MYGLBPiFhRMgMctgOkXicfujuf2HHvF9QL6mTKJHCICfHFag6lQaBO/0zDmf6mI9oIrKKFfulangUVshyCmnuaYPMFIZN4BZ7kzHSc/yr9/wg8lR8kAMdkIf/RZ+zBxbeJ6ZnNsJBbyL0riKIXCM7sXWQhpenaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVp9o9E2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVp9o9E2"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782840324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwd17XGb6yIU1LeV9+8Zji359XnI8ZNwG9WGgGJkKVI=;
	b=YVp9o9E2KjDijUfWSjyzvp47sdVZJvQLpBipEG2C6qkqtzunfWsxXhw5ll3prEk7fOWGEK
	YkHVuIiNE/+fx/0o2fmyM5mcdUGIBsFimUMdh2kfx8yYnD6FLK61sJ2BRY1894iXr7DbjA
	/q/b0beFc+pfsOE924rAjPuJT19ykfI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 17:25:18 +0000
Message-Id: <DJMK5BJH77WY.2IYQ67ZBPU7QK@linux.dev>
Subject: Re: [PATCH v3 02/16] mm/page_alloc: some renames to clarify
 alloc_flags scopes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Brendan Jackman"
 <jackmanb@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-2-57bef0eadbc2@google.com>
 <5dcdd1ef-21ad-4ed0-9e8a-0e5cf96b4392@kernel.org>
In-Reply-To: <5dcdd1ef-21ad-4ed0-9e8a-0e5cf96b4392@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue Jun 30, 2026 at 12:38 PM UTC, Vlastimil Babka (SUSE) wrote:
> On 6/29/26 15:11, Brendan Jackman wrote:
>> It's pretty confusing that:
>>=20
>> - The slowpath and fastpath have a totally distinct set of alloc_flags.
>>=20
>> - gfp_to_alloc_flags() sounds generic but it only influences the
>>   slowpath.
>>=20
>> Rename some variables to highlight which alloc_flags are
>> fastpath-specific. Rename gfp_to_alloc_flags() to highlight that it's
>> slowpath-specific.
>>=20
>> gfp_to_alloc_flags_cma() and gfp_to_alloc_flags_nonblocking() currently
>> have perfectly harmless names, but to keep the naming consistent also
>> rename those to the alloc_flags_*() pattern (which already exists for
>> alloc_flags_nofragment()).
>
> How annoying that alloc_flags_nofragment() doesn't have gfp as the first
> parameter, unlike others.
> Oh well, must resist too much OCD :)
>
> Uh, more annoyingly, alloc_flags_cma() takes alloc_flags and returns
> augmented alloc flags, so there's stuff like
>
> *alloc_flags =3D alloc_flags_cma(gfp_mask, *alloc_flags);
>
> Since we're unifying, it could be make to work additively like others? Th=
en:
>
> *alloc_flags |=3D alloc_flags_cma(gfp_mask);

Sure, I can chuck this on as an extra patch.
