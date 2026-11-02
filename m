Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626469;
	b=fpWXkmYanoVEV0ccf4F4oFN6incEabympIT3VSlqmaTGESgxGoa0qCnPCBXNh4SI8uNa
	 5s8Picwgv2MYGjJzaVPbU55HsItcli+PrGeUUWjnMw6tuyujJKUPgL+ZmbQqp0fBL+xJT
	 k1JTYSHTPcpaJ+PkMhsS7OKL9bbAM+vaAG4ISxmJy88mugSXQNNZw7mTR/n3G0CvG6+BQ
	 ZS7OicD3WJmDoMj7ye+SYSdCeIc6/hewsjVvvLkJeCWK45bdH5NG4552Cis3hPH8gyPOC
	 lzieKH8aZ0izp+Zynr+ZHVt31DrTJmu/08A/Dt93cxqDhYD7Oow7Ln3PGsGLCbgXu9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626469;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=g6NqlTicICQ+q+/83SlSfc2B/u3HZTwUz3v/TRoTmcQ=;
	b=SNC+vLoiAyEShmU4b4XZE46JuBMHX7LRVEqsiCcC7U5AUFaBqjOLH8dF+sCybkolV7sY
	 4nz8YRbrv3Hr9om1XDXyB/Vr0t2ut3DWSGLf5lz8kC9Iwi9jJ4+vXBO5sevmvjw3lICel
	 g/cZ7t+1MlJ8f/CHbW+N1v/mCyQSFuelgEYIq5aBeRdCNuty6O65R5o9iDo4wg1xzLOvp
	 Eu7Ln+bufTwKqxnYxCVZSUi5XGOKO0hM3cmelxo8ZH5YAEH2YJhpwWIAGUxfdhJw2O+uC
	 J37JRAEe/RZfAuCK/8WPiUIhNJB7BhZCRCfzuyytOyJZ2k50634Y6zVlEDfqTLiKKew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RG101fkI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p6aU+dmZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD80606A326
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 13:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD80606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RG101fkI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p6aU+dmZ
Date: Mon, 2 Nov 2026 14:34:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793626465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6NqlTicICQ+q+/83SlSfc2B/u3HZTwUz3v/TRoTmcQ=;
	b=RG101fkIyuPnwL7br2mkd5gFEHIIYvlds88GJF2Fay8Rfx9jv4mEggYFRLOkVLJKi8grhP
	8jDxFfe4HkcPvSGiWuyjMHwxZYhVzBSTLod/0vHzOAjUda/UmDa2dkeBc1PS6iCbMvD+6h
	4nMFRb2hEP4OzXmtdR4En83ifxAE59MnAq9OR0Sg3+TQSdZtpZiFai4zpMyzkOwEwgmdS1
	jO5uQEKm96baMRqF8zKApWWALbfsuRsmrpcgzkqBDOuBL0eCzw72fCFFz8ggf+v0D4PG8R
	722Ic/AGwFscpf02t56LuKbSZ/6hv+lCplgU01eToOm1cycr3zzOxo5OQ/y6Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793626465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6NqlTicICQ+q+/83SlSfc2B/u3HZTwUz3v/TRoTmcQ=;
	b=p6aU+dmZl6ayr9jfXroxmyJFq8wrGWOdSon326kXuQGuPy4ppNcHnfBYQ7O7aZuaZAMsvW
	+npbd/grJEuAaNCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	clrkwllms@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
	arnd@arndb.de, bp@alien8.de, kmehltretter@gmail.com,
	dapeng1.mi@linux.intel.com, elver@google.com,
	enelsonmoore@gmail.com, jlayton@kernel.org,
	quchaosheng000406@163.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] docs: sched-preemption: Fix the list of
 runtime-selectable models
Message-ID: <20261102133424.rJTJIkFX@linutronix.de>
References: <20261028024333.795917-1-ruanjinjie@huawei.com>
 <20261028024333.795917-3-ruanjinjie@huawei.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028024333.795917-3-ruanjinjie@huawei.com>

On 2026-10-28 10:43:33 [+0800], Jinjie Ruan wrote:
> --- a/Documentation/scheduler/sched-preemption.rst
> +++ b/Documentation/scheduler/sched-preemption.rst
> @@ -20,9 +20,6 @@ change.
>  The models selectable at runtime are:
>  
>  	=========	====================================================
> -	none		No preemption of kernel code other than at explicit
> -			``cond_resched()`` / blocking points.
> -	voluntary	As ``none``, plus ``might_sleep()`` sites.
>  	full		Any section that is not explicitly preempt disabled
>  			may be preempted at any time.
>  	lazy		As ``full``, except that the scheduling request is

This is fine.

> @@ -31,10 +28,12 @@ The models selectable at runtime are:
>  			apply to real-time tasks.
>  	=========	====================================================
>  
> -Not every model is available on every kernel.  An architecture that provides
> -lazy-preempt support offers only ``full`` and ``lazy``, and ``none`` and
> -``voluntary`` are rejected there.  A PREEMPT_RT kernel always offers ``full``,
> -and ``lazy`` as well if the architecture provides it.
> +CONFIG_PREEMPT_DYNAMIC depends on CONFIG_ARCH_HAS_PREEMPT_LAZY, so ``none``
> +and ``voluntary`` are never selectable at runtime; passing either is
> +rejected with "Dynamic Preempt: unsupported mode".  The two models are only
> +left as build-time choices on architectures without lazy-preempt support.
> +A PREEMPT_RT kernel always offers ``full``, and ``lazy`` as well if the
> +architecture provides it.

What about:
 Not every model is available on every kernel.  An architecture that provides
 preemption support supports ``full``. If additionally lazy-preempt is
 supported then the choice ``lazy`` becomes available. An architecture
 without preemption support can not enable CONFIG_PREEMPT_DYNAMIC. On
 such an architecture the preemption model can only be selected at
 compile time. 

Sebastian
