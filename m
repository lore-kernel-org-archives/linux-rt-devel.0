Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362020D4EB
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367695; cv=none; b=qjQSEphFOFECP+acncv00k8BeyahbUX/d8Ind0OtVELO6SgRwQHTR5QOz4Ru5ov2LRNaBcfcb6WUTnUIPeyLUl3oNj6gXr4Rt2hoZxLMlz/iT9urh80HYINjDfu+N8tK7EBErdXdF9KZkqICbAZ6qvzJASVuzqLWLrY4abg6CbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367695; c=relaxed/simple;
	bh=rKgqegSfIlddpX7SKg5lyaNHI0agR4d2VjHsNaNOYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP0sB112+8/JdQxybhyjNWCtH9FAeeT6NLf71XknCqPUpu56Tjz/Bj5CBZszuvAwGNKxzsOV6ayiMbtZ/d8rAxi0RKWpQ/5VZ7HgbTgJ/rphXdzNiAJAkROEWLSxaiz6ZH+J2SAcQZrFasuC8hc1yOO+gKO028LxEk1zUt0zDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNDd8HRV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=id4yU61I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNDd8HRV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="id4yU61I"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739367692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPAQGfBR+7S/RdiEr4MvqW7U6iju3OPPUWbdJGl/f2c=;
	b=JNDd8HRVokzNTO33bNqU1bUc/i1QR+DFcOEm3uhqyR48gbfX2iGQGW9FzaSr95pJQceVD2
	yzacZMQ1BdLBqJJi+Jza6UXaeQvnJdCZymPHT/39oERnv9ppPlm7OjfFM1P24y2KqYs3Sx
	IR5sAZeWoZI7Umj3eR5I3ejOcmC0W3SBzeTnBoiGu84WcuVP15sD1Eb3wt15aRLzAjtnmw
	itjMbYTTZEeebtSCgpC8J4u3gDCUHqYV6t8nj5nIHilxxP2VJ7A4/I2nu/92hjxcg1QwuN
	LkBjE3v/ZShiJH+We+mUNXGlVfsOIe123PNnxr0qOhkCgzDebGIs1sLBcOPlAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739367692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPAQGfBR+7S/RdiEr4MvqW7U6iju3OPPUWbdJGl/f2c=;
	b=id4yU61IgYf/Oi5G8elGNQM8xDxXQjxw46D1/+eX3o02qLQVUBdAHmF5WFkn1lNNRPPbn8
	cdCeIaDSso0k4KAg==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/9] arm64: Rely on generic printing of preemption model.
Date: Wed, 12 Feb 2025 14:41:10 +0100
Message-ID: <20250212134115.2583667-5-bigeasy@linutronix.de>
In-Reply-To: <20250212134115.2583667-1-bigeasy@linutronix.de>
References: <20250212134115.2583667-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__die() invokes later show_regs() -> show_regs_print_info() which prints
the current preemption model.
Remove it from the initial line.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/kernel/traps.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4e26bd356a482..529cff825531c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -172,14 +172,6 @@ static void dump_kernel_instr(const char *lvl, struct =
pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
=20
-#ifdef CONFIG_PREEMPT
-#define S_PREEMPT " PREEMPT"
-#elif defined(CONFIG_PREEMPT_RT)
-#define S_PREEMPT " PREEMPT_RT"
-#else
-#define S_PREEMPT ""
-#endif
-
 #define S_SMP " SMP"
=20
 static int __die(const char *str, long err, struct pt_regs *regs)
@@ -187,7 +179,7 @@ static int __die(const char *str, long err, struct pt_r=
egs *regs)
 	static int die_counter;
 	int ret;
=20
-	pr_emerg("Internal error: %s: %016lx [#%d]" S_PREEMPT S_SMP "\n",
+	pr_emerg("Internal error: %s: %016lx [#%d] " S_SMP "\n",
 		 str, err, ++die_counter);
=20
 	/* trap and error numbers are mostly meaningless on ARM */
--=20
2.47.2

