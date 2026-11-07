Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057449;
	b=Xh0qINMFJb9K3Qxbpjd5D3mOMEn11gPJM9XIlUz8lFg4DDTrBGYsr43PvTDhvlOSxMBG
	 R+XukhmEHbLj6FduwRD3lscy1KKlBlZbRRXguJDthRsKydVHhM0XrZ4oRMGO83NuhpNJv
	 ZZmGLWu2LSMagdwFfK+DvjKBvGbtsbQ11XF4OAnFKfuGvhnammNMviAOXSi6zz/wV9BOH
	 l33yJXo7x1iJWzrJVdMrIRfUYUb+a4Md3YFRmNr53+AUunjWmDRpBZiKyrik10CKwfKZY
	 DVxKpfYT4gBy94JZZM0JCHIIWItST3taPd1e+B27jQHVsQERUV1njl3Az2K3Wyw+qMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o9B9rtJeb09FWDwuhemZy/stOo5jVch8QF0LlBNkaEc=;
	b=2fn4FGlNEaFMiC56aJzgjAJjgKgLZZIHxux3/+JoBeg6gAjN2deyeCqDfmF9iRQo6zyy
	 jHe6PZvr0Gx2KtvbwZL+6if8/mxh6HGA2vd4B0ix+uR/o5R/6WDcaeOuYCo9PSxSp2P89
	 3lISR0S5rGdlUX4NgHBtbhhrvi9tfvOQIrEg4LqvFoV33p3DCr1UpvlOrIkHZkdHDmT8t
	 kjaNld2py0YZUBAWBSmzwuc5tbatEw2XSLin9TlE02cVfmh5dXjzCie6ghZgQkYMF6T87
	 FUg+ml/3wBTEd/a9aMUfcAGYmj1I6u6Ob4cQRIobB1Ib9u2E9XfND5GZu6NwAkMx+3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Og/xbYKH";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D1606A32D
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 460D1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Og/xbYKH
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so13631025e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057448; x=1794662248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9B9rtJeb09FWDwuhemZy/stOo5jVch8QF0LlBNkaEc=;
        b=Og/xbYKHHrWT9a7DeK+r3hhjkURn9v+R1uZCcBWo7gqJZWflrNVA+QKQDDy/4aBFGO
         +OY5c/2m/0JGNlSHDYDDl5IDYvZHyUhuqxv46tbXS0d4rVEj5auC7F/gid5ZtiNXZ653
         i1FCUPMrRC5H9px1P7gcsrWuYssrhVTe5xx9Mpq56ByvG5Eu6bg36NjXJBfOIk5tanHJ
         AWymIAdzklK1OnD42HKYjfktOre+AmHeDjNPxPz+M6GgXnmBAvYiIod+WRArAvTXIdqw
         xXahvjDmr8TCCeNXiWZhTZATwFNHnr7GU9vIVbAed9R5bdN8qoAgLonc4nS2Hzjeov9o
         lcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057448; x=1794662248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9B9rtJeb09FWDwuhemZy/stOo5jVch8QF0LlBNkaEc=;
        b=ke9mD4FNoyo9rFs8QFcYP1XDVxGlUbeZOjZ+es4Ea+nrd5V89e4Y4T4ElmSeb8W5jU
         R+R0YKId+ZYUD2uO2FkBh4q9LBVhnyrheYb0TNdTaIy9asplAA1Tgz2fgA9g6zji7z+K
         6irdFrJoa/P9MrAtFAJxSTKzRtlm4BvLkxxrZ6CnVGFDHBU6OltACUbhBGGZ+nY7yAi5
         gRIetumLN+A3cmn9V1bFVAnJpcTBaJzdR7ZwxPWbJaGkvyujQwUbnJ7nK8R0wF9Ac+uT
         pDf4Vgtua4GEzgxJZUW4bkWOTjQxodmMpx012Gq3Iw4lgChFQM8J9coGAZHhw0CztLAz
         Oymw==
X-Forwarded-Encrypted: i=1; AKwUvBzByHMqLq8P3PjEp4HxeNXgFXm6KtwJBfBR/7u11Mzg4sHolz4afVobY1kBDt87Ly8RYzhsb/rZnANrb+YDYg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ockpLtuysRglu+geg14K9jpmHogYp+UuLBP3tavVVvZWHxTMG
	Q58uQvw9tf26ZPGdFZH0ZyfKW+vzCvdal5DoRlV0y1OE4FyFqr4J04xD
X-Gm-Gg: AYBFou3GJ3n9ulnq420pf4QtBctBFuN8Guykw0izgl+T+zSSzNe8CV48XwppDbI2Ltq
	KpSMiYp7RpefqLZF6J/+G0YP3EQ9EPgbfsoWVmh2JQP0TMq5noCo9uCUfQLdCBui4rm1kAV33Pf
	o6AaxyWRAXQ+ReJhMHVo3GRyPOr2Ky/E9yRR8rtLS/jJzEyRCD8TFMJ+8Rz9XQhYDZq2IuI7VIt
	X84d1505gszM96Cdfip9edfNTQFK1/W6LK6w+HFIzCn2Ln9X/ComZYXcOVauh04SDv6T2UJ6b02
	CPVFe+0vgWCMf3zr1dC7yw4Dil1Jh4qk/FuTpxRTcpnU+uIWy6UtazMu40eWqdgWiQTQlgqDbmm
	VKt9PrOvv2qibCAb6T7PPI5drXbQcIOA0YsdBM3gEQbKuwE+tGtbLF+pzZGMMxThqQLNATJ1v6P
	Z+cQHaiASBM8/BWgxEo9RN8VAOWMpyJCfmepZJ+wxWxje9JhyST6PxkSJQXAO/94zf6DuDzEPWD
	j7NlMU0XLGzsI1i61O/UFsabeVjTLlTQzE1RW/5qIhxl2VK40U9fJMlhqgjWRpojOXU2MKd7t0U
	PuBC93pNL3Ty+e0EJ1ymNq5jpqn3jSgFjiWdZqetSE1xLyIHeOjiTriL7YGMurZqdEaepe23EvG
	zNP9cBK+LQaYO1Rt1UTr0zQqrbq/is1ribsXt6ypnYp7V2ywaCGuVkoezT9xPz/AgKpTh5CK0B8
	3XUtfIbxgpfCL4w1xwUybnzGF0GFTR3dk=
X-Received: by 2002:a05:600c:19d4:b0:4b4:49d7:bc25 with SMTP id 5b1f17b1804b1-4b6dfd97b92mr94982055e9.21.1794057447480;
        Sat, 07 Nov 2026 05:17:27 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:27 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] kcov: Use unsigned int for kcov_start() mode parameter
Date: Sat,  7 Nov 2026 14:17:05 +0100
Message-Id: <20261107131710.89264-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107131710.89264-1-kmehltretter@gmail.com>
References: <20261107131710.89264-1-kmehltretter@gmail.com>
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

task_struct::kcov_mode usually holds an enum kcov_mode value, but it can
also carry flag bits such as KCOV_IN_CTXSW, so the field is unsigned int.

kcov_remote_softirq_stop() passes the saved raw value through
kcov_start()'s enum kcov_mode parameter before kcov_start() stores it
back into the unsigned int field. The parameter type therefore does not
match the values it receives.

Type the parameter unsigned int, like the field and the saved copy. No
functional change.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 9402227bd7ba..7f106182cf1b 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -368,7 +368,7 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
 #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
 
 static void kcov_start(struct task_struct *t, struct kcov *kcov,
-			unsigned int size, void *area, enum kcov_mode mode,
+			unsigned int size, void *area, unsigned int mode,
 			int sequence)
 {
 	kcov_debug("t = %px, size = %u, area = %px\n", t, size, area);
-- 
2.39.5

