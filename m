Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5C1BCA1C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576659; cv=none; b=KLWYngJ27iB6YnNNoCZHD4AB+kkGXPQU4PwIMRZF+OOQVW9swCs52v1fGYGlxpUg/D7oY0sjG5q6pPoogZ9BG2aAFg6IdNd82hFmL4I2OSM9TmULRpaWIl2ZYZAOQhnJBApgU+lmGVoNncl5evDL8yD4RMhwajMjO0ZdzF78m/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576659; c=relaxed/simple;
	bh=dWlyZ+nzXkTj179ReweZJJwlq8+QsUSPlvN3YLSeioA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO8KHniclWbM0ZH32TGRakDEwFUpvxUlKCwylmYtGf3RyvHeKP69L3fNSY8yQbkzlmBO38+dZT2s64NXg6bqD6W/NomoF6kW673zqHxlZYlmgz01yVO4ZtIFn3dDtfLw/GI73NsNPTzAzhHCVcKbngXbuP8gyp79jILQMcY+TAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=hV4ndase; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="hV4ndase"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576655;
	bh=dWlyZ+nzXkTj179ReweZJJwlq8+QsUSPlvN3YLSeioA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hV4ndaseGuSxQpqMgod6a7RHHqVoiSJxk1A59uOVNspta13CjXgiZer3445tEetEP
	 EPR/EEMJMf2j2R7BpsrbXWO05/MnoVntLzp+sZhQKFl4abW4k4DIrtQRGvLYvYRzsq
	 W96KG+WjeOmmhQYkNdbAd8xO7Ho95lZ2NkPjnEdYEEN7c52+/vGgLy8LJW2LdRDBuc
	 7M4EllGe2iIWisHerPapidAxEMtuOwFOSzefvEotA/q7lSoP+jryjUSvWIN47dw0pR
	 hiTh6wCnIR+sxXMJJlL+bXjCoSc7wTQaEu8nU6r3i6g0c9DpasM41amtWGizH4L1Az
	 0uPDCGrEw3IWQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 17/24] drm/i915: Drop the irqs_disabled() check
Date: Fri, 20 Feb 2026 09:37:15 +0100
Message-ID: <20260220083657.28815-43-dev@lankhorst.se>
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

The !irqs_disabled() check triggers on PREEMPT_RT even with
i915_sched_engine::lock acquired. The reason is the lock is transformed
into a sleeping lock on PREEMPT_RT and does not disable interrupts.

There is no need to check for disabled interrupts. The lockdep
annotation below already check if the lock has been acquired by the
caller and will yell if the interrupts are not disabled.

Remove the !irqs_disabled() check.

Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/i915_request.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index d2c7b1090df08..f66f8efc70629 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -610,7 +610,6 @@ bool __i915_request_submit(struct i915_request *request)
 
 	RQ_TRACE(request, "\n");
 
-	GEM_BUG_ON(!irqs_disabled());
 	lockdep_assert_held(&engine->sched_engine->lock);
 
 	/*
@@ -719,7 +718,6 @@ void __i915_request_unsubmit(struct i915_request *request)
 	 */
 	RQ_TRACE(request, "\n");
 
-	GEM_BUG_ON(!irqs_disabled());
 	lockdep_assert_held(&engine->sched_engine->lock);
 
 	/*
-- 
2.51.0

