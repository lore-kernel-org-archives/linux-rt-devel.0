Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAFF507
	for <linux-rt-devel@lists.linux.dev>; Sun, 15 Mar 2026 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773555343; cv=none; b=uJg5+8bUVqCI6dyBx9hiMtpdf057puFETK0uffD7gilifIKbZ67fnGDeI/7pUeQAETKoaIZIEQYKXnex0qqj12hEDNW+NRCa0TSq2e5W389po9Mkg9W+qUaDhE/+u4FoeH+jlR47VTmHGwRTzGDkRc8J7B6OHpi967TvJS9xvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773555343; c=relaxed/simple;
	bh=2bOs3M/w/wVwUIcNA9+TQbXWvEmLFoSCdguOxxeTa/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9Suf90d4QT8TGQ308ohSbni8hD4zMD/U/+oJk83Gx9wGSjTVm7JztXfQAg4SNfeTRDMM7dTVjqnlQaIrnP0lNIZJkBIsB6rInv1mzD8UWQZKmgv/RaYQKgKKMB1XkSC62XlUHo7V+/hvkjIz+QevJd/twCSQ2r2wcWhf/I0bHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f25r/Wc2; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f25r/Wc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2Z
	XrhsOgjkrmqiFmYgkPWo256bNtg6JmkHxFHSed3AQ=; b=f25r/Wc27aWloKm8bI
	+759Ta5Gs0Jc567OtnqWzamn7ykEf3VMDtIPfCL5J6Xx3MnIGeDirOdC9Krw089i
	4C3UpWf+v/iKunYn2jgdwd/a7062J2+wvXc7SMbr9TnHJb494SFdRt1N5c66hWcS
	PUXFSr+vV0QSTdOhTg+fAHQEg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHNfVcTrZpPyEoRg--.15228S2;
	Sun, 15 Mar 2026 14:14:54 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@kernel.org
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	guoqi0226@163.com
Subject: [PATCH v1] hrtimer: Fix is_hard/is_soft both false with missing HARD/SOFT flag
Date: Sun, 15 Mar 2026 14:14:50 +0800
Message-Id: <20260315061450.129657-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHNfVcTrZpPyEoRg--.15228S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3Kr45ury5XFWUGr4xtFb_yoW8Cw1rpr
	WxJrWfK3y7XF4jyFW8AF9rGrZrtan3J3WxuFyrJ392ywn7t340qa1vg3Z8XFWaqrZ8urWx
	ArW0qr15CFWkZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piTmh5UUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4h6yG2m2Tl7VYQAA3u

When hrtimer mode is only ABS/REL (e.g. HRTIMER_MODE_ABS) with no explicit
SOFT/HARD flag, and CONFIG_PREEMPT_RT is disabled, both timer->is_hard and
is_soft become false, violating the hard/soft exclusive design rule.

Enforce correct hard/soft timer via effective_mode:
- Enable softtimer when CONFIG_PREEMPT_RT is enabled and no HARD flag
- Add HRTIMER_MODE_HARD to effective_mode when
  CONFIG_PREEMPT_RT is disabled (e.g. HRTIMER_MODE_ABS)
- Compute timer->is_hard as !!(effective_mode & HRTIMER_MODE_HARD)

This ensures exactly one of is_hard/is_soft is true.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 kernel/time/hrtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 860af7a58428..5107d2e69887 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1618,6 +1618,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
+	hrtimer_mode effective_mode = mode;
 	int base;
 
 	/*
@@ -1628,6 +1629,9 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
 		softtimer = true;
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD) &&
+		 !(mode & HRTIMER_MODE_SOFT))
+		effective_mode |= HRTIMER_MODE_HARD;
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
@@ -1644,7 +1648,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
-	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
+	timer->is_hard = !!(effective_mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 
-- 
2.25.1

