Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159F37EFEF
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079029; cv=none; b=iH54+mksBv5kMKRy4fru2ILhSAZE0j9OdDI1eDCcJxTR4O2AcQPDsLca5BuGWdx3oO5rhhEuA7hhA+Sr+tQz7nIvA9/t4nkVFEHTvhXxPpxh4FvzDwz35MH30cUHjo7IR4FgRyVLy+eMkd2DRsZS9xmEVGDdxe1Zdfe8vO/OQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079029; c=relaxed/simple;
	bh=VSetS396SrH76litqhz6V0tLsyOUbEp17iVMUlqbZ0A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EaQhCKV64JIYLSBHR75xfK78ww9IaLeqlcGq/iSs45UHKsz0gzCIG12R0/GFvETgsgoF7qyt8YwDHohlhgzAiMl0BWHqyZKx1S2zuwBXDr4U46uGQfGE7iktd8MjSCLhvQ3UpNCGQsD0+WB9WAotX/ce8Z21wAGdI1Y0l5EqWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=axBe2JTE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="axBe2JTE"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783079024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSetS396SrH76litqhz6V0tLsyOUbEp17iVMUlqbZ0A=;
	b=axBe2JTE4wy9jYDVh/aDcxlWFqplgDs/zl2EfbLtmG9mqQTYZV5rPg/mysAbrTIYroHQun
	imD73iN1OFVJuv2JTbrfrEOVOfWxT3+/GG9kaJQRW5kMdQ8aqP0fGcDHhwBu9Ypv9V+6iW
	7YqnlKUsRosMN4yi746SiqKn2nh99fI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 11:43:39 +0000
Message-Id: <DJOWRDASVUUV.376L8DP13F1XQ@linux.dev>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>
Subject: Re: [PATCH v4 18/18] mm: factor out can_spin_trylock()
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
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
 <1e162a97-1594-495d-b48e-7dafaa0a6d82@kernel.org>
In-Reply-To: <1e162a97-1594-495d-b48e-7dafaa0a6d82@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri Jul 3, 2026 at 9:32 AM UTC, Vlastimil Babka (SUSE) wrote:
> On 7/2/26 11:49, Brendan Jackman wrote:
>> Deduplicate checks for whether the current context is safe for
>> spin_trylock().
>>=20
>> Does this function really belong in mm/internal.h or is it generic? Not
>> sure. If someone ends up duplicating this logic elsewhere in the kernel,
>> that would be a shame. But goes in some generic header, someone treats
>> it as documentation about where it's guaranteed safe to spin_trylock(),
>> and then it emerges that there are other subtle preconditions that
>> didn't affect the mm usecase, that would be worse. So, just be
>> conservative and keep it local.
>
> Agreed. We could even use page_alloc.h ?

Would be nice to shrink the scope but I think it would be "wrong" for
slub.c to get it from there. It's not to do with the page allocator.
