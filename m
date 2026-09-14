Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4237E5ED
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364885; cv=none; b=Y9+QfKmShaH4w/TpqPUSajvziqHTah4vP8u8khcG6ifPwqfriZv1Epi5oEeZ3Jwhrh4d/aJAjrbYl775LfwYoYgE/uBXRWyRhu6k85HH9Rd41wtKPE1n2h4R9/XKT0o/NyUAyTkxCEirIoGFWvPhUTD+EtDh5d/BPQxqVkMAfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364885; c=relaxed/simple;
	bh=vs8iIby2nXHPAbbxM+YDs27DIBOnDI8WdDFG6sw1nDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaefLa1vI/y8pnut8KkoodUVg21uCl5cBvxjbMK+a1IduDnZvY3PvzqiyrvVY0oUilP6e68O6SoEi61XJ28n/pIlqLZOVj4wyD3YY/5m6f4FYzrA9ODO1B4pt7ZdVfjgA5iaaAWGNzDd38eWGb5VQeU9GoZFAzo1P8qCdD1BnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLpvVelq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLpvVelq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so7130945e9.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 13 Sep 2026 22:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364882; x=1789969682; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMwj6bRyrsgMgTwnA+0w1Z6ygXdtryIk5Fb3zMeqsM4=;
        b=gLpvVelqugliseFRCqxuex1wQ98Cy4s2iryahIUYnALSLdhNWk0aMGbOkmzZx0N3GP
         eJP8q2v9GxwEsaxJXLy/r/2rvxyqa7l3h8g6U7Cu6QaQ6hJHLB+ehyfqzMzQDNXeE0Oe
         VWQaBV13GzT6a0lbFHMlYFOl5YZ2Vcss79j27s8yQ7+cZb3mxh1gUBkW5F/Wb3vSiIoa
         IX9Kf7jxyET0KoguFYt/qGuIjHdnE3AoJ1LvDlQqCl9iw2OVm0evTdGR/Xw55vVnhua5
         BXrP23KLa13KlLJGQcFZvNvX5NXNUjXpSICO3420B8XLGmiEdkfC3yIojrQz60reFxI1
         X+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364882; x=1789969682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMwj6bRyrsgMgTwnA+0w1Z6ygXdtryIk5Fb3zMeqsM4=;
        b=r2V9mSPJWtwMCk/QTO+c+7/OQML9qKE1h8Xx713P29MTzfxs7ArzzwVXEjRB3DBcPu
         Wn7yLN1OBoLAS7aOFvR829IA3OtkWA+eB+/VF6oMkcu2NA9n6aePid1A/geTfD5P7PBX
         IEb/T4c8sY070vJA3XF4goiKOqgay+QNFrm6KQ++i7+mx4sYRU3SZIQADt+UL8mHZh0Y
         lcgELvMXZic9bx/oL8RExuQeKqe1FapJg/0j1EmvZxUhKzgmidhzgr+xuIrjg4phgC1+
         8FJHEgeGcP8dF5nSDLzl/r4eqiAt4kzj+JPhhvaeJo+9/01Zw06qJ79vATRog/MKUADI
         vMnA==
X-Forwarded-Encrypted: i=1; AKwUvBzufJ8M3TkQVrmzdN51kQPzvhnScPfnlNKXz3G40EKjIhHVtr3Xw45Go/N1rnhOoBaKojyfxwav2J8Gkmc+pw==@lists.linux.dev
X-Gm-Message-State: AFuF++n7ntOnHSp4dcNIsV7oHBTny5ytJHqNfpcPsY3kdsPL3+UI34bI
	Tpsj9Z8pFUzzPMPyTt9zN77kZLeByDDwSgAox18iY+Lhx7iyI2k5emEc
X-Gm-Gg: AYBFou0rZLfoqcfm3Wslsj9Jv0lNofx+UfuCGe/ujPk51jKtfAJ1E0UMvdcG1fDfcSL
	pJ4RM7Is9bhuLDyEgW8kBc+InrfN2KaUXHO/8lJz2dsat8lslRtgH9Tu2gJtwaZmyFYmVZG2ujs
	N9dv0USOSsciLYkJ/bGHp1+2P9PiGwoo320cE2J4WZmKBw4qOT80tDdp4ZLd49+lxXPPAO3fZof
	lTNUJ8KDy4LM34/y9qe9H7oDHgF6ILTR4GcJwjK5GiY3PhgP2NBdQxlrz3dr3sXO8FaWs7TWeVt
	pkN4YImocy06OG3setk2DKVU0ElaQRhsDGplkmImxbTHPDa4k3J5YPudyajxbYxVd7v8byZ+ud6
	hN+AiBwsE62enxLAa2CK+Zk9fVzEz22hnejtBEEGt+lIItqWhEmpRXZPnEoTWqryS7LVLKAAZME
	qcMuDKPDi2e+zQJY8VqWIp/s5WXHWK5zPrDrOdiLM/gXviggAxoVQSPjjbLd7ywKzyVAdmWFyxL
	X3Hy2UlztwRC8wc0IRz1l3GDvXM48dLc+cDXhOMlGk6or3lmoYS259Svw68Htloz5+ACxxcfnom
	V3X922Op+Sj4NZ0Z2VQm4UNKGJypGko=
X-Received: by 2002:a05:600c:871b:b0:49e:69e3:884d with SMTP id 5b1f17b1804b1-49e7a63770cmr9516405e9.4.1789364882018;
        Sun, 13 Sep 2026 22:48:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm214537735e9.5.2026.09.13.22.48.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 22:48:01 -0700 (PDT)
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
Subject: [PATCH v3 4/6] sched/core: Pause KCOV in __schedule()
Date: Mon, 14 Sep 2026 07:46:30 +0200
Message-Id: <20260914054632.12877-5-kmehltretter@gmail.com>
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

kernel/sched/ is built without KCOV instrumentation, but callees such
as sched_clock(), architecture CPU-capacity helpers and profile_hits() are.

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

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae97c63842a4..54b5c5383fe6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7116,6 +7116,9 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
+	/* Instrumented callees would leak coverage into current. */
+	guard(kcov_pause)();
+
 	/* Trace preemptions consistently with task switches */
 	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
 
-- 
2.53.0

