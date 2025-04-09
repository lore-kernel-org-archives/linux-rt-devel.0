Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DC14AD2D;
	Wed,  9 Apr 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216707; cv=none; b=aeCTJhzMmGVoHQQLp+XWncrXQAaHVKizWFZme4hIRHYIno9khniY98ENlzRP4X0XB1tipZ7A9yhhTtWpAcN7H+yQOIpo6SL6UMJpz3CnkGCvOQm/0ePfxWhWHRrYA90BvivpAjZDdNj9lsReWBXUZEsCzg5QPGPvc1AlazDf3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216707; c=relaxed/simple;
	bh=mJJ3jrXOq40V64NQbjm20IbqWTdRe6qQOlZGmqjPO40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFX+89ZakTSubNM3RYhd0NpivlfNVATgPxxYwwZcISb+UbfAx0bK1i09WLNkJ5nx3UIq0J0FQdpCG7ElZspBS/kuvUNKxMsRlxsXutZ96Wo1xMPKpYAr81BvqySchSFXTrTI/ZMRo9Gvp5yo8jfbdRsQzSsVpGRYU3UGXLkKVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427C5C4CEE2;
	Wed,  9 Apr 2025 16:38:25 +0000 (UTC)
Date: Wed, 9 Apr 2025 12:39:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Tejun Heo <tj@kernel.org>, David Vernet
 <dvernet@meta.com>, Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Juri Lelli
 <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250409123944.15df8714@gandalf.local.home>
In-Reply-To: <Z_af4PF18ocF0bBW@uudg.org>
References: <Z_W-i-ya0Q6fkXRh@uudg.org>
	<20250409114330.1444221e@gandalf.local.home>
	<Z_af4PF18ocF0bBW@uudg.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 13:27:12 -0300
"Luis Claudio R. Goncalves" <lgoncalv@redhat.com> wrote:

> > > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> > > +#ifdef CONFIG_PREEMPT_RT
> > > +	if (!preemptible() || current->pi_blocked_on)
> > > +		defer = true;
> > > +#endif  
> > 
> > Why add the ugly #ifdef back?
> > 
> > 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> > 	    (preemptible() && !current->pi_blocked_on)) {  
> 
> I had to add the #ifdef to avoid the build failing if CONFIG_RT_MUTEXES is
> not set. I do know SMP, FUTEX, I2C, PSTORE and a few more things depend on
> CONFIG_RT_MUTEXES being enabled, but I opted for being thorough.
> 
> I would be more than glad getting rid of the #ifdef and simplifying the patch
> if that possible build failure is not a case to worry about, if RT_MUTEXES are
> always enabled nowadays.
> 

Because pi_blocked_on is only defined when CONFIG_RT_MUTEXES is enabled?

OK, then perhaps we should add in sched.h:

#ifdef CONFIG_RT_MUTEXES
static inline bool tsk_is_pi_blocked_on(struct task_struct *tsk)
{
	return tsk->pi_blocked_on != NULL;
}
#else
static inline bool tsk_is_pi_blocked_on(strut task_struct *tsk)
{
	return false;
}
#endif

??

-- Steve
