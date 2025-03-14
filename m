Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F821202F9E
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968501; cv=none; b=Kwl9Nzy0Zq8lc1wj+jUNUmnGhhd67YSOvesvNs6vq0DHDPN//XClWTIRtUPsl0Z94vu8TjwdZSVgwte3tGOhE/Mc8CfA6rcdfRJY09s3nF5gaIVu0NGx3kDe4YVIeGAW/DzOWKjrP3BnZZSMWGIz2citb5J62B6037gdLHO9km4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968501; c=relaxed/simple;
	bh=oQzX+7nGoxhkL+yQVBL7r8HDvb37Hr/zFK9BLTl9xrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPN3CTLsHZtOhqhIvCo73R5CfvvAwRMnQt7TmdU5Ms8L5b7X+wuk18G7CX3MH5gvboAidYnEu+U5pTu+DjOjUGJXlIaflM1G/kNBz+ID0l3au87zSV4s/yGlaygTzw5Hb4B/uAZdU1ezBD2VP5+d2H+xd2Gv/FGfaO8dsyvuut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUvGicU9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKlii9JD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUvGicU9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKlii9JD"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UThOL2xYE+zlzWKKbLr4gFZbbNJ4JtHESm/nz/q22I=;
	b=oUvGicU9EzvDhQw6mwbX6KaWnwK85wGS1FqPabwF0NiVNPAIGHBx6LELfdu02mi4glujPm
	eolrnSGgQ7aoFzpdUkQwS/VN7Z25xOGvggToNLYhR4YEbuA79BU1D6PJmqtvGRmQFVIQ4e
	LKc6i51kdpZoP7fAFIAVgUFuP3VWMPZNe+kYoW+wgNifmq+7kYeS/QrCTEQpoEiilZ+f68
	QEW3WPnuOpiZRyh2NDsyzdZkWTyOmlUTXwr6cgEBqNEDeYV80+HVhajnFj4dZJTcZoNqX1
	DTsK2A1xouiZfunNcBz5zevTeJ9P3GY+g7sgstTKzqY8P8plPZurQeeQC1Sw9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UThOL2xYE+zlzWKKbLr4gFZbbNJ4JtHESm/nz/q22I=;
	b=BKlii9JDzCL1dJehRa3nId7N9nVNEeOzD6QG3T8tFCBuRpP4qdEZBdFXR1kby22VnhG37q
	NXHPULtxuG4UCeBQ==
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
Subject: [PATCH v4 5/9] powerpc: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:06 +0100
Message-ID: <20250314160810.2373416-6-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the first printk in __die() there is show_regs() ->
show_regs_print_info() which prints the current
preemption model.

Remove the preempion model from the arch code.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfdb..cb8e9357383e9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,9 @@ static int __die(const char *str, struct pt_regs *regs=
, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
=20
-	printk("%s PAGE_SIZE=3D%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=3D%luK%s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=3D" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
--=20
2.47.2

