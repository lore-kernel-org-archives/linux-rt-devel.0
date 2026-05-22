Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942F34F26F;
	Fri, 22 May 2026 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439614; cv=none; b=MoBHkhewQ8yWjdKTTuTEbyUjGT4tegVcCz8TqgG9r32AUFGnCPZcis2gH9gDxrHX7FDZjIGmowTkDiq1lE2L6OJGY+r4Ze3c0t/EfuAR/LxndW4Of17/Zxa7smlirY5W3fdXQXTJNZs4pDRaEjbeIDCHndra4ujj3+LEiWyvPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439614; c=relaxed/simple;
	bh=GF0SONpxxD7hyNnbIqgnI9lNoALhxOjgRq1qtberS9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPS33qi3s+HHJ42bYF63dwtablQZfFfkIhwjFfGjZuB6fla5U6/bx4fnqJZedklmonqzZkERETeT7r/eCN+EWEKLISrE3HayYojZsRsfnrX8t83jruJNjVO18dfxvk+ItFgHH+RgVnqsOydV/Y0rvMERafPOCLb+vLDWQ5syCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUKESoVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUKESoVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913AC1F000E9;
	Fri, 22 May 2026 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779439612;
	bh=2kKj5TUBkJ/lhKpwrX5zg7NzjXpzWJAzpXTS1fgVICc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YUKESoVKquqC4dbfhsbG+HvacauCOzizSC2ClD87K4VvwII9MuHoouI4xV6+a4bo4
	 Hv6Ogqb0s11ambrct3s7TRpVCroOEefPc8TFLJ5+7tRb68ny8XBBckvNAye09lto6b
	 62apL/qdZ8Hwou2syulNQb0bVPXvLEWe0w0XGQ67shJQB70o2e8SvfkzUBLBWrPDz6
	 QgYa5ARg3iQF5F4nYKqEE6bADB4D2JmeQcZk0vqa7O3LStfFInwFlSuI3IFk4tmDVw
	 ha27UMDq77FAZF2c/4QvcGyBqEnxrSAF/A+3PFGRE1DTqzjdBXfVU1sppHgtG8XZcF
	 oM7t8g+UFTdtA==
Date: Fri, 22 May 2026 09:46:45 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
Message-ID: <ahAXO_XN1TYvq24D@lucifer>
References: <20260520204628.933654-1-longman@redhat.com>
 <ag8zX5KJUKo70TvG@lucifer>
 <f0f4841a-816a-4442-bebb-277984ee950e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f4841a-816a-4442-bebb-277984ee950e@redhat.com>

On Thu, May 21, 2026 at 01:40:03PM -0400, Waiman Long wrote:
> On 5/21/26 12:40 PM, Lorenzo Stoakes wrote:
> > +cc Matthew who has fairly strong opinions on GFP flags and such :)
> >
> > Also, please don't send 2 patch series with 2/2 in-reply-to 1/2, use a
> > cover letter + have patches reply to that :) [yes it's one of those
> > subjective things that people differ on a lot but generally how we do in
> > mm]
> >
> > On Wed, May 20, 2026 at 04:46:27PM -0400, Waiman Long wrote:
> > > The GFP_ATOMIC flag is to be used in atomic context where user cannot
> > > sleep and need the allocation to succeed. However, it does not support
> > > contexts where preemption or interrupt is disabled under PREEMPT_RT
> > > like raw_spin_lock_irqsave() or plain preempt_disable().
> > >
> > > With the advance of the ALLOC_TRYLOCK allocation flag in the v7.1
> > > kernel, it is possible to allocate memory under such contexts by using
> > > spin_trylock to acquire the spinlock in the memory allocation path. This
> > > does increase the chance that the allocation can fail due to the presence
> > > of concurrent memory allocation requests. So its users must be able to
> > > handle such memory allocation failure gracefully.
> > >
> > > The ALLOC_TRYLOCK flag will only be enabled if none of the
> > > ___GFP_DIRECT_RECLAIM and ___GFP_KSWAPD_RECLAIM flags are set.
> > >
> > > Introduce a new GFP_ATOMIC_RT gfp flag for those PREEMPT_RT
> > > atomic contexts.  This new flag will fall back to GFP_ATOMIC in
> > > non-PREEMPT_RT kernel. GFP_ATOMIC can continue to be used in contexts
> > > where preemption and interrupt are not disabled in PREEMPT_RT kernel
> > > like spin_lock_irqsave().
> > This seems like the wrong place for the solution, now we have to remember
> > to use a specific GFP flag but only in one specific place in some IRQ code,
> > yet RT is fine with this in any other scenario?
> >
> > This is really confusing.
> >
> > Wouldn't we better off with a way of actively detecting this context
> > somehow in the page allocator?
>
> This new GFP_ATOMIC_RT flag will make memory allocation more likely to fail
> compared with GFP_ATOMIC. That is the main reason why I think a separate
> flag with documentation about this difference will make the users of the new
> gfp flag more aware of what they should check before they use it.
>
> I would certainly like to have the mm memory allocation code to handle it
> automatically if it doesn't impact the failure rate.
>
> >
> > It just instinctively feels like this is the wrong level of abstraction for
> > a fix here :)
> With PREEMPT_RT, GFP_ATOMIC_RT just translates to __GFP_HIGH. It can be set
> explicitly in the relevant call sites. This patch is more a documentation
> step to make clear the purpose and consequence of doing that.
> >
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   include/linux/gfp_types.h | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >
> > > diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> > > index cd4972a7c97c..ac30882b6cd4 100644
> > > --- a/include/linux/gfp_types.h
> > > +++ b/include/linux/gfp_types.h
> > > @@ -316,6 +316,13 @@ enum {
> > >    * preempt_disable() - see "Memory allocation" in
> > >    * Documentation/core-api/real-time/differences.rst for more info.
> > >    *
> > > + * %GFP_ATOMIC_RT is similar to %GFP_ATOMIC with the addition that it can also
> > > + * be used in context where preemption and/or interrupt is disabled under
> > > + * PREEMPT_RT, but not in NMI or hardirq contexts. The allocation is more
> > I'm not sure 'GFP_ATOMIC_RT' really communicates all of this information.
>
> I am not good at naming. If you have other good suggestion, I would like to
> hear it.

Haha herein lies the pain of naming - I am not claiming I am great at naming it
either :P

But _RT feels way off the mark for sure.

I mean in general, I'd rather we not add a new shall we say GFP flag alias? You
suggest an alternative approach in 2/2 so I'd definitely encourage you to
explore that first.

But if we were to add this, I'd prefer something like GFP_INTERRUPT or such? I
mean that's pretty terrible too... but something that points to the key feature
of being usable in contexts where preemption/interrupts are disabled.

>
> Cheers,
> Longman
>
>

Thanks, Lorenzo
