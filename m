Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF02010FD
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592208; cv=none; b=M1QoJEbwY0ffxQY1da8qIfdqtdPeq/BRovd6pzLsRAqD+Ewa/O4aiWIokfhHX2iEo2xTMAlKsvAS/Hb7O5X4Fte6wqAQ96pdkI/O4TSfr7Y5AzGcloUMoTLGdfscNFCc3DOZFaBr08DNSFuX0TqudgOSr88PF7iIH5YmfiJBq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592208; c=relaxed/simple;
	bh=pSKy/qsT+iXKg2g0H2gT9GJLhdQXpBlufpbUOra+KvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5sp81kVaFPNQTXx5vNwTgJ9P2qydxNzV93pgh2eaAAn1tdD0aM/h4C0qLk575fAyUoBmzWyp/F6HH4g+UBU2oB7qcy63He6xoOzT3Frl/q8gbAjycgDpQld4LKB+AXCQvFWUNdfJAW8GKphJAudnWFCxALTjDo1ucVG+zOovFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXBO+YXS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8m97Mwk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXBO+YXS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8m97Mwk"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znyJ87Rf5QSuIOA4QGRHzjQx5YRj+X4MdZFuK4VJ2mQ=;
	b=RXBO+YXS3oP2YLi8XhX18qVnwDPWqoVjKdgEu997meGXHrokZZEB7WWBuA8BXoPBdDkWU3
	6XSpQtXOvlGv+aP2is/zpW9jcm8iqzFj+Lh4x2MPofOrRrElYRnv54R0hT+sXxGEby75XD
	g2dKVjrrnHY8kFEwq50y6tbCAFKDCJsywEjl5gi0BDmAE8si/IBxZ0qBdsLaTrsa9mUV5J
	P+9jGWSSWldS+6GTR2MgZsT8nsJwKlDFa9iwZ8OY8c/D89z26mDsHtaPrBjP8w6jysEGDG
	lNx0K+nLHDBwckUs7NCWXcbh+YJfTuu21DB/v7jj7r3Ohb4prDyK3pxf88r/0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znyJ87Rf5QSuIOA4QGRHzjQx5YRj+X4MdZFuK4VJ2mQ=;
	b=N8m97MwktOuJaoUQu2wweXa7n3kcktzGltKb/3W9x/GM9cUX9rv9/dPRmb1mAR7g/UVBfl
	ePENj9HNQOeY8ZCQ==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/9] sched: Add a generic function to return the preemption string.
Date: Mon,  3 Feb 2025 15:16:24 +0100
Message-ID: <20250203141632.440554-2-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The individual architectures often add the preemption model to the begin
of the backtrace. This is the case on X86 or ARM64 for the "die" case
but not for regular warning. With the addition of DYNAMIC_PREEMPT for
PREEMPT_RT we end up with CONFIG_PREEMPT and CONFIG_PREEMPT_RT set
simultaneously. That means that everyone who tried to add that piece of
information gets it wrong for PREEMPT_RT because PREEMPT is checked
first.

Provide a generic function which returns the current scheduling model
considering LAZY preempt and the current state of PREEMPT_DYNAMIC.
[ The dynamic building of the string can lead to an empty string if the
  function is invoked simultaneously on two CPUs. ]

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/preempt.h |  2 ++
 kernel/sched/core.c     | 47 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c    | 10 +++++----
 kernel/sched/sched.h    |  1 +
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ca86235ac15c0..3e9808f2b5491 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -515,6 +515,8 @@ static inline bool preempt_model_rt(void)
 	return IS_ENABLED(CONFIG_PREEMPT_RT);
 }
=20
+extern const char *preempt_model_str(void);
+
 /*
  * Does the preemption model allow non-cooperative preemption?
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea9..bd2664755b09a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7646,10 +7646,57 @@ PREEMPT_MODEL_ACCESSOR(lazy);
=20
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
=20
+#define preempt_dynamic_mode -1
+
 static inline void preempt_dynamic_init(void) { }
=20
 #endif /* CONFIG_PREEMPT_DYNAMIC */
=20
+const char *preempt_modes[] =3D {
+	"none", "voluntary", "full", "lazy", NULL,
+};
+
+const char *preempt_model_str(void)
+{
+	bool brace =3D IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		(IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
+		 IS_ENABLED(CONFIG_PREEMPT_LAZY));
+	static char buf[128];
+
+	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
+		struct seq_buf s;
+
+		seq_buf_init(&s, buf, 128);
+		seq_buf_puts(&s, "PREEMPT");
+
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			seq_buf_printf(&s, "%sRT%s",
+				       brace ? "_{" : "_",
+				       brace ? "," : "");
+
+		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
+			seq_buf_printf(&s, "(%s)%s",
+				       preempt_dynamic_mode > 0 ?
+				       preempt_modes[preempt_dynamic_mode] : "undef",
+				       brace ? "}" : "");
+			return seq_buf_str(&s);
+		}
+
+		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			seq_buf_printf(&s, "LAZY%s",
+				       brace ? "}" : "");
+			return seq_buf_str(&s);
+		}
+
+		return seq_buf_str(&s);
+	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BUILD))
+		return "VOLUNTARY";
+
+	return "NONE";
+}
+
 int io_schedule_prepare(void)
 {
 	int old_iowait =3D current->in_iowait;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index fd7e852207157..755232ac88de9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -244,11 +244,13 @@ static ssize_t sched_dynamic_write(struct file *filp,=
 const char __user *ubuf,
=20
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	static const char * preempt_modes[] =3D {
-		"none", "voluntary", "full", "lazy",
-	};
-	int j =3D ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT=
_LAZY);
 	int i =3D IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
+	int j;
+
+	/* Count entries in NULL terminated preempt_modes */
+	for (j =3D 0; preempt_modes[j]; j++)
+		;
+	j -=3D !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
=20
 	for (; i < j; i++) {
 		if (preempt_dynamic_mode =3D=3D i)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38e0e323dda26..fb4486ceb978a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3619,6 +3619,7 @@ extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
+extern const char *preempt_modes[];
=20
 #ifdef CONFIG_SCHED_MM_CID
=20
--=20
2.47.2

