Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C72DF13F
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Sep 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744698; cv=none; b=Enlmaop0i+tNr+nJ2KJ/QQhTaKYfMTCmFhR5ldyrNArSZ2r2AZNwnOgc81QDKviX4m9rdBEormyqI7q0KsB0i31SImqUWE+TZ4665k0Q3VQa8Rjr/7em7trFn3ZtatIKIbiLvqw18170Aol+bCWgm0tC6qRX4Secz4szfpTfFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744698; c=relaxed/simple;
	bh=d/RBdc3nc4ZOoFn7y+X3s8cM0fRI9Sg/fZH6MKrcceo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rifynTsUSwPVN1JDpG8oa836ECSGoyBTvx0X/L1TAWJryTNWhTMnJfDN3UyJ+5CZK+7Dmrl1TEqP/5dZX2I3B68P7RBb0pN6zM+dppPFYjGWrjyJW8HoIFjoNfUS3latE/FmPp1gV1JEzMbUJtnVi8mkobVIMy2DDW0WBMjNI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5sq0L53; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dz9gmZUG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5sq0L53";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dz9gmZUG"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756744695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4cHD+2DwuVrmZw2dVYltot/Px0ddS/Ap45pQhFUjiQ=;
	b=N5sq0L53mBXi5MMXw9+gdKQCdrnI2iM0cSHQaxRRYi2TDs7dCWSxKnfrCsnGBxtgtY/H7M
	/15A1hwols33MyAr42myxNSAJky7L4J03HxnubhdUE70qNQbISIWfwmUjn7seea3cpzf2Y
	BrLByGegqf+b/H3FZL4G4WkmKUIEYMHgtJJJZwdv460+u/qrUG9VofV3q8on/QGz88V+WQ
	VKqLVCR0EBGrzUP6DzZpgpfT+CVayFnC0Ss7KZs4riyDA2I65hTnru3bX9+nV8Kin3zO47
	nBshV0Ear6SwgaQ1dKJ1cti1SDGiuoYqwahs2dqioK8IzGCfCCzf59e+ToQHMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756744695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4cHD+2DwuVrmZw2dVYltot/Px0ddS/Ap45pQhFUjiQ=;
	b=Dz9gmZUGFLAIiNS2wlBhX7O+u4oyeu4Y58mXlFMz88aUBz+TDjZVLDQD5l/t6jGR07n9OD
	E4CZhohPqTvoGOBg==
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
Subject: [PATCH v2 0/3] Allow to drop the softirq-BKL lock on PREEMPT_RT
Date: Mon,  1 Sep 2025 18:38:08 +0200
Message-ID: <20250901163811.963326-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
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
 kernel/workqueue.c     |  51 ++++++++++++---
 3 files changed, 175 insertions(+), 34 deletions(-)

--=20
2.51.0

