Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC63C197F
	for <linux-rt-devel@lists.linux.dev>; Fri,  7 Aug 2026 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135855; cv=none; b=t+4ZFEXssZazuiy7evtvgsZ8Jbo7n1ul1y0oGU0pyiTRePMVX0w7Ho4wUa5vXvTkCmxYrBRHybIYoSsQ39vhhxzw9CRvj89orIBVkx1hUWEo5SAadDwM1lLTAaKDRsjepwbtGurUpUDRxs44kbqAX6iyEtVTCZrbFoZAcAmVyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135855; c=relaxed/simple;
	bh=ovBootHlmPwMO9Q4aAGQU97zSZBvoeOXU5XO8Xv0k+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taEOOQ0OUbs1CUgAKXtN0Z7IalXD8sQQOz6r7EcZzlDzdnDPY5ROrmTS5pkxyStDPFkLKBK/gonxjvUg3U52uP4AvYf+vJCHw8CGelr5DURNnNH3mDqGUkF0/dsU3qvRu66u7aU4XU6E4Pa6YbW+NN5xHhVZZ59kJ7wxYJZDXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT73tiQE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT73tiQE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495590dde14so5455e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 07 Aug 2026 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786135852; x=1786740652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I5BZy2hwsKHXRFfC3cUWApKwBxDn8y4JzUdYjcaPm6s=;
        b=AT73tiQE6utkQN5LfYnQg+rKhvKg35UwBb4EHF3SqUp2pwBBbimxrLQVOOKNg+fcal
         rLCBxzFqKEorreRt5LHDq/TZDG4N4s/napj7mA7nVMib2+3KlLSLc36m0H8lIGDvi01j
         6tZkgT0DpHm5xlANZHTCERBCQG4LPCV1lDlVa3SAhBOz3Lxloa7MDbJ1UmNSVoqX+SOw
         wIO5Q0mRd8Xkwv2nrS7eIr5LF7w8CltMFmcwE+5eMnWUiRZwgzQsuocpIe8VzjKV2KcH
         acg/YdlJLsXKO61Ie56I48qP2m0pJDtKyD8cD8UjOCtbNK5j0RdE752DiUbwpbSVqapy
         ilqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786135852; x=1786740652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I5BZy2hwsKHXRFfC3cUWApKwBxDn8y4JzUdYjcaPm6s=;
        b=G5uwT6QvAv1OE23vJNOjIXbrK64H21E1L0jxXrO93EChrXXv7cdDrAO6uxuf5KkVDI
         Bs2qYeqnMV9l0tURjwD9hli+tBvEXtS4Ej6Un2b7Ys+b5UGXXk3BOVz9nJ5VwASVSuhy
         k2fd5D7k50M6wOsZvE4WxNtVbVDZo5MQzggRkjd0rKw++M08TnI9qgYBCsYKOpmu+tET
         yIfy5QLGM4ZDrzwfBE9FqgHmoav9SToVd3YjwteqDxGwOkIYFMkn6xNi1STQE+bU2k6C
         93c8xXxhlALMwObB5cRj79XpeCROB/4StgTXPo/dJfaa/t/nuqeSUESgnjVCAmDvaE9m
         wy0w==
X-Forwarded-Encrypted: i=1; AHgh+Ro81zg846YgP4vcyKRUaZZBEcxBFVCDtNy/W5JhN/lyQK+N8uS7hGJeMeAVhjQC8fx9p3OP8YSs8fOCFedFVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS8tjFcG4q1/2VnDx6s+Z+mKbxEPHI4iNt8mLFLJ7oFIoGwcTQ
	ZmkKI+McPS0at4Vycq4d10Hvf5WkQNJYIudJ8YulDv4KymIst6NtUlf3
X-Gm-Gg: AR+sD13YbOkL4+jIM27SKo6yCnK7opkNXIztTLVKbvES71bSsWO+S9I7Gal0HBmCjuI
	6ZDKl+A6tnh4hvkl8hSztMuwMvJixT0DxzPzHbF6jPaJdaDLxPwdInhP5QMppD+gjjDCxVlMvun
	5vVZqTiZOjJmcoKy4rhpvTO+kfoxQgWYmqWwbZ9ywzU1PegpVWbmDAXgl1jERqg3seVUmRH2zi6
	frPuCPvP6216wGqi2dfjIF9INFOAUKsSNb4OXa3mbRGMUE+G6iTxrKMMPbTaFpZ+fNOphjtnY2l
	7jCnMlGbyNnW7fXuG5IKV3CvcDGB+PZTAR2ZoIZnCM4Od19h2ToXP8H10HONyGjTM1vdF51cN1M
	jEzx0wXMnztcmAZOxHEDB0lGw7wy+VmKql5h08myOZ3QhJqzPZwVYXh731feNoQmhRzTkLxANcB
	8HSVh2z6ivQuOD+C5S+kcChl4AVo56aPLBHjoI/SOLEpdD52QtC6+k3HiWM2GFyQY6g0Eq7tcpZ
	1GlEDC46waHeScKxWT0bKMFRbNfNjpM70Mqfzy8c1tkr0Gv5BITlFxuTn9944bs6XyaiSdlyiQ/
	pO/I7XlS07TAA/o43wJV/iyZxjnN78l8D5I9w0cojyvM6JLDWIcTPuQtW7G875NS6CDB
X-Received: by 2002:a05:600c:e549:10b0:495:6934:414c with SMTP id 5b1f17b1804b1-4994e7df489mr277825025e9.19.1786135851912;
        Fri, 07 Aug 2026 13:50:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b105-e101-a437-493a-4de9-ee3e.310.pool.telefonica.de. [2a02:3100:b105:e101:a437:493a:4de9:ee3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542851d6sm192408105e9.12.2026.08.07.13.50.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 13:50:51 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH 4/5] sched: pause KCOV in try_to_wake_up()
Date: Fri,  7 Aug 2026 22:50:26 +0200
Message-Id: <20260807205027.31972-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807205027.31972-1-kmehltretter@gmail.com>
References: <20260807205027.31972-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_wake_up() is uninstrumented, but it calls instrumented helpers
such as kthread_is_per_cpu(), CPU capacity helpers and SCHED_HRTICK
arming. They can record into current while in_task() is true.

CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
softirq in a thread, so the wakeup runs in task context during the
selftest's spin. The same helpers leak into non-RT syscall wakeups such
as a pipe write waking a reader.

Pause all of try_to_wake_up(). Wrapping only select_task_rq() would miss
SCHED_HRTICK arming during enqueue.

Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d5663df6c702..1e562a7ff0af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4252,6 +4252,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	guard(preempt)();
 	int cpu, success = 0;
+	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
+	unsigned int kcov_paused = kcov_pause(current);
 
 	wake_flags |= WF_TTWU;
 
@@ -4418,6 +4420,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
 
+	kcov_resume(current, kcov_paused);
 	return success;
 }
 
-- 
2.53.0
