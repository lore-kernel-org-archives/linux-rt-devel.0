Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450633B42D3
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462893; cv=none; b=t3nbsEQHymOyqNt2ewuJTh1/FUIV0fnJVmlSKPYtuGNwYw2+/MWd5WKzvz477SKRkb5uf+zTgaKjhzJHvzZQEdiRB0oLzNlreVvnP2q7IL3/H1J1TUoDvH/vzNdX4+0ylAh9iWrnvJ6cMjjQV/Q73DnedV//6F1d1nLF8RnQnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462893; c=relaxed/simple;
	bh=s2GsF/HuuhqRgEBoKnXETG0xb+lEGpCR6SzR1Bt2wXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3zMCnbMOw/zM90qYbhf6IfqJYvAEyNBuUdUeV9/ekS2yQoFSuCSkQjE5Vps+Kh1czoGoSJDN8iQulJsMHVFSzX1hbsLS+ZDqgJjTLnqFJLtkhQfZgXpFlaDfpTKSg6wbNY1pcGvV9+J4nPboB8HT7V5kmSycydEwMBtlwTlAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pwr5wpNy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwr5wpNy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954aff6088so28163315e9.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462889; x=1787067689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBg7Waiba/udBzajyRDSpAo3xkVEtASSwhEEWYlwPWA=;
        b=Pwr5wpNyo3HthUfAa60xn+rP7Xg3kNpOG2etgWTrVF7oMdk+DGUYTsV79078GzuZCd
         G6XorHnwfFyw+WqCIz/lVXEc6e2UjOw0XWIMYnMZopUm6jHK6aZtGWPY3WPfjqxZZWTF
         trs8Uq5ti1bxJjo/zKFtxlay+NiwdWMKa9oM3oLdTuFmO3h6hvUNUYvnpP78S9OeJ3ha
         i18IsKOYRT9AmAjn2iF57VSEDOhJv3etf67WButxvIwCyxmRquI23FduMcZLRDfL/ofM
         Qu/rwwlzIHI/fIKEo8c/0mkM39nXnyHDrKLGTy4ZovDMml6xHMiESGxkP3TUStJEwLLl
         K/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462889; x=1787067689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RBg7Waiba/udBzajyRDSpAo3xkVEtASSwhEEWYlwPWA=;
        b=Ce+w37jZaUhRCqqhty6miNorlWAofIbg8HM47hNYjGcUzpByEgSBuJ3j/WpIcDY9C1
         zQc/3AVDygeHiXL8s29+pKsvhySksEuGLn+qHczNnPIME9b2ba1EidEm0Erx6VqWVOop
         ZXSju5us/6a0upl6WVSBrbr/rzvxcYTMzX7aq6ETx0lFmo1zywNgIN2oGhWHOcDb/ecF
         H3FLg7f/mnzkOb2vZLNjzCYqGTkbVZCvMJbo1PgN6wc6x9aJrOzqtBgd/huSCwAGe9p7
         vJnaYxwlhyGopjdTIEdHK4L4FwW8Vm49CIU+SGtLdLyRnbCAX7KnEUBOyUP7NevOOPPT
         tlsA==
X-Forwarded-Encrypted: i=1; AHgh+Rp46uzeUOF6ixfUtFZAT6OOL/DKIgqsWA5/khAR1cQLEq9HFW/2SW5tdHG7azD8ZBgKK5MRhJ2QxZtZl9kuAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMuWrXg6n959nHv/IoHLX4lgDFuU7DY34uwTFcqM162jLMkgy6
	i0SPpa7xJkex1P9JS2fmOLP0ywZ0LcgB8sQ3vW1rLLgvpAyCqCQ1WJ1S
X-Gm-Gg: AR+sD11PIxFxqt9F8qDnWUefcEjmjR+H99PQoyjsDZsfibzaRoxhVGvnOHM2glHh17y
	TBH88y0DHXjrtucR2GNxwzKb4TjibmrdooYbpe7iIbs7Ezg6MAqYS+f5ZcLITR+iE4EfaI07uMG
	hoFgGbjFV1WtMPPZ+W0MqlQb+fj53na5gqGfdJmVfd2VME3U+POYhd//oiJSkeP1bUxfoLi+0np
	pDfAQn4KztdHWr1WCwXSX2IaCkn/OqwYndRmJiEWBm9MDZkwsRdher9xrM9JQzlFvJ5WO6DhfgJ
	i2C2huVqsNGzmY/Az0NhcOqp+zHkRyS06bjK8zIqdM26jMVUb8lkh3Y7wh7bZfYy53W/pQUoT4F
	KzKHeefJm1ITS6o9uwGil4tNaLLX/+knaMS5pK1O4UYUVGjBTTiwReFESwV5NNM3+xzzqX6rKog
	DGMHEb+Ry5VGrVAxAFZdlZ9S/ZLRqnGeZn6lp2NgQTmekf2AwtMmJTb/DXvjy8KIAIakHbiHViP
	WRfN5I7BPt9q5jdNyGrU54i06IHN0amhVjusurh0k8EtFbj9l60TmgLFOgahqy8F4YZiEBbFtqP
	64ytTCOBnvr4mz29ACwLjcK1LDhJ7P/v7zz9A+G4AgzNef1WxaMjG+pLYagbOSIOiTeG
X-Received: by 2002:a05:600c:821b:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-49978444628mr78764855e9.11.1786462889308;
        Tue, 11 Aug 2026 08:41:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:28 -0700 (PDT)
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
Subject: [PATCH v2 4/6] sched/core: Pause KCOV in __schedule()
Date: Tue, 11 Aug 2026 17:41:09 +0200
Message-Id: <20260811154111.64669-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260811154111.64669-1-kmehltretter@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/sched/ is not instrumented, but callees such as sched_clock(),
architecture CPU-capacity helpers and profile_hits() are.

During preemption and schedule() calls, instrumented callees can add
nondeterministic scheduler coverage to current.

With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
selftest fails under QEMU, detecting spurious coverage in
arch_scale_cpu_capacity().

Annotating each callee would spread exclusions across architectures.
Pause across __schedule() instead, extending the scheduler exclusion to
its callees.

KCOV_PAUSED remains set while a task is switched out. The guard in its
resumed __schedule() frame restores the prior state.

Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Notes:
    v2:
     - take guard(kcov_pause)()
     - clarify the test configuration and reword the pause comment

 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cbf817f52a4a..e49f0bfa0ca73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7073,6 +7073,9 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
+	/* Instrumented callees would leak coverage into current. */
+	guard(kcov_pause)();
+
 	/* Trace preemptions consistently with task switches */
 	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
-- 
2.53.0
