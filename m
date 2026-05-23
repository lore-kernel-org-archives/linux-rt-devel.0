Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C2309DCF
	for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562291; cv=none; b=URa/hy/2AzIwkpun3kZG12kWf1W0r9exiTrojtx56AU7a4X0z0i7zhboMTmVEOqw5czHE017Q36NHDTKIS6OI8hAw5m9ay1llDGEluGanwybHukBBS2csdrC1vcuwI7MZ3e64taOZLt+naDwfQyqsRfaOyM4JYC7XnvQNcsLNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562291; c=relaxed/simple;
	bh=fGCYrQZITn15AymVpsL71gc4FDPxP7yav1XJig/tNYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1wr792Lh8Cz/DVPcXM6SkvirCnRZmWVC8AtHwo9Rt8YbIXj8kmi9GpZJQejLhUoR/4Z22Cu/5pVd6cdKkX3ad9VVY7tBlof91BH6EvQCU9JWwmoe4Luxmom54VYW3Yu/NBPn50zxhMKcGUEn27QTi7oRrZmf2cEv7Tw7aR91i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQlJuyKt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQlJuyKt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7645adbdso5551651f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779562289; x=1780167089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3KwK4OQz2Wqts/nc3+z0lkaqjN2Z4kU8MCbBSAoxhA=;
        b=IQlJuyKtwjljkVKO4x2tfRuNa+IxKP1vsMBtFUZ48hJYLL8reEeo2ZRCPgolnAcq8C
         Lnd3KQY3M3MhDC2VxIuwyymKunEbbawrMo2wCGttAk25HdtYwPrR4OowPguCSSTZbj9a
         NPK+Ikmr0sjbFzmg5ItPtzJ0PlSHKwJPLsoPzUuBm/i39BJ6UVHNmPgD5YJldnG/oQus
         9aV3+QuztsDoS8n4ZAEbPG8RmXNCg496XHfHF1G/iiB5NvdcVtVnO0C0H46cCawJQaF0
         YdKN/z7aw7OtUa9a3fzlfEuZVQczEMHspANaRFq7Q+0uLlzpp+bI1gpMvPk8nOQWoV+8
         F2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779562289; x=1780167089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3KwK4OQz2Wqts/nc3+z0lkaqjN2Z4kU8MCbBSAoxhA=;
        b=AvWOnky0Z7LTzUsf/ZlZhQdsknrZr1AeW4sGzvcSFEHnK+dnGPXo97Lzi+7Tu4vVqV
         p7osnppQKLAaGgHRv3K8YP71+gh3pp/sQBijPNxWeicwRW1sszdA7G5qFzMIRKYWRYdX
         Vd6Niu9xPnXvwCCTAU0Zxve2F9raTWMPANrPgzEAqME7gjY2sONE0ip69eNdvk7miN6O
         Q5WglE5ttsz3Sm+us6onqszeJ1jFH45kMfYvMykTi2zPMuakavkZg+25e+4VHL/KhsKp
         FajPKdvKA7qh/J3BylrX6YfDIkeVkvu9GfcDt4DoMu6auGTUJKwxEgKBWIpyRKh0QyyN
         sj/A==
X-Forwarded-Encrypted: i=1; AFNElJ8f99/0/Lw2bc7Ws0XczdlRl4ZQ6LO4NLJE+vWWpEq1sno8enBqeEKJry6k6YSmyINmAZwZWw/DbcWQg+GjFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznTK5ahWx0UvrFqI3bbeLb11PvRrZs3JZx+AhDGSrmcQC6aPe+
	wRxUmEDdGktLfJiZ8cgNgSfwJirrgQkeaMwGIbLzWrPLtMcjmKea0Wd7
X-Gm-Gg: Acq92OGA/as/hLA7p0S2ktikPVaxw7SLW1wlo+Is3G4bW6di9tKJ2wU4uk30E9bC5T2
	rsjzYt19GSV9nHaxf4A+0Vy2/PNSxQz5tlvB7rJbBksaIjuYf/S7p+vP7KNzNDTF9rGBpk8uSzD
	JGHBuvLme/ho4bTLUBWT26czHX26GhSJMBdi1pO0Xknyu69LkTq1/KlGkGl9MSwessc8VtrSTDl
	y48TVpcj4rl5bsZvaZcgNbk9L1NZ/Rw+pAgmouaVAHgIAa1viraFl/AVnVQJxIFMUlhSXiqMGQx
	S41+7iACN1JPsaTRWrVgtFtFtFwJi2kVaOkkfyuDpemBKamexMbNJLEVB2/OthmhserKMILKWrM
	XWkax47dUxFkFRd8QqB8XcaSyTWmVTicRgBZhb4kljYBG6Mcm3PXinurPMrkVMMqGgxJ206LCS3
	qRTO83gvt9owh1D7/Sakx7ZiCgghxSb0XGaFR3nmRid26wtlYxCmezR2MR1irTgstxQODSYozM1
	aNuK5DWpQLoYL+ew3FP27/DbhlDXAvhaAPuZsRYyy4DODBSkw9sFyQS0Ec+ZnrrtiEjit8f83A9
	FUFNfS8AAsCg4ZDlFQXXmtRJcRW+Yug=
X-Received: by 2002:a05:6000:430b:b0:45e:8526:7dd1 with SMTP id ffacd0b85a97d-45eb39e1f12mr13354310f8f.22.1779562288627;
        Sat, 23 May 2026 11:51:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a9c7-6b01-94ec-c77c-d65e-8d56.310.pool.telefonica.de. [2a02:3100:a9c7:6b01:94ec:c77c:d65e:8d56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f6ffsm14058366f8f.1.2026.05.23.11.51.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 11:51:28 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 1/2] lockdep/selftests: Restore migrate_disable() state on PREEMPT_RT
Date: Sat, 23 May 2026 20:51:22 +0200
Message-Id: <20260523185123.17482-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260523185123.17482-1-kmehltretter@gmail.com>
References: <20260523185123.17482-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lockdep selftests deliberately run unbalanced locking patterns.
dotest() restores the task state they leave behind before running the
next testcase.

On PREEMPT_RT, spin_lock() uses migrate_disable() instead of disabling
preemption. dotest() cleans up the resulting migration-disabled state, but
that cleanup is still guarded by CONFIG_SMP.

That used to match the scheduler data model, where migration_disabled was
also CONFIG_SMP-only. The commit referenced below made SMP scheduler state
unconditional, so CONFIG_SMP=n PREEMPT_RT kernels with
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y report success from the selftests and
then trip over stale current->migration_disabled state:

  releasing a pinned lock
  bad: scheduling from the idle thread!
  Kernel panic - not syncing: Fatal exception

Save and restore current->migration_disabled for every PREEMPT_RT build.

Fixes: cac5cefbade9 ("sched/smp: Make SMP unconditional")
Assisted-by: Codex:gpt-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 lib/locking-selftest.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index d939403331b5..34554e26d477 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1431,9 +1431,7 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
 	int saved_preempt_count = preempt_count();
 #ifdef CONFIG_PREEMPT_RT
-#ifdef CONFIG_SMP
 	int saved_mgd_count = current->migration_disabled;
-#endif
 	int saved_rcu_count = current->rcu_read_lock_nesting;
 #endif
 
@@ -1471,10 +1469,8 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 	preempt_count_set(saved_preempt_count);
 
 #ifdef CONFIG_PREEMPT_RT
-#ifdef CONFIG_SMP
 	while (current->migration_disabled > saved_mgd_count)
 		migrate_enable();
-#endif
 
 	while (current->rcu_read_lock_nesting > saved_rcu_count)
 		rcu_read_unlock();
-- 
2.39.5 (Apple Git-154)
