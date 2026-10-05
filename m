Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8C4DAF8E
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226710; cv=none; b=SkeEXZpdYChdc3saORERUEnOlJm0//kvlYBXYM/RXu0Mm3B5vgFvxfRBeXyWOU0ccLodfHm9K2M95uweBOhfQ2XHWGLHPEZlUkKvm03Zh6wHLaPqgKhMLT/0BykXwXY+2mPCfUuoYXIIC3aMceQh+XKYy/1qCyTBXxzWbw3vMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226710; c=relaxed/simple;
	bh=8NNhfSpyh9bt6fe86wAxMYT1d0iT3OI6uJeMeqYayIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YeAorWzBvrI92/kRqqucEwMovmNJJBmMNgwEdkI11nvwOEHRA58A7ZZlcPA86KDqOwr9scMueF8QEvffqyofdOgwkvWEidJ7LCEgyXm0ycZ23zY3QpIYtVdMVylPW7GSWTfJJZZHQr9GNSemqS0GHEzjZulWBIIoXIs93iNccKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWhZV5QH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWhZV5QH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a024e16179so13031185e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226707; x=1791831507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDVSYEG78WTqmDojHAIEfHw4bT2e8W9+9URBp7SfrwA=;
        b=NWhZV5QH41Otoo1FcCMSm5fGDmcyzWFMO3/ILXQS+foXO0mG7DHrN4f22QW0L8Dypb
         aDp/xvZxZyN/8YAPsfb35hKBILn2ocZwFPWyKTllQyrs7ce2vA3pQjIjCnMVmY1XLOzk
         gTt8R98j9VwI3vhXU75dN0nwIh6MovW+A/rrycvwsL330vkRASQ1Rm5G38eFC4ZeSgPG
         aXsSaz2hQkkQfdkeenYmxbspv9GCyNw83+eY+6EaATisN+UE5uH4om9GG17t3N9bGwUR
         RUlJHfRPGS7jWuC1g+vLw8Q/c13yFnJOf4SYc/NVI61Hb2Mt+K2/0nc8gQF6NmlMBK/F
         eqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226707; x=1791831507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GDVSYEG78WTqmDojHAIEfHw4bT2e8W9+9URBp7SfrwA=;
        b=erQ48mSdaR4XvxHp09U5PKDF5IChTbILUx2SmQ3FnyiDdvisdSaxPn3QsJPPLtqqrx
         V0yeXjjxVr8yOHKt7oHFyKS3c3rGW+cuoTSOOr9otsyfOnC7MFt8N8PL+NdjAGjg970p
         dsoUtVeXGp8tDLFfNFxEN8Ip4I7ShdB3aSETkpG4dmLT7/QevmP+vcP4vpY3CIpw4NVR
         upnYQHQy9eunpKX/Db9UV3/+oGutoaQ+ksjcoPlouaoQX/hNNTbLBq0HzK+HECgH37bD
         J8b4faTs+DDYm1eltCcrphI5/enyJ5/zfzvCuV2b864Gz+snEebiOGSyY1MBC46gaIFY
         TPGQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6hbmFnYuxPKpVfkG9w7wg6kfP29KSxAvZCC0mu8O5PjItHdwU8zkhcGW/p2Igp8mFg9OZZzz3gK739EYApw==@lists.linux.dev
X-Gm-Message-State: AFuF++n4Y4IXa6/E+XWo3IkeBNWWAIKocbRfAoqZS1PDFf6U6EKAdoZ8
	IvSHkvt7ze0/dYsUJE5qV4jXOzcbnAuvDsByb0NiG317U7kBkC0XDU57
X-Gm-Gg: AYBFou3aaxMO1gR8bLoMaIWH+k6c5U4TVHh6Cd/d4vlb8DHoUtB7GGM4t69KhzKnMda
	VORHxaoiQf6YVmowL/Spc3Tad4V8T8uDiQeY1BJwUJo0ry3fzqKBhEHKurNv9mFg5g5P4+j0MrA
	f7hVyeu7CgUaCkDG+7+MR+SeP18g3gKM5cEgtZQNIcA8wA45jed5HuSAZaAyfAn4X3ogHv5/zQ4
	4phfG8g6GuV6EEF2cRSmmzTKVHhaTuhpYZvo7uWSwEZTU8DzCng9wnFmgggYVK0161PllGBl0l9
	a1Bnhv4EN2RtmGeLqQ+FTHxhTw0/Rt+LiFjjkbjiPAlNXSjvc7uTA1aYcCwFUuLg1vVxvLDWrjJ
	WsntaL3kcCJhB6lc2ClA6XuApRcIKdjXHGkPmnpCWj5490sltAU8NWfFqYQPUxqmvn2CQi13gHY
	8xjIL6yhrZEgQ/EkwjVBo4jiRvy28efFdOCrWk0Z6Ybk0cZLhvGrW+F3U5pTyjItmGSxRKPehNX
	EzDZimVWKWIlaPhwwX39jQycEJ8yS+3j4AC2ge33Ade4rlf4EkEAB+dzUFRCnNlHwItVK0pGU9K
	plJiCBz79QKM6+YalxadCJ1ahLf+K0R5Z9hWdabEoPtcYf06JjxIWJOLaSHCAyivi5GR6Dv1c3b
	59Q==
X-Received: by 2002:a05:600c:4e55:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-4a02756f062mr197219325e9.14.1791226706201;
        Mon, 05 Oct 2026 11:58:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm281196795e9.2.2026.10.05.11.58.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 11:58:25 -0700 (PDT)
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
Subject: [PATCH v4 4/6] sched/core: Pause KCOV in __schedule()
Date: Mon,  5 Oct 2026 20:58:01 +0200
Message-Id: <20261005185803.39170-5-kmehltretter@gmail.com>
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

kernel/sched/ is built without KCOV instrumentation, but it calls code
that is instrumented with KCOV, such as sched_clock(), architecture
CPU-capacity helpers and profile_hits().

During preemption and schedule() calls, these callees can add
nondeterministic scheduler coverage to current.

With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
selftest fails under QEMU, detecting spurious coverage in
arch_scale_cpu_capacity().

Annotating each callee would spread exclusions across architectures.
Pause across __schedule() instead, extending the scheduler exclusion to
its callees.

KCOV_PAUSED remains set while a task is switched out. The guard in its
resumed __schedule() frame restores the prior state.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87cff2884980..419dd98645bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7123,6 +7123,9 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
+	/* Callees instrumented with KCOV would leak coverage into current. */
+	guard(kcov_pause)();
+
 	/* Trace preemptions consistently with task switches */
 	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
-- 
2.53.0

