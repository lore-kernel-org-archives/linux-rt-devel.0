Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48D2773D9;
	Mon, 18 Aug 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538868; cv=none; b=Ib/8GU13OQiSoFLw6zowbjfMjLDGOChbNuZ1GmvkJW2UjbmW6AIikotoGpxpd2B0ajUC2lOOZhEGGLpiW7eVgO54Twv2JBwTqXMXhPtazA7kv4sm+PLnUrzq3DVRvq1h+wdnCiMEG0cEW86TroucTTotxqx94S7RoQhl5TbcgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538868; c=relaxed/simple;
	bh=JemiC7ZENBcCqgnGqp4y8wCxlJ922UbVQ82EcDC5bsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js/3haDvw/9rFkbynNE0ukoEZK4XgNWnHqZ1LnfwV3w6mshEs1p1GOB7kyqd4T0j4SWcZclr6tNvMslfP6383sypdZAi3WXDDeUy26iCSzrRfChmLFg0r0Ly4Uq2QQD/xwBAtlF4SOy765huoRTxFRUfpFfKbhZv1KeD/lMcwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reAhGiF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reAhGiF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A3C4CEEB;
	Mon, 18 Aug 2025 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538867;
	bh=JemiC7ZENBcCqgnGqp4y8wCxlJ922UbVQ82EcDC5bsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reAhGiF9l9IUOKkUr5llmmgO6ZwFQwlKxHPmivj2Cm3vYvEtdr45kOcQYAKy02S5H
	 xFaEDE4vMWffIIoHst7LxPQjTqXMJ/uQjBILh2yFzYT/+PsgUdvncb9GGnRuE8SXIn
	 yria2tHYVpiUSS83fNaaK0n7Yk1EZDtyFnkX98EQdcqbUJAkVBNn6rYNdCRzzVjcO8
	 wku0shtg7AzGX07FuhPZUR7enRZHntM+tbJfxfBiKhMaIxIxvMadyfZL+aoKhUXz6Z
	 /WXkapiuxl53ZG1805LMBES3g/NxLrq6wwtneqaBQfdBAioXNgkJkJ6q5vGYG5sRFL
	 aOMRPE7YBbDhg==
Date: Mon, 18 Aug 2025 07:41:06 -1000
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
Message-ID: <aKNlshZmWsHVXBo0@slm.duckdns.org>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818125242.vJ4wGk20@linutronix.de>

Hello,

On Mon, Aug 18, 2025 at 02:52:42PM +0200, Sebastian Andrzej Siewior wrote:
...
> > Right, given how early in conversion, we can definitely leave this as
> > something to think about later. I have no objection to leave it be for now.
> 
> Okay. Do I need to update __flush_work() in anyway to make it obvious?
> The local_bh_disable()/ local_bh_enable() will become a nop in this
> regard and should be removed.
> It would be the revert of commit 134874e2eee93 ("workqueue: Allow
> cancel_work_sync() and disable_work() from atomic contexts on BH work
> items"). The commit added the possibility to flush BH work from atomic
> context but it is unclear if there already a requirement for this or if
> it was to match the legacy part of the tasklet API.

I see. Can I backtrack? If it doesn't require too invasive changes, let's
just keep the two in sync. I'll get back to conversions so that we can
actually achieve the goal eventually and it'll probably be more confusing if
we revert that and try to redo it later.

Thanks.

-- 
tejun
