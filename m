Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F617202C49
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968496; cv=none; b=pNrOPinSzsNnJM+aR4roq+Sg23QPrpHWRQzXBOyo8+gq8CNxLaT2PC5aKq0g7MUTlEVoGtZh9vPdJ/DBmh1vrCQ7QsNCRrrsLRvZglpVfiAFY9im82PQPs5ooPxdBltid2RFyPL6hHGI27hqxllw1PLYSRzdsGJx7DoHuhvUOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968496; c=relaxed/simple;
	bh=uDrCrmuMgiCKDdwlP4UJD9XuKVIsnN93CrT1pJWUxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6NC+6mJ3TmFvJ+HM7PtNqaf/aLeU1SuGQAsSRnoDEsCkxu+DWzO0pECOPAT/hYCMm2QnvfDF+Y0Ftf/IpA9exZnRIhxW4ZxRWQcUcs87C918lTPCGtudhox4oEbiNyo7RlRoZtxWn9k0kFgkXCmCS1EyIEFsO9fm55S8BDxUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c45d+1mk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xjUMbmyU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c45d+1mk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xjUMbmyU"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tsW3wVlon4ERSjet09JJR5/3Cm1k+iS1hqefXYiC/xo=;
	b=c45d+1mkVMZxo2P8TNvpB371bj0EYl+k0vtNxpqLWdqg92y82pSvYMVlzg8Xd6zeCHZ3LY
	kPMjzayuF5TaRKyyqBjzo76tYMkXLb3latxefstui6ucNbmKUxFqjRquG2mlMQJTEyibiN
	3DprDYyhfkZkM8L4SmOeoRs5n6amw2iIQ6a3JzfS9zGiHvNKnYP0559Se9YNTuIkycvTzL
	+5+qJeoyLhCSJAlZtw1xYnG/6SEXRCY8eRqBsEhTWmMBVsw2sSlnfN6/xG5h8hwRqpVpxj
	8yDryRJ4ZN0XiKsxZN+JLPXZHIMt3aMohmwwRdEkZyWMfdHgj5vd1FkGAV2OFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tsW3wVlon4ERSjet09JJR5/3Cm1k+iS1hqefXYiC/xo=;
	b=xjUMbmyUlIOm2m3qlnOwuchjkXHYEbJx31MC6ZBi7/jd86sn8UA+iNGd4OZNLLnVX+KsAu
	pSLhJZW1wt/28WCg==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 0/9] preempt: Add a generic function to return the preemption string.
Date: Fri, 14 Mar 2025 17:08:01 +0100
Message-ID: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The individual architectures often add the preemption model to the begin
of the backtrace. This is the case on X86 or ARM64 for the "die" case
but not for regular warning. With the addition of DYNAMIC_PREEMPT for
PREEMPT_RT we end up with CONFIG_PREEMPT and CONFIG_PREEMPT_RT set
simultaneously. That means that everyone who tried to add that piece of
information gets it wrong for PREEMPT_RT because PREEMPT is checked
first.

This series adds a generic helper which is used by
dump_stack_print_info() and other architectures which don't use the
function and provide this information on their own.

I collected ACKs for all architectures but x86.

v3=E2=80=A6v4 https://lore.kernel.org/all/20250212134115.2583667-1-bigeasy@=
linutronix.de/
  - repost

v2=E2=80=A6v3 https://lore.kernel.org/all/20250203141632.440554-1-bigeasy@l=
inutronix.de/
  - powerpc/ s390 and xtensa had the preemption string twice. Removed
    from the arch code.
  - Keeping the same printk() invocation, avoiding adding any level.
  - #1 has now a table showing which strings are possible.

RFC=E2=80=A6v2 https://lore.kernel.org/all/20241206113431.Q-VXMlru@linutron=
ix.de/
  - Split into individual patches.
  - Implement preempt_model_str() based on feedback by Peter Zijlstra
    and Steven Rostedt.

Sebastian Andrzej Siewior (9):
  sched: Add a generic function to return the preemption string.
  lib/dump_stack: Use preempt_model_str().
  arm: Rely on generic printing of preemption model.
  arm64: Rely on generic printing of preemption model.
  powerpc: Rely on generic printing of preemption model.
  s390: Rely on generic printing of preemption model.
  x86: Rely on generic printing of preemption model.
  xtensa: Rely on generic printing of preemption model.
  tracing: Use preempt_model_str().

 arch/arm/kernel/traps.c      | 11 ++-------
 arch/arm64/kernel/traps.c    | 10 +-------
 arch/powerpc/kernel/traps.c  |  3 +--
 arch/s390/kernel/dumpstack.c |  7 +-----
 arch/x86/kernel/dumpstack.c  |  9 ++-----
 arch/xtensa/kernel/traps.c   |  6 +----
 include/linux/preempt.h      |  2 ++
 kernel/sched/core.c          | 47 ++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c         | 10 +++++---
 kernel/sched/sched.h         |  1 +
 kernel/trace/trace.c         |  7 +-----
 lib/dump_stack.c             |  4 +--
 12 files changed, 67 insertions(+), 50 deletions(-)

--=20
2.47.2

