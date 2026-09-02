Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3835430CD3;
	Wed,  2 Sep 2026 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343522; cv=none; b=I6ps2KidVrZixDWPl5Eceke1rP0z6WH2iE/3belCnNg1Erb72tZ41HirXEEFIzoRmfZ0Rbpt4p7VJs6/EmwV/OpcXIJ9ZcSJNor406B3V+hSvDZdFOzRF2TQabueMXDmE5GJr7/ZTtXuWrnX7LWMXCkKkDfBgGXtS8vrnnaAw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343522; c=relaxed/simple;
	bh=pDy8xoSkObYPu/v5b7OoksLbTFhMEMX7QC4U2UlTwzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD7t2wz+ET3CpuMlMMFBGj4VTnHkO/qYLFg6WGgUwEsmKVj1yung41Da7RKJ1R7oziXEQOvRRoi8meVWfH5JS+DLPEhi9q8A68QACksgSXGq6HXhQqPv5mbnZzW3RxeUGlbaLQm9byMqVK2loSHOGqJvSPdZCjhE9xaG5CEZn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuUW4AFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuUW4AFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14B21F000E9;
	Wed,  2 Sep 2026 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343521;
	bh=8vWQxrJHayrwwhMkde5WNO4SONhqD9HgJXyCKA+9EN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XuUW4AFUy2dwHWVZf12krJbN9Ni/p6KdoXKlSOpUg42W5KpGAQwTxfimPF3TPllJ0
	 6uQbZkh5TYAx0j228akBJyGcEcPjzkmp2GTnDZHYNqte5BnL/vW/TMKAlYjGHiWbEp
	 WhDPsiiQ5uSkyp4oHeUlhrwstVsEpTthDvbp0zO8pH78F88UsyGBxMtb+W2PUD2+0V
	 9A65BzsNs8wr7gvoFG/bUken5QZPbXpZtnQSwSokJZ1IEHFG4E4IvIkCIJa6FyV8LL
	 tAvxNarFvgv6cuOrMyxT8vzFGOmEegIyQCAA3s1DR5VmOrZqwYu4GFmf9KOIemEDsV
	 y9R2aBMcHi6BA==
Date: Wed, 2 Sep 2026 11:05:18 +0100
From: Harry Yoo <harry@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: ThangNN99 <ngocthang2710.1999@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, syzbot+acf142088e0182172e58@syzkaller.appspotmail.com, 
	ast@kernel.org, puranjay@kernel.org
Subject: Re: [PATCH v3] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in
 kvfree_call_rcu()
Message-ID: <apfyeYF8IE03aazT@nixos>
References: <20260831130057.HLukQ-zm@linutronix.de>
 <20260831133222.8637-1-ngocthang2710.1999@gmail.com>
 <20260831143500.x-saxdAs@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143500.x-saxdAs@linutronix.de>

On Mon, Aug 31, 2026 at 04:35:00PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-31 20:32:22 [+0700], ThangNN99 wrote:
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -2034,7 +2027,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr)
> >  	if (!head)
> >  		might_sleep();
> >  
> > -	if (kfree_rcu_sheaf(ptr))
> > +	/*
> > +	 * Callers may hold a raw_spinlock_t here on PREEMPT_RT (e.g.
> > +	 * set_cpus_allowed_force(), whose callers all hold
> > +	 * task_struct::pi_lock), and the sheaf/barn locks are also taken
> > +	 * as blocking locks elsewhere, so trying them here creates a
> > +	 * lockdep-visible ordering conflict. Skip sheaves on PREEMPT_RT.
> > +	 */
> 
> You mix up things. A raw_spinlock_t should work in general and should
> not cause a problem. The task_struct::pi_lock is special: It used during
> wakes and the inner waitlock of the rtmutex acquires it even during a
> trylock. For PREEMPT_RT we don't want to acquire any locks while the
> pi_lock is held.

So... even can_spin_trylock() is not enough handle the pi_lock's
special case.

Probably we should make can_spin_trylock() check if current tasks's
pi_lock is acquired, to determine if it's safe to call _trylock()?

> What about
>   
>     kvfree_rcu() is called by set_cpus_allowed_force() with
>     task_struct::pi_lock acquired. On PREEMPT_RT the local_trylock()
>     usage below will acquire the waitlock which must be avoided.
>     Therefore avoid it on PREEMPT_RT.

-- 
Cheers,
Harry / Hyeonggon
