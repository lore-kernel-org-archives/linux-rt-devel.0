Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1081FF5FC;
	Tue, 25 Mar 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940221; cv=none; b=TGaS0FzsWAvcxNRNPOsut9BIAuEw4xih6FKkmfTa49lzUqvENJ+OJECwDlydvr7TSzWEV+wrSz4Thp36nQ30U0X5qATPMognVg5+6tsUhlotsTq0sjXs2xUEYS1E83zeiL0iyygvUTN6nb9KOj1tVnfcxwluCPjSS5iDzCYL89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940221; c=relaxed/simple;
	bh=r4FrZ3kQRtogOz5YRrI0Y7RwoXdZXIEq6GXFizuIs5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK2yaj4cXdL15QKe11bs0PYzpsz8Vd96F2pPAhqfqIiks0lVYhoEIjIeqE0C4qO0YYN7qLVu4c4ApJV1lSX+hti6/uK5cYfFKcyaz/8A+LzHro0l7bCV452msmLswjQ6jDZIWmfPe4dWT6F5iec8WucRnMrvkhaGI4C2vP3rI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtwEBROz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtwEBROz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8334C4CEE9;
	Tue, 25 Mar 2025 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742940221;
	bh=r4FrZ3kQRtogOz5YRrI0Y7RwoXdZXIEq6GXFizuIs5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtwEBROz1sVZ4zPjLlon/FtAMGwhCVzqKiknXc6JE3JQCPwPnnJDcM94RhFu2Fw1V
	 Ie+pikQW5ibhnh/d6rkDkJZhxSxwj7QTizo+8ZZBGR/PRaK/rQqi+eZFcVqjTW5WZw
	 wrXiZUqBwjsW3G0FQc9Q6GfVK5esB7hNfrSQnTZJFbPq0y/Ax8Ry5a4aR8AvxCLISA
	 y+0ex+Hw1IcoPCwEfnvy4MbzmeVcyR5E4F2j+VpORHmpNLrQDwErhFTxurLBU17Jrp
	 nozmUFyF6A1DbFXxwqsoQY5j2l7/CESYqVruKX7/kEJNJxyWZAJhB3WO6cZeNzJk5u
	 M6x96mkwVM02g==
Date: Tue, 25 Mar 2025 23:03:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Ryo Takakura <ryotkkr98@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] lockdep: Fix wait context check on softirq for
 PREEMPT_RT
Message-ID: <Z-MoNvnFOQmST8f3@gmail.com>
References: <20250321143322.79651-1-boqun.feng@gmail.com>
 <Z-J6jE0lHJpWA20l@gmail.com>
 <Z-L2Km8nHE7Eevis@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-L2Km8nHE7Eevis@boqun-archlinux>


* Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Mar 25, 2025 at 10:42:36AM +0100, Ingo Molnar wrote:
> > 
> > * Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > > Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> > > PREEMPT_RT."), the wait context test for mutex usage within
> > > "in softirq context" fails as it references @softirq_context.
> > > 
> > > [    0.184549]   | wait context tests |
> > > [    0.184549]   --------------------------------------------------------------------------
> > > [    0.184549]                                  | rcu  | raw  | spin |mutex |
> > > [    0.184549]   --------------------------------------------------------------------------
> > > [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> > > [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> > > [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> > > 
> > > As a fix, add lockdep map for BH disabled section. This fixes the
> > > issue by letting us catch cases when local_bh_disable() gets called
> > > with preemption disabled where local_lock doesn't get acquired.
> > > In the case of "in softirq context" selftest, local_bh_disable() was
> > > being called with preemption disable as it's early in the boot.
> > > 
> > > [boqun: Move the lockdep annotations into __local_bh_*() to avoid false
> > > positives because of unpaired local_bh_disable() reported by Borislav
> > > Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
> > > PREEMPT_RT]
> > > 
> > > Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
> > > Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
> > > Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com
> > 
> > That's a weird SOB chain. Following back the history of the submission 
> > I believe this line went missing:
> > 
> >   From: Ryo Takakura <ryotkkr98@gmail.com>
> > 
> > I added it back in to the commit.
> > 
> 
> Thanks! Looks like I lost the "From:" field when I post the draft of v4
> at:
> 
> 	https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/
> 
> I must re-apply that email as a patch to my branch, hence the "From:"
> field got changed. Sorry for the mistakes.

No worries - sometimes when rebasing with a conflict or applying with a 
conflict, Git can drop authorship without much of a warning - I've ran 
into that myself - so it happens.

Thanks,

	Ingo
