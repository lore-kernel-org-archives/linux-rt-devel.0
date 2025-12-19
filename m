Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73B302151;
	Fri, 19 Dec 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139310; cv=none; b=Es7MIldhc8NlArF4Bf68kvjPR2zrtXacQEJ7SQ8oBqn9HpIQWp22R568T3pCWRTEPc6DYmC5yQBu3t9dbmqSZpoYMyO2jhTFoc0ik8AdTnl/Qk+MgkrQVUEt14m3BhcmjVC1TzMz3Mg3+eL4Y8rADc+LcfKKqvVIowEVbv8lEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139310; c=relaxed/simple;
	bh=NdvxgAOxvtvVXI2hQU2xpfhkvBpSxGr1NHyfAnyj+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T96uEs191r8YNAfH13z8aBBDmjD22ojtbj9uCLH9m6kukNwlH9hv082Y6AyvETetSOGUff/hD/2dBjk+DZajTPzyN6qkWMZipGP7QDrsP27J/2RmCZKozTPRkwZZ0Dscr8hieqA3Ujt3DZ4L73jwJsIK+Wtpv8T+MUwJSYVpi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KtVBGFxW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KtVBGFxW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZpeSAWnRsos3mLWNkc2ncGSgCq8jhjODaJi3pbhYixY=; b=KtVBGFxWXczPlRgx2S0XvX77Gs
	GaRL0GxOeejKvpt4W2O8IGywTrpnO/GeHzXxUBH6cwQ788x3a8jaVJc9W9zHv78NKPE97ieaI1Btv
	HmyvfnIpZ1huRoB5/5BylI4fJJElbbXlsZmHgAeJOE5ZlpbX41otpH9fk7E8RCMvrIYmkVGg96z6C
	ZZfoVDNwVcfw6kkd29eJZgd05z0X/tllZmEcsAvu5VhQcGSwaVr5UfsvOz4rR7XSFEGwatCmuv6j4
	qF9YtLvi0KW71SGS6bunM2FXhAZ0DTRAQEmWv47tiDIsNrEiXDPFBvvbfx+UCyvpiMNjDyTHLpKHN
	YxOYJkvg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWXVn-00000007Q3y-0o4w;
	Fri, 19 Dec 2025 10:15:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B6AB30057C; Fri, 19 Dec 2025 11:15:02 +0100 (CET)
Date: Fri, 19 Dec 2025 11:15:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


[ with 6.18 being an LTS release, it might be a good time for this ]

The introduction of PREEMPT_LAZY was for multiple reasons:

  - PREEMPT_RT suffered from over-scheduling, hurting performance compared to
    !PREEMPT_RT.

  - the introduction of (more) features that rely on preemption; like
    folio_zero_user() which can do large memset() without preemption checks.

    (Xen already had a horrible hack to deal with long running hypercalls)

  - the endless and uncontrolled sprinkling of cond_resched() -- mostly cargo
    cult or in response to poor to replicate workloads.

By moving to a model that is fundamentally preemptable these things become
manageable and avoid needing to introduce more horrible hacks.

Since this is a requirement; limit PREEMPT_NONE to architectures that do not
support preemption at all. Further limit PREEMPT_VOLUNTARY to those
architectures that do not yet have PREEMPT_LAZY support (with the eventual goal
to make this the empty set and completely remove voluntary preemption and
cond_resched() -- notably VOLUNTARY is already limited to !ARCH_NO_PREEMPT.)

This leaves up-to-date architectures (arm64, loongarch, powerpc, riscv, s390,
x86) with only two preemption models: full and lazy (like PREEMPT_RT).

While Lazy has been the recommended setting for a while, not all distributions
have managed to make the switch yet. Force things along. Keep the patch minimal
in case of hard to address regressions that might pop up.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Kconfig.preempt |    3 +++
 kernel/sched/core.c    |    2 +-
 kernel/sched/debug.c   |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -16,11 +16,13 @@ config ARCH_HAS_PREEMPT_LAZY
 
 choice
 	prompt "Preemption Model"
+	default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
 	default PREEMPT_NONE
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
 	depends on !PREEMPT_RT
+	depends on ARCH_NO_PREEMPT
 	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
@@ -35,6 +37,7 @@ config PREEMPT_NONE
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
+	depends on !ARCH_HAS_PREEMPT_LAZY
 	depends on !ARCH_NO_PREEMPT
 	depends on !PREEMPT_RT
 	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7553,7 +7553,7 @@ int preempt_dynamic_mode = preempt_dynam
 
 int sched_dynamic_mode(const char *str)
 {
-# ifndef CONFIG_PREEMPT_RT
+# if !(defined(CONFIG_PREEMPT_RT) || defined(CONFIG_ARCH_HAS_PREEMPT_LAZY))
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
 
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -243,7 +243,7 @@ static ssize_t sched_dynamic_write(struc
 
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
+	int i = (IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY)) * 2;
 	int j;
 
 	/* Count entries in NULL terminated preempt_modes */
