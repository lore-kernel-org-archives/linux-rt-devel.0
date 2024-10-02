Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680D1D0953
	for <linux-rt-devel@lists.linux.dev>; Wed,  2 Oct 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883305; cv=none; b=ciBeglfsGcD90xhr8OT/OA7X2DNs77GzUBc4ZZPvSTCiNtC5+VYxSt0SuYtclOpWSGYoLYcMmdIoTxofxTodMRkexzYmBOTNx6J2PpzGzmC0bfed0eFvquiiDrB7aoN5G0RVFMqOWBSeiq3cIT5L+IxwkO2ZkSfoSGSQc/g1CrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883305; c=relaxed/simple;
	bh=uRPjqD1nw+yiBwuNbQlSFBXVhqoV/XZb/xEt1s/tads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mnd+EDqP1ejH2uwmo6XZrBmjEwDXm9IJWPP396HKaY3/J01aYmggtzJIxo5QSS1fIAm8Y8lh1ZtIiuooVURcBNCAtPnCKjw2FuO5YDYt91U9fEOms2i8e/cf5NL8RQKkvWMFiBGbSOWsy7g5XCrcUFwzp8s+dDCbbK+2sZ6nXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvR0rCyK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oBVw7gKR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvR0rCyK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oBVw7gKR"
Date: Wed, 2 Oct 2024 17:35:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRPjqD1nw+yiBwuNbQlSFBXVhqoV/XZb/xEt1s/tads=;
	b=hvR0rCyKglndYoykC1whh5Sk5yQCYPonAPDAvqPUNU++neNDye3Ber5R++NVx9SDZFoOeX
	A1s+7r4hoYaF6eqzpsyTHGF6MHWUMy9FcHXLL6FSdVvD7xo82aqv0QKRmTHDbqV2JWWgRI
	iuaXCJO4tPYfqke4IONDz/0fRwkOdjh0whojktSEKQKG3yaD8StoRLa2oxj/+FKtbnkcMq
	Hz5ItYGF8T8d6MZJNnX+cShA1ynexrn1izS9vZu8vVPR4hIy4hSO50ioeMD29Dnt2oCdRF
	iCUT3B1BGY7uKSOkYNNmvBjFqWmjRXfC/emt6qcofWPWW/jg6j28305h6KGUdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRPjqD1nw+yiBwuNbQlSFBXVhqoV/XZb/xEt1s/tads=;
	b=oBVw7gKRD1IZiUFttzX3zaRu+BzZxXbMPGCNzAnJRxwL6NQN3A0GbIkrOkUF1NEZtdyxR/
	n4wLdXJuDcp3ldAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Repeated rto_push_irq_work_func() invocation.
Message-ID: <20241002153500.UVq2Zn-J@linutronix.de>
References: <20241002112105.LCvHpHN1@linutronix.de>
 <20241002103749.14d713c1@gandalf.local.home>
 <20241002150543.IhYy2Q9k@linutronix.de>
 <20241002111920.12cdc78e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241002111920.12cdc78e@gandalf.local.home>

On 2024-10-02 11:19:20 [-0400], Steven Rostedt wrote:
> > +rcu_read_lock() but yes. This would be one part. You need to check if
>=20
> Yeah, preempt_disable() is pretty much equivalent today to rcu_read_lock(=
),
> as synchronize_rcu() and synchronize_sched() have been merged into one.

I know but=E2=80=A6

> > the task on pull-list has lower priority than the current task on rq.
> > This would be need to be moved to somewhere in schedule() probably after
> > pick_next_task().
>=20
> Does it matter? The target CPU has NEED_RESCHED set, which should handle
> the pushing logic anyway, right?

I am not sure. The task can only be added with the rq and push-list with
rq-lock held then schedule() should see it by the time it picks the task
with the highest priority. But part of what needs to be done as of
rto_push_irq_work_func()/ push_rt_task() is to push tasks with lower
priority to another CPU. This isn't the case as far as I understand the
code.
This looks expensive to be performed in schedule() but then it is also
done via the IPI. On the plus side, after the RT has been made curr it
is removed from the list. So this could be already used as a hint if
this needs to be done or not.=20

> Hmm, I probably should look deeper to make sure that anytime a schedule
> happens where there's overloaded RT tasks, it tries to push.

I think it tried pull on schedule but then it got outsourced to push via
the IPI with this new code. Don't remember the details=20

> -- Steve

Sebastian
