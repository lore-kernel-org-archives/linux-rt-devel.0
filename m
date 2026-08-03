Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187A3112A5
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Aug 2026 21:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794000; cv=none; b=rKuLxoVhcQB6wTQb+dTpFtdiJfLk01kC+AE5zgq9QH12WKcO8M0XlFyR3dlVrb4caw/7dibu2JOK3tcuHDyIngR2p25cpmMiXH+VsQpbt53kY0tEpOzctETtOXYo5nzcZtK1Pu1L9MaVoxvH1KnF3dnkqYEvvab6tP0HgaV3gdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794000; c=relaxed/simple;
	bh=XxPaqfAYKjeZn3sFsyCvWRBfcHJI/B4cGmsKYYY7AyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKsPT9ojsEANLpnnuKebL4bPVOkMLTCc2V+lGUR9z5yzkDqznII0VK2e36YlG/QR7BzTq4vUK4PFviku2YSbbsKI9QJxigAdIUIVxaP0o13tCJAhZm5QwJ5k3/eqX0oTEZv7z1GUCY7hBB6b/09yJMdIp2Vj5/Dq421O5bd3KtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=DiA/9sU6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="DiA/9sU6"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb64085c45so2772631a34.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Aug 2026 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1785793997; x=1786398797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYj46W8Df7hirMITCsNQUAF2P+9YRrFHR/TmGqySuFI=;
        b=DiA/9sU6wxxT4COuuFegsAoNwThTLPY10qhMLfPhDxuf4D7ip1VC5dWZIYUHOYqbEj
         /7Q1UUAvR15TJ9OExyZp3cz8XCiX8ReJzc4hLVjDA2A65nBrnAjOE4ZpxTUgoczaOsBk
         dvWq6HYZzH1Evt+mXd7/7mahctOh6SkKj47gURH/Q/WZeO8ciY6RW8YL3bYsXDLIZTly
         QjfDY6fkpGjJD2S4gJobq3UOukdtMmibHQdLcKeSj/AP8ux3vRlG6/BSG1s5Pr3OcnCN
         zyHUhzVRJLgP6PaKRjt+02PYX2YnjN6Qb5HUvtgB/UZTMBPdCfw1Zsbi9Fa7X6nb29Tf
         cOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793997; x=1786398797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYj46W8Df7hirMITCsNQUAF2P+9YRrFHR/TmGqySuFI=;
        b=NNSzyxIJBHypVS3o24Hf5iiIvqrIVjKFD5Gb+GHk9F6q0X8W8a3JmF5Uj26QoAnO4T
         VAuB4eYufZI2AXHKlhQ3JmZCg+rZAJbLF/ZXiuNAEhlP+X1RkKlRDOyKhSWypuv4egLa
         z8+swRTvhnDpIBE+vBMQldLBdSdQFft4iml2TTlcNplkd6vWREtZc1L/20Wi4nLSv5kq
         JZ1yE3b5UOeMxOtWqgJq1DlXwgkelLc8STxklBfHOPMaN9hj7O1tNvVx/juHf3bNaVfW
         mhwnsAmg7tWeGQCL6/vIW/fVFD76bat4nSA5CLX+C9mxuATZa08SmKk37NWYLezXmSkE
         TzsA==
X-Forwarded-Encrypted: i=1; AHgh+Rp43lGTmRATnfYzP0NH6kaF6h0XLFslEwSKTYb9qXApuiciw78NVqfNxWrEim/86oXo2pJ1N2E2l1b8XobE2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHxC06qD2VPoE1OvJHbtYFfRBCYMS0Ynwfy6LWsADw6vXQmPDk
	2y74wnHTL8uv7wJgcbT4DMCqmI+TCFauENu6HnYKWCAAOhry4/VMmQl99bv7iKDGRjg=
X-Gm-Gg: AR+sD11iR4IVaAr+P43czzfGiQ8dg3sOoo/ZD/37krqG4gM6ljcg4JpSShxechDRhqB
	3ywffafeHd2Y2pwhCJCuhBqZ2eTNERmTzfRT+tnUB3qV80/5vK1Thx4NOqJegquALyaVlfpzz8d
	3bNcc7fy4EQ67se7v3pYPy6bkT42xNP98g88yFLv3MMut0H/DghTzAw1RNwVfesafpvFHVkchjV
	Uq6ZG+xuAFj/RNEOyjLu9nXBCm5241xhiizA4BsMOsdVTPBoeq8DCdpugVWB6ufPsK26LJOLy1O
	V8/m+6OQyBMFpq4Jj61PuQzFJdnZim9hhsDb06900+llzkGJ51m47l4Dmrhlm39xjUpYrbekO3S
	PUUUox4rg5Q4QcEEUWCjNZrY+h6xWqKom7gkIwQ+DqsvpP6ql3wo4+SPzQCgdYke+/y2EG2ajb/
	gbt8n2eTnV2ExnBhHUj6f2+MRHVVxE/V/z9qRD1c/31sBd1cnvERSrxnyZKw/YJMepGgbK9PSYj
	JZtONAAEdyBU5U64WICSyBEmS8=
X-Received: by 2002:a05:6808:2f0c:b0:495:fa73:2e44 with SMTP id 5614622812f47-4af5e227274mr18564363b6e.15.1785793997051;
        Mon, 03 Aug 2026 14:53:17 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58e9551dsm7403958b6e.11.2026.08.03.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:53:16 -0700 (PDT)
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
	greentime.hu@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v5 2/3] riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
Date: Mon,  3 Aug 2026 16:52:41 -0500
Message-ID: <20260803215250.824417-3-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803215250.824417-1-tchiu@tenstorrent.com>
References: <20260803215250.824417-1-tchiu@tenstorrent.com>
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

Also, export both symbols so the kvm module can call into it.

Signed-off-by: Andy Chiu <tchiu@tenstorrent.com>
---
Changelog v4:
 - Include the linux/kvm_types.h to prevent build fail (patchwork ci)
 - drop preempt_v_started check in may_use_simd()
Changelog v3:
 - Export {get,put}_cpu_vector_context() only to kvm modules (Sebastian)
Changelog v2:
 - new patch since v2
---
 arch/riscv/include/asm/simd.h          | 16 +++-------------
 arch/riscv/kernel/kernel_mode_vector.c | 19 +++++++++++++------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index adb50f3ec205..f176a8072c62 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -36,20 +36,10 @@ static __must_check inline bool may_use_simd(void)
 	/*
 	 * Nesting is achieved in preempt_v by spreading the control for
 	 * preemptible and non-preemptible kernel-mode Vector into two fields.
-	 * Always try to match with preempt_v if kernel V-context exists. Then,
-	 * fallback to check non preempt_v if nesting happens, or if the config
-	 * is not set.
+	 * Only non-preempt_v can nest on top of preempt_v, if non-preempt_v is
+	 * unavailable, then preempt_v is not allowed.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_V_PREEMPTIVE) && current->thread.kernel_vstate.datap) {
-		if (!riscv_preempt_v_started(current))
-			return true;
-	}
-	/*
-	 * Non-preemptible kernel-mode Vector temporarily disables bh. So we
-	 * must not return true on irq_disabled(). Otherwise we would fail the
-	 * lockdep check calling local_bh_enable()
-	 */
-	return !irqs_disabled() && !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
+	return !(riscv_v_flags() & RISCV_KERNEL_MODE_V);
 }
 
 #else /* ! CONFIG_RISCV_ISA_V */
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 307ac369c3d4..965c8edbe984 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -10,6 +10,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
+#include <linux/kvm_types.h>
 
 #include <asm/vector.h>
 #include <asm/switch_to.h>
@@ -55,13 +56,16 @@ void get_cpu_vector_context(void)
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
+EXPORT_SYMBOL_FOR_KVM(get_cpu_vector_context);
 
 /*
  * Release the CPU vector context.
@@ -74,11 +78,14 @@ void put_cpu_vector_context(void)
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
+EXPORT_SYMBOL_FOR_KVM(put_cpu_vector_context);
 
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 static __always_inline u32 *riscv_v_flags_ptr(void)
-- 
2.43.0

