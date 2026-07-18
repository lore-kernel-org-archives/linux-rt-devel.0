Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96B31E82A
	for <linux-rt-devel@lists.linux.dev>; Sat, 18 Jul 2026 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411126; cv=none; b=H3nV2dZ2VF/Z7/uX2v6dHlj5Tu2NyUmo00Pr2TRhLltPR0BW/jt8C0ARbfwS67ik3CMn7ZN26ZTZMJRvJWld+kmeFpeeJmIUy0XP2z3QFluzL+JU52+Hs+/Q6UJYPWTg+m10jgo+dQNTLqR2ag3xwA57beXX5cpcvLzpoGoaaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411126; c=relaxed/simple;
	bh=TflFEkAAq8IFEZdplcfp5gf+gDvTkI/W1tDoehWX32Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCt7zSBW8qMXbunQV9QKwN+O/9EugTfmREbD1gk+jap5c13S5tpLJfLddgN1WtCUkJSx3YgCyxE1k/+ppT7qGCd6dznJ8zb5VXtPMtgYxX1E2NEUrjURc2RHFmrdNfR5uVitV3Fglarg9gFMWs6aMO76iC7YQKZcNNOgeeE1mw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/56rEgG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/56rEgG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49557167508so2249545e9.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 18 Jul 2026 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411123; x=1785015923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z4YGNawamvQdlBrqVppCZOuCeOqoXk+MraHRjuwkWAk=;
        b=J/56rEgGNhsMImQvqdAMQWON92WsGNL87Ki2tgPe/h0tcHR/X8LigKAFGS4TJJAvKq
         SnkQQrytNge0geffcfgm7YuIHcOIhZ5rqIevaeLYkNQ0IF/sfpzTdExRM6OR4JY578x7
         d46CtqeczY2GwiN83GGG4Xnh8FO0j3K9ZXsaFWsLTz9xrDu95bRCdNR1WjAxhrKs0aOw
         Tf4J1a5p3bJZ2o9XrLwdCHWFDyfHK132T+POlhOD+QpxqyZrHRiz9g59oTfsurvvmXZQ
         WF/qce05gp1hUdn3Pc12TGsjP/OM+civ0HmSHOQJN9v1oDPV0rFt36rBG87yusD+f4KR
         S3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411123; x=1785015923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4YGNawamvQdlBrqVppCZOuCeOqoXk+MraHRjuwkWAk=;
        b=P853gqECeOPmZjmLYrmqmyXzFQuTfx2g0Zt+gSqP505iJvQ77nzLe1DMFB3UfBO3C6
         ujtQZL67bzf3PzOh3+fz0fvDMrc4Ep+bRyfv5KQpy7e0m8/c20btcyvrCt5aKG0ZFK4G
         XRY87ABF8Yk/9ruHS68EF2JAMKpbhcwBdwYuWTNy4toxWa4x5ePoqYj9PeASjND/ak9O
         20J0vhUfKheJHRl2NInfwZ1FEF2SYHSVtLXj+Yhs59UfgW38aeh6Tj5WonRur2+5J/lY
         xqZHYw+XNecnjSjanXyzjadfvU70gNBZ4k03ngsA+Yx/Y1d87iBCBYsqCoiGzKywFe4L
         wesg==
X-Forwarded-Encrypted: i=1; AHgh+RqnV7KDkify92txt5SN2+Qi4mUosX65ptxpHSAj9gBu2Nl4gSISK896ZZPEMYaQIHHoz2DXF4Q3dR6ClbFIGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgbeZe3azqU5mwlaU3doX71dpuoPp4NvoMQ8X+wfWxsL7lMGtP
	d8kgcVgA8IJVKmswIjvWRh/Iv3HPXOUTphgD9TFpCqwILfeg2cXUPq2y
X-Gm-Gg: AfdE7cmuJTZWiiduRc6a0o0D2TBqSGzHd7GJC//fXKApINmCOABwU4jEXOF5BjXVL8R
	DZ6Gvh/o6ZdftVOEBfd4bRHBaXftURKO8NTaTtQ9+mtiAnNnEUohpijgbzYS8xU99TS/h/16/50
	oW8QRaVFnX1ONTrFqKI3+5/LQiSd5RhRKjYOSWS1piUJVoc3yAK9xXVlmCdU/mFOfiqH34C7jwn
	f0TW6VyX1PuiYgRmqr1juI3jX+w1FHiTQaLw6K+Gl8NJRPeiGG+a4/9wB/KT8J78dCZnth0PqHd
	S4mK+0RQeSosrYGOoS84ZGUWlmEcZSJksL307s0nQF2RiVSFfGjSbAjzSKVoijcdcHVQGV7duzr
	U8qzOmXrY2xDaha8nBEXkpQyvLtJOPiSNYKfARsqDPTL2Us7If/0Nm1nv7ZkDg/wGW6S7LnNd/k
	JrksSgo2qlJOhCxmMebGdhg2byhvx/nbjsdk+5xBEfYu5CiSoybLULTw/1YxyPIgn+5T56h1v4M
	1fKLFl6N4VdVyYHtbnyr058px61aQpHKzLCo2jos/5rYxJl+jGXYp6c6XylKWM6840oIChWGos4
	Dy0nZW5Hvw==
X-Received: by 2002:a05:600c:c83:b0:495:40f0:e77 with SMTP id 5b1f17b1804b1-4954a3d59c8mr86633455e9.5.1784411122797;
        Sat, 18 Jul 2026 14:45:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c00-bb01-3966-facf-793f-82a8.310.pool.telefonica.de. [2a02:3100:9c00:bb01:3966:facf:793f:82a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49558cb8433sm6377835e9.2.2026.07.18.14.45.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:45:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: select HAVE_POSIX_CPU_TIMERS_TASK_WORK
Date: Sat, 18 Jul 2026 23:45:15 +0200
Message-Id: <20260718214515.11275-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c6e61c06d606 ("ARM: 9463/1: Allow to enable RT") enabled PREEMPT_RT
on ARM but did not select HAVE_POSIX_CPU_TIMERS_TASK_WORK. This leaves
CONFIG_POSIX_CPU_TIMERS_TASK_WORK disabled, so CPU timers expire in hard
IRQ context.

On PREEMPT_RT this makes run_posix_cpu_timers() take the sleeping
sighand->siglock:

  BUG: sleeping function called from invalid context at spinlock_rt.c:48
    rt_spin_lock from lock_task_sighand
    lock_task_sighand from run_posix_cpu_timers
    run_posix_cpu_timers from update_process_times

ARM handles TIF_NOTIFY_RESUME on all return-to-user paths, including v7-M.
ARM32 KVM host support was removed by commit 541ad0150ca4 ("arm: Remove
32bit KVM host support"), so the select need not be conditional on KVM.

Select it to defer POSIX CPU timer expiry to task context.

Reproduced with setrlimit(RLIMIT_CPU, ...) and a busy loop. The same path
is used by setitimer(ITIMER_PROF or ITIMER_VIRTUAL) and POSIX CPU timers
created with timer_create().

Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Found with a self-hosted syzkaller instance patched to fuzz kernels on
QEMU's versatilepb machine (ARM926EJ-S, ARMv5TE). Runtime-tested before
and after the change on that setup, and compile-tested mps2_defconfig
with PREEMPT_RT (NOMMU, CPU_V7M).

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9187240a02db..f073b5102d4e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -133,6 +133,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
-- 
2.53.0
