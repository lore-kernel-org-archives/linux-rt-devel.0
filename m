Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD03A453B;
	Mon, 22 Jun 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123625; cv=none; b=JWaMVjix8lDgxLhE/WC4uuZd5E2MhfU5aYyN5Rr/sCX9RnzIWDRG+orK5/qBFD8BGCxsohGX44AHJAhQ+glu9Q4P5ZhwhLMf1LU8dSt1DlH6FN5QdRmX2JfW1MH1jQwZ4qsKVbtkJYhGITk8gKZ1y3+nZU+74PE+CoLkVzme08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123625; c=relaxed/simple;
	bh=OsvKo+nD8a67wCxe2nhaNPMrh2pMhphPKjJyTDR+mx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBs0GCDWI/TtooDhwbzczwhL5OvRMoeZ4hBtXyU4dbhLeu1nBI979VmtSUAp4XlFYgnJFrIotdiK+gj/vTJCrNQ6qzSCCyeBXG8HLdT43ZKrySvTJdLzYK1qL4mhzIBGpWKx3ar4HVRYjA39IMFW1OzAlIYvLTy86DQ1XQh1Of0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3dNwSEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3dNwSEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC21F000E9;
	Mon, 22 Jun 2026 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782123624;
	bh=Av5Cay2iQgE4dmKixANA1y2OxA30B1PEKQsa9QOD1Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3dNwSEdQK97otKyW4aA+SnAcax0LXFVdX64+OZjOO0Yq/NxEgpmFc+PVwtEkPciV
	 QQueXKNfzqnoitADM34KU9cMQrKUiA+WB5ez0XvobjUs5biRvhuvuLKAQJ0kAFD71K
	 spFd56Fk/w4Va/+NdkMYcD/JhXmr0IoR5GnqKN64=
Date: Mon, 22 Jun 2026 12:20:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 08/13] sgi-xp: Use higher-level allocator
Message-ID: <2026062229-lumping-latitude-b091@gregkh>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-8-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-alloc-trylock-v2-8-31f31367d420@google.com>

On Mon, Jun 22, 2026 at 10:01:35AM +0000, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the former allows you to pass NUMA_NO_NODE.
> 
> The former is going away and the latter works fine here so switch over.
> 
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Assisted-by: Gemini:unknown-model
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  drivers/misc/sgi-xp/xpc_uv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 772c787268932..aacff70204241 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -170,7 +170,7 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, char *irq_name,
>  	mq->mmr_blade = uv_cpu_to_blade_id(cpu);
>  
>  	nid = cpu_to_node(cpu);
> -	page = __alloc_pages_node(nid,
> +	page = alloc_pages_node(nid,
>  				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
>  				      pg_order);
>  	if (page == NULL) {
> 
> -- 
> 2.54.0
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
