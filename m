Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03E3BA22E
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266425; cv=none; b=MezzkIRe7sLHlnKttlOKxK6My3Z2yHmxGLtEqXJukblV/8m3eKttjyw1Vm/K40DrT1ryyTReU9wt1vWlyJvE+ySZklU8R32fv7YEWNfICN6DbKK8UbZe+Vo5MVh6sBDItIISpapb9sGPJZTPEMZ6Gp8x5K0lDE6jnGHco+JFMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266425; c=relaxed/simple;
	bh=Q1kxc5TCzG6rUOaN6yx3pMWtWO3CsPXJ1uYnFTOVLzI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AxkwLovPacMebFvxEaVrW7rqHXQaAabK1BSjFAXorkuDDXdLsq6Shz0lPFk9ytBeULRgNMoE2hk+ZcFEyUQ+I2gyhw/HHyDTiZHBLM/5F9dfxJ7YDp/hPlTl1RwU6DyQmw/o3pGq2Y/heMuKPlHbVTU9ZQnVGpS7YwDv+cKMgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAfQzwm5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teo76vCY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAfQzwm5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teo76vCY"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hO8gXVNSUQN6+tpplW//8AvD997TO/TzBq8e51WZEqE=;
	b=DAfQzwm5X5D+S8iNrwTrOfGGXRqRWkLiWPyJL+/ID11Zx2143GsDLx6F658GwWZ1dOYLku
	YmCPk4T1DLDOF3y2giGJjDMyHAWKwToSkoZCw4o/ruzuYlPrtC+EXaQsmd6arAofiqdWKo
	IQ//uzbKX29xw4fwzB6um24idVRb4IqJgEcDd5p5251krzrXT4OFxLcbi7+Y2OhJtYneli
	TrhUmDK6IKN2lpsflShvD9YvX+rxuIGhhRBl2cUfY6DAO6up8wo+Jdf+50OlmdYPahfDor
	UdvWr/TRdclHEZvBBOFpuwC1Kgt73AJg2rmLXgGGoG6cYYf4oyZR3ZxLk7Z48Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hO8gXVNSUQN6+tpplW//8AvD997TO/TzBq8e51WZEqE=;
	b=teo76vCYHXCNrBevpiw3Y3jfnppnaGjZ5Mxf+Pg2y8m6959wMQ94wFucgrePJkKeX/8JHS
	ayUjf8IY8OrwvnAQ==
Subject: [PATCH v3 0/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Date: Wed, 20 May 2026 10:39:59 +0200
Message-Id: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzQ6CMAzA8VcxO1uzL0A8+R7GA25FmpCNbJNgC
 O/uwIOJB5Je/k3668wiBsLILoeZBRwpknc51PHATNe4JwLZ3ExyWXLBKwgYUyCT0MLgySUMEVp
 yTQ/GSl1XdWurQrJ8PwRsadrs2z13RzH58N5ejWLdflUl9tRRgICHtqbhaEt9Vtee3CsF72g6W
 WSrPMqfVnC9p0ngoGuVRxVcYfGvLcvyAX1YB9gUAQAA
X-Change-ID: 20260107-restricted-pointers-final-cd24979fd752
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Waiman Long <longman@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266417; l=2518;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Q1kxc5TCzG6rUOaN6yx3pMWtWO3CsPXJ1uYnFTOVLzI=;
 b=yXmFOWO5uuy6Fq8BSMOPasLTuMSPJ0MePQhc001JmneXPQV2cuSvQ++2Zui1gDuWDBlcstODh
 OKatKGNisItDU1+LTcLqnCNdQHmzgNbZypcyh65RKTVgrdwzCAMR7z1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Depending on the system configuration, the restricted pointer formatting
might call into the security subsystem which takes spinlocks, which
might sleep under PREEMPT_RT. As %pK is intended to be only used from
read handlers of virtual files, which always run in task context,
this should not be a problem in practice.
However, developers have used %pK before from atomic context without
realizing this restriction.

Add a lockdep annotation to unconditionally introduce a fake spinlock in
restricted_pointer(), so lockdep can detect misuse even if the current
test system configuration would not exhibit the issue.

---
Changes in v3:
- Use in_task() over its open-coded inverse.
  - Also switch the existing check over to it.
- Link to v2: https://patch.msgid.link/20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de

Changes in v2:
- Use custom lock_map over might_sleep()
- Also assert IRQ context
- Link to v1: https://lore.kernel.org/r/20260317-restricted-pointers-final-v1-1-b4dca0ed6483@linutronix.de

To: Andrew Morton <akpm@linux-foundation.org>
To: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Will Deacon <will@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Waiman Long <longman@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
Thomas Weißschuh (5):
      locking/lockdep: Add a helper to validate the locking context without a lock
      locking/lockdep: Add a guard for lock_map_acquire()
      lib/vsprintf: Validate spinlock context during restricted pointer formatting
      lib/vsprintf: Use in_task() for restricted pointer context check
      lib/vsprintf: Always check interrupt context restrictions

 include/linux/lockdep.h | 11 +++++++++++
 lib/vsprintf.c          | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260107-restricted-pointers-final-cd24979fd752

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

