Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D863D9666;
	Wed, 24 Jun 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313875; cv=none; b=QHRy+Y5jb1yQ0vycGmPj+jgQzEL2J8lU9cgJuuhMu81mdiBVLtANuK4zCyJArDs5nfXLXn8xTmHzSPTn0QDCQYF+sfO34JviPWSoXHZEzcSod0aCQKhXVgHJ9WBAgkGl1QWm/I0KsUpS2gvDtJiTLabR5lDZqjrbFb6ueqA9TMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313875; c=relaxed/simple;
	bh=+WJfoGRd+NAOfw8c5h3qeDmnmfSaUjJK87qUlIYi3+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJhkA6YnLkuUVkyGIpXq4NA3M17alB/bXQU4tHQK53LkWS7oxklmQ0oxdGOd7dwwUUQLgIgh149NqpetiaETHru+DA+DvW5Zj6R5Zm4cz0EcXjhfOqURTX4863cnPmAu20jw7m07seXeqWSvCv4u0WHF7a9jB1RDh0wesig3PQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAgONeGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAgONeGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3904C1F000E9;
	Wed, 24 Jun 2026 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313874;
	bh=+WJfoGRd+NAOfw8c5h3qeDmnmfSaUjJK87qUlIYi3+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fAgONeGZaWn22E5+FjUE+WnnUF2s1EHj7SSaT1IWyGLrDVmmDBZTrScDLDdnpTLM8
	 BqXe1YZSsknnWhOhTTNs7kBK8/ovaC7Ro2k/GvmeSobEd6BBfPxPyQqD79jTtg5CXH
	 wQG54Yh0PExA7xH8tzX8MBGt4cfx8ZmZ1vpfnElBD1yV0IM9QxBAED/x7E/LTN0lMO
	 XUyFNhUqMrykFfDrJTSljiilpYZ1rLDcl2pQOktLE7OakpBA+t2ZjG6hs567lxhpXe
	 rQRnnNh2YLY+Xq6LWZebUWAFCjImA1dFIOi7pV+4L9h93ZE040cRNuKw5xIzf/g0IS
	 a2vFp+LHWpGdw==
Date: Wed, 24 Jun 2026 16:11:03 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Brendan Jackman <jackmanb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
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
Message-ID: <ajvzfXkKoCXAxg59@lucifer>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-11-31f31367d420@google.com>
 <ajrA4wiAKTdiraEO@lucifer>
 <CAJuCfpHqvLVnycuufO6Kf3S_RSFjyDRUnTGDyu3VW0kQ90tiHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHqvLVnycuufO6Kf3S_RSFjyDRUnTGDyu3VW0kQ90tiHQ@mail.gmail.com>

On Tue, Jun 23, 2026 at 04:48:04PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 23, 2026 at 10:29 AM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Mon, Jun 22, 2026 at 10:01:38AM +0000, Brendan Jackman wrote:
> > > This is logically mm code. Moving to mm/ allows access to mm/internal.h
> > >
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> >
> > Sorry to be a pain, but I feel that this change should be dealt with separately
> > perhaps as a pre-requisite to this series.
>
> I know you have an idea for some cleanup. Let's wait for your patch
> and then rebase this series over it. In the meantime I'll start
> reviewing the rest.

Thanks!

Cheers, Lorenzo
