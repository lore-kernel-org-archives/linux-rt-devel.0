Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491F36D504
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898192; cv=none; b=Pe2Z1WNOfXHpBgN7H71+6x9sxI36Xu7bgmxsR6swE2VGWPnattGWLjpLx+hI8u7jcptvIfRTZN1Y+9NKX0tIV/PH3LIIeC3P4NVEP2rShnXHUICCCXUW34H+3e+tCjGMjBJE86TOnCXqw7evWGsnnwiTNPjMPh1Jkljl/V89Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898192; c=relaxed/simple;
	bh=EKGMZlKAYG/eL2caf2RyvbNGIIJ5yQVRYkeosseaIU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA44Rts4BFpzg8QH/8Vpi4oXeVN00BW5EbsndiK2j2pztrkI+TitHc2co8gU38Qm4kzKIQRBTDJ1wkmDp78SYdfaGlJLMKLcnEAlrsuDjy6BWe9xR+OLl39PcvxvAD59Wx9MJ1AHUc2O0OQQzaZeAL2I1+v/FvMI/z0WOYwaV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9zB9Dhh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9zB9Dhh"
Date: Tue, 20 Jan 2026 16:36:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768898185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lkVn59AgzHG41rfxCcQcwV1gp3xTqlToekIxDgd/Iw=;
	b=J9zB9DhhUzdt+lyzMLvszXOIyc2O+nJbkjXAPF+9kplfQRYb3b0AdG2zwqsIa9Tc7oedl/
	xly2q2eVVCxZp+KuiRa91VtU8un+owcrglfFW355Jdu0yaA62lQp3MTqpXT17iRik49aTf
	rhZuKzl/oUxYHs0h0XBPgo7dHwjgKuE=
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
Subject: Re: [PATCH v3 10/21] slab: remove cpu (partial) slabs usage from
 allocation paths
Message-ID: <g73gai6ztmaxrigoqwvstyeatdsb6wjunli6gbbhvy7fxqomzv@la3452pj5na4>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-10-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-10-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:30PM +0100, Vlastimil Babka wrote:
> We now rely on sheaves as the percpu caching layer and can refill them
> directly from partial or newly allocated slabs. Start removing the cpu
> (partial) slabs code, first from allocation paths.
> 
> This means that any allocation not satisfied from percpu sheaves will
> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
> slabs, so it will only perform get_partial() or new_slab(). In the
> latter case we reuse alloc_from_new_slab() (when we don't use
> the debug/tiny alloc_single_from_new_slab() variant).
> 
> In get_partial_node() we used to return a slab for freezing as the cpu
> slab and to refill the partial slab. Now we only want to return a single
> object and leave the slab on the list (unless it became full). We can't
> simply reuse alloc_single_from_partial() as that assumes freeing uses
> free_to_partial_list(). Instead we need to use __slab_update_freelist()
> to work properly against a racing __slab_free().
> 
> The rest of the changes is removing functions that no longer have any
> callers.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 612 ++++++++------------------------------------------------------
>  1 file changed, 79 insertions(+), 533 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao
