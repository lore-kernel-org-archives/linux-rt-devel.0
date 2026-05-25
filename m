Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA9356764
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738587; cv=none; b=mVcQpAk7Csf3S4VBoMgzSBd9uF6l9bFHd2EYFKHcIgmQRPvW1bqXcYV2VWmQCT5mKFutjx0Aueb15Prt0aJdd6Y7/iRjyZOOl9p4BsVFitqzaAuEogmHQWk04klfJLUYkJdSJDMRDB2xXJRVVSckYYr3dMl9L8yKGtb/KjFIkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738587; c=relaxed/simple;
	bh=hN2gTsGG00WZfAJH7F3jeYvGlvKV+w5hhNPlto0mhTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWYjnJxa1Z0Zd3WG+rOW0/w6Ekvr3YfL8gTeKVxE0YTq+sE336rAYu7YOx0qYoRLx6MenQ3Dj/djDi4L7uNdAXeTZfoWdln1t84Gx56iEV2jQPBJasv6LCZdQMEFdKnxebMzpLBaxCIgwXprP0MUIkBXIGr0RQSMBRVi3hrFcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SCEonHcr; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SCEonHcr"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso6910004eec.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 25 May 2026 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779738585; x=1780343385; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Yu9d6gTXgdP6EK+2IYW5F5Xve/jIZBNQFenXapvxDA=;
        b=SCEonHcrfFrn4K5A7RsTvag6fXhWTDvFHmiH7VDVaFoeLf7IQKHc+ab8XJ5LhefuID
         L50phyJScww0ryK0xGxO7puivB7VWCyDD5luWBuBZNf60KntRLznfvuINck1OpJQjmk5
         1Efjq7OBG5kUsP+nUwShtAV2hSlKBiaJhPnOjU95o6b6FWQhYFcaagIL9pXApeRgnVdl
         pKolgWuyOjBs2MmKLhbhlqaAga+wyvX3noFMaShuVccxEv090Ks/aAqJ+dmKa7hlPuu7
         A05nnfzRiSFhpvs3L9T1KHXPIC5u2jiidzmEgs+0EfQzJVK91URUpZueVYbsVlfJYDD1
         ei2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738585; x=1780343385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Yu9d6gTXgdP6EK+2IYW5F5Xve/jIZBNQFenXapvxDA=;
        b=H0xdUJZbBWvjQi69RK60czUfqZ+5jrSIxHFGu38bF+h1ocl5WB/sgcRZsdZ9eQYoxg
         zDCwCw1w8tZeugjelZylIzlzhnmMr+24WPPRi54ZegtFA/WcioYnG5VL70nDHCPcWDAc
         0CvIZUKzngSjVdtwaf2To9IIWcAndPNYf4mE+v+aLVxnvtRvuAWw7aKTAarIRKhuD0KQ
         zfe68uWuQ4WLZzxLq6eYhai97MZYl21EKH95yLeTPMKHrYn4YhvIL9lsH6LqDWOUpiPo
         QezgTIAvv5Pjb4uR5Ibp6To35qgq8PY3CksOQ4fLWjyvFmbB+ndAAYsnUS+/X5K0EoAG
         KJIg==
X-Forwarded-Encrypted: i=1; AFNElJ930jDwywWIaC0fy2sqqyCn8qZG88WDAzM+anJe3b5T3jpjOO0BQvxGId5XEDLJWlTMrsa5k/aRe4sl2b/mzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXX8pD57Tp4MPAETWGkYQnoQHUio1xZ+2S7gfwDzHnEjHZvLY6
	XVNF3TNzi86wmNC3vuDUl0faKE5atkqVObL/NJHAxerCz0ayP56HfpO/F2dluibWl30=
X-Gm-Gg: Acq92OEpTuXlt3KFtgYUdeWxVmhYWDBGJ8xXqKm0MPlpT2KhYJvMmP2EUElT7+9joPM
	N6St1t0S3ah5EA15a9N3zzT2+MoCg3Rba9fQgp6ErFxp9zrOmltcl/w/EISiDCQUqjUBDN/+N4Z
	L8ymFUWWgwbpeS5Lxwc19FThlvQ10IpYrzF8ftb+ydQLnFazi2BGnGdB8Nz7p29xM0TRCgY0oPm
	DozhMHLJ/6WsTG/vgAIR43CuvyfLHpLAHqw+nIuJa0BT9Av4YGZcE5vuBkv49oTRZ+RFJ7n1quP
	PkhBVhwpQ8M0cyehsY91qOyhsi0bhC71Dq4mQSqNdVTDoMRJK/WQJcXlXpWpyv/IW3pJzZh1stK
	1Yzhw569OGLf581FCVWVXrkATWPazw2eNEedYyDw67cYsWgdTxzdsNJLfoF+z6w7vajFTbyUj8y
	k8zstpm85wO3M3gi/BcvOZ+1B9NQ==
X-Received: by 2002:a05:7301:418b:b0:2de:e194:5fb1 with SMTP id 5a478bee46e88-3044a41ceacmr5620399eec.7.1779738584945;
        Mon, 25 May 2026 12:49:44 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:2feb:307b:ed4b:5f1d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm11032141eec.17.2026.05.25.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:49:44 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>,
	linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v6 0/3] pps: improve PREEMPT_RT performance
Date: Mon, 25 May 2026 12:49:29 -0700
Message-ID: <cover.1779733602.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

Michael is busy, and I have some extra bandwidth, so I've volunteered to
help out with the patch schlepping here. These v6 patches are based on
7.1-rc5.

This is all Michael's work, and Michael's cover letter follows. I added
lore links to the older patch versions next to his change descriptions.

Note that I replaced two emdashes in comment blocks with regular hypens
in patch 1/3, to avoid 8bit encoding.

Thanks,
Calvin

---
From: Michael Byczkowski <by@by-online.de>

This is v6 of the PPS PREEMPT_RT patchset, addressing the review
feedback from Sebastian Andrzej Siewior on v5.

Changes since v5: https://lore.kernel.org/lkml/719A31CE-CA58-45C3-A013-1BFE81F724C5@by-online.de/
 - Reordered: the pps_kc_hardpps_lock conversion now precedes the
   pps_device.lock conversion. The previous order would have briefly
   produced a raw_spinlock holding a sleeping spinlock on PREEMPT_RT
   (Sebastian).
 - Patch 1/3: commit message reworded to describe the handler split
   structurally first, then its PREEMPT_RT benefit (Sebastian).
 - Patch 2/3: refactored pps_kc_bind() and pps_kc_remove() to use
   guard(raw_spinlock_irq) for scope-based lock release. Eliminates
   four duplicated unlock call sites in pps_kc_bind() and the
   ambiguous bracket structure that resulted from them (Sebastian).
 - Rodolfo's Acked-by on patch 2/3 is preserved from v5; the guard()
   refactor is purely stylistic and was suggested by Sebastian, but
   please re-ack or NAK if disagreement.

Changes since v4: https://lore.kernel.org/lkml/B24484C5-3117-4C56-9522-1EE9876E64BA@by-online.de/
 - Patch 2/3: added Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Changes since v3: https://lore.kernel.org/lkml/83318241-44C3-48BE-829D-5C5F82A78A74@by-online.de/
 - Patch 2/3: fixed lost indentation on pps_kc_event() call
   (reported by Rodolfo Giometti <giometti@enneenne.com>)

Changes since v2: https://lore.kernel.org/lkml/1BB87C0C-33C1-45C3-B50E-C5F349DA3FDC@by-online.de/
 - Patch 2/3: moved wake_up_interruptible_all() and kill_fasync() out
   of raw_spinlock section to avoid sleeping-in-atomic on PREEMPT_RT
   (reported by Nikolaus Buchwitz <nb@buchwitz.com>)

This patchset addresses three sources of PPS jitter under PREEMPT_RT,
while being fully backward-compatible with non-RT kernels:

1. pps-gpio: The IRQ handler is force-threaded on PREEMPT_RT, so the
   PPS timestamp is captured after scheduling delay rather than at
   interrupt entry. Fix: split into a hardirq primary handler
   (captures timestamp only) and a threaded handler (processes the
   event).

2. pps_kc_hardpps_lock: spinlock_t becomes a sleeping mutex on
   PREEMPT_RT. Since pps_kc_event() calls hardpps() under this lock
   and hardpps() takes the raw_spinlock_t tk_core.lock, the nesting
   is invalid. Fix: convert to DEFINE_RAW_SPINLOCK.

3. pps_device.lock: same issue as (2), in the PPS event delivery
   path. Fix: convert to raw_spinlock_t and move sleeping calls out
   of the critical section.

All three patches are tested on a Raspberry Pi 5 running 7.0.1 and
7.1-rc PREEMPT_RT kernels. On non-RT kernels there is zero behavioral
change.

Michael Byczkowski (3):
  pps: pps-gpio: split IRQ handler into hardirq timestamper + threaded
    handler
  pps: kc: convert pps_kc_hardpps_lock to raw_spinlock_t
  pps: convert pps_device.lock to raw_spinlock_t

 drivers/pps/clients/pps-gpio.c | 37 +++++++++++++------
 drivers/pps/kapi.c             |  6 +--
 drivers/pps/kc.c               | 67 ++++++++++++++++------------------
 drivers/pps/pps.c              | 16 ++++----
 include/linux/pps_kernel.h     |  2 +-
 5 files changed, 68 insertions(+), 60 deletions(-)

-- 
2.47.3

