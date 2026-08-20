Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A747D92E
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243945; cv=none; b=b8cPN+EETPtvwt6FuoXnih/mhfXUE6cRfgEcXjtg7AIUBPBQXZPQSXSYSpIsKOfwjpAU4k4ml13AMGXnlVZMwnH+WJUUTX9rfnCHBa9xeZYeL645sbRLNVZRoua/AskK9T/xrRlkCnI4BDVGd8rUUufFpZLzHMungMeRiXGAXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243945; c=relaxed/simple;
	bh=jKcxoKbIsQ7QDT2hCb635XJSw2JDoUeo20a5dXMuax8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQjnqGICgSvlHuvyN0JZIjgmsxs4qfXbAUgyeSFN1cWnRXPx+ubqMh1QI7sFGGqW2fUtTw4qY3z9WOYByQb4B6kLbHBBr0Qr2Yezj9R/yZq+wmTdEptl2cH0fc8Koh7RiHhHXn77R2WeBZsy/qnfq5jiJ0GfYjZAaYWwDO7/Nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFC97Cm+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFC97Cm+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceaf8a1265so879865ad.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787243944; x=1787848744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDmRvt2Dh399KldFX1CZaOl2WYAoa2VBzfFsCwhkX3k=;
        b=CFC97Cm+s4qYcen8zuQAs7L2IzNF1X9aqMOSOIubzU8efyY5D+GOfMkizj3tm49nNA
         GHoT6xyTFIDHnLlnzy2WnwGpWjECiX2wMhHdNdFD8/RgdBl44wB+xbW1YjuMH5RSW6dI
         dyxciWIOV763dDybJCyFBfpql2hd78wcSKlPPdlcNDiphMsoB+coJmIc6rEkIq6JOj6W
         Hruv4gqyIzeW+4Zq8/1VVPRezIkIzHNrt7UbimNPnCzNo4dJGDEeOmP4LjjwT5qlBv6T
         Pn1gOhhcC1b7SQ3TFF9eBgQUaRt1UCmbpURrBjpaZWkQM2uqKYg2daohSDB0Hb7BBmhn
         Bt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787243944; x=1787848744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDmRvt2Dh399KldFX1CZaOl2WYAoa2VBzfFsCwhkX3k=;
        b=ZE5Uyclr3+vlSWSxn/6lIkytfPM64wfF4STvRaEqSN4hOKeKaMqiO5n/pzMJLfqfAm
         gjuasLNInb8YXwHi1VYqhhUth6n1VugY+/GA0h+ySct0L6w0802Wo1032UlBPg/oPym9
         yiNkjXH2nzmn+Q40M/eyz8Rm9G8t6RZDYUEa8bW7KDQiX3rPk6w22j5IWSOzVOj4iLxz
         9B/fXif6vcZvBNXv1xdJ6km7/YOfwbRrOJcjcvsSnF654k4BdYKW4oDjrSp6uIPB6Lit
         gX+SU/9UJisWjyvzw0Xacf1oX9BBUO4ugDhKsSHtGVQsL1lof59ZDCPbco92ZQpfvx6g
         Hqvg==
X-Forwarded-Encrypted: i=1; AHgh+RrqyI73Xb1AeHGtPlGg50eCQfBqeSoMjvjYvW2ji9K9n9k33V82VxnM/R9JnMWCaRUWWyI3BI0/eoGUGmXJGg==@lists.linux.dev
X-Gm-Message-State: AFuF++kmgJpU25XvpmGbi81ELdT3O92kAibJv5EtKVE/rMT35GI9KxCV
	oQvmwETpD291oNM6acJ0un2ZOUzlNsG0a6P7ItYqFArcVnEa0crUw2oE
X-Gm-Gg: AR+sD100e18VZ5bExqYFq3yp6oU9xnsM61lEKWofgXdVUKqu6in+6Tmj8+xDOhASaXC
	SqLEKb9ux4q3Sns+rIQGk9p/Fb2RtW/mVy9X53Yutgz3dyFatPWu2jKoskiKr0VUzWpqGGjhN9L
	zQ1JonPD4pQT24O99r9ITO3D8LuTWvMzhOHsQ50hJOEfPB6JJInGBNKzfivBGCgJDM9a91VXn2s
	RV22ExKHjXZqsPGSpZmox5w8kfmxfebuRJ7tQ6mzbuasIUt58VwQnYHBWZ2u7X/6ngD2yPIMemR
	H6pNXTJGSpE55RtL4ldZE2qtHA3QqyGZSGsA1ahhD16F2AZ9voESPpJmf6msSbKSlvcnl7OoC9w
	dRHiY/Er4Oq5d+Pqw8cxgBMImVIjiHd0jYl+NeKpZwi/8K+rcmPTZ5UacuGBZ7guSH5c36xwaxM
	zXWLLRJrr9yBLZFNx56f8huZ8F2+FnNOpawg/mBLSkkTgrnY0A30wDAxPWlKp4VRsMAHPn++bDI
	A==
X-Received: by 2002:a17:903:1a86:b0:2d1:1f73:3667 with SMTP id d9443c01a7336-2d5fd65fe83mr292672675ad.1.1787243943674;
        Thu, 20 Aug 2026 09:39:03 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62ec88bb8sm9500305ad.83.2026.08.20.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:39:03 -0700 (PDT)
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
Subject: [PATCH v6] docs: real-time: mention the hrtimer sleeper HARD path
Date: Fri, 21 Aug 2026 00:38:58 +0800
Message-ID: <20260820163858.27984-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260820144655.22492-1-haohlliang@gmail.com>
References: <20260820144655.22492-1-haohlliang@gmail.com>
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
v5 -> v6:
- clarify soft delivery for non-RT sleepers (softirq context, not
  HRTIMER_MODE_SOFT)

 Documentation/core-api/real-time/differences.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
index a129570dab5a..6f5be9f0da2e 100644
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
+without a real-time priority is handled in soft interrupt context, but for
+real-time priorities HRTIMER_MODE_HARD is used. This ensures that real-time
+tasks are woken up as soon as possible while ordinary tasks cannot block the
+CPU with a thundering herd of wakeups.
+
 Memory allocation
 -----------------
 
-- 
2.50.1 (Apple Git-155)

