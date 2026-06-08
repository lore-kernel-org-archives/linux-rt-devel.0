Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC83191D3
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885412; cv=none; b=jMJAI3rnbqh9cUciJj2EBnAFtitDQx0qiw5cdLmB/vsbe5XEfTwLBin/amykRNT1OAj1WagI/Y5pbVAGQJamW8BI5866ZUIqWR88UTizMzBOHjd3IsKRQJSMKMeU07MzGlcalGTmr+P8vt7gW4jd3YUApQwdPOJwB3LC6mrgIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885412; c=relaxed/simple;
	bh=5uEFQX5H+pvZr1FacZzRG6H2gRVcWvvvASwYlGJkkl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VQz+YthNhJ7W9Zmj0Gr9F1qhsndsoXWOQjgvRsYkTMRxhG3RDaqyNJeAWZqK3nyjOQd+DU98oHmtEJNAq9DSm3sE87hBNSmP7/8I7BCB57qB689KlVTKN1qIMiYyRFmfHjbDxnPuf6h6gXUxg//rKM4X7KGbN0eJwa5lamYtiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmpOOdIG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmpOOdIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780885410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4pjEPP6UIRdrTl3K9yWNXm50pFPMXWUEr7RuLd2pZY=;
	b=PmpOOdIGVKzmjoeppaKibtuRR01E5gx+nLbOyqLJa8wHhXoQjAj7yvV2kon3+5TGDJZg/C
	BKiMeJOcpfijorG3ygqyxSh2ZrvgD9fDGv9t2ElElChhNy66vhNKxw+uOCmrazVq2RGaUS
	rh588ydPfPBqQ6JDwM9drajpLCvKJKo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-7ihvBpDDPgatnrQ6QHPnvw-1; Sun,
 07 Jun 2026 22:23:24 -0400
X-MC-Unique: 7ihvBpDDPgatnrQ6QHPnvw-1
X-Mimecast-MFC-AGG-ID: 7ihvBpDDPgatnrQ6QHPnvw_1780885402
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 570AB180047F;
	Mon,  8 Jun 2026 02:23:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D083519560A2;
	Mon,  8 Jun 2026 02:23:20 +0000 (UTC)
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
Subject: [PATCH v6 2/2] debugobjects: Don't call fill_pool() in early boot hardirq context
Date: Sun,  7 Jun 2026 22:22:22 -0400
Message-ID: <20260608022222.723265-3-longman@redhat.com>
In-Reply-To: <20260608022222.723265-1-longman@redhat.com>
References: <20260608022222.723265-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: rBGdS4U3tBGXFOEVsZPcbd8qvYSR4e1GUbLclItvK0A_1780885402
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When booting a debug PREEMPT_RT kernel on an arm64 system with grace
processor, a "inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage"
lockdep warning message was reported to the console.

During early boot, interrupts are getting enabled before the scheduler
is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
can fire and attempt to fill the pool from within the hardirq. This can
lead to a deadlock the interrupt occurred while in the memory allocator.

Reorder the exception rules and forbid this scenario by excluding
allocations from hardirq.

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 1d826689611f..6fb00e08a4e2 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -730,18 +730,29 @@ static inline bool can_fill_pool(void)
 		return true;
 
 	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and the task must not be blocked on a lock as that could
-	 * corrupt the PI state when blocking on a lock in the allocation path.
+	 * On RT enabled kernels, the task must not be blocked on a lock as
+	 * that could corrupt the PI state when blocking on a lock in the
+	 * allocation path.
 	 */
-	if (preemptible() && !debug_objects_is_pi_blocked_on())
+	if (debug_objects_is_pi_blocked_on())
+		return false;
+
+	/*
+	 * On RT enabled kernels the pool refill should happen in preemptible
+	 * context.
+	 */
+	if (preemptible())
 		return true;
 
 	/*
-	 * Allow refilling to happen early in the boot with disabled interrupts
-	 * as long as the scheduler is not operational.
+	 * Though during system boot before scheduling is set up, preemption is
+	 * disabled and the pool can get exhausted. Before scheduling is active
+	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
+	 * and if interrupted then hard interrupt context might run into a lock
+	 * inversion. So exclude hard interrupt context from allocations before
+	 * scheduling is active.
 	 */
-	return system_state < SYSTEM_SCHEDULING;
+	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
 }
 
 static void debug_objects_fill_pool(void)
-- 
2.54.0

