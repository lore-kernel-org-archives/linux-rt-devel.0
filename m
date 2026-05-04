Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DD34D38B
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891648; cv=none; b=CuauCwEATCHDFN+dNjOZzjHq9LrE0xB0IcCEFCJ6Ph+KzSAVcDTMFLeW7jS4iXD2TLQGqWr1NTY61fz6JMhl7hIFXgdtZ/40E/DIEeN1ncvcMqOp0B+RISfzENJbtWciU4/POeKJLieC7fSeOCgV99t20sFOonbPl3vSKKrYEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891648; c=relaxed/simple;
	bh=ZDGPPvXxpxQVBFMBIYUVyjbRBHxHAqyQJ4YiGEenfnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9ld8MiJRBIRGnz76CrBvWnetyzQHjEg2Opp870Igtb+Ro+9sVwz6O7jNHkvx/U5CtsI3/Xgi3VYxtc56Xk1eiD+JAI/VcJ/owk0x8FJSCW+XT5VWf/MJ7IZnZYSzlyT59ZV1djeYaI+COeuYeo6LvjpCOb9zzhzxGJhNYrrdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwmVMKkV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4uYMBydS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwmVMKkV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4uYMBydS"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777891645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwqF6lAOoZKH+Flkm3e9Ez3upd+JSieyXLkFsktuIM4=;
	b=zwmVMKkVsIWKhyEkR/97NpcPttcQ8xX/T5BMaLrngf6Owj06o2uvpli8vs2Yg61H9/aXe/
	b8fWctQlDgAZXbJG4LChJ+RpkjLoBTEpYPKZd8U7LtwTeYgKTHoxOCT9X9H3A4PwL9m4nM
	X6IhYkOO+ffmePQLY4lXDw0rsxp2+V/m79sQCpvUYy+i66ahct/vR0VYXyLgn7LtXvnd7g
	3Kn9lZUOiLcUSDzoj7RaNEDVEiMac5euVVqO5e82Zgcs0XT3Lm+M9fEliTQsJ4NwZLDLaD
	3X/izbU+XqKkX0ecBhjN2RAumalQGeqcGYPUhUYZWrkO229j2SLPEl0p8aZQwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777891645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwqF6lAOoZKH+Flkm3e9Ez3upd+JSieyXLkFsktuIM4=;
	b=4uYMBydS/dlko7LnM5IcRH1mgfRDgvZt291UgFpBBq1dj90TW+nMBTLp75ExAK7NcHHl9s
	VQShjyc/qr3iEkDA==
Date: Mon, 04 May 2026 12:47:18 +0200
Subject: [PATCH v2 2/4] locking/lockdep: Add a guard for lock_map_acquire()
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-restricted-pointers-final-v2-2-4934933503e5@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777891643; l=938;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZDGPPvXxpxQVBFMBIYUVyjbRBHxHAqyQJ4YiGEenfnI=;
 b=TiTFpyJGySZQqxk3ilStDiF9k4A4kazYDhbxEQIVQ9lbFvfrTqob2fo85tFOB07UqDbwXQeKV
 9Irsh+Ut3dnCJcZb3jFVpJzRWIvyaVr5MuA49WF+bIcE7Lt3+ruEBaz
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
2.53.0

