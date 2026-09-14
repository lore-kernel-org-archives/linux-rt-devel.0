Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BD374A19
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364886; cv=none; b=eZpb4F9tVbCakI1zfMlmcQWR0OOT6MMNkC8VRtPsWzXuqumRw6e38BtLe5z/KnY1Lcc6UdU3SmzcBZ9T1Vwn9TuUPJVhiDK1vNYYvwgkfYUUyJETHwHl/eG5Mlck5/lbQtSU/YYplhwEM7e3+OHFl8rVOeaV0evBrg0W/5MY1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364886; c=relaxed/simple;
	bh=4/rEt6aIcLBVMLDQITGZHHjQoIY+CauyfASRMhD8tuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfOZCi9E1MDJMgq/6W8LbW7Zawe/Tm9GHvoPOX/kaXXnbtASPiGcy3pdAzHUuPqWGMOERNlunBg+KyzdMps6LfjB1hTdcyzYKJFLV/M+FN9aN0hvlqF+wqrTj7grb9FTGPwg5qvbLwYFFJwq4IiYygaJK2o8a33o9dSSZQZLw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHAdpxai; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHAdpxai"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso4535475e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 13 Sep 2026 22:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364883; x=1789969683; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRxtvgP8q+4kgTU7CEIUrbrLAuy9hfqDj2Yu0xRVbQE=;
        b=rHAdpxaiGQj12HaqgKZA3UW+oy2b8zXzUCR8d9LFGuEtYcCMUeb3tyxMSoTbSki92/
         l+Hy+B18nU/CP7+6r5kbcUtY788EAp45FiVIjw00DWKS4ilP0yvBG/iM7Kofn/aMRY2x
         cUJLyHN3EIndPfl6DUq0QSJ9F50PwL6G/psYz882VSYRbo5OuCGpv/vzuHKthvr8xVzv
         EglDVpzv2rZvl0ZF5iwuUBxlnZK6wj0EJ25A+vyAnqwtpNxukY8iGG9tVcStCI/gXjOJ
         NKRNsiSakcLTkWkqH6Z0zsRDOeWgGGJSR5fe05lrthpwgA3QEL2B9I0Zb04+afEmoBDY
         wWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364883; x=1789969683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRxtvgP8q+4kgTU7CEIUrbrLAuy9hfqDj2Yu0xRVbQE=;
        b=oLi82WsiNVlJJxZnJRCogKwZHFA86IBNELAulkzVuDxcDUcPWKcE+3a8/8DTyBwQQ1
         LEp369cyhAFNa7Tsse9BtBqvCs/s6gUrELlmMBDwz/Oihi+CuBZzzqH0g/+qwCdUxRXN
         gzgUSwxNL6OIi0XrEooGvjHYPTS3nDz2uITbSAcaSwUO6E+t+ROyjhsOn1dRIoy/yNYZ
         MYG+rYtW+WGBBlss4Jsc0gRPasMNGNzAe3BEk25kfptE4UfkjryN2K7oAG7j/ecAFxlg
         DGhdItrKVHhDkQoGFGHYs/zFo3g7El839EnJGu523WQNxZWrAJTit8oP+Hc3An+8wns1
         4YJg==
X-Forwarded-Encrypted: i=1; AKwUvByg53u7402e2qABhuqGExFjYFBxblmQ9nz0rEn8b8dyn7os367tNyMY30n3jxdn8q4GGJ2rbFY/z+ZPxWM4LQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lbrmurLVqacLGOaB/pFNA1AguyQzJDqWoXDONSnNQtCK5EPkQl
	Q6O5FdtCCGervWwRv4h1+RwodrB0cg87Fs74Lna27HIPBp3m2FAFLczH
X-Gm-Gg: AYBFou2ghmPytjhfe1kgDvyoAWRFDrSZ1aEMyHRgynBiuweiL5Fa18D4MRckMtkuG9t
	BYMMpnGqdSOejVg+TD4uinnHP/zLXVGJXCRgwKtjG+OT6kaE7clv8VNyvuc1LtnpBzqHk2Q89WA
	6k+c5lbzQXSD+owPCejp3kFv2qCC/HvS5Q1wOZO/07UQMJxN6+7yvZPp9YzQLDY+6KZVxFyvYVM
	H8GieEQw3iHI/f5rS16dale8XCGx6tuIgrO2IYC8dTHsnF63CTvyWazWL9hSOI85vpQ8OJmOlJk
	xXasMC0utINqcZaYDXFusIflYOWNGhln56kpAnWZNz9IX7OXaS5J5QMJWv+Y28QCi/u1Fxi1PYH
	aMYijVi3ffoKm5nGKz6jXwSbjmtb2jEtsrglgqzcRVlEtEtL5e20lU8dh1rAceRG2nCRoqnZu4n
	2zi4+vgXdDd+guD5xUHFbLRnXTyzL+88ULKpRvbqcdrhP56ivO6nImJ5TUYsGHmu1gYWUwj4bZ5
	tAMJ2Jra8BOUGdegLsE2boizxhdXok0yvBQQwMjr5T4itM1yFbM+Mmi/i1BgRe25qf/T1p+uGdb
	6OnUAQSOwnT2jNLwo0eDXa454SJhxTmp
X-Received: by 2002:a05:600c:3484:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49e7a6865c1mr10069645e9.15.1789364883547;
        Sun, 13 Sep 2026 22:48:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm214537735e9.5.2026.09.13.22.48.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 22:48:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
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
Subject: [PATCH v3 5/6] sched/core: Pause KCOV in try_to_wake_up()
Date: Mon, 14 Sep 2026 07:46:31 +0200
Message-Id: <20260914054632.12877-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914054632.12877-1-kmehltretter@gmail.com>
References: <20260914054632.12877-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_wake_up() is built without KCOV instrumentation, but it calls
instrumented helpers such as kthread_is_per_cpu(), CPU capacity helpers
and SCHED_HRTICK arming. They can record into current while in_task() is
true.

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
index 54b5c5383fe6..e3b50bbdf3a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4266,6 +4266,8 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  */
 int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
+	/* Instrumented callees would leak coverage into current. */
+	guard(kcov_pause)();
 	guard(preempt)();
 	int cpu, success = 0;
 
-- 
2.53.0

