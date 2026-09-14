Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCE31ED93
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364880; cv=none; b=VCbFJXgY6fQdHkP8yWOLG4C2oVgp01gA952cS8Q0W7ueIRCtNXgkgyHDwpG89ux8rhGV401JFH1HLoWoq8FEtBaNgWOk20BwHBaUAiT6/4Cqq46MX3f4PJ8gIYymqBdOxeNZ+OYnq/VHkw9rFCdEDoK3qjjZXLPyLweD5rfSVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364880; c=relaxed/simple;
	bh=kaH16PG0n5qXMp1A+1ketXJJnLdvjaHIZnQlZIlJjfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeE/UM6voyji5jVIYEXfS6tiUmL6DC3oOy7cPOHIO7AHKJ3i3TMixV6DeUGPSH5WW7HOCM5Ov7s99qrm4cJEh/NEXMlxXRSQauTxHtBjqkEubgrwWNZO3Q5vjBrIkUVvZa+SucEudDefJ+HwvRMRoY75v416dB0gauSBrrJxth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTgac4Zj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTgac4Zj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so6013465e9.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 13 Sep 2026 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364878; x=1789969678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrdUODYcC4o3InxGyBh8xP7Mso3oU5634kbBFJDiJnI=;
        b=mTgac4ZjyBFGygoZx1GqL//XgAVBpTl7D6lnwejGgmbolSnCWCbLH8w7pp6uMBRTWu
         BDE2FiRyJFY08PtSOOlYgxyp2UI5qMsFp//BEZ6KV9zWb6yGjS8oBHZBbCmUhxe3ok5y
         E1Osmsi/KTYunKnwG5P2MZqMSjTndPNX2G4mECIforTyOeRwX50NY0PeYPENfLl8cn4Z
         +vofDz0JFTylY6mTIkEGjNYAEdBgzTpoVKdqv6fobTkIcfLvxhZFHa2n3HPLS+7kp08F
         h1hJJq+29bonyZOZG7jflSPq+jCNZh0++NmIt+Euv+gaIIi6mVrdWYj6S5rqxq6/0/db
         +j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364878; x=1789969678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrdUODYcC4o3InxGyBh8xP7Mso3oU5634kbBFJDiJnI=;
        b=N6wUG+MOATWb3QiG/ivz7ZXKmjgm3HRtYaamamdrmF9ZEjZ/LNw1gCtlnhs7FBr7sA
         lbRyXbb/3U8AJRfBmYTexgqXJPdEIO0o6kHcfpf6Dx7/neyvNztYyMm/OWcavgxMlNqt
         E8u10Ag2pgsb8HrVuJC/oWI3lhvXgRYhYBHKRDvIxggvLrQRBdLfbGmWWg2ryXhqKR35
         aZ+dLmvv/zKf1dh/CRIPFJFJi2HmV4sA0PYzQFLCrM7m5HnqFTRx/V8banPT8srwm2kn
         p2apaivS3w6ZRWbPthb6Y3I8HTQh0ReonZ84Lqn6Do8xMYi+iq9FXABNWdFbRHGZQsFU
         yung==
X-Forwarded-Encrypted: i=1; AKwUvBzZtRS5o8IoyxbS8bRH7Na7jPLyzfwWgsk2SlvYj0vtaM/dZ/Nvssnj4sHywUNgqKntjk8TPp3rl1APUcmjmA==@lists.linux.dev
X-Gm-Message-State: AFuF++lTL/l5pqZe8r+yryLB8Pgeo+WedHljesn9gdQ/5iVlVzxB7oWD
	uQdnzoglGbKan5ShN+XXDVXteqCZW+//PzckSmcPXikiN169ISvex9xD
X-Gm-Gg: AYBFou3wQ8uEwZv5oLdEM8VYpdo49z0ntrSxQVgWemekRpsINAU1vWSbAZtAZCx2dZN
	CCjJjbwFL4mHFb+cIFepeNdNeblI6VcwWb2QkeeATzrzgX4LHoJNYUSdyFNibFqqikjvlABaEWQ
	A515NbXVS5qQPIHjgWtkfz+fKrU1N73lVVNbrKsIFAiK31yla4eQC6enXc5KXArWb8a8bQEne+d
	87wJaZ3Pmp2jqtilTitswBY19Yc4hLuEl68KPqH1YxQqEz7+0zV2fvRmPOO4WWknbbjhGhikbEI
	KWdq02W/0M+WBrYqQKDh0SL4muvqA8fZLA65aqq1HNb91HktVjjNpkLRXact89nXaLRd14nR/cW
	Ubq6QhS3LkJyuUNVQ8Qq4EF8hYVRH3W8k6WoaSWMKi1yid8LUfdJGI75jDg7VRCuzBzda9vQ2ms
	Ccs1NkfR7RTcs75+G9ZKnNH2cZL3FzImNkVP8hayE0Yp34TdIgjd7pvEnGRAYaB+AISGygdKccD
	Oy+gXuhJPGQ2OTEPVlDjBYcA5mTkdd9q6iQsDc5Qr7k8ARbFmWoN7k4vlYBlvMVYFPfCvvdOruB
	KCuaUO//BdkHlAk/boTNgPXxOOZAJXY=
X-Received: by 2002:a05:600c:1910:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49e7a6573e4mr10643915e9.4.1789364877387;
        Sun, 13 Sep 2026 22:47:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm214537735e9.5.2026.09.13.22.47.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 22:47:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
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
Subject: [PATCH v3 1/6] kcov: Use unsigned int for kcov_start() mode parameter
Date: Mon, 14 Sep 2026 07:46:27 +0200
Message-Id: <20260914054632.12877-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914054632.12877-1-kmehltretter@gmail.com>
References: <20260914054632.12877-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
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

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 35420f0ac524..79dabbad5a38 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -350,7 +350,7 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
 #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
 
 static void kcov_start(struct task_struct *t, struct kcov *kcov,
-			unsigned int size, void *area, enum kcov_mode mode,
+			unsigned int size, void *area, unsigned int mode,
 			int sequence)
 {
 	kcov_debug("t = %px, size = %u, area = %px\n", t, size, area);
-- 
2.53.0

