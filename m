Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566937C0FD
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364888; cv=none; b=YdQ+cTKF8x7vYFY9pyYiV5TjzS6xN4+YV0nQMwAWeALEgfWEOPgvSp0X7gwA4+Ha4O+RH0KK+Cq/39NkkMFbkGwwOhyojSLBt39KIgXK0Z/69e5p3heTOA+bWTpyKAulITFUOx8gE8sxGm9XP+NpUh976+E6BZl1xV8GZQ/3l9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364888; c=relaxed/simple;
	bh=fR66qV3kQLyfv39LEIbTf/Q7lysxPTqD1gJeyle3EBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQq3RJ86AbrRP0MIflONKHThkhcv6BvAalc7I2KnZ3+WLYMdjkyzMC9Cr8PUS0MRNymtqP0VSNXOXsaD+MlaF37+4RK3QieWfNLrr/6DUdAJuY2CplERTQECYt4rHX9p7aWOZ/Hr3ucZj63ZuQuP0TryE4kjlBKcuXHE86eq4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rptkGFjc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rptkGFjc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49e6bad7b79so14261665e9.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 13 Sep 2026 22:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364885; x=1789969685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXNYXe0Z5RdbTRhZRnews+9t6bKbA3tmATeBlUSa9XA=;
        b=rptkGFjcDrtdMV7xrR1SEHRKlXvyaI79faXlu8/Uz+nKYs0f7r0FN1Bgh6tAAfEcBW
         lBYWZnlXZ7fBJGQCaIEHniIvt9ApbKg5YOukGZMbsxieNwDwyM6+CiFjxA03PPlhQ7/y
         +LEdw5eo/F1xC/QBs0bj3Art9KAbF9WgPJ8DuzXacmI+ZIERdfoKiYp+baRXKw61lWto
         Dfim1D1zlQeBSsSIf2nMNn4ckHhO3yUYadnXYdgMXeBJ5iIyKq5datz29yIZjL+zRIsd
         633/yuF1NyqY5drOymoAQW6TuNgPHFlgqMkrRk6U0vtuJZrCZ2i0/DDi90hM90yk+AjD
         oT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364885; x=1789969685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXNYXe0Z5RdbTRhZRnews+9t6bKbA3tmATeBlUSa9XA=;
        b=c9sT+j0bDwvQfZrHSGyl56thel2ALIsGl6Tx6cYqGUqBJ11d5MRYYcTpGXCbn7OK5L
         oY8+ndQcMFH0K9jMwj93z/HrfaT58IzZ2J07dBetLe6O3gS+4ZHO+UDMisF/CnlkdHc3
         zS+ePgDk/NZYHCS5LO1+4befMyzxiw0kvhz1VyI4so+Nu2rgJP4+kjK5c3mKH1qnDHdE
         BHkNTE4hrRjs5jAlUkz5Yv8hg7OdQZe6WzD7L5tuGwGVOCZbDeHcY4TUTomqmCAkjiTx
         ZGWMeTXA1S/gelrTOM1Bh29AR6flZ/KcCpHW/kuuci+hfEyTor8PJIElN/Wk/ZhQbR3Y
         zmlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlbSbkW5LXZY15PaOn26B5sg03smNE2UdjR3e2Yw6N+cnav/jpvwUPKW7ZYrasQqMmEHRo58ynUglhPaWxJg==@lists.linux.dev
X-Gm-Message-State: AFuF++mTnpRye92LRAJckDcgOMDoxEiUZr2aox+JSWlVd9vqsNiTvXpT
	Xd6PJgZcctZFkcnFBPpITJof7mU45O+kDexQ+B1PugD6jKaPEw9qCbg3
X-Gm-Gg: AYBFou1XXLNcLWksCrDjcW2VYefSeVVeFJm/HA00l6N7Lo2eLiwc3wtcEbTJLIJXhlH
	gVH2VZM46enLT3io0trRm5Qq95Es6I8DSoavNYl8Z2vceD+kqGQ/2ollLIAoqFJ4bkrZOSYt8/Y
	llUCPAq8aggqQzsQROxBLLnvzLtnjEmx/nTUVJcljWNDjJc/v0U5xR2oZotIHY6kpYpmRqlLKfP
	3b5MtEWbuKMyPeV0P3sqstj10RG/Kgw3inSEWCweDCF2ZX8KC6vGWZKfTjMVHYoGnxgEl1WHRfD
	ityKlDE46RqDqDJj41+t8ujx5ou3W5J3OSveXrn3kpuFj+KLwjd1G+CdPjBkn8djZKPITlKy6+2
	PXUdO8s5g8Vlc6WyNSzyi2hs7o2qvbF47Wq2EBKteSrz4/RvEIzdUKYzhMWA12rwzbfEhayjrCJ
	rB9kWdJUZzjcvxOW1bs6CJEekh8xblyQpLeXXkwtBA4T7UheSv+nuHDTP4uQR/7WuAq27Pyq8DW
	uYGyqrS/LanOOuh0gzC01Y5f0NjSFdMAPUQSwPYG0kz/tbNbeUtUZ36I7/p/zZJIUh26sGvWT8Z
	kn7mgkDMCeedUGVvDN4tvE9wsS5aK7E=
X-Received: by 2002:a05:600c:3586:b0:49e:747e:c00e with SMTP id 5b1f17b1804b1-49e7a64e729mr11700895e9.9.1789364885075;
        Sun, 13 Sep 2026 22:48:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm214537735e9.5.2026.09.13.22.48.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 22:48:04 -0700 (PDT)
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
Subject: [PATCH v3 6/6] sched/core: Pause KCOV in wake_up_new_task()
Date: Mon, 14 Sep 2026 07:46:32 +0200
Message-Id: <20260914054632.12877-7-kmehltretter@gmail.com>
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

wake_up_new_task() is built without KCOV instrumentation, but CPU
selection and enqueue call instrumented helpers. During a KCOV-enabled
fork, they can record scheduler, hrtimer and clockevent coverage into the
parent.

The paths depend on runqueue and CPU state, so coverage varies between
identical forks. Pause KCOV for the whole function, extending the
scheduler exclusion to new-task wakeups.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e3b50bbdf3a9..a669f8d99653 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4962,6 +4962,9 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 	int wake_flags = WF_FORK;
 
+	/* Instrumented callees would leak coverage into current. */
+	guard(kcov_pause)();
+
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	/*
-- 
2.53.0

