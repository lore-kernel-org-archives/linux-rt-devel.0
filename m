Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACC286439
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Jun 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298601; cv=none; b=dxNCebYvZF+hU/VBFKDGMgap5cFZ3xD7q/ggHtE+8UKtC5H2uLcSGwM1KVt6RmlyHs/5UhGqlJLBxC35i1XCwPq4l9pdA2rDbhccI1geox9LNliZIQkPZAmSV9vYaUlmn+RKpQyV3JijJiRy5V1jhLz+5W/LpO9kNQlLN0zkrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298601; c=relaxed/simple;
	bh=gDOkh25xXcMTUS9HaJEO2azCcIYGtAbOKrCArVSr9Q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cz6GphsojS2j7mAAPJ01VJM3OcTbCDqvhvBOoDy3s1/vqv+sd1gwXJhamHkWCTjZGyU2Ge0YAVELDbv7qi2Lmz8jvFDSpqd5u4ScZrFnRiiAF3ZA3yhYa9Lbcji/x2MZVj4vR+nRkQppompZqGaoOXXk5j0Zrr2j+FcEkXAbH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmdywXbi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+0eEuN9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmdywXbi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+0eEuN9"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751298598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOVGaTpr5O6VhJZRmy05NTyR377oOtfSuHpGe5zZyHo=;
	b=hmdywXbiQ+m3umczjUqvjz6eILPe9ELqRQ6n7Pdv7ZMNuIRhKfDK7yxcNrkoq1ITt18ybu
	NSOma1xZGaIPn4vT0aZjVapl/tmzwOSDX7C/EImIxEsneCxhYhgsUAfmHDZ2gidMx08W/B
	MY7k1qvPjwbx92WLyFRkQEefdsPuOMNm3ZZZ86rOQUC6zyqAgqkSbuQJ5jUDJ8AYWUyXcy
	abDsoUHd5Cbg6ya1pbHfCjbOeC1o3DBjQJQ07N/gs5ihZCtgt6fvbb+PB2wbYUFIQnKsTI
	DWT3nB/ntHIq0kAfRFobn1G+RRQyXZ856jBzMtJzTe1sOAmoibzc0ohjuRCbrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751298598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOVGaTpr5O6VhJZRmy05NTyR377oOtfSuHpGe5zZyHo=;
	b=q+0eEuN9y4xY59m0+nmMVXndgoQIoiL+9tCXnrCBoOA2X25bDh67o1KwfH6f9cFTpCxoou
	KdMBlxrNBV3H7tDg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun
 Feng <boqun.feng@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 1/1] local_lock: Move this_cpu_ptr() notation from
 internal to main header.
In-Reply-To: <20250630075138.3448715-2-bigeasy@linutronix.de>
References: <20250630075138.3448715-1-bigeasy@linutronix.de>
 <20250630075138.3448715-2-bigeasy@linutronix.de>
Date: Mon, 30 Jun 2025 17:49:58 +0200
Message-ID: <8734bhns9l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30 2025 at 09:51, Sebastian Andrzej Siewior wrote:
> The local_lock.h is the main entry for the local_lock_t type and
> provides wrappers around internal functions prefixed with __ in
> local_lock_internal.h.
>
> Move the this_cpu_ptr() dereference of the variable from the internal to
> the main header. Since it is all macro implemented, this_cpu_ptr() will
> still happen within the preempt/ IRQ disabled section.
> This will free the internal implementation (__) to be used on
> local_lock_t types which are local variables and must not be accessed
> via this_cpu_ptr().
>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've merged that into tip on top of v6.16-rc1 and tagged it, so the
commit can be pulled into net/crypto as needed:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git local-lock-for-net

Thanks,

        tglx
