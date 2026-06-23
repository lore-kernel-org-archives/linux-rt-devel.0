Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82360215075;
	Tue, 23 Jun 2026 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235745; cv=none; b=V2CsAv4VT/9fCw83b/EXegmc+bieu8gb+owjSZcN6CyxsyH9WUag9Y+Qb2v1wiYD0veM/DZxGMxsIBLzgTgUvLL9PP5QBHKnlIilN0VvvxWsVGQjpnveD1NQiQOcwPmiBAoUo1mEEDdkgYVpkyjLqiREqGGOeQhNVLLxbdqfPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235745; c=relaxed/simple;
	bh=H+C0bJGcZbIyJBT/vqqzsA6y0I7Z4LHjhRWlzS/mzmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc7B4UP9VstvM8kyL6klLRtxJHKIwOF329UL1hp1tiTAAw7M8YhZpIHbl86Prsl6wBVcEAXwbP6UfkguWvwNYut6y4g5JKB9r3vGLpuF8sQxuYED/ye4CbC3tFjhdSaem0u/0a4gR2nF6IQwCgfjdFggqYwVf/C29apba1BtXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+A9Dyhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+A9Dyhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ACC1F000E9;
	Tue, 23 Jun 2026 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782235744;
	bh=Wy+blSt5xdCwchobAX7ZrvH2NCFjXYGm/UFwJUwBnm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d+A9DyhiU0QEnMXLzKvsOFJugbfK+126pc5tl7z3mzF0WWFMGZCMZWr/JbfzVoi91
	 W4H+61ZYt6tKEUOgEWsQL8Sa41B1snb3BmYBIPp0xB5oOmyHOd28tFSptLQG3s6D8y
	 tDp6x9dj9FtSIrJsCujVxSvKwnTOwMFNlamej3AVOmJz9MLKWiwJAc7Y5xzOrIz20w
	 7i8lria7zrQccSkIL8TusUdr7xy2p3Y1iAxKklrDvSN8GBqzMdUz9UO5CBqXP2o/JX
	 hYXj+0TyrRzPXdnUiXxVXKWEax5CCeYrruxSK1fLEbZH+x3CTd9+NsgezxqerWlD3G
	 piWILdNijvcnA==
Date: Tue, 23 Jun 2026 18:28:53 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 11/13] alloc_tag: Move to mm/
Message-ID: <ajrA4wiAKTdiraEO@lucifer>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-11-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-alloc-trylock-v2-11-31f31367d420@google.com>

On Mon, Jun 22, 2026 at 10:01:38AM +0000, Brendan Jackman wrote:
> This is logically mm code. Moving to mm/ allows access to mm/internal.h
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Sorry to be a pain, but I feel that this change should be dealt with separately
perhaps as a pre-requisite to this series.

Thanks, Lorenzo

> ---
>  MAINTAINERS             | 2 +-
>  lib/Makefile            | 1 -
>  mm/Makefile             | 1 +
>  {lib => mm}/alloc_tag.c | 0
>  4 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65bd4328fe056..5d426b79b8fe7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16713,7 +16713,7 @@ S:	Maintained
>  F:	Documentation/mm/allocation-profiling.rst
>  F:	include/linux/alloc_tag.h
>  F:	include/linux/pgalloc_tag.h
> -F:	lib/alloc_tag.c
> +F:	mm/alloc_tag.c
>
>  MEMORY CONTROLLER DRIVERS
>  M:	Krzysztof Kozlowski <krzk@kernel.org>
> diff --git a/lib/Makefile b/lib/Makefile
> index f33a24bf1c19a..44f6538533a97 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -197,7 +197,6 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
>  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>
>  obj-$(CONFIG_CODE_TAGGING) += codetag.o
> -obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
>
>  lib-$(CONFIG_GENERIC_BUG) += bug.o
>
> diff --git a/mm/Makefile b/mm/Makefile
> index eff9f9e7e061c..4fc713867b9bd 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
>  obj-$(CONFIG_EXECMEM) += execmem.o
>  obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
>  obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) += tests/lazy_mmu_mode_kunit.o
> +obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
> diff --git a/lib/alloc_tag.c b/mm/alloc_tag.c
> similarity index 100%
> rename from lib/alloc_tag.c
> rename to mm/alloc_tag.c
>
> --
> 2.54.0
>
