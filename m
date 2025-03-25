Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528019CC27;
	Tue, 25 Mar 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895780; cv=none; b=oamQ6A5kI0dnrtrXIzG1vfTyXskO/yiEZa8EGdnN3de+Hg2xOy75HIc5qRdLoG9sUD6//9d67qKwucZjHHHTQ15iSUuLZPej4l7BpbXRkli5+hrn1IClr/uKZblLeVIaNdEZtUAxdiOSaPG6LDVgd+YFcn7Uc3YSMFnQjxZ8T1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895780; c=relaxed/simple;
	bh=Oiv8Av9xGB7EJoTp+udHsn8EcJRvAaBHEIhgkS3L1mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU3fyN0tCEY1e29QOzBBftVESjRWO3DZUxvurKjvHfNZMtca96dXsPOG+uPyL3/RDTe5pg8oahqz3Q4N+CBPzcMn4dtJBkeLDRwX4ls4KImjQwCvDDwvkawmF+FQ4Ax6vkjJATeiAlu17nAcn/kEhrtPKyAw/Et+nKpCMvmmIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwpHC4pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwpHC4pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3141C4CEE4;
	Tue, 25 Mar 2025 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742895778;
	bh=Oiv8Av9xGB7EJoTp+udHsn8EcJRvAaBHEIhgkS3L1mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwpHC4pf7aWNIhGxdSuYa3gt+J7lLM7DhBA/AhvGM2XK7H0Ow8cFaTPKxVsfSmZDX
	 iIOJ/Ih2EuPcV3H2NxModzu+fn0f9fu+RpFmSYfokSTeHarXedBzlwGvEUukkXzF+9
	 1DqbHwOHkpCuKxEzCThHqfNGMLidirWPb6Cu4YNJbm740x44RNJP79kti92/N/Ehmc
	 2Z/+bGoNp+aQtb8R9C7LHchmdQz7PnGPCMQ92quqF94+mANscYdjZyAmR/G3GAYzY1
	 K1XV69SVQXZbO4qCx+Q/o8EdeV8U4hPMrDeSzf+S6MpXIU+x/zBS0WpjhxFl6hnbaj
	 5fP+fdLVuXZ8w==
Date: Tue, 25 Mar 2025 10:42:36 +0100
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
Message-ID: <Z-J6jE0lHJpWA20l@gmail.com>
References: <20250321143322.79651-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321143322.79651-1-boqun.feng@gmail.com>


* Boqun Feng <boqun.feng@gmail.com> wrote:

> Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
> PREEMPT_RT."), the wait context test for mutex usage within
> "in softirq context" fails as it references @softirq_context.
> 
> [    0.184549]   | wait context tests |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184549]                                  | rcu  | raw  | spin |mutex |
> [    0.184549]   --------------------------------------------------------------------------
> [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
> [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
> [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
> 
> As a fix, add lockdep map for BH disabled section. This fixes the
> issue by letting us catch cases when local_bh_disable() gets called
> with preemption disabled where local_lock doesn't get acquired.
> In the case of "in softirq context" selftest, local_bh_disable() was
> being called with preemption disable as it's early in the boot.
> 
> [boqun: Move the lockdep annotations into __local_bh_*() to avoid false
> positives because of unpaired local_bh_disable() reported by Borislav
> Petkov [1] and Peter Zijlstra [2], and make bh_lock_map only exist for
> PREEMPT_RT]
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/ [1]
> Link: https://lore.kernel.org/lkml/20250307113955.GK16878@noisy.programming.kicks-ass.net/ [2]
> Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com

That's a weird SOB chain. Following back the history of the submission 
I believe this line went missing:

  From: Ryo Takakura <ryotkkr98@gmail.com>

I added it back in to the commit.

Thanks,

	Ingo
