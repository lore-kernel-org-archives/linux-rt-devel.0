Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AF448BA7
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911821; cv=none; b=Hzs01zWoto1eeAvZ0jXxauIvfxxKCy/6lDLJb398uZxatZU2wzCgFBCMUM2E3hpKCi+y0zq53kaS8xgmAuarM35Ac2QlphCKq8gK+H+FouO2P0hQHryPKyDNPTuUwqRJc1FI6CdPNcHHLfCrIEcGrj9rvqi3xFFHrALsnj1xFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911821; c=relaxed/simple;
	bh=3cO5Pby2B9cMKgHAiYTptVKmaMmxIRoRYqjVmfh8kkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5XNsJ/ERyH5WrwTRjwEsHdXVYj7L+7HLkqKDh+E6vKvecTisRd6Z6V4F6CW9vH0qMVrWuWL9NnMOQoQzpAQef5Gl+wHWXpgivC2G1P/PBttxWhiZ+/mR+DkvG4Rll/rGfUak/colznkbSfzZPgMIaLxrjr2/Nc2sJQ8XWmZzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=gCNS1RFA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="gCNS1RFA"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6aaf2f9ce3dso215040eaf.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784911818; x=1785516618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5IUFt86dCMeouqveB0y7ovO9azpKFmoPUqPgEE244Qc=;
        b=gCNS1RFAI4/ai/pYPM5K4mjFuJY0KlX5zPfjO31d8gPKlQHHMrnPIIV78RHsLi6EkZ
         IW07kNwMh8v93uUgpgObiULpVSRjY0nHrRHs8aevMy2xL33PRmdXUqk7ieYIlv4XbdCq
         BqK0iC94mmzMdFz5weDzugB9cEF6wWWPKMZCVCCPHJDwaqwuk7vyd/iMHdCi9yo/7zUX
         AXLrrOSWrFr/tCNPlfYabdSCZ3sPkMD93gWRYWxU9FUVdl5ciIvv4LNzubvdfRpMruXt
         SATocHgj+7cbI3nKv35+lOBfRa8v59taYoVtux8qeVajrH8Ll2uIhprfkUd7609lNUbO
         F6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911818; x=1785516618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5IUFt86dCMeouqveB0y7ovO9azpKFmoPUqPgEE244Qc=;
        b=MCK7biEeDzdSFc20GVP5ozc60C2hCY4Lizh8fiGm8+h01CPiiANGcV/qUw0mOaDRDd
         9WuzcDpqESYxFHNyAmk6BqnQKwa4ZtHtduu4eEFlArPdJppjIMR1akYSNhVYIFIRsSB5
         A8QBKm/ZH2/cZ2INjaK/iKFRYXWaSi4M7u2xOqUIENWLuZ0waLtVJXpEGdezBUQlJJ1Z
         U0AZvxc7wxCXCY5Y226YTzH9/qj6ctZ1V41EeEwKW4r4jVPUntN2JG01Mq/C2bx4kIBy
         IqyuQZzx3LwROOVW2t9w+pL0cRU5szxKpem0pKAtW6cGmNEAfVPIFGahYtFaF9t6x2c7
         YMsw==
X-Forwarded-Encrypted: i=1; AHgh+RrAydGDjRgFSCCb+XO//8eniaIYFePvOlvJhgA9tGIwh7Np18eDqeoESs72E5RtdAa9w43bAOLcRGU/UFSgMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsAmUipcI3NK820S4mT2TSM4eFV9aZmarTrn7V7qe9Ah9AK/Z6
	NSY9k3fNXZY/tV8YubrLEQbs+/n7gyx8QAOkgKWnQ17TB4aLY1VX47gKNu4eQUbCjWs=
X-Gm-Gg: AR+sD12KfzigJl9CNCVWE2Am9CBbxvUFbIsMY2J9JxBpyVeYM0rxUlh8FqQFABVmWIs
	SE50oNk4MooPdBfTwrbysB7W37lcHbxlOUznULJHs/5a4ozUaK+3IJ/LpqH16Ux0keNyiGlBdk5
	EIvZZhTi0Ti8DGHBQTHtaM+idBG8pe1Ke9HIviDKGOaqrcjTTHkF0jBCuSaCyaXHjFNfYXeB2UY
	Jw+gU3uRUgNpQDjpzgkgXSzn4i0brqhrdxkrAvbR6mXohrL4RQ9UFEAAgkqDpiULDDHWggcZuwF
	Be1KupQqjQnigf37NjXiTM0etnaAUM5bS+pgbSseVn/+WKmrGJdmUW/vQHlokw1XDCvHdZTHT2H
	39Z1u45Hfl6LFLopZQJs7a7qyiQu5ymPWtklnKdKiZxmcMkQRtDSxwCbUlRTbn/FCgMfl9YOoaE
	inLYWtwMI8hKWVfUzovxx+Kwax8pAD/YnjspM=
X-Received: by 2002:a05:6820:4c03:b0:6a3:8cf6:fdf6 with SMTP id 006d021491bc7-6aad418cb97mr4265835eaf.48.1784911818341;
        Fri, 24 Jul 2026 09:50:18 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf96f4501sm210882eaf.12.2026.07.24.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:50:18 -0700 (PDT)
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
Subject: [PATCH v3 2/3] riscv: vector: allow non-preemptible kernel-mode vector with IRQs off
Date: Fri, 24 Jul 2026 11:49:53 -0500
Message-ID: <20260724165001.2317788-3-tchiu@tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724165001.2317788-1-tchiu@tenstorrent.com>
References: <20260724165001.2317788-1-tchiu@tenstorrent.com>
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
Changelog v3:
 - Export {get,put}_cpu_vector_context() to only kvm modules (Sebastian)
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
index 307ac369c3d4..f76e52de1117 100644
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
+EXPORT_SYMBOL_FOR_KVM(get_cpu_vector_context);
 
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
+EXPORT_SYMBOL_FOR_KVM(put_cpu_vector_context);
 
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 static __always_inline u32 *riscv_v_flags_ptr(void)
-- 
2.43.0

