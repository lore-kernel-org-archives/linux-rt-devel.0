Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C538F23C
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 05:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058125; cv=none; b=ukNccal4Ekz9/PGZ/fge6WGCC9sg0gIAUCsIFvIp4dV+iseWV8tGn0I25A02xmkFjpULfI6tlqwPnonbrUkfwWVIZZLtrm3H3tbKcnPtKblFIF4F0pTq0Ncg7EGhkzrEcVD/miyvAVZS5fo/2htlh3YeJ5a99T6E5c8dkDQ7fqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058125; c=relaxed/simple;
	bh=ULm9KW9cn18wAR4j+b1x9VNXX1CaPev3Z0rTmH24Fmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX75CF4XAF2QhUxbJTCRcht2fZRPi5XLuHk8cNzREwpcEpdx6zjXw163bzQ8LNXH6HGBsoc2d22B0OhxVgt7QvWeliv6p+Ppsy4RKd/b34H3MNxbYizW7dpEiH/jmq5cZ1Ay4tJTKX3q0Qo0BIxJihU85rBbgyIaO1tXOqFW/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQl8IV6O; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQl8IV6O"
Date: Thu, 22 Jan 2026 13:01:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769058119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nesrHAnPEf109FX2/lCNqfl81JEqewLyfAPoUShZzXI=;
	b=qQl8IV6Oqoiu08opgd6gb71Xe1wVWqUbTnUDjm2fWGwarbwE/LQdD4fuFjLZ4Ep1NzwQma
	6uncJSiZ4ciNdkQddvpFierFWn3e0sMK/3Ga0FpYIViZUkj2BXJG7PtHPZo3sdioIXCjbl
	nDLG+Wm6HNOClrZ3kX+BTk3K7a/2w9M=
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
Subject: Re: [PATCH v3 19/21] slab: remove frozen slab checks from
 __slab_free()
Message-ID: <7syrsyflw6ii223mwyvnwz5pu7chlh5ddmblyq7izmgvtv4xt5@pl6osos5rpy7>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:39PM +0100, Vlastimil Babka wrote:
> Currently slabs are only frozen after consistency checks failed. This
> can happen only in caches with debugging enabled, and those use
> free_to_partial_list() for freeing. The non-debug operation of
> __slab_free() can thus stop considering the frozen field, and we can
> remove the FREE_FROZEN stat.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 

Looks good to me.
Reviewed-by: Hao Li <hao.li@linux.dev>
