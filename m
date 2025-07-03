Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145625A333;
	Thu,  3 Jul 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574944; cv=none; b=fT7jSu9xN9rFM1RG4zPiTvnn0kYbug8D1MU/TJ4p6mGwDEq6wx0htWjV5W7mx/lFvi64OEQ0wVb2G6CkzcKouN8HmrvI4abTw1pYbQ9x6xQj6NgfqjwUvhXHnj8rKU8Dpscbwo9OVc0lBOpCXfqSaxM1Cqw9RT1jag8vuEimGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574944; c=relaxed/simple;
	bh=pVdIOPY7Ro0del+0heKooS/R1gj5ie1weCQMVrLfGno=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LWq8+DPj3t9/a0mWBXjKIjmQpK9fluxDjQU1FibEov8yKr0pb3vlGehQAXInWIQ0Pcn7HSGZevP+4f0rJBMXBTkL68eF7bIwoJTr9h8R1P1XFjnFDzxkFG8icUL1CIhFpN4LfFYrZDHSfJBwGsx+VNF8/jcQu5PdQRs8/ntZeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R4fI54Mx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R4fI54Mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41664C4CEE3;
	Thu,  3 Jul 2025 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751574943;
	bh=pVdIOPY7Ro0del+0heKooS/R1gj5ie1weCQMVrLfGno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R4fI54Mxj6QHsAAOAeoV190DscJoLR/x3bJ7wtanPBdnNInG3neKCqgtEyRqF68YM
	 axmakqbVm7c5IF0+0WU9QZojQKP4GM0fwKLgakOGc/hLjg9dKO0e1AkyqvcZ4NKg/o
	 ySiAor7Az2ll7pZCJH0BoMQqlH3aLwXLj7n87mVQ=
Date: Thu, 3 Jul 2025 13:35:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, byungchul@sk.com, max.byungchul.park@gmail.com,
 ysk@kzalloc.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-Id: <20250703133542.b9d61290725adee655c9b491@linux-foundation.org>
In-Reply-To: <20250703181018.580833-1-yeoreum.yun@arm.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Jul 2025 19:10:18 +0100 Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> find_vm_area() couldn't be called in atomic_context.
> If find_vm_area() is called to reports vm area information,
> kasan can trigger deadlock like:
> 
> CPU0                                CPU1
> vmalloc();
>  alloc_vmap_area();
>   spin_lock(&vn->busy.lock)
>                                     spin_lock_bh(&some_lock);
>    <interrupt occurs>
>    <in softirq>
>    spin_lock(&some_lock);
>                                     <access invalid address>
>                                     kasan_report();
>                                      print_report();
>                                       print_address_description();
>                                        kasan_find_vm_area();
>                                         find_vm_area();
>                                          spin_lock(&vn->busy.lock) // deadlock!
> 
> To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> 
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")

Three years.

> Reported-by: Yunseong Kim <ysk@kzalloc.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Thanks, I'll queue this (with a cc:stable) for testing and I shall
await the conclusion of the ongoing review discussion.

