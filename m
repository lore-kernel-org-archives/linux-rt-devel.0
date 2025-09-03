Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFD1547C9;
	Wed,  3 Sep 2025 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924711; cv=none; b=WyocOiIFx2jstJeGNDP//t+6twIcElhBvIOC8jabDdllf/7+FeYctKwGhL16Evem2MhtW4IkBMFQwK3Xakwhw3TVKXysXDSmmVF/Bilwm/zf7sQZ5qL30XVAfwx+pnbGaGNFeF2TZa4Ts5hroRFgdx+xpgyzlqY/ZHstkTR0btM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924711; c=relaxed/simple;
	bh=hT/13VpZ1L33ft/+Oneh5aL8bCF1WIaI1EMCHmI0p94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV4XJ9QpCAB+lgayW9dHqLypGW26MOpf1TR5mugQQcspYLRU30bPG7bu2MSbu+fQ13n08ZTw6jcPaEN/xQ/vIDejWEOGaVQELMwmKBRiisri5zzD1pya3wTP1434udZ5j+fuBHSlRoUzwvPcWZXgbU3IKx11tteYhqf/sLU17n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXPwPwgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXPwPwgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03892C4CEE7;
	Wed,  3 Sep 2025 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756924711;
	bh=hT/13VpZ1L33ft/+Oneh5aL8bCF1WIaI1EMCHmI0p94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXPwPwgRPwoDsevudNAw0+zxbSTtBcZDgVe4ZrEVAaHKrSgQ9jy3dkRfD6Nm7wUfs
	 yzgCdEGlTWrwzx1c6+ALCQ/bBaUAkRziE+p8+y9UJtIgS5xoZCnXHeDOZJ0E6bEM10
	 J4VjH5xqsNx2d+GzAJGn5Yhh7vlWYGn7lMQLycYkrHxXAwffXrdiGHncPlmA1jFnnR
	 yueCyjbtrtkvxDwHk7ziDWzchl+62DrvrDkThaD2LzqOILlygElR61utO2TNC5DFQl
	 et+TdXoFK1nEABTETMEO57LU0OLPKerWlc2ymXTS2K3YGU/mE8Zk/XGjJJitDU1Gdn
	 52fDBeGqKvBYw==
Date: Wed, 3 Sep 2025 08:38:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH
 workers
Message-ID: <aLiLJh4n80iKWzRe@slm.duckdns.org>
References: <20250901163811.963326-1-bigeasy@linutronix.de>
 <20250901163811.963326-2-bigeasy@linutronix.de>
 <CAJhGHyDrKzG2n77UXh4WBhufFK+crjoHbYUdQ40TGvDcDXugOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyDrKzG2n77UXh4WBhufFK+crjoHbYUdQ40TGvDcDXugOQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 03:30:08PM +0800, Lai Jiangshan wrote:
> On Tue, Sep 2, 2025 at 12:38 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> 
> > @@ -4222,17 +4251,18 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
> >                     (data & WORK_OFFQ_BH)) {
> >                         /*
> >                          * On RT, prevent a live lock when %current preempted
> > -                        * soft interrupt processing or prevents ksoftirqd from
> > -                        * running by keeping flipping BH. If the BH work item
> > -                        * runs on a different CPU then this has no effect other
> > -                        * than doing the BH disable/enable dance for nothing.
> > -                        * This is copied from
> > -                        * kernel/softirq.c::tasklet_unlock_spin_wait().
> > +                        * soft interrupt processing by blocking on lock which
> > +                        * is owned by the thread invoking the callback.
> >                          */
> >                         while (!try_wait_for_completion(&barr.done)) {
> >                                 if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > -                                       local_bh_disable();
> > -                                       local_bh_enable();
> > +                                       struct worker_pool *pool;
> > +
> > +                                       mutex_lock(&wq_pool_mutex);
> > +                                       pool = get_work_pool(work);
> > +                                       if (pool)
> > +                                               workqueue_callback_cancel_wait_running(pool);
> > +                                       mutex_unlock(&wq_pool_mutex);
> 
> The goal is to avoid using a potentially sleeping function in
> __flush_work() for BH work items on PREEMPT_RT, but
> mutex_lock(&wq_pool_mutex) is not appropriate in this context.
> 
> To obtain the pool of a work item, the preferred approach is to use
> rcu_read_lock() together with get_work_pool(work), as is done in
> start_flush_work().

Yeah, Sebastian, can you please switch it to rcu_read_lock()?

Thanks.

-- 
tejun
