Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646236;
	b=EjsC0TR/23RQdHUMD1faywz9/K4ifMsCNIicebXo+Tr7pzAfwvoLWNp9g3jreRMSYQOO
	 O5aVp1cYsMAofzJ6bHvy7TS0bG2uoupyVd4QgyzxEo7X9daLqbwdx/7TEnqg6kx+cspOj
	 nUPjo3H1Rx2Hx8DzGN3wYhxmzaLajzeBBAQDgGE2e8zt6SlXC6asvQKii4371yVFNTqML
	 pqma5+yS1ccdVxxCrdGcLnumPXUsQ3CBHZ6aiCMEbA9aagEIFsup2cEMKmwi8NLrFhwRk
	 iHY5Hvf0SFXlGbzOy64VrZi05DxC39+KenSBYzledLgiMREenc4M/AmgPj1/DZ03VGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H/SXDgdhEaQ9Leps7ngp4tdnFYLEJykx5g1h92ea+nY=;
	b=439CoirfG0qKljUSPLT6eokdkeGn3wpZpkG7l6R20zZArS+4ztsbMcBzRX4nbz/2XRPy
	 rHAT8PXyPi6cf138JSDBixLnK39LWx1fz9bJeQFyjjak02qVFQYJRpuasxxkI3Pz6Pbos
	 vXbPFvOVVgwtSqA3sou+99DUsCQcL16TPGYaw0E8U3W4hnv/FSc3G04rjj3sdxQt90IYW
	 hVRD3QfkLL+tLy9AcbcSystusxWVfcu6Ku/uSgw3rD6jZ3fZODzVDc2BFeeKl8ac1maHZ
	 5ptMm7Izlf3a3v/E8+yibsEI0Mhyhv0NPomtjZGUohFP2w680smJNmkK4+PB0veZ1PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mxU3S65y;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8143606A31A
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8143606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mxU3S65y
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso15951735e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646234; x=1793251034; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/SXDgdhEaQ9Leps7ngp4tdnFYLEJykx5g1h92ea+nY=;
        b=mxU3S65ysHFnzJyu5iLRSi2q4TjecPrRo78DiXM81UCXZUK4viIX4KucKU+X31375P
         TXE927VPRscPO9UWTtoeKeIEFQOH9H81b/caIleJw0VRraEIIpD7Iw21TwgcITFMUTZp
         dKOrhpg2uSkR8vGHAZgzYmBaqM/swYn9+4oGaXkJlZf1MIb3YfnbqJHWhfz74Rc7rDPG
         9wkacKhO8qYoDlriPbx+LuTBU5syS+dXJkRDakQcrxZSzaPGJ+nQdg2Ks03MtSmf19qj
         q5Z34k8g0q96vbcWDGuNpYephKvWkB1MZUN2+fwX8T5xRzhxhpxwrmjCkFDReSDID8/9
         6UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646234; x=1793251034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/SXDgdhEaQ9Leps7ngp4tdnFYLEJykx5g1h92ea+nY=;
        b=BGc2fVoq5A4YvawZzIWc5G6g5ntI/UBnX79lJ45WmJraJxoBKcWXav6yCXpz2jf7pb
         EyIDbCm8E9MfLscZ5I2QJmSZvSfGKwA5PeycbN3cpi0TQG1xkKZLAMKxtJ3VvM5Gvma8
         DRS+RTvnk5dUa17IrNeNKvYoM608vVXcIJTJahlDS21nVRD265kHOfsG0Zsetid//2Bh
         Lsk/NYMxcVimwBQ56AE6iwP9CCnrsazzbxjyMvxxIg0uzFHBSlV+uJg4ynOB0IeDclF0
         GAJbnF9GeCdBvlDXgd4IIL8polK+laZSZ5cyJq0gg7WAzuyCeowP3g5O3H++kr3UrGeG
         fW/A==
X-Forwarded-Encrypted: i=1; AKwUvBwYHsmv03G2Djlm6FC3Jfve1kj2qU/oVmlpVP/GTzlDc4Df+0VRsPtsiCv2Tz+Cu7UKPUUKblSxuPlVEKfY1g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJgj2FYT6Q58YVv4GFWtAjM1YruRq79iyrfVVmHKaEFnFpViMLI
	o8+xkaKD8Gl8mRc/1dvBJl9RebdpSrHSFMoLU0/Y7QO8QpuhaaetwCIE
X-Gm-Gg: AYBFou3agqd0M4cSqEIEaoJndBkLwgl0yfKxsyt4s8O1hXVRDxROocWPq1Jq8WfsvzY
	dl3EhGw0fYfRSgI6NMNDk3mno0aBlXsolFQi/7UUX6yBu8Ph4Bhj0Cs2HVHC0oxrhUOnLgKFmA5
	28PtSsObBLaxeYEMQW5FX3q3+spjTDTAxpbIxLTfj7p2gTDL13QRSFrGKeqPFHje/RY3kqu1/Hj
	wHX9YOfZcz0pEHoyGeHKedCqW2d2tHZ1fhi3t2iHt+Pg+H7op/ALvmHZXFQZUdw4ThciRdhOVnP
	cESEqqwLX4c2P8bbuwQGkbkSuaNSTeif7dLWEdAGDuZgGQ/IO44alN5Lf8Yy1kzLiK7bz/6Y49m
	k7gydwHHYWTOu2zjNiJJ/KSvtGWfKnQ2t0+5rBWbNa9Cy61FzxPkeFHBwVOP+PNxxITY/K9hSgV
	EkDxWjZFYBaegBmEyKSoyu6spq60mtUh/ERyMORx4BeEbPec8Zzk5iDEjpOWXsruvBJEBRwSvPE
	e4Rz23158sFXoW4qbhaWini8ZfWRPKGWBSGQK5DVwjtuSlPTf3xF1/vIEiA6GiqbGWaLoeVJ38F
	y1ilKc9N2TPglncrKolZzoGA/yBu0sMh/eD3nhB0jN2EjJkhvaxnv+7iyqO1pb8IF5ZxKqwsY1K
	BqsKr2o7bkJ0PmgXVPxFaor5sYjNo043W42uINUMY3zqtRkdS6zL2hZaq1pA=
X-Received: by 2002:a05:600c:3513:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1fdd1e97emr87433205e9.31.1792646233938;
        Wed, 21 Oct 2026 22:17:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:12 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/12] entry, tracing: Classify early hardirq entry and return tails
Date: Thu, 22 Oct 2026 07:16:42 +0200
Message-Id: <20261022051654.79224-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Tracing's transition recursion slot exists because a callback can run after
architectural hardirq entry but before generic entry increments
preempt_count(). Steve asked whether the count could be updated soon enough
to remove that slot. This RFC establishes that entry contract on arm64 and
closes a separate recursion window exposed by the same tests.

This is a design RFC, not a merge-ready proposal. I am looking for
feedback on the entry contract before extending it to other architectures
or removing TRACE_CTX_TRANSITION.

Clang can outline raw preempt-count updates and
__kern_my_cpu_offset() from noinstr entry code. This series applies to a
tree with the following two patches added:

  - Hongyan Xia, "arm64: Always inline raw preempt count updates"
    https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
  - Will Deacon, "arm64: percpu: Annotate __kern_my_cpu_offset() as
    '__always_inline'"
    https://lore.kernel.org/r/20260918161407.2300-12-will@kernel.org

Those patches are external prerequisites and are not included in this
RFC.

Patches 1 through 11 split raw preempt-count updates from generic IRQ
bookkeeping. On arm64, ordinary interrupts add HARDIRQ_OFFSET after the
pseudo-NMI decision but before instrumentable generic entry work. The
remaining accounting still happens in irq_enter_rcu().

The exit side has a similar gap. Function-graph and MTE callbacks can run
after the real hardirq state has been removed, and kernel return may
schedule before them. The series records ordinary-hardirq provenance and
restores a synthetic hardirq classification after the preemption decision.
That tail changes only preempt-count and lockdep state. It does not repeat
interrupt accounting, RCU, or tick entry.

Patch 12 keeps tracing's recursion state inside one preemption-disabled
interval. It closes the transition collision reproduced at the IRQ-exit
reschedule boundary. TRACE_CTX_TRANSITION remains unchanged because
unconverted architecture entry intervals can still run before
preempt_count() reflects hardirq context. An x86-64 no-transition control
still recorded recursion at system-vector entry and exit and in the
deferred hrtimer return tail.

The base includes "entry: Account the deferred hrtimer rearm as hardirq
context for lockdep" and "softirq: Preserve interrupt context on return
from interrupt".

The main questions are:

  - Should generic entry expose separate raw-update and bookkeeping phases?
  - Are preempt count and lockdep state sufficient for the return tail?
  - Is arm64 a suitable first user of this contract?
  - Should the recursion-lifetime fix travel with the entry conversion?

Karl Mehltretter (12):
  sched: Split preempt-count bookkeeping from raw updates
  lockdep: Use raw access for pinned hardirq state
  entry: Add the pre-counted ordinary-hardirq entry/exit contract
  entry: Skip inactive IRQ-return reschedule calls
  context_tracking: Split IRQ-exit preparation from the EQS transition
  lockdep: Prepare IRQ-on state from a hardirq return tail
  entry: Carry ordinary-hardirq provenance through kernel return
  entry: Classify ordinary hardirq return-tail work as hardirq context
  arm64: Use the pre-counted hardirq lifecycle
  docs: entry: Describe the pre-counted hardirq lifecycle
  locking/selftest: Exercise hardirq return-tail preparation
  tracing: Pin recursion state for its complete lifetime

 Documentation/core-api/entry.rst     |  75 ++++++++++--
 arch/arm64/include/asm/preempt.h     |   2 +-
 arch/arm64/kernel/entry-common.c     |  25 ++--
 include/linux/context_tracking_irq.h |  32 +++++-
 include/linux/hardirq.h              |  29 +++++
 include/linux/interrupt.h            |   2 +-
 include/linux/irq-entry-common.h     |  96 ++++++++++++++--
 include/linux/irqflags.h             |  14 ++-
 include/linux/preempt.h              |   9 ++
 include/linux/trace_recursion.h      |  14 ++-
 kernel/context_tracking.c            |  78 ++++++++++---
 kernel/entry/common.c                |  38 +++++-
 kernel/locking/lockdep.c             |  48 +++++---
 kernel/sched/core.c                  |  68 +++++++++--
 kernel/softirq.c                     | 166 +++++++++++++++++++++++----
 lib/locking-selftest.c               |  53 +++++++++
 16 files changed, 648 insertions(+), 101 deletions(-)


base-commit: 779ab5d73a22c798d1273b4aaf50cf5b8d750be9
prerequisite-patch-id: 9c009809614854fbff979d65aad6732757d006d5
prerequisite-patch-id: 764fd197db36a3889548bbc41890dd5b3d902f99
-- 
2.39.5 (Apple Git-154)

