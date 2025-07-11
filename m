Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5770808
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Jul 2025 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199869; cv=none; b=RJXiZDbWeh764IplMHVevbsJp8ZhHIr5hdakqihY9C2C3gMphEY/xlmRQHgFV7ZJ6ymvjzP++VE62iS+TWYZ+pHhyvm2Y13qp8+pO+6pP4Y4Vvwu6GlCqUopJtpgQCZ9bKCqAC6QWRCK3CwQEaUiGzrFErpI3mysLKqcklFGLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199869; c=relaxed/simple;
	bh=oyqpaHCXNtnH2AyieviUSp/gVpxZ/bNXm0FM0r7skuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYI+7TVvCl46iVdjYsoHDEdNQIBm4kVujLRzU8jwHzC+0GxcoNPbCyIYgafL1hl0OIUv/fT/i0UYZukGl69MRQ3KX5ER2FnsQiU3PHXXVLxIUJYAekP+cuXy760E/9ETplFd5P4m4PxsIxEtfWZOQ6TZuuvAUhdj6ky92BOXUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-17-687072b9b6c9
Date: Fri, 11 Jul 2025 11:11:00 +0900
From: Byungchul Park <byungchul@sk.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org,
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel_team@skhynix.com
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <20250711021100.GA4320@system.software.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711020858.GA78977@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsXC9ZZnoe7OooIMg6/fNS3mrF/DZvF94nR2
	i2kXJzFbLHvyj8liwsM2dov2j3uZLVY8u89kcXnXHDaLe2v+s1pcWn2BxeLCxF5Wi30dD5gs
	9v77yWIx94uhxZfVq9gc+D3WzFvD6LFz1l12j5Z9t9g9Fmwq9dgz8SSbx6ZVnUDi0yR2j4W/
	XzB7vDt3jt3jxIzfLB4vNs9k9Pi8SS6AJ4rLJiU1J7MstUjfLoEr4/WUSWwFJ4QrOtYdZG5g
	3MfbxcjJISFgInH52RoWGHvz8dvMIDaLgKrE7J/vmEBsNgF1iRs3foLFRQS0JSbc+AVUz8XB
	LNDGLPFn811WkISwQKRE87ZrYA28AuYSzU9nghUJCaxnlPj16idUQlDi5MwnYNuYgab+mXcJ
	aCoHkC0tsfwfB0RYXqJ562ywZZwClhKvp2xlB7FFBZQlDmw7zgQyU0JgGbvE8/NLmSGulpQ4
	uOIGywRGwVlIVsxCsmIWwopZSFYsYGRZxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREYoctq/0Tv
	YPx0IfgQowAHoxIPr8Pq/Awh1sSy4srcQ4wSHMxKIrzrfAsyhHhTEiurUovy44tKc1KLDzFK
	c7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTBKeBz6yvDh+PZ8DdbUkoN8iw5FzH4Vlc0l
	MmH219LrNoopYnXpC+6pm1dyr9zLHq7NdvvXhWnSHx9sWr7HY9Lm20uLz++NWDrB47/G+kd3
	tmxxPfn01NmFJ126196uC5vzQFa8Sr4jOztZpbnzckZx5or1+q3TK7dOTJx89JmHyrLLlVcz
	TUPuK7EUZyQaajEXFScCAB4frvrMAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsXC5WfdrLuzqCDDoPuktMWc9WvYLL5PnM5u
	Me3iJGaLZU/+MVlMeNjGbtH+cS+zxYpn95ksDs89yWpxedccNot7a/6zWlxafYHF4sLEXlaL
	fR0PmCz2/vvJYjH3i6HFl9Wr2BwEPNbMW8PosXPWXXaPln232D0WbCr12DPxJJvHplWdQOLT
	JHaPhb9fMHu8O3eO3ePEjN8sHi82z2T0WPziA5PH501yAbxRXDYpqTmZZalF+nYJXBmvp0xi
	KzghXNGx7iBzA+M+3i5GTg4JAROJzcdvM4PYLAKqErN/vmMCsdkE1CVu3PgJFhcR0JaYcOMX
	SxcjFwezQBuzxJ/Nd1lBEsICkRLN266BNfAKmEs0P50JViQksJ5R4tern1AJQYmTM5+wgNjM
	QFP/zLsENJUDyJaWWP6PAyIsL9G8dTbYMk4BS4nXU7ayg9iiAsoSB7YdZ5rAyDcLyaRZSCbN
	Qpg0C8mkBYwsqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLjbVntn4k7GL9cdj/EKMDBqMTD
	67A6P0OINbGsuDL3EKMEB7OSCO8634IMId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLp
	iSWp2ampBalFMFkmDk6pBsY718TSjfVnFbI07tWb/Jj77yyxzhvpdYqHVRizjy94rv5+l8tJ
	Ywe9STF39VZLvY8QWVUnaW55LCBWWkY9aYmmgdb0k2F63oz1jNIXefxUWq4tavfuC565/nu+
	9HnvqCkF1iktiwT2+QesrlqjsvbA1Y6WhYt/7KxPO95du4tr87WY2SGy15VYijMSDbWYi4oT
	AQ9n3/KzAgAA
X-CFilter-Loop: Reflected

On Fri, Jul 11, 2025 at 11:08:58AM +0900, Byungchul Park wrote:
> On Thu, Jul 10, 2025 at 02:43:15PM +0200, Andrey Konovalov wrote:
> > On Thu, Jul 3, 2025 at 8:10 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > >
> > > find_vm_area() couldn't be called in atomic_context.
> > > If find_vm_area() is called to reports vm area information,
> > > kasan can trigger deadlock like:
> > >
> > > CPU0                                CPU1
> > > vmalloc();
> > >  alloc_vmap_area();
> > >   spin_lock(&vn->busy.lock)
> > >                                     spin_lock_bh(&some_lock);
> > >    <interrupt occurs>
> > >    <in softirq>
> > >    spin_lock(&some_lock);
> > >                                     <access invalid address>
> > >                                     kasan_report();
> > >                                      print_report();
> > >                                       print_address_description();
> > >                                        kasan_find_vm_area();
> > >                                         find_vm_area();
> > >                                          spin_lock(&vn->busy.lock) // deadlock!
> > >
> > > To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> > >
> > > Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> > > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > 
> > As a fix:
> > 
> > Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
> > 
> > But it would be great to figure out a way to eventually restore this
> > functionality; I'll file a bug for this once this patch lands. The
> > virtual mapping info helps with real issues: e.g. just recently it
> > helped me to quickly see the issue that caused a false-positive report
> 
> I checked the critical section by &vn->busy.lock in find_vm_area().  The
> time complextity looks O(log N).  I don't think an irq disabled section
> of O(log N) is harmful.  I still think using
> spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> of significant irq delay.  Am I missing something?

I prefer this one tho.

	Byungchul
> 
> If it's unacceptable for some reasons, why don't we introduce kind of
> try_find_vm_area() using trylock so as to go ahead only if there's no
> lock contention?
> 
> 	Byungchul
> 
> > [1].
> > 
> > [1] https://lore.kernel.org/all/CA+fCnZfzHOFjVo43UZK8H6h3j=OHjfF13oFJvT0P-SM84Oc4qQ@mail.gmail.com/
