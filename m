Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555D39C637
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891647; cv=none; b=UxXYZEU0v55cUx2zsjHIFfuGftGr87uqfx6tFwHq0EUcQkAyzgenIP71WBvz3282tJ0ViCT7++80kGCfmNtlz5+yC0YMhnzu20YdmEbV3pbIUIFOTLLZxj8ww2wQA2fi+HO+osTxxVc7OMh7ldmcwLJnlCY6wtwgOtij+AP0SJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891647; c=relaxed/simple;
	bh=B2QN0SifbMh2La/twhWWaJUTyAryY/YjepycKtDQdkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9sOJZq083zBpO0d2IyDS05H9M5Mki8wZ/lRMwXD5HAamCcAJYqvjOTZHJ/ydUgh4dgQvBsgaEjD4dKlHvsxbGaF7uLfSODQQTuGvBpH7KjoisymwdSRwtagzYgyJcWCEDA+kpkeVadcittepbOQP0gEp6WXepNeJCuiqFMvxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2wanBuf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGa7wH8W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2wanBuf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGa7wH8W"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777891645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4tm8pTuwCSr7owNnQdabrJvenrKmBnZOfdXbRtBJzs=;
	b=x2wanBuf7AjxbV7zhqajkQPqy1OQDfSBTtjTtX2N9QFIWoN0VuzcKGWNxPfeTtERM11fzv
	NRKekvx2ew7s5OUE8QR+4xJYgnSCuuI9kL+YhYz8HiO6ABF1ufH427qCfdBAmDOrObcjWw
	j2S8XhxogiFuUPDKlmXIP62LHGf3qS0iK+KbOxPV9wFCWH/wN5vRmUbJbzf3MhOe7cUA9T
	P/S1dT43p3woFgWPDJ8NXXzTp5GwmvoLSowHyoWOSEO13bV7CkBOxBw1jVvRPwcTwlf0uL
	K+nQqaY7Micn27ZeqIL6uf9We+NPZI1z0C7Png+IFBoBPWqB4+CxAs5bv2AZUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777891645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4tm8pTuwCSr7owNnQdabrJvenrKmBnZOfdXbRtBJzs=;
	b=nGa7wH8WRfkxCgyVFVHA/5TV1fKYT0CanP17btQ2zE9nY4k4fU30n84hVy6fHom7VlTLtH
	YtxAtW88PgNku5Cw==
Date: Mon, 04 May 2026 12:47:17 +0200
Subject: [PATCH v2 1/4] locking/lockdep: Add a helper to validate the
 locking context without a lock
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-restricted-pointers-final-v2-1-4934933503e5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777891643; l=1669;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=B2QN0SifbMh2La/twhWWaJUTyAryY/YjepycKtDQdkU=;
 b=oCWTaCgWfjET6njo5KLghv3yqP07FfsTim/Rk2k4ddBeWpzJ/5/I+AVxX+lQCzeo2WdB1QLiz
 ucwILNnKM55AoWwS/Fe/IncnUHq9m+7BQGySVhOEVn785XMhu3wrgvl
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
2.53.0

