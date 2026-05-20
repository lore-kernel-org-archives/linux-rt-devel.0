Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A73BF69E
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266426; cv=none; b=c6QLiiQVNIy3M2dGEa9NENhUhz6uZd/HjuAzmJVy84OXHQASxd5OypdOu31XwtFHLN2UALPs1o+P5XUUUjNJk4sYd6Dmm+140xF7oF4QpIzQT1qY0ZRuYCZbHybS1ToZoFz2b52txnIRm98etjs7G6MmR99Jla9S7Up1lIlYK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266426; c=relaxed/simple;
	bh=AkYj5AHtrC/uF53D3aGzzwsC2RGoqU7NdyGliCiAltE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ho28M719yU9Zp2bXblnjAMAMKjxPw4jIhJXnSM/OuRcjg5yoW3/MsSrxEfifzoZLAUDW4lEoRx7/ezewWbNX8Nlk82woo6+dIssWBJuOsWjeDDZhg1fEzgAC1B4jRX06EBduQYfX4IDlS2AlPitUiaN/a3T/zPXh1WmgN0SEzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SpTCledQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vXNAu2vq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SpTCledQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXNAu2vq"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAloKRgByKT+tR/NHbf2IcJ2ZEGz+DigBWOf/M55hSA=;
	b=SpTCledQPSNqgpt0IAKW0WgQq1Xqc7iTLmcItrpYiQizNimSRfeX90J1cAe4+g/clCNZsZ
	z5IriZAqyhkDdISxO5bD4i4zJhZlBQWgXI51IDz5FeNXws4Q7kw40oB+pbCEaIVou4HLqa
	QgLAwM/p2sB70HfOASjw+GXHobNWl7nk0qpfs5SAKTqLgxWkNVgM9F58kszDgo/RybsHw1
	T3hvPIiPjMQqZlHi7DCB3+FKfG+VLsDTfpDLgC9Mz9H61C8dxmuVjTvKlNCUExT78tMwEZ
	z5nNTinJce5Fb9gBtAxEePEd1FXB+DSopiad4kByFbPwDsybRxL/sbrLL3lYTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAloKRgByKT+tR/NHbf2IcJ2ZEGz+DigBWOf/M55hSA=;
	b=vXNAu2vqa03VGTZ5XO39BdyqlQTofKD8PpnONLnnBbGZKXwaD1N/KWLKNz9FXLyahQIXdg
	UBGgkx+42jDDVzDw==
Date: Wed, 20 May 2026 10:40:00 +0200
Subject: [PATCH v3 1/5] locking/lockdep: Add a helper to validate the
 locking context without a lock
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-restricted-pointers-final-v3-1-76bca6a6ab3f@linutronix.de>
References: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
In-Reply-To: <20260520-restricted-pointers-final-v3-0-76bca6a6ab3f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266417; l=1669;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AkYj5AHtrC/uF53D3aGzzwsC2RGoqU7NdyGliCiAltE=;
 b=ZZd4eW/N9bVO5CEuqJhhmpoRiJIqfe7z/snFE1Fw84CB9a/+Mgin2by1lBUvxRBUEnNT+fTor
 UUxm9juAGh3DFcdWkXY/ZZPhz18Z9KOAbEuxxlebEKf3UIOqNtLwwQy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In some cases the specific codepath and its locking operations depend on
the runtime configuration of the system. lockdep will only detect lock
misuse if the system is configured in the right way by chance.

To make lockdep more reliable in these cases, introduce a helper macro
to define a lockdep map without any corresponding lock.

This differs from the related DEFINE_WAIT_OVERRIDE_MAP() as the context
of the map is checked against the current locking context.

Link: https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/lockdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 621566345406..ae3e332f1518 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -315,6 +315,11 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		.wait_type_inner = _wait_type,		\
 		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
 
+#define DEFINE_WAIT_ASSERT_MAP(_name, _wait_type)	\
+	struct lockdep_map _name = {			\
+		.name = #_name "-wait-type-assert",	\
+		.wait_type_inner = _wait_type, }
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -407,6 +412,9 @@ extern int lockdep_is_held(const void *);
 #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
 	struct lockdep_map __maybe_unused _name = {}
 
+#define DEFINE_WAIT_ASSERT_MAP(_name, _wait_type)	\
+	struct lockdep_map __maybe_unused _name = {}
+
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_PROVE_LOCKING

-- 
2.54.0

