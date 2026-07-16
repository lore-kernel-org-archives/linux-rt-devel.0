Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CA346A1D
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184074; cv=none; b=lnRdk8M9VHTi75GKMB66O1k8qLz1c7C4K5utQGJPjZnXc9z52ZxdsrLPyD6uQiwcUj4IGwmTxTJDxTlB58+tjoy1tiaglDzzGY6C4c25GjfZ+26VZDekyhx5rSXL/2Yvp5x9WJiXBcz4RBQD1d/AeKxqXZmrYeoF7YG3z1xDehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184074; c=relaxed/simple;
	bh=ARwBqNXy7iYAR/zvzCQFr6JDEhfZR9bP5dOWQAURFD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEwwdM+486jn+PH/StoRy2P539BFB0M0ie++uiW8mZ90P7NARuuGQ001D6kzJ/sHk0ZV6VJYWrj3KDrnWVOFUQCqwvIyTLKgb8BJVUoIOshoP/sjmLxs1I69y2R7FT23xLi9uoZGxLxb5Pwo3P+SavkA7FSP2sqczumwwYHiqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du9uDPqC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du9uDPqC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e7391839cso2693817a12.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784184072; x=1784788872; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8J2PB70MWAXXQG95F609SxeXRC3aZLcryE0e4szEh2g=;
        b=Du9uDPqCn5ELWFbHqYXvif2DJgARr729rlHBvhQRTygFPwVfxre24jclm98brm/Oxr
         iijiN2JRwi0kN48d/3u4XJ/1n/GVVoB327BioCGTAMAjc+gPTaNhZXNNRrzXPHXpoJnq
         Y4DzUHEwWNWjt/Kz9R9ReLL3VXyByBtMSD5H4l8SDo8nBvYNduxnYXsmISvixJ9NFP5W
         +YxlhaqGHw2uSfxl3ZrKFIuTJgO9El86zXUaJ5Rra3c5JYF0mzF2VdQby+Ln6m2Pt4/m
         Or9pi21WB1vhurHqPmjiStCamcujGuQ70/cuUj9UPtdaynKhYREAkb2I3aMH8ICqdqTp
         iLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784184072; x=1784788872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8J2PB70MWAXXQG95F609SxeXRC3aZLcryE0e4szEh2g=;
        b=MvFfCdHBy41mXlhCYedzuavEgWlZdhSRqUdnckD+8+zTWnYoW9P5Lz2anolOw5R/hl
         iwtjLKGW/aCIGaijX1Ig4S6vbT9iIC2U1qy9vMN3XoGrNzASTmDfhQpY26wF4FP3lqOX
         4qHyHghTk1mYWQkQR2Gn1VkpEP3jkA5UMJsCkxCFIP/w++F+sidNT60oKy8GmqxtWTxW
         +86OJZPg5o/16b/XH4Cb/jdw+0iLFmGawrdDiz2iDqHi1N40kdBW0LoTKeBZzmW9s2u7
         c1xkl7MvvyQzPSueN00weKJFOoie+/XBxOUNRSjFf4UvEJkFSFVyb8bq9zB+buGYjknj
         bNiQ==
X-Forwarded-Encrypted: i=1; AHgh+RptzoVB/Ledl61prQ1RV7tY+/R/rA6Y2SIHBtJeVQIzqvAKdcVosfQXp8DSqe7gZRV1et6nE6Xoq5Uynu9Q+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxponfBTjA5cL5V6r+lmZ3kHD6phG2mP3QfwjcFiK+1F+sQ/txx
	zuOXsipXkoi66ibY8+VKVlMyhdQNBJ1lSArjV26CHzXIE1pMfSAi9MYR
X-Gm-Gg: AfdE7ckpExPaphmV5x5u8ohNuUl+qlSh0htKi0MwCnC6gfWVSEkuH5TqgqVZu1HQU5n
	wFkc9KD+Xt0KAXiZvU+UYqUV1GkZVijNnQihTrvy+48zhZrvwCDiC49GnSYQR8UsxbTBpVTK7Zs
	LjqZx0fEQht5SYYzVvb96/Vg0orVDf5pN7KrqZotHqPTDGhSggJfEHrL+mhKiBwvyIaLBtGleBt
	DBVyGmwzF7ex+r8djw52AWVu2sPkt7JaPwh033/gC52qx7gTizk7qJGUzCK80iR74AhjS9Yp5ys
	5x8r2IGmi01lqtjAqV8xFiSmin6NIl86Ut/uZJWYaN0tp3QomOspWLlho6PE3u9UWbGd1azpAI6
	f2b97MQx6X1jMyLGtKhloAbzE4/4ZUfUil60nqR9I3AurfoXFtHtxK3a9916cFEhIKJSsEMe6I/
	X/d48fkiygNORSMvgMCH1y
X-Received: by 2002:a05:6a21:495:b0:3c0:9c1b:d0b5 with SMTP id adf61e73a8af0-3c1109f44ebmr22579230637.64.1784184072215;
        Wed, 15 Jul 2026 23:41:12 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb856dsm1412425a12.6.2026.07.15.23.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:41:11 -0700 (PDT)
From: yhchen312@gmail.com
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	"Yuhang.chen" <yhchen312@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critical section
Date: Thu, 16 Jul 2026 14:40:11 +0800
Message-Id: <20260716064011.2387501-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yuhang.chen" <yhchen312@gmail.com>

The VMID update critical section performs an IPI broadcast via
on_each_cpu_mask() on VMID version rollover, which must not be preempted
under PREEMPT_RT. Convert vmid_lock to raw_spinlock_t and use plain
raw_spin_lock()/raw_spin_unlock() (interrupts stay enabled, since
on_each_cpu_mask() requires it).

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 arch/riscv/kvm/vmid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
index c15bdb1dd8be..21c2b276b55d 100644
--- a/arch/riscv/kvm/vmid.c
+++ b/arch/riscv/kvm/vmid.c
@@ -21,7 +21,7 @@
 static unsigned long vmid_version = 1;
 static unsigned long vmid_next;
 static unsigned long vmid_bits __ro_after_init;
-static DEFINE_SPINLOCK(vmid_lock);
+static DEFINE_RAW_SPINLOCK(vmid_lock);
 
 void __init kvm_riscv_gstage_vmid_detect(void)
 {
@@ -78,14 +78,14 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu)
 	if (!kvm_riscv_gstage_vmid_ver_changed(vmid))
 		return;
 
-	spin_lock(&vmid_lock);
+	raw_spin_lock(&vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_version here to ensure that if
 	 * another vcpu already allocated a valid vmid for this vm.
 	 */
 	if (!kvm_riscv_gstage_vmid_ver_changed(vmid)) {
-		spin_unlock(&vmid_lock);
+		raw_spin_unlock(&vmid_lock);
 		return;
 	}
 
@@ -117,7 +117,7 @@ void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu)
 
 	WRITE_ONCE(vmid->vmid_version, READ_ONCE(vmid_version));
 
-	spin_unlock(&vmid_lock);
+	raw_spin_unlock(&vmid_lock);
 
 	/* Request G-stage page table update for all VCPUs */
 	kvm_for_each_vcpu(i, v, vcpu->kvm)
-- 
2.34.1

