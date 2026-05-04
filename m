Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8E3CF05F;
	Mon,  4 May 2026 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899656; cv=none; b=m0fPPLvTQKx1MBnjpxFNzUxLf7jG7s+crGgZWTu04eCz8SEiV8GXYT9Uvw5HhB5lQeUzkt0pvYH35IR3y3YhpXKJN6eS8mlTaYh3bE1T1hQ/NQf9GGpo0En0+S+5rNyoh1OrDJBQMhPQabUYQ0mAP6W82kIqdJeBrRiK4TbNSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899656; c=relaxed/simple;
	bh=rqBCEn0JrZGW+v3eAHVpw4MEtcNzSsldS0GztYeDEJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9bP/WWQKX6lzez9UT1aSRYlLpsvl6+sPQ2SVu3IDFuFC3JyxrEfPLN6hsbuUo1w9J0LTEcKw6Rw1aYSpt6QYP+6mFAr7CLmvHLhfmhlDmLgPqbtNDT1RLs01wPUuTWIGZ24vcgHnv+uD65XmimYXoRIdNXhQd231bfRAZlCq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RUK56eiC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RUK56eiC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=baM+1a4/MGHsEkc5EGKyQetKR/6gznfQKOmEmzK2Fm0=; b=RUK56eiCk8E9WuwGgNgpk7085t
	Q/OOy++KGekY9z/aN6hdFVXt1Xsd6bt/ZcD+aGJpuGxOyNAmy73Et5zmQTChcVDQTorncRLt2Efsr
	qD2sYVGuc8OSYmq6eQu6FZXQAQb8yrnjQeqNgjSaNURoN4Gmsip3XxJZcLay9WE7q7A5R4NZD1IgQ
	pRNa83ARi0K/degnnnvn25k6JkNVnA/OmPHZTSnRicAqfLNPzhWoZQ4/KZg+JCW+ejwChgsVfodLj
	Yp9YMJPUaaUOz6fQlKtN/opDqnwUiQBNqvzrB43hUHWF8bnsxcG27jvscyPxvzryGsBp44gNeZEXS
	nvcl5InQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJsuj-00000000tSt-1biL;
	Mon, 04 May 2026 13:00:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6C8B3013A0; Mon, 04 May 2026 15:00:44 +0200 (CEST)
Date: Mon, 4 May 2026 15:00:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/4] lib/vsprintf: Always check interrupt context
 restrictions
Message-ID: <20260504130044.GU3126523@noisy.programming.kicks-ass.net>
References: <20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de>
 <20260504-restricted-pointers-final-v2-4-4934933503e5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-restricted-pointers-final-v2-4-4934933503e5@linutronix.de>

On Mon, May 04, 2026 at 12:47:20PM +0200, Thomas Weiﬂschuh wrote:
> When kptr_restrict is set to '1' restricted pointers can not be used
> in IRQ context. As kptr_restrict can change at any time at runtime,
> this means that restricted pointers can not be used from IRQ context
> in general.
> 
> Add some assertions to detect misuse early, independently of the
> runtime configuration of the test system.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  lib/vsprintf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 021db95087fe..185bd9e61144 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -871,6 +871,10 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  
>  	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
>  
> +	lockdep_assert(!in_hardirq());
> +	lockdep_assert(!in_serving_softirq());
> +	lockdep_assert(!in_nmi());
> +

did that want to be:

	lockdep_assert(in_task());

	?
