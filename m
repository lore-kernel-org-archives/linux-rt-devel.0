Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCE1BCA1C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576655; cv=none; b=ImYzgNbt2vpkZGonLHktSLBwjJVLaJ4cEHdhMvB1aZrkG1VxgIhoJ6pzInC5PHuM4+WWNKoHDbOS+BAqLWjiCS50SxdCC/CmxnpjviQo7mvf8+vtmgUny3/Mfqjamm9Kq6VNXnUOH+CDwwiRyRUpZM5pxz87kWmTXwFlMQ1o4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576655; c=relaxed/simple;
	bh=xlhLY5tDMB4bEJBi0YfRt81NNL1GKZQF5SQn3VuvCVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jf2gtXdC0CdBgfca8pK2bDVe9Qpqw027P8Koq4PwyK43CIHnzDBlhcSafjjJ1egJBKRMw6Tr1BspJ+sHJlzKtYP6Fprn6fQ3rQQ8ycHzUIXI4wcHCc5jADJD3OI2akJ+bKtP8Y/dO2jlB9RICmYD9jUIUTgLkmi9RdMwLI5jShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=JvGXKDc2; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="JvGXKDc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576653;
	bh=xlhLY5tDMB4bEJBi0YfRt81NNL1GKZQF5SQn3VuvCVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvGXKDc278CGNZ+vMyzB7GCffmOJRxDwpulC94mtZAAgv2sYWopMzfGxgbA2rGvBk
	 NHhdL1Z9fqaZOpkglz7SHdKGCWweqgt9/tRjoFcUwOGFkhOGptbt+dY6qLec4OVWg0
	 QWNxiK6RmT/0pDJzuPoOR147zPUYnYrg+u1rCio+gzudiBG3mXqq3wjTT0drcm137H
	 P99oUBq5JQhYoFaDKa9FR0u1qQ66jGhEshbfrlXkvT/iCZoC6PfvjBhHy8stZIYXq8
	 8BLlKygh5OvhIg1rIaEphWFEncNJbrb7CebfEWQ5cbLvHFZFTiorPRsko4bDpdUOPI
	 b0qmtPXP90QGA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 16/24] drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock()
Date: Fri, 20 Feb 2026 09:37:14 +0100
Message-ID: <20260220083657.28815-42-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220083657.28815-26-dev@lankhorst.se>
References: <20260220083657.28815-26-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

execlists_dequeue() is invoked from a function which uses
local_irq_disable() to disable interrupts so the spin_lock() behaves
like spin_lock_irq().
This breaks PREEMPT_RT because local_irq_disable() + spin_lock() is not
the same as spin_lock_irq().

execlists_dequeue_irq() and execlists_dequeue() has each one caller
only. If intel_engine_cs::active::lock is acquired and released with the
_irq suffix then it behaves almost as if execlists_dequeue() would be
invoked with disabled interrupts. The difference is the last part of the
function which is then invoked with enabled interrupts.
I can't tell if this makes a difference. From looking at it, it might
work to move the last unlock at the end of the function as I didn't find
anything that would acquire the lock again.

Reported-by: Clark Williams <williams@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 .../drm/i915/gt/intel_execlists_submission.c    | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 3df683b0402ad..948975e72d295 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -1300,7 +1300,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	 * and context switches) submission.
 	 */
 
-	spin_lock(&sched_engine->lock);
+	spin_lock_irq(&sched_engine->lock);
 
 	/*
 	 * If the queue is higher priority than the last
@@ -1400,7 +1400,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 				 * Even if ELSP[1] is occupied and not worthy
 				 * of timeslices, our queue might be.
 				 */
-				spin_unlock(&sched_engine->lock);
+				spin_unlock_irq(&sched_engine->lock);
 				return;
 			}
 		}
@@ -1426,7 +1426,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 
 		if (last && !can_merge_rq(last, rq)) {
 			spin_unlock(&ve->base.sched_engine->lock);
-			spin_unlock(&engine->sched_engine->lock);
+			spin_unlock_irq(&engine->sched_engine->lock);
 			return; /* leave this for another sibling */
 		}
 
@@ -1588,7 +1588,7 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	 */
 	sched_engine->queue_priority_hint = queue_prio(sched_engine);
 	i915_sched_engine_reset_on_empty(sched_engine);
-	spin_unlock(&sched_engine->lock);
+	spin_unlock_irq(&sched_engine->lock);
 
 	/*
 	 * We can skip poking the HW if we ended up with exactly the same set
@@ -1614,13 +1614,6 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 	}
 }
 
-static void execlists_dequeue_irq(struct intel_engine_cs *engine)
-{
-	local_irq_disable(); /* Suspend interrupts across request submission */
-	execlists_dequeue(engine);
-	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
-}
-
 static void clear_ports(struct i915_request **ports, int count)
 {
 	memset_p((void **)ports, NULL, count);
@@ -2475,7 +2468,7 @@ static void execlists_submission_tasklet(struct tasklet_struct *t)
 	}
 
 	if (!engine->execlists.pending[0]) {
-		execlists_dequeue_irq(engine);
+		execlists_dequeue(engine);
 		start_timeslice(engine);
 	}
 
-- 
2.51.0

