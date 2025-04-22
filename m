Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D328F931
	for <linux-rt-devel@lists.linux.dev>; Tue, 22 Apr 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337028; cv=none; b=LwMknzSGp5/umzjDIC/WVN27zE2RMfaqoN4jhdj73y42h+slAHfrocQESJ4nANvtyovnDVEiec7hxpIPax5LDIb141jSawRXbpDgv8k69i8eMbGc7z9yA76He57FvIsKfQlsQpqoqPxHFcYMAF1FEGvGtLXEcqze+aoyTmk9sQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337028; c=relaxed/simple;
	bh=mIhBxYbG+pmDSE5aCrley4crIb2diwH7C1G03e2Hk6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y70ZE08CpkNAfdc7HK0iEKss3ksO0+NTzKyczW/UVk18jo50atdsPi+Q1kIF57uEuht/DNVASGGv17qEYOpNJlXPkOVUIPqa7RuIsrGypyFPydU7HK2vIU2m1slLrdqQT+NuiI3Oj01x2j/PgIK8iza27Dxf7yh00zWdtzJA9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7KhwUdp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7KhwUdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745337025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0OrTzSyXcOQ/sG0Ok5H6s6X1DlUx1r4W6qvigJ8iSw=;
	b=D7KhwUdpvN4LsHebMEVUQxiz8prQ+tdCeTFEz+z4F7Q8XdYQQ7myv/1/btTyL4/VLJStKk
	/caFh3vBOXauaHjft1DU9OCiVkd8chB2MY/2zAidkBHROHxtIaWPfxdfonSE/UIRtN799q
	DZTdOegLMW8E5HA1pcxj+nBgirVGzFM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-g2ARZujmPqKh2thGUbLH4A-1; Tue,
 22 Apr 2025 11:50:20 -0400
X-MC-Unique: g2ARZujmPqKh2thGUbLH4A-1
X-Mimecast-MFC-AGG-ID: g2ARZujmPqKh2thGUbLH4A_1745337018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0CE6180010A;
	Tue, 22 Apr 2025 15:50:17 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E73D818001DD;
	Tue, 22 Apr 2025 15:50:07 +0000 (UTC)
Date: Tue, 22 Apr 2025 12:50:06 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Crystal Wood <crwood@redhat.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, lclaudio00@gmail.com
Subject: Re: [PATCH v4] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <ucooiludwnen2gxm6pjypzloif23w4t37vrpml75egpkifbc4z@tmrs462ju7om>
References: <Z_gLsK6rOjV3KElO@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_gLsK6rOjV3KElO@uudg.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 10, 2025 at 03:19:28PM -0300, Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);
> 
> Fix that by unconditionally resorting to the deferred call to
> __put_task_struct() if PREEMPT_RT is enabled.
> 
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
> 
> v2: (Rostedt) remove the #ifdef from put_task_struct() and create
>     tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
> v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
> v4: Fix the implementation of what was requested on v3.
> 
>  include/linux/sched/task.h |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0f2aeb37bbb04..51678a541477a 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -134,11 +134,8 @@ static inline void put_task_struct(struct task_struct *t)
>  	if (!refcount_dec_and_test(&t->usage))
>  		return;
>  
> -	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +	/* In !RT, it is always safe to call __put_task_struct(). */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
>  
>  		lock_map_acquire_try(&put_task_map);
> @@ -148,11 +145,13 @@ static inline void put_task_struct(struct task_struct *t)
>  	}
>  
>  	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * Under PREEMPT_RT, we can't call __put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
>  	 *
> -	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +	 * call_rcu() will schedule __put_task_struct_rcu_cb()
>  	 * to be called in process context.
>  	 *
>  	 * __put_task_struct() is called when
> @@ -165,7 +164,7 @@ static inline void put_task_struct(struct task_struct *t)
>  	 *
>  	 * delayed_free_task() also uses ->rcu, but it is only called
>  	 * when it fails to fork a process. Therefore, there is no
> -	 * way it can conflict with put_task_struct().
> +	 * way it can conflict with __put_task_struct().
>  	 */
>  	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
>  }
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

