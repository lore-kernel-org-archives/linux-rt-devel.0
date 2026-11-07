Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071594;
	b=D60h+jSYayXuO/HPaJQB9KFVQx/9y+8w3tsTnu2Mfu0n+PlHiz8TIEPR5mT/hgbuu+IS
	 jPsr4Y8dIU78KQj8Xzth3j0zu8cW9Cg0Wo25ElAEUClcodSxeRiDWpX6Nfxm9uDjMn8Re
	 OfkIkF39Xc0AprSRhxdH1qQsy04TO7G1qaNtGxMAgaWLnh8Cmea5bDFeeqbDlnGpzsWd5
	 hI74TXqqNmE/3vsPKyijaCzRU2RG9KSkgxgZojQP2aW2UcfRfqCAqnfY5P8eVNJlom93D
	 +2Qs1UALxe9tuSjcUaISXmXKVmDnEYCpxpIE39yeir0DPDUdYzk0DNcGOUSqwG2g+Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vG12dDB2cOlbfaJe777WCUEVPBMgOyFMr8jFTvptykE=;
	b=sLMXbQKm17A+xbb0zhJ6nRJaDOTEUnT8dFOT/Mf+OPcHQUIb7c8CUW+2lZcfQ9uiHwCk
	 wJQkgRl3+77uyIMgp9ctn6zQPI6jozglloq+UxA/rCrwXUy4XkLNTpHGRrvxrgMGkq1UK
	 Zu8BUzDqHOo1CfxMzliDE7PBpGJiiGNKQfL/kXcYws7f6VpbMs93D6BK7g9ARjk5x99Xq
	 y0YCrp9ZSfRbcjM7JuyguswEFGV/aOTcFJhon0UN4u9gguZBZOaynCHQOuNV/9HH2BZ3l
	 mXm2D50zTWHN7wtMlzc5sLiRkeAr7gQ2qlvZ6q1HGlB6vdYQX2UNyNp17TaHOdV7dfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cacooL3S;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A4606EEAA
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 17:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D76A4606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cacooL3S
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4922523d1afso921779f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071592; x=1794676392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vG12dDB2cOlbfaJe777WCUEVPBMgOyFMr8jFTvptykE=;
        b=cacooL3SoqMXGOrhh//Zi4nZKDA3XMZwFn412OZxxrguOKIbgW8/djqIl/ZiueNpDS
         TzWX2vwcEDF+eFQQDomG+Ff0tY6Mn+/iH365zyG2fHHoSs8MLcqRoQjPom6WeIqDocJa
         VfyE634q5XEVkmyZN/muKHLuJYuAO/COjx15JbeW5T14HEmc4cX2VJ5QnafabhfV6g0L
         u1OPvEGr21JcL51Z6LAkxO16nu8xAYjw3fllyjRKWHPPQG68bH5JuHor7GxLsVZBL2PK
         adwjp/oR/sQMWTJIkSgDBbX+JQd65xTLlWmAwuP6ogqgp5G20PXgDYiKJqz7TjZ4Sjzl
         gDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071592; x=1794676392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vG12dDB2cOlbfaJe777WCUEVPBMgOyFMr8jFTvptykE=;
        b=nwFsebUbsO0HxVbtQbV/bdpB8xRHvifpBO6oSBURPttMCBpkREAGPZKj5sK6kwEOsR
         TRSv+HQ8RHEuyH0o70ZKPTq5Y3pGvvRRfsx7dh+3WO6LWI7Q3MwfBnk+77cQImDIqoTr
         /E/KuMOkII10b5vfgC0tf7V/1y3cg6OAr52vPp+wtZE/5rjvFo5mzWDsy64o3iF9FN8U
         RC873lUTsrPLc3OBjwdJ8Rk0ljL5BknKaLcaku/SGCYEGxV4xbmxCJXuXmG/N82eccWL
         wtbUzKaJcUcaTVLMaB/mdeBkpHo6EJGCly99pbuIVxzqa5XxeYcRCV6cxpPYXo3BuhCS
         3nog==
X-Forwarded-Encrypted: i=1; AL+hErFFOsyYGGAXIZFR7a8azxhDq34XKxQJuKTaBIvhmFSAB0VyBJ9TZyl10MfkxRGZbEKlOqOpmkAtlkJVJLMhDw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+OUFtPbaAtlZETyJQBbldQnAH/0djIXR/F8Qv/46CCAgpHRUQm
	Xo1DavRPoHOJJQ3wLKYHa82kRypIXoEQuHaByLrBwTUBvSatdcR91ZE7aBtgqkf7Fmw=
X-Gm-Gg: AYBFou2JX3YYzTtkQ5ayXI4fgn7MH9vb/MyaOfzYKuTEQmja7ZhQBRf6rXTWubaZUVk
	4XGAPDwi07ra4R4t9JefpLjK1h0n6uBPVu5gvNw4gpfHbCMXbOuilmFCC7vY+ayclHQe3uITI6W
	03xFEICTTmKYcbJ4r5EtOfMsGBccQrIuJVqRLJL74q8nqVswmt0lc0trCQGnHTEsM19frEM60U5
	CyCTTmMNALqh5G+fdwr1yI5vKN3iqECqj6ReUtLmnsuWIaTEeuLu/O2bAiULDWiHBBrUCWxhsqS
	HgtbhTnIqlnS9BzF9oeb4hqopgKUe2Xdo6cDffRHjVIq00v4PGBFoVBSHd5SzfC7+NvgpkiguOw
	myqDIrYOVV0Yd1aroI0Q4yMrUZr0aXIADVx4smRqSZVzbm4D0UnCjvpM8n8ATPodEIrFu4H3mCz
	Qcmn8elSeMQ5Cp9/Rz2R8zMv42f9mn3FIiHOIdEm9wtb2pobp29q628Y/SQu0DNtaawG4syDYMT
	aOZkrczgQDgjwQueBF67UN494mF9DgkveFwVNtwbSkvEFZyp3KI6xu75O17z0X+SHnkjUvutsiY
	wbn3igw/2GIsDfOH4UzJMmpbtDPi/KoUAJda9SAAsX1B82Zc53w23BYyNKj1zJ3x/Iw5zRgCcQh
	fWEFBEkiy5ivgUDPqVb+HCAu/4tl0yLTwguTWdm7WcgRSG4MaNy3XudyYXNu/AbqwFRggjpgVGe
	ziUzkaOtSKJPU+2vIEiraHV7HUJXJw4I4=
X-Received: by 2002:a05:6000:2dc9:b0:491:8462:20cc with SMTP id ffacd0b85a97d-49277bb1d39mr11173964f8f.37.1794071592005;
        Sat, 07 Nov 2026 09:13:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:11 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/9] tracing/sched: Add IRQ preemption lifecycle tracepoints
Date: Sat,  7 Nov 2026 18:12:45 +0100
Message-Id: <20261107171252.25090-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tracepoints around __schedule() do not identify the start and end of one
preempt_schedule_irq() invocation. The calling task may switch out and
resume on another CPU before the invocation returns.

Add bare entry and exit tracepoints around the generic helper using
DECLARE_TRACE() so they are not exported in tracefs. Record the task
that called preempt_schedule_irq() as the owner in both tracepoints so
consumers can follow the invocation across switches and migration.
Sample the preempt count and interrupt state before dispatching
tracepoint callbacks.

The tracepoints bracket preempt_schedule_irq() only. They do not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/trace/events/sched.h | 26 ++++++++++++++++++++++++++
 kernel/sched/core.c          |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f159..c7aeaa85d27ef 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,32 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+/*
+ * sched_irq_preempt_entry - begin preempt_schedule_irq() processing
+ * @owner: task whose interrupted execution will resume after scheduling
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted after entry assertions and context-tracking setup, with zero
+ * preempt count and local interrupts disabled. Exception-return paths can
+ * also use this scheduler entrypoint.
+ */
+DECLARE_TRACE(sched_irq_preempt_entry,
+	      TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	      TP_ARGS(owner, pc, irq_off));
+
+/*
+ * sched_irq_preempt_exit - original preempt_schedule_irq() invocation resumes
+ * @owner: task saved by the matching entry, possibly on a different CPU
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted with local interrupts disabled before restoring context tracking.
+ */
+DECLARE_TRACE(sched_irq_preempt_exit,
+	      TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	      TP_ARGS(owner, pc, irq_off));
+
 #define DL_OTHER 0
 #define DL_TASK 1
 #define DL_SERVER_FAIR 2
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8ca..e5c476d27eca7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7649,12 +7649,16 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
  */
 asmlinkage __visible void __sched preempt_schedule_irq(void)
 {
+	struct task_struct *owner = current;
 	enum ctx_state prev_state;
 
 	/* Catch callers which need to be fixed */
 	BUG_ON(preempt_count() || !irqs_disabled());
 
 	prev_state = exception_enter();
+	/* Sample before tracing bookkeeping can change the observed context. */
+	if (trace_sched_irq_preempt_entry_tp_enabled())
+		trace_sched_irq_preempt_entry_tp(owner, preempt_count(), irqs_disabled());
 
 	do {
 		preempt_disable();
@@ -7664,6 +7668,8 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 
+	if (trace_sched_irq_preempt_exit_tp_enabled())
+		trace_sched_irq_preempt_exit_tp(owner, preempt_count(), irqs_disabled());
 	exception_exit(prev_state);
 }
 
-- 
2.39.5 (Apple Git-154)

