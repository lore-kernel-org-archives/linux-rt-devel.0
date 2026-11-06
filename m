Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956782;
	b=irZVjq4lipnHiqGT3sEbwqBUtFZbUy6kox6RWoiUvW4LRWFrMSTSujIIHWN4CRZ979ef
	 0k1YzwxsKRCFVsHi41Lt4jSsEkj4aUD0dryojMtiN9bj0NmGNxkyVI7Wj+CMFY5BUkvGJ
	 LOwcDcrKA2WCnEF1Uf0Qo7eQho9exjDaCRfl76kPrVs3lVAp24qcsPViWSijl+IUdrJpq
	 blltjpLOIhIsZcvij+gAYFEriHBaNwkyA0jISA/cXKPqPGB414dMSG8ncmVMlNqaZa+0J
	 rv/+20wNk8mDtnapKQ0DO1181eTwXVjXEKih+Iw4/7RZtOF9rqWDloFtaPzxX/8u/4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956782;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GDlt3jH4rV3KAKlgbppx+p4I5RYe0an1YhekwbD/go4=;
	b=r45+Gcr+snvtUL25CtLt2krkdvsiAL17k4Zx806/7uNI/oMwhTY9fEwHFZwHjOjylo5A
	 yk+lRUiBHEgOCxxE9biSomcNsIfs2Ky+sYhEuWTZSThL19Bw6yW+0jXrLWouRBOU1I9U/
	 baHj+tQq+j5tp4KOdBrRTbw7PjYccXDovrEExPkGdBqk+s3e/tBLgECqcdhfroRie4uWX
	 gahQytPXOS6lxBSHHlqIsUwThTBf4Ky9ylHZDDLh5SPnMjJbA13G2Mu6s5J/yfJyg/Xx7
	 +qAvNZeFObgvd5Y0NNWv9TVbq41/84IGOIgGMYxQerjTkI6Pl7oorzqpoocDKHfRkqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="nwihVlW/";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="q/s/Kddl";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CD606D801
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581CD606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=nwihVlW/;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=q/s/Kddl
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDlt3jH4rV3KAKlgbppx+p4I5RYe0an1YhekwbD/go4=;
	b=nwihVlW/1l5NhrdcFtc4jpfdr4MkP+xA6UNNkt+TazwI4wo2zqBFakoxyfEnak7SWlhC25
	3ZHqvCRzQ4d3oF8Y1KSgNMfWFsUTvR3P120TzfBYprqe6JEpTzzyQ6CORuXCIHh/K7HHUf
	RneY1bvzGwG/Dti99XCVoxrh0TbabPTzYgBGefv0NhRn7FXz4OHEmn3xf7ko/bKMYj57+q
	newwJ/ZDo+rJ0bzLdKLO9VaoVQ/W4Nf8NqkzirbYuta0l7z+8QwqZHkit2qDQJCSA0BI/c
	yr1zIVdxHTrYbAvN4XeQ1BxqZrNNsh4H2gGDoEDVN5ngTIVm7kc+a8sDIUa46A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDlt3jH4rV3KAKlgbppx+p4I5RYe0an1YhekwbD/go4=;
	b=q/s/KddlkzKvqRjG/5+hYcDi2FsDfcjG+vBBU/pXND21KSQaBdNw4WeoUnlSn5lk1j2T9/
	QPdvHSh17RIMWRDw==
To: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev,
	debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 02/10] kconfig-checker: Introduce PREEMPT_RT configuration rules
Date: Fri,  6 Nov 2026 10:19:14 +0100
Message-ID: <20261106091922.7560-3-darwi@linutronix.de>
In-Reply-To: <20261106091922.7560-1-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
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

Introduce a kconfig-checker PREEMPT_RT rules file, matching what is at
Documentation/core-api/real-time/kernel-configuration.rst.

This will allow the tool to mechanically check the kernel's .config at a
later step.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/kconfig-checker/rules/preempt_rt.yml | 169 +++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 tools/kconfig-checker/rules/preempt_rt.yml

diff --git a/tools/kconfig-checker/rules/preempt_rt.yml b/tools/kconfig-checker/rules/preempt_rt.yml
new file mode 100644
index 000000000000..5c1b80adc846
--- /dev/null
+++ b/tools/kconfig-checker/rules/preempt_rt.yml
@@ -0,0 +1,169 @@
+# PREEMPT_RT .config sanitization
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# List all config options in alphabetic order, per group
+---
+
+docs_url: https://docs.kernel.org/core-api/real-time/kernel-configuration.html
+rules:
+  - name: CONFIG_CPU_FREQ
+    expected: y
+    severity: high
+    docs_hint: config
+
+  - name: CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
+    expected: y
+    severity: high
+    docs_hint: config
+
+  - name_pattern: CONFIG_CPU_FREQ_GOV_(CONSERVATIVE|ONDEMAND|POWERSAVE|USERSPACE)
+    expected: n
+    severity: medium
+    docs_hint: non-performance-cpu-frequency-governors
+
+  - name: CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+    expected: n
+    severity: medium
+    docs_hint: non-performance-cpu-frequency-governors
+
+  - name: CONFIG_CPU_IDLE
+    expected: y
+    severity: info
+    docs_hint: config
+
+  - name: CONFIG_DRM
+    expected: n
+    severity: info
+    docs_hint: config
+
+  - name: CONFIG_EFI_DISABLE_RUNTIME
+    expected: y
+    severity: medium
+    docs_hint: config
+
+  - name: CONFIG_NO_HZ
+    expected: n
+    severity: medium
+    docs_hint: config-no-hz-config-no-hz-full
+
+  - name: CONFIG_NO_HZ_FULL
+    expected: n
+    severity: medium
+    docs_hint: config-no-hz-config-no-hz-full
+
+  - name: CONFIG_PREEMPT_RT
+    expected: y
+    severity: fatal
+    docs_hint: config
+
+  #
+  # Tracing
+  #
+
+  - name: CONFIG_DYNAMIC_FTRACE
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  - name: CONFIG_FUNCTION_GRAPH_TRACER
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  - name: CONFIG_HWLAT_TRACER
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  - name: CONFIG_IRQSOFF_TRACER
+    expected: n
+    severity: high
+    docs_hint: config-irqsoff-tracer-and-config-preempt-tracer
+
+  - name: CONFIG_KPROBE_EVENTS
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  - name: CONFIG_PREEMPT_TRACER
+    expected: n
+    severity: high
+    docs_hint: config-irqsoff-tracer-and-config-preempt-tracer
+
+  - name: CONFIG_SCHED_TRACER
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  - name: CONFIG_TRACING
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  - name: CONFIG_UPROBE_EVENTS
+    expected: y
+    severity: info
+    docs_hint: config-tracing-and-tracing-options
+
+  #
+  # Debugging
+  #
+
+  - name_pattern: CONFIG_DEBUG_.*
+    expected: n
+    severity: medium
+    docs_hint: kernel-debug-options
+
+  - name: CONFIG_DEBUG_ATOMIC_SLEEP
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_BOOT_PARAMS
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_BUGVERBOSE
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_FS
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_FS_ALLOW_ALL
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_INFO
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_INFO_NONE
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_KERNEL
+    expected: allowed
+    severity: low
+
+  - name: CONFIG_DEBUG_MISC
+    expected: allowed
+    severity: low
+    rationale:
+      A menu option which enables the display of other debug symbols.
+
+  - name: CONFIG_LOCKUP_DETECTOR
+    expected: n
+    severity: high
+    docs_hint: config
+
+  - name: CONFIG_PROVE_LOCKING
+    expected: n
+    severity: high
+    docs_hint: config
+
+  - name_pattern: CONFIG_SLUB_DEBUG.*
+    expected: n
+    severity: high
+    docs_hint: kernel-debug-options
-- 
2.56.0

