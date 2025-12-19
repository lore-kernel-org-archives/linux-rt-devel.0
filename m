Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99D2BCF5
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157755; cv=none; b=XkiKIMiprkqzNWiDeGl09UG1XE0vTkloBSBBZ7nNrDGiGo1Dhekog2WVzfcOzFu2ZKb5jl2/BLHcr+KCZUTG1Gvc+Qv9869IsuGr2K6G1Xt+IMVuY8FccYIabYmLj+ag8O5ujsed/s9PsXCXHsFdVfyyufjBa9PbfT8ZlEjB0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157755; c=relaxed/simple;
	bh=6gncP9/fpjY8Vo7Xu0ZgNEEaR+9l8j/vsWxL7oTVW+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5GK/9EjRcP5OK3k5IvJSh7LYj8/dt/my2uETAaHQOCgI4DePeuSgbXGZJ0PsS2KYkg5A1zf1oDiykSkoXTHIryvltXw6tjwZEp1ImwSfNDYMKTtNWj7Xxlt0xzlKYyGA7tLLxVhLPfLsZCTEk/pMDEvjEhT9BXzjDGxw0Nly2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P8SXJr8g; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P8SXJr8g"
Date: Fri, 19 Dec 2025 23:22:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766157750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3s9JULSYXzELMJAZ9rBTWMLVrJKymV2Q8hfDA0hnfqY=;
	b=P8SXJr8gDG4M12wrwkP9Ka2nH0qsdAxraE23lcyLTJkG/xBOKXWTHJuSovBKj+EGHpbfu2
	DKEDZY44SAvoeWtuOdyUh0VS0YmxoDLmqdXs8l+7ab84a3iFtJSoEicJAPgZRAZC6/FMAG
	/gzueVk0S42JOVHcw3W+XcpSzDP11MQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
Subject: Re: [PATCH] slab: fix kmalloc_nolock() context check for PREEMPT_RT
Message-ID: <p2kiryxpwq7iu7x6jq65kzff4uivbdd3cne7rizax5b33ce5yx@nr5hfrnfevxy>
References: <20251219085755.139846-1-swarajgaikwad1925@gmail.com>
 <6fcfe0cc-3826-42c2-9c54-c127dc8379e1@suse.cz>
 <aUVTJyd74OoCtSyN@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVTJyd74OoCtSyN@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 19, 2025 at 10:29:11AM -0300, Luis Claudio R. Goncalves wrote:
> On Fri, Dec 19, 2025 at 10:31:55AM +0100, Vlastimil Babka wrote:
> > On 12/19/25 09:57, Swaraj Gaikwad wrote:
> > > On PREEMPT_RT kernels, local_lock becomes a sleeping lock. The current
> > > check in kmalloc_nolock() only verifies we're not in NMI or hard IRQ
> > > context, but misses the case where preemption is disabled.
> > > 
> > > When a BPF program runs from a tracepoint with preemption disabled
> > > (preempt_count > 0), kmalloc_nolock() proceeds to call
> > > local_lock_irqsave() which attempts to acquire a sleeping lock,
> > > triggering:
> > > 
> > >   BUG: sleeping function called from invalid context
> > >   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6128
> > >   preempt_count: 2, expected: 0
> > > 
> > > Fix this by also checking preempt_count() on PREEMPT_RT, ensuring
> > > kmalloc_nolock() returns NULL early when called from any
> > > non-preemptible context.
> > > 
> > > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> > > Reported-by: syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=b1546ad4a95331b2101e
> > > Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> > > ---
> > > Tested by building with syz config and running the syzbot
> > > reproducer - kernel no longer crashes.
> > > 
> > >  mm/slub.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 2acce22590f8..1dd8a25664c5 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -5689,8 +5689,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > >  	if (unlikely(!size))
> > >  		return ZERO_SIZE_PTR;
> > > 
> > > -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > > -		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> > > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq() || preempt_count() ))
> > 
> > AFAICS we can just simplify that to preempt_count() then, since in_nmi() and
> > in_hardirq() both are a special cases of that.
> > 
> > Any comment from RT folks please?
> 
> Maybe, for the purpose of this change, using in_atomic() or !preemptible()
> would be a bit more descriptive, as both macros check preempt_count()?

Hi,

I might be misunderstanding the situation, but my current understanding
is as follows:

__might_sleep will report this BUG if it is called with IRQs disabled or
in atomic context. Therefore, to avoid this BUG, it seems necessary to
check preemptible(), since in_atomic() alone does not appear to be
sufficient.

As a side note, once Vlastimil's "sheaves for all" branch is merged into
mainline, the local_lock_cpu_slab(s, flags); statement that currently
triggers the BUG is expected to be removed. Furthermore, the entire
nolock path in SLUB is planned to be implemented using trylock
semantics, which should eliminate the possibility of sleeping, even on
RT kernels. At that point, it seems we would only need to guard against
deadlock risks from NMI and IRQ, so this condition might need to be
reverted to in_nmi() || in_hardirq() again.

Please let me know if I'm missing something here or if there are
additional constraints I haven't considered. I'd appreciate any
corrections or further insights.

Thanks

> 
> Luis
>  
> > > +		/*
> > > +		 * kmalloc_nolock() in PREEMPT_RT is not supported from
> > > +		 * non-preemptible context because local_lock becomes a
> > > +		 * sleeping lock on RT.
> > > +		 */
> > >  		return NULL;
> > >  retry:
> > >  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > > 
> > > base-commit: 559e608c46553c107dbba19dae0854af7b219400
> > > --
> > > 2.52.0
> > > 
> > 
> > 
> ---end quoted text---
> 
> 
