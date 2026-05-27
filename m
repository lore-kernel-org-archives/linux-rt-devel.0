Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E43BB9F5
	for <linux-rt-devel@lists.linux.dev>; Wed, 27 May 2026 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866178; cv=none; b=W8UH/4Pvj3nU38OU52Myf1JZjawClUm+SuAyCL3DLtNsMNhbNV8cMrdO5KLAyCKCTXk4i4I/05UDAAnE0A3iF+wym+QH0lnVR4Axq3tNZbpJee0tSROUrFDB6vZ1AJpBU/YyL/IWhTTkSmV8hsyO5V2ReD1nh4Vu5XVvhinJ99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866178; c=relaxed/simple;
	bh=rwbu1JjOlBHSv0oqanc3D6oxYHRDXPMUDaKegJ/YJTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJqiLF+NjHnKf7FxHgFr40EjONQmepWlDSTksZM60rmvA2oO+dM8lB215ZIIqd2jY4oCtT4EedRFoS8re1Tpusvp/tp8FephbtQA4dffXyPDgwBXnWYlWUzx7+L1/OKatx+bG5NRRLKPav2ZW0Fu41QfJgS2Tu3ZM6HSHZcRg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+wOgIOt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xaiocjhj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+wOgIOt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xaiocjhj"
Date: Wed, 27 May 2026 09:16:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779866175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AH5sgHy+bL5b68ae+ELbUNqD19ikq6EFa5yg38AqiQo=;
	b=a+wOgIOtR8tATMIwSqFnGqUekgnHtXGzBojGqkoEW+M5zOzgcnio5D0PJemM37FPwkL4SY
	+K2NODKDBWPZxNRc9VwdQpXFqLwAdCYsJ/evS2wagXg7Nt8mWsmsyval3cKz5WqecNZhCs
	8kXNG//JvraGIOfvUnlcADv+8KgS+YkJVa3tO69Z9wc14ttlw9gqWLmV7eiyhCI+GLVyH4
	6m6feRTjZfCZa4D/63uN9zK2MRIXRTa1VK6JocYiqDCOdoLIaNo5AMzYjDkD+KyY7ekP7s
	kjNH4zdJ19zCg2E8jYsfIRiTVRZrBK0sxvaYqN167RG952xpWSX8oq8daRefpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779866175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AH5sgHy+bL5b68ae+ELbUNqD19ikq6EFa5yg38AqiQo=;
	b=xaiocjhjSqbBXxEeCWqGysVOh90vzHCbKz2tGHHyqWrRuSWGPZMhAQSRGopAKMHdpb7QlT
	PQlZH3VDU0OahQAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] l2tp: use refcount_inc_not_zero in
 l2tp_session_get_by_ifname
Message-ID: <20260527071614.MwD6LIK5@linutronix.de>
References: <20260523023423.2568972-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260523023423.2568972-1-michael.bommarito@gmail.com>

sorry for being late=E2=80=A6

On 2026-05-22 22:34:23 [-0400], Michael Bommarito wrote:
=E2=80=A6
> a slab-use-after-free. On PREEMPT_RT local_bh_disable() is a per-CPU
> sleeping lock and the preemption window is real;=20
No, it is not but there is a preemption window, yes.

>                                                  on stock PREEMPT
> kernels local_bh_disable() is a preempt_count increment that closes
> the cross-CPU race in practice (see below).

It might be that the window is not wide open. I don't see why it should
not trigger on SMP.

> Use refcount_inc_not_zero() and continue the list walk on failure,
> matching the other session getters in the file. The ifname getter
> is the only session getter in net/l2tp/ that still uses the bare
> refcount_inc() pattern; this change restores file-internal
> consistency. The success path is unchanged.

This is the right change.

> Fixes: abe7a1a7d0b6 ("l2tp: improve tunnel/session refcount helpers")

This simply removes the wrapper but the logic is the same. Wouldn't
commit 2777e2ab5a9cf ("l2tp: take a reference on sessions used in
genetlink handlers") be where it was introduced?

> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
=E2=80=A6

Sebastian
