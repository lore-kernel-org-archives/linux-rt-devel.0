Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3818386C0D
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Sep 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548255; cv=none; b=ZIDII7XKoKu2/mkm1qW0ACBcZDl0N+XE1vprr6ZNIF4IjPYwfpb0cSIorjVpC2qQCqGks1rAV6bpE1qpjxxZhw0IUnrUNf2Y+EsLyE4yFrrRY+PH4aUAb219kIag2Ejn5URWZK1NbjgWyw+y2l77xJyGT267s1nDqW/6VfXX8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548255; c=relaxed/simple;
	bh=lrtM+xBeckFR4nZsxsjHFZh0rlxPGu3kN0vHHxpEVk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDxoHxjOXcKFvgQLcPQPhSo+naX31/J6Witz2b4s+XleFX6W4AF0h3QPpIuNJXE/FE+9uTKe5eYJzQ3hJOBNFM9rjFLfN2uJsWH0DaWD3jduvnK6oogxUByJ2faCQGNNGVQEYwL6GjStO/MwVx8Z/PZuzLGctRMWi4Y+1fk+c1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0XjFA0+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ptiGNVr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0XjFA0+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ptiGNVr"
Date: Wed, 16 Sep 2026 10:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789548245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASF/WpIYGZkEbpolc/F3Wi3P1TTRk1E6xzIEUVemjeI=;
	b=x0XjFA0+VS6BEKMMEdfX7q5Mr7EzX5vKE1y8qLI28gVtUd4fqQ0gJZvoX1zIdSzgBweSvZ
	DHJ0iNK3IgVzJ3ASqIH1f1M1R33T0DszXC4siJCzMIu9Wpd9xZXhqSSCUJzXU/0/9JHfaR
	yyCZVH64c8Wc9x3iXPCsKGtZful+hF2cMgASgIlNe7Rt9VdQSBdHTtD/DO0q8f6XoSKQRS
	1KVnPvm8tihat2j8M+RtsbcfExXVE++fWc0GBhT2xR/jsT6Fx9ftzEbs+H8Ha6UFa5458f
	lU2j+Q3iAb6TfbdBU0OXUbqddMY8RkwC3PJNM9HR2ffX/J1Llv7WItTKPSed6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789548245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASF/WpIYGZkEbpolc/F3Wi3P1TTRk1E6xzIEUVemjeI=;
	b=1ptiGNVr4mlsFj9znayV4gv6dZ4sSq/SvRX/Iy9R4YOr4p6vIgSVu9BW8La9EtFdlCrxcy
	ouInbmvfiVhXKVBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>, Radu Rendec <rrendec@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] ARM: allocate the cacheinfo early to fix the
 PREEMPT_RT boot warning
Message-ID: <20260916084404.fjkCQKUK@linutronix.de>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>

On 2026-09-12 21:55:48 [+0200], Karl Mehltretter wrote:
> This series moves ARM cacheinfo allocation to the boot CPU to avoid
> sleeping-lock warnings during PREEMPT_RT secondary-CPU startup. It is
> based on 5225b8eec4c9 (7.3-rc2 plus one day).
> 
> Patches 1-3 prepare for early allocation: bound cache-leaf writes,
> include external caches in the allocation size, and guard CLIDR reads
> on older CPUs. Patch 4 enables early allocation. Please take all four
> patches together for stable.
> 
> Tested on QEMU virt (Cortex-A15), vexpress-a9 (Cortex-A9 with PL310),
> and realview-eb-mpcore (ARM11 MPCore) with PREEMPT_RT, plus non-RT
> virt and vexpress-a9 builds. Cache sysfs output is unchanged for the
> normal platform DTs, and CPU hotplug passes where supported. Additional
> checks cover DT leaf undercounting with KASAN and ARM11 DT cache
> descriptions.
> 
> The full series also passes on a Raspberry Pi 400 with a 32-bit
> PREEMPT_RT 7.2.6-rc1 kernel: the boot warning is absent and all 12 cache
> sysfs entries match the baseline. CPU hotplug is unavailable there.

This makes sense.

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
