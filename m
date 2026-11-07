Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057456;
	b=HO5agal/ZZYpW3IPkdW3NnapEFVLGED32W6GbI5Eyejq0HAiK9lF1MBnoEageZ0ZBzR+
	 COfwyhfrBv7beyOngeiIDzMslw++0P+RGwt9q3CYSjgBcESvpqASKprlx5qOyreBBczN8
	 qGo2Zb+Q4MIOEArwehODAJim/Wc887Cd9CVqkCj88C6l0fUfIRWn6XJyZcEpo+n+jy1Ef
	 ine2oGxgNAAtWhGIaqzPoPq2KMVrKXeotTdYWTv2/zjVOjU8jqXLA4v781BPJ6+EfvkU3
	 QHtzL12Bbp3IeKUADdwi7Q1tCjKLADw29fC89Vm0l9mPi6kn3ZselWcKnlYdtA2W+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ItPMq+0SKfbZaBB5rlvcWbCpgzrdlSr6QqqHBYde7Y0=;
	b=Gz4XMwsw8UbmPCu2xKVdPeKjPNZZ6OQPur+dQg8nHnr7PHUrLHRFuj6oadmAZKtClKTY
	 gREPhhqPLg25gkRoZ6oNdwadaVupxmm4mxsKNVeKpSMYoLRHoTFEfzTDgXACM2Y0LJ7Fe
	 +4DQSusM0/lGz3V1J5Yj3pA1cAGLP/rsQGrgYfI1Uhwk5+Cx7sgeicNXAek5A/Xaub4hr
	 UeaDL5vmFTgt1FvaGoLMu1gaUQXVXiuEkOp9eD4fgeZfCjY4+OnHr2uV18mP8TKlZaBdk
	 JZQoU1e9vISEQn8TnevmU8DHO2X7WZIZiGngxXOA5xLUI/f2LdGZMKEdvxWN//E7nPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9Olo6We;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F6606D807
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 170F6606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9Olo6We
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so2172165e9.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057454; x=1794662254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItPMq+0SKfbZaBB5rlvcWbCpgzrdlSr6QqqHBYde7Y0=;
        b=A9Olo6WehJpQaaHeZUZpcUjwEw/+j7aOOjT2P5NwgjmE6BDf/3/wQXrcfUAbKTuMVX
         KmWaYkGm9ZN6+glJ9dHMjE24ezx7hOG5uqU5qQ2T0JPHIzvtCKbNM+latk6c30wyu4Kz
         qerFAs6ukblkVtQrmiT/FX9GWSmc2J65B2fCVl7mrRkK3gNyRPmL6WB8UQzzQAS7iEVS
         9TndusW2oUzzAo+QziQMO2cSA94vIDXslaaMcMxVSi0RzWoWek0ISgR6HidP8w8iFhu8
         FVhvObf2MdW5zRzfmwYRmA2M9Ib+hzRk+XgXq6xoNuEWvLk2js6UM7rTmJYsjohYQb3H
         3/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057454; x=1794662254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItPMq+0SKfbZaBB5rlvcWbCpgzrdlSr6QqqHBYde7Y0=;
        b=lXOXBj4VeI4F/NcKOVSOXC6oONC6EAu1t8GlzSbEemSIF3I1wMBMufdvRcWKRW+TQU
         MXMIQHavgEpRAADVSIHcv5fzbdD9HtIj0+z5u3PAUGVRIz3f7ewb+2Zr0kcaNQZvhPUt
         zzVGTbYHMgE3g4Yg7EqqAb9cT+8jWY3TsGctGeIruveo/x+8f0LU4YSrovMl/IepW4gG
         ASOxQVdCBoBMChAwJXqjtvLhx2fblmBXWIrwvODlSOI5S7uH+uOI5q1XoZrXucXaRd0Q
         bGKUV0H6SUD59z+EFWWb1UfASUat0xoxnNyCio/A5QjUOcle0RmR3xRb6iA5vYjD+NA6
         DrRg==
X-Forwarded-Encrypted: i=1; AKwUvBzH6MsavWeAmQkWvzf+CidKzWIh5nkXGmZ4i09lxgElXOvV+5rfFrFISsIj+c27AdTTlyeYU+2cRAcZbOgvPQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9OLzCgS5xZSu8zmIemR66ATR7RV8XgZUsxwMbMWkEsxxtogxdW
	PZBD6cJBgUBiDC6piO+3kw5f1UGZPMYIXBjbqOlJJKCPMcO6qMOqxHhM
X-Gm-Gg: AYBFou0NPNaXah3h8zhFMVit+wSKIxXLsY4UzI9lth9nYwkdMKby8Ma5++yxBBqcKYa
	5MlxC0j41q1KeTlfOawe6scWGR9pVVq5uiVPGHlNP8l5oIwVXTooBkCmQN3hja3iiUBtvf3V91o
	Yl8n/dceuoiB5euEnpdLA1RNeyK8OaEVqlf7VA0+yA2WWeQUkcJBbhb55/eWOq7kdU0EuTo5d3F
	33DzVWQguTqjInwH7QfhToyeScawZeVPf4hBX67sWTWTYvpnbOYWFffsNvrEn1u45IQHrdhftWP
	QKwDtvEgjrlFu+byYIPuWOsaLhmuhogmMWulLqJMxDOM7gTb7hlgp0kQSqaNO65SkwW53sfq8tX
	60V4PP95zdDJd9BunhBPDCb1Wn2YHObufO7P07rTWzGDMFwY0FyUKIxpkKGr94bbDqosAriQVf9
	KBO8SVNH7C+h1IMKQim/oJNQxK/elL9OgTbL0o+3qAjxBdHGq6aSihtxnzCzhHxsUCnllGK8QGD
	UfvAHh7DSoxR8LuuyV6d/it09iKUORqf0B1XYYzT5EHHE8MTnb/9t2qhYP3GeNkWJFB/2RImOsK
	SCgXbAT6Fb/uR/LKa72GU8gxbKhU0C8U8YxTkFRPY5GXuI4MERQrfMAMuB0gwRUyJH+00YmPhm1
	c2mJyvMBxuyfq+DwzMKQtqFP9M+dAbyR05rxPMIsQP550ddymEz/szwI5beUICigmufhACVM7xV
	CVWLc70qlHHS6lVtXeUQsHhw/N2mtlQCs=
X-Received: by 2002:a05:600c:4f8a:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b819f51afbmr34182515e9.13.1794057454331;
        Sat, 07 Nov 2026 05:17:34 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:33 -0800 (PST)
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
Subject: [PATCH v5 5/6] sched/core: Pause KCOV in try_to_wake_up()
Date: Sat,  7 Nov 2026 14:17:09 +0100
Message-Id: <20261107131710.89264-6-kmehltretter@gmail.com>
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

try_to_wake_up() is built without KCOV instrumentation, but it calls
helpers instrumented with KCOV, such as kthread_is_per_cpu(), CPU
capacity helpers and SCHED_HRTICK arming. They can record into current
while in_task() is true.

During task-context wakeups such as a pipe write waking a reader, these
helpers record coverage that depends on the target task and runqueue
state into the waking task. Before commit feb5c9a2447a ("softirq:
Preserve interrupt context on return from interrupt"), the IRQ-exit
ktimersd wakeup under PREEMPT_RT also ran in task context and failed
CONFIG_KCOV_SELFTEST in kthread_is_per_cpu().

Pause the wakeup body with kcov_pause_scope(). Take it before the
preemption guard so preemption is re-enabled while KCOV remains paused.
Wrapping only select_task_rq() would miss SCHED_HRTICK arming during
enqueue.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1691eb19f31a..4bd0d5736ccf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4323,6 +4323,8 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  */
 int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
+	/* Callees instrumented with KCOV would leak coverage into current. */
+	kcov_pause_scope();
 	guard(preempt)();
 	int cpu, success = 0;
 
-- 
2.39.5

