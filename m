Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646239;
	b=OESlAcFs/CkI7ULI2iGuKEmiWbrl11Fu7lg9ZPB3fVUdmpkX9j5DNsY83u3EtzZ4a96Z
	 5Zpl6ZnE1vZzB5tIbt6PBCXP6UR/8rCPCxWE1i4hvaer4GL8A5AS2HXqxGTw7iVxmoOft
	 aBCAPTE7mNEMIbXPuQFEKEmCNP8PQGPSXpo5lRMJDST/4YK3TxUBit6Vamo/EYTVqufW/
	 DxaBaFuqS9Ed3qMY1X54F5vrdKnP05u6MA6QM7OH7XmrQH7aYWfoS4dwAo5ZZZKTA0/tj
	 4tk6ZYV/m1Vl/4ArKZRH5mVIU3o/Sy039LrL7rM9tU56TmvW8N5QNpeNMn+vZ9T/k4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TTPx+dOGfrZ2gbZc2iR4OE7g80jE9NdI9RPBQdZQId4=;
	b=QuWTTnw7IWCXpME8q2wmJ4rQEl0jowVyU0/4KhXwbAaivWvV5VPfhohyf96CVYzYT7OK
	 bft6W0rlAHUxGVdfMriQvk3OMkgQtRl37nQ/bEd/phnEiUadiAMLgBof6M1DJPSX4V+uE
	 voDLLQwKGBduTPLEQZN/yGVmg4bNHevfxje00Fu7Nh3tsuwKGt5C2TPxlyO7wOmUtHAzm
	 iGW0PERu7WV5PHe8hejoC/jAjvSFqgUR294awfs+z/i8ZBi+/7588qraDZv/DoNjqApea
	 jheaCfS2sRy/uldcASF4i9untYDKvF1VKEwzetrIOcrn9r5nWME8W61nmqKeYVALFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EMK6HyyU;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80341606A332
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80341606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EMK6HyyU
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so5310945e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646237; x=1793251037; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTPx+dOGfrZ2gbZc2iR4OE7g80jE9NdI9RPBQdZQId4=;
        b=EMK6HyyU1xop/YuK9j9ytExZpL7WJpjbjG9I2Rcy2RsJzVkJwOPKpemsEvJiEcZT7z
         a6oyEvEe9SlQMNXjPJzG/72B/TlndvrJqygQ71IkrnTNPAHYduvuVqrfmPiHVyxOLRuC
         yFvLF4/LWtYE2MA8yHlLj+46GSf8O4sOILGDZ5yzpOP83klbHZ0fs/BW1w5XoNQ8+gxf
         EfWY+HuWVOaabtubm83rWRx8oi6HOnnh3xRPe99vjQgvWiaJwOwLKY8PvDmx28m4qF8+
         O/UO/y/Vh9cILdh0bptiWHpXabl1kwDQD5vGNEfO12C5oXb+Ctl9TFitj4c/wojBrrlx
         4KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646237; x=1793251037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TTPx+dOGfrZ2gbZc2iR4OE7g80jE9NdI9RPBQdZQId4=;
        b=k71xHbyaDcg+U5t8BnxBcJ8aQAcEm0LvET2yJfumwIvU67G9OPPvX4QfYdzjlzgLbm
         7xzI7UMymRotV+8xVG7urmYZMHqa4cwcHHHvRCPDeH/J1QbE8FKoj0AQEIFiTZsyZeOZ
         TgGYrc/SFUT8Ty3U0WV7zv/CdzOBa0Swayajd4oFK09r5lsI1Az795L4xEkRma2Z2af4
         FKNK3nrrwG0exWwAtENegF1ZurZe5zAe6iwASWZDPgpdPBViBQX6gsh4ba0G68M8ojx7
         Cs7cCKJunzFG8D9xqsb7TfcFDhYJUo+NTTJoDpVEC924do6170U78KTHF2RiFammpzW6
         snGg==
X-Forwarded-Encrypted: i=1; AKwUvBxdOutuJVR7su38wtSt+BRKNHQpcBs5GI8nYJZ6sB0IqURFOw7j8mdCepxPJZjylyP0gMUp4XGbPMFEJptzTg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ69wi8ocBxIzU+l6WVU0mQl8wtl+/BwbLcLgJRCXqsCPl7zMMp
	1eG9kIB624k0nTZMN3vDQvOfZ+ZEFvtIyjHTqTALdobhhYeXz9x+j0u0
X-Gm-Gg: AYBFou1tAsdz+4yNPo5kIHqtQpGF8Sub2uaY2MyYsUStHsbDKU+JEIT6xg3Uknxz3C8
	HVCZns0cO6uYbT8l1EivegwyE7VLilsQDl37oDVlMup56ZsVeQ/RWuc46p0luAS4q4JPQFgX4a2
	AwFyaIXlYqBWn74XgmAopSBMxBeYhmFGmdDkqg8ImaGmVt1S7Vz/aBKiL77ua7JegpCrIYBr+X5
	p6sE3cmPG5RL1t2H+LBOx1IthScVQ/o3T6qPOgRfLFBY5B8jKCpR/uUaguQ2MRY5Q2aazQCSOUD
	+4j1GI8b9HM+PDAHkpnU14jM9ZYsvH4dC2MyEwynoc0s4sn8wnpTtrtfq1PYWeuY6NjLQFWxoWb
	n/a0kjJu79zlgGRUy7zwnzqDizKwdYba1pXZ+bDCoVtUbzORnpTOpNMtAj1ZAq5/HOh8+RB7tMb
	SZaOc7CM+9dxt0QPawnwu0vciRmmtPoOHzJ9lNLlZie/n1xrpZb0dSYh+n83waSoktXi+i09xTW
	rS30gQiVkGhGnEpvk+uuEHZpZf4RY8GG7B4hwxglshf6WfBoxXUA/0jHya8SLsLy0nZIfNuKHkR
	2g8JZ0Pd69+cI/rz7C42salkRm+DgL+Z7LIrBhANcbjSdiuK5i78qeeKOYQBh2dep2ZSR/v/hsW
	U78nYNsR53uEiawl089oS4M9wXquLc379U6gLhOdSBfmPm9u0fUk/qrGehUc=
X-Received: by 2002:a05:600c:c83:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a204aace0amr25847565e9.5.1792646236628;
        Wed, 21 Oct 2026 22:17:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/12] sched: Split preempt-count bookkeeping from raw updates
Date: Thu, 22 Oct 2026 07:16:43 +0200
Message-Id: <20261022051654.79224-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022051654.79224-1-kmehltretter@gmail.com>
References: <20261022051654.79224-1-kmehltretter@gmail.com>
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

Very early entry code may need to update the preempt count before
instrumentable debug and tracing code can run. Conversely, return code may
need to finish instrumentable validation and latency tracing before raw
teardown.

Add preempt_count_add_finish() for bookkeeping after a raw addition. Add
preempt_count_sub_prepare() for validation and tracing before a raw
subtraction. Keep preempt_count_add() and preempt_count_sub() behavior and
ordering unchanged.

Keep latency tracing in each calling path so CALLER_ADDR0 identifies the
caller. Force the start and stop helpers inline because trace provenance
depends on their stack frames.

Assisted-by: LLM
---
 include/linux/preempt.h |  9 ++++++
 kernel/sched/core.c     | 68 +++++++++++++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 2e689de7b29ab..ad2c35b6813fb 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -228,6 +228,15 @@ extern void preempt_count_sub(int val);
 #define preempt_count_dec_and_test() __preempt_count_dec_and_test()
 #endif
 
+#if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
+					defined(CONFIG_TRACE_PREEMPT_TOGGLE))
+void preempt_count_add_finish(int val);
+bool preempt_count_sub_prepare(int val);
+#else
+static __always_inline void preempt_count_add_finish(int val) { }
+static __always_inline bool preempt_count_sub_prepare(int val) { return true; }
+#endif
+
 #define __preempt_count_inc() __preempt_count_add(1)
 #define __preempt_count_dec() __preempt_count_sub(1)
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1754d9f95f2cf..562d54b978960 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5978,7 +5978,7 @@ static inline void sched_tick_stop(int cpu) { }
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
  */
-static inline void preempt_latency_start(int val)
+static __always_inline void preempt_latency_start(int val)
 {
 	if (preempt_count() == val) {
 		unsigned long ip = get_lock_parent_ip();
@@ -5989,6 +5989,28 @@ static inline void preempt_latency_start(int val)
 	}
 }
 
+static __always_inline void preempt_count_add_debug_checks(void)
+{
+#ifdef CONFIG_DEBUG_PREEMPT
+	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
+				PREEMPT_MASK - 10);
+#endif
+}
+
+/**
+ * preempt_count_add_finish - Finish a raw preempt count addition
+ * @val: The value which was added to the preempt count
+ *
+ * Complete the debug checks and latency tracing after an entry path had to
+ * update the raw preempt count before instrumentable code could run.
+ */
+void preempt_count_add_finish(int val)
+{
+	preempt_count_add_debug_checks();
+	preempt_latency_start(val);
+}
+NOKPROBE_SYMBOL(preempt_count_add_finish);
+
 void preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
@@ -6004,13 +6026,8 @@ void preempt_count_add(int val)
 		return;
 #endif
 	__preempt_count_add(val);
-#ifdef CONFIG_DEBUG_PREEMPT
-	/*
-	 * Spinlock count overflowing soon?
-	 */
-	DEBUG_LOCKS_WARN_ON((preempt_count() & PREEMPT_MASK) >=
-				PREEMPT_MASK - 10);
-#endif
+	preempt_count_add_debug_checks();
+	/* Keep latency attribution in the preempt_count_add() stack frame. */
 	preempt_latency_start(val);
 }
 EXPORT_SYMBOL(preempt_count_add);
@@ -6020,13 +6037,13 @@ NOKPROBE_SYMBOL(preempt_count_add);
  * If the value passed in equals to the current preempt count
  * then we just enabled preemption. Stop timing the latency.
  */
-static inline void preempt_latency_stop(int val)
+static __always_inline void preempt_latency_stop(int val)
 {
 	if (preempt_count() == val)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
-void preempt_count_sub(int val)
+static __always_inline bool preempt_count_sub_debug_checks(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -6036,15 +6053,42 @@ void preempt_count_sub(int val)
 	unsigned int pc = preempt_count();
 
 	if (DEBUG_LOCKS_WARN_ON(pc - uval > pc))
-		return;
+		return false;
 	/*
 	 * Is the spinlock portion underflowing?
 	 */
 	if (DEBUG_LOCKS_WARN_ON((val < PREEMPT_MASK) &&
 			!(preempt_count() & PREEMPT_MASK)))
-		return;
+		return false;
 #endif
+	return true;
+}
+
+/**
+ * preempt_count_sub_prepare - Prepare a raw preempt count subtraction
+ * @val: The value which will be subtracted from the preempt count
+ *
+ * Run debug checks and latency tracing before an entry path performs a raw
+ * preempt count subtraction after all instrumentable code has returned.
+ *
+ * Return: true when the caller should perform the subtraction.
+ */
+bool preempt_count_sub_prepare(int val)
+{
+	if (!preempt_count_sub_debug_checks(val))
+		return false;
+
+	preempt_latency_stop(val);
+	return true;
+}
+NOKPROBE_SYMBOL(preempt_count_sub_prepare);
+
+void preempt_count_sub(int val)
+{
+	if (!preempt_count_sub_debug_checks(val))
+		return;
 
+	/* Keep latency attribution in the preempt_count_sub() stack frame. */
 	preempt_latency_stop(val);
 	__preempt_count_sub(val);
 }
-- 
2.39.5 (Apple Git-154)

