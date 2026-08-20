Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F2373BE0
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237222; cv=none; b=AL8KLVigb5m2biECu4XA+687vxxC5KWR8tOuC4LQ4E4UYGH9l1LRspULA3mxCV/tIMjBu1rm+cB/kxwKA4SvtX/FqRtz2yzVMxncfLT6IRci53apubHpjwqsdZN0nAvWIfdE0LnMNGGlWrs8wVhLm4Jn3B8lIPNHOBFtmNctKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237222; c=relaxed/simple;
	bh=Ftej52SklxTXozfvmwOfHn0CtfseigpuDEQMNnD7W1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om3LJtg3QLH9I9SRbbFY0YuMJuTn6rNgMNo47Ywod405U7GtQYRXGG6PtIoPW7KNuivs9tErbaoTcSnQpxtB/MAdaEpCp9hry76Xewx+np1eYK8yNXF58vtoq9ZWEbcEOIukw5B2KUi5rYRYUfEX1y68j1LGyz4Cs6UUFKbexpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRf1XnB+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRf1XnB+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2181840b3a.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787237220; x=1787842020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVfSuQvXyLuniL2nm4D/+95VYDhWOHF3K6aMyMIHSIs=;
        b=sRf1XnB+xzcz8EDPhpr4mQAhlVvzepE4lOYBCeZrSkiZW1/myAd+WMXcr6O7w4pIpk
         uzdIy+d73Xsi/YvXKIYXOL1f/mzbJULbFRS6xmEgccdMZNe7lnYWFst3eFwDkfwa6jWW
         5L2WgKlfbQ0tMEGW+mpRj7J9/JScoDeqNG2HanuVZxbeNWFoavoeLyPobIBfkwlmr4+6
         xiqw92+ifZQkIW5KKq0SuOJgwu6kJFFQOu0SWCLxHJ3iuHBc5d7NRjVZeXAaEet4OmYv
         6aimhBOHcy/y77gk+jgDeQQtS7dimA7NWkqird8C06JquT72ecUs7UheHwbGIaWhGOUw
         3goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237220; x=1787842020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVfSuQvXyLuniL2nm4D/+95VYDhWOHF3K6aMyMIHSIs=;
        b=D4red8afqIUA5pwSA4XQW7rd2WRv2OcrC82T1qgl27SgbPaPq7cbYiRxCBRXCHGqPM
         NC7t7KCJduh/U1AlQEY/w6tsp5U2njRRWJcezfmE1a94jKr22XhB9vaUdwWMRGQJSILF
         5uOqtckOCODFbqvuzq7tNMYZZ4not5vmFyr4A9hXubU6aHCXbxVesE1lqiKewTft4Lj/
         gorYYEcmoiH8HeHFV+P7LpCUwCzE0wjhrunhp2LFXZuBzN8fjoj6ki7LV99qiWSx0n7W
         hIMJHezTqaK4IlJf/IjjicV2Jq13mNjwZOy4hbEqpY4RvSPWo6x5O4k4E0s4x+ECwsA9
         Mrrg==
X-Forwarded-Encrypted: i=1; AHgh+RpJJxxFCGX1z62oioJn6Qnug/dfVVxofiL/MXJRhV/tAeVhojFGjVKVIvCEShUM77tWef6KUt71RJICQ55jbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxesGpzx3h2e1D3WugUVx/OlgFHZKXto6dlP7gFwa4GIh6Kpd+N
	eOkSGJaE4JG02paO94x/zZQ5xk4IXOULm/ugHHTUM8+5a53+j136iW2h
X-Gm-Gg: AR+sD108ZEGKUhbVvydfTw5jgT9ZBOCtddGjvayvIUHG34vWTesmSogDXQF6Aqvfves
	J5eg7thyCHLgQR1loraka8tkRWmJBbQUF95+EAtmR35FiwHRthDzsgTg8/kJedkIGw4eEZZ6B46
	qkD2yccw8jhrqhqzzD2/QOTh6TGCPMFRGPA5aDNvVAjVcNmSDDI7IbF3mqkYS+X9Curx3NA2WpI
	juFO5io8OsZMw/pEAEmkobR6MK2Nw+PDvKAZjRBy7SWDofj4IuOc1QbKXjppHFj/gsMNw/2JkLQ
	rRzsQx9OCVHlnXrYlFIJCZBmcvjsKjxCFukmXvOo5JO8b79GBLxR2T7516M8GTUZQbvdIA4+Fq7
	+//q/jRfYi9MLz8EVPGEMIUPjwDZDoUPZotWuhHYpHLz9ej26li1wk60Emop8IdMB81qwUFiCHd
	1oq/FjJihmO4i3wOKMNIFK0hEkTsDVJY3orSYBqV9dU3RVY2wUywHZzfHrS++GfKuC/mw7TWOb0
	Q==
X-Received: by 2002:a05:6a00:2d8f:b0:84f:dfce:966b with SMTP id d2e1a72fcca58-851d387fed3mr21945328b3a.8.1787237220112;
        Thu, 20 Aug 2026 07:47:00 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640a4bsm1800099b3a.42.2026.08.20.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:46:59 -0700 (PDT)
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
Subject: [PATCH v5] docs: real-time: mention the hrtimer sleeper HARD path
Date: Thu, 20 Aug 2026 22:46:55 +0800
Message-ID: <20260820144655.22492-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260820082114.QIiSu8n5@linutronix.de>
References: <20260820082114.QIiSu8n5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Timers section documents the PREEMPT_RT softirq default and
HRTIMER_MODE_HARD, but not the sleeper helper used by userspace sleeps.
Describe that path, and rename "ktimersd" to "ktimers" to match
ksoftirqd naming in this document.

No code or behaviour change.

Signed-off-by: Liang Hao <haohlliang@gmail.com>
---
Thanks!

v4 -> v5:
- use "ktimers" instead of "ktimers/%u"
- replace the sleeper paragraph with wording suggested by Sebastian

 Documentation/core-api/real-time/differences.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
index a129570dab5a..04be5789b5fc 100644
--- a/Documentation/core-api/real-time/differences.rst
+++ b/Documentation/core-api/real-time/differences.rst
@@ -119,12 +119,20 @@ timers initialized with the HRTIMER_MODE_SOFT flag, which are executed in
 softirq context.
 
 On a PREEMPT_RT kernel, this behavior is reversed: hrtimers are executed in
-softirq context by default, typically within the ktimersd thread. This thread
+softirq context by default, typically within the ktimers thread. This thread
 runs at the lowest real-time priority, ensuring it executes before any
 SCHED_OTHER tasks but does not interfere with higher-priority real-time
 threads. To explicitly request execution in hard interrupt context on
 PREEMPT_RT, the timer must be marked with the HRTIMER_MODE_HARD flag.
 
+Userland sleepers usually deploy a hrtimer to guarantee a precise wakeup
+time. The timer is initialized with hrtimer_setup_sleeper_on_stack(), which
+distinguishes between real-time and regular tasks. The hrtimer of a task
+without a real-time priority is initialized with HRTIMER_MODE_SOFT, but for
+real-time priorities HRTIMER_MODE_HARD is used. This ensures that real-time
+tasks are woken up as soon as possible while ordinary tasks cannot block the
+CPU with a thundering herd of wakeups.
+
 Memory allocation
 -----------------
 
-- 
2.50.1 (Apple Git-155)

