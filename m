Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA14DD6E6
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226713; cv=none; b=hSz64SyknpyXZ2ZbH+tKJENKuJti0ibll2NHV8ghE6dI/RiRML2cXwkrhg4G3+/WzIt3wAYZplPqV8PyCzdSrRBgNCof4raYCLH7lfjVBfrXPq/BVupfDsFOLSKsdxIGg/mYcZImAksz7uZ5lHh5AxW7+9uQ227+kbyKXwbege8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226713; c=relaxed/simple;
	bh=uWLJhE4gif7RZ8mt+wzYrxDcQS3MG1MxrDZwbp4qFO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F43E+j/VLS9b6exN4Q64ciuNTOHgF1D0jq+h2yASUs9qR82Z99PK/5VXYw4fm2jJuHsERMEfYFzURC19iUXReF0s/XAKbOJNL3h/UBu6QbNQ1GvhOQR6yk18f59IMp2twRCtMk/FQJzv79mmXG5IaPejJ1flSUhwGnT+PzcrVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JckT0vf5; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JckT0vf5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so1158581f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226710; x=1791831510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBT8VnKHbqUAHOFreCce12tKQFcAcgcsqsShePksoqw=;
        b=JckT0vf5L2xUKmy0qqe+kn4ncGszzG7GuwZSUMtICYoOjOH0TLuJekdXrf22rn3sDT
         wxZTRP7iFQb7stoQ0RWVkdDvzxk40Y02XnDMqutga4jocJyQUOfSIW1j0PeLsFZwYEHp
         nbdDV8aWkdfqfga+1vIUG9rh4a/rk2mxL+uKDjm2158T4oWT3RFBiDCO50sjk55rowAs
         sSR45UZqgdzxaYc29Td0J9FvH19T/evTY9C9y8WRld4eYWo3NvdnIR4HtC3KihBdcrpo
         vpycOx10ofJVCgDElwRq/RDkZ4Tc9YOs2JnKZlEEdyr2NyUS4dJmHUZkeWADIbpPbJHV
         AYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226710; x=1791831510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBT8VnKHbqUAHOFreCce12tKQFcAcgcsqsShePksoqw=;
        b=nBQmgvVvqtZnUBu8maoYPztHbERqzLRNdNPwaLPdn+jsaWTMmGCHqeIlMOitY6FYz3
         vdW3vM2ESYFv1MSuwIWt9ds7DG8mPbptgrOwTfPbWPrKu8cIWzYwhroCOEM1JsuYK9x1
         HbviLolctW6wt/qM9dQlolVSSAcMlXSqe4lc6IvKdR796LUpuTgUtz9BId8+SqFbQumc
         F3M9PBkO+dP41eXj7gik+n5IZeJvJtuZ6OckE/A5Ti1uI5AmK04cjFIGC0dOMBMarTvv
         d5mnor4XFVcw5ybSHh+Fi6V9hm29/IfQ5/TRkpvEizifEd4LKbiuLxBJM7GtfSfXvd/l
         0W3A==
X-Forwarded-Encrypted: i=1; AKwUvByWUiVqRa0ATsICh0tzo022uSxUQNpgdyoBgOTjPz5+MchsRaT4hUwgBTcgd8FIhMzRfkjOL+BwFXNUTheIoQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lUUHevXDe/o+iL+MKf3Zw3GZ5vUDLGvBVYEY10DjYDRCX3A0w3
	t//hlO+k/b4QouywVCIE+CHC1ZkFYY2oQW8NAZaK/iypypHkKHlO3u33
X-Gm-Gg: AYBFou3BOLrhz3denY2xed4gqCRwSodeypynxFeyIVjnMstcyeL0iWGPM+edOrcP6jn
	YU3gBHEEkoUG0/zpos2erDN05OCvMdoD7VSeA87vfnrMHPkTRsux9FkSZqPTOOLeqTj9M4pGrnX
	k8ZbxSuQQF9z7kVy2tpkuIlmjIbo/sJqUWspWxxG+AOfWBaG/kzqcKWwp1EMs5pq6UC1bhBj1kb
	QIb8y4tfGjEtjlMVbhMgMGoCxNTM2ihzqw5BfoXf3iTEJOAaWjko6qdRFgYeCOfsiluhPBUaV0N
	VIADvRYwyFS3vhxbd+F/sxsimhwcQ4Sz+UFjFUbkPVSw0dTvqX+/CuuseMfyV+x1Z27qkxdT2oQ
	H5XF0MOkCANEFPoDI7L/uksX33MerypxasxNzHmqIY0FIM9mRsl0fu7zIvVl4+AzZbm1tIIrYjU
	FL19Zz5G9og2fA/pIRWtByk6ZIsCidLYkJoTgHNI6XzDTqfXxNqAGOj7V6R5cCoe4I+ndHtRUrT
	+ZLG7knrpIz1HiK/D7x4PvlQotFcfuxD3w1JiV3mXdC3KleOc0vbjyHdk7VV3JtXOeU5vLiA/LV
	Z3VJWVfkZhldw113Deydw1gi1847xMhcL1hklM9I5pqYBGkVyaUH1wfR7LnZgOhEhsRPt8GcsDK
	sZA==
X-Received: by 2002:a05:600c:37cc:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-4a1772c5ee2mr27447175e9.26.1791226709978;
        Mon, 05 Oct 2026 11:58:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm281196795e9.2.2026.10.05.11.58.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 11:58:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] sched/core: Pause KCOV in try_to_wake_up()
Date: Mon,  5 Oct 2026 20:58:02 +0200
Message-Id: <20261005185803.39170-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005185803.39170-1-kmehltretter@gmail.com>
References: <20261005185803.39170-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_wake_up() is built without KCOV instrumentation, but it calls
helpers instrumented with KCOV, such as kthread_is_per_cpu(), CPU
capacity helpers and SCHED_HRTICK arming. They can record into current
while in_task() is true.

CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
softirq in a thread, so the wakeup runs in task context during the
selftest's spin. The same helpers leak into non-RT syscall wakeups such
as a pipe write waking a reader.

Pause the wakeup body with the kcov_pause guard. Take it before the
preemption guard so preemption is re-enabled while KCOV remains paused.
Wrapping only select_task_rq() would miss SCHED_HRTICK arming during
enqueue.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 419dd98645bd..f19221282278 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4273,6 +4273,8 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  */
 int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
+	/* Callees instrumented with KCOV would leak coverage into current. */
+	guard(kcov_pause)();
 	guard(preempt)();
 	int cpu, success = 0;
 
-- 
2.53.0

