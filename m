Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5751FC0F3
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Apr 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509810; cv=none; b=UyoCTzBodG/STSDYOZr5q8o9KK37De8N/VmS76hRG0AkypVAeDwVf5M3Msj1Es8azQhPjb0ChvpD0AJGjDvqTYKYGUdHyAdFzNUqcqNmk63v0phZ+GYuNwtUXzthgDfoHi3xF4TJBjbqtY17Giy2wlJkKI68OP/zICBZRSSshUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509810; c=relaxed/simple;
	bh=rV7E7khY6GflsWjerHOpm/+fY+OMiiaLoSnxTYz8ms0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTBRj790VQ2xsHWso7P6C0YXDf6RTGu2YhDZ1hNjlgY64oo5GiaR7jRLJxYxyNWPKExu/dfIptn19mAQ8TSGSq0+G7EFJae8PVmkCdtDJJiUiU2FXXv1KycgP/k014r/pzLDqpD8bQZRcoZnvfHjfXa9FOuhX2yvOKGak9oOyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DLx19PW1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9U9U3Oh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DLx19PW1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9U9U3Oh"
Date: Tue, 1 Apr 2025 14:16:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743509807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSDjtBZ47LpztDJkooWgxLsP/Q2k5iB61gSzS0BtTpY=;
	b=DLx19PW1qy7DpIWE1SWAFScBgx3pQDE9+zAwFCen4DwMDD8DNy4EgjSylL2P+FzuX6iddv
	nR3+wFp0Z68d/fCpX5+pa5etUqbLoGryqO1TwcGdl+o/Zm8yPGWufw4mCdgfd7lHiihHdi
	QSLusGGkv5JxVKSmC44mDWlFBq8dczzAlOrLo9a3NBUOlC6RxEFF6WDXWkCJE8np2GyXxd
	MjX5cxTbZDO60aU2rwQEGO1ztCSjfBa8/C63BWyjI/UJ/2O3LO1DxVHkQ86Y0W3A8CwVf/
	74/iXTKno8i2wN9slWsqoIIvlCGRZ/fOkwm/4pVWPigp3yyqJqzTWvBDhMpAeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743509807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSDjtBZ47LpztDJkooWgxLsP/Q2k5iB61gSzS0BtTpY=;
	b=Z9U9U3Ohl8FHUh8cgVk6EGVIaKKJ3vLhhhlg+QV4V3oGkAqf6NTY0xkvIk50FVrZ/ujOfB
	NdSNj5VGHjEpcRCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ismo 1. Puustinen (Nokia)" <ismo.1.puustinen@nokia.com>
Cc: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: RE: Two kernel oopses
Message-ID: <20250401121645.qhxReysh@linutronix.de>
References: <AS8PR07MB8117D39772278625220157B085A12@AS8PR07MB8117.eurprd07.prod.outlook.com>
 <20250331063139.WHL_PGTC@linutronix.de>
 <AS8PR07MB8117432C9C7C051F57D7495485AC2@AS8PR07MB8117.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR07MB8117432C9C7C051F57D7495485AC2@AS8PR07MB8117.eurprd07.prod.outlook.com>

On 2025-04-01 11:22:24 [+0000], Ismo 1. Puustinen (Nokia) wrote:
> On 2025-03-31 09:32:11 [+0300], Sebastian Andrzej Siewior wrote:
> 
> > I don't know what Talos Linux is. Do you have a vanilla v6.12.13 or do you
> > have any patches (like the PREEMPT_RT patch for v6.12) on top?
> 
> Talos Linux is a minimal Linux distribution for running a Kubernetes node. The system has vanilla 6.12.13. We build it ourselves because Talos doesn't provide a RT kernel. I'm also not sure why the separate PREEMPT_RT patch would be needed on 6.12 -- should I use it?

There are a few extensions which are not yet part of v6.12. Nothing
that would explain this kind of crashes.

> > Both things are scheduler related and mess up its internal state/ tracking. I
> > haven't see anything like it so far. It would be good to know if you have any
> > external patches or if you do anything else usual to track this down.
> 
> There isn't anything special that I can think of. The crashes seem to
> happen on a "mostly idle" system even without any special kernel
> parameters or run the real-time workloads. There are lots of processes
> running on the system though, but the cpu load is small. The server
> itself is a large one with 64 cores, so I guess any race conditions
> are easy to trigger there. The BIOS version is recent, using an older
> version doesn't seem to affect the issues. Also, for what it's worth,
> we see the same crashes also on 6.12.6 kernel. The rt.c:1035 crash
> seems to happen in both IRQ and TASK context. The crashes happen on
> several (identical) servers.

So no external patches.
Could you build one kernel with CONFIG_DEBUG_ATOMIC_SLEEP and check if
something pops up in the kernel buffer?
If the crash happens without additional data could you try to enable
CONFIG_PROVE_LOCKING and try if this option creates additional output?

> I'll add here the first lines of a couple of oopses I have in store, I
> can attach the full backtraces if it helps. I can also add full kernel
> configuration or other data points if you think that it may help, and
> if you think there is something I can try out to help find the issue
> I'm happy to do so.

I've seen the backtraces in bugzilla, that is okay. If you could try the
steps above if this creates an additional source of information what
might be going on, that would be nice.

> Thanks!
> 
> Ismo

Sebastian
