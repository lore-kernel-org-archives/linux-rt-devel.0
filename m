Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAE534478
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169702; cv=none; b=mKMQ7xXrb0VAwOyJJV8Idm2lFKSfO7UgdxWpel74xClP0I+nkRCTLP6Z7XVogyTCu1/SJ3XUZeLlSURseL7cqIPOGiiqhz/o92MDYT8KOQ2fhyhDECrOalzeSmT2GQFY340UT/vzB5Oe32OVmUshzeYnsx6cAoZhk1+LyV9C4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169702; c=relaxed/simple;
	bh=pezFwcfFZeafxOv+cBj8kAUagRQFpIO1YRl5z9coiNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVwNW/Fo4VukwzK2d8JUW8/AZoirvsb4AY0n3bErrXHP1KAXXkSF5T0QZFzxPewMpG2NKfcHoZatSy6c68swIghmwzbcO2J143f/+VR3rBwwym47VMfgouoVgGcz72WwKkU+W/eORTUH2/re0tCwWT7RXSQ/ODdTy7o4f6pZxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=xAOsX50d; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="xAOsX50d"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DAAED1C3D20;
	Fri, 16 Oct 2026 16:54:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 371736000F;
	Fri, 16 Oct 2026 16:54:55 +0000 (UTC)
Date: Fri, 16 Oct 2026 12:54:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Possible enhancement to RCU CPU stall warning messages
Message-ID: <20261016125453.36ae8efe@gandalf.local.home>
In-Reply-To: <d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
References: <a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop>
	<20261016112339.6d6ac80a@gandalf.local.home>
	<7aac27b4-b323-436b-95a4-25c676f6f934@paulmck-laptop>
	<20261016121753.0da4e4e1@gandalf.local.home>
	<d475217c-f42e-4f92-877b-74310c50b66c@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8updmuhzcbfpbsrx3p359a93rgm355pq
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 371736000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Bde7pdpTYXYzXs9f/VDhgJIyDA4rKX6A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=uMb40HfyWkjHU1zElkpck1tYxNoh8n6WvMkNwJrN6cQ=; b=xAOsX50dy7E18RcWmdt+jRsOl1/mE0yeMrb2YZfxaXjkfHGABOcS6HkmT9eutwQe1j/sJ3Azx0BMpYCdTwt3FHpmSDmCU2vaqF61IvLiUh94b93j7XFm0QO6pcPmTBTBfq5mLpzTgQkjk+HhqWlTvXsbSZ1YqvtCb6IeHHLRx9o=
X-HE-Tag: 1792169695-421132
X-HE-Meta: U2FsdGVkX19EDNf2YvsxXEY+az25AbFCHg+xHNksNVYjvcEg2EKAolriZcwS7GVC5bx8KPD8P/ITw9499i6QEkJdtUaBJpx4FCl0xhQopj8L5YKu3BP5Gh32pg/shmErqmjOR81V0jFfs8UIDK6IDjruknkUd3s3vbqnfRpl9goIEtYlgogjj6oDNuHPzg1JqALtT8AAYFPD7Ikk6ePAGk5e8AbSDNA0hl0kDd0I2qLh+0nzrann1yFVt35KdLeH6A8hSgQzkDbE54l6O2/SFyg3lofYLD9NeUhhOpMY9PQmMgio0veU8390jIxGoQNEf0JKVrljtWySQ7UgerEBkYwULOMezhms

On Fri, 16 Oct 2026 09:48:12 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> ------------------------------------------------------------------------
> 
> static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
> 	__releases(rnp->lock)
> {
> 	int i = 0;
> 	int ndetected = 0;
> 	struct rcu_stall_chk_rdr rscr;
> 	struct task_struct *t;
> 	struct task_struct *tc;
> 	struct task_struct *ts[8];
> 
> 	lockdep_assert_irqs_disabled();
> 	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
> 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 		return 0;
> 	}
> 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
> 	       rnp->level, rnp->grplo, rnp->grphi);
> 	t = list_entry(rnp->gp_tasks->prev,
> 		       struct task_struct, rcu_node_entry);
> 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
> 		get_task_struct(t);

This gets the ts[i]

> 		ts[i++] = t;
> 		if (i >= ARRAY_SIZE(ts))
> 			break;
> 	}
> 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 	while (i) {
> 		t = ts[--i];
> 		if (task_call_func(t, check_slow_task, &rscr)) {
> 			pr_cont(" P%d", t->pid);
> 		} else {
> 			tc = rscr.rcu_rdr_cpu_task;

But what gets the tc?

> 			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
> 				t->pid, rscr.nesting,
> 				".b"[rscr.rs.b.blocked],
> 				".q"[rscr.rs.b.need_qs],
> 				".e"[rscr.rs.b.exp_hint],
> 				".l"[rscr.on_blkd_list],
> 				".R"[rscr.rcu_rdr_running],
> 				".B?"[rscr.rcu_rdr_boosted],
> 				rscr.rcu_rdr_cpu,
> 				rscr.rcu_rdr_cpu_offline ? "!" : "",
> 				tc ? tc->comm : "???",
> 				tc ? tc->pid : -1,
> 				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");

Here tc is dereferenced.

> 		}
> 		lockdep_assert_irqs_disabled();
> 		put_task_struct(t);

There's a put_task_struct(t), but I don't see a put_task_struct(tc) :-/

-- Steve

> 		ndetected++;
> 	}
> 	pr_cont("\n");
> 	return ndetected;
> }
> 
> ------------------------------------------------------------------------
> 
> The ts[] array keeps track of up to eight tasks, the number indicated
> by local variable "i", and the list_for_each_entry_continue() has
> done get_task_struct() on each of those tasks.  Then the "while" loop
> iterates over those tasks, printing each one and then doing the matching
> put_task_struct().
> 
> Does that work, or am I missing something subtle?

