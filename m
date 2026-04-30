Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0A18E025
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558622; cv=none; b=hGHJ8q2fLHw2ZmwhyLDHqCiHzzL9ty+G3qD18lYP2xHLjMcnPiN0FsqtnrMYKKlH/MeGo91hNpjrRAa0JZlFPTJuuCHkWlxahC4JKwWCszgs9GZaxTmubqGlJqeX6rt7E6+1f+mwqs6r/uq8/HFzM1tFQxI7JC0MEtJqYiZOWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558622; c=relaxed/simple;
	bh=zii+nV2err+fyskK0vqQWcMICzkH2Dq/bzGZueIYXuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2zzE48pnMg0doVjo4nUuGugeLc2JVts7vGMCL/8EU2My6LQFcJA54Id7mZNddF2GJLNhU9hyPW9MOJ4a8nZk6rVsO/a+SyRvDTDsQ1yiCIyAn1rO1o/Y7fo/imdy3kxywiIt7ktch2uv7XMb2k1kK/EFgHpqcDuVAS47qBYifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMdxKrF4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMdxKrF4"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70c112cb61so598378a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777558621; x=1778163421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHo9iPjyCSduKMwgGnNHZX/dT+4HXSckBt2Ukm/+PI4=;
        b=GMdxKrF4QTV1bJYBAtZFLhUyh6kwTwFfJDasgOUNF0he4y1Bxm+a78Wckm/rdXEynR
         6cwIHWfvYoWALULv6kPR5oZ5tjEiH6Hd/LHWwN/fNhd4Y/U+KbWnr7EBI4L6RUiHlG8e
         sBzfVDLp/cBfvU6MWs3zYqti9XXBvEOKcxoTaG21jduryB4XRKhgn0ymUOQPs4DRvETD
         QwLxuSXkdEsdATunVdTodciNvrzIX6T3qU1zUf5pFVbI22F5TbHBIxY0mHKrw8ST4hLJ
         WQOyDn9xfmLVw639Kps82wIMQoqJQfci2NqM+709YyhhBpjekgnZ+OBj/v7SQ+n79WFk
         vtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558621; x=1778163421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHo9iPjyCSduKMwgGnNHZX/dT+4HXSckBt2Ukm/+PI4=;
        b=PRw/UOR/putBfPVOFj2MtaTH0ITP3mzZL3v7EMqe20/5YoD1/xbSneNa/jn6yZEQL2
         eKLiOqsfFpEj4PNERcX3GhtSBkZB4pGgZvPzBlM1ly/IgawD5OBI44pxSWpCIGPQcE8/
         ounH3jO6VEXehU4whO7sUfrsfYEHZSlfVoYhr2NP8B96L551VUdp5PpsScBpBw2E6hYX
         QZhgJK+7oqYrIXIow82R6Bf+ZJCnLpcezKv0vbwX0oGuXIRbRy+z4x2GIDOuA8UgSkpv
         ublqURZ4nT70Wu9ct/qwQwbBB7je4PBB0PuJsDtw9GrCAKn3V+HDUIWbnERKSNHuLEM/
         aFSw==
X-Forwarded-Encrypted: i=1; AFNElJ+8mFGhb56Cz6FHyUDRpraZ7iAA2TXYWQO7hkSorUBfzjPv/xPFDhWzA+NpPeU2Gn80V0+FRq6mbWvyu9hrSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbLZp8bzFnTr1WVL+HmAvQ7T5YfXNnofxsD5eJJjbH3BFs1uEP
	NDlHvOC8phRLUZcEdOR/gPMjPHDwuohdD840YuSEMtbki4I+NgAbn/Tr
X-Gm-Gg: AeBDievhQ6eKr1aRspO/lYozqOsbVdkaTTPlBQgccdHda4RARhnPiEofYQ+kmyMr/bN
	hPDzVFA5DQVkrHuH39m7HTKF2IVV/xihl2/etk0EfcoUj4SZtpTQ1a/Rb2Bmq5reHEAlD2mYH3w
	p5IWVyAN0tVUznBoD3zbwgRYkCmyvj8Q8Uz08ixHSEre1TXwoDqjPSTVAHezp0cpAOFD0Tpb17p
	+wdgxFMcZpXXurBfxgvUsyESC2JeqLv9NZJvlC+zEBK7yJN1DdE1DnuY+yX40cwQtsa34hq+O14
	fXpMQgNFFrWuNqnwWUBN3NoxNjH3LK/MvM+Owcnp53KPpgfQxcTIQzi+tapUMkSrF7bTYWyJMxU
	QIOxZ0X8fs6KTGEk5b8bQq3O/jzqut1ipmpbUOIJhXcsdchiZ0fATjEyaA1rbRr+OeN1cxL9zgA
	tQlll3lGunQloGOL4TTIvcrBnouT1ZZvm8MOhzhrqqvbJ1OB9U3Ks=
X-Received: by 2002:a17:903:3212:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2b9a23054f1mr22891225ad.5.1777558620563;
        Thu, 30 Apr 2026 07:17:00 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.92.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887ad80bsm57132495ad.37.2026.04.30.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:17:00 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 19:46:39 +0530
Message-ID: <20260430141639.10815-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
References: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
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
- __oom_reap_task_mm() completes
- mmu_notifier_oom_enter() detaches the KVM subscription
- call_srcu() callback runs after (SRCU grace period)
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

