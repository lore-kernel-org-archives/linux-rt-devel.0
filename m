Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3AC40D568
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782698463; cv=none; b=rbiThrLsoR9vfxOSk7U5ji6tmDHLCc+df6wVW5r1xz0HtrnrS70xzp56vxYBaf5TVpkpqYnJhk0b71f+1KhRt2/m43b92NBIkz+uvPRH8yQHGE4Gnfpz0KU3BvlMtion2sda6JbcyFNjRbrjjiWN0NWTdJUldmiB0R6/7V1588Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782698463; c=relaxed/simple;
	bh=fwrrwpH/BaEHJXAYBdgKN08KqhTO8F9+wHs087B12qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOUoR72g4lBERjRhZHc5XpmMr9uyDNBpZ3QnJnITCgGPDoSEypRbexV35unJ1dfa0g3Qck7FK4MLeRKD5rQeewoC45wpjd7HfsDRlIjcvBAobuZ6qTB+Wau74HKbFyuObBv/+iQyjt0DztLZ/MSRhJWbS0oZmKer/+VoIKajkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXjwrJnj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXjwrJnj"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51a868b6962so35193521cf.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 28 Jun 2026 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782698461; x=1783303261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh4ZvE2Ba8epM6KIDao30fstJWHE57U07EByhetTANg=;
        b=sXjwrJnjqcg3lF5MHIJKys8engaXH0M/hkWyDnPFHigcnH1YLP1+57Fb6vaVyqIy9r
         SNhyb9mGVQWwTgZvOXdYYRN6p2DuP3RNg71JlR9SsYWSCi1BC+UYmJoGzhUiG9wbKUWg
         2CJpeToLAToKsDndEro8LHnrC0Y+DRWhjEcRMkQAx2YTqGiBNyKCuHhnalLnKvS0Oi0L
         2KCWpIeiqfxcYOoDrC0oA+h82ozCzXTeFd8+Qo+Q5ShCfOCpcG6sbuT0k/STIlfEAs5E
         Gf0vgXbuxufsissMKFe+nVMWbCQD3/2dIFc+ISuKA8kpZBiCPd9bRmz3GyoqfuHO9Hdo
         KctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782698461; x=1783303261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh4ZvE2Ba8epM6KIDao30fstJWHE57U07EByhetTANg=;
        b=FuiP9HPG8JK74IKf+Jy7rOOcTLbjVjNDLR6FuuMgb6xX9+QC9mpbJ2+2sFY2gVGdyw
         dl//cZmJ7DGKjcBnYuSsSjod/IBfHKuXiVGk3ac5BSCARpcxV7B45pcnjnaIPJf5zrRh
         pLXJDTQx+qRLEruw28dYsPsCyfMc3KTZ6I3MQvtdlCSbM/DUqija3z9urPJOpZ6syudx
         k1mePKmZAhN/YQ8lvWyZynMIszNTE4oaSM0y7nNxfXJ0P+CYZNJtBLTgIyQD0gWk4bpe
         HUwFFJ+ws1s9LKuspvS740GtL0J/5DmnjNczoPIGodS++Lb5OyKvF/0hZqK2U1Qr8VKB
         TynA==
X-Forwarded-Encrypted: i=1; AFNElJ9DoGKf+8DkGLPpcsOSMulaO5xq/iOQnf50Kn6KoSHgJ3bHcm0xWDx/rwp0nrFTch6GKRz6DFtmW0iaSxW+1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx94/XdA9ly4LSvnNo/cLoK7r1Z1xd8zoX09GHPergKo14xXxiB
	j5fWur2n7oebt3RaHmmzG9X2t/ICvaE05VO2PrZsu49NQLdvz8CKgFOW
X-Gm-Gg: AfdE7cl+qISvPIhbnL79eIOzgxXsM/rC8U0Pws35hHkjV9xtCmXi1JOQdMswvZQQdGC
	dLOnq3pNOt9S6BlpmiDBr5QsgB08GB66ZF/ZxLyfUBIez7DQ5Qc4vLHCukLsJO/Zy0jWC0VOTpB
	Cdj3p68ZktWR8G6LxSrvmyt8OBkXUAR0CGDui7oj9KBXIcscffGhHrfcNkERLQpdfFweLIz3JPn
	ZUAc5Ak7huwuSNOK4hxSH9Q/bgK4cBweuUXXP3zcL77OGxTnuJvP45lSN2LT9YGA/7OCgSX3dbK
	v9xZtxH6irbnTmHTm2nMoe/95YAqKRSNxtJEtHFiElDRu1RZF150SwZnWKEN8BW+zITW3tOvzCq
	Ze+wzPFbK2/UgFRH7E98eSn8OV25MFGplv2Ysf+uEpV7KQWKK+QyM7peDbjsyN98mZJ5EUvX64n
	cqN7MNYki8EKPltxZ9dkz95mQdBMq6S7nrQLz4hECXNvxP/sC4Gx29Hsfj6nteke4HEo8JauGm1
	OLp6hiNNhm6HHeXvhhVfZUHFMHogD6+
X-Received: by 2002:a05:622a:2d3:b0:519:55c0:a1e5 with SMTP id d75a77b69052e-51a726e2a09mr192133211cf.8.1782698460639;
        Sun, 28 Jun 2026 19:01:00 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f03e035a77sm14362436d6.8.2026.06.28.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 19:01:00 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] futex/requeue: Clean up requeue state on the self-deadlock path
Date: Sun, 28 Jun 2026 22:00:49 -0400
Message-ID: <20260629020049.2082397-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

futex_requeue() can reach the self-deadlock check after get_pi_state()
has taken a reference for the waiter and futex_requeue_pi_prepare() has
set this->pi_state and moved the waiter's requeue_state to
Q_REQUEUE_PI_IN_PROGRESS. The check returns -EDEADLK and breaks out of
the requeue loop without undoing any of that, unlike the sibling
rt_mutex_start_proxy_lock() failure path which clears this->pi_state,
drops the reference with put_pi_state() and calls
futex_requeue_pi_complete().

The extra pi_state reference is therefore leaked (the post-loop
put_pi_state() only balances the initial reference taken in
futex_proxy_trylock_atomic()), and the waiter is left in
Q_REQUEUE_PI_IN_PROGRESS. When that waiter is next woken on the source
futex it enters futex_requeue_pi_wakeup_sync() and waits for a requeue
completion that never comes, since futex_requeue_pi_complete() was
skipped; on a !PREEMPT_RT kernel this is an unkillable busy-spin that
pins a CPU. The path is reachable by an unprivileged FUTEX_CMP_REQUEUE_PI
that requeues a non-top waiter which already owns the target PI futex.

Make the -EDEADLK path perform the same cleanup as the
rt_mutex_start_proxy_lock() deadlock path.

Fixes: 74e144274af3 ("futex/requeue: Prevent NULL pointer dereference in remove_waiter() on self-deadlock")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Built x86_64 with W=1, no new warnings; checkpatch --strict clean.

Reproduced with an unprivileged user program under QEMU/KVM: the
triggering FUTEX_CMP_REQUEUE_PI leaves the requeued owner spinning
permanently in futex_requeue_pi_wakeup_sync() (requeue_state stuck at
Q_REQUEUE_PI_WAIT) and kmemleak reports the leaked futex_pi_state. With
this patch the requeue still returns -EDEADLK, but the waiter no longer
wedges and kmemleak is clean. The futex selftests pass and are unchanged
from the unpatched kernel.

 kernel/futex/requeue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 7384672916fb6..73ca06ec32454 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -648,6 +648,9 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags1,
 			/* Self-deadlock: non-top waiter already owns the PI futex. */
 			if (rt_mutex_owner(&pi_state->pi_mutex) == this->task) {
 				ret = -EDEADLK;
+				this->pi_state = NULL;
+				put_pi_state(pi_state);
+				futex_requeue_pi_complete(this, ret);
 				break;
 			}
 

base-commit: f24ca6729076623c9a0547ecc71e4fc1c4b65c3c
-- 
2.53.0

