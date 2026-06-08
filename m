Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF893CD8C1
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928510; cv=none; b=nFxbUe+l5GR3lgemOquoA1SWlg6Q3FWJbmJ79LgXjFmyWAyJNaNy2tG3TzvwhB7MSiYOjUBScanbSLr5rnXYbEB+Tm91n6Wn447f4G3DOjU2Txmyrceyw3aOdfLD9aOq/76f+fHTBiiiwGOm2fLEZVa3Gyt/vwrxcddq7dqyclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928510; c=relaxed/simple;
	bh=6Q/9ulCqN7kq47L/f080OtZN84Fv3G/xnY1TwiWuXwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgLPycecq0aKd9oNnuNS4Vgt43IkF87FwJELlpglgUMfr5Vg8yb9LvnbQPnADK7uVOWQQLOD/1Rhbm7IcwGGnw2FjtTKMmlgHsA8O1uzdrl4PRwvNUfgOWismh8KqUpdzHZDQWuhWNfUWolhYtNwNmmmCu1jLi4TClGt9xkdwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HUWDtFU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9mIWTHre; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUWDtFU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9mIWTHre"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780928507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOjoJ2GXJXyNfZG6fkhX9EjF0PqxBF6e5FrhpqCKuD0=;
	b=HUWDtFU1a6nEMo/eYYXkne+g/ySXXkDiKZzsxBxb7EX+ylX+Ep42JZIj5Mhpt69hn25eGu
	FsZ61omsBvoporfn66kzeD4j0eRPenJaFPKcJmXxxYxBgYSE1KMUJCd0CNsCN7ZWEdDLah
	p7ucvoWhTifamfdMpT186ObxOMJmAEK8NUaSqo7AAL/qxHcPjhv5ExCbWBIxWySFDFrvgU
	jpnRLwX9K1wnlz7/eoOPDYQzAh6UE9azaGB0UJNazwi8AyT58ClGhMHWVw5LPqoQmdrrUu
	Fu0ZdmFNKrxPsN6nBmu5yALP2UPxYYcs3WYfJtA6gZSPEbr01woBDAzMWOUAlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780928507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOjoJ2GXJXyNfZG6fkhX9EjF0PqxBF6e5FrhpqCKuD0=;
	b=9mIWTHreQg2kfOZrohmfzfKAGcNjfyV2ebBHQkyMqvedlFx7KO0ubFnjtdZRCY97KwqKpv
	vyndSRKhHub8eEDA==
Date: Mon, 08 Jun 2026 16:21:44 +0200
Subject: [PATCH v4 4/5] lib/vsprintf: Always check interrupt context
 restrictions
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-restricted-pointers-final-v4-4-9a436615799e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780928505; l=1099;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6Q/9ulCqN7kq47L/f080OtZN84Fv3G/xnY1TwiWuXwg=;
 b=lxOL3lH4djT2DFcaKyVr48gtphP2otoqYe5K04EThcRETgH/kMDkv/JWwoZt4Oi2IgSbXNxW2
 L/oSjeuXGMmC3wf8jW4Yhxmn6DG5U04RcQNa0F2i3IGEnhbL19XwaNq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When kptr_restrict is set to '1' restricted pointers can only be used
in task context. As kptr_restrict can change at any time at runtime,
this means that restricted pointers can only be used from task context
in general.

Add an assertion to detect misuse early, independently of the
current runtime configuration.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 6095b5f0d022..09e0e5194d41 100644
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
@@ -863,6 +864,8 @@ static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
 			 struct printf_spec spec)
 {
+	lockdep_assert(in_task());
+
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */

-- 
2.54.0

