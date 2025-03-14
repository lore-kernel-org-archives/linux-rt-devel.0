Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F143204599
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968501; cv=none; b=i20xnGBrVzlIbPev5BxIJIRrjyaZ4Y+JpEIOCgrd46J7gSPOnupSmGXpoVWt8yuJBAyCCM5UdhmMCGf+Yz7TqDbssYCQM7Xs1QSVbQFK7E7/bWi219DqMXwSqI3ekTaOLqis7+/6o27bhUf5QDJhEbTRE4TMsXBLRA2XoGQhBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968501; c=relaxed/simple;
	bh=7JqJh5zD1TYrinJPilLtjUURzbqKPfNMZVxThprtkeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/sl5dridXbg1g4uP9Y9HlLKOhhKSkbi2cD40oc0vt50ZmCCoFuEm/7yZrcXJGqG96hebCXuoiXH/Qg/f958F6ZYOl0RCnSgP8+CxHh6Cs4kGfr/bFNPoQfacfIFVF+euvGWStPJwDOv2HudxWsHljsfNK77XkvMncJ7DbV+tx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pk+dzClr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOYYBZu8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pk+dzClr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOYYBZu8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S38qgxTEFuAeFPS21MPXcaa84mVOzB3Jka/wNMKS3a4=;
	b=Pk+dzClrzxJE42C28fzXXvDRwNXQPBk5cNcqdk2/t+S5CUEIES5zneJwJnGCA3tq0fNXEh
	w5WeGXDJNMM9Ri74qbiAY3gHu59A/6tnEdBb0R8DJXH8Kpy8YOTnFHqxSAhUQpHmjy24ZU
	/PkqUKdbKNEf+P5wVC3kmU1ZLM64ikLJitpIThJv7PEuf9AJnPgJzopapt8peKA+NomY+u
	Xn5Lg0o85F7nczPXMV0w/BoPDwgOzVSK/gtqKRMXAjoyzobp5cl1pIOo5IyJdzyZRmvayy
	ZLoHleS5pdPXU7vXAKEZAmvgie5EXgpnoDuE30g9ln+MSMh1fUI+VPoRAkvU7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S38qgxTEFuAeFPS21MPXcaa84mVOzB3Jka/wNMKS3a4=;
	b=qOYYBZu8fK50EKYNvfS1kwrWww5/LewRzQf0d2EX9r5V5F3Y1YCWToiuyPfsbMwyOY/BFE
	NUlsSlfgVNI3+WBA==
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
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 8/9] xtensa: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:09 +0100
Message-ID: <20250314160810.2373416-9-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

die() invokes later show_regs() -> show_regs_print_info() which prints
the current preemption model.

Remove it from the initial line.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/xtensa/kernel/traps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 38092d21acf8e..44c07c4e0833a 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -629,15 +629,11 @@ DEFINE_SPINLOCK(die_lock);
 void __noreturn die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
-	const char *pr =3D "";
-
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
=20
 	console_verbose();
 	spin_lock_irq(&die_lock);
=20
-	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, pr);
+	pr_info("%s: sig: %ld [#%d]\n", str, err, ++die_counter);
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long *)regs->areg[1], KERN_INFO);
--=20
2.47.2

