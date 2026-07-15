Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10D3A7F52
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092630; cv=none; b=r6Ddsotlt3zvtPAJ8hLKTf7ohmMoKrR30BMFiW9SwEqnaSJE6NPG+OE+4jcirtvYhL/qda3EjGWn3zf8NBPRVn9NSPk/n1zLNLOhIAI1u2jNCxEVzKevy1x4FF6t48fpkymE9AxX9NYlxkSrNjZIUKIwDjqEffvQi+2gx8k3rMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092630; c=relaxed/simple;
	bh=ZLriYkGfnQ5bulWZpic12v/qW8GJXtqXAnIk8GAYR5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGWayOmjm7KlogFzLEpluo9gW6kyWoio9vFUoC0zMpZLrYpa86Pj4ICk+cVAWQIrpQWD20dgBamv9GGFHXLRuLceQxsihHasLK/wRxubaiDdLU5HYSn5CmhyCzSCnt6jvUqA3o1SaUv+5o7RznmFbZKMc3Za/Yw7CjjUHMKNi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Sovx9bT/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Sovx9bT/"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80e2cfe6918so14846707b3.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 22:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784092627; x=1784697427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mLoZb5ms98D0YoseVgyr3YqsEnYg/BNwWq+M/OSz/0=;
        b=Sovx9bT/C/SPc7kqe68xe15j+KU8UkuoU/b3N3gpCpcCGRe+bEw3jjffyVNVlTONXU
         dCJbQUSB7l46SXxgFXbw1/hfngtUFQ+AkeNmEpZiE/kxIRdUMJnfZs6cGooEe3eNl69l
         n09VWnTZS+59hGXRsE8chSFgmpUWFz/Om44eMC+BF1GTKoIcf/wBSRShu/6D8si+WoMF
         WhlU5TTdtWDAYmOW2ckyQysPC/euKWGYTnupdzlEVKjqKXmx1z/9uqQ6jHtx31PVJjS/
         DdB6HRWyg7O945hP+ySd02QSFHYxrqMUb/chj4CBmNN1CVPTb9oynyuEl1xC1Ujjj67D
         vd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784092627; x=1784697427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mLoZb5ms98D0YoseVgyr3YqsEnYg/BNwWq+M/OSz/0=;
        b=kgIJtULmUl4lNFxSAg6g2gbx07B4rraRPWkaRustBtkBZbwJ/HSK01gegsFQtM2ygR
         +enfKX7YOIb9is49t59hkxweEAGnmqq5tyNTysKk5e49FedQiED5YYjllxQPnNTp9mF2
         BzsZCXbhbUuitYfvNMeAmCl0M9DJySamplniT5tn/tszUTiFjtCHqigPNCPNERMwE8k9
         /iOPwcfCL0fCdheJM53/XyWyWCQfey3noZDQpfWpDLpDR/H7ToPosnH9uUNlT49oWj/F
         rh6dFCYhJrLyAkCFsqWfs8bxqhrVHvvl56pZletvnB2kbsDg/0ayUYtrYWk1YzUsMo4l
         ZJ+g==
X-Forwarded-Encrypted: i=1; AHgh+RpVGlHLqovyp0BYte1uMDbodcN8PVJueebRk7r26JHwej/qSDPAbo2r/Zc68pTFzki4n5MOcCi+TG/dlukX5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ7mNuN71jWpN+0HEx19/GPwf8I33VyoiUSEysGM3z1e5jac/I
	q8dp0Kb9N2AjQTSP+pb2cHp8OK4yg1ollg0ckyMOUpTk7Yxf5oo9Z9FDKq4fZeQ2cEI=
X-Gm-Gg: AfdE7cmL61DVOJlBypmV0qBLdARrWXtckmwKT4kUqwWQibLO7a9HoQUgLP7z8fvBT0M
	GPmk4x3qTftTArg/FttXj9PxgWKgqlwrU62E8CFyVKdC4UvYHBWCbVeyeOlDin+xANHCbothH8V
	GsB7DvjxbYWybWnkeciVrYMIyOaJGl/UGw85UMtSpmNQhrADlS1z3D9mghHO77nfThcN256O8ml
	1H3M6P+MWpatKcOLo9jePSrVg7KhhBZn+PgUvFv6GHzMDkyyeWkBOoardHc37eM8FgqdW/jrKWz
	Zd24cXPTPKFFK9c3w9kON9jH9o2QzV4gEbR+gLzgqiOrAjcQFcHD9P1x+FMVnO7gMv/0bs6d0zt
	ZI03xaEP5B5wezuN6QCRUBuIO8Dv2/DuD9lDU4gC/Ct3Ze6CzydzQBqwQ5adhCL3+4lStLID71A
	Yr4kXuz7Fi8Wo/JIhsk4UqwYwWoX2RFY12zFsMRRJyDtltKJgSaXHotNx7xg9lhIf20clF+2lcY
	d/XErZH/0IRLekzUkQheckYKJsSPAJ4OVOG6xxr8vlAkTmiBkc=
X-Received: by 2002:a05:690c:6d0d:b0:81e:c972:e8c3 with SMTP id 00721157ae682-81ec972e93emr25328327b3.29.1784092627340;
        Tue, 14 Jul 2026 22:17:07 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net (108-196-157-19.lightspeed.austtx.sbcglobal.net. [108.196.157.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c23939fsm159625657b3.46.2026.07.14.22.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:17:07 -0700 (PDT)
From: Andy Chiu <tchiu@tenstorrent.com>
To: anup@brainfault.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-riscv@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: kvm-riscv@lists.infradead.org,
	Andy Chiu <tchiu@tenstorrent.com>,
	dfustini@oss.tenstorrent.com,
	greentime.hu@sifive.com
Subject: [PATCH v2 2/3] riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
Date: Wed, 15 Jul 2026 00:16:21 -0500
Message-ID: <20260715051629.1169645-3-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715051629.1169645-1-tchiu@tenstorrent.com>
References: <20260715051629.1169645-1-tchiu@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 7137a203b251 ("arm64/fpsimd: Permit kernel mode NEON
with IRQs off"), we are upgrading get/put_cpu_vector_context such that
kvm_arch_vcpu_load/put can be safely called under both irq off and
regular process context.

Also, export both symbols so kvm module can call into it.

Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>
---
Changelog v2:
 - new patch since v2
---
 arch/riscv/include/asm/simd.h          |  8 ++------
 arch/riscv/kernel/kernel_mode_vector.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index adb50f3ec205..678c8b97cd49 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -44,12 +44,8 @@ static __must_check inline bool may_use_simd(void)
 		if (!riscv_preempt_v_started(current))
 			return true;
 	}
-	/*
-	 * Non-preemptible kernel-mode Vector temporarily disables bh. So we
-	 * must not return true on irq_disabled(). Otherwise we would fail the
-	 * lockdep check calling local_bh_enable()
-	 */
-	return !irqs_disabled() && !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
+
+	return !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
 }
 
 #else /* ! CONFIG_RISCV_ISA_V */
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 307ac369c3d4..6627e1a82e19 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -55,13 +55,16 @@ void get_cpu_vector_context(void)
 	 * disable softirqs so it is impossible for softirqs to nest
 	 * get_cpu_vector_context() when kernel is actively using Vector.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_disable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (!irqs_disabled())
+			local_bh_disable();
+	} else {
 		preempt_disable();
+	}
 
 	riscv_v_start(RISCV_KERNEL_MODE_V);
 }
+EXPORT_SYMBOL_GPL(get_cpu_vector_context);
 
 /*
  * Release the CPU vector context.
@@ -74,11 +77,14 @@ void put_cpu_vector_context(void)
 {
 	riscv_v_stop(RISCV_KERNEL_MODE_V);
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_enable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (!irqs_disabled())
+			local_bh_enable();
+	} else {
 		preempt_enable();
+	}
 }
+EXPORT_SYMBOL_GPL(put_cpu_vector_context);
 
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 static __always_inline u32 *riscv_v_flags_ptr(void)
-- 
2.43.0

