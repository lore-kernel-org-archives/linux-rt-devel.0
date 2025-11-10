Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A432FC866
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Nov 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786584; cv=none; b=tD5+zEXRpYCDuC+fnNZtf2AyvC+M/Fffv6v/LWxHma1xJOC8vXX22GetYsu5K2CEzE+pITctMcBwweGceMrbVxU7Au0BuN1Kakjp0HHJM7ByRWNqIXEB1lLqg+KQD+RrrMgBKgK+xXDXV9A9l5s1+MZziHXakvdKRndox6H2T6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786584; c=relaxed/simple;
	bh=g4I27jYg8s3GMX/pqvBi+OU7tYdgZiLviaIfoNhTjXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlLuIGaFo+jKLW0udILDcdbNUYRD8AsckaWh7GwVhq4t+ku5kT/pAvHjml4LCvPD8o473mbUZAOgaZpacWJOcgtjsXJRk/qdIXTxfy4AE+qrIuXPk2tWQK83MRNPsYPpRkB5OBu7Kz0Ko7mTXMId5OYC388lNvzVFphTr0Wu9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=39hbm44w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=62yaiWmn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="39hbm44w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="62yaiWmn"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762786580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynPbA00EHBUjDvPWf7RgfREeAWmSK7c/wyN3Y0W7m1A=;
	b=39hbm44wS0rb4FCBQ3nPVwxyFC/HgpKTY/WGxCL3GtQm0YmCDRmjPNxcB1SX+JK/gTErxV
	prMB8xEGxTfnkaUHpnmba39hNhnqbPLdcbgrCpKrtnhrFeWyGVUF5/ZhlZkv/bXT8eVXQQ
	Fu5Dlxde9CjXjIjMwAK1lAJxJ/KHNI5Sgn0jRQ00WRGED8SRkE7gMh6ammR4hfmIScif7k
	7wWQUYsgcT+lLXsawFUWjv/TGmevjWQlzLPFQbBUwAgsrP52Ol2twF5HrYKAWD4ec7RuXJ
	Td0TWRbBjdGgnJHZAUwFF+/WMhtORA6efvtpdS6pwqqkE+k1Q7GJY8HLiR4CIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762786580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynPbA00EHBUjDvPWf7RgfREeAWmSK7c/wyN3Y0W7m1A=;
	b=62yaiWmndfz0hWiAHf7jnUvbO2g0Q1DDSRtQXrSbCI8VXNQaN6GTl00/QreaPAm+XQFVok
	egnyScVmqbnpipBw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 1/5] ARM: mm: fault: Move harden_branch_predictor() before interrupts are enabled
Date: Mon, 10 Nov 2025 15:55:51 +0100
Message-ID: <20251110145555.2555055-2-bigeasy@linutronix.de>
In-Reply-To: <20251110145555.2555055-1-bigeasy@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the LPAE case, interrupts are enabled early in do_page_fault(). If
the user attempts to access a pointer > TASK_SIZE then is invoked
harden_branch_predictor(). The function will complain that CPU migration
is enabled due to its smp_processor_id() usage.

The intention is invoke harden_branch_predictor() on the CPU which
triggered the page fault. It is only invoked for user access of pointer
> TASK_SIZE. This always generate a fault for the user because this area
is restricted to the kernel.

Move the invocation of harden_branch_predictor() up in the call chain to
the two callers do_bad_area() and do_page_fault().
Invoke it if the user accesses the >=3D TASK_SIZE area.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c0..5d28c28e877c1 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -183,9 +183,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, u=
nsigned int sig,
 {
 	struct task_struct *tsk =3D current;
=20
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {
@@ -218,10 +215,13 @@ void do_bad_area(unsigned long addr, unsigned int fsr=
, struct pt_regs *regs)
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
 	 */
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		if (addr >=3D TASK_SIZE)
+			harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
-	else
+	} else {
 		__do_kernel_fault(mm, addr, fsr, regs);
+	}
 }
=20
 #ifdef CONFIG_MMU
@@ -274,8 +274,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, st=
ruct pt_regs *regs)
=20
=20
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (interrupts_enabled(regs))
+	if (interrupts_enabled(regs)) {
+		if (user_mode(regs) && addr >=3D TASK_SIZE)
+			harden_branch_predictor();
 		local_irq_enable();
+	}
=20
 	/*
 	 * If we're in an interrupt or have no user
--=20
2.51.0

