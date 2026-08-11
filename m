Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A43B27C6
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462899; cv=none; b=JhFx8jasqG/NNHvBfRJgQ5Ih1BWzNc6g31ueKO1wTYnjp2tJoKGvSCMkcU3JX/KstEPHzz6zLRGBOIUeODSitWeYJ4/BPRz4Qf4ytK8toBMWyx/gSi5sYPm8xuWIjWLIP46s3GeXZm1tt5tRIlUE8/3Z1WJwF+tyajkIrtTXFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462899; c=relaxed/simple;
	bh=9jk9XjA/6n/fxs+YT4/t3BnvsbOeRFkLd3nOBibWNAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQQ8SWZUaHcJVSwTq0Uwa3tjwsXrqlDSkE0xkufHQqHvDd7fDfsI0V0e9ZBI3zKZKl6/J776+YG68PIR77KG199MNpNiKIPnA6NyEpUkzzJk3uqdgVwXWcueIEMem2a0YJyKojFIN4O1s4prrExmEB8XTzdcRKMmYzi5oOHhdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZH9veFQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZH9veFQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49800c6a846so31078935e9.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462894; x=1787067694; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxCk87oJVTgaexDQI9eTOLL9u4+8ey5QmMeaUWHcbqk=;
        b=fZH9veFQ0IwU4008YaBCuCB+DkS4Y4i5b6eKvSp++p2usecWAvOAII3qoid1oqmv63
         iOZz8VJyNHHETDWqy2ooBKPce80UDKKHUjMVwwl9fbdmDdyF2MzqFdooPn6Bl/CzeXc/
         q65K5cXs4RjRwPoT6/5s3rPRW9JQGqZDDbib6pJ5YRqMKXS/do/miSnhdebCcPBfPHJz
         87I/He8Gt+mdKUx3pIqBEHo1i/zDwgpPdX3xYnS/FDFkLyaxLDipnRnGO2GtgdWR8F8t
         eJKMG3aISWy22reY9ZZVAgruPcZNHMEJM+rPrtaPKNozPHLMe0/ZSBiEV4ScMdgDK5dD
         3AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462894; x=1787067694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bxCk87oJVTgaexDQI9eTOLL9u4+8ey5QmMeaUWHcbqk=;
        b=MFSe7I9L3tTJAEtsnpI5PLO+9gPJ0816G8beEx+0ayW+dT/jb97eUzQo0bP4yayTH1
         G2MT8eMoqALG6MoIP5fPPI8Wg/gsYts8zej86+vnQ8unVHc7Ep5riPjar4LyFt/06/RK
         3NEoS6QhbdjBXXTbBkFEIUiALTwNpR6wuiFIvj09umdQ49WqKQGuZ2TQRKJEYUxTspla
         PP6QBc594W/5ve8pc3PIS9HqxOfnt0db1b30PJR3/SrskwAG4a9iS1CUmm8/9P60QTDk
         BOOjPioE+T7tzWccHVNg2NKe/vrvdAraFf1e8n0/XLtYI/627vawQm7pEjKzsP8gEqoZ
         UzRA==
X-Forwarded-Encrypted: i=1; AHgh+Roel2iPz+L4x9a8+Hn0TCPR0kcFVnhKVkNBJxDW27LJ2wyZVC05p4Ar4ryPZB75xGjcBtoyW+nm00zS816Eow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyYIR69PSZ2AxLhftDmClz5IY/WCSqTs7dlRSlqehCQLPeRa3U
	0Ji9jjYWVJnEWIcl+YNpCDOCR9x3puHu0gpikh/fu3OF/lT6hzePp92K
X-Gm-Gg: AR+sD114zMD0kbwsM6K90MwDdPoqvQdmwGwpxf59DDg/Ea/gK8ssZXgyJ9lEJzD+uvh
	yEM87HZZ+9Yhe9oyLHYHHhsaTmJkAOiGEwTa8lJknFhi6ayKjL3PXLutWCUlJFub2EJeRIhP4vC
	Pa9R/VG5Rpf2Tw/sTMjdrv0cIj2PCXPg5+4wF+QtdSQdwkxcLQNUOo/co7mZ1sKEZISIKG4Qzp7
	Bo6nNYrQaaYJM7QFhv4sJHJSFH4j7t0+7omj5gunsaUx9idx5au57j2yRRCREsK9+X14Z5sw19H
	t9hW56GtRaRKHxymsmOEE8o8y0auI2oDYDHbAwPj+4aj9qH5mtVxcx0C2YZM8BinswwlPpEOS8T
	FDbM2BmNzANaEE+rzr3dcYB6g5xKVPFy47HOyKbgtrhDuZw6qUk3YyRBjJtsfaNbdiCppu5qWim
	beHYmSzLUb8npOMZDZw+rUbdGIkmox1LT4y0UTfcMx7IopumdM5QxVyL57eNibhMWKbgeMgeN7q
	AY2idFp3RfAORMUTTuIyt+ZT2GJut6o0kYkCYUF4ZwNbr7kjoBDD6C23Ajj5GBwcSa1D4QSBhhe
	R4v4hk99IfELxjcZgNfDwW2975VD4+QYV+GgzvRLRFKUjwpcXyjLI12aSV4ECMez/Q45
X-Received: by 2002:a05:600c:6088:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49978475c11mr75566165e9.19.1786462893952;
        Tue, 11 Aug 2026 08:41:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:33 -0700 (PDT)
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
Subject: [PATCH v2 6/6] sched/core: Pause KCOV in wake_up_new_task()
Date: Tue, 11 Aug 2026 17:41:11 +0200
Message-Id: <20260811154111.64669-7-kmehltretter@gmail.com>
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

wake_up_new_task() is uninstrumented, but CPU selection and enqueue call
instrumented helpers. During a KCOV-enabled fork, they can record
scheduler, hrtimer and clockevent coverage into the parent.

The paths depend on runqueue and CPU state, so coverage varies between
identical forks. Pause KCOV for the whole function, extending the
scheduler exclusion to new-task wakeups.

Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Notes:
    v2:
     - take guard(kcov_pause)()
     - reword the pause comment

 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e863fac02e38f..f7ddfbbb5a494 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4947,6 +4947,9 @@ void wake_up_new_task(struct task_struct *p)
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
