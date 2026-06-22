Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1173AFD0E;
	Mon, 22 Jun 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133527; cv=none; b=uzVNuKP5eMlmGlpzSMzn+cRoqy8CrYKcdVUEoAVqHaVTH+esjLujmc71IYSdoJW8++RWHEXGxstM2kY7XhkVw+IobYuaCLBHkheuqsqLMcM5l+tXG1iSjwfwWZIaD2vFZVJyFJzxwFoFCxUUGpvZn0qcM2otEQrmh/HXJ7eA8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133527; c=relaxed/simple;
	bh=ZJj9YhFK2hJVxnbdSePlWavyqkwkuwdYFPBjliCKcJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TguoLgu2VQbVqkYoamjqGhfBQk4NcdlKY6HQFKjmdszwnGgd9LPwMW54atpd1gKFcGvVUQgX3scho1ALb79VAHGXvNSDBpN/B6ki53v9Qm/mGHwEZOEBRAHAT9gHFsLawjB7aJKXWFGSLmmgycO/RPEAOLZdWlMUoN3ZoAQFVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMY1FrLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMY1FrLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5324E1F00A3A;
	Mon, 22 Jun 2026 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133526;
	bh=v1873G05ErtieljTAjknolTYLp1nP5on/cJgnqOtADc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cMY1FrLzFrM7ZR5e8zF2y0QbnlGoXq/XvqyrtrzKgrV7t6W7TVqu+tCkJ5xl4olXQ
	 IMsQaRk87J2tt64F8GIAUZT5yDz6mchMXPgJgTpkNHjiVSEk1Yl5wy7AzodOuR2u5Q
	 nXqykqd8DjXbnbFQN4ez4Cy/GZEE8Zp7JXFY7jwy9TycipjIIbKaymtCVpQpK48dth
	 shy0oW0PiEeuU3ISBnap/fU4lySKQncLTjKyVhZiW+4faB4s4bmbJmGGNmLDIwSWGc
	 y/DYJXwSttcRJa7sejEEOcyqtuuiovHK+7VxN8OWHZd5nZR1HZ9KBzsMOaavYjyi4E
	 jQ+Lurdxq92ZA==
Date: Mon, 22 Jun 2026 14:05:15 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 12/13] mm: Move __alloc_pages() to mm/internal.h
Message-ID: <ajky-U6rWpzY_Hsw@lucifer>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
 <41e92bab-6882-401a-8de9-154adbdcfb36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e92bab-6882-401a-8de9-154adbdcfb36@kernel.org>

On Mon, Jun 22, 2026 at 02:24:36PM +0200, David Hildenbrand (Arm) wrote:
> On 6/22/26 12:01, Brendan Jackman wrote:
> > It's no longer used outside of mm/.
> >
> > Since this means __alloc_pages_noprof() is no longer visible from gfp.h,
> > this also means moving the definition of alloc_pages_node_noprof into
> > the .c file.
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v1/cpusets.rst |  2 +-
> >  Documentation/admin-guide/mm/transhuge.rst      |  2 +-
> >  include/linux/gfp.h                             | 16 +---------------
> >  mm/internal.h                                   |  4 ++++
> >  mm/page_alloc.c                                 | 11 +++++++++++
> >  5 files changed, 18 insertions(+), 17 deletions(-)
>
> Do we want some mm/page_alloc.h , to start splitting up mm/internal.h

Yes please!

>
> --
> Cheers,
>
> David
