Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0D14F70;
	Thu, 22 Jan 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110162; cv=none; b=YhSOYzrldfmaPJBsj5QPLzc6OJYTyqaQQOq2SpbpSxwbmxJCC4prIInE0t8jTZiQAED4/8hsER7mBV0oCdf4xXGsyWOeaIcEvGC8SnaGxyVq7PbQ7PwxZjyuw7ME4dY46GQ1w3I/eVrRYP9swg8SxNOg0BRBIVuARLYVV8aUrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110162; c=relaxed/simple;
	bh=TRShzXRqgC1qMNEPnUKst+QX8fiXgfS27vWI+CFO9KM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t4yaPPTp2HlKivgY0fegTMfKTJye0ESrlhA5TCYF9QGqK+6b9ElQDHFwv097xe1DzBD+S8O28+AZ//DIRPKbYclL3P8ng1VNo/OllrNVkv+swFVU69jMtaNIFwwBMHEdfb4lnOxYY5PCsyjJXkVG/Ey0AHqs6gNMcOOegflhU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mSS/NLlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mSS/NLlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A543C116D0;
	Thu, 22 Jan 2026 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769110161;
	bh=TRShzXRqgC1qMNEPnUKst+QX8fiXgfS27vWI+CFO9KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSS/NLlM2o05Lm/uZnfrOKAfF16LBgLUhq27+DlC/6LjrwmwZ9TBjOke0Pw4xv8L8
	 SFwEusrx9UFo95Jv+rPgnXlzaltukTdgWQqWkkQ3/+LmQTyWFKi9oP5y2d40FL0moY
	 91BiMqBSyenppI0G/Fwo7kTNH0SRxISMDzM9hzO8=
Date: Thu, 22 Jan 2026 11:29:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3] mm/mm_init: Don't cond_resched() in
 deferred_init_memmap_chunk() if called from deferred_grow_zone()
Message-Id: <20260122112920.2b435873a0cc5f396df5d1a7@linux-foundation.org>
In-Reply-To: <20260122184343.546627-1-longman@redhat.com>
References: <20260122184343.546627-1-longman@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 13:43:43 -0500 Waiman Long <longman@redhat.com> wrote:

> Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk()
> in deferred_grow_zone()") made deferred_grow_zone() call
> deferred_init_memmap_chunk() within a pgdat_resize_lock() critical
> section with irqs disabled.
>
> It did check for irqs_disabled() in
> deferred_init_memmap_chunk() to avoid calling cond_resched(). For a
> PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
> interrupt but rcu_read_lock() is called. This leads to the following
> bug report.
> 
>   BUG: sleeping function called from invalid context at mm/mm_init.c:2091
>   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
>   preempt_count: 0, expected: 0
>
> @@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  
>  			spfn = chunk_end;
>  
> -			if (irqs_disabled())
> -				touch_nmi_watchdog();
> -			else
> +			if (can_resched)
>  				cond_resched();
> +			else
> +				touch_nmi_watchdog();
>  		}
>  	}

Disables the cond_resched() in some situations.  Can this reintroduce
the watchdog warnings which that cond_resched() was intended to
prevent?

The cond_resched() was added by <dig, dig> da97f2d56bbd ("mm: call
cond_resched() from deferred_init_memmap()").

Pasha's 2020 patch replaced touch_nmi_watchdog() with cond_resched() to
prevent RCU stall warnings.  So I think the answer to my question is
yes, going back to touch_nmi_watchdog() could reintroduce those RCU
warnings.

