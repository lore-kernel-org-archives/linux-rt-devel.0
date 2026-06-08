Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856C3CCFDB
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928512; cv=none; b=qe9Ecp73eB7iGzgGSBh2jJNwDuMKZvKZsKXB+Ybea5VZVZ97JHZ5Ad5I/dVpkC/HrZYcBudZu7yKa2n87YgW1m7agT6iUFF7h7vsVTe8qL++RWPaxthPwg1/Qy/cioMbCjYBac79dHuPHMuR/fthLdfh8i1uhHepva7yCdW2fCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928512; c=relaxed/simple;
	bh=M6cWIuBYmnEz8STtik/V00y/7Xg8RuWOIvf5O2pFl8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUKDUVD3cC5DiSOXOD4LbN5at/Xi6bMDVK95Gpy65CNpwTPyjPemEbl9dAu/SuTQmOoTEO1ST7JifQNiSpyjDkJPekT8WuW6X7lGunWmYsWiWvWHGtbMnr9I8C396VKJK8GBV3VGvfo/FOzAl4DR1NB0amcJmQqIEmtHfowcYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDb0Ulxi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NG8BTgZR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDb0Ulxi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NG8BTgZR"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780928508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7W+MRuoH3ZGaCldnwhU19nMaYlneJ/8geVf9JU0C+w=;
	b=ZDb0UlxitRXCFs80f/Gc3AoPM995zs9/P1J10FypRSoTaDjqYXBJZeMhQzkJGQbnV3QvzL
	naLqZLzGEQ7NPGvuQnTKQ1PKUyeDMUeIUkJivpIu0N2fHEQ1hWfaZ/htTv2sBe8fCuAdwm
	AzADUFfKmOuM43ab+tyyQmLER6P39Kgeq472iv6vevc08LsA9AyVFqNuGHbKwpiGrlfSo4
	qyp54cr80HkygUnj+hIIw17Gt5wT07w/77odZAH1Xw8m8ADga9MBIR9rq3ardalbKnrpnr
	APkfrF5U/BQhKBxip6vhy3ZRCYy0lV2J15KjhmoYDCeeLM9CWfTiCfWouRtBNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780928508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7W+MRuoH3ZGaCldnwhU19nMaYlneJ/8geVf9JU0C+w=;
	b=NG8BTgZR/2fZ3nSStiNchaRBdWaThvrs0MIHBBTSaveBawmuxt32ZAPgWH73QDmaThb54+
	tvVtccB/15Lm9iAA==
Date: Mon, 08 Jun 2026 16:21:45 +0200
Subject: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
In-Reply-To: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780928505; l=2053;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=M6cWIuBYmnEz8STtik/V00y/7Xg8RuWOIvf5O2pFl8M=;
 b=iDj1AZALpfrUczZFylj08SzrIopeztbQ8wm+nLspcZDP/xos7oNjwT1XHRALbll45dMpvsyYh
 JBwW0jS/iHLCubXnDafZIJtOO6wZa7O43fHBgXy2BKfuhg4uDb32M8V
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
This is intentionally a single lock instance shared by all callers,
as that mirrors what can happen in the security subsystem.

This check comes intentionally after the in_task() one, to have the
clearer diagnostic first when the function is called from IRQ context,
which will trigger both.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Link: https://lore.kernel.org/lkml/20241217142032.55793-1-acarmina@redhat.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 09e0e5194d41..728a1acd69ae 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -864,7 +864,14 @@ static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
 			 struct printf_spec spec)
 {
+	/*
+	 * has_capability_noaudit() may use spinlocks.
+	 * Make sure %pK is only used from valid contexts.
+	 */
+	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAIT_CONFIG);
+
 	lockdep_assert(in_task());
+	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
 
 	switch (kptr_restrict) {
 	case 0:

-- 
2.54.0

