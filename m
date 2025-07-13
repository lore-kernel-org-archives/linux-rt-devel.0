Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A051FDE02
	for <linux-rt-devel@lists.linux.dev>; Sun, 13 Jul 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449271; cv=none; b=agwxhDqZkfQFl70uqwptEnqdr/6L5pk0eBoVkoZfqdsMwPIOBlgJ0oQv+gZR/5MP13U7hivHD/7Aa0Bc0b9Vj6xmeFEwZAdGdV+dypHFowrBPoU6ZmRsBat7MCQuup8dbLsGidQpNyFdBvX2BgQOUHzKwp5MgOVdEQcN/EOmZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449271; c=relaxed/simple;
	bh=PNlpdiBlfke4hLU5sd6jQGIZ+kbIUkdFcN98yW9xMQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnjfGvBKJzbcFLnAufmQNbLytiyFncaw+u2G/k1oZ6hBKm7/3Tw7ooE1o49fXR5fSspcHUDp+1la6GutkmZ8zDSnVXSm+Xij3/EgQb40YPpMEBH4WVdrt2s5Rvug+Lc+8oQMq7RPjEh7YkipNX10K8qGVviyNKKp+iYYDtySG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-54-687440f1ab53
Date: Mon, 14 Jul 2025 08:27:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"glider@google.com" <glider@google.com>,
	"dvyukov@google.com" <dvyukov@google.com>,
	Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>,
	"ysk@kzalloc.com" <ysk@kzalloc.com>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <20250713232740.GA18327@system.software.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com>
 <20250711021100.GA4320@system.software.com>
 <GV1PR08MB1052126BB553BD36DA768C998FB4AA@GV1PR08MB10521.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1PR08MB1052126BB553BD36DA768C998FB4AA@GV1PR08MB10521.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsXC9ZZnoe5Hh5IMg3f7NCzmrF/DZvF94nR2
	i2kXJzFbLHvyj8liwsM2dov2j3uZLVY8u89kcXnXHDaLe2v+s1pcWn2BxeLCxF5Wi30dD5gs
	Vl9ksdj77yeLxdwvhhZfVq9icxDwWDNvDaPHzll32T1a9t1i91iwqdRjz8STbB6bVnUCiU+T
	2D0W/n7B7PHu3Dl2jxMzfrN4vNg8k9Hj8ya5AJ4oLpuU1JzMstQifbsEroz7d/vZC65wVOze
	85e5gfEFWxcjJ4eEgInE1h9NzDD23XknmUBsFgFVia2/GsDibALqEjdu/ASzRQTUJH6uOgZW
	wyywi03iwvtEEFtYIFKieds1sDivgIVE883ZrF2MHBxCApuYJN7aQ4QFJU7OfMIC0aolcePf
	SyaQEmYBaYnl/zhAwpwC8RKPzk8FmyIqoCxxYNtxIJsL6LLp7BJLl25jhThTUuLgihssExgF
	ZiEZOwvJ2FkIYxcwMq9iFMrMK8tNzMwx0cuozMus0EvOz93ECIy5ZbV/oncwfroQfIhRgINR
	iYf3xpbiDCHWxLLiytxDjBIczEoivK/uFmUI8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4i
	JJCeWJKanZpakFoEk2Xi4JRqYIytEl/4xfodQ6X/3dmSFUerlnmd4zbh8BTNNvmZ43z613zH
	ma2B84qXndr89JyVw0TulbseR8zglov7W9Fc8l/ha1ZLce6zdXITGYXeVK/7zKNSHH/XULpp
	l338Wz5vZr8Tn4RrFQWSdkjPaSiPYFE10BI7mr3uRZpWV92m7y3Sv/e+Dvv5WomlOCPRUIu5
	qDgRAOKU1i+1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42Lh8rNu1v3oUJJhcPW2uMWc9WvYLL5PnM5u
	Me3iJGaLZU/+MVlMeNjGbtH+cS+zxYpn95ksDs89yWpxedccNot7a/6zWlxafYHF4sLEXlaL
	fR0PmCxWX2Sx2PvvJ4vF3C+GFl9Wr2JzEPRYM28No8fOWXfZPVr23WL3WLCp1GPPxJNsHptW
	dQKJT5PYPRb+fsHs8e7cOXaPEzN+s3i82DyT0WPxiw9MHp83yQXwRnHZpKTmZJalFunbJXBl
	3L/bz15whaNi956/zA2ML9i6GDk5JARMJO7OO8kEYrMIqEps/dXADGKzCahL3LjxE8wWEVCT
	+LnqGFgNs8AuNokL7xNBbGGBSInmbdfA4rwCFhLNN2ezdjFycAgJbGKSeGsPERaUODnzCQtE
	q5bEjX8vmUBKmAWkJZb/4wAJcwrESzw6PxVsiqiAssSBbceZJjDyzkLSPQtJ9yyE7gWMzKsY
	RTLzynITM3NM9YqzMyrzMiv0kvNzNzECI2hZ7Z+JOxi/XHY/xCjAwajEw3tjS3GGEGtiWXFl
	7iFGCQ5mJRHeV3eLMoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFk
	mTg4pRoYVfkyX039eKwuy+l9Xuz821OtZzLIne2+pJz56Pvk+XI7YkWaJA83Jwox7svqqRXI
	Ez+wLUt/7smqQL0Slv9z53l7hU2yPdGfodMlwHUh9ujxZ4Izua5l2n/5dfLx7D0NfxMeT1zF
	oj3J37L+yAU+NpbcgOZJeta/5zdLvI7gEu7xCf7FF7NAiaU4I9FQi7moOBEAkEiYeZwCAAA=
X-CFilter-Loop: Reflected

On Sat, Jul 12, 2025 at 03:46:10PM +0000, Yeo Reum Yun wrote:
> Hi ByungChul,
> 
> [...]
> > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > time complextity looks O(log N).  I don't think an irq disabled section
> > of O(log N) is harmful.  I still think using
> > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > of significant irq delay.  Am I missing something?
> 
> I don't agree for this.
> since in PREEMPT_RT case, it has the same problem.
> 
> In case of PREEMPT_RT, spin_lock_irqsave() becomes rt_spin_lock() which is sleepable.
> But, KASAN calls "rt_spin_lock()" holding raw_spin_lock_irqsave() which is definitely wrong.

It's another issue than irq handling latency, but it's about lock usage
correctness.  You are right.

	Byungchul

> But as Uladzislau said, without reference count manage, UAF can always happen.
> IOW, If KASAN to dump vm information, I think we need:
>     1. manage reference for vmap_area.
>     2. find_vm_area() with rcu version.
> 
> 
> Thanks.
> 
> --
> Sincerely,
> Yeoreum Yun
