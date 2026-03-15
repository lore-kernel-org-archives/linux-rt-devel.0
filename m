Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFC179A3
	for <linux-rt-devel@lists.linux.dev>; Sun, 15 Mar 2026 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773556262; cv=none; b=GuFj4jH3fqzhJRvexvMNJdXiun8uaot67j7EucEt0/5ewXXl5pPc7v+tTQ8sizj46nsYW3BXDCXp8nGfRaMkVsaOk2hAqJ/mMkGOt4RL20zTffJsm65aLHZtIyTRRVqKD20qI76LG0wNqOaZrWcM9USlPF/eFloMrgLRIBaixg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773556262; c=relaxed/simple;
	bh=pvqQyrR9elfaUfWzJQ/WI3AfxEoV71acSC9RTRUSxNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8Q9hSFYs38hiYrlvHvRzZZthjTysha7wETaIX6o2OEUIXrIFgxWsf4D8GNt6JjqpvN9WPIx5kXa1pQzZDBw0So1GYcVuC5i/Z2WpPv+ezx8VZZKCoKbjOE0M9kFLfuPBWbLCe8Rh4AS5cMdi96fy5WufRAsW7ipFsqjLkMyXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lLB3Q0Ii; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lLB3Q0Ii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iM
	xqPb9tQin2+fb7323+1uqh0gw2emflu02TkyDK23s=; b=lLB3Q0IivbYPil28Bw
	RrOD0lYEdV9XyzndBFsECLRs6qjiI9XhW81Dr0diFW5VO0KZt7j7p5b/umzLOycA
	xfkmfbv/X0kwajNF19m7H7EQXOw5V8gNAClD83v5Rt4eIPzYRfYP9Xplm35Rss/+
	ovtdoVQO3faYr0578ai572BCY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnKGnzUbZpeopXBA--.3656S2;
	Sun, 15 Mar 2026 14:30:11 +0800 (CST)
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
Subject: [PATCH v2] hrtimer: Fix is_hard/is_soft both false with missing HARD/SOFT flag
Date: Sun, 15 Mar 2026 14:30:09 +0800
Message-Id: <20260315063009.146668-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnKGnzUbZpeopXBA--.3656S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3Kr45ury5XFWUGr4xtFb_yoW8Cw1fpr
	WxJrWfK3y7XF4jyFW8AF9rWrZrt3Z3J3WxuFyFy392ywn7t340qa1vg3Z8XFWaqrZ8urWx
	A3y0qr15CFWkZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVbyJUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4hSZAmm2UfT9AwAA3p

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
index 860af7a58428..1709fccc8720 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1618,6 +1618,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
+	enum hrtimer_mode effective_mode = mode;
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

