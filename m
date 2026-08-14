Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7A3546F7
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Aug 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723971; cv=none; b=lbWOC1D0rg+qvPMxpMl9qJG0fDYoUGjdmZz/4dcep5sxPH6KpUO1WHHMEyi17cSNXBRBJPqPKsOkV2rh5YljZJzZCMJUF4xYa4zEZUQ+nsa7onNX5abrncbjwKy7qIVx7G74ITokPR5jRLdqPSrIH0reHn2Ttv0tn4B0YSA64qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723971; c=relaxed/simple;
	bh=hBoTlJskC3yTAUQrqdc/RwBmCeeh3r4SPWGRRWjMR10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TedTW9gs4jc+qBbdlA5NR1A383J3MU3Fin+uZjqj6IM+jN7kZnz0kMOm0jfus7iPPkBy80NyGoATWpj/wbst+LAPz6UPMyMHMKccwoZCQfXRQQVzep6rv8fBzVVssoZ0Ma3Bo2QmohhP682lskcJsIg3dZEX6wuEK+4WS8xBzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXMryVuI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXMryVuI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cace91f112so15268405ad.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 14 Aug 2026 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786723967; x=1787328767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AntyT1xcB6lPLO8SgF8lHn/f8LIO7sUmv8TB1AYj/jE=;
        b=TXMryVuI7iPudOqpOrHLveUdg5w86tWVBH4BJLbLFCgIZETv8Bg0tbdFS6zGsYKIMu
         +fKcJ5DBilPWZnYL/eVd6J1iixC9hmPcl/BVBKQImH57F1jpY4sDoBBWVhx+WxwaBmi0
         J7G0sSO4EVhpxlrW5Y5q5C9ovgxpvE+wrqFcZAkVf3FccsJI3/oKuYS5Kx9roTUdIzNe
         0JZf9kfYpBq9KmJz/YzRa3rBh741SNuR5JkpSgXdkjnvXsIP5pwVvF8vgXyAqw0a55ns
         MuiiS42u9mWBiSfw6XA0zZiFGcljeZVRlEJ2C1cZ45P6XBT5jbPeMLgrAwmLAX/XjOjB
         ZvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723967; x=1787328767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AntyT1xcB6lPLO8SgF8lHn/f8LIO7sUmv8TB1AYj/jE=;
        b=sN9+KVTD8V44ljJyBNmMZe2aEmnpg3S4tomxbpjXULAnfpjUx/f0uy1kzi80zCy+fm
         NI5sC+0pncEYH7nnB6gESWb0wAtPfDd6XhSKSDHoce4LfP9KX6szMVH+zPGCoXUurxqb
         6/xlQ76auXChyJ0gQiB1ID3mmz0FaeH8MOXot8iuZZS2rgQ+nqlH2t0vtFCVQYVb5UOZ
         MsgCfT1LjXVBteohNjBgTDsgTHG1Q3ZivCou1jCTWdUprCQ1V6QRche/oYKf2Ii+0EtT
         dl9zm6Z7VCK0zLRCtjSaxmOam7VnmpsXzYuqc7UDdLht63Gn0y0ygKTYHYpxTLf88dya
         59gQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMULo/Y8BC2GkB+JmEpTMV5RUVLs1LJBWf13gq55GKShl5xvFfUPoQDya1gAlvw9YmTS/qEUIcQiUaSrG2/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywuj4O9J0jlhaVoB3jypw9afyL0OvQUFNnWPEQMQ8kEcbgh5YJm
	bgkIyYmY3wPS1IDqTi/sAKiTngbtOnSjmxASDBbUEjcDYRyLEJ/z6vTo
X-Gm-Gg: AR+sD13vkEQ/JpftUIBYMLXKKjboDjYJz0S1ZdZHuV8tfmRVSITIZh4JLlzY6OOJVWy
	vDhGvHkxfRYU692P41XX8Yw2wj6jrboylF1GhrVG28NC+yqetcuBtuS9OV8KldM58A20aClffht
	6Vmqx+NOzdIXkPeHxz8Tmzqvi8iE6x9C8KX8MsmQh5Lz371wrV4MmzGSxS4phRQT1vkef8rnVjk
	Myu9Jjr5NRUyF117Ylre4tLi18sgkA8j+bPljiXTkagEKdUzU2T4WYwKrnuymgz2SZB/8l+vxoC
	GQFfeyDe4P9AYMuOobZVuw5qFbT3XMvJJuNxh17g39pmv7/wA6gcmF2wiUwA9Ae50SNUZIntCLd
	5OONghBvDQjyYOGoS3QLiFkVzN2tbVvkXuAaZFDL8AZmR3tG7pj3FsGMtkRXOFKIBJz1nBHUi40
	ckmYFG55YUDh+WD6mjmg9tWLeHdYgAFdTU/By2m6jByTBDH3ALPaUvbb6dmxk2wByUIy8izh08Z
	1gKT6s=
X-Received: by 2002:a17:903:2c0f:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d3b0eec2f6mr92007415ad.14.1786723966514;
        Fri, 14 Aug 2026 09:12:46 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb887aasm12260415ad.61.2026.08.14.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:12:46 -0700 (PDT)
From: Liang Hao <haohlliang@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Liang Hao <haohlliang@gmail.com>
Subject: [PATCH v4] docs: real-time: mention the hrtimer sleeper HARD path
Date: Sat, 15 Aug 2026 00:12:40 +0800
Message-ID: <20260814161240.33774-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260814094910.akPMAqd4@linutronix.de>
References: <20260814094910.akPMAqd4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Timers section of Documentation/core-api/real-time/differences.rst
describes the PREEMPT_RT default (softirq / ktimers) and HRTIMER_MODE_HARD,
but not the sleeper helper: hrtimer_setup_sleeper_on_stack() marks the
timer HRTIMER_MODE_HARD when the current task is RT or DEADLINE and
HRTIMER_MODE_SOFT was not requested, so the wakeup runs in hard interrupt
context.

Document that behaviour. Also rename "ktimersd" to "ktimers/%u" to match
the per-CPU thread name.

No code or behaviour change.

Signed-off-by: Liang Hao <haohlliang@gmail.com>
---
v3 -> v4:
- drop the Documentation/timers/hrtimers.rst section; extend differences.rst
  instead, per review
- add only the sleeper HARD wording and the ktimers/%u rename
- do not restate lowest-priority / cancel-PI points already covered elsewhere
- avoid vague "and similar" caller lists

 Documentation/core-api/real-time/differences.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
index a129570dab5a..c8acfba051eb 100644
--- a/Documentation/core-api/real-time/differences.rst
+++ b/Documentation/core-api/real-time/differences.rst
@@ -119,12 +119,17 @@ timers initialized with the HRTIMER_MODE_SOFT flag, which are executed in
 softirq context.
 
 On a PREEMPT_RT kernel, this behavior is reversed: hrtimers are executed in
-softirq context by default, typically within the ktimersd thread. This thread
-runs at the lowest real-time priority, ensuring it executes before any
-SCHED_OTHER tasks but does not interfere with higher-priority real-time
+softirq context by default, typically within the per-CPU ktimers/%u thread.
+This thread runs at the lowest real-time priority, ensuring it executes before
+any SCHED_OTHER tasks but does not interfere with higher-priority real-time
 threads. To explicitly request execution in hard interrupt context on
 PREEMPT_RT, the timer must be marked with the HRTIMER_MODE_HARD flag.
 
+hrtimer_setup_sleeper_on_stack() marks the sleeper HRTIMER_MODE_HARD when the
+current task is in a real-time or deadline scheduling class and
+HRTIMER_MODE_SOFT was not requested, so the wakeup runs in hard interrupt
+context rather than on ktimers/%u.
+
 Memory allocation
 -----------------
 
-- 
2.50.1 (Apple Git-155)

