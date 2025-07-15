Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00619CCF5
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610226; cv=none; b=N+lggYuX2v+WCBst/5E24LbrY1PjgPnDuWiwGurLZ/rZzCYc0uMu5lyrOh8pHzl4KSySOyLzUSNyDdKb3OGeSzzmi4ueYtEmVdAcaKt3RQMS4L0QooG+h89yffk8PB1emLDhoLfoa0nB+3AN2/QPkI+Kvm/LVxvQbfdvNg2Orn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610226; c=relaxed/simple;
	bh=cU9i1wr/qttX/NxtKUGU7maFCojwI67SBXWmeC2s5lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHurpIKNfITGLSc+FW935jAaeV56ptlhCgcjBJvQ6XnpaaxQd2T76U7fZ4JAC25caaomXraV9CkptARIfRMRj/XvIbCrZzFICTUhUbQDH9IN50KY00Onmmc3Zp524EN8IF4JGUExnQUdIkaX9aqqv45Rc6XRFHath4JVqwlHKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gqDvPi/3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gqDvPi/3"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5900840AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752610224; bh=miYc8hGZ3thT5RjnLLLSR8gNgdp/SgVJA93cuXxYcpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gqDvPi/3BJDpz3ZeOFZhrRxUOwpyDZas+bHGAFaGa1Ze88f2k2FRWatUZsXmzbMzv
	 Xf1Ifz23HZL5zDYbjxaZfF/0Nra53cotA3qjoI2G56gPGe9oWUMjx26tDLvo/Jamp5
	 57QbIIwVVg5PGBT2m7Nl03ElwP7qPP0UGq4BGuAcGPg8nUMGW85LlKSPcxYpF88uV6
	 5u4u0CBGVSxWMn3zPG3pfMVFt71vxyqHB8ENvqsMixL+y16HLtMqVwY9F2xJrdrE3+
	 hNArh/Zt6rHeUqKGWFszA+FRXGW9BJfFXjpkrHHc9tdhIT6yf6B/yutiQKSfjOIJM4
	 WlT0SfsPVBi3A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5900840AD0;
	Tue, 15 Jul 2025 20:10:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>, Clark Williams
 <clrkwllms@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/3] Documentation: locking: Add local_lock_nested_bh()
 to locktypes
In-Reply-To: <20250715144127.697787-3-bigeasy@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-3-bigeasy@linutronix.de>
Date: Tue, 15 Jul 2025 14:10:23 -0600
Message-ID: <87zfd5dxlc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> local_lock_nested_bh() is used within networking where applicable.
> Document why it is used and how it behaves.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/locking/locktypes.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 80c914f6eae7a..4851ec1232058 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
>  local_lock is not suitable to protect against preemption or interrupts on a
>  PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>  
> +CPU local scope and bottom-half
> +-------------------------------
> +
> +Per-CPU variables that are accessed only in softirq context should not rely on
> +the assumption that this context is implicitly protected due to being
> +non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, and
> +synchronizing every bottom-half-disabled section via implicit context results
> +in an implicit per-CPU "big kernel lock."
> +
> +A local_lock_t together with local_lock_nested_bh() and
> +local_unlock_nested_bh() for locking operations help to identify the locking
> +scope.
> +
> +With lockdep is enabled, these functions verify that data structure access

Did you mean *When* lockdep is enabled?

Otherwise no complaints here.

jon
