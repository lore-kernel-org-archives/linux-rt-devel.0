Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C74A3C
	for <linux-rt-devel@lists.linux.dev>; Thu,  4 Sep 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995933; cv=none; b=YH5QrtBrj2yE1mCMvtgwRYw7ykk6bqg7PG22cJG+toUANORVrHijQ/IzHSgbSIaUuJSJZQWOtOfThvNoblJXOLMCOBAA25R25df45E6CIs17eDjAIy3fwvTCo3KWZ2EYq+LarxhV55CVFjcxuCv+NvZPwMKcX5rxAE81hdrTi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995933; c=relaxed/simple;
	bh=bSbsonRjoAlhi/vZVAGanzqb9MT1cPH4oYtxvhApFQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KLViBexHNMWROtepPk1L0vigNMIZSTiuVFSIb1lKfEPZCnSnXhLubXyYPcy11BPQWFZlPv8Fg+ct/s3yAJKapjJg28ZyC6aNAvQRgWijT4J7EoaGSHxLzh2Sc0QQ7oKbsR/Tdz9yyZ8Kr7rRUEeO3P24Aq79k6usjcGwWQ0oRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VdeNmq+R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbozpS02; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VdeNmq+R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbozpS02"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756995929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCx7oWYatUcftn5F4YlXfxcmcSa68JwRo8W7ICgnhrU=;
	b=VdeNmq+RSskei2GX8ieFIaDJmscierdDADs4PTDeE6tHBosLL5kPV9oN62g41qbZoT4Dmg
	cGesXES7UvI5kS/Bhxmw9gpbiHSwcgjFLBuW1Tq6mPvCKpaDCPdP7DjsDRjwJW1JQtGOqN
	cLcHu6lRio+0q7B0SA5isaJQLLwC4CWh01At16fwzqNiAJR69JHF+8mY12tHBgILtHIeIb
	Q1FGhJCiSmNfvnEXaOoMZ89+gx7xeiYdJ+k5ZGtx1qAFaZOk/zcb1uorZIRfNVSVbWU5GH
	4vN+tz3ZKl1rpZ+RvNPqcmYT2xdjoNJl60PSji/GGfZOr7YNpXV18Wzr44aElQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756995929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCx7oWYatUcftn5F4YlXfxcmcSa68JwRo8W7ICgnhrU=;
	b=CbozpS02VgSoiEuup9lE6/HSl9bZeomhqTU6EMueQFOFgQYagiZvGhlBDHY8sxqayh4ekz
	SDUlWVNKJmsPwEBw==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 0/3] Allow to drop the softirq-BKL lock on PREEMPT_RT
Date: Thu,  4 Sep 2025 16:25:22 +0200
Message-ID: <20250904142526.1845999-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Users which rely on synchronisation within a BH-disabled section as in
- access to per-CPU data
- per-CPU timers
- synchronisation against another user within a BH-disabled section

rely on the local_lock_t lock in local_bh_disable() on PREEMPT_RT.
Almost all users dropped their dependency. The remaining (identified)
user in networking (pipapo) is in net-next.
What is left is the infrastructure as in tasklet and workqueue (for
bh-worker).
Both are part of this series. The last patch in the series adds an
option to drop the lock.

v1=E2=80=A6v2: https://lore.kernel.org/all/20250901163811.963326-1-bigeasy@=
linutronix.de/
  - In workqueue, __flush_work(), replace wq_pool_mutex with RCU locking.

v1 tasklet https://lore.kernel.org/all/20250812143930.22RBn5BW@linutronix.de
v1 workqueue https://lore.kernel.org/all/20250820103657.vDuDuLx6@linutronix=
.de
v1 lock-drop https://lore.kernel.org/all/20250613105653.1860729-2-bigeasy@l=
inutronix.de

Sebastian Andrzej Siewior (3):
  workqueue: Provide a handshake for canceling BH workers
  softirq: Provide a handshake for canceling tasklets via polling
  softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

 kernel/Kconfig.preempt |  13 ++++
 kernel/softirq.c       | 145 ++++++++++++++++++++++++++++++++++-------
 kernel/workqueue.c     |  50 +++++++++++---
 3 files changed, 174 insertions(+), 34 deletions(-)

--=20
2.51.0

