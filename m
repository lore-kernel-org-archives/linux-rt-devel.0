Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39032374E42
	for <linux-rt-devel@lists.linux.dev>; Fri,  7 Aug 2026 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135845; cv=none; b=JRFNZHtERSI1yd6NYQjriAP91pxTMj+oTSEP9olniQRS5IOWJLgaUY8f3SWF8WUFC6iRdeQ2MWENIs3UXPx6mmVZG6lxiYtchGbIXiZwbcRdepJTiVG6hWRg/DPMfk3gibPX7aDiA+Szv7jCcyNrWtO/CIbxds/RPZQlnFgJCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135845; c=relaxed/simple;
	bh=SBdGherCSW81nJjciKeWLXON/6esbqxqVMZGrB1zgyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ob/d3ykhyjdTPpaa9c6vIJwWw0eF4JDWli9nAwYpJtwGHY5wmnNI+tR2HrapcUDNW1PiCLzdX12mXjhdoT2aIQLVW/Lz1XW5bMPCVI+s28etljxPyo6Es/TB1wCupl8/id7vKhqkHjAk55e33Ecj3lZKjoxoPamWl0gQbswNJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHoUkKSF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHoUkKSF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so4235e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 07 Aug 2026 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786135842; x=1786740642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJ2y2c9WQsFigCJJ3iH+zv9O0e2lt5rqns3DqPN/VCQ=;
        b=GHoUkKSF6kjZvNepvEb8vnwBcKMmcjR9QoHSGqAsb98E9ELfKu9ihHNUJLANZvZfNT
         xQPSC9IXyUOvJEFR8LH0eDRX5F/XHuXEuwU4AaRPOLhstaEhIPD0VVm099wYIYHJsIrH
         rEMTdrBR3coQfnnYNQpCyKRqH+6s7Yxbyetqp6ENPYLODTJwJuoWr8zL9OCF5I/SuMbg
         BZ1QCKtG/4AwpLdRjv4pJbPwBgF4f6CZz7OoXEGrROZLMDJiCOUriZFAhttUNGbw+tvK
         MnrL2u8ILU8BVl5I5OFj5jORlAqLgNPQ9MWrmjR5zHbjplPO4V/58i+XpTWWiMxGuP10
         6R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786135842; x=1786740642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJ2y2c9WQsFigCJJ3iH+zv9O0e2lt5rqns3DqPN/VCQ=;
        b=AFwthvSjoKwAXb7L1i07/KQCqhcISIaFXp4FReErpnpe8VugBtr8kkd3+llf3xsKmt
         Ce5cwGgGhqv+7lkNjaAQaUB8TO/VMVroirnv8yJV/C8yunamFcaRiKSB9qUEl56k/2O7
         kONkQmUD7Tfe96Jvnuj63/jOavogAh/noKCHYfLsFFyHYYMsMiq+PF2Qch3wRX2tADZG
         2ekVFGotR+h8LN1Sav9hOPtcw/6hh1EEkEuLuX21hj+T0LMYu3NWYfYCB4qW4toROL3N
         ctV1EM2bY4I1cOYzgs5FqoZVcmwQnfKh+1EdRsDyvWxEAh1lK3eBTYXevwTWfcwdiDhs
         wHIA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3JW9CdZO+9BNfAu9QAR4ZgP++0MrTyIlQvji64Q2I5yp65692lnycsUiX5rdFU6jB2cWWogr8xY1aoWUB/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGxQBRkNunPf9anl+UNtdrKUakecBiJU/bYQNsSYJgHwS9Bv3n
	HBTCIrL9UKEqF5OmBKJe5ABnVwCbkW385gae28WUaOZHMtu5zOcZp1J4
X-Gm-Gg: AR+sD12HIStQqqXxB8NR43EfDX4isgpOEaQKuUgnNY6yoSZ9TweHoMG1ScDb7ttRzmv
	c0PoborVKXrl5O3/C/+65NW0c6HZ/413nyPXEA1QvGHfWS2K8MxN6nYbIyUWpgJgqxf84xr5AFz
	eoRUgPN44apKUnsrssbQddPxkr6NM2QlIlF5KM+cUasLQPARze2Yxk9CxtJEqU4lcD9XwndVDYe
	AeW5eK4Sox4w6YJ2T1/NCP6KXZw/Jf38J/vUmvD5RQq+g3RqsroHhsWMNsVg187ikDXtdU61FZ5
	lh4DNQFeWfUqQczuqmirIoVxwMTojrDO485sfMlUNfIaBkQ7euXDr5GVVBh5kILOoxr2PQiSMAk
	ssLM3ZS647EaWRHJCk6SZDCf2iEd6CDDc85zPP51Xpx0gYSG0kDpMoG5cGgvicLJ+rwi8qXGJB+
	Q0dxXSgN3s2gzcWsYB0poDUUnYtuquTxxitZ8h+b3JcuufnJqzmvyIZrKYEHFbsPO9OHfkob6En
	cuTkEX4HCGKIRXbDCGOwmoG77qY5eN5vZeDRVIs68fFnYH6/x2iWlYnlzIkcDVCdCEGzkVmElcy
	2pRXXNeaBO6uzV6Bt5Juvz9lW7nrbm1m3vb3JSjJqu3iU29pjViieYir1zxOs20x3bfP
X-Received: by 2002:a05:600c:840f:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4994e7c0446mr315138345e9.10.1786135842375;
        Fri, 07 Aug 2026 13:50:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b105-e101-a437-493a-4de9-ee3e.310.pool.telefonica.de. [2a02:3100:b105:e101:a437:493a:4de9:ee3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542851d6sm192408105e9.12.2026.08.07.13.50.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 13:50:41 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] kcov: suppress timer and scheduler coverage leaks
Date: Fri,  7 Aug 2026 22:50:22 +0200
Message-Id: <20260807205027.31972-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCOV excludes interrupt and scheduler coverage so syscall coverage stays
input-dependent. Instrumented callees can still record when uninstrumented
timer and scheduler paths run with in_task() true.

CONFIG_KCOV_SELFTEST [1] exposes three cases on x86-64: deferred
hrtimer rearm, __schedule() callees and PREEMPT_RT wakeups. Task-context
wakeups and new-task enqueue also add scheduler coverage to ordinary
syscalls.

Add a nestable KCOV_PAUSED bit. Use it around deferred hrtimer rearm,
__schedule(), try_to_wake_up() and wake_up_new_task(). This keeps coverage
from their instrumented callees without excluding those callees from real
task-context coverage.

Testing:

  - GCC builds across x86-64, arm32, arm64, MIPS32, PowerPC 32/64,
    s390, RISC-V 32/64, LoongArch, Xtensa and UML
  - x86-64 Clang and KCOV-disabled builds
  - KCOV selftest, 10/10 x86-64 boots with and without PREEMPT_RT
  - KCOV selftest, 3/3 RISC-V 32/64, LoongArch and s390 boots after
    isolating unrelated architecture entry leaks
  - 40 dummy_hcd/g_zero remote-KCOV cycles on x86-64 and arm64
  - 400 repeated fork calls on x86-64 PREEMPT_RT
  - syzkaller: five one-hour A/B pairs on four 2-vCPU PREEMPT_RT VMs.
    At ~110k executions, the five-run median was 4,142 vs. 3,216
    corpus entries (+28.8%) and 54,872 vs. 50,940 coverage (+7.7%).
    No unsuppressed reports

The USB runs no longer contained the baseline PCs from deferred rearm,
hrtick and scheduler wakeup callees. The fork run no longer contained the
baseline __smp_call_single_queue(), generic_exec_single() or
smp_call_function_single_async() PCs.

With KCOV disabled, the pause calls compile away. With KCOV enabled on
x86-64, __schedule() grows by 117 bytes across patches 2 and 3,
try_to_wake_up() by 106 bytes and wake_up_new_task() by 88 bytes.

[1] https://lore.kernel.org/r/20260724192122.73080-1-kmehltretter@gmail.com/

Karl Mehltretter (5):
  kcov: add kcov_pause()/kcov_resume() helpers
  hrtimer: pause KCOV during deferred rearm
  sched: pause KCOV in __schedule()
  sched: pause KCOV in try_to_wake_up()
  sched: pause KCOV in wake_up_new_task()

 include/linux/hrtimer_rearm.h | 18 ++++++++++++++++--
 include/linux/kcov.h          | 25 ++++++++++++++++++++++++-
 kernel/kcov.c                 |  2 +-
 kernel/sched/core.c           | 15 ++++++++++++++-
 4 files changed, 55 insertions(+), 5 deletions(-)

base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
