Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D212BE051
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506477; cv=none; b=dawyAjlBjVkJorHwCsNLsUiHQ0OLHGXXM1j8ly5RbQalN9ZM4ZooIa/8mGeUuR4TEuw59MG5tuVr2ZCD6ZVf5EmnpJQvO0lB5are5tV66whAWu7PdpYy0sFUIfyycicaiBfLfWlQrm2JRkbweJvlPHL2ZN46u47NAWE00TcAKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506477; c=relaxed/simple;
	bh=EM5dnYnPjG0ExPspOMnKXz+O2VCw2L4p5bLMrt8OiYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dwozh2zXGVChYBSf9B5MTuikJPm9TAZJjjms8xhBmTz0ylxv36g/FaA8QyH7DCn1K9BQHisgp/+XmIx7/nfPrTgkWCUSYPaXWP+Rjeexczw/n/Oek9Ty/lOTiHXwxgcyAqvwIPYFc4lcE4zRgvRmE8OYF7ipm+Lexu/7A/vAWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBci2c7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbBcklNb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBci2c7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbBcklNb"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780506473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXUu03gGAw2PqYVU0d/8b+RI1ECws9w94+4av0PHPW4=;
	b=RBci2c7GWigeAW+ebl+sJ0kTHFKZ5RxmndhCt+2JePanpw2WotY5ozRNMFeCa2D4HL1I8o
	Lkpwse70VusFmMYHUmWtIsnlIbjrzR13u06YxHZM/6EmgMSNPFLkgyYL/9lxhJi03mdbPr
	dLnt/z8ffgQQLRV1ZCPoj6Gj0KjRkPoWXUmFgG2I1LN3VoAsuA7Uire0ybJMOjuF8d494h
	IriDEpqln21KRHx8VDETrb8I7Oye0Yk2V8RkPZY20UjfUovUUHLDN0qGBFo+hh+PHYZLzc
	r/f84hzD+YMa8ZmxwvSsmTUW2Rk+PeBJWl6DmNTMBRnNmj5GPe1CnAveaIdvqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780506473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXUu03gGAw2PqYVU0d/8b+RI1ECws9w94+4av0PHPW4=;
	b=JbBcklNbrXzKxb39xdaldqE+SOQRVr22wdEeebWZ5d92uuyOG2bBTazmGo25w1Vd8neVqs
	PsdQGpswcyuuKFCw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Waiman Long
 <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH-tip v3] debugobjects: Don't call fill_pool() in early
 boot non-task context
In-Reply-To: <20260603075656.S1aZM9PO@linutronix.de>
References: <20260520201509.931905-1-longman@redhat.com>
 <20260603075656.S1aZM9PO@linutronix.de>
Date: Wed, 03 Jun 2026 19:07:52 +0200
Message-ID: <87mrxb5z87.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 03 2026 at 09:56, Sebastian Andrzej Siewior wrote:
> On 2026-05-20 16:15:09 [-0400], Waiman Long wrote:
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index b18a682fe3da2..2adfe2a79a086 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -736,12 +736,17 @@ static void debug_objects_fill_pool(void)
>  
>  	/*
>  	 * On RT enabled kernels the pool refill must happen in preemptible
> -	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
> -	 * on the fact that spinlock_t and raw_spinlock_t are basically the
> -	 * same type and this lock-type inversion works just fine.
> +	 * context and not while blocking on a lock which can trigger recursion
> +	 * during PI. During system boot (before scheduling) preemption is
> +	 * disabled and the pool gets exhausted. Without scheduling a deadlock
> +	 * is not possible if allocations from interrupt context are excluded.
> +	 * For !RT kernels we rely on the fact that spinlock_t and
> +	 * raw_spinlock_t are basically the same type and this lock-type
> +	 * inversion works just fine.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
> -	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> +	    !debug_objects_is_pi_blocked_on() &&
> +	    (preemptible() || (system_state < SYSTEM_SCHEDULING && !in_hardirq()))) {

This whole thing is unreadable gunk by now and I really can't decode the
correctness of the condition without reading it five times. Something
like the below:

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,34 @@ static inline bool debug_objects_is_pi_b
 #endif
 }
 
+static inline bool can_fill_pool(void)
+{
+	/*
+	 * On !RT enabled kernels there are no restrictions and spinlock_t and
+	 * raw_spinlock_t are the same types.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return true;
+
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context and the task must not be blocked on a lock as that could
+	 * corrupt the PI state when blocking on a lock in the allocation path.
+	 */
+	if (preemptible() && !debug_objects_is_pi_blocked_on())
+		return true;
+
+	/*
+	 * Though during system boot before scheduling is set up, preemption is
+	 * disabled and the pool can get exhausted. Before scheduling is active
+	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
+	 * and if interrupted then hard interrupt context might run into a lock
+	 * inversion. So exclude hard interrupt context from allocations before
+	 * scheduling is active.
+	 */
+	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -734,18 +762,11 @@ static void debug_objects_fill_pool(void
 	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
+	if (can_fill_pool()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-		 * the preemptible() condition above.
+		 * the preemptible() condition in can_fill_pool().
 		 */
 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
