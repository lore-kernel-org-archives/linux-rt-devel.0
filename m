Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329E26F288
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Jan 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699965; cv=none; b=Qr1lhkcVO+cuNrjcUbZ7OSNYFhv8dOdmQ2GlPGKCb2YkmF0/SUQ3JVAD8TceWpMUlMB8wLW0MENMHehgITnoOoR1w90XjJevTALOOyJtKDRldXkyRcZP5o7/SkyA+gKZDO1VPDV+xpAp/owuQi9dc3g8CQC4eePbX5PWMPzOboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699965; c=relaxed/simple;
	bh=sLtHdOPZztY4e0NwfEVYdctcdwCqoMwIh1kfiu9s+Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLL9LK+k2q7avoonn6zQlGg3fuIYqld/yo1f/wOv8bgL8HP23ZNOwZ+YQEd3gD0ApkIzaweUZaid2tmUNK+iq6D4Oml8zwy5GBTYIsPe+9e2TbZf4TihvwImCL7//uPNm0RtTJpEpEpPwaKmB7Yire+HYMDeZ7mHM0XxH+zx6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BR3wjJrj; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BR3wjJrj"
Date: Thu, 29 Jan 2026 23:18:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769699960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIp7jKuWgekJy97efthM5741IP+QBaVVTDcUYnJ8gmc=;
	b=BR3wjJrjPKCxj1WTCO2atJ6c6xqeJZCHHAHnVxrrsNappdgMNM2Go+lK2KrNlOlVgs299P
	oZhPnGnOqwLwpBuoUG6n2Z0RWXCNsafIuazWIOwOqHD4ZqkYeLD13uMZvUk6bOafpPn9f0
	u3t212KDl63dQDbYx+n11Mhvf4k1u18=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
X-Migadu-Flow: FLOW_OUT

Hi Vlastimil,

I conducted a detailed performance evaluation of the each patch on my setup.

During my tests, I observed two points in the series where performance
regressions occurred:

    Patch 10: I noticed a ~16% regression in my environment. My hypothesis is
    that with this patch, the allocation fast path bypasses the percpu partial
    list, leading to increased contention on the node list.

    Patch 12: This patch seems to introduce an additional ~9.7% regression. I
    suspect this might be because the free path also loses buffering from the
    percpu partial list, further exacerbating node list contention.

These are the only two patches in the series where I observed noticeable
regressions. The rest of the patches did not show significant performance
changes in my tests.

I hope these test results are helpful.

-- 
Thanks,
Hao
