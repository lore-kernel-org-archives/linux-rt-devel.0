Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB01EFF8B
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Jul 2025 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436603; cv=none; b=ZAdPCmICPs+4AWJzX1QDWs98VkJFkywTMdR0TqKY/scUpJf2pHaD630dCt7wy+DChidhwJWPdxx5b8RoS7fMAhTZyHnAIFsmW5qvoduQAZSkBZO21WJP6cEZ/acu9YrWqiMkeKZrd4FchkusveazikxWeP/QS+h9Q5Zb51f+hvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436603; c=relaxed/simple;
	bh=flPywGfoZfh0sny+4UgOR+SeiTfe1jaKdoWuv4kazbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpESbMUCCSMZZDkX7Z4GkyJS7mXLwY+MaihHIQxCg9XgtmWdqWSvCU0IQHEH6CQY+DJJvZKpdAAlzKeOcXkzD/UAX7GoGJOPzyiPPzHluX8Du4oKgYw+R5HhzvwVov2uKEERPwK8+cHonr2pJswFxZsNefqkMtotWH0reoAEJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d8-6864cd32507e
Date: Wed, 2 Jul 2025 15:09:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	kpm@linux-foundation.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	max.byungchul.park@gmail.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, nd@arm.com,
	Yunseong Kim <ysk@kzalloc.com>, kernel_team@skhynix.com
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
Message-ID: <20250702060949.GB5358@system.software.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
 <20250702060138.GA5358@system.software.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702060138.GA5358@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsXC9ZZnka7x2ZQMg4nZFt8nTme3mHZxErPF
	sif/mCwmPGxjt2j/uJfZYsWz+0wWlz8sY7a4vGsOm8W9Nf9ZLS6tvsBicWFiL6vFmeU9zBb7
	Oh4wWRzfuoXZYu+/nywWc78YWnxZvYrNQdBjzbw1jB47Z91l92jZd4vdY8GmUo89E0+yeWxa
	1QkkPk1i91j4+wWzx7tz59g9Tsz4zeLxYvNMRo/Pm+QCeKK4bFJSczLLUov07RK4Mk69vM1a
	sG41Y8WWKcuZGhgv9DB2MXJySAiYSKyb1ckOY0+7tIgZxGYRUJFYd3IiWA2bgLrEjRs/weIi
	AqoSi9vPsHQxcnEwC6xllrgx+RRYs7BAvMSTaRdYQWxeAXOJt+chFggJpEvc/viNDSIuKHFy
	5hMWEJtZQEvixr+XTF2MHEC2tMTyfxwgYU4BC4kLW96CjREVUJY4sO04E8guCYFV7BKrG+Yw
	QRwqKXFwxQ2WCYwCs5CMnYVk7CyEsQsYmVcxCmXmleUmZuaY6GVU5mVW6CXn525iBEbhsto/
	0TsYP10IPsQowMGoxMN74kpyhhBrYllxZe4hRgkOZiURXj5ZoBBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXFeo2/lKUAfJpakZqemFqQWwWSZODilGhh11zpxNEXxiF/jD7dNT/neb1L00DZSO/71
	6wjx5VMmc9n+PVorlXTE8W7tNF6n+F//c9e36Ys7xIRHn63sef1lxscP7w/s7xUP1l139VbC
	HzbBHyavgyZMPesiWf/7EqO8gGUmM4PjAYWX3+we//Db92n50eP329zuy8+5zW2gkLRiqVBf
	qaISS3FGoqEWc1FxIgBBUmDTvgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC5WfdrGt0NiXD4MRfXYvvE6ezW0y7OInZ
	YtmTf0wWEx62sVu0f9zLbLHi2X0mi8NzT7JaXP6wjNni8q45bBb31vxntbi0+gKLxYWJvawW
	Z5b3MFvs63jAZHF86xZmi73/frJYzP1iaPFl9So2ByGPNfPWMHrsnHWX3aNl3y12jwWbSj32
	TDzJ5rFpVSeQ+DSJ3WPh7xfMHu/OnWP3ODHjN4vHi80zGT0Wv/jA5PF5k1wAbxSXTUpqTmZZ
	apG+XQJXxqmXt1kL1q1mrNgyZTlTA+OFHsYuRk4OCQETiWmXFjGD2CwCKhLrTk4Ei7MJqEvc
	uPETLC4ioCqxuP0MSxcjFwezwFpmiRuTT7GDJIQF4iWeTLvACmLzCphLvD0PMVRIIF3i9sdv
	bBBxQYmTM5+wgNjMAloSN/69ZOpi5ACypSWW/+MACXMKWEhc2PIWbIyogLLEgW3HmSYw8s5C
	0j0LSfcshO4FjMyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAqNqWe2fiTsYv1x2P8QowMGo
	xMN74GxyhhBrYllxZe4hRgkOZiURXj5ZoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBKBX
	EktSs1NTC1KLYLJMHJxSDYwZTbx/rE6/DJgTobFVzytsixqr3m+L3/NdrHd/LJaX2qybJPHq
	RIR6iLSVGWtbxZsjm8WvvjBKNmvm+PigZfv5Jds/8UbPuv5g7acLAdUzUz7+c+LOFkjePfGI
	/am8uxc0ZMq59rh+lOGYflR8I8+We9LmH746970+vfRBri/3hoSlEbtK1q5QYinOSDTUYi4q
	TgQANm8HwaYCAAA=
X-CFilter-Loop: Reflected

On Wed, Jul 02, 2025 at 03:01:38PM +0900, Byungchul Park wrote:
> On Tue, Jul 01, 2025 at 09:35:45PM +0100, Yeoreum Yun wrote:
> > 
> > 
> > Caution: External Email. Please take care when clicking links or opening attachments.
> > 
> > 
> > 
> > 
> > 
> > 
> > In below senario, kasan causes deadlock while reporting vm area informaion:
> > 
> > CPU0                                CPU1
> > vmalloc();
> >  alloc_vmap_area();
> >   spin_lock(&vn->busy.lock)
> 			^
> 	Here, it should be spin_lock_bh(&vn->busy.lock).

spin_lock_irqsave(&vn->busy.lock) might be even better, assuming
find_vm_area() could be called with a critcal section of *_irq() or
something.

	Byungchul
> 
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
> 						^
> 		It should be spin_lock_bh(&vn->busy.lock), since it can
> 		be within a critical section of *spin_lock_bh*() to
> 		avoid a deadlock with softirq involved.
> 
> 	Byungchul
> 
> > To resolve this possible deadlock, don't call find_vm_area()
> > to prevent possible deadlock while kasan reports vm area information.
> > 
> > Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> > Below report is from Yunseong Kim using DEPT:
> > 
> > ===================================================
> > DEPT: Circular dependency has been detected.
> > 6.15.0-rc6-00043-ga83a69ec7f9f #5 Not tainted
> > ---------------------------------------------------
> > summary
> > ---------------------------------------------------
> > *** DEADLOCK ***
> > 
> > context A
> >    [S] lock(report_lock:0)
> >    [W] lock(&vn->busy.lock:0)
> >    [E] unlock(report_lock:0)
> > 
> > context B
> >    [S] lock(&tb->tb6_lock:0)
> >    [W] lock(report_lock:0)
> >    [E] unlock(&tb->tb6_lock:0)
> > 
> > context C
> >    [S] write_lock(&ndev->lock:0)
> >    [W] lock(&tb->tb6_lock:0)
> >    [E] write_unlock(&ndev->lock:0)
> > 
> > context D
> >    [S] lock(&vn->busy.lock:0)
> >    [W] write_lock(&ndev->lock:0)
> >    [E] unlock(&vn->busy.lock:0)
> > 
> > [S]: start of the event context
> > [W]: the wait blocked
> > [E]: the event not reachable
> > ---------------------------------------------------
> > context A's detail
> > ---------------------------------------------------
> > context A
> >    [S] lock(report_lock:0)
> >    [W] lock(&vn->busy.lock:0)
> >    [E] unlock(report_lock:0)
> > 
> > [S] lock(report_lock:0):
> > [<ffff800080bd2600>] start_report mm/kasan/report.c:215 [inline]
> > [<ffff800080bd2600>] kasan_report+0x74/0x1d4 mm/kasan/report.c:623
> > stacktrace:
> >       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >       _raw_spin_lock_irqsave+0x88/0xd8 kernel/locking/spinlock.c:162
> >       start_report mm/kasan/report.c:215 [inline]
> >       kasan_report+0x74/0x1d4 mm/kasan/report.c:623
> >       __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
> >       fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
> >       fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
> >       fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
> >       fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
> >       fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
> >       __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
> >       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
> >       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
> >       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
> >       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
> >       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
> >       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> >       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
> >       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
> > 
> > [W] lock(&vn->busy.lock:0):
> > [<ffff800080ae57a0>] spin_lock include/linux/spinlock.h:351 [inline]
> > [<ffff800080ae57a0>] find_vmap_area+0xa0/0x228 mm/vmalloc.c:2418
> > stacktrace:
> >       spin_lock include/linux/spinlock.h:351 [inline]
> >       find_vmap_area+0xa0/0x228 mm/vmalloc.c:2418
> >       find_vm_area+0x20/0x68 mm/vmalloc.c:3208
> >       kasan_find_vm_area mm/kasan/report.c:398 [inline]
> >       print_address_description mm/kasan/report.c:432 [inline]
> >       print_report+0x3d8/0x54c mm/kasan/report.c:521
> >       kasan_report+0xb8/0x1d4 mm/kasan/report.c:634
> >       __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
> >       fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
> >       fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
> >       fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
> >       fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
> >       fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
> >       __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
> >       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
> >       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
> >       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
> >       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
> >       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
> >       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> > 
> > [E] unlock(report_lock:0):
> > (N/A)
> > ---------------------------------------------------
> > context B's detail
> > ---------------------------------------------------
> > context B
> >    [S] lock(&tb->tb6_lock:0)
> >    [W] lock(report_lock:0)
> >    [E] unlock(&tb->tb6_lock:0)
> > 
> > [S] lock(&tb->tb6_lock:0):
> > [<ffff80008a172d10>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> > [<ffff80008a172d10>] __fib6_clean_all+0xe8/0x2b8 net/ipv6/ip6_fib.c:2267
> > stacktrace:
> >       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
> >       _raw_spin_lock_bh+0x80/0xd0 kernel/locking/spinlock.c:178
> >       spin_lock_bh include/linux/spinlock.h:356 [inline]
> >       __fib6_clean_all+0xe8/0x2b8 net/ipv6/ip6_fib.c:2267
> >       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
> >       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
> >       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
> >       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
> >       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
> >       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> >       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
> >       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
> >       call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
> >       call_netdevice_notifiers net/core/dev.c:2228 [inline]
> >       dev_close_many+0x290/0x4b8 net/core/dev.c:1731
> >       unregister_netdevice_many_notify+0x574/0x1fa0 net/core/dev.c:11940
> >       unregister_netdevice_many net/core/dev.c:12034 [inline]
> >       unregister_netdevice_queue+0x2b8/0x390 net/core/dev.c:11877
> >       unregister_netdevice include/linux/netdevice.h:3374 [inline]
> >       __tun_detach+0xec4/0x1180 drivers/net/tun.c:620
> >       tun_detach drivers/net/tun.c:636 [inline]
> >       tun_chr_close+0xa4/0x248 drivers/net/tun.c:3390
> >       __fput+0x374/0xa30 fs/file_table.c:465
> >       ____fput+0x20/0x3c fs/file_table.c:493
> > 
> > [W] lock(report_lock:0):
> > [<ffff800080bd2600>] start_report mm/kasan/report.c:215 [inline]
> > [<ffff800080bd2600>] kasan_report+0x74/0x1d4 mm/kasan/report.c:623
> > stacktrace:
> >       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >       _raw_spin_lock_irqsave+0x6c/0xd8 kernel/locking/spinlock.c:162
> >       start_report mm/kasan/report.c:215 [inline]
> >       kasan_report+0x74/0x1d4 mm/kasan/report.c:623
> >       __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
> >       fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
> >       fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
> >       fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
> >       fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
> >       fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
> >       __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
> >       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
> >       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
> >       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
> >       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
> >       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
> >       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> >       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
> >       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
> > 
> > [E] unlock(&tb->tb6_lock:0):
> > (N/A)
> > ---------------------------------------------------
> > context C's detail
> > ---------------------------------------------------
> > context C
> >    [S] write_lock(&ndev->lock:0)
> >    [W] lock(&tb->tb6_lock:0)
> >    [E] write_unlock(&ndev->lock:0)
> > 
> > [S] write_lock(&ndev->lock:0):
> > [<ffff80008a133bd8>] addrconf_permanent_addr net/ipv6/addrconf.c:3622 [inline]
> > [<ffff80008a133bd8>] addrconf_notify+0xab4/0x1688 net/ipv6/addrconf.c:3698
> > stacktrace:
> >       __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
> >       _raw_write_lock_bh+0x88/0xd4 kernel/locking/spinlock.c:334
> >       addrconf_permanent_addr net/ipv6/addrconf.c:3622 [inline]
> >       addrconf_notify+0xab4/0x1688 net/ipv6/addrconf.c:3698
> >       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> >       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
> >       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
> >       call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
> >       call_netdevice_notifiers net/core/dev.c:2228 [inline]
> >       __dev_notify_flags+0x114/0x294 net/core/dev.c:9393
> >       netif_change_flags+0x108/0x160 net/core/dev.c:9422
> >       do_setlink.isra.0+0x960/0x3464 net/core/rtnetlink.c:3152
> >       rtnl_changelink net/core/rtnetlink.c:3769 [inline]
> >       __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
> >       rtnl_newlink+0x1080/0x1a1c net/core/rtnetlink.c:4065
> >       rtnetlink_rcv_msg+0x82c/0xc30 net/core/rtnetlink.c:6955
> >       netlink_rcv_skb+0x218/0x400 net/netlink/af_netlink.c:2534
> >       rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6982
> >       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> >       netlink_unicast+0x50c/0x778 net/netlink/af_netlink.c:1339
> >       netlink_sendmsg+0x794/0xc28 net/netlink/af_netlink.c:1883
> >       sock_sendmsg_nosec net/socket.c:712 [inline]
> >       __sock_sendmsg+0xe0/0x1a0 net/socket.c:727
> >       __sys_sendto+0x238/0x2fc net/socket.c:2180
> > 
> > [W] lock(&tb->tb6_lock:0):
> > [<ffff80008a1643fc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> > [<ffff80008a1643fc>] __ip6_ins_rt net/ipv6/route.c:1350 [inline]
> > [<ffff80008a1643fc>] ip6_route_add+0x7c/0x220 net/ipv6/route.c:3900
> > stacktrace:
> >       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
> >       _raw_spin_lock_bh+0x5c/0xd0 kernel/locking/spinlock.c:178
> >       spin_lock_bh include/linux/spinlock.h:356 [inline]
> >       __ip6_ins_rt net/ipv6/route.c:1350 [inline]
> >       ip6_route_add+0x7c/0x220 net/ipv6/route.c:3900
> >       addrconf_prefix_route+0x28c/0x494 net/ipv6/addrconf.c:2487
> >       fixup_permanent_addr net/ipv6/addrconf.c:3602 [inline]
> >       addrconf_permanent_addr net/ipv6/addrconf.c:3626 [inline]
> >       addrconf_notify+0xfd0/0x1688 net/ipv6/addrconf.c:3698
> >       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> >       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
> >       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
> >       call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
> >       call_netdevice_notifiers net/core/dev.c:2228 [inline]
> >       __dev_notify_flags+0x114/0x294 net/core/dev.c:9393
> >       netif_change_flags+0x108/0x160 net/core/dev.c:9422
> >       do_setlink.isra.0+0x960/0x3464 net/core/rtnetlink.c:3152
> >       rtnl_changelink net/core/rtnetlink.c:3769 [inline]
> >       __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
> >       rtnl_newlink+0x1080/0x1a1c net/core/rtnetlink.c:4065
> >       rtnetlink_rcv_msg+0x82c/0xc30 net/core/rtnetlink.c:6955
> >       netlink_rcv_skb+0x218/0x400 net/netlink/af_netlink.c:2534
> >       rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6982
> >       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
> >       netlink_unicast+0x50c/0x778 net/netlink/af_netlink.c:1339
> >       netlink_sendmsg+0x794/0xc28 net/netlink/af_netlink.c:1883
> > 
> > [E] write_unlock(&ndev->lock:0):
> > (N/A)
> > ---------------------------------------------------
> > context D's detail
> > ---------------------------------------------------
> > context D
> >    [S] lock(&vn->busy.lock:0)
> >    [W] write_lock(&ndev->lock:0)
> >    [E] unlock(&vn->busy.lock:0)
> > 
> > [S] lock(&vn->busy.lock:0):
> > [<ffff800080adcf80>] spin_lock include/linux/spinlock.h:351 [inline]
> > [<ffff800080adcf80>] alloc_vmap_area+0x800/0x26d0 mm/vmalloc.c:2027
> > stacktrace:
> >       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >       _raw_spin_lock+0x78/0xc0 kernel/locking/spinlock.c:154
> >       spin_lock include/linux/spinlock.h:351 [inline]
> >       alloc_vmap_area+0x800/0x26d0 mm/vmalloc.c:2027
> >       __get_vm_area_node+0x1c8/0x360 mm/vmalloc.c:3138
> >       __vmalloc_node_range_noprof+0x168/0x10d4 mm/vmalloc.c:3805
> >       __vmalloc_node_noprof+0x130/0x178 mm/vmalloc.c:3908
> >       vzalloc_noprof+0x3c/0x54 mm/vmalloc.c:3981
> >       alloc_counters net/ipv6/netfilter/ip6_tables.c:815 [inline]
> >       copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
> >       get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
> >       do_ip6t_get_ctl+0x520/0xad0 net/ipv6/netfilter/ip6_tables.c:1677
> >       nf_getsockopt+0x8c/0x10c net/netfilter/nf_sockopt.c:116
> >       ipv6_getsockopt+0x24c/0x460 net/ipv6/ipv6_sockglue.c:1493
> >       tcp_getsockopt+0x98/0x120 net/ipv4/tcp.c:4727
> >       sock_common_getsockopt+0x9c/0xcc net/core/sock.c:3867
> >       do_sock_getsockopt+0x308/0x57c net/socket.c:2357
> >       __sys_getsockopt+0xec/0x188 net/socket.c:2386
> >       __do_sys_getsockopt net/socket.c:2393 [inline]
> >       __se_sys_getsockopt net/socket.c:2390 [inline]
> >       __arm64_sys_getsockopt+0xa8/0x110 net/socket.c:2390
> >       __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
> >       invoke_syscall+0x88/0x2e0 arch/arm64/kernel/syscall.c:50
> >       el0_svc_common.constprop.0+0xe8/0x2e0 arch/arm64/kernel/syscall.c:139
> > 
> > [W] write_lock(&ndev->lock:0):
> > [<ffff80008a127f20>] addrconf_rs_timer+0xa0/0x730 net/ipv6/addrconf.c:4025
> > stacktrace:
> >       __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
> >       _raw_write_lock+0x5c/0xd0 kernel/locking/spinlock.c:300
> >       addrconf_rs_timer+0xa0/0x730 net/ipv6/addrconf.c:4025
> >       call_timer_fn+0x204/0x964 kernel/time/timer.c:1789
> >       expire_timers kernel/time/timer.c:1840 [inline]
> >       __run_timers+0x830/0xb00 kernel/time/timer.c:2414
> >       __run_timer_base kernel/time/timer.c:2426 [inline]
> >       __run_timer_base kernel/time/timer.c:2418 [inline]
> >       run_timer_base+0x124/0x198 kernel/time/timer.c:2435
> >       run_timer_softirq+0x20/0x58 kernel/time/timer.c:2445
> >       handle_softirqs+0x30c/0xdc0 kernel/softirq.c:579
> >       __do_softirq+0x14/0x20 kernel/softirq.c:613
> >       ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
> >       call_on_irq_stack+0x24/0x30 arch/arm64/kernel/entry.S:891
> >       do_softirq_own_stack+0x20/0x40 arch/arm64/kernel/irq.c:86
> >       invoke_softirq kernel/softirq.c:460 [inline]
> >       __irq_exit_rcu+0x400/0x560 kernel/softirq.c:680
> >       irq_exit_rcu+0x14/0x80 kernel/softirq.c:696
> >       __el1_irq arch/arm64/kernel/entry-common.c:561 [inline]
> >       el1_interrupt+0x38/0x54 arch/arm64/kernel/entry-common.c:575
> >       el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
> >       el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
> > 
> > [E] unlock(&vn->busy.lock:0):
> > (N/A)
> > ---------------------------------------------------
> > information that might be helpful
> > ---------------------------------------------------
> > CPU: 1 UID: 0 PID: 19536 Comm: syz.4.2592 Not tainted 6.15.0-rc6-00043-ga83a69ec7f9f #5 PREEMPT
> > Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> > Call trace:
> >  dump_backtrace arch/arm64/kernel/stacktrace.c:449 [inline] (C)
> >  show_stack+0x34/0x80 arch/arm64/kernel/stacktrace.c:466 (C)
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x104/0x180 lib/dump_stack.c:120
> >  dump_stack+0x20/0x2c lib/dump_stack.c:129
> >  print_circle kernel/dependency/dept.c:928 [inline]
> >  cb_check_dl kernel/dependency/dept.c:1362 [inline]
> >  cb_check_dl+0x1080/0x10ec kernel/dependency/dept.c:1356
> >  bfs+0x4d8/0x630 kernel/dependency/dept.c:980
> >  check_dl_bfs kernel/dependency/dept.c:1381 [inline]
> >  add_dep+0x1cc/0x364 kernel/dependency/dept.c:1710
> >  add_wait kernel/dependency/dept.c:1829 [inline]
> >  __dept_wait+0x60c/0x16e0 kernel/dependency/dept.c:2585
> >  dept_wait kernel/dependency/dept.c:2666 [inline]
> >  dept_wait+0x168/0x1a8 kernel/dependency/dept.c:2640
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >  _raw_spin_lock+0x54/0xc0 kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:351 [inline]
> >  find_vmap_area+0xa0/0x228 mm/vmalloc.c:2418
> >  find_vm_area+0x20/0x68 mm/vmalloc.c:3208
> >  kasan_find_vm_area mm/kasan/report.c:398 [inline]
> >  print_address_description mm/kasan/report.c:432 [inline]
> >  print_report+0x3d8/0x54c mm/kasan/report.c:521
> >  kasan_report+0xb8/0x1d4 mm/kasan/report.c:634
> >  __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
> >  fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
> >  fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
> >  fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
> >  fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
> >  fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
> >  __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
> >  fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
> >  rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
> >  rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
> >  addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
> >  addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
> >  notifier_call_chain+0x94/0x50c kernel/notifier.c:85
> >  raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
> >  call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
> >  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2228 [inline]
> >  dev_close_many+0x290/0x4b8 net/core/dev.c:1731
> >  unregister_netdevice_many_notify+0x574/0x1fa0 net/core/dev.c:11940
> >  unregister_netdevice_many net/core/dev.c:12034 [inline]
> >  unregister_netdevice_queue+0x2b8/0x390 net/core/dev.c:11877
> >  unregister_netdevice include/linux/netdevice.h:3374 [inline]
> >  __tun_detach+0xec4/0x1180 drivers/net/tun.c:620
> >  tun_detach drivers/net/tun.c:636 [inline]
> >  tun_chr_close+0xa4/0x248 drivers/net/tun.c:3390
> >  __fput+0x374/0xa30 fs/file_table.c:465
> >  ____fput+0x20/0x3c fs/file_table.c:493
> >  task_work_run+0x154/0x278 kernel/task_work.c:227
> >  exit_task_work include/linux/task_work.h:40 [inline]
> >  do_exit+0x950/0x23a8 kernel/exit.c:953
> >  do_group_exit+0xc0/0x248 kernel/exit.c:1103
> >  get_signal+0x1f98/0x20cc kernel/signal.c:3034
> >  do_signal+0x200/0x880 arch/arm64/kernel/signal.c:1658
> >  do_notify_resume+0x1a0/0x26c arch/arm64/kernel/entry-common.c:148
> >  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
> >  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
> >  el0_svc+0xf8/0x188 arch/arm64/kernel/entry-common.c:745
> >  el0t_64_sync_handler+0x10c/0x140 arch/arm64/kernel/entry-common.c:762
> >  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> > 
> > ---
> >  mm/kasan/report.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 8357e1a33699..61c590e8005e 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -387,7 +387,7 @@ static inline struct vm_struct *kasan_find_vm_area(void *addr)
> >         static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
> >         struct vm_struct *va;
> > 
> > -       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +       if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_interrupt())
> >                 return NULL;
> > 
> >         /*
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> > 
