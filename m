Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBF47CA95
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254858; cv=none; b=qNxk2ulw6Oi1vNfMFGrwZC80RtzGTwCwCzBmnxDKfKaFGeKz/DWVsFgANgWz3B38Jq/LflrdgocQ6WMtgKjZ6nU619vehb//S5h1VWcydtX014pLk8szWzi3XwSL1uPLUNhniGKatiIgJk+f9UrVslGy9jEPNVlmc3RUwDa9uOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254858; c=relaxed/simple;
	bh=nPpXfR6NAp88fxH/7MU90CJYM/Ds+nZslD3wQ7OxXNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CSJXOGKmsc5o3tlnc/Mm4RQFp5xjxv93Kc9DoZnfonWluIXzGXZBekGGJFAEkTz3ujjBy7QDyn0wN668w9kEnmHGlOAIQwuI6rRB7uNOL0JKwyblf6LGFwejWn97s2rDi/cMARknVWbNzFNaE8sJDBacMpRR46I5WZBWRNJ4ZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LenEXTyP; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LenEXTyP"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso331885566b.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788254853; x=1788859653; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdC630qSepMOzA2lVAlUNAGtTB350vu7dUwfU0LuExI=;
        b=LenEXTyPwVvUSatBRfyu04ScLs8vGQqiSycliVbmuF1/taOjCXQRwGUkkms/wrDbod
         l3gRmo6qS97M3ZIzl7eC9v+hRQHC0Wqf3vvb8c84NjHRrCWf6jFajQITLoX42Jn7WUFa
         HjzHDh4Md4wsbB6JAffHlrwzxqiuMkHEHiAw/BBZ+HT8QsasC+LzpamvoscDuX1l5P/F
         Y3xQpPw1y+6YLMnvRL4RzcepGe94W7cbBqP3rmLhghOrLW5eg0LBCT2KpdWp8AH4dNQ7
         wcTKWP5Zqt45b/Bh7IAyQgAC06yxq1Rpsggg0bfnkP5UN5gbjryQH6V66zon6U8rJsqw
         NMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254853; x=1788859653;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdC630qSepMOzA2lVAlUNAGtTB350vu7dUwfU0LuExI=;
        b=BSIfmZQPRYx3Q7b+9iOtoqE7YFFtweAYTTD3w2e35vbRPajZTIj0lh/KmB5I18S0wB
         xj/DQzkYp1CMTuKVa56MTKFl40aBTutqHUE9RNK5dFALwDf0+MD8c2tzKq+yKPPKDwiq
         4WFQGX/05xckKqJLNzqVwmDaGAiBcptQbXyN2+N6hycIfMW20vVw4kIrwU6Uramx7Dir
         fRU6md33mU2/xVQoAtpAzqnnMa/aGN0+U4irB/a2aIgCuJGiA/OpZn5IWnpxO258uBhH
         QNvKqFUoQHX4vaJnPvtvV1el+FVP9j1CgeUW+oq+42tqZnXT8rWz+FbTS9/DyZE3Jdwz
         90FA==
X-Forwarded-Encrypted: i=1; AKwUvByLboPXq5ECKMVovBM2FQZlF9wtyKzKqcUwssuUDZ9OHVR9YYp8Oy1rbh3/9aUml6F9Vn6x3ODcpCtLXkNgLg==@lists.linux.dev
X-Gm-Message-State: AFuF++mYeLAOwwUkCguMe5uWBWUhBUJ7Vzx//H9MQ0PkNv6KCjvZGqKP
	B6xc47Mdq99F1l2N8sHyYCcH8XCf420wxVOzwcpU143z9cY01nmunWXJ988aNYMt0FqJMtaysUP
	CC9vzn80MmyKOyTQnIA==
X-Received: from ejblv5.prod.google.com ([2002:a17:906:bc85:b0:c20:221c:9ee2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:18cb:b0:c25:848a:4a8d with SMTP id a640c23a62f3a-c25848a4edamr1140296766b.5.1788254852741;
 Tue, 01 Sep 2026 02:27:32 -0700 (PDT)
Date: Tue, 1 Sep 2026 09:27:31 +0000
In-Reply-To: <20260827232948.2520558-9-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260827232948.2520558-9-stevensd@google.com>
Message-ID: <apaagy0KJRPVtwHM@google.com>
Subject: Re: [RFC 08/10] Set PF_RECLAIMABLE_STACK in various places
From: Alice Ryhl <aliceryhl@google.com>
To: David Stevens <stevensd@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 27, 2026 at 04:29:46PM -0700, David Stevens wrote:
> Annotate various blocking locations with the PF_RECLAIMABLE_STACK.
> 
> Signed-off-by: David Stevens <stevensd@google.com>
> ---
>  drivers/android/binder/thread.rs | 14 +++++++++++++
>  fs/eventpoll.c                   |  3 +++
>  fs/pipe.c                        | 28 ++++++++++++++++---------
>  fs/select.c                      |  3 +++
>  kernel/futex/waitwake.c          |  3 +++
>  kernel/signal.c                  | 36 +++++++++++++++++++-------------
>  kernel/time/hrtimer.c            |  3 +++
>  rust/kernel/task.rs              | 16 ++++++++++++++
>  8 files changed, 82 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
> index bc0ef8927905..be62f7fd43ca 100644
> --- a/drivers/android/binder/thread.rs
> +++ b/drivers/android/binder/thread.rs
> @@ -538,13 +538,21 @@ fn get_work_local(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn Deliv
>  
>          // Loop waiting only on the local queue (i.e., not registering with the process queue).
>          let mut inner = self.inner.lock();
> +        // SAFETY: Only accessed locally in this function
> +        let current = unsafe { Task::current() };

You can invoke kernel::current!() instead to avoid unsafe here.

>          loop {
>              if let Some(work) = inner.pop_work() {
>                  return Ok(Some(work));
>              }
>  
>              inner.looper_flags |= LOOPER_WAITING;
> +
> +            current.set_flag_bits(bindings::PF_RECLAIMABLE_STACK);
> +
>              let signal_pending = self.work_condvar.wait_interruptible_freezable(&mut inner);
> +
> +            current.clear_flag_bits(bindings::PF_RECLAIMABLE_STACK);

It would be nicer to define a guard type like you did in C so that this
is less "manual".

> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 38273f4eedb5..6168f058343a 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -344,6 +344,22 @@ pub fn group_leader(&self) -> &Task {
>          // only be used while `current` is still valid, thus still running.
>          unsafe { &*ptr.cast() }
>      }
> +
> +    /// Sets the given task flag bits on the current task.
> +    #[inline]
> +    pub fn set_flag_bits(&self, set: u32) {
> +            // SAFETY: The `flags` field of `current` is not modified from other threads, so
> +	    // the non-atomic update isn't a race.
> +	    unsafe { (*self.as_ptr()).flags |= set }
> +    }
> +
> +    /// Clears the given task flag bits on the current task.
> +    #[inline]
> +    pub fn clear_flag_bits(&self, clear: u32) {
> +            // SAFETY: The `flags` field of `current` is not modified from other threads, so
> +	    // the non-atomic update isn't a race.
> +	    unsafe { (*self.as_ptr()).flags &= !clear }
> +    }

It looks like the indentation here is a bit off. Please try invoking
'make rustfmt' to reformat this code.

Alice
