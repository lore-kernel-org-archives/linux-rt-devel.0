Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDF224B17
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806994; cv=none; b=Ax8wl7fUhIBzEMMqxBvK1woA/2jjUJJk8rUonB7B3qdD3NAEYFwHalSWQrXpmBv0o0oIxQXRiwnHgkwhGaYg8AtRWgvHy1omfUOltW9APIybm11GQYrjiFKK4F0fJncaGXSfXUliezg3AUnFm7mAB9jH9vvUdj6sGk4MGOKoi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806994; c=relaxed/simple;
	bh=k72aroVKQHh1qZFv7vxVhrfZHBO93j0J4DPoF4u/cxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOxxBpsRnKy188Jz4Ip9XHw2z4Zis/FHx8EIW3u9cjQkLsJsxYpKk9G6vw5ly/YnZOJAJOY4SlP9ZhVijFUrhAthjk9G19XYKy9zEQBsI3pDZnGlXpNGkDwgjgdnPSgJ7srj9DLVZF6WOSoiEtXBNEKzElLhtA1uZUqujICtxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YnKadfTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GcX1TfL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YnKadfTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GcX1TfL"
Date: Mon, 17 Feb 2025 16:43:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739806990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDZt4WFEIPWOyU577sCBTfPji3aQbE2kJD7pIg8nvy0=;
	b=YnKadfTXTur9oD1IV7BrFIiQCYgNj8IqZWEi8ygsR16NH0CuI5iBiMerEGSnyNfg/FVPuz
	WH8HO2XU9JgkDxMQcXPbg7cXEvM6o9fQADFiGitdo6GaExrsGWvhUE7tQ87LnHAfg38cn0
	e4VqU8hT9BLh1e39iP1uxacmZ+9Z1MXMLYSj710sQyDg6G8mCO04pa0sFX+qnYN4IL1HdA
	WVsRfzMNM9uxcuZJ7gieoSkS7LC2jebPBtmnAkojEbSeIG2iQ3oVxy5FkVyR6/Ii8zUQdh
	NJRkya0NEay/ccXX4uQ8FIs861548PohmRq7K1eqki+ntJTBSQECu4X1DxATlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739806990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDZt4WFEIPWOyU577sCBTfPji3aQbE2kJD7pIg8nvy0=;
	b=3GcX1TfLYYuULHDnpmsHLPgysv2FFLSMXuP01TS2qoaN4wCmgEdQT9GPQNgmEyyQbzxuHs
	1/A5lFpbM0g05xBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
Message-ID: <20250217154309.C2CMqCjE@linutronix.de>
References: <20250217042108.185932-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217042108.185932-1-longman@redhat.com>

On 2025-02-16 23:21:08 [-0500], Waiman Long wrote:

I would skip the first part. The backtrace is not really helpful here.

> The following bug report appeared with a test run in a RT debug kernel.
> 
> [ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
> [ 3359.353853] preempt_count: 1, expected: 0
>   :
> [ 3359.353933] Call trace:
>   :
> [ 3359.353955]  rt_spin_lock+0x70/0x140
> [ 3359.353959]  find_vmap_area+0x84/0x168
> [ 3359.353963]  find_vm_area+0x1c/0x50
> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
> [ 3359.353972]  print_report+0x108/0x1f8
> [ 3359.353976]  kasan_report+0x90/0xc8
> [ 3359.353980]  __asan_load1+0x60/0x70
> 
> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.

s/to avoid.*//. This has nothing to do with the problem at hand.

> The print_address_description() function is called with report_lock
> acquired and interrupt disabled.  However, the find_vm_area() function
> still needs to acquire a spinlock_t which becomes a sleeping lock in
> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
> changing report_lock to a raw_spinlock_t is not enough to completely
> solve this RT kernel problem.

This function is always invoked under the report_lock which is a
raw_spinlock_t. The context under this lock is always atomic even on
PREEMPT_RT. find_vm_area() acquires vmap_node::busy.lock which is a
spinlock_t, becoming a sleeping lock on PREEMPT_RT and must not be
acquired in atomic context.

> Fix this bug report by skipping the find_vm_area() call in this case
> and just print out the address as is.

Please use PREEMPT_RT instead of RT.

Don't invoke find_vm_area() on PREEMPT_RT and just print the address.
Non-PREEMPT_RT builds remain unchanged. Add a DEFINE_WAIT_OVERRIDE_MAP()
is to tell lockdep that this lock nesting allowed because the PREEMPT_RT
part (which is invalid) has been taken care of.

> For !RT kernel, follow the example set in commit 0cce06ba859a
> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
> inside raw_spinlock_t warning.


> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
>  mm/kasan/report.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
>  [v3] Rename helper to print_vmalloc_info_set_page.
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..7c8c2e173aa4 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void *addr)
>  			sizeof(init_thread_union.stack));
>  }
>  
> +/*
> + * RT kernel cannot call find_vm_area() in atomic context. For !RT kernel,
> + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
> + * to WAIT_SLEEP.
> + */

Do we need this comment? I lacks context of why it is atomic. And we
have it in the commit description.

> +static inline void print_vmalloc_info_set_page(void *addr, struct page **ppage)
> +{
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
> +		struct vm_struct *va;
> +
> +		lock_map_acquire_try(&vmalloc_map);
> +		va = find_vm_area(addr);
> +		if (va) {
> +			pr_err("The buggy address belongs to the virtual mapping at\n"
> +			       " [%px, %px) created by:\n"
> +			       " %pS\n",
> +			       va->addr, va->addr + va->size, va->caller);
> +			pr_err("\n");
> +
> +			*ppage = vmalloc_to_page(addr);
> +		}
> +		lock_map_release(&vmalloc_map);
> +		return;
> +	}
> +	pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
> +}
> +
>  static void print_address_description(void *addr, u8 tag,
>  				      struct kasan_report_info *info)
>  {

Sebastian
