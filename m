Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A86204597
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592208; cv=none; b=UTXrJNaq5r3NlfP785GPK0Ii4l8mrZp+2z1eZO3y8vXSRhMNbdDkogpkbc0wguudNMmOpdLZSiDC2D+tLIaGSVE5DesnG5a+p8mqxgJ76CxURgL6Cu6QsL4C1/H5cu71hBRQ1dAnCCX3HjQAeIWNimlREsE8zzamGaLWpPdkD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592208; c=relaxed/simple;
	bh=ra2thAmU8ozH0ETw5KywNHj7GHiO9m0XjN0qzhTk/sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8uObDItJBLa8v9esbGrhWMvvLDRtOZYv6EE/QSfJbZDdWanCVYvpj3vfLWsfgO1US9qWNxT6dtZ4izgPbSR7w2Xx4QWOP6J66VcRxWk77axi25Of4iLkoJVbInESIFlWecEVg7mK4ApQVnwWFejS6Wbz6X88eoRzJNhD6Ep2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LF3l01ac; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iC4/nQxu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LF3l01ac";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iC4/nQxu"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V13yIzrzFM11r3zZVa4A30yIhnkQb3enn/TKqKVG4ak=;
	b=LF3l01ac2jy7YDc+QsiD+O8T3fpumEfH79CHIM+tyyWq9Jqn8mUe9Y4kj75D9oCluP0FOv
	Ev6FVaNoKLMvAFIUppvBNjeo5b1gQjM0LM/w8DRVA5SXvoiCXZxExO7tEoJygFDHT0VOVk
	tHC/TUcEctVcNISjcQdYGUdr58NoG4aT2y/yqLl4tCHKmSf7OY7TKePuGhvx3a0/02VVjt
	zQNiDBMCeJApX+VCI34Zg+66/ab1/kRQ3g2YE1LvcPgJz1yIupONAMAh8Q/ZtJi5tR2Www
	ou+O4drjAGczJVpvCI5WI9s62+WuIf/2YW13tGHXXvF+S0aZe268A34RUNQcFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V13yIzrzFM11r3zZVa4A30yIhnkQb3enn/TKqKVG4ak=;
	b=iC4/nQxuXkp6ffIi9ljHP8b1U4bQvbWxiMmAGkIUNMxGIyb4IJUaOhfDdR0Z0qYHXsA0k1
	dB4ofBg7whIYbdBQ==
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
Subject: [PATCH v2 2/9] lib/dump_stack: Use preempt_model_str().
Date: Mon,  3 Feb 2025 15:16:25 +0100
Message-ID: <20250203141632.440554-3-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
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
index 388da1aea14a5..425556f3fd018 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -54,7 +54,7 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT =
"\n",
+	pr_warn("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s " BUILD_ID=
_FMT "\n",
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

