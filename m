Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5860313523
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444256; cv=none; b=GvpiyJsiE37ur7kUGL+pDB9vIr9DzlwPmYv7PZOGqlnIuGIdiErtJ+fpVrtmx/7jg5Us6UVJjaSDuKKR/jL3J/GJLWJmdBi9QhXbCnjdKfOQrjkuCZW3I/JFMrRa3N6KOKgA5cEWHnxfvIt0MNZXdZcRKJW46xijUMnh/xVegFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444256; c=relaxed/simple;
	bh=nfi0PfSq6Dox8FYapvzx2yyqZb6FV4A0jwmwDZVXYCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qOkGxkWohCTvLORYkBlpAnxA/ZTS+SiLC4rsb0VxlPAngHgWuMi6hLgRECc8hJt2SJL/0vgoJHowxxP0p6gMQrcM297XABL+pO4qcVG8JAH5NoUZ1UyKr2GnoEnPnmrdL8ZDDyWWxzRQ+fS8D+8uAttp6bDBTc1jHkb1RR81p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ble0H83e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4I1a9cCQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ble0H83e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4I1a9cCQ"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760444252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FhJoJ9sh/rzNr2PrKp88Hxaryk64dOD8tUujsdzCgGQ=;
	b=Ble0H83e0fuYY4+wv1NL+635xo7D3oTuXx8GedLjyBKm7HGLr9LAGuYEv8EXfOjzoN5Zar
	1rYz1bqrZ/JkdxJ+zhLIcM+w9Vwjxmin6goO9MoLXULJtXk1e0IrTX5iExO+RYtHaJzCpF
	xjEF40eUs57LwWMRekbKmply+VJ4DWiVrJmAkpyqPapquSClT94HZJh0srjueaVa4W2TEn
	6IOTyg66dmMBEcGPTGsdbmfMdt/viORmp+7QsTjkwOq5n7EMzWGd96sflG7z7dGvGNZHst
	i1683NGzGpdmgEctrcwusZB6Q6yHXZn97PzE3bpmH2GeLGN/uHpNz+U5VwdWGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760444252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FhJoJ9sh/rzNr2PrKp88Hxaryk64dOD8tUujsdzCgGQ=;
	b=4I1a9cCQdKf3V0UthOuGjYRRLJAB9eXiEw304zCQm267VJ7N4g4wQUGlKTtjW8/uYKn7Si
	FAE1dEr/cH4hWsCg==
Date: Tue, 14 Oct 2025 14:17:23 +0200
Subject: [PATCH] mempool: clarify behavior of mempool_alloc_preallocated()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAFI/7mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MT3dzU3IL8/BzdlPxkXTMj05QUE0tLM0NDAyWgjoKi1LTMCrBp0bG
 1tQAutAIpXQAAAA==
X-Change-ID: 20251014-mempool-doc-625dd4996110
To: Vlastimil Babka <vbabka@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760444246; l=1440;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=nfi0PfSq6Dox8FYapvzx2yyqZb6FV4A0jwmwDZVXYCA=;
 b=wKeMfz8U2ptYpXr7OqbqIBhkLpbKS7lKG6KC01/LeijIueu/9G17xbRhhBgvjAE1NGGLTL70B
 iKzdh5OSC/BAqg+8EF4qsMQBySXulgy5aBtlfgKBxExFORpBKTdRv4W
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The documentation of that function promises to never sleep.
However on PREEMPT_RT a spinlock_t might in fact sleep.

Reword the documentation so users can predict its behavior better.

mempool could also replace spinlock_t with raw_spinlock_t which doesn't
sleep even on PREEMPT_RT but that would take away the improved
preemptibility of sleeping locks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 mm/mempool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 1c38e873e546fadcc594f041874eb42774e3df16..cceb09b75ebe35f263a5fb95ff6d400221ecbdd5 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
  *             mempool_create().
  *
  * This function is similar to mempool_alloc, but it only attempts allocating
- * an element from the preallocated elements. It does not sleep and immediately
- * returns if no preallocated elements are available.
+ * an element from the preallocated elements. It only takes a single spinlock_t
+ * and immediately returns if no preallocated elements are available.
  *
  * Return: pointer to the allocated element or %NULL if no elements are
  * available.

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-mempool-doc-625dd4996110

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

