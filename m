Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA83A63F2
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891649; cv=none; b=iaTEPoN59lh1apI9DyJ+lPeibM68lBwOXlhmxQjFxLM6uKtRZZnqD4vj5uSOcStfwrbNLiS6G1H+VVonhE+6+yOpHnBCKnFCYV3moTde142XQKiYlP9kUaRkm5LQQOxfkMANkT5VGjfd3detCZF6IeE8OefSN+4HCpsPfnx1kSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891649; c=relaxed/simple;
	bh=cj79tgC3dkANYQMvHafzxPjuPZeqLTCTo6zJRjFZft8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bt3xoWnk7slMc280U+NoTVB+xT5hE/pu8YxeJTw5S6W106okCjWkS8bmIMD1foOtfn2Vv4dAv/eDj3Nca1ta4latFcvxFGQvYmQvJ1O4dXNqyJnh4dmo1U+lLdWeiFLf7MwKxQDdZHZRqy+IZZb93EaLq4DvshHrhbHMu5pNNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j3G2QgYL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQbWOhdq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j3G2QgYL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQbWOhdq"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777891646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsCdOkpXxchXq5yCTTtYRm+AzOj71Uwa8aetkv2LHYI=;
	b=j3G2QgYLH9ExCoeXEU4KYtm3YzNRfTIePziO1saRv5d2s/xxkAbQee55Ut6siX+jxO5RhW
	Rqv8UNyZ7RFj3XDCQEc1bSp3z73gPYPnEatHXFgKBf0rGPZRRrLtrhFve1KvETGOkTEpqA
	C09xLz8IhKIjf8dwtqJFGV59rPwVChGZFDKt9ZZuedyzBsILJXLyi3E4CNRHJye0kaWSpc
	3qXcLI0A2ufgG3uuO3gH3g8IP7rd6fT9alLBLPYKSFcASBqJCQoXcKmK8WSkWmbhCGyou6
	WvH/750EWBISDuOQ3O+egy/eNvigJ5p0zdEOXhATka/Ga7vZRfntQxkFuRcYHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777891646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsCdOkpXxchXq5yCTTtYRm+AzOj71Uwa8aetkv2LHYI=;
	b=CQbWOhdqcMlbWyktsjOMp8oIVoBo0LRYKHMwX2xdHaRHcWfzqdGmnTkdFMWWdjrAWA9LHU
	q1x+gEtvCiEjd4Cg==
Date: Mon, 04 May 2026 12:47:20 +0200
Subject: [PATCH v2 4/4] lib/vsprintf: Always check interrupt context
 restrictions
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-restricted-pointers-final-v2-4-4934933503e5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777891643; l=976;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cj79tgC3dkANYQMvHafzxPjuPZeqLTCTo6zJRjFZft8=;
 b=M49gSKlUWVacnKb3VA9478HZQJl71SOqmRbyaMl4E7NthDiuQsfI5jb3ykU3KAhRHeBePE+CG
 Jja/DCtDJWoBzLq1mbrHnmCLC4X966trTyvMIFuU0rB0cX+V6ZrbLmd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When kptr_restrict is set to '1' restricted pointers can not be used
in IRQ context. As kptr_restrict can change at any time at runtime,
this means that restricted pointers can not be used from IRQ context
in general.

Add some assertions to detect misuse early, independently of the
runtime configuration of the test system.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vsprintf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 021db95087fe..185bd9e61144 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -871,6 +871,10 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 
 	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
 
+	lockdep_assert(!in_hardirq());
+	lockdep_assert(!in_serving_softirq());
+	lockdep_assert(!in_nmi());
+
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */

-- 
2.53.0

