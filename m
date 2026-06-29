Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10940681D
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738777; cv=none; b=AOF/VL64drK4dJ0f1QEy0rN9FM8XwVHLVRNkz0ZEf6IBsYBSep40hwmTWrMX5y9Onj8RWn2FMK3xd6W3rpckl6mhVPNstGBLl1SnBtVaqUy4je9ia+GvTuSLrXb1L2t3uoog5ABwA20urSF7aJsqUt9KksXVYTQlxuBO8oq7nIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738777; c=relaxed/simple;
	bh=GTHoxJ99biZ8FOjq3pfZmCbm0/qhn/r6w9hjL9w/CGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOMPS7CMXfOtj7qzEYoYtGxTyjYRHsibPwOK07Oo9MrXUGKOTKssRd9K6C4Wryevlc0eBJjzMkhXraHSPDDT85l5qGNpHIwaytwz6kC4kV8Abx3B6UXbZH2z2PLt/48FDDbzHF+JjTV2woyYxZEQxsaMig2iN9oTlXms5ypGOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcGHSbz6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D4x+DcX2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcGHSbz6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D4x+DcX2"
Date: Mon, 29 Jun 2026 15:12:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782738773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zw+RT1NKAF0aQaiZlH21SqdyQS0ZhWGU3d3VMX1aeCU=;
	b=tcGHSbz6F9WV28RDo6yMc33jFoeHFRxclQbLRtFNJGpZnDuUQHjPW3GDaZorxrvO3DWdk3
	jcbya2ESSg60KejCZJgZwsc3LGZTtbc16peFb/2C1C3yfvXo90YVvhvz9saqDnXTB1j4+I
	Kjb6pOKetBihkbIXOrJzxTy34nG+BRYGAN9ILGCEcTNZ1F+PLBZeq5W4Ay1+aaWn0M/k1d
	L/06YWSEmvFnff7wYohtJOf72qrEJ8HSWXeM+mWAnsFy5tFeNWKhOBTSdwDVpugcLgKgiP
	wuP0jzXl/QwGvyt+1BpskRHlxzi+ofr3V8/ONpAS3pxVxoWHNGQsSV5PRQFCeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782738773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zw+RT1NKAF0aQaiZlH21SqdyQS0ZhWGU3d3VMX1aeCU=;
	b=D4x+DcX26zcpwPseZ1+GItizECXYop0z6vMgenhXufoZyEqvGtDLzPhn9uIBFjv3v8K+La
	r0E6dDB4wF8v4KBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, arnd@arndb.de,
	clrkwllms@kernel.org, liaohua4@huawei.com, lilinjie8@huawei.com,
	linusw@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] ARM: enable interrupts when unhandled user faults are
 triggered
Message-ID: <20260629131251.1odjlGCC@linutronix.de>
References: <20260629123349.134224-1-xieyuanbin1@huawei.com>
 <20260629124816.136079-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629124816.136079-1-xieyuanbin1@huawei.com>

On 2026-06-29 20:48:16 [+0800], Xie Yuanbin wrote:
> On Mon, 29 Jun 2026 11:40:22 +0200, Sebastian Andrzej Siewior wrote:
> > If this is moved to the callers of arm_notify_die() then I don't know
> > what to do about baddataabort(). It looks like it gets invoked with
> > disabled interrupts, too but I'm not sure. This looks like pre ARM v7.
> > Is it reasonable to add such a check there?
> 
> Oh, I'm not sure about this place either. Would interrupts here be
> disabled? I'm not familiar with the entry assembly code of v4t, so
> I don't know how to construct a user-space program that can run to
> baddataabort(), and I also don't have a v4t device to test it.

I don't have anything myself but it follows the same pattern.
Sashiko just reported that it is a pre-existing issue :)

Sebastian
