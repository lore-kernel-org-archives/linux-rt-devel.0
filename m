Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23364272905;
	Tue, 11 Feb 2025 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314652; cv=none; b=sTBM54hXFoeBN+P1JoYeUYvDkigl/Htf/hiCG/YdXMUNmeCzP7iXoUS6C7kBpvQH17htT1Yi3TtE02L3CFyiCA20IfY4MDRCwOdK0jznCLEkOcDUoF64/17DCtlVzHjV1ZkA7bF+h+dQ4LnhQaKBe9fXi9srzVD8G+01QwiPvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314652; c=relaxed/simple;
	bh=l3wCHtuiiyz1DjVrycJOAarx4FFHHVF/wtuFwDWPK00=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hqKZjmsNadcaKytpH+MQfPqqF12PbXQw+ccfHukjluJ7FLHYL+mTozjcQNx2H2+aGsvEBhffOPge49GbB2W8UcNrpbYXj0YSbvyxF9Wl/wnPSKe3c/EYcf1579HR4v0EYPYbrhnq9gp9gBjgaNchqWPTmnuqEW6/X18oejK1jJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BPCIvq52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BPCIvq52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C955C4CEDD;
	Tue, 11 Feb 2025 22:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739314651;
	bh=l3wCHtuiiyz1DjVrycJOAarx4FFHHVF/wtuFwDWPK00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BPCIvq52OzV94jnl5cNujgSvko+IxN/iCUFzL/s9gW9d8+UdJ4SP0lPDTrJMrpQlJ
	 GDgw4fMp3w9ZKLdJ6I47NMJIZq1bM1Lmf9wHpwckTTN8m/tmDxGf9m8aDcnHxkfS/j
	 2k+IgzSMBL4kgvH/vwraRO8Uf5RRgVnnLTtp7lcQ=
Date: Tue, 11 Feb 2025 14:57:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Nico Pache
 <npache@redhat.com>
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
Message-Id: <20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
In-Reply-To: <20250211160750.1301353-1-longman@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 11:07:50 -0500 Waiman Long <longman@redhat.com> wrote:

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
> The print_address_description() is run with a raw_spinlock_t acquired
> and interrupt disabled. The find_vm_area() function needs to acquire
> a spinlock_t which becomes a sleeping lock in the RT kernel. IOW,
> we can't call find_vm_area() in a RT kernel. Fix this bug report
> by skipping the find_vm_area() call in this case and just print out
> the address as is.
> 
> For !RT kernel, follow the example set in commit 0cce06ba859a
> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
> inside raw_spinlock_t warning.
> 

Thanks.  I added it and shall await review from the KASAN developers.

I'm thinking we add

Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
Cc: <stable@vger.kernel.org>

but c056a364e954 is 3 years old and I don't think we care about -rt in
such old kernels.  Thoughts?

