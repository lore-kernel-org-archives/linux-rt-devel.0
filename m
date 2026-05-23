Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F036A374
	for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562293; cv=none; b=aS/pmtohCBq73yrvF25xWa6nvoFL6Q2EdrD8vOL6cBQxJbUJwJktv0KKw1j8OVpdSLqGNprCiRpH65BYT5AGssVRHUtQGkxL77tCsrb0YHVXQLJwLwh3rdbWAcpW2PCVHAzYdWVXe41H0+nv+3DHmU/pmmBhXUetahUAv8Nw/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562293; c=relaxed/simple;
	bh=JEkNE3Lz6tOZdCtt9tbH/hfLjFXUU5qnknFzHKrT17Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lG8U8y1Y92JxULAw802l9yrJ/7LUC6q2TLgRuQrWAP8r5Qqz6qRqEteVIbixlSHkdvUzSbAM9cWMgMzGqMZ+2A0RpMIRgbmIGW+Tk0sETwWms2pTdGBGkwR5W8SUFz5IO95qOQSmHMju4zVFI9vvfxTUbg4CZK6hn4OxliSYvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRfeolSu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRfeolSu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso52323565e9.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 23 May 2026 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779562290; x=1780167090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ft4nNrAXI8vhYmPV6zzABvor6jykXPGjask3Bth/uk=;
        b=eRfeolSuTCge+WoW4CCUOuEKikUp91GxoV2FBpGcD0B3kk9HfYnlW/PUKhLIyUlBNv
         x5iVFeGFdSwDs7jiMtjXuRwTfEaSpq8i8+oWXVGDitZPK8DFxJHMsDXbK88ltxgt3+aa
         5/Y+AQcBLUUcxa6hXOAHOe9Qkgw/0JoQ6v8vSe9yx9vIhWkp7jlzzvlOT0ip5xccmkTu
         kc2TFcUyGQGj8m5QpJpePWXnqnzbSTQXmVomP9dCuYSsY9ymvGIIj4QYHrO58lz9xClI
         Zi2eRXl/Qlqx10Rz095Ag6CJtfUMsbuB2JHieqK+IrBGXXLA60PhIAW9NchFDDPHRnT/
         2fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779562290; x=1780167090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ft4nNrAXI8vhYmPV6zzABvor6jykXPGjask3Bth/uk=;
        b=CczhBXvxLY4lWDdo1n2kI95KbtDjsCsGO9WsvrZJdgyz+pUFP/WYNcykPvJ/IQx2FI
         AN8HoWsKGxB9f3drD4yWBiG1RpeGIzQ/2C0UR4/qY//WYj1aW+xf/FS0tdu4byUTJDkA
         U1syG2yiCjepZtTvnwAJwvavFI91kCqcyUXn6YXzrJYNUqdwAXu48ibpwBcWmKwcpELU
         0Dnqu3G94hZ+oZM+ZjlYEXAJEVY6J7AXaHSbmfrhv/3OnuhemMJD3J/X8klzCdb4WTly
         yelYk4ZqVkBggjF6Ed9UY9KrezomPCG7jPxGAtl7YO/UcDAM7wQx+ZAoTBaecBPU0JCr
         lBiw==
X-Forwarded-Encrypted: i=1; AFNElJ+hExOVumyYJKNURA/g/sJU/vESc/wZCOzBimtG5/IUunfcLaSZe2y4sKgJng7HDs2F9giBNu4T9QPtDNmvwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzxNkqO+S1rnmiYa6DRO9KdNxyu5PNUNPAeBup8MwQSRTEB7zJ
	AlKefW6SUaqgyVypdW/NbW+8d/wH2WT9JiS1bSFI9Fi2c1qit92JHGIJ
X-Gm-Gg: Acq92OF5GrXPDTGh+QzLdMw7gvf7Q2O1TxzyAsklbvsUkQWQ+5nDyNtr+2NGQifsi6w
	WKtaC/wYyhvT3VDp2Y37AOYxgPG2Tz97CNm72vtgDfWNGuzMvzjbGMXEOAFX/ZngGOenrpppQun
	rsmUk/jymCYzfKpiNAPCRd/lDuaPVC+wzEvJRBsXeRISxNNU0eob4VodI/qdrPjVYHFeX93fRGc
	vmy/OXcS7zI0tZlbWeRY/qTMruJzC66d0FUWd22MoBjjV34N7l5NVtOgw8fFYssp1Bv8iXD7hZc
	0+aP4RD5DJE2gwJjSROOKHseKA4yipKwbBXNf3t/Ttth8BsopZsB7dnGnIFmUmgGi0cOWJKboe/
	D+0Ta4+atTJAInm8s3DKbTGC1AqHLw75VIiKijrZXqv0WH/yppYyTv/SYYzE6GTjdnEzQSSTjx0
	GIZRLO316cIoIg15ztBHT3ACD+rV6Uo/gBI9DB1ichKGnA28G8GwDk+JyLUqYq69RdMOehimLjN
	XQY8SfLHrdz1U+VNmgEb5uMrhOO+gDMvFG0pU1sienj2nZ2+Jjg4qL0V2wiYt3MjY8j7WQw/E4C
	NzPqultFeAhwoIJy1TEgRdX0DYPMZ2w/2h8iBk8gSg==
X-Received: by 2002:a05:600c:4510:b0:490:3d2e:b67d with SMTP id 5b1f17b1804b1-490428eb9aamr126341515e9.30.1779562289734;
        Sat, 23 May 2026 11:51:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a9c7-6b01-94ec-c77c-d65e-8d56.310.pool.telefonica.de. [2a02:3100:a9c7:6b01:94ec:c77c:d65e:8d56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f6ffsm14058366f8f.1.2026.05.23.11.51.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 11:51:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 2/2] lockdep/selftests: Restore sched_rt_mutex state on PREEMPT_RT
Date: Sat, 23 May 2026 20:51:23 +0200
Message-Id: <20260523185123.17482-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260523185123.17482-1-kmehltretter@gmail.com>
References: <20260523185123.17482-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WW-mutex selftests deliberately exercise failing lock paths. On
PREEMPT_RT, some of those paths enter the RT-mutex scheduler helpers.

The change referenced by the Fixes tag made those helpers track RT-mutex
scheduling state in current->sched_rt_mutex. The bit is normally cleared by
the matching post-schedule helper, but some WW-mutex selftests disable
the runtime debug_locks flag before that happens. With debug_locks cleared,
lockdep_assert() does not evaluate the expression that clears the bit,
leaving stale state for the next testcase.

With CONFIG_PREEMPT_RT=y and CONFIG_DEBUG_LOCKING_API_SELFTESTS=y, that
stale state produces warnings such as:

  WARNING: kernel/sched/core.c:7557 at rt_mutex_pre_schedule+0x26/0x2d
  RIP: 0010:rt_mutex_pre_schedule+0x26/0x2d

Save and restore current->sched_rt_mutex around each testcase, matching the
existing PREEMPT_RT cleanup for task-local migration and RCU state.

Fixes: d14f9e930b90 ("locking/rtmutex: Use rt_mutex specific scheduler helpers")
Assisted-by: Codex:gpt-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 lib/locking-selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 34554e26d477..e7c3ccb23b58 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1433,6 +1433,7 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 #ifdef CONFIG_PREEMPT_RT
 	int saved_mgd_count = current->migration_disabled;
 	int saved_rcu_count = current->rcu_read_lock_nesting;
+	int saved_sched_rt_mutex = current->sched_rt_mutex;
 #endif
 
 	WARN_ON(irqs_disabled());
@@ -1469,6 +1470,8 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 	preempt_count_set(saved_preempt_count);
 
 #ifdef CONFIG_PREEMPT_RT
+	current->sched_rt_mutex = saved_sched_rt_mutex;
+
 	while (current->migration_disabled > saved_mgd_count)
 		migrate_enable();
 
-- 
2.39.5 (Apple Git-154)
