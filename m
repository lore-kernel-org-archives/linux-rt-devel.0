Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D5340A76
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712863; cv=none; b=Pdo3V45iczgdtqYK9lgjQUL9eAhBC/FaqcnQ8Ek/Qn4ma+t4KRVesMpkCv2EC4zRIojidpui3Hj7vDH5DCy/e2OLbz5Rj+SmYU+gKFwl/+fbmdaz8jA7vTv7/3M8ZzSx2NoY9kl2n3BTBCwU8Zc2N7PEw8a59kNPuwu4zUErzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712863; c=relaxed/simple;
	bh=KS1C9bAwlDhZvSLMwp9flwtHD0RxO1IUENqc9t4uHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYMI8Mo79CcH9FG4Zd0VQpkWC+0orowYHFGodJo6Uh7ByPXvEO+hU0DBoFAOdjIorg/cNjR6AzZkWP+cCxsrSr2mfI4DiQHQZXga65wwNuFCW0Aw44dtvde/qFDh6bDo4OTIlyLa7P51pFE6PxxLGYwrpydzShu0qJr/So3Ot5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 384438ABED;
	Tue,  6 Jan 2026 15:20:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id ECE9C2000D;
	Tue,  6 Jan 2026 15:20:55 +0000 (UTC)
Date: Tue, 6 Jan 2026 10:21:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark
 Williams <clrkwllms@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, kernel test robot
 <oliver.sang@intel.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH mm-hotfixes] mm/page_alloc: prevent pcp corruption with
 SMP=n
Message-ID: <20260106102120.4272260e@gandalf.local.home>
In-Reply-To: <04624b16-40ea-42c6-b687-4013796e4779@suse.cz>
References: <20260105-fix-pcp-up-v1-1-5579662d2071@suse.cz>
	<20260105164036.32a22c2e@gandalf.local.home>
	<04624b16-40ea-42c6-b687-4013796e4779@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kadyobb6jxgg53rrgr8pk5kiu7pjqpd4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: ECE9C2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Cnps0ORM9wOahzNOtx0DT319eAQmpInc=
X-HE-Tag: 1767712855-198917
X-HE-Meta: U2FsdGVkX18qn3xbopg0HXbkKioqQiII+KS+SESHqD4DmcTs87FqtTwlrJHklBpNtixlk38wVYTWl58BF19c+TgMm92szMg+VQcnCFJNRD4AHB5RYUf1fMNVhQROcMki6PZDC0Yr/gdYibD8NrC5wWG37/dIiBSLdagQmEYQCqe4JL5jxVSUPjcFfM05fbU3ts99MchYGe3AcRK+OZCbq7ODj7gIEfL2XaQLW0BDxwqvZlqdVSGAODffh/iEG18lJF8gLB7q7qfRDRhLXeXY2dl8zEBMD79afbk00Tj1xF5+SjEf+Sp0KISnnd++GCQG

On Tue, 6 Jan 2026 09:28:29 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> >> + */
> >> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
> >> +static inline void __flags_noop(unsigned long *flags) { }
> >> +#define spin_lock_maybe_irqsave(lock, flags)		\
> >> +({							\
> >> +	 __flags_noop(&(flags));			\
> >> +	 spin_lock(lock);				\
> >> +})
> >> +#define spin_unlock_maybe_irqrestore(lock, flags)	\
> >> +({							\
> >> +	 spin_unlock(lock);				\
> >> +	 __flags_noop(&(flags));			\
> >> +})
> >> +#else
> >> +#define spin_lock_maybe_irqsave(lock, flags)		spin_lock_irqsave(lock, flags)
> >> +#define spin_unlock_maybe_irqrestore(lock, flags)	spin_unlock_irqrestore(lock, flags)
> >> +#endif
> >> +  
> > 
> > These are very generic looking names for something specific for
> > page_alloc.c. Could you add a prefix of some kind to make it easy to see
> > that these are specific to the mm code?
> > 
> >  mm_spin_lock_maybe_irqsave() ?  
> OK, I think it's best like this:

Yeah, thanks.

-- Steve

> 
> ----8<----
> >From a6da5d9e3db005a2f44f3196814d7253dce21d3e Mon Sep 17 00:00:00 2001  
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 6 Jan 2026 09:23:37 +0100
> Subject: [PATCH] mm/page_alloc: prevent pcp corruption with SMP=n - fix
> 
> Add pcp_ prefix to the spin_lock_irqsave wrappers, per Steven.
> With that make them also take pcp pointer and reference the lock
> field themselves, to be like the existing pcp trylock wrappers.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_alloc.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ec3551d56cde..dd72ff39da8c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -177,19 +177,21 @@ static inline void __pcp_trylock_noop(unsigned long *flags) { }
>   */
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
>  static inline void __flags_noop(unsigned long *flags) { }
> -#define spin_lock_maybe_irqsave(lock, flags)		\
> +#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
>  ({							\
>  	 __flags_noop(&(flags));			\
> -	 spin_lock(lock);				\
> +	 spin_lock(&(ptr)->lock);			\
>  })
