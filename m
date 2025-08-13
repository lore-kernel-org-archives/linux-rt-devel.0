Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10D244673;
	Wed, 13 Aug 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108337; cv=none; b=e2F0XQ9KkiLLDLYTSlLV5X2mAZtTYlvrs4jaIWYxWpQ5+yYV0a2WIrgpvW1lV1I6vJdvbs4YRNhd+RKQh3uAguHOMUigywofN4faHHBaZnDWRbtNOIgxgSQGPw36zz69tbNX/IOYU0M8hazXFkHQhYNwrMnT1ONGp6KzARIYb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108337; c=relaxed/simple;
	bh=VdllnDqoiojl2rXcVQgdytgzxs83C33rglqhv8B4mHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX5VD4Hya58EGrZPt0w17sk03JUaaljxTLqLO6b//w9WGclUx0p/AW9InlqrLk+mw7W+WjG8E4rqbimOu3G39ovE5asw2ZumPTt1FfzxqakcRuf4mbbRdnjMOoQUEof9rrm7JR7R+QkN/I/4W8VUJRnGSeB/HuY1PKQJcZy7oCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUqyfZuz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUqyfZuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECDAC4CEF6;
	Wed, 13 Aug 2025 18:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108335;
	bh=VdllnDqoiojl2rXcVQgdytgzxs83C33rglqhv8B4mHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUqyfZuziYDpH4FX/CYNPt33vDrQKsfI2nPQMFf2/LHeC8TNDs67jnIcRz4I03Kcv
	 w1OIIWofG1ZnbdCHdTVXBU1HJSdv4R6XCMmUo5LRXPytViVxsCu0dZt3uh67IO9js7
	 XwEjOiS2sVFf8bwS+YrAmZcl51g0grdb3ShqvGwhAqmM/f9TF7lLPUFwoysfv+1osa
	 zk8qUnr+5yrBjCpRZGEgUfqx8zzMLjmI/SZhj5sbjiUluAAlrriQJpNNIjorj7PW/0
	 l1uo+4mg8LcWI6D5GC1nzPx/E4sbCicNlFFbs/DHrnMxDKNAU7ckvzda4zmnaXilIC
	 D2ValjDCUPh7A==
Date: Wed, 13 Aug 2025 08:05:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <aJzT7rqwkRQrLGqo@slm.duckdns.org>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063311.33m0TDKl@linutronix.de>

Hello,

On Wed, Aug 13, 2025 at 08:33:11AM +0200, Sebastian Andrzej Siewior wrote:
...
> > The intention is to convert all BH users to workqueue-BH and remove BH
> > (that's what Linus wants and why workqueue-BH came to be), so the APIs
> > should be able to match up, I'm afraid. There were some attempts at pushing
> > the conversion but we've only made minimal progress. If you're looking at BH
> > users anyway and feel like it, please feel free to convert them.
> 
> I understand this but I am talking about legacy users:
> 
> | drivers/atm/eni.c:      tasklet_disable_in_atomic(&ENI_DEV(vcc->dev)->task);
> | drivers/net/wireless/ath/ath9k/beacon.c:        tasklet_disable_in_atomic(&sc->bcon_tasklet);
> | drivers/pci/controller/pci-hyperv.c:    tasklet_disable_in_atomic(&channel->callback_event);
> 
> This is what is left. (There is also i915 but this is "special").
> So we are talking about establishing an API and behaviour for those here
> after we painfully managed converting everyone else away:

Right, given how early in conversion, we can definitely leave this as
something to think about later. I have no objection to leave it be for now.

Thanks.

-- 
tejun
