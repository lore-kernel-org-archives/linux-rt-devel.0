Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29C3CB8F4
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928509; cv=none; b=XRM2Rt7F7mWtkUtXY0J9WhJ3YbWlVYp95DdvvcQvNC8O+6XHcbc4uR3j1wk7dDLslT8yRLodsSLdvN6LBqCLY/AI1o1c+i7Jzw+WAcvzpl5nHrX+spNgEEIUADv1nGkUYlKMn3OyJA89EiX/27B4GKAQdmnuGe17Q2315SmYeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928509; c=relaxed/simple;
	bh=VTtSmlTf4DOzDvKpDdSuJkdCtmRx26UF3OdVKOsA+MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbcPQKn8VCTihq/cTf0fi7Wju3WGiLirZfTR4g209pHzkSiSUYXnBqwtaJBhXOim05erVKSwNYIHdimMRcHKjg0hqzunwUL4jiKEMSaYKFUqBP+vUiA9X5FsYqfnmulgKEDlBeQ1Z1vvqcJxW1LKU6MUuKH6t5C7hlW4RnYV/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUlOhAPE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/6jgsUY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUlOhAPE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/6jgsUY"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780928506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPf/0wI4bhIUl2hLwfCYV4qdPyTepnwIiSC3i8r18ig=;
	b=EUlOhAPELUiSJdAEPpcBNt8nwqZv6CX8eKsBuulFXtu5RSdZyYZRHcBRUpwPDhbNElRYxx
	JWs5tMpeP95yzxchrovyPAOdLDDKW5ddcnV2cukK/P2nxxhRNv/6bbj12vBflmNoGp1wc9
	yGp6OWYhexxOYqmjTy7RuW2DoJhHZQldA/rrX1SwSY/S2L4am1WCbIwEbIlJipO7uxObKd
	uyJOrMFWJTVXq2ILQe9vsa4vGW+cb0IFQcP/aizrpTIlpmz0kwZAkeBWj8ABCzBHvp78LL
	Plf7LLvT1HJgE42ysDIhJNONNpuYul5pGWK2k9mqFtrwrtgqHoCGcZ9KGSq79w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780928506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPf/0wI4bhIUl2hLwfCYV4qdPyTepnwIiSC3i8r18ig=;
	b=2/6jgsUYJQHwzil49JxeO5ZSvZLrAKJ/M2G1Mf1Kby2SJYQLhqp8wzHf9m3+McIvvXOZpD
	3o8RhFNqZMnkZ8Aw==
Date: Mon, 08 Jun 2026 16:21:42 +0200
Subject: [PATCH v4 2/5] locking/lockdep: Add a guard for lock_map_acquire()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-restricted-pointers-final-v4-2-9a436615799e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780928505; l=938;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VTtSmlTf4DOzDvKpDdSuJkdCtmRx26UF3OdVKOsA+MI=;
 b=fXUsFlr5RAs+WfZK6pLVYiLFPAFaTWlA6n65+64fjsx4uNT4/0I5DYis5y9hKPPNxBIzFZ7KO
 5dBGBOceTfgAup/m3s/d3Vg4bpuh2t+b8uh2dl0yUV1+7Rj6oLjMtDm
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make it easy to acquire a lock map based on source code structure.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/lockdep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index ae3e332f1518..fad8d71e0505 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
 
+#include <linux/cleanup.h>
 #include <linux/lockdep_types.h>
 #include <linux/smp.h>
 #include <asm/percpu.h>
@@ -553,6 +554,8 @@ do {									\
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
 #define lock_map_sync(l)			lock_sync(l, 0, 0, 1, NULL, _THIS_IP_)
 
+DEFINE_GUARD(lock_map_acquire, struct lockdep_map *, lock_map_acquire(_T), lock_map_release(_T))
+
 #ifdef CONFIG_PROVE_LOCKING
 # define might_lock(lock)						\
 do {									\

-- 
2.54.0

