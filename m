Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FD3F4DD2
	for <linux-rt-devel@lists.linux.dev>; Tue, 22 Sep 2026 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057067; cv=none; b=ZrCLKELawiFt7P/q0/CNIlAxxUJ4UOsW2vRXaljjyM1JJifI3JN7OnnF+j7E68/IHcQY1ktkc0VrdxpQqE57cPrPZqZMyNWf04wAGwStxfBRNjZqoaQkYeoYtZ8Oi9ZqEGKIB2BFV1WFhTgy8spEXe5dzgOogDDhhI8Gks+qaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057067; c=relaxed/simple;
	bh=ElBhcqsUM2Ad9S8ZEGyEN9t/tY74rVMwa0Q7cwzZwxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYkfQmvDfldxguSAGcALpuWDACxOBP0eKJ7Eixa1bqtfvAcb3FJHH12eN8DRMXgHi5pskqNWyCY8Rs+sKm3RECPU3rghqOtI4gaGRn7SqImf3ZO+s0jNL2DUIM7twKGtH9qN2KL3yhIRO0zWyS7NHc80btF5I746M2cs6848Pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0E2PlaI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0E2PlaI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so25534335e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790057064; x=1790661864; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZ4t+Je/NuLiMzspe4ek1fsrc4XzG00tppqvK5+4Vd4=;
        b=p0E2PlaI/XLrBIIVd5cBvac786V1U27sR+iXU5qYHgkCOkfATRRRvohiXI5F4YJkyN
         het+Cy39AOF2szNAAW0vqXEn1MVvE2i8SmynOlm/wXmnA1sCMybssLOrRruONCVGFpiU
         lGioJ1aNPX0xCQHfPl+Ba+EHBjuJ38cDt0Hp9s+Atg30D+U1kKsFr9zvIyHlsAAQcWqp
         yF6ZJXR0t/D/yUHK7x6WRa3mjE8Bi1T8oQ6QAK604dsmRjOe5JbI623OMWXaQY4fiCDc
         rgciwlIbngta6vdl1Nep3jUUdB0I5n5rYhcXsmiytragfBmAaKb71yUr241DfxAjTc58
         nQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057064; x=1790661864;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZ4t+Je/NuLiMzspe4ek1fsrc4XzG00tppqvK5+4Vd4=;
        b=1mw8PjbHn0y03lG9qXhCJw0L6dSBmZSA0Y6v7BQPXeVAyDOcFRdWEpjgR77wCvvCx6
         kPtylVmg8lQzumrfSFQtryJidVWgneVH+fCf+3GZhL4q9YLkbpkLe9FJDy5tvRfbM0F7
         kr9tl2RImTEUGFX2rtp452ljzT4lSEC2D9yBH8AHBUcyXFbrwDOa+zksnDwv4NBOe3wm
         qVDQLM75ZGRJPYMkBxU7fo9MLXK6+4vC4GS5vAesWI8WuBwMQVzVvWrNfjHhnRs50yPA
         eCsk6GgGp5Xi4GwaKjuG4FwJbBoIeDb+XQGNzf/3hhPNh0bTn4jCEUCWK+zNhRKyhi1l
         9SmQ==
X-Forwarded-Encrypted: i=1; AKwUvBys1mEKC0XUYFO9Bf8heuO1b8nuPmOLa9cdTfGk2JiFlc2fv7iiswEbuelgVuFhRgZ0jj4+PKogWpNuTW7VfA==@lists.linux.dev
X-Gm-Message-State: AFuF++k6IDmo47wm+rGX/BiBiWm6OyjyPCzftxPUxFY/S79IY5iVMbyO
	7RUSU/jk/bIRVWh3WU2qF5+nMCiyZd1xET4Iu4oGQw4u7qckQ9SavPnx
X-Gm-Gg: AYBFou1/Tp80vw8H2wnYj9437pt1b0TxT6kVg7g8w77/xfZPhGK7G70q4j9Vj+jTCCp
	TPrtt4x8DunRV5aY2ppVWieA5TzBGl8xzC+ClumvByZUkA21aJ0rxokFsswist6y0E9UKtkigDp
	8ab518Fc7meEMrAPHaKCtP3AuwGp5LYDMN+51nxbtui1xCorEKUy5L4eZESoHgN4rApW+nH4Uln
	bNlK9HmYgbAfUw7Kkz+zcG20IgDwkDwlJ82wNdoLnAXiRlUcyjDesrq41oeBX9cgkX/NTTNWhEO
	uJ1rwHK+NkLARcRe064GnCR79FCn9xQ6kLAb+WPoKA6z/AnAcOyWgar/9Eg/ZHedlTtW1UD1K0H
	Skw1pkvN77QGfOM3bc1tiZdI4veQOd7RfSfEvzxWt0TTDi67mFwuAzD0cj1MbiPRWStWa03oIRK
	xxKbWYhsySPuTdEEhumXK8bxxLbeqn7pMWVN9u7MYDGsCNgCvd3HG4044OBLy4VvSHa6mPzVtQC
	MGDxY+jiA1FSsPzOQ33GYdxnDfGX69amYNGHUW9TPn9rl4NLZLF4zdcHY+BMymfUU7B4VyP+f16
	EfhOc5H4DF/LLq+Xa+LTI9+aLS2eEma0WbaAIyk2Uyhvwt3KWYd5AMEzhXPbO6Sw+8RSBoQd7g=
	=
X-Received: by 2002:a05:600c:474e:b0:49e:7cff:f8ca with SMTP id 5b1f17b1804b1-49fc5743c69mr172251345e9.29.1790057063419;
        Mon, 21 Sep 2026 23:04:23 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a5e6-3401-ecdc-1e24-2e52-02d6.310.pool.telefonica.de. [2a02:3100:a5e6:3401:ecdc:1e24:2e52:2d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862793792sm2769226f8f.31.2026.09.21.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:04:22 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:04:21 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Hao Li <hao.li@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Amery Hung <ameryhung@gmail.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
Message-ID: <arIY0wMQjCCsqidI@gmail.com>
References: <20260919171443.90512-1-kmehltretter@gmail.com>
 <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com>

On Sat, Sep 19, 2026 at 06:17:30PM +0100, Alexei Starovoitov wrote:
> 6.19 had this check in kmalloc_nolock() only. alloc_pages_nolock() and
> free_pages_nolock() allowed irqs disabled since they were introduced,
> and arena was sleepable only under a mutex back then.

Hi Alexei,

Thanks for the review!

> No. This kills bpf arena on RT.

I have now confirmed by testing that the RFC breaks both BPF arena paths
on PREEMPT_RT.

> As Sebastian said in
> https://lore.kernel.org/r/20260831143500.x-saxdAs@linutronix.de
> raw_spinlock_t is fine in general. pi_lock is special. rq lock too,
> I think, since rt_spin_unlock() can end up in try_to_wake_up().
> The check has to be about those and not about every irq/preempt
> disabled section.

This leaves me unsure where the boundary between the MM and BPF fixes
should be. I see four possible directions:

a) Change MM so _nolock() allocation remains safe and can still succeed
   while pi_lock or an rq lock is held. Existing BPF behavior would
   remain unchanged. Is this feasible, or would it require substantial
   allocator changes?

b) Restore BPF local storage's dedicated allocator, and document, with
   debug checks if possible, that _nolock() must not be used in those
   scheduler-lock contexts. Since the allocator change would restore
   the behavior before f484f4a3e058 and be confined to BPF, could this
   also be suitable for stable kernels?

c) Have MM detect those contexts and return NULL. This prevents the
   deadlock while preserving ordinary raw-lock callers such as arena,
   but task-storage creation from scheduler tracepoints then fails
   deterministically.

d) Combine (b) and (c) restore BPF functionality first, then add
   the MM restriction for other and future callers.

Are these the right alternatives? In particular, what behavior is
intended from the _nolock() API in these scheduler-lock contexts?

Thanks,
Karl
