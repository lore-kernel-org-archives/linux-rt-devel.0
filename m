Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4B3B0AF3
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266426; cv=none; b=hn1c5tchYNkW59vtPSObST419ccKjinjMSZb2kZpHK+c8fS5rjK44CJ89eKXlq3ksqcEsWEwbFfBKPNstD6qDbekMLDVS+Ns4Gec6liudbzf8/9MHFaFzZj/vriocHT+tFXQdQ6bzXtr3vJcDbgb9dBrFTykBK3f9tCNU3EdGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266426; c=relaxed/simple;
	bh=VTtSmlTf4DOzDvKpDdSuJkdCtmRx26UF3OdVKOsA+MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZrNb1Ga97EZ8I6xtWbW6Cs2ZoM6fgLLrw/VhjhnJ56gOrQ5h+q6OpNbbciSVakxdF24f3kJya8MS2jW8P2Y/tknzkEN+E3+D1mUErb8cddb18yDbGwb1q6Pzwbhy8/YWxKMpG14SB21JWiq5OVfi+jOwaMzp7X2IL+nucJNv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oG8it2Jh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UhJUZcJc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oG8it2Jh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UhJUZcJc"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779266423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPf/0wI4bhIUl2hLwfCYV4qdPyTepnwIiSC3i8r18ig=;
	b=oG8it2JhA1Wr1GFe7bbI7JACFf41uX1T7MlTtV9RqT9WJ7gOD+2BqPUbnKjveG32/KwuJF
	QQXgeNctsluMMJEpitYSobNrvqjGwG4T1UlEIR64/jWxRAa/a1eYvzF+RO5jv6v+S6s1cQ
	TJVnz301nG9e7An2fICf5IdBDySx7IjAtcSa8Yd58axo2+9e63gR6sRa11E3mpXlQ2J7eW
	rAs5nmqTfFzYn60APVpEYk/8GjAxpzRgb6rledwHKIJT6W5tJUa4dG8hjpEv+kKntvlrOq
	t50+GUhJhhPAaZBgbbPyl5isqhAe0Dj/Alv8xzWwKP3HRIa2cIhIgFmpzUyc9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779266423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPf/0wI4bhIUl2hLwfCYV4qdPyTepnwIiSC3i8r18ig=;
	b=UhJUZcJc3Q2EZgAIpcPW0LoAR1c8Dunt+jlyMy3n8lP7qJPZCzusQ4hKODX58hdC2fVta4
	+medufYJChEbfMDA==
Date: Wed, 20 May 2026 10:40:01 +0200
Subject: [PATCH v3 2/5] locking/lockdep: Add a guard for lock_map_acquire()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-restricted-pointers-final-v3-2-76bca6a6ab3f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266417; l=938;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VTtSmlTf4DOzDvKpDdSuJkdCtmRx26UF3OdVKOsA+MI=;
 b=cWh9+pY28Z60+qr0jSuhJLelOyj+P5+ATvEQkcsde0wAUgIo3yFX6COytSj3K33zccOKjreF7
 crgL9QXuI7QDtFaO2h2LvoCHChaZsoKSztflKXjk227LbeOmkB2Eph9
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

