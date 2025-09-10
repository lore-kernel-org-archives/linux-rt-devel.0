Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E181B4236
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Sep 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502041; cv=none; b=gKQ6cTqY02sPL4Bh56bw4zT955P+8lFZRlPwAjz/DqJPdBx/tBDQzT3s4xw7xVE/ojWk/K6zQFbY8FHk1rhl3amq/MoIOrAYbE83XHiCN/kULkSqvGIirtvmErBhUVHiznxFOu5cKKyWz/RL0sca1/g4FFg2Nj1hlHpxF2G6+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502041; c=relaxed/simple;
	bh=3q09RmMkWSHgrLY6p8anzbp6nCFALU1LtrNvIDZ55sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP+d56hruO5untM9r6Hp7egI4VOA0UCsO916SoIk+XoWT3d9jUNtKUwlBs7ZTZjyFyEdZ2CGrpS352v3GCi5U+9RobyoKKFNyBbbLZO9M8qLVZMvB0VfAXqYNezpwzjpilFv5tGJAI8537swF9k57Vx4nx3pQNYhIzKl3nFNW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EvJBQClh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHZFRomI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EvJBQClh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHZFRomI"
Date: Wed, 10 Sep 2025 13:00:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757502038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfzc87QdWgWMMWC+tnsO32jnctjxPw3Hh/HTjNOLmus=;
	b=EvJBQClh8of271fAFeiBu/IqmIcfIzE3oWxHKBUD1CuTVoKoDrW2B1QSUV6kem5LmRhjpZ
	Ij24VtscTIeLVjiyQpJQUuMkXwDEmNXKzIZ1sx9dk00G8h/Fv1c3jGKOiDDAG6Umxizrar
	cDFFdJV3xF9aVDKQSC1L3fAA2Dsf0NABf3oUj7eXP4W3KoC6txs44ixCi+kWfo8awSz6oL
	2/0GDeqDm1G+/sKRLR6OBDd3SCYRdFqsqAidSM2015CBi1+W34sxFOsv2Uu9kejaAm30XP
	9UXi3BnugKX7ElAhQralKvYk3uc+tdJJcp2irhekVprLGhEFlKPCjKaTGwjUPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757502038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfzc87QdWgWMMWC+tnsO32jnctjxPw3Hh/HTjNOLmus=;
	b=CHZFRomIn7JliWyt+7fTM31EUzmgbLZaVtgtJufg5ZiWQegB81CxSvChfsUGRNHyOAmEkb
	qjzkpOY1r/qn51Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] Documentation: update config name in real-time
 architecture support
Message-ID: <20250910110037.-QJ4Esqh@linutronix.de>
References: <20250910085859.47818-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910085859.47818-1-lukas.bulwahn@redhat.com>

On 2025-09-10 10:58:59 [+0200], Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 14ec35ff5786 ("entry: Rename "kvm" entry code assets to "virt" to
> genericize APIs") renames the config KVM_XFER_TO_GUEST_WORK to

This is 4843a45ef9fe8 ("entry: Rename "kvm" entry code assets to "virt" to genericize APIs")
in -next as of today.

> VIRT_XFER_TO_GUEST_WORK. In a concurrent development work with commit
> f51fe3b7e48c ("Documentation: Add real-time to core-api"), the
> documentation on making an architecture support PREEMPT_RT has been
> included referring to this config with its previous name.
> 
> Adjust the documentation to the current situation, and specifically
> refer to the new name of the config.
> 
> Fixes: f51fe3b7e48c ("Documentation: Add real-time to core-api")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  Documentation/core-api/real-time/architecture-porting.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Documentation/core-api/real-time/architecture-porting.rst
> index d822fac29922..3062cff0e5a3 100644
> --- a/Documentation/core-api/real-time/architecture-porting.rst
> +++ b/Documentation/core-api/real-time/architecture-porting.rst
> @@ -35,9 +35,10 @@ POSIX CPU timers and KVM
>    POSIX CPU timers must expire from thread context rather than directly within
>    the timer interrupt. This behavior is enabled by setting the configuration
>    option CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.
> -  When KVM is enabled, CONFIG_KVM_XFER_TO_GUEST_WORK must also be set to ensure
> -  that any pending work, such as POSIX timer expiration, is handled before
> -  transitioning into guest mode.
> +  When virtualization support, such as KVM, is enabled,
> +  CONFIG_VIRT_XFER_TO_GUEST_WORK must also be set to ensure that any pending
> +  work, such as POSIX timer expiration, is handled before transitioning into
> +  guest mode.

I don't know how this is handled here but if you would start a new line
after "ensure" then you would end up with smaller diff.

>  Hard-IRQ and Soft-IRQ stacks
>    Soft interrupts are handled in the thread context in which they are raised. If

Sebastian
