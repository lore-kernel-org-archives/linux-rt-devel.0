Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9F46A61A
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546498; cv=none; b=IfoJNPyAbk9WfrLDghRjqr8QbLrKsvhhbU4amWPK3cWo+KJUAKI2YYDsQyqWoxxvLIB1me+R0AZN7oIr2HBl0PhM7DGFI/OVb4j4UPwHWCgihIufqGvLUOCF0LjrqraUhfsEgGjYY4keyoHnKYSHMfRs9vJmGMwfepTlbmFRv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546498; c=relaxed/simple;
	bh=ggZWb/rBiqtP7g2mRVkG7zh3PqK153hqDL94sI8DK4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKWtfRf5logYLfWteC4xat0qX3MKtaJACAItm2hw4BL6HfSDLQ8XHs1cP2jQ9Wjk9O8G8oVuyn9Cd0b5640egnWKIuRFCgILiEZrvLxqIGVKXEoq5PePRrIgS912AdQg7pnr0YHcoGyY+3MhPvOsiL7DuOzpMky0aYAunCgc68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b39vj6v9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b39vj6v9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1536720a91.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546486; x=1787151286; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyYu/EtrXs6+w7joY9KRy5CcVEubQhW0BF1ueyFLgVE=;
        b=b39vj6v9gZalLdKU/fip4mg6BSwD0SeutjdZKbuNzS06yb+1iAgST+OeSGAFV2TAkO
         eHUAwQCwHeuWXTDbkgBtl59lJnmG/ua6yLcyMGwcNDftUMFpo4wcdwZQZQD4/BPpRueq
         jj/XuOVvOC1eoMLF8sEj6J1CzVjWmL0bKYWnqQR57Ejp4cazRK3kuoFSVqc9jI2/HZdZ
         iErkYiVo+9e13PgRzCDSdOsvfd69+SRtahGF2dEwdsHKYwQYPx1dH7wXKYb3Vm68O+Q1
         2F6DC6ze9k0f/vL+b693rDR6qkdwqoh7qvK/m/cUG6GTxhx+8eh4z1Ej3OYFMKliQVt6
         DVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546486; x=1787151286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyYu/EtrXs6+w7joY9KRy5CcVEubQhW0BF1ueyFLgVE=;
        b=o0MevF+MmFaa+I2/+Aq4vLJKwRLmLR4NnIRmOgFOYLlYqZ8bTZTsE5bmMY2CTZHeby
         vuLOEGKZBkd9fvyJ++HAsHk1yLor7YI5hzWolEed5m7xWj7+ob/EB04UknmZeH2m7LSp
         CiiBcuVidG8eANVR65774TPgE68K3rVZoguknd7H5dA1HNAtza4TfN6+a+tLLY43g/mR
         sJ1hHGjRKQKchjH7LalkRTUzM6EsibcMZkSg2JkorrVcfn8tMCvkhftZ28sOI0xE/Tdh
         cNANE6KybvYT9VtfZzIOMuhbDxCeFKpPfE4ufwna0/ytYMXWeb72kLYjgDqgdL+Kuvj0
         BN8w==
X-Forwarded-Encrypted: i=1; AHgh+Roi0t+quYbp/FNpYE0Ss07NGffjng70alkPo0OADcwZfRs6N3I+dB1hrpdWZZMDSYUs1CyG8ybkvYD8hWzFqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz75Z37RXZi+2AHyK6k0+24Ft7/hn+qLnzUpwdwuTPkkiX4uB2y
	rA9pTV6L127GPJiAlZlyoA4EkXg0hc93IEU4lSJzkP+2/BdxXPGamuV0
X-Gm-Gg: AR+sD12FlpWs1FJ+W/cxA4QNsZ8YbFy5HIHW8aO9ioYzft31YadGrNbKgFlMRetAwyC
	GuVsAxTG1uqi/a5WnG66L+VtBg6U68/65J0Ez0yCMeHoZIphgxf4mD7Vpyac+lAeAeTnnYFCmZn
	ngLw+epLj/s0oRxVLoVOxSzEK4pOxbxBqS6vCs16cqiy93DygJ86uZ9IlfKvHpTJWWJtA9HVToY
	CvznQkY1XxABF1GjXR9sGIYcudYcFqR/NZfr3Y5qS11+/9qDiAWQuYoNcNOngIELKsfCSVBheEl
	Di+ZJiQayBVdaf411mjjpmJTH/ZscaOaj5tNGH3096xf+2++nsb+s0ZrJOkKyiaLItgFcNjkk+4
	EJDwpto/uYoBekHouydoszXq4if6f9N3UU1NnTiORt7iGtUq6pnQGgFNdivVPHbYT3xO25sZU2E
	tYIjUcutobCcVfmLFKEK58hmIXwPqDSnFJs8arS43aLPzjagpuMHffptGhXl590s/xHD+IlLB1b
	Q==
X-Received: by 2002:a17:90b:288b:b0:38e:f6eb:2b38 with SMTP id 98e67ed59e1d1-393014944a5mr6567009a91.17.1786546486135;
        Wed, 12 Aug 2026 07:54:46 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe4b1659sm1334683a91.3.2026.08.12.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:54:45 -0700 (PDT)
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
Subject: [PATCH v2] docs: timers: hrtimers: clarify expiry modes and ktimersd on PREEMPT_RT
Date: Wed, 12 Aug 2026 22:54:40 +0800
Message-ID: <20260812145440.23528-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807161929.49913-1-haohlliang@gmail.com>
References: <20260807161929.49913-1-haohlliang@gmail.com>
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
 - the sleeper exception: hrtimer_setup_sleeper() marks RT/DL-armed
   timers HRTIMER_MODE_HARD, so their wakeups do not go through
   ktimers/%u.

Documentation only; no code or behaviour change.

Signed-off-by: Liang Hao <haohlliang@gmail.com>
---
v1 -> v2:
- shorten the RT overview; link to real-time/differences
- state the arming-path priority consequence (priority not inherited;
  PI is for the cancel handshake)
- drop the hrtimer_start trace debugging section
- use the ktimers/%u thread name, with ktimersd as its doc alias

 Documentation/timers/hrtimers.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index f88ff8bae89c..fae191550c5d 100644
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
+``hrtimer_setup_sleeper()`` (used by ``clock_nanosleep()`` and similar)
+is an exception: when armed by an RT or DEADLINE task it is marked
+``HRTIMER_MODE_HARD``, so the wakeup runs in hardirq context and does
+not go through ``ktimers/%u``.
+
+If callback work must run at the owning task's RT priority, either
+mark the timer ``HRTIMER_MODE_HARD`` (and keep the callback
+hardirq-safe) or wake a dedicated kthread from the callback.
-- 
2.50.1 (Apple Git-155)

