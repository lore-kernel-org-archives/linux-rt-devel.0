Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093E426D1E
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911088; cv=none; b=IhawLhP81KDNgqC0Mi6HEMQAxjvk2foPPwHgcUONa3VR+DhkJwx6FF2A/Wqv7WgzCJk68cMCFdPDn+zYcvsxUFFVW3mSDPwAB2uZhcoxqEirz9nT8ozfNUIUyBcVLLCVpaE4IPXfhkyLca5eet1VdwYgcr9fMgP0jG+SIfWtxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911088; c=relaxed/simple;
	bh=pEnfeULKBhJxNamTxUnPO+8JkY5cm0XWckh3IDcPkGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWLzfekndin3gocoEzFnalFtQVk8KqtCioNo6Kx59pUrv9MFCyNUpb6DRlvN78wyAOADjRyAB5altL48ti5zQGWm8HYeWbV5gGVGvBAlz6gYVHl8t2XKi6NVNxLAPZB3huB132x7xrcjpyrGFDOWJIMHjS9dfwKbnINZJjFHlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q4pTiUAf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q4pTiUAf"
Date: Tue, 20 Jan 2026 20:10:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768911084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ft4cfnsazH2fqh82dag3UKKoVEEmk8hPCPptOiIZ6Ls=;
	b=q4pTiUAfOIKpOsCaPxK7ufMZNY66q32D+T6qXJJExTNSxwJ2okdO2ymUJknkUzAKiW8yBq
	Q/y0CluMbt79RShE0/KvxS79Bl40SYaVHrdvCs22+iNKnaLsmI+uSrZOev9JWGfCrKcY7O
	h+6Ys3n0CeZTFZDrSjJWfpDJDu7UQRE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
Message-ID: <3vjyq6wpkvaczzgl3r2qhwi7zdluh6zldejjxnki2hft7vxr52@g7gn4lqbdi3c>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:31PM +0100, Vlastimil Babka wrote:
> We have removed the partial slab usage from allocation paths. Now remove
> the whole config option and associated code.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/Kconfig |  11 ---
>  mm/slab.h  |  29 ------
>  mm/slub.c  | 321 ++++---------------------------------------------------------
>  3 files changed, 19 insertions(+), 342 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
