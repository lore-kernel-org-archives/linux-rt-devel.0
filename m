Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3C2063F5
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592211; cv=none; b=Kduw7fkDQ6TWkB5D4x0p9+aUsf1zmC0MskJdvOlgYoTZgChVdYRmlX3CtsYzVvoFUW5yWVQOoTdKAGYptmmWew9sgORVGtVemkrDRHQDGn7mrajs4dWuUxTulhQFa3Ym08jPSWlhLKFD5Om1k07BBNylZ+FSUkbbldSJxqtnHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592211; c=relaxed/simple;
	bh=hK1A6zIsrNJAovrrv0VlTMANs2MhQLrSeZf+N+Ilra4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNtLSkHzY0nQfHqE8zMir5RnK8wO9YvXdN6++ocKBwnoYwNrVBFFZ0Kil9mCCTMt2JJBe8qZAqBxWt0OrMDy6G6Y3mbKgvbuuYuS9TyH949pkBNSJDkdX15DJjBI9breZoTNexc2j1R1HL/MFARDiQHPtaguqLxCUhyr0s105Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUUGvDyB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCJLKVB0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUUGvDyB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCJLKVB0"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1nmWywTWzJzDcPVwkzbvEHu1zvcPiY8k6qmYTOWby8=;
	b=iUUGvDyBJrA7c57inT21YOu8ZGBfhpvN2ZPc1wUQ0LZ7j1MwniZpFBN897AY4tBwcAKxp4
	lpcdrzhQhjp4MUj4IK4PLHPVysC9yb465Cb1FET+G6AYqVAoFfT+1M8o+JvoLeKNLIQfkD
	wjZDn/A0rA1rEwLs4PZI/i4DP7MsfwwY6NkDQcGUrHX4RWkUYuO8pbmrOMDU0uT4iplxlf
	1A1NbwajnOE9NN0vXctsatvQowPETzmaUj4tVlqNlhPalfBNBJz0tXFKAtUsefjzJiD3EJ
	Lx+JTiTYdikNn34kOZLspQLmhY/oFoH63eKQuSyHAXctrpVDt4MN+eaMwAzDNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1nmWywTWzJzDcPVwkzbvEHu1zvcPiY8k6qmYTOWby8=;
	b=DCJLKVB0wS/pJHnxQ7GqNHr4u3FHrpkpY1Dd5QrouEPyu6obnl3lePm4ISH+pJTsoJisem
	cZrzw0HN+s4qktCQ==
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 7/9] x86: Rely on generic printing of preemption model.
Date: Mon,  3 Feb 2025 15:16:30 +0100
Message-ID: <20250203141632.440554-8-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After __die_header(), __die_body() is always invoked. There we have
show_regs() -> show_regs_print_info() which prints the current
preemption model.
Remove it from the initial line.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/dumpstack.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d562697e50e..91639d1e4ec2c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -395,18 +395,13 @@ NOKPROBE_SYMBOL(oops_end);
=20
 static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
-	const char *pr =3D "";
-
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
 		exec_summary_regs =3D *regs;
=20
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
-
 	printk(KERN_DEFAULT
-	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
-	       ++die_counter, pr,
+	       "Oops: %s: %04lx [#%d]%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
--=20
2.47.2

