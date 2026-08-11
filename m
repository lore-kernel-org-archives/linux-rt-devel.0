Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9AC3B6366
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462897; cv=none; b=RPAYwbDyE7cTdev3kHDKbV4L/PEy64QUCiNxmF8AvpActADvMRfxyp8CBsjD5t/Dx47Sw0rZGLYnSlGaDPvfCy+zyu6J+XKignXmaa3BDmuJklO/wpQnxclnUq5VQZe1bsO+Bevb9Xwy9leD758YSBeIUWXmfzdnyFL5gU6S13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462897; c=relaxed/simple;
	bh=mKSMctdUiHV7v8CKYXwusXFPtIb1S1vJydiBFzUlq1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKQBo369ngaXUkQzdhgI6JTnZ1/qYToGCaJdSuW01Gft6NawtVj6YSXhxrC+ARIr47tRVQaGK8Pw6oAgmXfQ0oEKceAQ1grP/0PI1lyhC+Fz+63mIQ/26sOkgZ8lqoPHFgabnpnU7hQqkYKmnJ6yM7YeSzZymfI2dU8hNZ1Wpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY7H7bmJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY7H7bmJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-496b7622a83so30261645e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462892; x=1787067692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWD3Va6ASDeIp0J3iCIlcAhU+r4lUSfzKNfJdPGsleI=;
        b=HY7H7bmJIA/pV4L3Ql38m6Nj9QyXumqzqC3lgqmeX/PNUYkPm677Ri5ft6c/G58JIW
         vZOy2InkyQMBy1mgHbKTLmAV5oTtnqCKWnVI5+OGX4f0SggmwTaS+QlrGiFadV6Z8paz
         09LEtnxxbunmDwT35GeId73X6UZCWsgsxcgFNSGGNzs1g4OjlZBUw+J4fJQl62SgLAG8
         ymk04Kkg9ODcNA3LlqJTWe/b8+PIr3c0gM41qrdam//XjT2+8WdwoQCfK7czTzA5brwR
         OCxU1ABDvmzBg+LHacs93sCs9mssWdeROjmL7kKcLPOlq3+9bSXK+LWTdMSVADWthCNM
         jJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462892; x=1787067692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWD3Va6ASDeIp0J3iCIlcAhU+r4lUSfzKNfJdPGsleI=;
        b=ZNsohxbaIr52r4qjQtNHsZ08s2tNvhvib2VfiMB7f8tZM6KGOIxWB5oVjHGIExKFjI
         WaHkR+jXvSZu3OaZ+G0yL+nH0KBV8c6aSXt8/sQ/QzLFzNK3E6N+ErSTyG6e6736ydrL
         OaGbiNZiFLEVGxaNIIOlYOcbE+fbjSFxghRIzANU4OY1jDHDQLDRBddGcXpvPFw8mOTd
         lR79Qc/Ln8UQBzizts9Mz99T6Bv9qRH/Qb0QRf/bYyqCPICPGg+N3US6E78HAN+OlvRd
         0nPRhYbjmmQqk5Akg2UyVp1K3s+l/ULLLyAhkadbdtDQ4uR0xRKrQ6grgtssrPjgWIuP
         EXBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1jANoBZDdSRNyZUOqfZRFI6lt9FyT1sPB3An1ADyBSo1swECbix26m06UHZ2OQfxDMP52VY+If2stn+MJVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwD1Ei3BuIMKXQGRbUq91qFDUXWaa3dvrflLZGvrZ+V46f6n0ln
	+yU0zu48FFcpTYjB6MdCsh7lIEQVO5FiTVgPlQ3tr53wO0grUonSugB3
X-Gm-Gg: AR+sD10AirGD/phdk7cPskuwoHnVosg4Y7X/+hEBC0KxKlwKypfK7i+gacDG0IRUQbs
	47dOAz5KRyGluAazvim6NGVMecjA0qMvkImhab3edCUAJzy4Ax6qkI2oxH2eTzKCNum7pbHbB2O
	zHVAecn9vaCFr3SpxgmsIukvZqhQEIleuuNyBndP2TF2S+AJ7Ezqb0pMzYn5kPGD9wsIsbbc109
	BgLhAUtg571yXd7LHf1pcG3UdEd0Mi6f66VxqrGEjUKG3Z5ilSuHUtccSD4s2XXHtklWsutcqmu
	rj7z8xwh7GykUXjpDHtxIcfgQ+iC4NIIvabrpfFrqClUZ3cPVM2/nconMnSGJQP13T+1lj3c8dk
	pwT+lHU33Ni70oXAibpQitNCclviO8uPBEcVAKvrBsHuYpQn9aFFb1toHnMaWVGDKKtZfpvq/jF
	K4Af9vgrDbCLUrG34o6SCAjLPzlIE5VR2CdESbipS8PBnkYb9z1k2+VJPrabPEbSga3afJH5Rw7
	rWbyCNBfMePn6pbK1po800jateSSlG2hdtVP1XInSVRF6G7pw36NxuPmFczZ7+OOiyb/QBo+XKR
	A16ATSyOwsb588Ofw4euDLWVFRXP2v4jw6ds752wZ5Ke/WuMpI/TQ+yVgT/7m30uO0Wx
X-Received: by 2002:a05:600c:4443:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4997846c13dmr52811515e9.16.1786462891646;
        Tue, 11 Aug 2026 08:41:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:31 -0700 (PDT)
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
Subject: [PATCH v2 5/6] sched/core: Pause KCOV in try_to_wake_up()
Date: Tue, 11 Aug 2026 17:41:10 +0200
Message-Id: <20260811154111.64669-6-kmehltretter@gmail.com>
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

try_to_wake_up() is uninstrumented, but it calls instrumented helpers
such as kthread_is_per_cpu(), CPU capacity helpers and SCHED_HRTICK
arming. They can record into current while in_task() is true.

CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
softirq in a thread, so the wakeup runs in task context during the
selftest's spin. The same helpers leak into non-RT syscall wakeups such
as a pipe write waking a reader.

Pause the wakeup body with the kcov_pause guard. Wrapping only
select_task_rq() would miss SCHED_HRTICK arming during enqueue.

Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Notes:
    v2:
     - take guard(kcov_pause)()
     - describe the paused wakeup body precisely

 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e49f0bfa0ca73..e863fac02e38f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4253,6 +4253,9 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	guard(preempt)();
 	int cpu, success = 0;
 
+	/* Instrumented callees would leak coverage into current. */
+	guard(kcov_pause)();
+
 	wake_flags |= WF_TTWU;
 
 	if (p == current) {
-- 
2.53.0
