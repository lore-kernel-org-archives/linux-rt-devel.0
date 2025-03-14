Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1097202C55
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968498; cv=none; b=n2x0BVFVMmezmyjZ4uDgl+OSqWKGSWG9T5ADmTGKhfoGGFGxFgBQfvuLTiuZTeD5FAJuRG/yvBtQlTX2W9hpHbuVcacIzWF3c9G265DesI6AuqN1noNIhk0ZHLSZUz5/NeKsNLZdkjLOJpGgfLBaZrMd5bTU8nGwuHaB8IPhPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968498; c=relaxed/simple;
	bh=UaCvuTQO6zmkgN4mXHVvrSlB8jTKd6GUp5a/4x9Dsvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVcLQ2h+90qwCKljmUKJRZk9gSV1a3wVEKInFa8AhlJeZmnYwlKurC6EKbzvE2lm8zCvpHww5tTJVu2EovNzKvXCGW1+nGhsfNu8q8tOh5jHC1iufcKvjrpidFBJkeTRYVh9aNMfXPD47EIqcHfL4lEeGigeE8WSzQC9N6RL3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vwl1ocV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcHAPrc3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vwl1ocV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcHAPrc3"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3+PdbzXvKDPzf7DVHIuFNry45mZcOhReYq7bCDi1t4=;
	b=0vwl1ocVzMUPBdnmdzrlUe0+XwPFNfLKRelHK9hpQ9wUHPM1EBONSOb0tkDOeYx2yHsc1X
	ytQ9cW3CBNKKBxkHVEPTX1FcWpz62J0AWpo0z1/pkNR2dxb2HdRqjiL/uKEGaY5RgzahOB
	D/4hWSlzVJMkg4TLuXPa9uhFo/abWnhKELvbSH3qqvAXtmEKb0wN2szRXzf5wkdY9iFimK
	ltsfEIsYSh6qu5MgDIQBNyDJiEBMmO8prR4dIt4DWsFR2K+O2Ek6hrVWV6RwgxJWOoUkqu
	ChoL/eNStKMXCDyOEpZQaPvHbWWq6wLEsF5zYxSxRphZqXwPIOL9/ShIMcyZhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3+PdbzXvKDPzf7DVHIuFNry45mZcOhReYq7bCDi1t4=;
	b=vcHAPrc3/SIkIQLXBRAC4fngHgKvGvxD8a2OKRvAd6xMg0dZJf3m5CdLESBQRgdFCpd4Xv
	+SzFvlkBhGz9T7DA==
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 2/9] lib/dump_stack: Use preempt_model_str().
Date: Fri, 14 Mar 2025 17:08:03 +0100
Message-ID: <20250314160810.2373416-3-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use preempt_model_str() to print the current preemption model. Use
pr_warn() instead of printk() to pass a loglevel. This makes it part of
generic WARN/ BUG traces.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/dump_stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 388da1aea14a5..b3a85fe8b673e 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -54,7 +54,7 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT =
"\n",
+	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s " BUILD_ID_=
FMT "\n",
 	       log_lvl, raw_smp_processor_id(),
 	       __kuid_val(current_real_cred()->euid),
 	       current->pid, current->comm,
@@ -62,7 +62,7 @@ void dump_stack_print_info(const char *log_lvl)
 	       print_tainted(),
 	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version, BUILD_ID_VAL);
+	       init_utsname()->version, preempt_model_str(), BUILD_ID_VAL);
=20
 	if (get_taint())
 		printk("%s%s\n", log_lvl, print_tainted_verbose());
--=20
2.47.2

