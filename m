Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315C3451D2
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597657; cv=none; b=oThOviToYrP9KFULC4vV15fKDU19XfaqjOXNX7+NIh7s44+0VTq05jbi+JWiMvJYnD1LWxrVEPElyLXbWPHGz2P8MaJaYj1KY/xY1CmU4bNJsJ2llel4FuNEf1ZqHmEIuiGNYRyZdBZZgg+TG01CbLsxDNCQobb263MU17b0mt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597657; c=relaxed/simple;
	bh=tKG385zLApPrmYgg1y212g0XqqpZbgwznZlmTUIjBa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un3g8WmezHjFZzv6fQKLMufXtZkRze1PsUErt+b0f4bOUqtoGMSqTqNZ/B5rMNqzWVO02jvHEfh8bUp817RjkNxIPOOY0MMeCWbudnbbbwOdc0NJgQVOJk8pZAEqpZ9Eu5J6KppXMXoCHFBKKkRourfDDkvqV0zLTEZ0GTZKatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lc3hCAm9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2brXP8Ck; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lc3hCAm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2brXP8Ck"
Date: Tue, 19 Aug 2025 12:00:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755597648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJl/XWMsycTjvYGQzFnWsmROTTphBuImum1tAc0aB1k=;
	b=Lc3hCAm9QqnZszBsyc+HllW9WeRXJc379CQY5oGagFF2UjqaipMjFDJVrQtKfh9+2YGb7Z
	F8LNVOjResyLPlQy3oP00fajmsBIt0laBcPhQywELgUxi/ExW4aGLzuU1QmGcmE4QP0EFX
	OPFsmEvt4snxihzsgUlredp6QoBwcgl8VD3/WGUHIDceMwbYsnu8ldyGQzrgulw4dEwuBI
	JR4Xs78+DN0SLgqDBtTyB4ho9O5ytVBfA5HXIvFV4+7VWHkeGe+mVPiOMoD1RcV6EU6Qqr
	zQawW4/DDYwPSrxjtArh6AnpbHf+QN/0G+B9hkCR8Yq/weZscC3sMbA/rnfTAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755597648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJl/XWMsycTjvYGQzFnWsmROTTphBuImum1tAc0aB1k=;
	b=2brXP8Cknm/wTMNegAihVLlosxexHrtSPaxbeJlUrMga5JiAS/v1ERSmtE1vOYLJlp5OsZ
	R1BRaBlpgfllzTAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: locking: Add
 local_lock_nested_bh() to locktypes
Message-ID: <20250819100046.ymb_o7VA@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-3-bigeasy@linutronix.de>
 <db8defe4-14bf-4060-803f-e8b09a941d42@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db8defe4-14bf-4060-803f-e8b09a941d42@redhat.com>

On 2025-08-18 14:06:39 [-0400], Waiman Long wrote:
> > index 80c914f6eae7a..37b6a5670c2fa 100644
> > --- a/Documentation/locking/locktypes.rst
> > +++ b/Documentation/locking/locktypes.rst
> > @@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
> >   local_lock is not suitable to protect against preemption or interrupts on a
> >   PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
> > +CPU local scope and bottom-half
> > +-------------------------------
> > +
> > +Per-CPU variables that are accessed only in softirq context should not rely on
> > +the assumption that this context is implicitly protected due to being
> > +non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, and
> > +synchronizing every bottom-half-disabled section via implicit context results
> > +in an implicit per-CPU "big kernel lock."
> > +
> > +A local_lock_t together with local_lock_nested_bh() and
> > +local_unlock_nested_bh() for locking operations help to identify the locking
> > +scope.
> > +
> > +When lockdep is enabled, these functions verify that data structure access
> > +occurs within softirq context.
> > +Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
> > +does not add overhead when used without lockdep.
> 
> Should it be local_lock_nested_bh()? It doesn't make sense to compare
> local_unlock_nested_bh() against local_lock(). In a PREEMPT_RT kernel,
> local_lock() disables migration but not preemption.

Yes, it should have been the lock and not the unlock part. I mention
just preemption part here because it focuses on the !RT part compared to
local_lock() and that it adds no overhead.
The PREEMPT_RT part below mentions that it behaves as a real lock so
that should be enough (not to mention the migration part (technically
migration must be already disabled so we could omit disabling migration
here but it is just a counter increment/ decrement at this point so we
don't win much by doing so)).

I made the following:

@@ -219,11 +219,11 @@ scope.
 
 When lockdep is enabled, these functions verify that data structure access
 occurs within softirq context.
-Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
+Unlike local_lock(), local_lock_nested_bh() does not disable preemption and
 does not add overhead when used without lockdep.
 
 On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
-local_unlock_nested_bh() serializes access to the data structure, which allows
+local_lock_nested_bh() serializes access to the data structure, which allows
 removal of serialization via local_bh_disable().
 
 raw_spinlock_t and spinlock_t

Good?

> Cheers,
> Longman
> 
> > +
> > +On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
> > +local_unlock_nested_bh() serializes access to the data structure, which allows
> > +removal of serialization via local_bh_disable().
> >   raw_spinlock_t and spinlock_t
> >   =============================

Sebastian
