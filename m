Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65362392C21
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633074; cv=none; b=H9QJa5I4OW1cVWCfgXc9OLsETnuwMKdO4XUtcj1bDtOpSxWvtQDll8zIVNw0adNXfdq+IVs7upGK1CBVNEn3CA8Yz8igTVRB+SsrBtKxXnPgfPJZ+ToFfv1wSnYupVP0NeU6cYC9mC9SyuQ8M9ZsBI8GQvDae5HWcAvg+AxBR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633074; c=relaxed/simple;
	bh=UzDJRYzn8/XIL+G2itjXNV/UKIkP2Zl5tn0cjd5eH1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU3gGe/4zDTnBk0cL27YCN6Koc09wFvT/otpzwv7Go8LmzggaLjYxDnaFw2yUV8XoIYOM/1rWL3wnkB13j9yocXZFm1gBwCt1rBRiZ39QBGGHALq3GAj4ds+939IO5FqQP65sCtV1h4JKzOxQyucwHL984VlRMkpLIAxeSnD8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwVL+Y2S; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwVL+Y2S"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso500335ad.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786633071; x=1787237871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zYINpSgOxSLHev+n0fE2laFlkLhiN8CqX0AHvm/85M=;
        b=MwVL+Y2Ssn/D91WutK3cDYBfAv5BW444HwVgNkwRfvy0YRK9KY8P+a6CRhii6iRz2A
         uSAi+6M3dzH+e4VxTEiLATksKUSAoBGpTVTBrkXDNE86Y+8WaDH66VQ2HO3PFv3g3vLR
         JldDdVVDN0xLfWeoDJRICOgFxUS26LAe4XMHJpsq5HFM2uFrSZ65xblTTOqhgbnuDWml
         lTzFI+3qYE+u8wNtfDjcTiT0rTPtacBgN1laIKGQhW6hbH9dytZOymUunfH/ZX0vLabz
         hpw1SHrOqCgHrhvgHIsHx0epR/8ipwHTbO+O3NTnBmu72dBs4eYjq0pT4e6NzhwxGUKc
         Mspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786633071; x=1787237871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zYINpSgOxSLHev+n0fE2laFlkLhiN8CqX0AHvm/85M=;
        b=pcX2eWqrAqwGJN3AQGZR+2fYVhkticCxsD4KXA/JvN7HblmYJqvjFPVJE3U/txnjtA
         LEnk8fx8p6RqROyj+6ft+CkAkxYqrFWmQHnM2g0asZDqDsmVRtnACZafBDlQVjZ4M4wD
         BoE/6L/EueQ6v9JOgAX4ByL4B8bonX1NWUEcRv7tPTdTvDZymB7SUgR6Hl+OKedUJr6a
         bCtI8CZwG0vb+g+XVfK5pZRvQHR8W54kfa8dsih2UIsaLx81vkiz9/p4R4yrJsTF9aN9
         OBU+Lou8ko9+xC+GGfPgOErBekfE7VBN92XRpOze+tjuSHWSw6dFD4gEOH4dcRvNEp5F
         44iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0n4XJJKdr1VTe+30tvA3LhbBIjQqBBV/RwIZ9etraTsOdCexSo6Nh+CCwoBHWtA5NCa96GCkAt95T6NsoAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEzrRjhBi+hqrWLrQ02vVoVxR37i/1JREe33HSOkJyVoH/jag0
	uHomZ8AMfsFgo1FHxDh0WcoZyvZz3gU902Wi8BLJNVrB18o3WTRbKX/r3AeEng==
X-Gm-Gg: AR+sD132DkSq6NKm7rRgQXyXd6+p+bAjv/+AUR7vsLWf6ICgWDiSUYiLLdYG3B9X7zH
	EBluV5xI+uPYU1x9unklYGLoHPoe4/KOqz4rdp+cyPEyoZ5/AcETq9e5RGbWIVMH8J3fluULpWZ
	BgqAug4lApLAYS0eGrc6dTdVBx2IGYsRHjKte3HhrDwJsSb4iCJRh2fUUu2L3WpO6zFtZY/82Ab
	hH/SXv6kVw7PIY7S0VJD22Z+8KzvOHZlBIPNBBzb8s3/VGHJzR/+Xrb4eijXLUPDSaeP9035qqK
	4qrSxSYSjANdnY7tMTXj429HFU8oTKnxcOT6Qg3pjnQqiww+gFHkf5XFzghEsBrZnIIo7E9GcPc
	ua5t3XJIdtFWNMwrbeKqq5anmNlczfrBRWrZyOkS0aOvlpUZZUbJoct5ohHVzW76/CNoTKhvL0p
	j1hLb0gxrMmsjNy6fbv4Uk1RRro0zgSNx6IAwb7oL26B9mn417YQ92quxnud8SitsJMTiiP8+gj
	bLczo6scMigsQ==
X-Received: by 2002:a17:902:f550:b0:2cf:7fab:3cf with SMTP id d9443c01a7336-2d37ebcefa5mr59040865ad.23.1786633071088;
        Thu, 13 Aug 2026 07:57:51 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c40e8c4sm11313775ad.45.2026.08.13.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:57:50 -0700 (PDT)
From: Liang Hao <haohlliang@gmail.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Liang Hao <haohlliang@gmail.com>
Subject: [PATCH v3] docs: timers: hrtimers: clarify expiry modes and ktimersd on PREEMPT_RT
Date: Thu, 13 Aug 2026 22:57:46 +0800
Message-ID: <20260813145746.26612-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812145440.23528-1-haohlliang@gmail.com>
References: <20260812145440.23528-1-haohlliang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/timers/hrtimers.rst did not cover the PREEMPT_RT
expiry-mode semantics.  On a PREEMPT_RT kernel a timer that is not
explicitly marked HRTIMER_MODE_HARD is forced into softirq expiry and
its callback runs on the per-CPU ktimers/%u thread at the lowest
SCHED_FIFO priority (sched_set_fifo_low), regardless of the priority of
the task that armed it -- a SCHED_FIFO task running at priority 99 that
starts an unmarked timer still expires on ktimers/%u (lowest SCHED_FIFO
priority), not at priority 99.

Add an "Expiry modes and PREEMPT_RT" section that, rather than
duplicating the default-context description in
Documentation/core-api/real-time/differences.rst (Timers),
cross-references it and focuses on what that document does not spell
out:

 - the callback does not inherit the arming task's priority, and
   priority inheritance on PREEMPT_RT is used for the cancel handshake,
   not the arming path (the "Spin until ready" section of the same
   document);
 - the sleeper exception: hrtimer_setup_sleeper_on_stack() marks
   RT/DL-armed timers HRTIMER_MODE_HARD, so their wakeups do not go
   through ktimers/%u.

Documentation only; no code or behaviour change.

Signed-off-by: Liang Hao <haohlliang@gmail.com>
---
v2 -> v3:
- use hrtimer_setup_sleeper_on_stack(); there is no hrtimer_setup_sleeper()

 Documentation/timers/hrtimers.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index f88ff8bae89c..b81785e0310e 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -171,3 +171,31 @@ hrtimers-based high-resolution clock implementation, so the hrtimers
 code got a healthy amount of testing and use in practice.
 
 	Thomas Gleixner, Ingo Molnar
+
+
+Expiry modes and PREEMPT_RT
+---------------------------
+
+The default expiry context on PREEMPT_RT and the role of the ktimersd
+thread are documented in :doc:`/core-api/real-time/differences`
+(Timers).  Those details are not repeated here.
+
+The per-CPU ``ktimers/%u`` thread (referred to as ktimersd in that
+document) runs at the lowest ``SCHED_FIFO`` priority via
+``sched_set_fifo_low()``.  That priority is fixed: the callback does
+not inherit the priority of the task that armed the timer.  A
+``SCHED_FIFO`` task running at priority 99 that starts an unmarked
+timer still expires on ``ktimers/%u`` (lowest ``SCHED_FIFO`` priority),
+not at priority 99.
+Priority inheritance on PREEMPT_RT is used for the cancel handshake,
+not for the arming path; see the "Spin until ready" section of the same
+document.
+
+``hrtimer_setup_sleeper_on_stack()`` (used by ``clock_nanosleep()`` and similar)
+is an exception: when armed by an RT or DEADLINE task it is marked
+``HRTIMER_MODE_HARD``, so the wakeup runs in hardirq context and does
+not go through ``ktimers/%u``.
+
+If callback work must run at the owning task's RT priority, either
+mark the timer ``HRTIMER_MODE_HARD`` (and keep the callback
+hardirq-safe) or wake a dedicated kthread from the callback.
-- 
2.50.1 (Apple Git-155)

