Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4B1E9B35
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288763; cv=none; b=HBfwOVOnK9VTsbQwzVlufLODbgpHG46FCy5ICESk/uf4h2uAta9DkbQvi2izkKcbPYxFoeT6i+CTPPSjG07Dr3ydSX2Mo5se2px/3g7Ow472xwYBuHCp/EGXZqGJCLPo6wZpUMUNfqw0n7rNVGHDewtdT+XNcpLZATV/kUgznMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288763; c=relaxed/simple;
	bh=2CaeixBRt0vG5VXEkPe1WzaF95OakNuejAea8dSeWSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4ZhWe92zjmB6LFD8kCN/2gV494ZPisxo7yvnObzZd27hc9AfMJSs3bYvQShl5G2mlctc3gvgtmQ7CcetVrJwqcTT70pgYgYu9XiBETtNsnHc7m+EMNIAJdPN+hGcKAAOseUHCGGlE7h4dyeKjTjGHN0SGH99Cd6Uqyx7pXsFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TASGUFyl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TASGUFyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744288760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K93wQb2/mSAJZahQSAzOrD4hk2XT84rHR3EYRte3A3s=;
	b=TASGUFylVufQU6ufIh6vO39Rp90KjgKLKuHkVvIV/uaTGHZZYH3kGTei9K7GFPQ2qzxZXJ
	CJYp37OpTGvUBhZtpq4XZmuxdQnNjBuF1K6tFPqb5zASVOMgYUrPdMrYnaDBU4GpAsPH7w
	frk6l28yRNSmKmjROT+Cy1ckYaXRhU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-Sl7472ZeMN-A91E0ISQwxA-1; Thu,
 10 Apr 2025 08:39:17 -0400
X-MC-Unique: Sl7472ZeMN-A91E0ISQwxA-1
X-Mimecast-MFC-AGG-ID: Sl7472ZeMN-A91E0ISQwxA_1744288755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61669195609E;
	Thu, 10 Apr 2025 12:39:14 +0000 (UTC)
Received: from localhost (unknown [10.22.88.250])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11DB03001D0E;
	Thu, 10 Apr 2025 12:39:12 +0000 (UTC)
Date: Thu, 10 Apr 2025 09:39:11 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_e77422QjeYfWWy@uudg.org>
References: <Z_e0uh36Ezz6isYo@uudg.org>
 <20250410122002.JxN9F-nE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410122002.JxN9F-nE@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Apr 10, 2025 at 02:20:02PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-10 09:10:12 [-0300], Luis Claudio R. Goncalves wrote:
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -134,22 +134,12 @@ static inline void put_task_struct(struct task_struct *t)
> >  		return;
> >  
> >  	/*
> > -	 * In !RT, it is always safe to call __put_task_struct().
> > -	 * Under RT, we can only call it in preemptible context.
> > -	 */
> > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> > -		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > -
> > -		lock_map_acquire_try(&put_task_map);
> > -		__put_task_struct(t);
> > -		lock_map_release(&put_task_map);
> > -		return;
> > -	}
> > -
> > -	/*
> > -	 * under PREEMPT_RT, we can't call put_task_struct
> > +	 * In !RT, it is always safe to call __put_task_struct(),
> > +	 * but under PREEMPT_RT, we can't call put_task_struct
> >  	 * in atomic context because it will indirectly
> > -	 * acquire sleeping locks.
> > +	 * acquire sleeping locks. The same is true if the
> > +	 * current process has a mutex enqueued (blocked on
> > +	 * a PI chain).
> >  	 *
> >  	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> >  	 * to be called in process context.
> 
> Did you test it with lockdep with and without PREEMPT_RT? It would be
> nice to throw some testing on it.

I will re-run the full set of tests on both kernels.

> This comment here "call_rcu will schedule bla in process context" is
> wrong. It will schedule the callback in softirq context. Unless RCU is
> configured to run the callbacks in rcuc/ thread which is the default for
> PREEMPT_RT. Also delayed_put_task_struct_rcu() does not exist, imho
> never did.

I kept the original comment about the call_rcu in process context, but
didn't realize that wouldn't hold true for !RT. Would you prefer I adjust
the comments (for RT vs non-RT and other possibilities) or remove them
entirely?

And I completely missed delayed_put_task_struct_rcu() vs
__put_task_struct_rcu_cb() in the original comment.

Thank you again for the review!
Luis
> 
> Sebastian
> 
---end quoted text---

