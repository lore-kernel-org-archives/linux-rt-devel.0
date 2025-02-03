Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B942063F9
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592212; cv=none; b=PSFnE0UATQ7QXj1PfaYHK82yJ+pSVjG9YwoVUszgPtVp9omrMXNnbLdi6VF7rCeHe2lUv+p90CzQRyxn1fMDLCmGBGlOvVfZ6RZ3ZbxI2UkKLKSUpGUtMqF1nr8B4gmxwUsutG7C0K1l4fs2/bd8uke5vBNdRJplEGFHLb3BZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592212; c=relaxed/simple;
	bh=mR6vPOjdkBTEdRSlAl2s/rFalP/2IlJiRUYhKvRs1Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUrJShR7yofPnxRsGH9r+Ed8+ikMhVmACf/9glpspTA5c4KmoD8TTOvNUuBLA/N4NPldy5rNi7hzy3T/yeZP4vfhx86zZaaullkHZ0aq4eG641d4mEDeDgmUo3GC5feCJMQngUTkiV05kczuqw5JBGF05IY3nTXUTk5bci0t6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fa2pGKEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ggrNndh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fa2pGKEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ggrNndh"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0V5ulaONnLToG07tiQ1kzrRUASrctk1BlR8nwnpSIU=;
	b=fa2pGKEzmwGixw0PPg9eEw1rs7GM/afNRYkoYQMeft0a4FBTh8ofpR751iqqQBlV8EJSDL
	FMhnnHlF5Utbdv3j+OYsl4pWxENAGL06nsg0SpnEhoYiI84T7hEkMP3AdPVadU3NCvK/vA
	lCf2FbWI+RbyRR9lgk8VpgnvVgo2sC7HTKZh7VyGzD3PUF+YzSNBZXAdxdVIKwKdZC4l2U
	DCFrlXlxWfzYcCqneUCloNdXLW+UmhPJ1kbYJBC/+aliOykZL4EGARtsibtfpFGJB6kFFG
	tZLe94y1THHStfqoptnOCTtzqY0/KagL0OvAysrMEIph8CCMGdnTl2bAKFKWuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0V5ulaONnLToG07tiQ1kzrRUASrctk1BlR8nwnpSIU=;
	b=2ggrNndhlZgjqGyOaTjuqRZKvC5AXFzUlrEvERzBH0iQrlO8Ag2yQhE9FDQysMJLYhAQfx
	o7YQcDjrkYlr8hBw==
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
Subject: [PATCH v2 8/9] xtensa: Use preempt_model_str().
Date: Mon,  3 Feb 2025 15:16:31 +0100
Message-ID: <20250203141632.440554-9-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use preempt_model_str() instead of manually conducting the preemption
model.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/xtensa/kernel/traps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 38092d21acf8e..a7b1e4ad112e8 100644
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
+	pr_info("%s: sig: %ld [#%d] %s\n", str, err, ++die_counter, preempt_model=
_str());
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long *)regs->areg[1], KERN_INFO);
--=20
2.47.2

