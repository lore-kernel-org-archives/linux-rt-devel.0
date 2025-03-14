Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCE202C4A
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968498; cv=none; b=sNsXNdsRlAXifzIVIS7QjOUTIwzvpbxKZp7z+4ShaRIDwkB1KOKXPl8iD1BHX3b+onPjZCaLHlgXHDmuDyUdNRH6YaDIF3S/fZQgSgLcaR7iXu6A++VqOwWdFOqZGlA3qwmHI5NQtVSZ29r/XNdgsxBpyhy4TBPG7Be9tGRWh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968498; c=relaxed/simple;
	bh=IbAdTCkreZc14mUqvZLci9hmaZIiHVclNoAzXspEE6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg2K5q2eE0h1OMT5wHkRjTU+l6Y9Qjh0yq0pO2ehxPjOnWFFl8dK1/HBSqwNQx4QEMvRCHys84I0cl0P7o3AQW81kI2SGXLcv/SV281EhOsy3m6kOT/136ecIWwT/6ZX4pXDWV5+uGJGRNiCMpMMhdLPaj0lmJ9Yx/fAyOm+fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ys76eKUB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnBCiIGr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ys76eKUB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnBCiIGr"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6E692BOQyouBFZQiMzEua5fqpH9ktmDroi8bOmXbNk=;
	b=Ys76eKUBSSnqY0lIjJqn/VtEZJFHefuWwYNHRJRvhnfFo3LIlT6TBM4JH+wiurbghru8iB
	bKTRzmCnsg0IVa09byIM7eld2r4z+2ojXQBHBewqegEmItvgII9BLetvnPHdmbShApWsxS
	G0MwsP6NI3BYtziqkxixIsDtkt2H51bbPEsS756HvXm6mD18wbvHiAlSEDGbmNxRPY5R6s
	rKdfcIdpKD6OBiMQymLtN3s78kvfTotxlL8OeuDZBVlEQ9vBSEa33G1B/bpkf/JcW1jYyo
	imiSrfCG/4YAhnz+D9NHJVoBHf34MTKvQVVa9hY22t28RuxKWl/MWJI+fKj4iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6E692BOQyouBFZQiMzEua5fqpH9ktmDroi8bOmXbNk=;
	b=BnBCiIGrjV6ruheCMnu++OmfttuH9FKaCPEXvPUS9TZBxv/c/G3ToddoTyZr6h+gWFCkIT
	lJkZ03ZFCi5KwfCw==
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
Subject: [PATCH v4 1/9] sched: Add a generic function to return the preemption string.
Date: Fri, 14 Mar 2025 17:08:02 +0100
Message-ID: <20250314160810.2373416-2-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The resulting strings are:
=E2=94=8F=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=93
=E2=94=83   Model   =E2=94=83  -RT -DYN    =E2=94=83     +RT -DYN      =E2=
=94=83     -RT +DYN       =E2=94=83     +RT +DYN      =E2=94=83
=E2=94=A1=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=A9
=E2=94=82NONE       =E2=94=82 NONE         =E2=94=82 n/a               =E2=
=94=82 PREEMPT(none)      =E2=94=82 n/a               =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82VOLUNTARY  =E2=94=82 VOLUNTARY    =E2=94=82 n/a               =E2=
=94=82 PREEMPT(voluntary) =E2=94=82 n/a               =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82FULL       =E2=94=82 PREEMPT      =E2=94=82 PREEMPT_RT        =E2=
=94=82 PREEMPT(full)      =E2=94=82 PREEMPT_{RT,full} =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82LAZY       =E2=94=82 PREEMPT_LAZY =E2=94=82 PREEMPT_{RT,LAZY} =E2=
=94=82 PREEMPT(lazy)      =E2=94=82 PREEMPT_{RT,lazy} =E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

[ The dynamic building of the string can lead to an empty string if the
  function is invoked simultaneously on two CPUs. ]

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
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
index 67189907214d3..f6fba7da40c78 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7647,10 +7647,57 @@ PREEMPT_MODEL_ACCESSOR(lazy);
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
+		seq_buf_init(&s, buf, sizeof(buf));
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
index ef047add7f9e6..39be73969d284 100644
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
index c8512a9fb0229..9c3252fbaee08 100644
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

