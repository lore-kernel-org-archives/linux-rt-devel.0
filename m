Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A6218EB1
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891648; cv=none; b=VcrgZdIlSxXxNls2vUEcxTMBACAIhsxAZbTNcjH9+A7RWH3l5UfEQRzdZB1QLc0CqnBc6vt9TkJ2P8A39vkzr0dhvlc1D7CcO+8aYWD0rcWvIbB8e1RFQZQkZ4bUuz1boueGCYmqVzJGvH5DVt7eLNGydaeIH5yfuecE1uVVJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891648; c=relaxed/simple;
	bh=wlFRlmGUGOfX8guQV8d3MX86WvI0POQHkYy3nPAHGhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQ1MHO1dte8Z1aEkXRCZiZnYaQQSWmAbtOQRV/wn/aLF5BvN/jokKRU/3sAABHY8IJaoFQrXmESNyxhnQQw73dAIweDEh/DKf/vcHW/L0158CfsBZ5s4teB8TlpBjQGBHwqL+s63oS89YkSw9zLzfF7CJoaw9h1z5pDIHDYu8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1vUzzRN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ae3s2eDh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1vUzzRN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ae3s2eDh"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777891646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gi/NB0RzMU01umq9jbneD18kObEOz0PBPLV85YFGFSs=;
	b=t1vUzzRNhhdv/uJjEYg6r1iM/33AD47oxHsi1wsEhS4SKuxZo2ntFFcBkrfcEY6OSCtqNn
	GtVyL8HN5eRW5lY7d9aZTMqkRNf4VolgFGkVgAVSMqT9ubtmUnS33j4CvEbw/BOY+rhAuO
	wvtT9aZkIk2gyU8aPeQ3pY8g+9EJhvzz0OEBMbISchYG6g5ab0y49LVY8Px9jH+qTb+Bq9
	2b3CQ2LBwCN6I59NwwO8TsxkxMRyZs39/3SBliOwjYkTGT2J0Wq8BuH+oUy6iw7RzQW2bb
	hbTYuNAuPrvBm9J9+zecM46JRUammuALspD71RqOgEw8ayXXGW5h4u5rX2MgYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777891646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gi/NB0RzMU01umq9jbneD18kObEOz0PBPLV85YFGFSs=;
	b=ae3s2eDhZ6VTxvBE3Y8V9dDM1NWni0zc1DbWshQOZjSYoP7Jn/zZbtQpHClHDLS2dXiE4v
	dWV9yDE6wYz6jbDg==
Date: Mon, 04 May 2026 12:47:19 +0200
Subject: [PATCH v2 3/4] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-restricted-pointers-final-v2-3-4934933503e5@linutronix.de>
References: <20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de>
In-Reply-To: <20260504-restricted-pointers-final-v2-0-4934933503e5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777891643; l=1956;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wlFRlmGUGOfX8guQV8d3MX86WvI0POQHkYy3nPAHGhE=;
 b=xMLfHdB/dtcBgLUUTP2biYXBLF+0NbBbjF6bMLH7pW7fJWPAqIfehFiJM9+Lmqvt2rTRF55XH
 sE8cWRsGWUOAHz5e+S2GQvvoQRtAUFD2IC1u6heXMJfCp6+UNNo7R0w
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
2.53.0

