Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D363E8660
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758335; cv=none; b=nt5k5RWlXRgpB+h+nqh4vpIJoLR86Uz0BVGNhuW2Yv+ECNqUyWjo9DFBxmV8QSSzeXKXoYi38JgJzVInF/aaR3xdAQvZAkAO14p9kYH4lVyLsG6ohrU+GWmVnc+h/GF/agd9AuYT9G27f/kZgvPJDA1kImtuqsOrkV7JtnflAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758335; c=relaxed/simple;
	bh=mmphkqcG93FqderNmd/L1cinawqh36y76fm1wNIAD9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9216W8msOafae79XNnKDGNKhNQeSl2up1Mqdck5pU+i9LvxMfbEbKZdj8sNmvtl0GkJBfTX+BaqaAZDlsA/eprU2UvgfDFylAbkveR/llkbIo/ChZhgjNGU2K68a5vXisvJNCglM5OVnmD8RJ9rZ89xXr06r4O9mHpaWNqi+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CAqrgaus; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=84bu404I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CAqrgaus";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="84bu404I"
Date: Tue, 17 Mar 2026 15:38:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773758332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dwiQtjV0URScOIyDH89kknET1vSDADAowJTLNm5SWs=;
	b=CAqrgaus2MC0i0ZA73W1BgaQkEPeGXkI36AQ10M7pSsfgysl9ZTEuCxyefNd2bwX+cTtgH
	reyD8HZoqjeRHtw2HeEZtk+C1T222jYnG1iwH+1olsve8OJUn4wuvgNhGL6G5v5YqCZbtZ
	f4j4w4+gKi3I9mps/rnIEBk2XJbNRLQQ8ZGRq4uxY6z7yF6Kpeo9jYkYo7G8poM71IPhPM
	fVhA0+hc9TUxZaIR64ZodGqKF7xWI6MTvwUvhfZgk/QBEAocv1SkZPYi5Fp+IVnCqizB+h
	oH2IgzEfULR3Pu05W8kBCo6NP+fS/LVwuS32HHSJI5/+I4SslxYugAvcfEciuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773758332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4dwiQtjV0URScOIyDH89kknET1vSDADAowJTLNm5SWs=;
	b=84bu404IaCUK9e3YVljsj9RC5Ra9wg3tAMbQJPB3/MA7gyjRQM14VVZtJQH6QS/AJSLPzV
	WddHZhtlwmYG9SBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com
Subject: Re: [PATCH iwl-net 0/3] idpf: virtchnl locking and async fixes
Message-ID: <20260317143850.BLrnAox8@linutronix.de>
References: <20260316232819.6872-1-emil.s.tantilov@intel.com>
 <20260317090054.DuPZ6O0O@linutronix.de>
 <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7247024b-fc8d-4a75-ba15-a10399db03bc@intel.com>

On 2026-03-17 07:20:18 [-0700], Tantilov, Emil S wrote:
> > Why is there a raw_spinlock_t? From a quick look a spinlock_t would do
> > just fine with not runtime change for !PREEMPT_RT.
> 
> The handling of the virtchannel messages is done via the completion API
> and the transactions are using the raw spinlock from struct
> swait_queue_head:
> 
> https://elixir.bootlin.com/linux/v6.19.8/source/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c#L298
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/tree/include/linux/swait.h?h=dev-queue#n44

I am aware that completions use a raw_spinlock_t. I don't see the link.
What would break if you make that lock a spinlock_t?

> Thanks,
> Emil

Sebastian
