Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43323304BA3
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jul 2026 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938682; cv=none; b=GpwNS6cWZjFAlz68CKD94IfnkdYpE7vhXv2EVNE0nYJ6rqUBWWX6lhX/NzDD7ZZiqHkpPdPjwTfHf9KnmCNXJPRQH28cPMqyfy3LD2JgUjsEWuvpbv24Z3thnI17/hySAOqtQ1vusPmydo2pFDTou7BQYKzRdrfVIVEMe02OJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938682; c=relaxed/simple;
	bh=XxPaqfAYKjeZn3sFsyCvWRBfcHJI/B4cGmsKYYY7AyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+658vwxM0CujLE2Hz2cqx6mYR7IvIgqj1QNqoHENpqCjetNguEEmvNlhJXq2HtHJRuPlJxp9d/UrLxfIR4Yl80n5oJ+MDipRmOAnJfKLWz+kUKK+vY2vSddjVdq9iX69BdZE5nmA600XYhErE80PBOytzXsK0xjGr/wF+8uHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=O4oFy+Iw; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="O4oFy+Iw"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aae4823f62so330923eaf.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784938679; x=1785543479; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYj46W8Df7hirMITCsNQUAF2P+9YRrFHR/TmGqySuFI=;
        b=O4oFy+Iw9qdyxhtByPc4CpFRgbTNsRWUQgPRJaTFQh6lIPPRHUXamBvahpXAd9aACs
         S+xjJOzEAqHronhhe61bhnGaQ/f/CWsTVKimzzzHfwcHhwTVCPeugBxwwoIxUVbeNeRc
         SYlfuYEZ6d0EVM4QwMh07U0i32Q+4QVDKb6iKpyFSkzf6aepB1Bv+KGzNIZBdgYsGsKF
         P/qs+Ikn2kPg1caI+UCkhsJ5Z37cdgxTDnYxLIZwiGpwdo+0NlRnCnryPkFHnosvOH9Y
         87+YWfq0suk3u8uh3kFHSbzU5OczontXeqkiFQ5aTg1VhQf5kF0K6AKgaXqVWVXTkGxa
         5ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784938679; x=1785543479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OYj46W8Df7hirMITCsNQUAF2P+9YRrFHR/TmGqySuFI=;
        b=ePELMs3CIxgTMHxkkdHHdTM+VMBDUB8WPB8PYrBRRM/nDzbh5JGaHIjvRekRdbBj4i
         Yy2IWzeykVOaJiwRNZFIwPYjWAybnPFLLsh/IMDE1jRN2Dr7gaIPzjIiWzKA1OJiKjLG
         dv2iqOSKilbqG84R4+06LSlJgItNiIVuvz8Qvd0A0LQ/G/CjcVy43jXwkkdfllD8ik8u
         uQS9htJrGYLEANoQVu+tuHiFgNrhRcC2f8F4tGHuYA1epNcxOziJveCnX63hWrCkeozH
         lo6FqdfXOhmXUxwFUDwBgZJYZuwU3VuQTqtrPYIJ4rMXJtdpFGSIRpmoJw4LcdS9/GAL
         9/uQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxVJrWns2cPZ8EoDUXsx2IJHaaJBxnFXrrKVDCdmzpM8sSFM1vANDaLvqkYCMI/r+w2cwjBnI7hEJ54FnBmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTmrQOBtN9Bh2NNMlinKF4ZdD4N/DOrmYXi8aCA5sxrFvh8ljA
	LKxMKFz7Rnr87nTUFpgd0Mdia6E5zjr3exY8rzOEA/DNOWKvlcKNcaqDf1EHqK2oe7M=
X-Gm-Gg: AR+sD10J9+k2z/ZoMwp9BV6c77pQHWDYIEcumsscsGNCZSnvssghrBdQ1qMOlwrAmvz
	Lm92ClrgpDxyHySxTkMKseDj8oSjAm3oZtwmdaPnhzq/hlf2isIGQL3rqlEmeZvWpr31aMi8Lc3
	FQRIgQ5mcxxYN+LJdpq6SlDSUjidtY9mIe1sInCLHWN+Dl0G0te+WgonA6FmRsvAOooERTj/FSn
	mdyTVa4GAb3qOO5ELVMw5g0/W7SZqguR8NkNhd3Chpnek9+7ud5a7IDCVvK3/VeLP6uyZ1gP8Tn
	eJL/4lydENJdgl1xBuuoSUK/qOnkV33vUekIOElYXQ+GfKMD/jqE8LElUkjL2eNN+HLUlVOBq1C
	gN8aQQ0bFyPZbO5j+vj8Ge4SZNR1DCjhB4IeSTzII1k6FbEgXQt7FyFp/3mIequtlbkdvJ2g6p0
	2y8X1Xz8bwSsbeytI2EyHW6DRznBFRteZQltI=
X-Received: by 2002:a05:6820:6ae8:b0:6a3:c5:30ca with SMTP id 006d021491bc7-6aaff9916e4mr432102eaf.31.1784938678681;
        Fri, 24 Jul 2026 17:17:58 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf9385b35sm884057eaf.7.2026.07.24.17.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:17:58 -0700 (PDT)
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
Subject: [PATCH v4 2/3] riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
Date: Fri, 24 Jul 2026 19:17:41 -0500
Message-ID: <20260725001749.2579274-3-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725001749.2579274-1-tchiu@tenstorrent.com>
References: <20260725001749.2579274-1-tchiu@tenstorrent.com>
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

