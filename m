Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A44332902
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116744; cv=none; b=fr5/I/UdzIcqL+Ym+kW4uwRGCrZ4CJmnSeFplCmjCRSuV71wqp+jFymlQ7O1ZA+F0wz7Kfj393QH0mN2s5Xh8X5yVo0B7C1bjRsJq+JngDMETEehnhiuhyKn6R7Rhhwbaac+YHQeQP0R2HK9+xB7tIUD7NJZWtozjgBdZDfU9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116744; c=relaxed/simple;
	bh=iuAdYE5WYuaJlGn8GYQlwP9kU508R2DjW9kjK00rreE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq8RbGUli+huQ4Ee5fZIsJcS1untFOGfUY4weJL6fO0WHolsDwGDOl5afwsayVq1NarhON4RR9W0yhT+kuXMD5zJQK3XbNSbcJ9ZAUc2XBdjNEDFRE9s3iRKcZUrPq+aHdjI1qqrZe6XxLODyavX5cYks/yp/nHocl85EaX31dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUyjoKS3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkwh6iuu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUyjoKS3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkwh6iuu"
Date: Thu, 26 Feb 2026 15:38:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772116738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qD3+6POXKNawLzIUuj2U309vx3UvgtoIfk7xn2TbokQ=;
	b=dUyjoKS3qrtrq3xWSwNltNQhKE3o4ALW1ajwOY7nqMMCsXtZPKu6siKbP7Cw4YHXOFHRhC
	e4D1mBMHOiVArrXPRxwOgxruvmhth4wVfL/+Z1odokwiQuMnGZa16FVPXFeZ7zl61xxI7d
	/Vg2dcH2CDFWfEaD8yZPJWyoTVzEkQdl8SSKbEL/Cuj1gcj6LD4d67NTy/JxeGrXGEuVFM
	Bkyt8KJHZrus4LasFa48Dye32bn83BWKmoad4egODdq2SnG6NvGwGGkLh61mZTo1MA8UMv
	I1u4N3q3wsMqfeAMdGv7S+NZq4a94iA0QxzYljVyKijtZyRYYDOSQ+kYWhlCVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772116738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qD3+6POXKNawLzIUuj2U309vx3UvgtoIfk7xn2TbokQ=;
	b=pkwh6iuuR7s/oYhiqToSdazOZCtQLovdcZtbccX9MNRgHlUHKExkYyYmFExj/bdgS/tOTS
	RnQ9pkoJopgzepDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [i915-rt v6 00/24] drm/i915/display: All patches to make
 PREEMPT_RT work on i915 + xe.
Message-ID: <20260226143857.4ZJAFzf6@linutronix.de>
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260224162703.Q_taYjEC@linutronix.de>
 <20260224165903.2mn24oQy@linutronix.de>
 <20260225075806.XNtXjZ5E@linutronix.de>
 <7ee8b784-a714-4329-aab2-a571f25c3baa@lankhorst.se>
 <20260226120715.6Ug1Qkse@linutronix.de>
 <20260226141942.Z6vUrEQ3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226141942.Z6vUrEQ3@linutronix.de>

On 2026-02-26 15:19:42 [+0100], To Maarten Lankhorst wrote:
> On 2026-02-26 13:07:18 [+0100], To Maarten Lankhorst wrote:
> > series somewhere I could pull and check. In meantime I would look what
> > causes the lockup on i915.
> 
> I think I got it.

This the atomic sync as-is, IRQ-Work (FIFO-1) will be preempted by the
threaded-interrupt (FIFO-50) and the interrupt will poll on
signaler_active while the irq-work can't make progress.

This will provide the needed sync:

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index a2b413982ce64..337f6e88faf05 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -209,6 +209,7 @@ static void signal_irq_work(struct irq_work *work)
 		intel_breadcrumbs_disarm_irq(b);
 
 	rcu_read_lock();
+	spin_lock(&b->signaler_active_sync);
 	atomic_inc(&b->signaler_active);
 	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
 		struct i915_request *rq;
@@ -246,6 +247,7 @@ static void signal_irq_work(struct irq_work *work)
 		}
 	}
 	atomic_dec(&b->signaler_active);
+	spin_unlock(&b->signaler_active_sync);
 	rcu_read_unlock();
 
 	llist_for_each_safe(signal, sn, signal) {
@@ -290,6 +292,7 @@ intel_breadcrumbs_create(struct intel_engine_cs *irq_engine)
 	init_llist_head(&b->signaled_requests);
 
 	spin_lock_init(&b->irq_lock);
+	spin_lock_init(&b->signaler_active_sync);
 	init_irq_work(&b->irq_work, signal_irq_work);
 
 	b->irq_engine = irq_engine;
@@ -487,8 +490,11 @@ void intel_context_remove_breadcrumbs(struct intel_context *ce,
 	if (release)
 		intel_context_put(ce);
 
-	while (atomic_read(&b->signaler_active))
+	while (atomic_read(&b->signaler_active)) {
+		spin_lock(&b->signaler_active_sync);
+		spin_unlock(&b->signaler_active_sync);
 		cpu_relax();
+	}
 }
 
 static void print_signals(struct intel_breadcrumbs *b, struct drm_printer *p)
diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h b/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
index bdf09fd67b6e7..28dae32628aab 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h
@@ -40,6 +40,7 @@ struct intel_breadcrumbs {
 	struct list_head signalers;
 	struct llist_head signaled_requests;
 	atomic_t signaler_active;
+	spinlock_t signaler_active_sync;
 
 	spinlock_t irq_lock; /* protects the interrupt from hardirq context */
 	struct irq_work irq_work; /* for use from inside irq_lock */

Sebastian
