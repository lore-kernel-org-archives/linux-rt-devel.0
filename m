Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FF2063E1
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592210; cv=none; b=mkaflc/2tw4G9IF5DTBcowlNToDSnbbs2VW6QV8u4HJlEDggni0gf0jS7WWeaA7y85lNsN40aOxaIrCL7PEa8jYMyIHZxJatrEJhI8z58Ly7ctrUNw0KP+U+Cqdc5aeBMJCI3Dda9bagxKzI65vs/1txjCjef5XidSGzJJH4NIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592210; c=relaxed/simple;
	bh=PWKlchBpJd+N+9kqbMPU2hjG360lbQg1ywkcW+Pb9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXpG839Z/cG4gna9r9CuvfL2kYrZchMMrUt+7pb3GDir0ucKqtNPUWAuqvNeLRDCtCTOdyDNTFc+3Vc3duKaWhWcCCGnHWYRUhZ6HGaQ+DQieZaak/vWnF8gbpA9ZBSGOhSm9isSnRRNwfSR7g3G3OJPrwo0/hmCZQa6uo4HnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YqqVGci0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXIsAuM9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YqqVGci0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXIsAuM9"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbMY7jhAkRshWc9tky24ybr6eQCno2dqBNRHKZaouzc=;
	b=YqqVGci0vNuMDu6dryL1TFq2lf6DnnkuJpqGzKYrMSQ5amO/4iEeohSKC2vVER14hKJfuZ
	XTqxGHdPWTeo5Q0oRyPwZGdK+kA9R7P8Mbfajh1vZ2tfNQrrftyuOFDYVbhtQjLvfYNpnM
	0oGSfeqx/QWXjKufXvXOMl/c2/vUfV7rRUQQxJTzYnguz9lnTGUV1VaQU+N430o11YAz82
	ltanqOdynmh+l8MjZtKSrgWqjYggVYwcgL6JDYmzjxd7pD5/zpA4ZXPA3zDFJp0Lu9aj+r
	nYe50d3btYwB0jzZUU9M+agqLh9hIKeDCAnu0MQEce/DpgKVwCmRhbU76OV8rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbMY7jhAkRshWc9tky24ybr6eQCno2dqBNRHKZaouzc=;
	b=WXIsAuM9UBBOBK8XE8F/E+Of6tdfOZdRK0oMxBxhwbhH9JVP2wEr0ek72jL5VC5ufclzd5
	2OPzuhrMQGTgPuCg==
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
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/9] powerpc: Use preempt_model_str().
Date: Mon,  3 Feb 2025 15:16:28 +0100
Message-ID: <20250203141632.440554-6-bigeasy@linutronix.de>
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
model. Use pr_emerg() instead of printk() to pass a loglevel.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfdb..9eb383189cfb2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,10 @@ static int __die(const char *str, struct pt_regs *reg=
s, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
=20
-	printk("%s PAGE_SIZE=3D%luK%s%s%s%s%s%s %s\n",
+	pr_emerg("%s PAGE_SIZE=3D%luK%s %s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       preempt_model_str(),
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=3D" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
--=20
2.47.2

