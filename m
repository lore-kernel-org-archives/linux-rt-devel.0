Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80346202F6D
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968499; cv=none; b=tj2gkucLJd6TfnlIBdPaJ6R/SbvFTD65xN876oOFKu2MhQS2B4nxkcGpXUe1ItIXL/oSLH1qwSwpS8xiTwFvz46soBWwFIxcmOV0WPlxbidHar/HYc4R+Zy/1OSjyl+2S7HYN9UQtmVHzZCicCtMWWbfhoXg2DBtML6x7eCZNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968499; c=relaxed/simple;
	bh=a0AJDJcPWIKouQji85jmkMjuukyKxWnxESN2VAr9aPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jC3BwqfGI6u6xBT7s5RkXNnjVi/2mH6NFzbknQxwLuCq+WUC9g2jWRui+cvtj//3dX+lkp52czMrpzTMbXa3T9R9ls/ZDJFZXHWN4S/uFDCde4/IdAGV38VlaMj/HzQ5Lk5bbLhukDIFzeW+mJ9rgvQTN0sGLEXBdcDofT4a/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aMFZNY90; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=85Z5yYFK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMFZNY90";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="85Z5yYFK"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrwuML1z2twiI5Q1nEGmeclGfRZJCdzNfx8loT/6B/0=;
	b=aMFZNY90Z0dXVUWrnA1h5MtmXPZonTKvrxZ26VS6PzBDzM3GopweafZyKULHQUFXVJrwm9
	BSq6p46jeOijyzXP2X11epJ+bymVgF/Qzr6f8s0GlO9ZZmkRDz9s78Hpf9xTeh2LNe2Mkz
	qSP20ur7M9+oq/4dhmc9xPHCJG81LFORMD+4IJ5wcjF9JNiHlD65RfGTfoYJycDIvLjvpp
	HGdO6tu5RrtSb0QJLyAnFFTSFuHKLnSh7jupe8aAoJch12azCn847CU9kU/OKMvQwaGarQ
	hdsvD8G3BpycSfQr3sftwWQN9NL/AJXp9Xb4HdxM/d26+R2jYYmaJURljyP/HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrwuML1z2twiI5Q1nEGmeclGfRZJCdzNfx8loT/6B/0=;
	b=85Z5yYFKpXEcc7cTMq9arCtQDW4e2BjP5BL83TyQES2bWnCHqGaFuImRqDpM+corO94Gee
	v07KEql9v+Wd25Bg==
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
	linux-arm-kernel@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v4 3/9] arm: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:04 +0100
Message-ID: <20250314160810.2373416-4-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
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

Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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

