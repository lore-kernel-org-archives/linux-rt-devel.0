Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83654202F7B
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968499; cv=none; b=j5a/61B3pSai1QiT/FN8jGjrSuQgBTHnGuoY1LvoZiLp1eE5Chqo8cEVjapj6IGKBGU+eTcDgAuTtlAaedxw4HdQyiUgN32QcYq1psp6nrwO4n/widnOYG0Ne6C2uhYptYIpRNLlk2qDDSkTIRpDqIOqVYssR7frJY9VX+2gEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968499; c=relaxed/simple;
	bh=hMEsLsglNs4AwkHsJbHuF/7QRbxSiICOISHMO54ovQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=au8B9FJzS41L9YhKHAEiZESd6KHLtZsPQjnDZyoK62dVPFbNy9gyBiDe6q7mcn74ThAXjCgh4tzxoZvBylqcNIhJcAcwR1RlQqaRCwVCRYwn4elLCY/lqVSmdKZ4CZfClalnXMj6S2ue6Q4LxqQZFgOKg1fmo0QJUutGvHKW8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CRDy1lqA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A/TyYnpx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CRDy1lqA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A/TyYnpx"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUmCwmW08CUlGez91ObC9mBwhMIwUpRmBhCO7ubM414=;
	b=CRDy1lqAGtDW+JG/zhQo2hI2v/UAgh3ORFOgjKP45KwnFP1rT49KzKY/J3crWLpN4yHLxU
	BTL5F51HQCU7M1YMo9VuWVy5wyJ72MCnfio7/olA/BBM7p65uJ4IUQHDS8d5maX3ck5JgY
	iVw49MwhAUb2LGq4x5SSThekSLuCUk6Gkqh0/C5l+3ohrpt5ejZU9X8THoEg+YwBosqnx8
	1Yj5ntUWibetqA30qK3Nc3248MmUnBqV+BuoZUg4q4Pw81kMJLMbJHEqTffkWlIM7qwFWX
	j9R7xLusIUUW0QBYwho1ZhCvAynOc7YEEF2nW2hhMjKbqYC1MFGXVG6fto4l+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUmCwmW08CUlGez91ObC9mBwhMIwUpRmBhCO7ubM414=;
	b=A/TyYnpxt9kTOXU5xGGtNrsvn3uyfHMkD6NKJsuf0LNWc4Kb0oD+2I0R0xphQWcIqym4xU
	XdUUWguOXGWBp0BQ==
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
Subject: [PATCH v4 4/9] arm64: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:05 +0100
Message-ID: <20250314160810.2373416-5-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

