Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A018316192
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Jun 2026 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593767; cv=none; b=dhPMvyIlZDuulqeUle/IBsH1qfd3wu1kbNyryhTJHNcwIDfq8y75rJKoWR7SYAMX0/xCicn2Emz3ZViqb2ykYi1cQR7j0CUCVs7y21VqtyzdWoK7OJa6c3rcIz+1nJckd6A460SXlElxDuOIpgjuWNUBpE5Dc+obBih83QkKF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593767; c=relaxed/simple;
	bh=x06EytUj1cUar/FCWQk48AyH/dFMOgOpvY0ZBp+gRuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzcg1zZuCNj9pI9t6/u9dyTA7XUPKw4xBvOEuzXQclDCJ7iqv//cZFS7KmzotCb5M22OlX4zjgwvxoIqdkLqKxIUIgn8ILK5UZBC4BvwZPeguDmCq9cnBGaXjg89fyc0H4AONOheKo/MPM7dGCYAdiNUgrFwz+/EWB7FYhGyDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7X8qfMg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7X8qfMg"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa65a184f2so3977785e87.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Jun 2026 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781593764; x=1782198564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkzoBaCuAa+vTIFS8jlJVus+yT58jGb9pw8BHvECoBY=;
        b=R7X8qfMgSMC/NaPbI5SftyXaIKW7XiRAo5ktJl7pDIf098C60xXgtlJD416H23wLbB
         UnYJROedhW5xWgejwI2zpVjpFmpkkaQxEyXfVpdoIiT9Yy25T5QUaNmeadmE1KD34/El
         NPkpByIDrXtbCjc9UmNITR8VBKnkn5lZc30ICPCXNe5vvjA7KxJzJjz9Oh1CH3veKw6+
         AhXA+vrc29l9wDNKaWKrPH4J0qRbM7lpQKWMcL0r3a2NB/x8A4CvgjDW/66nOPJV0IlI
         +nVlnX9kjyHIfj1XBSVn1BUrGm0aSoOw7vqrjqkWnQjUoC/PQ1uK2qT9/pitIO1sRJeg
         towA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781593764; x=1782198564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkzoBaCuAa+vTIFS8jlJVus+yT58jGb9pw8BHvECoBY=;
        b=rdzrfWcHBDyklMYFSO5CrQmBJvQM0yOFJzZ5arZJCEytgduTURaj2JzKrDrk2EnvBI
         WenpLJRQ8xVmFfs2ZjJeq6L1xZy1uvAkeFQ5OZ7JrkMcTmDZfArCzPUhlwVbsxSQOQbF
         JHq1RPFd0nQlTYMMoxhWuKgh5gGaOZw2uZ08l5HPZlnNL6HTUFkCTd+k8GSBpbNTmjif
         SbrE/wlYhF8/btwXYgclfFow+gpuNAgIwKHMhpnFY+8VnzUzBo+UXhNmxVKJDh5yCejN
         aSlhIWUiIi1ddOd0t5Xw4Wk0tkRybSYHYjS7JPzco54PhB9XD8ia33/jeLPD1iY+eKHb
         4d1w==
X-Forwarded-Encrypted: i=1; AFNElJ+U5FUWMEw7gM2dsNnfeyhMsxFdyaieOSotbFLVGl/CusUGiN2D0l4la9T7hzmadaVys26E7pvmAeWD4dPaog==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX8BLlh2i8z5EfxccKT5RmIi2z/hYyArRFFhbaBLzmAn/o5fYk
	YYBfom/QtDWD5IYvjNlqAMkwXunSExz4f/zpZZyqmuR6Y6fnyHtiXtFx
X-Gm-Gg: Acq92OEd8LQk9+/mvHqArvl3+KKZ5tPk7ZO6In9VIm9HrI+QDuPc2sWbc6IApHBu0R0
	F0Gc2mom6Flu1DzlLJr0RACTWmtmObnqXpBe9nBQt+GMjb2HIbSIaYYLTBBARS7k5sEDYA//kC4
	+0gLX5o7qgOccIw2rE/ieCV6LQYwIQzqWmBh4LhmJhWsPMOLXMC/GBLltLiBS/n3Ni9zauVP4Fv
	gPrhL4F+WTpSk2Agj+2c4A7uJj+AECwSzSvIOqxAp1cAr1Y95wm3Si4bL3pqoatd/Cwciz1hBht
	IcqVCnU+mFaxkHM7IiZt4xUuNHx+HEND3r54UcBGMeLJx21U/WhYZRnzndr2pCPEKlRJQ7u4fOR
	v8nPLcgQJsX3j/jvwpp0JdMqIJTwcifrsUEUnk6lukg7zoZ15mhSvoqU/msl13/ZOReAg/lOJHI
	lRo6G3YkHvnR1Gi2JHZJLN4k1kUsIgXknd
X-Received: by 2002:a05:6512:1452:10b0:5aa:7525:e770 with SMTP id 2adb3069b0e04-5ad437220f0mr460894e87.40.1781593763842;
        Tue, 16 Jun 2026 00:09:23 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c04d4d1sm4876581fa.4.2026.06.16.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:09:22 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] timekeeping: Register default clocksource before taking tk_core.lock
Date: Tue, 16 Jun 2026 12:09:14 +0500
Message-ID: <20260616070914.65818-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f24df84cbe05 ("time/jiffies: Register jiffies clocksource before
usage") moved the jiffies clocksource registration into
clocksource_default_clock(), so that it is registered lazily on the first
call. __clocksource_register() acquires clocksource_mutex, but the first
caller is timekeeping_init(), which invokes clocksource_default_clock()
while holding tk_core.lock, a raw spinlock.

Acquiring a sleeping mutex while holding a raw spinlock is invalid, and
lockdep reports it on every boot when CONFIG_PROVE_RAW_LOCK_NESTING is
enabled:

  =============================
  [ BUG: Invalid wait context ]
  -----------------------------
  swapper/0/0 is trying to lock:
  ... (clocksource_mutex){....}-{4:4}, at: __clocksource_register_scale
  other info that might help us debug this:
  context-{5:5}
  1 lock held by swapper/0/0:
   #0: ... (&tkd->lock){....}-{2:2}, at: timekeeping_init+0x1d5/0x320
  stack backtrace:
   dump_stack_lvl+0x84/0xd0
   __lock_acquire.cold+0x39/0x63
   lock_acquire.part.0+0xc7/0x280
   __mutex_lock+0x1b2/0x2440
   __clocksource_register_scale.cold+0x289/0x609
   clocksource_default_clock+0x31/0x50
   timekeeping_init+0x1e3/0x320
   start_kernel+0x243/0x3f0
   x86_64_start_reservations+0x24/0x30
   x86_64_start_kernel+0x134/0x140
   common_startup_64+0x13e/0x151

On PREEMPT_RT this is a genuine sleeping-while-atomic bug. On !RT
clocksource_mutex is uncontended at this point, so the boot survives, but
the locking rule is violated either way.

The default clocksource only has to be registered before
tk_setup_internals() consumes its mult/shift/maxadj. Neither
clocksource_default_clock(), the ->enable() callback, nor the registration
itself need tk_core.lock, so fetch and enable the clock before acquiring
the lock. This preserves the "register before usage" ordering while
keeping clocksource_mutex out of the raw spinlock section.

clocksource_default_clock() has a second caller,
clocksource_done_booting(), which invokes it with clocksource_mutex
already held. That path avoids a recursive lock only because
timekeeping_init() has already run and set cs_jiffies_registered, so the
registration is skipped there. This change does not alter that; it only
fixes the invalid wait context in timekeeping_init().

Fixes: f24df84cbe05 ("time/jiffies: Register jiffies clocksource before usage")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 kernel/time/timekeeping.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0d5b67f609bb..b1b5ec43c0f2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2061,13 +2061,14 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
+	clock = clocksource_default_clock();
+	if (clock->enable)
+		clock->enable(clock);
+
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
 	ntp_init();
 
-	clock = clocksource_default_clock();
-	if (clock->enable)
-		clock->enable(clock);
 	tk_setup_internals(tks, clock);
 
 	tk_set_xtime(tks, &wall_time);
-- 
2.54.0

