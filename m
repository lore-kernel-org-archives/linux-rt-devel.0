Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AA4D7D5E
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416046; cv=none; b=SbE9sk9k60AVheRc5UraP/JUqztA+SjT7x0J2PJZ+OBWsZAriqlfHk7s3bY34fSkdCJMzn4Xs+xhifWpJ2cdj6OsbxsZb2ee0BPOUzAF+dvF81wK4eMyeEQEYCWMwFBVty7C0/97ard0KoxXM874EQJNi9IqkbyLJSuFfzsw9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416046; c=relaxed/simple;
	bh=Y84iBQWlpHiFtmfpXJElZZ2mZgBlnpwNYTXZe0Fyluc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1kdMp88fSZtLSeV1vFRVLm6tteQP32TsETKcZ9yPNLy2zGj41DUowgYwHsN7/BhnEmP1gIuOECWCq/YsAa8wVbv8dmQn6QHVys2+xFEV5LrAFOUxO8+usS4XXqm9ZlH56RB+JtVy9+rrI17sKlrjxrFFb2HXICGyNk2E84anBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGRFuQmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGRFuQmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0E41F000C4;
	Mon, 19 Oct 2026 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416045;
	bh=aFz6tMDneRfAiax81gydkYDdf/QTvsFngF3Ua5uanvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGRFuQmIUndqJBu5VOqmBOhswg2ATuImrzNeYthILoeSTkYPNzASDT0ZRy3LSrTtm
	 4TgDnNpZ8MR41xO1eCrTiCsO89Kr/1O0MDb4xSVfye2fEEFYN4vYpPlFYObOKMzwo9
	 ZItQP4JkpzglGg0Xk7jrgLMs9J7FdP5LLnzhKbLK4bcT/pzsR81eClKOr8pkG/gxGV
	 Feq65vaUB+IjVIrF3xbd37FR61vvLEJ/EYDw3+BRn8qJTerBtKpbc2GbChaSk6kFQW
	 kH4KgRtQJ9Y3hZE8cU/QYMlp0yantjyxiVxJChUPKP5mezmwfn3394dklGDyQLT3Kv
	 VU2mQ4vvHhsnQ==
Date: Mon, 19 Oct 2026 08:20:44 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: wen.yang@linux.dev
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
Message-ID: <atYZLK0gmG8vRHxG@demetrius>
References: <cover.1792345413.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792345413.git.wen.yang@linux.dev>

On Mon, Oct 19, 2026 at 02:15:22AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> Backport backlog-NAPI threads to v6.6-rt-next first, as requested by
> Sebastian and Clark, before following up with the v6.1-rt backport.
> The base is 4c4970859022 (Linux 6.6.151-rt78-rc1).
> 
> The existing RT workaround, 1f7514c9c75d ("net: Avoid the IPI to free the"),
> redirects deferred skb cleanup to a worker but leaves RPS remote-backlog
> scheduling on the function-call IPI path. In a fresh RT guest this still
> triggers do_softirq_post_smp_call_flush() from idle queue flushing.
> 
> The ten earlier NAPI/RPS prerequisites are already present in v6.6, so this
> series reverts the workaround and backports the four upstream changes (all
> in upstream v6.10) in dependency order. Backlog-NAPI threads replace the
> RPS/defer function-call notifications; ordinary scheduler wakeup IPI traffic
> can still occur. Two of the changes were previously backported to ordinary
> 6.6.y and reverted (507692c05636, 5a530c8ead06) only because PREEMPT_RT is
> absent there, not for a functional defect.
> 
> Backport notes
> --------------
> Only 3/5 needs context adaptations; they are listed in that patch's commit
> message. The other four apply without context edits. Unlike v6.1, v6.6 keeps
> WRITE_ONCE(napi->list_owner, ...) because the field already exists here.
> 
> Verification
> ------------
> Each of the five stages was replayed against the base snapshot and compiled
> for net/core/dev.o and net/core/skbuff.o. The baseline and final RT/RPS
> bzImages were built with byte-identical normalized configs using GCC 9.4.0,
> with no compiler warnings or errors.
> 
> Tests use virtme-ng 1.38, x86_64 QEMU/KVM, four vCPUs and 2 GiB memory:
> 
>   vng --run <bzImage> --cpus 4 --memory 2G \
>       --qemu-opts='-machine accel=kvm' --exec 'bash <script>'
> 
> The config enables PREEMPT_RT, SMP, SYSFS, NET_NS, VETH, RPS,
> IRQ_TIME_ACCOUNTING and KPROBES, with NR_CPUS=4. Run the inline script below
> in a fresh guest for each image; it prints one column of the table, and the
> columns are joined outside the guest. It covers both mechanisms: the RPS/IPI
> path (ping flood with RPS steered to CPU1) and the defer_list purge path
> (cross-CPU TCP frees traced with kprobes). See its header for details.
> 

Wen,

I just pushed v6.6.159-rt82-rc1 up to the linux-stable-rt repository in
v6.6-rt-next, waiting for kernelci.org to pick it up and test it. I'll
let it soak for a bit so people can test it, then we can release it
later this week.

I'm betting the v6.1-rt series is going to be a bit bigger?  :)

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
