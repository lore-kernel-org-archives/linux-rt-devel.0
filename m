Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646247;
	b=lEz4sWucAQqrk3Ne6S2HakYSZGT+4TfJsNuXolY3dscrDhmSVMWFNSjsnKBkHlgOFD6t
	 fbuyHtLQ0omXN7NSSeF6OCrjyCkSQx7X46eHTAW/sldGspZXYY0JjxGC+NBq5FzLWOUjI
	 JgCTn/mgV3MVs3r6IR3eXZi1wvV3oGsZqQqNdaGHsySWIDGmvo0EToOLtaaXLyF4cTnss
	 ALcMKZOl8zM/JBcA6TOfoJy8NQz1mO8EC3nfG77GfR7M26Pb2RRydUGadZANdGDIRSH5Z
	 /MWWqtUY6W4WRwWyCkkjPvmW8I1oV53Qz3g03cA7OCECB88J+czWeXucONGlA9uJJHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OcKo2jdE/+qreu4/thhFC1vb4R1orDdFtElaGu2Tq3o=;
	b=xZO7817bvT4BpsJ5CSsY+JAgfSdr33hGFA1EfXGP6ptC/RAtB7+KsA5qXcA2Dzpi/lb4
	 Rokuc+BME863xw6olfnjR2nOWWZi6THnbXFXUOXAsCZOLLAkBnHerR7rFaipRV+o9LNda
	 EiC9LkybzewBkyjrhxkIaEwPipxqHwetblsEXtnMj7mN6gPyBCjNscBgVAfxHGaQu/jzv
	 w4cKn+AXcdnONA7VyYGYP8TqA3OZ07i8aDvPvr++dMeoYbHngUKveebzQMCcXgxy8O+A0
	 NHFXE6xJVLRejJGBBtdajiCiGhzTx7UJpWFn5EjdTzFU6vJoPa0k2B9CLlhf1EzGWeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bwrSKBY6;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E78606A31D
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E78606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bwrSKBY6
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so8823285e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646245; x=1793251045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcKo2jdE/+qreu4/thhFC1vb4R1orDdFtElaGu2Tq3o=;
        b=bwrSKBY6ZK6sep1A1/edPyuVrwzzAzdcN9fqrnOw+Re/YdYrMnl2k67kmOjEH6LMck
         v+N6kSRxrmDLk0vkPzc6161GEikxLLe3kmjWpf8L5VNSSJxGzriMuLWd3Kx4vArB/YEr
         Ov6PgxCiJLqs8YfaGQYg6fwTfxCbI61mzcSdQWZBocvhg88IVrrfNI5suIncqbxvTt6k
         qlFIJVymuM9wclaBwuu/MzahHlBw6c52n1KTZJ6jnlMvfr9oaxej6cuJKMq4ZkspNhCC
         KcwSMm10fDhDT1arIymqA0B6kpke5/gTEGnyaEjZF2PGb/gyO8gvzdCkKJOfH9TFruUu
         F4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646245; x=1793251045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcKo2jdE/+qreu4/thhFC1vb4R1orDdFtElaGu2Tq3o=;
        b=2QFWS83DC+KPvDS2Z1LBU6nOnY400napcvekUNlVBRymUQKbKYh0jMFYax1tgtGf5+
         3ew1M19KFQUqp+uYbt6wdKxhbblaEC6dvOrRg/mxw4l0QtHGObOr5g+CK3bL52HUC8Rg
         6+fKCCo5yZ+GRADNJn1xoAgqrNM3WO4xm84pcLSQlN/vkPO6XtbVvkiwcjwYM7Z1ne8d
         kPxoHOwfIyQoba3k1gXJwoXXHHZusL86+1C1EYDdSl5fI1ef6NIOk3oZaYI71YA7cMbK
         miy/9iDl04MELksiqeLOowk2ADp1xzxgSJ7xffnpZdn5/7KcWwBT5vdLMYKhm2dQJx24
         u9Ug==
X-Forwarded-Encrypted: i=1; AKwUvByzNdfxkiXRHJ2Zl2cSShJAPM/wiphDpuPEkn8P5oB7uo4psLg55UL+5nQdQKctiBipfcpyNWJqZMfXosSWYg==@lists.linux.dev
X-Gm-Message-State: AFq9FYINuJ7LrG3lc86y+XYPD27r/mkO38jQhEL7gZtfTlOJFg8Zb+SX
	p3X44p2WNqSXckJRlbGBeXokw8g0n1QdB2a487SWVvy/+rw1ip1QZW7b
X-Gm-Gg: AYBFou28uHMUk3UkwGeD4Od1Qz+L1zIQnpVrQ6T5zMJJrvZfUuwOkuREyqvK0Dnm72o
	Apmu+5f/fTl7WI3+75LLtahIS56u4iO02OHh8xH56WlWBLGUVjsUnt8J8M9E/Ka6vd/QgEaNga5
	6TfqhIrk4i+N31fs+U96DVm9XZJys1pqsqWz7W6SqSk/7hab27oB7NjW5Oq6DFL/2wGlrgDpewv
	7hJOcthAOSbhEt+r5IVLtxHi+Cld1zjndqMzfV0pk9zqsmzlk0uAdubr5QUUP42gv5Q7oBnlVAE
	3B3hCqlH4WY1j/8y55QeOZVm1uJdt+EtqD2Tyq00li6AgSHkR8yqaUxGxtEv8+VqHXIqKjAh0k6
	2sI5HkR3NroG9e4wINZTcvWu8p9t32JeykdR8WpbkxkrgEXlhaJGIS+FLKP3oJYPlnHtg5KVg6l
	A1T1AHSZ1Y32EP1Y+g4PdcinBPtkfkLAGP4CCKu0HVF2qia792c57qHXhwa3e/WN8Lqqg6zU2y8
	MiHS3Ij5B3BNI6QQdJvRijv9rGii2nKqh6aU+T7Q/H7Bh8a8MYq+agdrwTZVPpVTn5enB4Y/ZTO
	hhPlxhU/qICDdESBPXfWjkknGbJ8V9j5or2hZwfo7Y8YhdBPq5dPixCBIn01JYgTSl08GapKCZU
	/Xs1dAV4GmJBhnYGfvRy89HTUEWpch4pc7sQMOR0/TfF00mtA7gnUvr8rGbM=
X-Received: by 2002:a05:600c:4f50:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a1fdb079ebmr98097255e9.10.1792646245241;
        Wed, 21 Oct 2026 22:17:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:24 -0700 (PDT)
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
Subject: [RFC PATCH 04/12] entry: Skip inactive IRQ-return reschedule calls
Date: Thu, 22 Oct 2026 07:16:46 +0200
Message-Id: <20261022051654.79224-5-kmehltretter@gmail.com>
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

irqentry_exit_to_kernel_mode_preempt() calls the dynamic reschedule helper
when preemption is enabled even if the preempt count is nonzero. The helper
returns immediately, but its call and return remain traceable after hardirq
context has been removed.

Check the preempt count in the inline caller and avoid the inactive call.
Keep the existing check in the helper for its other callers. This does not
change whether IRQ return schedules.

Assisted-by: LLM
---
 include/linux/irq-entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 3ee80e926a17a..24c2b9fdff4f4 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -487,7 +487,7 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 	if (regs_irqs_disabled(regs) || state.exit_rcu)
 		return;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
+	if (IS_ENABLED(CONFIG_PREEMPTION) && !preempt_count())
 		irqentry_exit_cond_resched();
 }
 
-- 
2.39.5 (Apple Git-154)

