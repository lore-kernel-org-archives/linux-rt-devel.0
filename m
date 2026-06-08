Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BD3CB2FD
	for <linux-rt-devel@lists.linux.dev>; Mon,  8 Jun 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928509; cv=none; b=HRpw45bvrHLf3iHz4GisdzN+pvp3XBUQuBT4tSum/YjUElmntk6xOnsfQByMtIKvz/jMA4SAaeRvBUGo/7Dj1HjxrKiPi6G0DTsOJN3wb/qPkOM1AbtOuhAxiiXlNl4pIw8P/BiP+jnRQDLtt0hTXzC5OpEFkw9NI6sM9A5+tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928509; c=relaxed/simple;
	bh=AkYj5AHtrC/uF53D3aGzzwsC2RGoqU7NdyGliCiAltE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5uyuoDM00e0J3duRUPVTCZW7Vm6a0isIVoMlagKgB4ySZ2ze8JA5pKigLYcFzSsOd4zFEC898FOKEp/IKcs+j+ykbnzTO3Y5xpPQ89tpOsbfCYjxW9037+CMUjUSEsuMaJj7oTXLeMByjNV/bJ7QoPCVZwWYjBsMdGsDg3czE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBRoG8Zo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swxE7ihq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBRoG8Zo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swxE7ihq"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780928506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAloKRgByKT+tR/NHbf2IcJ2ZEGz+DigBWOf/M55hSA=;
	b=hBRoG8ZoU+7DPdo2VGjNTKX0byeGCNXsR6cd1NCeENj1ZhX09A41ei+cGsboT0j3MA+JOh
	ClBQdT/ce5eb042OkgMgHFatTTX6W+rwUoW4t9vI+XgbvkD8IbfkbyDKt/2OLKDiSTTg4F
	vhEs1RUsDQgSnBsYYeGAsI0gdDVbDysS+RxVWUJbZwkizL8ve4u8whxgw33kOBB3iaRQ5H
	Uq3JiOn/P4NTPH+R4o/MxWDCcqI7QVpKkWkbII1Gki7+8zMAeV4ecC1eLvVWLSleJFkT76
	Ea+d/oWRg2ZDOpQNCkmH9yJNyC3DNqB6aOkD0g/ClcN0tkQxfV/9Wugng0mBkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780928506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAloKRgByKT+tR/NHbf2IcJ2ZEGz+DigBWOf/M55hSA=;
	b=swxE7ihqTpiY7nOCE+H2qDYVeqrnsDr9YnQkQgMYGw1UKXAcvfxPQ84MSy2lWGTzk3CWGh
	RMeSvTaamSysKjBQ==
Date: Mon, 08 Jun 2026 16:21:41 +0200
Subject: [PATCH v4 1/5] locking/lockdep: Add a helper to validate the
 locking context without a lock
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-restricted-pointers-final-v4-1-9a436615799e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780928505; l=1669;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AkYj5AHtrC/uF53D3aGzzwsC2RGoqU7NdyGliCiAltE=;
 b=YnGcL7veYxjdmGNkarldtLIpJtAcjUgRhGWlvdPBZoGclDU+xcfOVphcAsRhPYNLVDb+OLWiB
 5D4Z7l+3vL4AJ/szNpx0lbOZq/KqSoTzarHxUoDAC7lGpdVs/wSCw3t
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

