Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CE37E315;
	Thu, 21 May 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381639; cv=none; b=fbwkUUf86Mm0qB6YdFLZsUXnDarng7wZdTY8Ct8mGN5KU6MQA1pBOnWmexnDW8JX06oWtheGDIXWPRRCmrZM/evvcyelg6DwsCwD8NPtgSeFyWhV4Oz0c6ZyczqxNjDnhwNcAdJmSDFp+Pw3bu+k+xzAEmOcpqnn3pbngmNfgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381639; c=relaxed/simple;
	bh=tgzyCoAPKpw1NSC34RTwXXrjyq07LoKbjwH//9PPF7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghrax2nhIAzmOdvmyWUgYcLGsBy/L7JQrp4BzR+u2eSiaFTNVl2D8HKLUs9FAZA7fXJB/oTgDZpa2qzx+0lZzP9TbeCrmlFaRRnCochtvkOG6E3ojy9c7x0dZz/p4LcGxn8kRO8FoXc6lJLOMfazFSsC2xGCg/JWNQJ4i5iVRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG/Z7QUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG/Z7QUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8051F000E9;
	Thu, 21 May 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381638;
	bh=2YGGMyXe7SMejzK+iwa7+2TNKMnNR9YtdBRWN/ulgbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fG/Z7QUpeZCEYhug5SVVxPYIo0JfhG3m2rPSBOkh2oi7CZgxxvB9zjFWuTOIVy5cY
	 WibkXJmWrgbFkp7QHACq5F6Iem5WFdybG71CCCQXQRLn6OhOj1sqIbllxlDq9rWych
	 k/HgBFcenei9SY6H7SZBfeYEoV3FeNc6blqLlL/dLvy1wOk+hF5rkTY6FpmDroESSW
	 5gLmhOhlH1x6Gh56UTM5lm9dycJvAAQL04TK+0rmz+Rz4Y2SqPQWmV9PN+UGN/P2dB
	 +kLiHstSBHah9ZoE5aC8tSp9SoddkWbQWO5752L+NPURwmmY3x7o3FCOiC+dqEGYM5
	 I58LauGj0TyDQ==
Date: Thu, 21 May 2026 17:40:32 +0100
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
Message-ID: <ag8zX5KJUKo70TvG@lucifer>
References: <20260520204628.933654-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520204628.933654-1-longman@redhat.com>

+cc Matthew who has fairly strong opinions on GFP flags and such :)

Also, please don't send 2 patch series with 2/2 in-reply-to 1/2, use a
cover letter + have patches reply to that :) [yes it's one of those
subjective things that people differ on a lot but generally how we do in
mm]

On Wed, May 20, 2026 at 04:46:27PM -0400, Waiman Long wrote:
> The GFP_ATOMIC flag is to be used in atomic context where user cannot
> sleep and need the allocation to succeed. However, it does not support
> contexts where preemption or interrupt is disabled under PREEMPT_RT
> like raw_spin_lock_irqsave() or plain preempt_disable().
>
> With the advance of the ALLOC_TRYLOCK allocation flag in the v7.1
> kernel, it is possible to allocate memory under such contexts by using
> spin_trylock to acquire the spinlock in the memory allocation path. This
> does increase the chance that the allocation can fail due to the presence
> of concurrent memory allocation requests. So its users must be able to
> handle such memory allocation failure gracefully.
>
> The ALLOC_TRYLOCK flag will only be enabled if none of the
> ___GFP_DIRECT_RECLAIM and ___GFP_KSWAPD_RECLAIM flags are set.
>
> Introduce a new GFP_ATOMIC_RT gfp flag for those PREEMPT_RT
> atomic contexts.  This new flag will fall back to GFP_ATOMIC in
> non-PREEMPT_RT kernel. GFP_ATOMIC can continue to be used in contexts
> where preemption and interrupt are not disabled in PREEMPT_RT kernel
> like spin_lock_irqsave().

This seems like the wrong place for the solution, now we have to remember
to use a specific GFP flag but only in one specific place in some IRQ code,
yet RT is fine with this in any other scenario?

This is really confusing.

Wouldn't we better off with a way of actively detecting this context
somehow in the page allocator?

It just instinctively feels like this is the wrong level of abstraction for
a fix here :)

>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/gfp_types.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index cd4972a7c97c..ac30882b6cd4 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -316,6 +316,13 @@ enum {
>   * preempt_disable() - see "Memory allocation" in
>   * Documentation/core-api/real-time/differences.rst for more info.
>   *
> + * %GFP_ATOMIC_RT is similar to %GFP_ATOMIC with the addition that it can also
> + * be used in context where preemption and/or interrupt is disabled under
> + * PREEMPT_RT, but not in NMI or hardirq contexts. The allocation is more

I'm not sure 'GFP_ATOMIC_RT' really communicates all of this information.

> + * likely to fail under PREEMPT_RT due to the spin_trylock() nature of lock
> + * acquisition. So the caller must be ready to handle memory allocation failure
> + * gracefully.
> + *
>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
>   *
> @@ -388,4 +395,10 @@ enum {
>  			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>  #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
>
> +#ifdef CONFIG_PREEMPT_RT
> +# define GFP_ATOMIC_RT	__GFP_HIGH
> +#else
> +# define GFP_ATOMIC_RT	GFP_ATOMIC
> +#endif
> +
>  #endif /* __LINUX_GFP_TYPES_H */
> --
> 2.54.0
>

Cheers, Lorenzo
