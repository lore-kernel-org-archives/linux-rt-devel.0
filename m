Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057454;
	b=bAOF6MO0QW2nqIrgMQ5mZell2FjF4IYrFH1201BSC1UCpQ3AQFVvtaby9+MaLD6t+lXD
	 PxmtkH0Jf8K+PBy73rntC29aaDs+YGaSRJVWn55EsnWgDAnnPfl6M3+oowYmgZaBUoJJV
	 tvlPAkVk8Cw+oNtRizMUOBSv81qs5gLReLzEeTanBUDug+jsEveM4fSQGw4UgUzuFkDp2
	 HXTyO2qrD1Hqaxle6b5qjIkEDtYGHI13LJyQB7gL2zrtylRZ884wOemrj2H1LJ+K18o8O
	 yt6XG8Yj3spIG6cMwZvg64q791PL/lh8vC+Nmfg5Sv8bW7k8UwJcYVkWQ8ga0fVqrMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QzumoAbO9NG/cegBxumiz71GDAJVD0gixQxGqBuh4Jo=;
	b=N14ag715SWv4QwWLoSf9nuiIr47za637hcurE4vngPoHsuQTuDjf86wWjyjV88nvjbBw
	 aDw7X2ig6sQ9ccvoleQm7lok5u7gjcFv+b/tBSAANXEAULKrRqYwXfj2W9dCN7sElRQ2d
	 OB7DCJHaiwKVW8uACeLGkkhf282EM2RdYQZf4Z3oAYHKFO4S11yHc32bcpffadefgCvkt
	 gD35diabIzIbV2NQB9xPoNk/bHt3dxF4KfkYaJiuTOxEU/YI0MYoCCb4Q/EO0vAdnB5FI
	 NQD+tNyjxuBfUyjUF75pXqA6ZxwUZsJXIyMHnxfUX63fI0E3e91q1yHxdCj9eikXP2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VZ1my8gI;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE9606D803
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BE9606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VZ1my8gI
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so19578545e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057453; x=1794662253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzumoAbO9NG/cegBxumiz71GDAJVD0gixQxGqBuh4Jo=;
        b=VZ1my8gIbE0nIEGR/S0lwBn01oxNUQta3UtVXqnjlzAiK8bEwc4K65mBMxdvMbxApT
         dBCMQA8NWsBfTfkbtbEJcYeonPApbUqfUvYxpKF5pMou0DM+/drBS5104BPp7ZpmrFU3
         wzQW42cwd3IPhQQVYNdApFUOuSdyu53JE/5qDCxvM4v44OYT2gaRm4gv5jW6dArHQrUs
         np87Wl9z1YfARWd3WhKNucykgnRGgxTAELXN5wPZm6fzD5QIf8RByMaPLPJiYw/bJ+0X
         tWtkQAvqEOlGbvU73Bd/QojEUZM5tNO9sfhC1R8sqY58YUhaT5oSDSZG/WBNCAo0s7Af
         edWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057453; x=1794662253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzumoAbO9NG/cegBxumiz71GDAJVD0gixQxGqBuh4Jo=;
        b=UwSTfUBm1gWnWXoaSjLp7nL4x1BFjycFF6wEtJEdaLSJnaCQP7SRNLX9MGVmplPT3o
         Ap2lgl7SgC3awoGXo9s1qzGlIdSEePhr2TNa9LYmr5Gq1zVjzqZFnLp7jydsUgGz+0jM
         j1ADFhqpMqXEqQf6BPI6yvPhe97rz4WZZMoSaJsaR370llrKDYimx+VbG+9TzWhGHzrx
         7TfUvp2az864wLOLT1FcwLcHvc8VliGqZlH+ES50+N2WAOCIK0kLTLAMdf35ZJTAhnUl
         zxNcDCurcXyfckssDoVc1YwlDfPLmqTvvYtvy1lFLneTVdYkF2d3igFu6IfiR+SCMTzm
         2UtA==
X-Forwarded-Encrypted: i=1; AKwUvBzogVBp2li3FuLgsCW26J1ifMyKj68K3bckPeSid5RUdyFomM5o9fNmcWe160r+Li4YTLZLvZByG/aWskQfTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ws3dvk9NauUkK36oTeWDJr/RBU8kFktiVCjfBfwIzaxlPb5pc
	v73ovevpYFX5M6xEDMlqVP21kp8emepeA+GuzA9Pbjuo8nGOOGgdruSF
X-Gm-Gg: AYBFou1gRlAsAPe47K2ivKInWk9RnsclUNJcF19Pf3vMOWWbSq7v2z5JjWHEx3spTVa
	Fx13NM/+JmL8e0JqW7yYmVOTKXPUr4w8F4XjNFQ5GGYNz8N0SKxW7dDo3zMBnERVuVmMdHI7vYC
	B3HzJqdROV764kb86NxVgNolPh4fAgXroVWoyW2/ru063+mV7dk52whogpFx2PNqC6JORQUTmQ9
	YyV1Kj2vz0yAY/5W/AJr7qPYs/tff5Hlkh5VoNG4EKi2RCKLzR5mISjtpyVRRIfwQba1dXQZzb4
	ULBqHZhmXUnG3nnZjI7Pq+3YVb2J2oEWw+C89dCx2X3KH+vP5kHRD800258rgkgmTw4y/vqTo4B
	SmQmPK806OMIRu52BLKGEMkfQVKUPvEJzHAv7xwVyEPXPkPzo8Lxklr2SqNmn+lIeLJeckCgcDt
	qpZYCjwXmxHEdG6Zg+fO4erqE9Pyx5PX6+M2tQVPem0mLuNB2vse/hHxDQdc1SAiCwhdLiq6VoH
	q8rnTV+EezlM2UKc/1hqpVtraSpRwPz3EVDzml6q7SjmEupG6UomyjZ4pwKM4KfLCyUf39b6l2A
	pDlThKiYv23ZTQGGfsgvmJRp2g1MTeRkyOd2mjc2syKW8vJvagMiONXOtyXEKReTsI4Ws0Dg8LP
	O9eARJlbURI8yrL+7Jfyd04Cz84YzBGetcLurJmjz73q9TrHHrYEQHS06snVJ3HBe38IthLYjED
	YqExkkG5liUP7ZVTtIa5JzsAm55gSeiGg=
X-Received: by 2002:a05:600c:4ece:b0:4a1:a6e0:4ce4 with SMTP id 5b1f17b1804b1-4b6e035effamr93976305e9.33.1794057452720;
        Sat, 07 Nov 2026 05:17:32 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:32 -0800 (PST)
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
Subject: [PATCH v5 4/6] sched/core: Pause KCOV in __schedule()
Date: Sat,  7 Nov 2026 14:17:08 +0100
Message-Id: <20261107131710.89264-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107131710.89264-1-kmehltretter@gmail.com>
References: <20261107131710.89264-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
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

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3f13170c2939..1691eb19f31a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7219,6 +7219,9 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
+	/* Callees instrumented with KCOV would leak coverage into current. */
+	kcov_pause_scope();
+
 	/* Trace preemptions consistently with task switches */
 	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
-- 
2.39.5

