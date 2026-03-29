Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECC37419C
	for <linux-rt-devel@lists.linux.dev>; Sun, 29 Mar 2026 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790248; cv=none; b=Dn7ddoI03DXwJWCFVIMk1n/8OH9YBG6L8d0IRnum6q+whS/H6g4MWEw3l6sznsIj+/y6R37R206MSiZ75AhL8yX9dcCvDPnz/mdTX1gkYljqfcMmFkulK+mspi4Bpxjga1UhznaIzHHTS0fKBsTJX6z8RlaQlBUikHiopcKXDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790248; c=relaxed/simple;
	bh=pmpqx1e9U+UK3wPkcTvBqSxmqbSIT871fIcbydBa3xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=op5jtYVw8Ay0YVlE4Mw3RkE0kG+fLG4kXYEgCp02EKDkY8aZffFmSPELRbU0zj+Ep9lz3r73M/WMJsHFVfCqpb3ejjqqwSX4GCJLQI/UuoUc67nVr1UnxJVYQbUZ3rlmOkfI18Txsf0rZMpg7wGQM7Xs9cZULsAiexvcjNd7L/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/rPKqB5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/rPKqB5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aae146b604so21531415ad.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 29 Mar 2026 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774790245; x=1775395045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UX+gGrIRP7HRhBCYkm8PVH6w9Y8VLiDpuR6eBzVdyw=;
        b=W/rPKqB55DVcS1lHgEzDyK+tkThF9JlJfcgPks0nFMpnQb8cRLz9xZ0EPglK9CE4u2
         p1reAPtrY0OX33vAHlUes2f62bZZRFy3RZ3tgQUhy3RXq8TMmpIRcqTWCiG9HYMYq/4o
         yDxlNnsfWafeWLh9Oxgp30YaK4x/iiJw5YehgGB6D5I15RcoXSZ1+Y0jkdGo1dgX0PYZ
         ds+ayKOSF53y44oApwc9MkJ2okjBfrpuMQmdsme038PbMfWLm+Nb4UjlvtBV88xGMNRu
         JKEvfmsdFUSzwk9RR6TBf7A5nmSvbKSqZYCqrlao46bcLVwCU+6WQuoGiaKADQ5V7FXY
         /6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774790245; x=1775395045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UX+gGrIRP7HRhBCYkm8PVH6w9Y8VLiDpuR6eBzVdyw=;
        b=lLzxSjhsQuoPCXk5lDhNgler9W7q0IwRdeMKPXVv0JDr/o+lPvl99bZDVh/N82CPU8
         dMXO7gmO/wLty61HLF4yWpAaAjl9c6uUZVr5ubboVHmsoyYaAv4QdlEWB57nVvDTHlwF
         oZKWNyTQCD2DTCXgE5Y8uPKoGvKLEbPWRF+Az5pcoybsBbeoSSuKuWwAUevsPmRIIdlA
         zoqh1CiPy6VRhPgtjoNKn1EiuiAGhwJWbCLU7Wm7CaZCbjR/MoqqH0dkONqomEZCpKOA
         tIRABnqrY8c7u3N2nuAtlMuN4M/3SfeEB351YQfKZzxXBQ09/jmHgEdQ74VgOeH2vTmE
         7t6w==
X-Forwarded-Encrypted: i=1; AJvYcCWLAAB+uyt5yEBNfED9RrUzO2vzShT+J4ch0YzntTpczOIXu6+qfQI89lhL6cs0lcslWuh8ueJz3pioS4lFXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQnkPV44muHmtjKMT2fyywrgJEctzoDmrUvrNdx2MDubURq1rl
	tj7sTKFHJ2ZkCw3UUpHHCKnO8aDD9+iaVtTVGaRbycSAe3v03BBzxHLT
X-Gm-Gg: ATEYQzyS0/Rf0ni3gb+/kT7fVgZvViGyuB5CRLyTsdkKFG15DfVy/aBODnpi5YwaU7B
	oTAO1g+gsBHKWdLLcr1w8/CeiflvI+ZMrUWya3vgRPRa0Y2mui6qBFe5A9tZBG5GzjEOD1QWFTe
	rixpPqn0WmpJYI1RtCG+vCt15nbFQ5TZHJDPYOdSGPE/kIm0DFDYgIpW2jjxjApS57h6hmHUhX5
	TS6uo107geDeI6P3DUHR0jYE3aN01rFFxnioY6NuUc5O0JWVxb2k6evwkZwZm66ENRs3tUe+3yA
	qCQiTwgdJo/BPFNaYKrDf5FOGxnnNfO7PtpWD5xuDTHPXzp3VIzBgyu5fCBoTcb18UWy2+2vyZr
	nphcWDqmhz0PXusV6R0EnlVM8m1AEWNeUayJ5nzMuC2wN9FW1AANWcqjP/txYiomwyIH3aqM4SS
	OLyka7mJbbnw/xaZ/KmP4W3FMmLjM9UhX1U4VfZwwmHg==
X-Received: by 2002:a17:902:e883:b0:2b0:6323:1758 with SMTP id d9443c01a7336-2b0cdd1ad56mr100407635ad.48.1774790244913;
        Sun, 29 Mar 2026 06:17:24 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.99.157.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264224esm50635465ad.15.2026.03.29.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 06:17:23 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Subject: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on PREEMPT_RT
Date: Sun, 29 Mar 2026 18:45:43 +0530
Message-ID: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT, kvm_xen_set_evtchn_fast() acquires a sleeping lock
(gpc->lock) from hard IRQ context (xen_timer_callback), triggering:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/5
  preempt_count: 10100, expected: 0
  RCU nest depth: 0, expected: 0
  4 locks held by swapper/5/0:
  INFO: lockdep is turned off.
  irq event stamp: 1766
  hardirqs last  enabled at (1765): [<ffffffff81678fd4>] tick_nohz_idle_got_tick+0x84/0x90
  hardirqs last disabled at (1766): [<ffffffff8b665051>] sysvec_apic_timer_interrupt+0x11/0xd0
  softirqs last  enabled at (0): [<ffffffff81289e76>] copy_process+0x1586/0x58b0
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  Preempt disabled at:
  [<ffffffff8b6650bc>] sysvec_apic_timer_interrupt+0x7c/0xd0
  CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.13.0-rc1-syzkaller-00026-g2d5404caa8c7 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
   __might_resched+0x30d/0x8f0 kernel/sched/core.c:10318
   rt_spin_lock+0x70/0x130 kernel/locking/spinlock_rt.c:48
   kvm_xen_set_evtchn_fast+0x20b/0xa40 arch/x86/kvm/xen.c:1820
   xen_timer_callback+0x91/0x1a0 arch/x86/kvm/xen.c:142
   __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
   __hrtimer_run_queues+0x20b/0xa00 kernel/time/hrtimer.c:1803

The Xen timer uses HRTIMER_MODE_ABS_HARD for latency-sensitive event
delivery (see commit 77c9b9dea4fb ("KVM: x86/xen: Use fast path for Xen
timer delivery")). On PREEMPT_RT, hard IRQ hrtimers execute in hard IRQ
context where sleeping locks cannot be acquired.

Use irq_work to defer event injection to a context where sleeping locks
are permitted on PREEMPT_RT. This preserves the hard IRQ timer precision
on non-RT kernels while avoiding the lock context violation on RT.

The approach follows the existing pvclock_irq_work pattern in
arch/x86/kvm/x86.c.

Tested on PREEMPT_RT kernel (CONFIG_PREEMPT_RT=y) with the syzbot C
reproducer - no crash observed after 30+ minutes of continuous execution.
Also tested on non-RT kernel (CONFIG_PREEMPT_RT=n) to verify no
regression in the fast path.

Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
Fixes: 77c9b9dea4fb ("KVM: x86/xen: Use fast path for Xen timer delivery")

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/xen.c              | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5a3bfa293e8b..533b45289d53 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -746,6 +746,7 @@ struct kvm_vcpu_xen {
 	u64 timer_expires; /* In guest epoch */
 	atomic_t timer_pending;
 	struct hrtimer timer;
+	struct irq_work timer_inject_irqwork;
 	int poll_evtchn;
 	struct timer_list poll_timer;
 	struct kvm_hypervisor_cpuid cpuid;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d6b2a665b499..01fa7b165355 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -122,6 +122,24 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void xen_timer_inject_irqwork(struct irq_work *work)
+{
+	struct kvm_vcpu_xen *xen = container_of(work, struct kvm_vcpu_xen,
+						timer_inject_irqwork);
+	struct kvm_vcpu *vcpu = container_of(xen, struct kvm_vcpu, arch.xen);
+	struct kvm_xen_evtchn e;
+	int rc;
+
+	e.vcpu_id = vcpu->vcpu_id;
+	e.vcpu_idx = vcpu->vcpu_idx;
+	e.port = vcpu->arch.xen.timer_virq;
+	e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
+
+	rc = kvm_xen_set_evtchn_fast(&e, vcpu->kvm);
+	if (rc != -EWOULDBLOCK)
+		vcpu->arch.xen.timer_expires = 0;
+}
+
 static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
 {
 	struct kvm_vcpu *vcpu = container_of(timer, struct kvm_vcpu,
@@ -132,6 +150,17 @@ static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
 	if (atomic_read(&vcpu->arch.xen.timer_pending))
 		return HRTIMER_NORESTART;
 
+	/*
+	 * On PREEMPT_RT, this callback runs in hard IRQ context where
+	 * kvm_xen_set_evtchn_fast() cannot acquire sleeping locks
+	 * (specifically gpc->lock). Defer to irq_work which runs in
+	 * thread context on RT.
+	 */
+	if (in_hardirq()) {
+		irq_work_queue(&vcpu->arch.xen.timer_inject_irqwork);
+		return HRTIMER_NORESTART;
+	}
+
 	e.vcpu_id = vcpu->vcpu_id;
 	e.vcpu_idx = vcpu->vcpu_idx;
 	e.port = vcpu->arch.xen.timer_virq;
@@ -2303,6 +2332,8 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
 	hrtimer_setup(&vcpu->arch.xen.timer, xen_timer_callback, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_ABS_HARD);
+	init_irq_work(&vcpu->arch.xen.timer_inject_irqwork,
+		      xen_timer_inject_irqwork);
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-- 
2.43.0

