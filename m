Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866017080E
	for <linux-rt-devel@lists.linux.dev>; Sun,  3 Aug 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754205713; cv=none; b=cn7P606PnabX+Jwn588tKelRfX5V7moVrgKSlwfsN9smPKNHgAl2y33uKar8n9dLJNbqfmf3EEyPZvduG9BqaWfGh4OYoA8lLQfOlob47Vbq0/JQ4Z93ablpEypSyqEAbqdlooNBVacQMM/BWPJrHjqkSbT5PDGWPWgc8kGCSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754205713; c=relaxed/simple;
	bh=bcY2L+w2W3FD7OVys+ViD2p8bbkemX9jfFW7WXsVmns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6hCHvQnZO3MkVCOaROf70PR0SCVZavuTYo3NB+yNHcrK2v72liFJ59A64lZ/klR6pIdwd9ocsa5y05KTi7Ow5zyQDBft4aqjXVfvz4c/QCYMe7jDY8SlxWoV/fs/mKREpAT9+XcCbW4i8p3jDsJKr/+qJIsljN448vZmb0784o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31ec291f442so583527a91.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 03 Aug 2025 00:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754205711; x=1754810511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFUScgwG+xBWsWyWWaKRGCTrL7i264F4pYGwsVBK3Co=;
        b=kVH/xZZN011XLCCdjU+M9tLH1o/e9HBkww5fKN1U1i4U0qunHYirCJB5MJOf4AKBQ7
         IacXt7k6xi8oMdZaNY8Ee388W7W9BcpB0/PGNfxpAluDBZXQxvsmF1mzl05zXNOPuKuZ
         PYGO7Kxdeh7Z6mEVhWPLfIWfImDyc5hDNPaQWTDZbIlf6SfD27iHrg+apuybAE0uKyU0
         SgdOZUtFBUZxaK1T+CeyoOC/lWdecF39tnuQ9DLNPq8OnPQ8OeyIMDbsXEB2rTRQmbEK
         Wr1MjcC5oRm9NyCT7rf1PNuh5+gDwh/g7NDGSsrrF+SvcSm3uOW9ARi44W2oZuc393f1
         5ghQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx8ZlPCxFZcUR/I7zQTlPo4GKeQYP7oeNmhQVRwIpMQAqYC4W4YI2+4ir86mQM9JlPkvAFw8S2F6pLUGeMwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZutd508j+2kU7iUu7gz69Su8rftIPJSSC3anNxJhqavEwlKx8
	7vaGls5Kf7fp5MRcHZuOTnjjC6dRbWWL59D8Tz290d+nfDeBN+TMqjxn
X-Gm-Gg: ASbGncudnyGXpdyjrWyZX3ICOVUolfVnDV0ewRIanvrqXl/fJ/HnL9vJe8qSGMS+V13
	LVkw3lo6nU3+fH9nsXgyu2sY3vPc/GDCfJWVP6Zb204jVEip4El31Py7bEdGOlW7vnNpruZmQDD
	jvLrqs34kmOd4v/JSA7LNvx1KeAiuB0vUS8nS7nM/h5oceA3ViZc13jnY3CnTNuB2BoxdKZKB9T
	8Lzptxh5RTBM1Xyklw3lGt9+dBDrKQgmIBoRrBkg2Od9jFRvBcbK+B6es/7zlWYG/eOIxh1HH1S
	McS4yGD/HK+1BggzGPNfj2a/GxMe4Fg6U701S2Ms42IwZVTcS2pkV7F4shg4wmIa3Q8QeVVUliT
	eIDJBHlWpHN/z
X-Google-Smtp-Source: AGHT+IHAx1g1rmU3WmTPsV4DTQv66chU6qy6HWfVYFxspZDp1m7ON0mbZQ/tEfo0w0NjbV8mHzECfA==
X-Received: by 2002:a05:6a20:5484:b0:203:cb2e:7a08 with SMTP id adf61e73a8af0-23df90a2a4bmr3470080637.5.1754205710800;
        Sun, 03 Aug 2025 00:21:50 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm4517004a12.33.2025.08.03.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 00:21:50 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Byungchul Park <byungchul@sk.com>,
	max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	ppbuk5246@gmail.com,
	linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzkaller@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH v3 0/4] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
Date: Sun,  3 Aug 2025 07:20:41 +0000
Message-ID: <20250803072044.572733-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series resolves a sleeping function called from invalid context
bug that occurs when fuzzing USB with syzkaller on a PREEMPT_RT kernel.

The regression was introduced by the interaction of two separate patches:
one that made kcov's internal locks sleep on PREEMPT_RT for better latency
(d5d2c51f1e5f), and another that wrapped a kcov call in the USB softirq
path with local_irq_save() to prevent re-entrancy (f85d39dd7ed8).
This combination resulted in an attempt to acquire a sleeping lock from
within an atomic context, causing a kernel BUG.

To resolve this, this series makes the kcov remote path fully compatible
with atomic contexts by converting all its internal locking primitives to
non-sleeping variants. This approach is more robust than conditional
compilation as it creates a single, unified codebase that works correctly
on both RT and non-RT kernels.

The series is structured as follows:

Patch 1 converts the global kcov locks (kcov->lock and kcov_remote_lock)
to use the non-sleeping raw_spinlock_t.

Patch 2 replace the PREEMPT_RT-specific per-CPU local_lock_t back to the
original local_irq_save/restore primitives, making the per-CPU protection
non-sleeping as well.

Patches 3 and 4 are preparatory refactoring. They move the memory
allocation for remote handles out of the locked sections in the
KCOV_REMOTE_ENABLE ioctl path, which is a prerequisite for safely
using raw_spinlock_t as it forbids sleeping functions like kmalloc
within its critical section.

With these changes, I have been able to run syzkaller fuzzing on a
PREEMPT_RT kernel for a full day with no issues reported.

Reproduction details in here.
Link: https://lore.kernel.org/all/20250725201400.1078395-2-ysk@kzalloc.com/t/#u

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---

Changes from v2:

	1. Updated kcov_remote_reset() to use raw_spin_lock_irqsave() /
	   raw_spin_unlock_irqrestore() instead of raw_spin_lock() /
	   raw_spin_unlock(), following the interrupt disabling pattern
	   used in the original function that guard kcov_remote_lock.

Changes from v1:

	1. Dropped the #ifdef-based PREEMPT_RT branching.

	2. Convert kcov->lock and kcov_remote_lock from spinlock_t to
	   raw_spinlock_t. This ensures they remain true, non-sleeping
	   spinlocks even on PREEMPT_RT kernels.

	3. Remove the local_lock_t protection for kcov_percpu_data in
	   kcov_remote_start/stop(). Since local_lock_t can also sleep under
	   RT, and the required protection is against local interrupts when
	   accessing per-CPU data, it is replaced with explicit
	   local_irq_save/restore().

	4. Refactor the KCOV_REMOTE_ENABLE path to move memory allocations
	   out of the critical section.

	5. Modify the ioctl handling logic to utilize these pre-allocated
	   structures within the critical section. kcov_remote_add() is
	   modified to accept a pre-allocated structure instead of allocating
	   one internally. All necessary struct kcov_remote structures are now
	   pre-allocated individually in kcov_ioctl() using GFP_KERNEL
	   (allowing sleep) before acquiring the raw spinlocks.

Changes from v0:

	1. On PREEMPT_RT, separated the handling of
	   kcov_remote_start_usb_softirq() and kcov_remote_stop_usb_softirq()
	   to allow sleeping when entering kcov_remote_start_usb() /
	   kcov_remote_stop().

Yunseong Kim (4):
  kcov: Use raw_spinlock_t for kcov->lock and kcov_remote_lock
  kcov: Replace per-CPU local_lock with local_irq_save/restore
  kcov: Separate KCOV_REMOTE_ENABLE ioctl helper function
  kcov: move remote handle allocation outside raw spinlock

 kernel/kcov.c | 248 +++++++++++++++++++++++++++-----------------------
 1 file changed, 134 insertions(+), 114 deletions(-)

base-commit: 186f3edfdd41f2ae87fc40a9ccba52a3bf930994

-- 
2.50.0

