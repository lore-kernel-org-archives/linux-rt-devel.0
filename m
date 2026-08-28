Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468A44AB83
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924197; cv=none; b=SVOxR+2w2RVj3ARYfpT3ti8ehTvjg7PLprYfV3ZUCbryBO9yxIzoaGp/MmteGn1S8g7vNyPFa8VbZa6GT2O5TBfwAS/1E68ArF12zbOo68dHZN/wErKLfXD52sSqKMyEHPSOSA7d4PJIh8V4GHJLa4oeI7WU8M/fCtwMxVGc8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924197; c=relaxed/simple;
	bh=Fma1IpH+7fDUUAe0L/pRsviNIhxjKEH7xvkFRr2tGUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eudR9wOSgTYpP7+ltK787OY8wYxSZ0YgWWvwOnhSdD2p0FmdPkZ70W/1BTyk2pgKzKzmGSZRFgh1o+IaIzAqDPnmdFvsUjdEdcOMYPmqnX5dReuZGkrQX3NCOn103SDX5rpTHhvv8lHK8XetVxLNX34pHadRAkBlEDfZYSf+TaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zHr5gm9u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2slVRRU9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zHr5gm9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2slVRRU9"
Date: Fri, 28 Aug 2026 15:36:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787924182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q2R0OExeXoLUYFz9ysgWw29sTN/8ZU4lxybQbrXgrZA=;
	b=zHr5gm9uJuQjJaXQweR/D4yoAZIHaeIlhRtOxuM7xYfNDxomg3PvGnrXsvi2LhBnduI+1g
	Puj4mPxNDqKrow+lXe6p/m3FfqH9dks62FzRj9uE3ArSrxKZAlAbg5DieZzD7TQx8wiUsz
	VtKSbVgIxqyr1NYWJjwiN/amwniaCzF8b89m/0RJVhEYiqEs/qLTtZWlAm2UFTPLlSfvMh
	Oahq3izuqq6VGWa8c7D+ctlV6AAmyH1bitLxM9g22/pYE02kVc6BHdBx2uKwXHd4GjJH7w
	saOSvYbOSReT1k23eIS23OM/bq1Ww4og3bFMIgkMrDxpfZFTEuaA0K2KW2tr+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787924182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q2R0OExeXoLUYFz9ysgWw29sTN/8ZU4lxybQbrXgrZA=;
	b=2slVRRU98UPacC+TgkLGX3+5I6jfQVk3efEXBJ5yWyG54KCToYRd3d3ZEA1xWi1HMwwKEu
	Qn6vvf+pLEb51rDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Stevens <stevensd@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260828133620._x2XfJR_@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827232948.2520558-7-stevensd@google.com>

On 2026-08-27 16:29:44 [-0700], David Stevens wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index fa7507ac8e13..adb4a5957996 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1534,6 +1534,24 @@ config VMAP_STACK
>  	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
>  	  must be enabled.
>  
> +config HAVE_ARCH_RECLAIMABLE_STACK
> +	def_bool n
> +
> +config RECLAIMABLE_STACK
> +	default !PREEMPT_RT && !PROC_KCORE

This shouldn't default like this for RT. It either is useable or it is
not.

> +	bool "Allow stacks of some blocked threads to be reclaimed"
> +	depends on VMAP_STACK && !STACK_GROWSUP
> +	depends on HAVE_ARCH_RECLAIMABLE_STACK
> +	depends on !DEBUG_STACK_USAGE
> +	depends on !KASAN_VMALLOC # TODO: add support for this
> +	depends on !DEBUG_KMEMLEAK # TODO: add support for this
> +	help
> +	  Enable this to allow the unused portion of kernel stacks of most
> +	  blocked tasks to be reclaimed.
> +
> +	  The wakeup latency of tasks with reclaimed stacks may increase,
> +	  especially while the system is under memory pressure.

It says *may* increase and on RT it _definitely_ will increase since
there is a kworker involved not to mention the memory allocation itself.
Anyway. This either needs to stay away from PREEMPT_RT or find a way to
exclude at the very least mlock()ed tasks.
Did lockdep see this?

If I understood the whole exercise correct then you have a kernel stack
of two pages and in best case you can unmap and release the second page
while the task is napping.

What might be a tad simpler is to memset(,0,) the remaining part of the
stack. Since the stack is vmap-ed it should be swapped out on its own
without additional tricks. That memset() would help zram to compress
better so it uses less memory. ta-da.

What also should be simpler (and I am not saying just to move you away
from the scheduler) is to have a shrinker which iterates over all tasks
which are marked for reclaim and then similar to swap just unmap both
stack pages and release the second page which is not used.
Upon wake up the task should create a page_fault which would be used to
allocate the second stack page and map the whole stack again.

This sounds simpler.

Sebastian
