Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F22274FE3
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 Aug 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325459; cv=none; b=c3JqhCvVK5O8FKQXtNKt3Yw/c2vRHUchzCIT3AesSCTrC6PEksYNS9mkH5zWOD7bm34i72zAVVBEVkKiWqpltQLtLBHeSjp1uq4mTnOnzihHza/49R1hpYw6IA9cWlZ6rOnqMC5bP9HSgTvuDnIFfvn8q+mVzhg9HIVd9MXyz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325459; c=relaxed/simple;
	bh=eQ1B7fWck2plFM9ie7viO3hgpQX6fKWsnWwoHvKUBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIMYVYvTdBCLI34lHdMJ+HszaOsfh6n59MPlhm/Ms4LCXLugvSRDNJ3WebTYbIHYZO9866+BVbSjIgQ7n1kThisQYieUkzqodpEeLiR0Yc+/uoVM87KQFmKUDZWdz/Fpogt/hatLaew/H/Y7fPM4qLMvnjn2iNvdXiI07v2hoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B0C4A16081E;
	Mon,  4 Aug 2025 16:37:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 694EE22;
	Mon,  4 Aug 2025 16:37:28 +0000 (UTC)
Date: Mon, 4 Aug 2025 12:37:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com, Yeoreum
 Yun <yeoreum.yun@arm.com>, ppbuk5246@gmail.com, linux-usb@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, syzkaller@googlegroups.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] kcov: Replace per-CPU local_lock with
 local_irq_save/restore
Message-ID: <20250804123756.7678cb3d@gandalf.local.home>
In-Reply-To: <20250803072044.572733-6-ysk@kzalloc.com>
References: <20250803072044.572733-2-ysk@kzalloc.com>
	<20250803072044.572733-6-ysk@kzalloc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 694EE22
X-Stat-Signature: gbwrjeowoyigsjc9wictbdrsxum6r8iy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/uQhOn1Fyqq2fpyzlrwEHVWYt5vTqRb7E=
X-HE-Tag: 1754325448-434064
X-HE-Meta: U2FsdGVkX1/mgT4nDHb3f7o/1ybC4xqUbhxzTP2su8vp+fivYgvjjOAYcFSuPpP3LB8ZeobyzjYoJvlb27F5buAymcjmspNzhskohp+GPlzRAoHT3Elce59c3sw4R+EitYmKmfYtJgXp6YXgXv1cS9pp3BTO5wexULUuB2twEit/Atiodkgzt1KXNazZWo2pqbtKpKdKMHFaZ7h0YeyxKCNfmSpbCRsc/6Pfjld0tmonws5hJkmPk7mQo6PHT4g1XTrzYXVyqzaQZtecMntogQM/DC1pJnQKk86CwW3BUu5hQHUOJCjEfA5EA/xApCgw8keBiHthkpXtfBuYLFNRoyKogOYHNEgae+L4sLfwuaZseaxL/hvjJAlmjEKbjQv8

On Sun,  3 Aug 2025 07:20:45 +0000
Yunseong Kim <ysk@kzalloc.com> wrote:

> Commit f85d39dd7ed8 ("kcov, usb: disable interrupts in
> kcov_remote_start_usb_softirq") introduced a local_irq_save() in the
> kcov_remote_start_usb_softirq() wrapper, placing kcov_remote_start() in
> atomic context.
> 
> The previous patch addressed this by converting the global

Don't ever use the phrase "The previous patch" in a change log. These get
added to git and it's very hard to find any order of one patch to another.
When doing a git blame 5 years from now, "The previous patch" will be
meaningless.

> kcov_remote_lock to a non-sleeping raw_spinlock_t. However, per-CPU
> data in kcov_remote_start() and kcov_remote_stop() remains protected
> by kcov_percpu_data.lock, which is a local_lock_t.

Instead, you should say something like:

  As kcov_remote_start() is now in atomic context, the kcov_remote lock was
  converted to a non-sleeping raw_spinlock. However, per-cpu ...


> 
> On PREEMPT_RT kernels, local_lock_t is implemented as a sleeping lock.
> Acquiring it from atomic context triggers warnings or crashes due to
> invalid sleeping behavior.
> 
> The original use of local_lock_t assumed that kcov_remote_start() would
> never be called in atomic context. Now that this assumption no longer
> holds, replace it with local_irq_save() and local_irq_restore(), which are
> safe in all contexts and compatible with the use of raw_spinlock_t.

Hmm, if the local_lock_t() is called inside of the taking of the
raw_spinlock_t, then this patch should probably be first. Why introduce a
different bug when fixing another one?

Then the change log of this and the previous patch can both just mention
being called from atomic context.

This change log would probably then say, "in order to convert the kcov locks
to raw_spinlocks, the local_lock_irqsave()s need to be converted over to
local_irq_save()".

-- Steve

> 
> With this change, both global and per-CPU synchronization primitives are
> guaranteed to be non-sleeping, making kcov_remote_start() safe for
> use in atomic contexts.
> 
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> ---
