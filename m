Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B119259E
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jan 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444509; cv=none; b=P7gZ8MV9FTM8StMhRe8SMm7U9uMKjN+WLm06eQk9z1WzLQqk/6P/NZ8amPXi20AJCxGm3XyQHFGXwG0QCQsV0DNG1ypVIhyTF5DmBwm+1rKpzTOgiXNyo4uWr+sNuDX0bXppOPTjEdDIjBuJToz5lWOrGkAYFvJPnq6qWmrcEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444509; c=relaxed/simple;
	bh=z4Vdt9Is5tpUaKQMYdbgOD0AzOM4rvDlvNxQ9reOIj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOvXavK/XsHwKiSlYpyMMBO0w6dQNMh4fjM6Ggn1+kQtHuDKZPqqWZL7RA/1KHJpfK7DXd5dVI4UOYQPW9XdA50dD6yefz4puo8aKHO1rX0139sMM3IieLTPxe9nXGubWbiopVFB3kOI6PuYaMlFPzsyUn4i2UARofiWAGncpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWLRhujE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FU6rZ+UQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWLRhujE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FU6rZ+UQ"
Date: Thu, 9 Jan 2025 18:41:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736444505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9LnSQtw2NnfdHnfWVPnZ4AarNwhw+EVaGlWNisHEKs=;
	b=FWLRhujESPl+RgMy9mquwVXOAxPeVFTkv6lHr5vkq/kjjT0vgj7n8jxzmBfCNg6/cfet9+
	qolcbjVSZh/IsNtJmN03Ubecvumf9+HxKcI/S8n3EGfthpmxxxMvwWbafCGwf24QVi84l0
	Mv/ZFQzR2vXMYQWrZd7FqSrrQ6RfCZxNLJMr26ivNaQBz2+UUVyJZasGaWEmdrdDrmse1V
	l14X12LCADCZJainzu9+ZRwFmdUttb8c5SXmgpas6xEVrPFoV4mFy2yDImV+MeWoz0nap4
	DSEHNaGXHHF0Q5ygBV0N0YpY6gcr23g4CwWDPRepXS+h91MNwQrsPyF2C+OTmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736444505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9LnSQtw2NnfdHnfWVPnZ4AarNwhw+EVaGlWNisHEKs=;
	b=FU6rZ+UQ87nu1fnuQfQgUvIZcJ7M9B/FDlmyDv8dF/ZWck94+VPtVhNRExU78oZBCmiyjm
	bt9O1JA+DDWS6XCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [RFC PATCH] preempt: Add a generic function to return the
 preemption string.
Message-ID: <20250109174143.ZY0WQerE@linutronix.de>
References: <20241206113431.Q-VXMlru@linutronix.de>
 <20250109114339.GB2981@noisy.programming.kicks-ass.net>
 <20250109093702.5fe3400d@gandalf.local.home>
 <20250109143701.GA5388@noisy.programming.kicks-ass.net>
 <20250109144124.a7MWASit@linutronix.de>
 <20250109145408.GB5388@noisy.programming.kicks-ass.net>
 <20250109152733.VIh584yu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109152733.VIh584yu@linutronix.de>

On 2025-01-09 16:27:33 [+0100], To Peter Zijlstra wrote:
> Good. I do like it. Let me make a patch.

I have this now for the sched bits. You wanted to reuse preempt_modes:

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ca86235ac15c0..3e9808f2b5491 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -515,6 +515,8 @@ static inline bool preempt_model_rt(void)
 	return IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
+extern const char *preempt_model_str(void);
+
 /*
  * Does the preemption model allow non-cooperative preemption?
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e5a6bf587f91..ff460c309d27a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7638,10 +7638,57 @@ PREEMPT_MODEL_ACCESSOR(lazy);
 
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
 
+#define preempt_dynamic_mode -1
+
 static inline void preempt_dynamic_init(void) { }
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+const char *preempt_modes[] = {
+	"none", "voluntary", "full", "lazy", NULL,
+};
+
+const char *preempt_model_str(void)
+{
+	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
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
 	int old_iowait = current->in_iowait;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a1be00a988bf6..496a766e50e5e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -244,11 +244,13 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full", "lazy",
-	};
-	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
+	int j;
+
+	/* Count entries in NULL terminated preempt_modes */
+	for (j = 0; preempt_modes[j]; j++)
+		;
+	j -= !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 
 	for (; i < j; i++) {
 		if (preempt_dynamic_mode == i)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c5d67a43fe524..cf52a650ada68 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3587,6 +3587,7 @@ extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
+extern const char *preempt_modes[];
 
 #ifdef CONFIG_SCHED_MM_CID
 
Sebastian
