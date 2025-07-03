Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959812F2720
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Jul 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568298; cv=none; b=KDRlyy+5LoNKgMkD5jgqT2l/H3y7UvUBimZrwG7q8VoqkK54TXLYQeg1xI3PgFIvvpnQtwS3LmJ3250+gPMg9cUZSs10w8z8zLNejRy09lXNuqWYGH2Ty36AoxCBOdnAnSZYexcWaakjnfm4l+iAF67x/4683CYdF78bAQo/zCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568298; c=relaxed/simple;
	bh=aTwfNpbWbQinmRuX9YrFCZ3ccTC3pHYw9hPBZvaiNR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyfnNapg8ydFzXPfdlT/zOmhOlOmg1/qg6cujPZXpIlZTPSJ6uQQUDlh4i8W+B0wMAg21/ceRYeNf8p5r3tyoJMRqRtYuFCNZNEi9o1TwLW19E0EHmwehFX9DmlHUgfGrmcmy7jVN7qSyXI4TU+kkklBDrgM6klzfsIg5tOu8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxPZlvsD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxPZlvsD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so79482f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 03 Jul 2025 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568294; x=1752173094; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhkOyWvT8G/VMXyw/UKeBC01BSrCEvw5VmaWeJzf0yQ=;
        b=AxPZlvsDZQaUpXkBL4aQHlV8VPNd5cfRER5Iqh0nwsHdLnm2B0U/Tzh4CXAgXCmebI
         cHfyvdmDxkGGCSp50gS9YpR4foBBe3qeqhW5OK9R2OYI/oUJK4Peq4pPmpk67ycnfB08
         a5M4MH1P18bgXYjPDGKFwh/sNZZzo311doXXfLvEgVAbRbCVaFVHQGe1zs54/KwDK9yz
         KAaq4sAz/oS76Mql9G7F5EnfO2Q+ETF+zvSMovpzY83uMwYHxV/KjJuRo9wOi7tGUd+y
         0scV/HiQfy4QuFiSOo3rzfoiNX6+ASb7Jvr2dGT6tOmPK+sy3RrayaW8faZDBjXYBTTd
         Xd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568294; x=1752173094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhkOyWvT8G/VMXyw/UKeBC01BSrCEvw5VmaWeJzf0yQ=;
        b=Zp/2Hkq++N747xQ+Vy4w46EDMziujkatXo3CSrb11K7EkwDi9i8zQCJOl6/uujV2rF
         T6bBmWSjVDFgzrX6/NHT6ChLWK9hICFVQ5EPfPvvuNzQjdkf5Q7wwxjP9uODJFb0kDeo
         820Uj5sdSx3EBN4TNZDzu50qxD/WNrVG7BYaZ6lY0kQEq8uEIkEUy3/8/MYzjeg6vQqf
         zKZhbM0uL/SGg/cx/siK92gI1TxzpBRHMX4N5bwRK1AQcmedueHYunO5ZfWEgb7+6ebE
         mxQHuZlcn1ODtQ1z7Hh6cl6R5BTwV1TRzAylsdzb32XEWnFyoyt7mdIsvutrzhTAyZ+/
         BBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvtB9F/kOFHIS+Eg/Oo3C1EbqCR5DK2YlOc1KJpuslbzrmWp5mbb/8g9pGCGuzCQ1szNZwa+NsOQ1WnB3A+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvKR/uE2CYcwK8emo44xIODsMkqecOj3osfvfGtF3nX7bC8X5Z
	OXei3lfxnlaj6D1OmF4zl4npBxRBAM4qjEFBavCkApLSLoF4mQBGFEmU33oOnTMAMX914DYiYNq
	pWOKDAeShiVVypGUDVF/9DscGSWQ58g0=
X-Gm-Gg: ASbGnctcdKHMtGIGUGpInyc2k26nt8+n2CrrGn9g4PIetNiBXil+CREcBcS0FnkcV+h
	+d+fUCuZLxD9WfO5onc/vdri3JKhuRe10TRGgaQJWV/zyGDYcmnhKRajynOKtReApNaoMXyH+2I
	8dRZCkbnND9ac7/cXG76GgX2nWBqdasAN4jOCXSMkgpEdnzeFhVBBvAA3n
X-Google-Smtp-Source: AGHT+IEzWIbjdqLqf3wZ3uvXnvznx42ckDqNrYlcDFnGMHrLRUu69xpFF6TVgrC8cQQDcxkuAMtFfyi+bW233A1pTRY=
X-Received: by 2002:adf:9b96:0:b0:3a6:d191:a835 with SMTP id
 ffacd0b85a97d-3b32de6aa89mr3137295f8f.41.1751568293470; Thu, 03 Jul 2025
 11:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
In-Reply-To: <20250703181018.580833-1-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 3 Jul 2025 20:44:42 +0200
X-Gm-Features: Ac12FXxK_uNd7MYB8JUTDzt5QKdGlekxuViZupditnH5BtfReGGJsAY_cAZre7c
Message-ID: <CA+fCnZeL4KQJYg=yozG7Tr9JA=d+pMFHag_dkPUT=06khjz4xA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, byungchul@sk.com, max.byungchul.park@gmail.com, 
	ysk@kzalloc.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:10=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> wr=
ote:
>
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
>                                          spin_lock(&vn->busy.lock) // dea=
dlock!
>
> To prevent possible deadlock while kasan reports, remove kasan_find_vm_ar=
ea().

Can we keep it for when we are in_task()?

>
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Reported-by: Yunseong Kim <ysk@kzalloc.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>
> Patch History
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> From v1 to v2:
>   - remove kasan_find_vm_area()
>   - v1: https://lore.kernel.org/all/20250701203545.216719-1-yeoreum.yun@a=
rm.com/
>
> NOTE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Below report is from Yunseong Kim using DEPT:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> DEPT: Circular dependency has been detected.
> 6.15.0-rc6-00043-ga83a69ec7f9f #5 Not tainted
> ---------------------------------------------------
> summary
> ---------------------------------------------------
> *** DEADLOCK ***
>
> context A
>    [S] lock(report_lock:0)
>    [W] lock(&vn->busy.lock:0)
>    [E] unlock(report_lock:0)
>
> context B
>    [S] lock(&tb->tb6_lock:0)
>    [W] lock(report_lock:0)
>    [E] unlock(&tb->tb6_lock:0)
>
> context C
>    [S] write_lock(&ndev->lock:0)
>    [W] lock(&tb->tb6_lock:0)
>    [E] write_unlock(&ndev->lock:0)
>
> context D
>    [S] lock(&vn->busy.lock:0)
>    [W] write_lock(&ndev->lock:0)
>    [E] unlock(&vn->busy.lock:0)
>
> [S]: start of the event context
> [W]: the wait blocked
> [E]: the event not reachable
> ---------------------------------------------------
> context A's detail
> ---------------------------------------------------
> context A
>    [S] lock(report_lock:0)
>    [W] lock(&vn->busy.lock:0)
>    [E] unlock(report_lock:0)
>
> [S] lock(report_lock:0):
> [<ffff800080bd2600>] start_report mm/kasan/report.c:215 [inline]
> [<ffff800080bd2600>] kasan_report+0x74/0x1d4 mm/kasan/report.c:623
> stacktrace:
>       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inlin=
e]
>       _raw_spin_lock_irqsave+0x88/0xd8 kernel/locking/spinlock.c:162
>       start_report mm/kasan/report.c:215 [inline]
>       kasan_report+0x74/0x1d4 mm/kasan/report.c:623
>       __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
>       fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
>       fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
>       fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
>       fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
>       fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
>       __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
>       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
>       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
>       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
>       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
>       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
>       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
>       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
>
> [W] lock(&vn->busy.lock:0):
> [<ffff800080ae57a0>] spin_lock include/linux/spinlock.h:351 [inline]
> [<ffff800080ae57a0>] find_vmap_area+0xa0/0x228 mm/vmalloc.c:2418
> stacktrace:
>       spin_lock include/linux/spinlock.h:351 [inline]
>       find_vmap_area+0xa0/0x228 mm/vmalloc.c:2418
>       find_vm_area+0x20/0x68 mm/vmalloc.c:3208
>       kasan_find_vm_area mm/kasan/report.c:398 [inline]
>       print_address_description mm/kasan/report.c:432 [inline]
>       print_report+0x3d8/0x54c mm/kasan/report.c:521
>       kasan_report+0xb8/0x1d4 mm/kasan/report.c:634
>       __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
>       fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
>       fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
>       fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
>       fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
>       fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
>       __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
>       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
>       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
>       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
>       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
>       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
>       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>
> [E] unlock(report_lock:0):
> (N/A)
> ---------------------------------------------------
> context B's detail
> ---------------------------------------------------
> context B
>    [S] lock(&tb->tb6_lock:0)
>    [W] lock(report_lock:0)
>    [E] unlock(&tb->tb6_lock:0)
>
> [S] lock(&tb->tb6_lock:0):
> [<ffff80008a172d10>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> [<ffff80008a172d10>] __fib6_clean_all+0xe8/0x2b8 net/ipv6/ip6_fib.c:2267
> stacktrace:
>       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>       _raw_spin_lock_bh+0x80/0xd0 kernel/locking/spinlock.c:178
>       spin_lock_bh include/linux/spinlock.h:356 [inline]
>       __fib6_clean_all+0xe8/0x2b8 net/ipv6/ip6_fib.c:2267
>       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
>       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
>       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
>       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
>       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
>       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
>       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
>       call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>       call_netdevice_notifiers net/core/dev.c:2228 [inline]
>       dev_close_many+0x290/0x4b8 net/core/dev.c:1731
>       unregister_netdevice_many_notify+0x574/0x1fa0 net/core/dev.c:11940
>       unregister_netdevice_many net/core/dev.c:12034 [inline]
>       unregister_netdevice_queue+0x2b8/0x390 net/core/dev.c:11877
>       unregister_netdevice include/linux/netdevice.h:3374 [inline]
>       __tun_detach+0xec4/0x1180 drivers/net/tun.c:620
>       tun_detach drivers/net/tun.c:636 [inline]
>       tun_chr_close+0xa4/0x248 drivers/net/tun.c:3390
>       __fput+0x374/0xa30 fs/file_table.c:465
>       ____fput+0x20/0x3c fs/file_table.c:493
>
> [W] lock(report_lock:0):
> [<ffff800080bd2600>] start_report mm/kasan/report.c:215 [inline]
> [<ffff800080bd2600>] kasan_report+0x74/0x1d4 mm/kasan/report.c:623
> stacktrace:
>       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inlin=
e]
>       _raw_spin_lock_irqsave+0x6c/0xd8 kernel/locking/spinlock.c:162
>       start_report mm/kasan/report.c:215 [inline]
>       kasan_report+0x74/0x1d4 mm/kasan/report.c:623
>       __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
>       fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
>       fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
>       fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
>       fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
>       fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
>       __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
>       fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
>       rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
>       rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
>       addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
>       addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
>       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
>       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
>
> [E] unlock(&tb->tb6_lock:0):
> (N/A)
> ---------------------------------------------------
> context C's detail
> ---------------------------------------------------
> context C
>    [S] write_lock(&ndev->lock:0)
>    [W] lock(&tb->tb6_lock:0)
>    [E] write_unlock(&ndev->lock:0)
>
> [S] write_lock(&ndev->lock:0):
> [<ffff80008a133bd8>] addrconf_permanent_addr net/ipv6/addrconf.c:3622 [in=
line]
> [<ffff80008a133bd8>] addrconf_notify+0xab4/0x1688 net/ipv6/addrconf.c:369=
8
> stacktrace:
>       __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
>       _raw_write_lock_bh+0x88/0xd4 kernel/locking/spinlock.c:334
>       addrconf_permanent_addr net/ipv6/addrconf.c:3622 [inline]
>       addrconf_notify+0xab4/0x1688 net/ipv6/addrconf.c:3698
>       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
>       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
>       call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>       call_netdevice_notifiers net/core/dev.c:2228 [inline]
>       __dev_notify_flags+0x114/0x294 net/core/dev.c:9393
>       netif_change_flags+0x108/0x160 net/core/dev.c:9422
>       do_setlink.isra.0+0x960/0x3464 net/core/rtnetlink.c:3152
>       rtnl_changelink net/core/rtnetlink.c:3769 [inline]
>       __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
>       rtnl_newlink+0x1080/0x1a1c net/core/rtnetlink.c:4065
>       rtnetlink_rcv_msg+0x82c/0xc30 net/core/rtnetlink.c:6955
>       netlink_rcv_skb+0x218/0x400 net/netlink/af_netlink.c:2534
>       rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6982
>       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>       netlink_unicast+0x50c/0x778 net/netlink/af_netlink.c:1339
>       netlink_sendmsg+0x794/0xc28 net/netlink/af_netlink.c:1883
>       sock_sendmsg_nosec net/socket.c:712 [inline]
>       __sock_sendmsg+0xe0/0x1a0 net/socket.c:727
>       __sys_sendto+0x238/0x2fc net/socket.c:2180
>
> [W] lock(&tb->tb6_lock:0):
> [<ffff80008a1643fc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> [<ffff80008a1643fc>] __ip6_ins_rt net/ipv6/route.c:1350 [inline]
> [<ffff80008a1643fc>] ip6_route_add+0x7c/0x220 net/ipv6/route.c:3900
> stacktrace:
>       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>       _raw_spin_lock_bh+0x5c/0xd0 kernel/locking/spinlock.c:178
>       spin_lock_bh include/linux/spinlock.h:356 [inline]
>       __ip6_ins_rt net/ipv6/route.c:1350 [inline]
>       ip6_route_add+0x7c/0x220 net/ipv6/route.c:3900
>       addrconf_prefix_route+0x28c/0x494 net/ipv6/addrconf.c:2487
>       fixup_permanent_addr net/ipv6/addrconf.c:3602 [inline]
>       addrconf_permanent_addr net/ipv6/addrconf.c:3626 [inline]
>       addrconf_notify+0xfd0/0x1688 net/ipv6/addrconf.c:3698
>       notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>       raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
>       call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
>       call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>       call_netdevice_notifiers net/core/dev.c:2228 [inline]
>       __dev_notify_flags+0x114/0x294 net/core/dev.c:9393
>       netif_change_flags+0x108/0x160 net/core/dev.c:9422
>       do_setlink.isra.0+0x960/0x3464 net/core/rtnetlink.c:3152
>       rtnl_changelink net/core/rtnetlink.c:3769 [inline]
>       __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
>       rtnl_newlink+0x1080/0x1a1c net/core/rtnetlink.c:4065
>       rtnetlink_rcv_msg+0x82c/0xc30 net/core/rtnetlink.c:6955
>       netlink_rcv_skb+0x218/0x400 net/netlink/af_netlink.c:2534
>       rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6982
>       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>       netlink_unicast+0x50c/0x778 net/netlink/af_netlink.c:1339
>       netlink_sendmsg+0x794/0xc28 net/netlink/af_netlink.c:1883
>
> [E] write_unlock(&ndev->lock:0):
> (N/A)
> ---------------------------------------------------
> context D's detail
> ---------------------------------------------------
> context D
>    [S] lock(&vn->busy.lock:0)
>    [W] write_lock(&ndev->lock:0)
>    [E] unlock(&vn->busy.lock:0)
>
> [S] lock(&vn->busy.lock:0):
> [<ffff800080adcf80>] spin_lock include/linux/spinlock.h:351 [inline]
> [<ffff800080adcf80>] alloc_vmap_area+0x800/0x26d0 mm/vmalloc.c:2027
> stacktrace:
>       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>       _raw_spin_lock+0x78/0xc0 kernel/locking/spinlock.c:154
>       spin_lock include/linux/spinlock.h:351 [inline]
>       alloc_vmap_area+0x800/0x26d0 mm/vmalloc.c:2027
>       __get_vm_area_node+0x1c8/0x360 mm/vmalloc.c:3138
>       __vmalloc_node_range_noprof+0x168/0x10d4 mm/vmalloc.c:3805
>       __vmalloc_node_noprof+0x130/0x178 mm/vmalloc.c:3908
>       vzalloc_noprof+0x3c/0x54 mm/vmalloc.c:3981
>       alloc_counters net/ipv6/netfilter/ip6_tables.c:815 [inline]
>       copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
>       get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
>       do_ip6t_get_ctl+0x520/0xad0 net/ipv6/netfilter/ip6_tables.c:1677
>       nf_getsockopt+0x8c/0x10c net/netfilter/nf_sockopt.c:116
>       ipv6_getsockopt+0x24c/0x460 net/ipv6/ipv6_sockglue.c:1493
>       tcp_getsockopt+0x98/0x120 net/ipv4/tcp.c:4727
>       sock_common_getsockopt+0x9c/0xcc net/core/sock.c:3867
>       do_sock_getsockopt+0x308/0x57c net/socket.c:2357
>       __sys_getsockopt+0xec/0x188 net/socket.c:2386
>       __do_sys_getsockopt net/socket.c:2393 [inline]
>       __se_sys_getsockopt net/socket.c:2390 [inline]
>       __arm64_sys_getsockopt+0xa8/0x110 net/socket.c:2390
>       __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
>       invoke_syscall+0x88/0x2e0 arch/arm64/kernel/syscall.c:50
>       el0_svc_common.constprop.0+0xe8/0x2e0 arch/arm64/kernel/syscall.c:1=
39
>
> [W] write_lock(&ndev->lock:0):
> [<ffff80008a127f20>] addrconf_rs_timer+0xa0/0x730 net/ipv6/addrconf.c:402=
5
> stacktrace:
>       __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
>       _raw_write_lock+0x5c/0xd0 kernel/locking/spinlock.c:300
>       addrconf_rs_timer+0xa0/0x730 net/ipv6/addrconf.c:4025
>       call_timer_fn+0x204/0x964 kernel/time/timer.c:1789
>       expire_timers kernel/time/timer.c:1840 [inline]
>       __run_timers+0x830/0xb00 kernel/time/timer.c:2414
>       __run_timer_base kernel/time/timer.c:2426 [inline]
>       __run_timer_base kernel/time/timer.c:2418 [inline]
>       run_timer_base+0x124/0x198 kernel/time/timer.c:2435
>       run_timer_softirq+0x20/0x58 kernel/time/timer.c:2445
>       handle_softirqs+0x30c/0xdc0 kernel/softirq.c:579
>       __do_softirq+0x14/0x20 kernel/softirq.c:613
>       ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
>       call_on_irq_stack+0x24/0x30 arch/arm64/kernel/entry.S:891
>       do_softirq_own_stack+0x20/0x40 arch/arm64/kernel/irq.c:86
>       invoke_softirq kernel/softirq.c:460 [inline]
>       __irq_exit_rcu+0x400/0x560 kernel/softirq.c:680
>       irq_exit_rcu+0x14/0x80 kernel/softirq.c:696
>       __el1_irq arch/arm64/kernel/entry-common.c:561 [inline]
>       el1_interrupt+0x38/0x54 arch/arm64/kernel/entry-common.c:575
>       el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:580
>       el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:596
>
> [E] unlock(&vn->busy.lock:0):
> (N/A)
> ---------------------------------------------------
> information that might be helpful
> ---------------------------------------------------
> CPU: 1 UID: 0 PID: 19536 Comm: syz.4.2592 Not tainted 6.15.0-rc6-00043-ga=
83a69ec7f9f #5 PREEMPT
> Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> Call trace:
>  dump_backtrace arch/arm64/kernel/stacktrace.c:449 [inline] (C)
>  show_stack+0x34/0x80 arch/arm64/kernel/stacktrace.c:466 (C)
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x104/0x180 lib/dump_stack.c:120
>  dump_stack+0x20/0x2c lib/dump_stack.c:129
>  print_circle kernel/dependency/dept.c:928 [inline]
>  cb_check_dl kernel/dependency/dept.c:1362 [inline]
>  cb_check_dl+0x1080/0x10ec kernel/dependency/dept.c:1356
>  bfs+0x4d8/0x630 kernel/dependency/dept.c:980
>  check_dl_bfs kernel/dependency/dept.c:1381 [inline]
>  add_dep+0x1cc/0x364 kernel/dependency/dept.c:1710
>  add_wait kernel/dependency/dept.c:1829 [inline]
>  __dept_wait+0x60c/0x16e0 kernel/dependency/dept.c:2585
>  dept_wait kernel/dependency/dept.c:2666 [inline]
>  dept_wait+0x168/0x1a8 kernel/dependency/dept.c:2640
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x54/0xc0 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  find_vmap_area+0xa0/0x228 mm/vmalloc.c:2418
>  find_vm_area+0x20/0x68 mm/vmalloc.c:3208
>  kasan_find_vm_area mm/kasan/report.c:398 [inline]
>  print_address_description mm/kasan/report.c:432 [inline]
>  print_report+0x3d8/0x54c mm/kasan/report.c:521
>  kasan_report+0xb8/0x1d4 mm/kasan/report.c:634
>  __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
>  fib6_ifdown+0x67c/0x6bc net/ipv6/route.c:4910
>  fib6_clean_node+0x23c/0x4e0 net/ipv6/ip6_fib.c:2199
>  fib6_walk_continue+0x38c/0x774 net/ipv6/ip6_fib.c:2124
>  fib6_walk+0x158/0x31c net/ipv6/ip6_fib.c:2172
>  fib6_clean_tree+0xe0/0x128 net/ipv6/ip6_fib.c:2252
>  __fib6_clean_all+0x104/0x2b8 net/ipv6/ip6_fib.c:2268
>  fib6_clean_all+0x3c/0x50 net/ipv6/ip6_fib.c:2279
>  rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
>  rt6_disable_ip+0x270/0x840 net/ipv6/route.c:4956
>  addrconf_ifdown.isra.0+0x104/0x175c net/ipv6/addrconf.c:3857
>  addrconf_notify+0x3a0/0x1688 net/ipv6/addrconf.c:3780
>  notifier_call_chain+0x94/0x50c kernel/notifier.c:85
>  raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
>  call_netdevice_notifiers_info+0xb8/0x150 net/core/dev.c:2176
>  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>  call_netdevice_notifiers net/core/dev.c:2228 [inline]
>  dev_close_many+0x290/0x4b8 net/core/dev.c:1731
>  unregister_netdevice_many_notify+0x574/0x1fa0 net/core/dev.c:11940
>  unregister_netdevice_many net/core/dev.c:12034 [inline]
>  unregister_netdevice_queue+0x2b8/0x390 net/core/dev.c:11877
>  unregister_netdevice include/linux/netdevice.h:3374 [inline]
>  __tun_detach+0xec4/0x1180 drivers/net/tun.c:620
>  tun_detach drivers/net/tun.c:636 [inline]
>  tun_chr_close+0xa4/0x248 drivers/net/tun.c:3390
>  __fput+0x374/0xa30 fs/file_table.c:465
>  ____fput+0x20/0x3c fs/file_table.c:493
>  task_work_run+0x154/0x278 kernel/task_work.c:227
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x950/0x23a8 kernel/exit.c:953
>  do_group_exit+0xc0/0x248 kernel/exit.c:1103
>  get_signal+0x1f98/0x20cc kernel/signal.c:3034
>  do_signal+0x200/0x880 arch/arm64/kernel/signal.c:1658
>  do_notify_resume+0x1a0/0x26c arch/arm64/kernel/entry-common.c:148
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_svc+0xf8/0x188 arch/arm64/kernel/entry-common.c:745
>  el0t_64_sync_handler+0x10c/0x140 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>
> ---
>  mm/kasan/report.c | 45 ++-------------------------------------------
>  1 file changed, 2 insertions(+), 43 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 8357e1a33699..b0877035491f 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -370,36 +370,6 @@ static inline bool init_task_stack_addr(const void *=
addr)
>                         sizeof(init_thread_union.stack));
>  }
>
> -/*
> - * This function is invoked with report_lock (a raw_spinlock) held. A
> - * PREEMPT_RT kernel cannot call find_vm_area() as it will acquire a sle=
eping
> - * rt_spinlock.
> - *
> - * For !RT kernel, the PROVE_RAW_LOCK_NESTING config option will print a
> - * lockdep warning for this raw_spinlock -> spinlock dependency. This co=
nfig
> - * option is enabled by default to ensure better test coverage to expose=
 this
> - * kind of RT kernel problem. This lockdep splat, however, can be suppre=
ssed
> - * by using DEFINE_WAIT_OVERRIDE_MAP() if it serves a useful purpose and=
 the
> - * invalid PREEMPT_RT case has been taken care of.
> - */
> -static inline struct vm_struct *kasan_find_vm_area(void *addr)
> -{
> -       static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
> -       struct vm_struct *va;
> -
> -       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -               return NULL;
> -
> -       /*
> -        * Suppress lockdep warning and fetch vmalloc area of the
> -        * offending address.
> -        */
> -       lock_map_acquire_try(&vmalloc_map);
> -       va =3D find_vm_area(addr);
> -       lock_map_release(&vmalloc_map);
> -       return va;
> -}
> -
>  static void print_address_description(void *addr, u8 tag,
>                                       struct kasan_report_info *info)
>  {
> @@ -429,19 +399,8 @@ static void print_address_description(void *addr, u8=
 tag,
>         }
>
>         if (is_vmalloc_addr(addr)) {
> -               struct vm_struct *va =3D kasan_find_vm_area(addr);
> -
> -               if (va) {
> -                       pr_err("The buggy address belongs to the virtual =
mapping at\n"
> -                              " [%px, %px) created by:\n"
> -                              " %pS\n",
> -                              va->addr, va->addr + va->size, va->caller)=
;
> -                       pr_err("\n");
> -
> -                       page =3D vmalloc_to_page(addr);
> -               } else {
> -                       pr_err("The buggy address %px belongs to a vmallo=
c virtual mapping\n", addr);
> -               }
> +               pr_err("The buggy address %px belongs to a vmalloc virtua=
l mapping\n", addr);
> +               page =3D vmalloc_to_page(addr);
>         }
>
>         if (page) {
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>
