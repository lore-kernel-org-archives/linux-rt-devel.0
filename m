Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D02446067;
	Wed,  2 Sep 2026 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344680; cv=none; b=X17070JMRu/7QSzi/fMaqGynoIbkk6em7DgngI3nV2qybJ+dNV+ca+IyZT6m3oNBjfaWXZ6m0DZe2TA3j9Eu584E4qsvpvlUy+KMk0CsOjtwEMspXbqxZL8qiAUwyPWg0rVCaVugdBttwkwr8jA6EgYHFTPqn/B97Wi5oTzrBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344680; c=relaxed/simple;
	bh=ukCDj4ExguipADchZk8z+Q1F95A+k2+0eBsKIkxHsMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpq94j9jxkAS1PS9XF0xLPkpP/BhpYjtO4SBRpwKIBjdyZ168DIWN7kZI2T8co4SKhC9SilO/15IxlfzqdvCKSh7GoN43faIs2eZMsc9+YrO0ocWhTrwgc+4z1ljmy8my4Gl3bcJtcYx51pKmW6WQvhpvyBWMi3AV+lLsSrtFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOvew3l8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOvew3l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A9E1F000E9;
	Wed,  2 Sep 2026 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788344675;
	bh=NaQwdMaMWyBaW+1JHeOi/GljyUWwMv+cdyTRLLUox2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOvew3l83e06p6RB76xlMujpso/lVLUdS2hThNW4uCyyf6i7UFiit3bgubPkygPHv
	 KPqzA3EDTjtV4rtdbGEcjnfYsMm5DAQYgJpXI1EYEoD3C6NWuhbZTs6WgVA/QABcTp
	 wTPijWfibcwm3MTbrLwzFiJKEqg4Hm11nH5lxr1ZKt4JBafdB0BEshVxv0CKtlfKSo
	 BJe8xZQH7aO7RZahvxSTk/ozNCsbNVMT34Ih1adzBGId7GzH0HLYj9372wV8tbfcDD
	 Sf7DFcw0BJhB6VkjNsh7clAoTm9Gp5buJhpP7Cj3Y5svOrMPVQSL2BqvecbEOAi4hI
	 pjhLLko5zWpng==
Date: Wed, 2 Sep 2026 11:24:32 +0100
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com, ThangNN99 <ngocthang2710.1999@gmail.com>, puranjay@kernel.org
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Message-ID: <apfwshahN_C6jBSn@nixos>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
 <20260901073339.uyKHXWCX@linutronix.de>
 <47aa459f-27d5-4b2f-9eb9-36ebca63d890@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47aa459f-27d5-4b2f-9eb9-36ebca63d890@kernel.org>

On Tue, Sep 01, 2026 at 03:59:09PM +0200, Vlastimil Babka (SUSE) wrote:
> On 9/1/26 09:33, Sebastian Andrzej Siewior wrote:
> > On 2026-08-31 18:02:38 [+0200], Vlastimil Babka (SUSE) wrote:
> >> This partially reverts commit 2a8bb29ec9b2 ("mm/slab: allow
> >> kfree_rcu_sheaf() on PREEMPT_RT"). It was based on an assumption that
> >> local_trylock() is safe on PREEMPT_RT from any context.
> > …
> >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> >> ---
> >> Incidentally I have posted a RFC [1] that leads to replacing that
> >> kfree_rcu() from set_cpus_allowed_force() but now after back from
> >> vacation I need to check the feedback and based on this bug report I can
> >> already see it makes the same bad assumption that trylock is fine.
> > 
> > free_to_pcs() has still this trylock.
> > 
> > What I am not so sure how good is that kfree_rcu_nolock() may allocate
> > memory for the sheaf if there is none around.

At least it doesn't wake up kswapd... oh wait, but it does use trylock.
But that's not just kfree_rcu_nolock()'s problem?

_nolock() helpers can be called at any context, even under pi_lock
(at least in theory). re: we should fix can_spin_trylock() and use it
IMHO?

> Per sashiko review it's actually bad too under the pi_lock, because
> GFP_NOWAIT means __GFP_KSWAPD_RECLAIM which can mean wakeup_kswapd() and
> thus also need scheduler locks. And it's not a PREEMPT_RT-only issue...

Right. That's a pre-existing issue that has been around for a while...
I tried to reproduce it locally a while ago but it was quite tough.

> > It could have a pool of X
> > and if it runs out, it runs out and waits until the clean up process
> > feeds the used sheafs back. There is fallback and the run out is not the
> > usual case.
> 
> I'd rather not invent new pools, since there's fallback and the sheaf+barn
> is already a pool.

Agreed.

> Could be enough to make sure the allocation attempt is
> safe, i.e. use only __GFP_NOWARN.

in __kfree_rcu_sheaf(), yeah.

-- 
Cheers,
Harry / Hyeonggon
