Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF2391E44;
	Mon, 14 Sep 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370787; cv=none; b=c3YjJZABF8Tjc1MpLNAcBmbd7qD16BtGbzevhRsOcoBhFS3oEeA74mUDf055NB7ve1QIz0SxH+ufLDNgcURqvDmadSzblMORjitz6f79fITV3U1KHTCZL/EwoY9fnn0/f6TD+jguD145X97qnC2xLpxiZREK57EL2WfhdrGT95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370787; c=relaxed/simple;
	bh=bsGdOl8K2QiBGwmi0g97VKjbfovbw4P1wi4hex5y5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtiPLODG6KiGagRYmmwxr4yb76Oq7JY8cGDvyu7rNPNGeFP0f/jqGFQuwTKTS+0vVOx2S+Eug8gSaOcDHi2MKmQQNJdM3P3x6Ln5K0XP0lam01FrZyAOUz77hQaOtdhr0UHtfNYs55sArNPhXBC+j7XGlHrkAwecDEN6UFMeaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFsiPCfE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5D6IopvA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFsiPCfE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5D6IopvA"
Date: Mon, 14 Sep 2026 09:26:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789370784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OGq4S9EEK8muizX5eTxulaDRgKnEZhBbib2tr3gCzU=;
	b=CFsiPCfEGeF9XmgZTJSqe3Jwic/36JU0ej18ZLHmQ18tpFr6Jr0amoTVaRn0cwkScQxUIu
	vKaPYVVn2f/hDyMhx3Mnt2jfr4qmNaQzTId3gO/qP8h26cBpY/kFjcfQS0l9CbJ1UZJ1CQ
	rQ53qdFLGGJ8HYQ9jU+M4Iq8xRy2TM0XwpLJBGWbl9d8qvTQklXCjY55k4QNUuM5Ng1bfk
	jrlsVKySyBLJlll/gCqJBjtzuT32YqNkD4q9M/Rnv80PFaYEhIbeH7j5wBN0njq6nZoPWz
	GeJdc1SVPnmg7Y0U+bjv8P5kAbFJ6VoMx05ls7juU9jNScrkmjSMT2TACvqaRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789370784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OGq4S9EEK8muizX5eTxulaDRgKnEZhBbib2tr3gCzU=;
	b=5D6IopvArs8zmcCStQuzr9aNjiioa49aHbktkrBKbof0She2ufNE0CNkm/tAKB1wFapvzE
	WqfLrpYFSQjTnlCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] irq_work: Flush lazy work CPU down on PREEMPT_RT
Message-ID: <20260914072623.OegMPpLL@linutronix.de>
References: <20260911143815.997254-1-bigeasy@linutronix.de>
 <20260911143815.997254-3-bigeasy@linutronix.de>
 <20260911145555.8BE8C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911145555.8BE8C1F000FF@smtp.kernel.org>

On 2026-09-11 14:55:55 [+0000], sashiko-bot@kernel.org wrote:
> [Severity: High]
> Is this statement accurate?
> 
> Several lazy irq_work callbacks (e.g., cgrp_dead_tasks_iwork_fn in
> kernel/cgroup/cgroup.c) rely on this_cpu_*() accessors to process local queues:
> 
> kernel/cgroup/cgroup.c:cgrp_dead_tasks_iwork_fn() {
>     ...
>     lnode = llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
>     ...
> }
> 
> Executing them remotely on the control CPU causes them to access and drain the
> control CPU's per-CPU lists instead of the dying CPU's. Could this permanently
> leak task structs and pin cgroups on the dead CPU indefinitely, while
> incorrectly altering the state of the control CPU?

The cover letter explained why this shouldn't happen. Additionally the
referenced cgroup patch is already staged for 7.4. 

> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index 9f19c05c9962c..73eabcbdcd50c 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> [ ... ]
> > @@ -263,6 +263,17 @@ void irq_work_run(void)
> >  }
> >  EXPORT_SYMBOL_GPL(irq_work_run);
> >  
> > +void irq_work_run_cpu(unsigned int cpu)
> > +{
> > +	if (WARN_ON_ONCE(!cpumask_test_cpu(cpu, cpu_dying_mask)))
> > +		return;
> > +
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		return;
> > +
> > +	irq_work_run_list(per_cpu_ptr(&lazy_list, cpu));
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Could this result in a use-after-free of the irq_work structure?
> 
> irq_work_sync() protects against concurrent execution by waiting for
> IRQ_WORK_BUSY to clear and then calling synchronize_rcu(). This assumes the work
> callback executes inside an RCU read-side critical section.
> 
> However, irq_work_run_cpu() runs from preemptible thread context in
> smpcfd_dead_cpu() without holding the RCU read lock. irq_work_single() can be
> preempted after clearing IRQ_WORK_BUSY but before calling rcuwait_wake_up().
> 
> If irq_work_sync() on another CPU sees the BUSY bit clear, it will call
> synchronize_rcu() which returns immediately, and the caller may then free the
> irq_work structure. When the preempted work function resumes, could it access
> freed memory in rcuwait_wake_up()?

Okay, this is a bummer.

> > +}
> 

Sebastian
