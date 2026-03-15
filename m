Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131A1DF254
	for <linux-rt-devel@lists.linux.dev>; Sun, 15 Mar 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773553167; cv=none; b=rxO8/wsYlB6R0XAEB6Lco2Auvu/2hmyvHTGbEi4ejr53q36BAkKgb8Qm6fchm6rcniIR2K9Te3YqQ/UTwbMyH1w4pQyymOrW2CQlBJ0YjiY93Mb6yx6LpMuVWrbIZvX+aRYi3onQ6WLWXNltqJ4cj9yIRjGKrYH2Grza3nwZ/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773553167; c=relaxed/simple;
	bh=VPlFiaE6XohqKIiaIyGVQLPlSJG+kkUHYnL0F1sL2D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llxSsTE0Zvk3h2+GwPMLO+kIFaD7FA7Jac3/QJL3UX6x2wMBPthTCI+x3XkBvxdEYdumvh4+unZUTESV0+M8LzgAVk/LWkjPqH+ztu7A8eBqfOOQsMeqixHV6pnHS6RBhgFkIbMVF6uW8Te5x7kHjqgRBbZosb/8vB5gVx396J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ioD2u0Wr; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ioD2u0Wr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IV
	mmy5TH3h/U0oiqfUAE95kayhL+mCkP8idJWyCNUIs=; b=ioD2u0WrHjs5gcLG3/
	dpdxhqpH4u43vSKPk6hNkQfMV5GfPqTd8cQfafzIxXKi5m3TKbETwNBvM5SC6m/e
	wKzPco+GFr4cBxtrqissFpLqogme5Z2OB9JqmwcrrWmA/g27cepc4YW9hV2OLUk0
	RrAUEQR6yeAbQQwXXTXuou0y8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHL_7eRbZp1c9fBA--.6138S2;
	Sun, 15 Mar 2026 13:38:39 +0800 (CST)
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
Subject: [PATCH] hrtimer: Fix is_hard/is_soft both false with missing HARD/SOFT flag
Date: Sun, 15 Mar 2026 13:38:36 +0800
Message-Id: <20260315053836.122937-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHL_7eRbZp1c9fBA--.6138S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3Kr45ury5XFWUGr4xtFb_yoW8CF47pF
	WxJrW3K3y7XF4jyFW8AFnrWrZrtan3J3WxuFyrJ392yrn7t340qa1vg3Z8XFWaqrZ8urWx
	A34Iqr15CFWkZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pihvtAUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4h+Q+Gm2Rd+CsgAA3g

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
 kernel/time/hrtimer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 860af7a58428..9584a3af13e6 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1618,6 +1618,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
+	hrtimer_mode effective_mode = mode;
 	int base;
 
 	/*
@@ -1628,6 +1629,8 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
 		softtimer = true;
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
+		effective_mode |= HRTIMER_MODE_HARD;
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
@@ -1644,7 +1647,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
-	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
+	timer->is_hard = !!(effective_mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 
-- 
2.25.1

