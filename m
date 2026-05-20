Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5D3B9DBF
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266427; cv=none; b=HsNDBObdF1/Pw4Lz2SIH3+TS8MAQ4vIw7KCaMjDR0L6Z0VfYYzEEqSmL/WtORehniJYakIltNeDGfeAUFcdhK5o0qSPLlQNbhWlmGYR+tRcDciQBgeqXnKbPVrD9c58jWiNit8TxEYPOycEMZeoAHereqh/LstWNxJ52ACZQElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266427; c=relaxed/simple;
	bh=/mEXOiC/f6xskRob+7ts6LDI/fxACCuuHHDi9u7W/iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rz7/ZUZ/jhbUyP3e04NavUufUMlAtsRdzUPe1vSwqLb6s4vQ5gakGYs+G833O3ukoIJ8+YOpW0HnYyhROjpADM1pr7+Gu/EBPEfTQ4fmp+UpLFqvUcNELgiKxLlWLRsD9fjORKv0kQJ2Xmo5w2/pme5ldZE7ZLnWKYKhOBGe9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPrpXX9v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bm6JCFl9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPrpXX9v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bm6JCFl9"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgxoQN7k7B/yedJeRoNxR5qGWcfMv24tVRYYH6yjonk=;
	b=tPrpXX9vBAksPlu8bWYvspoJ0ClDTdowVDjAuWkGeCx7IHRPWzKQavACdqVxfuknKBSu0H
	lfXMNZDkB8gxKM6bX3sO4ydAl05U1aihPIt18VLPJKsymvc/3g1MOEfnGkLE/mMYXPohP0
	rfVZE587gE0et3eecBSqDOnZaAA0FqMx0I0Yk3HAedfd6wI0ih7JL89qjRhjGvVJ1h4WfR
	pRVq5zrWv+nTtSaTB09FHsSWVXtry6QW6fUblgr27yGfPH1YqvsjbhbyiWgwp1qVbvNQTm
	3ed2QQenmHckTrx+D3LWNSInnrUtt0fgsyHkakkgE4HflCVqYlvhxG0/QykBlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgxoQN7k7B/yedJeRoNxR5qGWcfMv24tVRYYH6yjonk=;
	b=Bm6JCFl9h9/DvbDXvN4EgL8mo0qv7dl3cJbeZWM/6wgNW1zQ1ZqzwmwLHAL5EoGnUs9Jh0
	pUO/YBtAGJZvRHDA==
Date: Wed, 20 May 2026 10:40:02 +0200
Subject: [PATCH v3 3/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-restricted-pointers-final-v3-3-76bca6a6ab3f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266417; l=1956;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/mEXOiC/f6xskRob+7ts6LDI/fxACCuuHHDi9u7W/iQ=;
 b=GvmuWGO4VY15wjtkfuIezHgqzhSdrEb0bUEASOcqVLsm9QlVJ3GqQ7vq4bK2GZOl9OWQX8LeD
 MHZYSNqMm1eAmBl+Wyz5Q2Pgw84KeQDZB74eVFXAdyHKkk2kVbKkR2Z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Depending on the system configuration, the restricted pointer formatting
might call into the security subsystem which takes spinlocks, which
might sleep under PREEMPT_RT. As %pK is intended to be only used from
read handlers of virtual files, which always run in task context,
this should not be a problem in practice.
However, developers have used %pK before from atomic context without
realizing this restriction. While all existing user of %pK through
printk() have been removed, new ones might be reintroduced accidentally
in the future.

Add a lockdep annotation to unconditionally introduce a fake spinlock in
restricted_pointer(), so lockdep can detect misuse even if the current
test system configuration would not exhibit the issue.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Link: https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vsprintf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9f359b31c8d1..021db95087fe 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -29,6 +29,7 @@
 #include <linux/hex.h>
 #include <linux/kernel.h>
 #include <linux/kallsyms.h>
+#include <linux/lockdep.h>
 #include <linux/math64.h>
 #include <linux/uaccess.h>
 #include <linux/ioport.h>
@@ -862,6 +863,14 @@ static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
 			 struct printf_spec spec)
 {
+	/*
+	 * has_capability_noaudit() may use spinlocks.
+	 * Make sure %pK is only used from valid contexts.
+	 */
+	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
+
+	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
+
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */

-- 
2.54.0

