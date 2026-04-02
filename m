Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1632BF5D
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112619; cv=none; b=j9ylEq3hn+XbZPRY9LrrIjce+ku9JvxsWnyXT0gnfeRHQ8JlYPDUeqg5hOLNvwMBbtbXS9qd7P5if7sMfA/O6KrzcRqKPKWSOgX9G2semR+Uk27UomLbzKpsUTyXsszsfnO0OmkdwhiKHfjnCxr2b9D2/0Tv5+kD31kjWUMHXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112619; c=relaxed/simple;
	bh=FDBfbYuR0sezk33n0Yqae9MBxFSwAVgx4KMwokcLh6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0AP0PuIURvJF8r0Q++2QHr4DdnavLwEirkEhtA0llybXzq81elQkcNJ/o0CMXTwBS5LXO60CX8cCoGpyK5sHv4+yFpw8PW+J9Pd87TPgySybu4BgBwsrhmjGdDHkiTGoJhfJ/hR3ZMyLw1h8BZuLZsIFvCRoQznybp9bdEk5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbraNC/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W7g8stzG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbraNC/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W7g8stzG"
Date: Thu, 2 Apr 2026 08:50:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775112616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDBfbYuR0sezk33n0Yqae9MBxFSwAVgx4KMwokcLh6A=;
	b=dbraNC/j65WI/W4lW19TcIueFAJN0y2PeQKu+Kh1hqwvVlPZDmk1PbwOm5nf2nKftCZkOO
	/F4KGCkn1GpW0a4R1NlmVAXKOW5qVsMtEWLp5yak3gfRMFmvtpTC/AYIFKCaZ7bxy0xZo9
	CbrNM6Wvi20lodocSUVrUKa5d+pV2rDPqqKmFj4d+zqQLuSQ/FDMYVBfBz89DqnVLxl15Q
	0NVopbCEC6GHl8iC67Hqbm6IAmMfE9T9f0OOsX+jLyv7REpl92PZUVXBlY3dZmfUCRM2wb
	bidhjfz1ushjVp4K5n149OwU8lC4ifpZSLaYYcwjey2krA2YugU6d8/4Fqup+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775112616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDBfbYuR0sezk33n0Yqae9MBxFSwAVgx4KMwokcLh6A=;
	b=W7g8stzGrvulluDjwbmX3xfvDNyoMni7V6Ij1ktbduZ32FAKIOlXqM3PhwnA2LUW0aQGWG
	slWCHe+To0WpNHBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-rt-devel@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] irq_work: Fix use-after-free in irq_work_single on
 PREEMPT_RT
Message-ID: <20260402065015.JKszGSXu@linutronix.de>
References: <20260330073234.303732-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260330073234.303732-1-jiayuan.chen@linux.dev>

On 2026-03-30 15:32:29 [+0800], Jiayuan Chen wrote:
> On PREEMPT_RT, non-HARD irq_work runs in per-CPU kthreads via
> run_irq_workd(), so irq_work_sync() uses rcuwait to wait for
> BUSY=3D=3D0.
>=20
> After irq_work_single() clears BUSY via atomic_cmpxchg(), it still
> dereferences @work for irq_work_is_hard() and rcuwait_wake_up().
> An irq_work_sync() caller on another CPU that enters after BUSY is
> cleared can observe BUSY=3D=3D0 immediately, return, and free the work
> before those accesses complete =E2=80=94 causing a use-after-free.
>=20
> Fix this by wrapping run_irq_workd() in guard(rcu)() so that the
> entire irq_work_single() execution is within an RCU read-side
> critical section. Then add synchronize_rcu() in irq_work_sync()
> after rcuwait_wait_event() to ensure the caller waits for the RCU
> grace period before returning, preventing premature frees.
>=20
> Fixes: 810979682ccc ("irq_work: Allow irq_work_sync() to sleep if irq_wor=
k() no IRQ support.")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
