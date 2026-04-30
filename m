Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51579363C55
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777524196; cv=none; b=Co4PV67VWnz+9mtOOZnTX8BA48wDvQEyIf5StM20MyZnd5rdvSWSU1C4vi85yljAgXPKVf1Z5CuF8qWNDi6TrguIehx8a+SFb/9ZSXJzMdBPPDnhuhbRQry/HCDqRC6UvZCGoCnPLfS0AkSs9I+OpDmyK0LfsVfGXvEC/+J/Q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777524196; c=relaxed/simple;
	bh=VwTWPTxcmD8Q+mU2ivc4k8RfaZQ5s7GGiDf5PcxClEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcWnZ2kmzDhemCRgYCuFiJUcSqyehLdnUsN/d/+/wrFI6ozu0lqDIHzpxT3sZgewSvJx9iUhpML49P+CDIpju3K+Sed5wa7mKTbml5y/0UKDXaNd7D6ZHXHvAwYAp3/01uhiKKztKHTv65MuT/ZHAv0VIMx4XJQie8UE1iokVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijDcrhUb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijDcrhUb"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c6e2355739dso161021a12.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Apr 2026 21:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777524194; x=1778128994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R56QgG1D9bXIBDN7pmrJ8rb2E5GLXsJR+QR5OWKoEXY=;
        b=ijDcrhUb8XiYgfxxoj+ROxxGqIlcCvGK68OZzSW5WADCDxHw77S0rFG3OYoDIWOp4l
         VHv7L5Wu0CAkewiRpDbQchI/9uRtd1I+e/7BI/4bVaKeFU2bFSox7Ka6bx557MnMbxbi
         5sqlnAWFxdAfkx9Hi0lEI7wJQpx2eVM7dhDdvGkEPA6ZJl9vSAM3pfFN0QohpfrleZOr
         ekqT1fzeh9OHLN3ib7xP7VBlpVt7/YVnO/nmDobQRvw5LRwZsADAXughxpHSAEjYfJR4
         t7C0tZz02HkMiI5dktO2bRN0W3LTiJzYMsTTb6QWtdBxnvgp5UKKtzpixuhv4OiNjh6l
         2vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777524194; x=1778128994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R56QgG1D9bXIBDN7pmrJ8rb2E5GLXsJR+QR5OWKoEXY=;
        b=LlSMsopPk4rIsltTpsF2ZNycYGAcghSS1Zn6DCe11UhhsR+fSK9k0y62maYlVd25ug
         BCFXGQr7zm/mN8kBgIfsWMAK5/l9B1gKdJxvGteTmigbKTNt/mgdPuU9Hd+gkCq+QcBQ
         ePTGZo8MoFS6CRVIvyEUD5P7DLO7iOl1BYB5jH7JTl17MtINAurXCCE2VXZpV8bED0GT
         2OfzEvziVrhQXXc/jcau+xkAS2xAj+5XaoRJI0wgD4dzbESruoqv/w9inH+0al1m0zrX
         ZTx/3wsH8/3S4BlVAlWG7eLdR3IzCI9DbXNjtbi1l/9mK/B2N1M4sUja9uaCa6NBu0a5
         DjJw==
X-Forwarded-Encrypted: i=1; AFNElJ+g0a9fvrhJNyffiZE/UFjl5x7cjcJvOpoduPJR6H91tfmY63LRowG9NNyeChZxPuON1Bgd8nCfA2sdAezzYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzdj85NFaydr/qbx1RyeAAqxQ98wZnsHIBa59C7Q+avIU5yrBL3
	l/Ds+KN8XigYQUmoiujDTdtmEN/E7Z8vnDSNPS1nIZr2BzUj1ZCHWXDk
X-Gm-Gg: AeBDievh5QMVUhH9b/NMD1vy/LQ3riUUno0ycBUOOAQwqHLDBs9yU1ucd1qh+ryuPKb
	qIxiz14nhCZwVYKaLnsnoKUtP58F2oPYS5HsfMjVGkSrW33u9klPTrr1mYxAa42Fe30Ed/h3Rga
	aiVYR2tqMIurPseybfB4Wbeqiqm9yAqmSO7O2FJwIDCxTO/NRR3/em6s7b5CWL6fZ0Bx7puq1ID
	r2mLh4cWOKSxRKwyhpjVkNRilrhCxZqA0iCYdvlj/bbG2/SBm1BTvdMW1SpduakRQSUqB6xdHZ5
	9UuBLtb2O3bvzj2lNdjKXwdp3RGcSCWEWdZa0c6IukE8J1PmrlHYZHvm5CtFwn5cmkjjSbPuCpj
	wM4sHfO8GQcqE0yiYXwjw2qPd9rYeOC/cCyLmn2A3dNIJZtKKREkN5t7L5GXHPTWaaHRMUL0nVi
	ECj4B6OlZJibT9VZGE23iboFv0v8f00CqQsgOTOyDmI7nc4RPXQ+I=
X-Received: by 2002:a05:6a21:6d88:b0:39b:da83:91aa with SMTP id adf61e73a8af0-3a3cf8cbdc5mr1452663637.51.1777524194416;
        Wed, 29 Apr 2026 21:43:14 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.92.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd5e6e830sm3752482a12.6.2026.04.29.21.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:43:13 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	pbonzini@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Subject: [PATCH v2 0/1] mm/mmu_notifier: Add async OOM cleanup via call_srcu()
Date: Thu, 30 Apr 2026 10:12:29 +0530
Message-ID: <20260430044229.10736-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements the after_oom_unregister callback design
proposed by Paolo in v1 review [1].

The current OOM notifier path calls synchronize_srcu() inline from
mmu_notifier_oom_enter(), which can deadlock on PREEMPT_RT when
locks such as siglock are held. This series moves the cleanup to an
asynchronous context using call_srcu(), allowing the OOM path to
proceed without waiting for an SRCU grace period.

Subscribers opt in via a new after_oom_unregister callback in
struct mmu_notifier_ops.

KVM is the first (and currently only) user.

Changes since v1 [1]:
- Implement after_oom_unregister callback in struct
  mmu_notifier_ops as proposed by Paolo
- Add mmu_notifier_oom_enter() to detach subscriptions and
  schedule cleanup via call_srcu()
- Add mmu_notifier_barrier() (srcu_barrier wrapper) so consumers
  can wait for pending callbacks during teardown
- Move call site from __oom_kill_process() to __oom_reap_task_mm()
  to fix KASAN vmalloc-out-of-bounds observed in v1
- Use hlist_del_init() to keep hlist_unhashed() correct for the
  kvm_destroy_vm() detection path, avoiding use-after-free on the
  stack-allocated oom_list head
- Add KVM after_oom_unregister implementation to clear
  mn_active_invalidate_count
- Update kvm_destroy_vm() to detect detached subscriptions via
  hlist_unhashed() and use mmu_notifier_barrier() + mmdrop()
  instead of mmu_notifier_unregister()
- Remove pr_err() on GFP_ATOMIC failure per checkpatch; the
  trade-off is documented inline

Testing
-------

Developed and tested under virtme-ng with PREEMPT_RT, KASAN, and
lockdep enabled.

Test setup:
- simple_kvm.c: minimal userspace program that opens /dev/kvm,
  creates a VM, registers memory, creates a vCPU, and sleeps
- CONFIG_DEBUG_VM-only debugfs interface (not part of this
  submission) at /sys/kernel/debug/oom_reap_task to invoke
  __oom_reap_task_mm() on a target task

Test sequence:
  $ ./simple_kvm &
  $ echo $! | sudo tee /sys/kernel/debug/oom_reap_task

Observed with patch applied:
- __oom_reap_task_mm() completes in ~3 ms
- mmu_notifier_oom_enter() detaches the KVM subscription
- call_srcu() callback runs after ~57 ms (SRCU grace period)
- KVM after_oom_unregister clears mn_active_invalidate_count
- mmu_notifier_barrier() returns cleanly
- No KASAN reports, no kernel BUGs, lockdep clean

Stress runs (20 iterations) showed consistent results.

Reproducing the syzbot-reported issue
-------------------------------------
The issue reported by syzbot is reproducible on an unpatched
PREEMPT_RT kernel, triggering a "sleeping function called from
invalid context" warning in kvm_mmu_notifier_invalidate_range_start().
With this patch applied, the warning is no longer observed..


Known limitations
-----------------

Failure of GFP_ATOMIC allocation in mmu_notifier_oom_enter()
causes the corresponding after_oom_unregister callback to be
skipped. The OOM path cannot sleep without reintroducing the
deadlock this series fixes, and synchronous execution would
require waiting for SRCU readers. Cleanup still occurs later via
the normal unregister path. A mempool-backed allocator could
address this in the future.

[1] https://lore.kernel.org/all/CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com

Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

shaikh.kamal (1):
  mm/mmu_notifier: Add async OOM cleanup via call_srcu()

 include/linux/mmu_notifier.h |  10 +++
 mm/mmu_notifier.c            | 123 +++++++++++++++++++++++++++++++++++
 mm/oom_kill.c                |   3 +
 virt/kvm/kvm_main.c          |  27 +++++++-
 4 files changed, 162 insertions(+), 1 deletion(-)

--
2.43.0

