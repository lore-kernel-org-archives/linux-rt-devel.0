Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF20B665
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Jul 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199750; cv=none; b=Qx0LKZjLQqvha3G+LAHLEIl38RnHIB4u4CWgSgpH7mCd+9t3mKoNNm6GcBpxRaJujJiMrHMLZjUsvShB3m1E9aod2yIOIkv01/eJsavmJ0RyWXnD3K24sK4oIFmy0NT8mICLLmDTN4ncwgL88T43esAL9lyvd8s9A56W3q8zf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199750; c=relaxed/simple;
	bh=zqq57u2WVfgXoEdamVTbfR05Ve7afEYjp1upTRr2SY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkBplkQVlJ92shI7UbWcYcGFNAvVQp16n/CfzxcYGsIEoE7maLbg+8FuwQj0UxoGh82AOlTOZt8Tr1u7GjHrKCvHRaCPgFJa30OEMKDqAKueRtyKqMDM2ngeOKv4OGKMORtUMfrfNG9JbpjuT84ssC1OAEoLiSQomj+V5mR0DXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-28-6870723f8102
Date: Fri, 11 Jul 2025 11:08:58 +0900
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
Message-ID: <20250711020858.GA78977@system.software.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsXC9ZZnoa59UUGGwex1IhZz1q9hs/g+cTq7
	xbSLk5gtlj35x2Qx4WEbu0X7x73MFiue3WeyuLxrDpvFvTX/WS0urb7AYnFhYi+rxb6OB0wW
	e//9ZLGY+8XQ4svqVWwO/B5r5q1h9Ng56y67R8u+W+weCzaVeuyZeJLNY9OqTiDxaRK7x8Lf
	L5g93p07x+5xYsZvFo8Xm2cyenzeJBfAE8Vlk5Kak1mWWqRvl8CVcb9hIWPBV8GKi02bWRsY
	d/J0MXJySAiYSJx4e4YFxv7eeRfMZhFQlXh94Dg7iM0moC5x48ZPZhBbREBbYsKNX0A1XBzM
	Am3MEn8232UFSQgLREo0b7vGBGLzClhIfFswGaxISKCBUWL+m14WiISgxMmZT8BsZqCpf+Zd
	AprKAWRLSyz/xwERlpdo3jobbBmnQKBE+7Z/YLaogLLEgW3HmUBmSgisYpe4u3wOO8TVkhIH
	V9xgmcAoOAvJillIVsxCWDELyYoFjCyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQIjdFntn+gd
	jJ8uBB9iFOBgVOLhdVidnyHEmlhWXJl7iFGCg1lJhHedb0GGEG9KYmVValF+fFFpTmrxIUZp
	DhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBka3E29YplfUyb5eGuf+8Mmavt1Ct10TdvX4
	SdeIFi8X62bovjZl9nWNUxpxd4IuFLzRWqn/eZJjxvobVgIbtf8J7fj//K+szN48hogXhnfb
	Xfjbvkhv/qfIWL9XdofBvUVcDzd1ld+uiBLqd8p9o/r0Z8G8H/ebawp2zbjgFbDa5rD/WrXs
	/QeUWIozEg21mIuKEwEDMfAizAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsXC5WfdrGtfVJBhcGEqi8Wc9WvYLL5PnM5u
	Me3iJGaLZU/+MVlMeNjGbtH+cS+zxYpn95ksDs89yWpxedccNot7a/6zWlxafYHF4sLEXlaL
	fR0PmCz2/vvJYjH3i6HFl9Wr2BwEPNbMW8PosXPWXXaPln232D0WbCr12DPxJJvHplWdQOLT
	JHaPhb9fMHu8O3eO3ePEjN8sHi82z2T0WPziA5PH501yAbxRXDYpqTmZZalF+nYJXBn3GxYy
	FnwVrLjYtJm1gXEnTxcjJ4eEgInE9867LCA2i4CqxOsDx9lBbDYBdYkbN34yg9giAtoSE278
	Aqrh4mAWaGOW+LP5LitIQlggUqJ52zUmEJtXwELi24LJYEVCAg2MEvPf9LJAJAQlTs58AmYz
	A039M+8S0FQOIFtaYvk/DoiwvETz1tlgyzgFAiXat/0Ds0UFlCUObDvONIGRbxaSSbOQTJqF
	MGkWkkkLGFlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBMbbsto/E3cwfrnsfohRgINRiYfX
	YXV+hhBrYllxZe4hRgkOZiUR3nW+BRlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNIT
	S1KzU1MLUotgskwcnFINjAkZwV9fGeso6bmLPPGKMfWun/37ye1FN13mnrl5jOui5qKFl0/V
	PP3N1ZaV+vipSbKxp/3dZ7f2fE77c+v3yWOXdi0IUlwzoSuvoJlpzYQcebbJb6/euCn/ZqvD
	ZIMvzhNuFG78Z188p+1gpeoOcYal3BrLL2y9oNNV+OC95gLP8xvn3OZ4kTpfiaU4I9FQi7mo
	OBEAuCK4YLMCAAA=
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 02:43:15PM +0200, Andrey Konovalov wrote:
> On Thu, Jul 3, 2025 at 8:10 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > find_vm_area() couldn't be called in atomic_context.
> > If find_vm_area() is called to reports vm area information,
> > kasan can trigger deadlock like:
> >
> > CPU0                                CPU1
> > vmalloc();
> >  alloc_vmap_area();
> >   spin_lock(&vn->busy.lock)
> >                                     spin_lock_bh(&some_lock);
> >    <interrupt occurs>
> >    <in softirq>
> >    spin_lock(&some_lock);
> >                                     <access invalid address>
> >                                     kasan_report();
> >                                      print_report();
> >                                       print_address_description();
> >                                        kasan_find_vm_area();
> >                                         find_vm_area();
> >                                          spin_lock(&vn->busy.lock) // deadlock!
> >
> > To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> >
> > Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> As a fix:
> 
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> But it would be great to figure out a way to eventually restore this
> functionality; I'll file a bug for this once this patch lands. The
> virtual mapping info helps with real issues: e.g. just recently it
> helped me to quickly see the issue that caused a false-positive report

I checked the critical section by &vn->busy.lock in find_vm_area().  The
time complextity looks O(log N).  I don't think an irq disabled section
of O(log N) is harmful.  I still think using
spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
of significant irq delay.  Am I missing something?

If it's unacceptable for some reasons, why don't we introduce kind of
try_find_vm_area() using trylock so as to go ahead only if there's no
lock contention?

	Byungchul

> [1].
> 
> [1] https://lore.kernel.org/all/CA+fCnZfzHOFjVo43UZK8H6h3j=OHjfF13oFJvT0P-SM84Oc4qQ@mail.gmail.com/
