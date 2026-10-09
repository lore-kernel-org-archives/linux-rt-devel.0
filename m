Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5F3A3834
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540281; cv=none; b=QMj5ENDrSTDKKoTefg9q9TbCLgSRvtlHYFwZLBJWK0XTSupuVdcQ3lV7Xj/zPDZg9Tc/2yoTI4TfGZxEliB4nW187UvTh+92gQ54+USIHP70D024au/399rVKu0Q1vq6nfwleuGIiAu87q/38Ux3Bk5qAlCMKa0qrJHn92vW1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540281; c=relaxed/simple;
	bh=5yLkz2OZBQ4ipEjXEN7/lCEXtkQpCiwl45030Q1M6lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K21634kKaJZyZiQOoGd25UMC6Xq+7XIrsNnp87y0YfmfGi/W+3/Lr1kMgHWIkVYMnxJeBBTEEiyMVvBwGWlZiGks15f5OqJmuSw6HmLlFcvCiRPaEkLi0j/7+pxkHkRQQcNA+oij9MRO+/bGG/XIjyECs31IbWv6kCIiuem1ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pO+Yvk/i; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO+Yvk/i"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afe75f055so5582801f8f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791540276; x=1792145076; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCfrYFQWaB6ljrpcA5mB+GvPCr6ztXX1INv06kJj6BA=;
        b=pO+Yvk/iNBTZ1erC9K7SQdfY7ZKShNLncTmp/61RTWoYp/AYBLIweTF8EAwQ8RmoXf
         qLqYqYLWCyJ/+BixPBn8JpJemHUT3JEoLvRvex5J22xGHXd6pcJjAvHgPFWtlzXSskl0
         Qo5zC1aB3MY0Y4gmG23jyfrSokenJTItAtL1CRjX8LHsgJTNBYY4uLXcPj7NrpQs5HEL
         H2kx7kWyXmXgJY6hIXUGWonjXbU2tdLxWJObczARTvy11G8CugAKCIBPIADs0Y7ILdkX
         bQ3A2CCoCPB0Pr1Hc7KS68DZKnULQv9ZjYNz00QSXR3beUTEIN6jCWKRKoVLNJUUjWs0
         2LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540276; x=1792145076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCfrYFQWaB6ljrpcA5mB+GvPCr6ztXX1INv06kJj6BA=;
        b=nSUt3OGKa09Q9oa2ADjCb59v3dt3XLpOqP+bLEI3ymqTyg3ATsIbsfBv7zCrNsQHCn
         b1NO1n1PgG5iEeDDxKbv6Z/1Aku4T3CbuNbF+uQKl/fAbKeiXz9khrnF7uYvJgOeMf+I
         CmPBvcCbyyWWBZqx0mVxBfHd8suios9Q7cYOCr67K0f6nGSg3q1PVGpz4VjPikHOO1ul
         J2eY7cXiSq09mvUAJcEqiMzOI5/mN3JjdFTA1jtKNP6XBxk1JGGuc3NMwloztVYfyzhh
         9oY41GA6Irklw30utGBvFTuABpLCAdAHeVJcG/ZyNlAeOiETxyVljvgY85gGhjZ2EuII
         3kAw==
X-Forwarded-Encrypted: i=1; AKwUvBwzXhSq1Be7xLuZTN+AEZWSCqp1g/URFgXrh2OGdahgxuuAxGjSOADAZDIEiihCP7iLLmiW1OapFumFWe000A==@lists.linux.dev
X-Gm-Message-State: AFuF++mWWXAmMwrHHdGtzBtRkKzo3T7p7B4DKEO4sFuEhXDbRovGxWML
	vwz06FwHiUMKUml3OZLcod8XbjWjxUD5i8kx9O8wZvh34C1Z1wVpm295
X-Gm-Gg: AYBFou0DoOLwv5juxJiitc4b+dYA+4ie+w2Py1872rXmC8i19UG38dGxCiLTtJJ9lpl
	8eWjSnHPfJ1AA2ZD2oDabXBCuN2T6JFnvnQ1/spVd+plmwmz6JBhOpsi2q4WJkxPVTTRzHCkLik
	M4XVMjDqZhSLFUhvHZBTuN/j9WnI9QNXv0l1T8aMn6Mn0uPMWoA0R3pNMCoUNdCJVI+BXh3nBrZ
	qwa3lqBMy7+RRJHXWqusCu3bAO9X4y92Yw6mHvrQIagn/vclEx+J9MPvjVGNAsNjyYGdnYgkAqJ
	oZKfCD1rxo0PO+ITNge+zRQlRdL7neZ4Z5ed68NUXCOCmXzLNskR4OEd0CVJwPKrSEw7rBFKHNy
	uEBi/JWBMsy4B+lEIGA7UuAjuimtY1uHDOzxvBUhx1CI3hUWjcr7+uG+01lOOObdS5oIcolrEql
	TtObN9HR5B3/rsquK+zi9kpc9vfdFfKrDyzwSj3BeyeArZJ3WqSwOf5kIUaoKnmyMmLl1NLkD3Z
	DkOghyjJvTqJUkD/+dp1uCAuh1gKu3gH1T3CORVEe/sNzQpA//DgQsGPmPGxQ2g9B+wLnFKd4L4
	TWoKywsBvAXTFpWPBUKF90GPki1LiTz1nWwk68PFLtONQcIkxIVAdSoQ1hWBmkoiIPwWDG13PJM
	7vzDWcm84rHxsceU=
X-Received: by 2002:a05:600c:3f16:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a18e44395bmr24842945e9.4.1791540276044;
        Fri, 09 Oct 2026 03:04:36 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm53382635e9.10.2026.10.09.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:04:35 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:04:33 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Harry Yoo <harry@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Stevens <stevensd@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] locking, mm: Add atomic allocator trylocks on
 RT
Message-ID: <asi6Kj3TcCd6HAM5@gmail.com>
References: <20261005070625.8871-1-kmehltretter@gmail.com>
 <asZ8jmWNoGk5tYce@thinkpad>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZ8jmWNoGk5tYce@thinkpad>

On Wed, Oct 07, 2026 at 07:15:29PM +0100, Harry Yoo wrote:
> > This RFC instead adds an atomic owner state for bounded PREEMPT_RT spinlock
> > trylocks. Atomic acquisition succeeds only from the completely free state.
> 
> Please don't skip discussion stage and jump into submitting a very
> intrusive change across locking and mm, assisted by LLM? :/
> 
> I don't think attempts to tackle this problem will make progress without
> discussing and getting buy-in from (PREEMPT_RT) locking folks.
> 

Sorry, I should have followed up on the additional v1 replies before
posting this v2.

On the alternatives in [1], Alexei [2] preferred detecting
scheduler-lock contexts and returning NULL. He confirmed that NULL
returns are allowed, rejected restoring the local-storage allocator, and
raised the RT unlock/wakeup objection.

I initially tried that detection, tracking pi_lock, rtmutex wait_lock
and rq locks. With RT, lockdep and slab_debug enabled, task-storage
allocation under an independently held hrtimer base lock reported this
cycle:

  hrtimer_bases.lock -> rtmutex wait_lock -> pi_lock -> rq->__lock
    -> hrtimer_bases.lock

I don't know whether my changes introduced or exposed the dependency.
The timer lock was not covered by that guard. This was a lockdep warning
and the workload completed.

I then tried atomic ownership in v2 to avoid that unlock path, at
the cost of IRQ-disabled spinning without PI boosting of the owner.

One possible interpretation of "raw_local_trylock_t" would be preserving
the non-RT local_trylock semantics on RT for short per-CPU cache
operations, with allocation failing when it needs an rtmutex-backed
fallback.

Would that be worth exploring? Sebastian suggested
consolidating the existing local-lock variants first. What should that
cover?

For arena user faults, backing-page allocation failure returns
VM_FAULT_SIGSEGV on the RFC base. next-20261007 preallocates outside the
raw lock. Failed fallback allocation returns VM_FAULT_SIGBUS. If
restricting that fallback increases fault failures, is that acceptable?

Thanks,
Karl

[1] https://lore.kernel.org/r/arIY0wMQjCCsqidI@gmail.com
[2] https://lore.kernel.org/r/DLO3RV3IQUOV.21BNLF4QS9T4W@gmail.com
