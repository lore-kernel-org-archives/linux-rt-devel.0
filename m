Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC440205E23
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592209; cv=none; b=Xh/QwpoUebZomR/YhbivNJ5l1uxhS1Z9imTXpzon9vNFoQGehuWje/KEyNIOGHQmUn73JjTUZa3Ap7EbhkXZ5Nm0CO1xJEnsvCDO2aG3bdIk+t4XXB2zBCvolwTPUX/enr3Nfy4086w9+z3sWAwuq3daRAeYw7JQg0x5O/QsOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592209; c=relaxed/simple;
	bh=aPpGpeN3KUlxNzmqdawwj6IhMjaxo0gfAhNIUX/rqqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIdeGjfrhu0WtNWIVGYkCIxSaFPP0eheNqqVYP6/fCeJgx3i2uiPyzbnfhUcvuvzG7Z7SevnHcBlyZA6BvCyjiD3BhmK0+OXYgN1fSvGyXk6ZNJGS6B2WLFXbDfyv5NnGYjwnvLoK294/zPsZxGOR6TG3cwEPFqUTRu/oXR7csU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAAvsyVf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qQjoimea; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAAvsyVf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qQjoimea"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVykWfPj6hH80UBabvF2jVot4ICLdWiycKbgvtjRQrc=;
	b=OAAvsyVfJIXCTDV0jlmbfBRVNnFAHe2s/axWez929gL0/1SFj9CCtWFrIBDxrHVhLSdYt6
	fehMewweBdKqQrNTtqxuFAxGTa/EkHsWHrhIrsdfPP45R7Pgar0l2Tbx55CpVGtff4IjeY
	W55Ri92Fzj9mYUxW0WisFiJFO5anm/O6fakD3WdKbKg7EpuRWnr2W2zWp6YAxQT4Wzl5NI
	a8V5LZIFkVcvX+24mPhx0Xgo9r85e8rCmmu9gkDiGL2kjPRA0+IMX+h1tLJ38tTSu/FRBl
	3GFzrE+teMc8I/5iXnPIHH0BGy1aTzTw0V3+qAooJDXuDepXwDmlUZUXRQMQ9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVykWfPj6hH80UBabvF2jVot4ICLdWiycKbgvtjRQrc=;
	b=qQjoimeaG99ho0DbphIIPeIOyoN5S4z/BmH9EKPnuytCz1jWmC+iyLEcDyhSKbNEWQwAuB
	4pOonPeDJP1YFxAQ==
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
Subject: [PATCH v2 4/9] arm64: Rely on generic printing of preemption model.
Date: Mon,  3 Feb 2025 15:16:27 +0100
Message-ID: <20250203141632.440554-5-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
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

