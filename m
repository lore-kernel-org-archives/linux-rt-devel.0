Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD12045A5
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592208; cv=none; b=YqNqUzGtdD5hEpW26qrBn39se4mxcRLNBcfHTcZb9hY4Yenf6xTaAd9k1w8u1hoIuhJpnzUBDtClUcG89mBDN6vGPp0dxjXGAa5RWv/V7z6cw6BcM84QcJGdqig6eiGTBaMqdtKXsTnrXyzbhFRWm0g+OdgibrQmPE6fB1NnnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592208; c=relaxed/simple;
	bh=s6LR4cD4L+E9V3LOC+CayprvaMN8VoutnxDA+SpvIeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck2d4H+UFdnRp804f/1pnff0yknSzN8PYbBiusnjVI6hPqcVAnnOFuL/9tAa77UiV5aWSVaPexv4LNz9Qc4ORFuJpcCg4znqUrbWyEyoZE4ej6gnPrls40s/IXeU8ClwzoZfwFCamr1hGIxv65ZTO+ELSl6t7rI/r+pIIzu7c3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qolkE9Wo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCGcyddB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qolkE9Wo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCGcyddB"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ulFTvDAefqAdJc6TUbpR3GW4CR8A3NjhobBVG3Dsg=;
	b=qolkE9Wo1YEPfFcnO64QkD+SJyUvuAh/21nheTEdSJz1Aqc1+H7HDJ1/LwAbmD6R3kT0fz
	NSuJbmEnfOYwxmy2MOga9jbOkPg39EBpryO5d7HZCnTx6KJteeY2Kw2LowkhkQ6MqkiSTP
	zAYkVC1JQGc+E7kFBIZ5Y6m6ZV12pK85U84MyvsSy9tbf4+HIJGmaVqfeFIAgroW9iLDdT
	ffDETyunDXAHTDDyeqxVsYv5WBFNntOuzId4ftexMqb6O8cOXLuskiEqpUm3d1t/lOuWzB
	PdgAFi1PTvF1xEi7HHC4Z+DIHL8ze/fRiv6bKwQMac6LpdJM0xVZZM9xhwhYsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ulFTvDAefqAdJc6TUbpR3GW4CR8A3NjhobBVG3Dsg=;
	b=XCGcyddBg5I1tIU9Y/XRDUleszWy0XkjidrAz2iNusl1veVDgUwbxRAj5j58BW479NuOAZ
	lqraoF4mk2MWsSCg==
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
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/9] arm: Rely on generic printing of preemption model.
Date: Mon,  3 Feb 2025 15:16:26 +0100
Message-ID: <20250203141632.440554-4-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__die() invokes later __show_regs() -> show_regs_print_info() which
prints the current preemption model.
Remove it from the initial line.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/traps.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6ea645939573f..afbd2ebe5c39d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -258,13 +258,6 @@ void show_stack(struct task_struct *tsk, unsigned long=
 *sp, const char *loglvl)
 	barrier();
 }
=20
-#ifdef CONFIG_PREEMPT
-#define S_PREEMPT " PREEMPT"
-#elif defined(CONFIG_PREEMPT_RT)
-#define S_PREEMPT " PREEMPT_RT"
-#else
-#define S_PREEMPT ""
-#endif
 #ifdef CONFIG_SMP
 #define S_SMP " SMP"
 #else
@@ -282,8 +275,8 @@ static int __die(const char *str, int err, struct pt_re=
gs *regs)
 	static int die_counter;
 	int ret;
=20
-	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
-	         str, err, ++die_counter);
+	pr_emerg("Internal error: %s: %x [#%d]" S_SMP S_ISA "\n",
+		 str, err, ++die_counter);
=20
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret =3D notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV=
);
--=20
2.47.2

