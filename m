Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2530F547
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885406; cv=none; b=b30eu/0dn6db2mvdJyMiWO6OY4GWn0V6Z4Y0Vd8ibKZhX0gwH5MCp13nqpnVFy4DgzmU0vNpVUAbfPhuF6BIocmyszRkcEUqKNYORly9cYW9ZNggGk2eM1PevWdoXHASahdq+5DE7AwnHR2IKAIbQ06eDen72lLyw7FYb+7g6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885406; c=relaxed/simple;
	bh=1dqjeTXq2/01kDuF3HpXMO1cfM745PC+ileuKbWH/dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=s2E/atasKtdxA4QGQfDh8183igwmRGDEexm1UdyXd4hAqaLNNDpQQ9G4mN5SY0jJHzUgIXxPcES7e1i8LIBWxWRQODSYldnYhoq8/VnwTgm167AP/HXIG0/WFv/NIrLStN0Bgn7P8HtmmVKUD0fGztRU5+6tbIOLQ8cjIecAHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIIYE+zk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIIYE+zk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780885403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILywUoltnn1EtjSpguSVVCO1VF4yG/cINhF/dYcn1P0=;
	b=PIIYE+zkJPbDeRoSacYgryAbzySeoeSrCXw4j8txkJlTIetDhj/rKdurTIVRK/UKUrfTtF
	FA/zM3PZ/NsJa9yCBIqA8nWUNl4geGLAeqI6+EAudtI0Igi2z3eBdleqT9TKPSV4kn3dZu
	qi83z3EcuiOszAvCW4T86SLUFHGNC6g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-c4hoiibGPAi3sXizzZVLYQ-1; Sun,
 07 Jun 2026 22:23:22 -0400
X-MC-Unique: c4hoiibGPAi3sXizzZVLYQ-1
X-Mimecast-MFC-AGG-ID: c4hoiibGPAi3sXizzZVLYQ_1780885400
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D4871800347;
	Mon,  8 Jun 2026 02:23:20 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29AD319560A3;
	Mon,  8 Jun 2026 02:23:19 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 1/2] debugobjects: Add a can_fill_pool() helper for debug_objects_fill_pool()
Date: Sun,  7 Jun 2026 22:22:21 -0400
Message-ID: <20260608022222.723265-2-longman@redhat.com>
In-Reply-To: <20260608022222.723265-1-longman@redhat.com>
References: <20260608022222.723265-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 8MMAM_q1WIrwsA0_std7U2YNczfYeI9c7hjkj8LXBJw_1780885400
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The conditional check in debug_objects_fill_pool() for determining
if fill_pool() can be called is now quite complicated. Add a new
can_fill_pool() helper to break down the conditions individually to
make them easier to understand. No functional change is expected.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b18a682fe3da..1d826689611f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,30 @@ static inline bool debug_objects_is_pi_blocked_on(void)
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
+	 * Allow refilling to happen early in the boot with disabled interrupts
+	 * as long as the scheduler is not operational.
+	 */
+	return system_state < SYSTEM_SCHEDULING;
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -734,18 +758,11 @@ static void debug_objects_fill_pool(void)
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
-- 
2.54.0

