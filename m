Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646274;
	b=Pqfddq7v0qR+QsjdZ/TDTItUQ5rW5Kki/x0GtqNgPnghCPcJe8olHs8hzej96X/L+cIh
	 ugQV7vYpmh4T0COTBNFX9Wr4gkQ9pXZgpgU/6xZi+9VJ8ZJKPIxW6wW86TIhPpI6w09VP
	 LILCyEIA8Ss69pHCEL20qjKAJ4tv2N5ROw+ZgL7Mk6a6fyG0Aeiv6SSCvQr0suzVRUDhg
	 YJfmZrMyYuzqh/etOJC9ZLGnCiiViShERwxVjRyM4DAC4yf/nXnts1Sow+qbaDNVRiwGJ
	 JVhClX+jsL8HuaX3fEGVZqMcsFV/S8oMtNq/xhFcUboAAqS/MGlbxgydVX85+y+rROQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s8aI8a3P6Aq6+tBvBYl4aRZbjZMBmTJC4bYbBQam67c=;
	b=mOts6DNlVYmanSepJJAxD8oot5sUuN3Luld7WoNIc4GuuhGJhJcuDXtN7Ke6/FiAVdop
	 lQrpafIaBTJ0jAm1dYE2Iba0zikPVXr4ouM/BGEMZbsHE/UxYQGkEEKlqrMJ0OSbEDCaN
	 RDWHy83eB77Z7OmA7R77oBleBP/zUsnf0GGmUhVufEP7dFbfFmIpu8YOcf7Nk3rf/9rue
	 axgIhU91t8n8aZ8M1MnnPPi7mqNf/1GhXftaZNvPdIAdLK62s4jjIS+hyXrlBiYgRcfDJ
	 p9/nmsmWVjQA6FF1edL+1gbgk/2V/XKmpDyTAGwfJ1Ajm+QJ5YOChXGaKdMhRPmDn1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bDgz3Da+;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AAE60A2603
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32AAE60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bDgz3Da+
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so11397065e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646272; x=1793251072; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s8aI8a3P6Aq6+tBvBYl4aRZbjZMBmTJC4bYbBQam67c=;
        b=bDgz3Da+Ke7ybh9+QrhQUgC7dA6zslNEj7vqevxZ0mOqV55PiFZO3QD4N1vI6Bsn/+
         haJLOHcOxf5072AhXbbs7XQoOp+FGBrO6Fn0LV+wM0/Kwbx5OvY663FPtg6Ob5/aMF9b
         F16pYnN3V6GgFXv1Da7T1PS7JQBReM/euWRG60QWYMduIaf+J+xhaya/xscFB5gTVYJk
         8/PCb6yZfG+kSFG0bs8QW4ZNNa318x3aV6CnSo/bzHp4ZSxY+ZfaPADQYVN50rZ3Oay1
         ix8f6vlhURBD4Um7MBhq0LmhC7MVsdL7km42yDOtjfC3zdoYcpMyyN0oDgtugDBMzqJf
         4DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646272; x=1793251072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s8aI8a3P6Aq6+tBvBYl4aRZbjZMBmTJC4bYbBQam67c=;
        b=KImPtiF9EzpWXx8UsCJfkpSFkZuDEHvx/um38k14vq4eQvxP/ojYYm44Wp09MZFA7Y
         ZxPIOO4yFwxy4RXEVXed5rXVW0XSYvzIbnNlXzcxvqdukH9pefBYdp3Q2GlWiP9tN6CZ
         BaYuYfWbgrGYeWumzxfv3yAIqdEwCrnES3kgk8eJQmF7d7+pmhetoQmVsqkOiDD1YPA+
         rlK/0cI1ls3vD29FMIrK1nYbwMmzYNo65p763y+OY5Asw6r841vi/JJiNBrjWmxyKSxH
         wOzSN6ocaY3RmmLeeLvuHAvrC2FPRrvdq7B7I/cVgNMypbVutLRIuqUkkO25nTPPKgOf
         pPWw==
X-Forwarded-Encrypted: i=1; AKwUvBzpuVYVc/Bob1f2NiQPwHkPMNG0UqSrEfAYd8A+NHn+MTAXvztiXS/o/Xzqf34hvhNU1hc+QfzCHSWtPEom7A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIi1SUTeNODVPgxEtBjZk1MLTARx3Mht/6+Oo+gyXRFMXo1BzOD
	sAJ1MdEKtgKBgBawYA24hId68wmbhuuN+bIKkXDFj3N9eqZiW6QLKmg4
X-Gm-Gg: AYBFou0QpHAaUSwv599uz6up0c6ScTtTtkSTMi90Dj9D4CwmHM6zIY3xi+TL76pvlo0
	fNNa/fNLQmf2ZUDvpVONn3mxmrgrdGAsW+ox7vVOGsFDDgKFmQQO3SogqRKU4FsjeJE3E+tv9Ci
	ZgldivhNSdmjaFlCscZONv0R/VuNozj6fG/0/q1qaGQlYUX136Vta1L7m065rCdJj0Vgus5sGaK
	zwUsedMoIXaOSk0h5Jm/EfGOCcDIfhtvWYzG7+/ozj+fD4MTOMoEIbAVvrMXbWIDIHgKvqPokgf
	pZoZhJt3bH6RXwb3J2EUusV+8/QAOoghTnL7hrf+J08d+8tIKgR1b2wIxQUvCERf3l5pYFSrXFn
	veb4WgIVac63t0qSj3UQ5SvpdEU0UMdT8e85nvHYxAoUxDqOvSWMODHblW9qnepljziKOXEXuWo
	+w/x11WIzmDdb2ixSpzsjre8lO9IWaD3DMjFs011sR1MfXirn5yQi5FUsqA0tcZcip0E0SY6gko
	wy5Tn3f50DVV+HqpdFnfWO7zx6g2lXBbu+LgAm5NW69vHASkAkQf3ReFAdrGBz0V+J/I8a4r7+E
	8dQxy7F2F/bYU601Dn7pTWzEQfM2xD047pjjfqt6v6+/9niw7Ewi559W1ozGVfH5gF2FqYIsNhf
	EbJauK1ue5ozQXyEqftVqe4TOsdY9GsltUq44bjHRpgdVwMJEkxRciX7unu8JV87Ncsd3maM5eH
	YTZZen
X-Received: by 2002:a05:600c:4715:b0:4a1:e46d:1bd4 with SMTP id 5b1f17b1804b1-4a1fdd574dcmr76596295e9.29.1792646271519;
        Wed, 21 Oct 2026 22:17:51 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:50 -0700 (PDT)
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
Subject: [RFC PATCH 11/12] locking/selftest: Exercise hardirq return-tail preparation
Date: Thu, 22 Oct 2026 07:16:53 +0200
Message-Id: <20261022051654.79224-12-kmehltretter@gmail.com>
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

The return-tail lockdep preparation must accept exactly one live
hardirq context. Zero and nested contexts must fail, and the ordinary
preparation helper must continue to reject a live hardirq context.

Add focused boot-time lockdep cases for those four states. Skip the
final IRQ-state transition after an expected preparation failure so
that each failure remains attributable to the preparation invariant.

Assisted-by: LLM
---
 lib/locking-selftest.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index c3d976c801bb4..1575a04f65d46 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -222,6 +222,55 @@ static void init_shared_classes(void)
 		local_irq_enable();		\
 		local_bh_enable();
 
+static void irqtail_prepare_test_enter(unsigned int nr)
+{
+	unsigned int i;
+
+	local_irq_disable();
+	for (i = 0; i < nr; i++)
+		__irq_enter_raw();
+	trace_hardirqs_on_prepare();
+}
+
+static void irqtail_prepare_test_exit(unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++)
+		__irq_exit_raw();
+	if (debug_locks)
+		lockdep_hardirqs_on(_THIS_IP_);
+	raw_local_irq_enable();
+}
+
+static void prepare_irqtail_0(void)
+{
+	irqtail_prepare_test_enter(0);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(0);
+}
+
+static void prepare_irqtail_1(void)
+{
+	irqtail_prepare_test_enter(1);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(1);
+}
+
+static void prepare_irqtail_2(void)
+{
+	irqtail_prepare_test_enter(2);
+	lockdep_hardirqs_on_prepare_irqtail();
+	irqtail_prepare_test_exit(2);
+}
+
+static void prepare_regular_1(void)
+{
+	irqtail_prepare_test_enter(1);
+	lockdep_hardirqs_on_prepare();
+	irqtail_prepare_test_exit(1);
+}
+
 /*
  * Shortcuts for lock/unlock API variants, to keep
  * the testcases compact:
@@ -2934,6 +2983,10 @@ void locking_selftest(void)
 	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
+	DO_TESTCASE_1B("IRQ tail prepare", prepare_irqtail, 0);
+	DO_TESTCASE_1("IRQ tail prepare", prepare_irqtail, 1);
+	DO_TESTCASE_1B("IRQ tail prepare", prepare_irqtail, 2);
+	DO_TESTCASE_1B("regular IRQ prepare", prepare_regular, 1);
 
 	ww_tests();
 
-- 
2.39.5 (Apple Git-154)

