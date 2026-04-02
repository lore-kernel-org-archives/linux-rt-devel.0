Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC931E32D6
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093492; cv=none; b=gQSXIubCa7RrXRlrtETlJNxgEhHnJ0J2BuBekMQtvyeOXT0THVbMh9xN7IfnKUhholmdN96e+oHlShW2GtpPOKs6DZUBn98h8Psd8olNaqNQQS2B8CR+n1vDtiB5ro/CCFyCRPZoEhZ/o0XpB68xNw55Oi588D8wJgUgBZst7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093492; c=relaxed/simple;
	bh=CmiCJDKKLtVBWY4PaNZhE3phmXu2DbyTzXQix20TwNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmKa1uq0f5dalNkUkRQQo923bdN+HvET1QKd4K9Nv01+inHZdGAjJTuBSlH4DDbtQSevRvfRwXuzAkW86BL6Hty+oYCYOvT+zPL46Ng82orfqbXFmtRCGyeOdVl/Up/LCANoX4TWGjmINVwYvcpNXaWbFOywfvNO2OYSqvCGVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgOG6sTR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgOG6sTR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b070f109so194968a12.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 01 Apr 2026 18:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775093490; x=1775698290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAh0rZ9dUNksvKcTzl6dU2+Jr09vS06UeooC9PWMHnQ=;
        b=hgOG6sTRNzJZBFZ3t4Al5ybX7DDFwQDxSPn09MldTRSGvztVxCB2jjn93UcE+4cI72
         9AFmz4BxIieraoq5/ISEOE1SZg13H3qTQU4gaBBGavQuCyE2U25OjaokvwOyC0h5hMfb
         MRG3hfVRn/XdLHSxSVMXrAul1fh1hg4He4+hjcS+03Ju9ETrObthpvzdnI4ifkF64c75
         5lB7jFTgshOC2y8/tYekgVAM91E4yLKaT5CfXPlVq1v84ntHr2Sh0xi1u1ig0TBSeA2q
         9YISTtzfLdIAyK/6w5sQAi0rkiMtCey4Zo9P3KWP6mqjrvKYXkSWVp3668vUQtN79DbJ
         DLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775093490; x=1775698290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAh0rZ9dUNksvKcTzl6dU2+Jr09vS06UeooC9PWMHnQ=;
        b=r3klor1hzE7hvDs49s9J0boQZlTH/HnXsufwqBzJ2cX5S4dfKsY0dNi0nDup06yMTQ
         3XVStD1AlBfFiLdOlulVlw8Q/LOvn7a7yORA38FqkZyp+pzJssAzuD1V3QP/Q3lVRZ3D
         YDfQBB6TzjoiPzH+w/7bjvJvkBx9qoe8K2kilC3MMW9USC7fJn5GonwZNoPqinu8CuIK
         3ZV9GmOG2sUJ8lzTV9xBfe/j1pksb4jKHBpq06P8bYoWBsMfTDDnTRt89jkAjupFJ4Lk
         Y6bsi5yxDh5n/qm+DRmFnVQ4nmJPz6QVNk0cBeOMfQr5zcuWDIpjou3WdLgY+FDkgjG4
         HTAg==
X-Forwarded-Encrypted: i=1; AJvYcCVN+XTQpjSwdt960zoKjur1pP3sFIlLHT0KuifFZQdOmI5S3iaCcxcJlZtNIoR2uocUagekGZmHC1LK8+kCLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxj4BH7MtxUkZRtDSKp+T6MKmBFvl3Ehsr0qtt4qWwfAV31qYI9
	xVc6C8rHfV9Ss4s3HSUY+XLPgJRXao7OfxHJEw3LccHTA3x6ziZ8fa15
X-Gm-Gg: ATEYQzx6AllbTQm+KooHMqd8+TLdYKnVutFiAiKhYo5ySYfJinT/IvOTGYsI4YBirnK
	fPJ18zNvH0SvEq4tfqCtjBqCHOi2BXPcxUSdj/dMb38O6zm3lsvZvDZVsdSiJ+ViJY+k5RaFtwc
	YHoKoeO3Bqjd6ub/DNvlPXtSBB4nUig7JRE9QcbTby1uscUlbv0UYIb8IQ0kSYAg9RQhQB1KPHI
	xO1EichoCgU7WoS2ApPYAgMw/ULlCCDL5aF6JKw3D6OV9QCMXBxgHPKP7JaOs7WpiSONsLKrW91
	bjya3dLy8q0i8PH6aePMxn/IMYMA/BvAB+kkyk0ymmPSfmuBNDuHRxaUyMEZuutybBNdbruPniR
	DtAUR9fGYwIYQzlLGhZyMd9EMtf8iqnGBWH/zuFpV/9O83/mi3n7wvdsI7jF1xtJzgh3hoXN1Sy
	PPOLGFfn6GJdq+Jn7zxI1JGtCWWVo+/2rgtgKXjO4=
X-Received: by 2002:a05:6a20:394f:b0:398:8026:4811 with SMTP id adf61e73a8af0-39ef77372d3mr6463370637.35.1775093489688;
        Wed, 01 Apr 2026 18:31:29 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.76.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41b8dsm1091851b3a.34.2026.04.01.18.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:31:29 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: pbonzini@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>
Subject: [PATCH v2 1/1] KVM: x86/xen: Use trylock for fast path event channel delivery
Date: Thu,  2 Apr 2026 07:01:02 +0530
Message-ID: <20260402013102.21951-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac08V4TaM2yh9SY1@google.com>
References: <ac08V4TaM2yh9SY1@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_xen_set_evtchn_fast() acquires gpc->lock with read_lock_irqsave(),
which becomes a sleeping lock on PREEMPT_RT, triggering:

  BUG: sleeping function called from invalid context
  in_hardirq(): 1, in_serving_softirq(): 0
  Call Trace:
   <IRQ>
   rt_spin_lock+0x70/0x130
   kvm_xen_set_evtchn_fast+0x20b/0xa40
   xen_timer_callback+0x91/0x1a0
   __run_hrtimer
   hrtimer_interrupt

when called from hard IRQ context (e.g., hrtimer callback).

The function uses read_lock_irqsave() to access two gpc structures:
shinfo_cache and vcpu_info_cache. On PREEMPT_RT, these rwlocks are
rt_mutex-based and cannot be acquired from hard IRQ context.

Use read_trylock() instead for both gpc lock acquisitions. If either
lock is contended, return -EWOULDBLOCK to trigger the existing slow
path: xen_timer_callback() sets vcpu->arch.xen.timer_pending, kicks
the vCPU with KVM_REQ_UNBLOCK, and the event gets injected from
process context via kvm_xen_inject_timer_irqs().

This approach works on all kernels (RT and non-RT) and preserves the
"fast path" semantics: acquire the lock only if immediately available,
otherwise bail out rather than blocking.

Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
Fixes: 77c9b9dea4fb ("KVM: x86/xen: Use fast path for Xen timer delivery")
Suggested-by: Sean Christopherson <seanjc@google.com>

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 arch/x86/kvm/xen.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d6b2a665b499..479e8f23a9c4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1817,7 +1817,17 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
+	/*
+	 * Use trylock for the "fast" path. If the lock is contended,
+	 * return -EWOULDBLOCK to use the slow path which injects the
+	 * event from process context via timer_pending + KVM_REQ_UNBLOCK.
+	 */
+	local_irq_save(flags);
+	if (!read_trylock(&gpc->lock)) {
+		local_irq_restore(flags);
+		srcu_read_unlock(&kvm->srcu, idx);
+		return -EWOULDBLOCK;
+	}
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
@@ -1848,10 +1858,22 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	} else {
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
+		local_irq_restore(flags);
 		gpc = &vcpu->arch.xen.vcpu_info_cache;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		local_irq_save(flags);
+		if (!read_trylock(&gpc->lock)) {
+			/*
+			 * Lock contended. Set the in-kernel pending flag
+			 * and kick the vCPU to inject via the slow path.
+			 */
+			local_irq_restore(flags);
+			if (!test_and_set_bit(port_word_bit,
+					&vcpu->arch.xen.evtchn_pending_sel))
+				kick_vcpu = true;
+			goto out_kick;
+		}
 		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 			/*
 			 * Could not access the vcpu_info. Set the bit in-kernel
@@ -1885,7 +1907,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	}
 
  out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
+	local_irq_restore(flags);
+
+ out_kick:
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kick_vcpu) {
-- 
2.43.0

