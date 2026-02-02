Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39C25C818
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Feb 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051919; cv=none; b=QcOyDNeu8OpWpOAMo+3jMLV0ZBcC+Db/OnDWOYbiST7iKg+5fHeB27HFc3SjCR/m0nPN2DTCtoNwWN8jZJjSL2A2lI8FVYP0dPQMMxSYXxUB1m22NSgwibC12+wNGfl7OE1gHRXEfTzDsg91rEVX04U4445rpJg1A28+AOATZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051919; c=relaxed/simple;
	bh=qFrhiLrEqstvhIiH9EeQC0quRqARawDbhew/Y2/UYLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WYHBLN31wVBp+ts7l+jWI55RR2+A9n/eo7IMPdCYOBoTPEFIVr/gpGPVtrf0DR+bhtGUaC9GcdFOj2vikXNbMqCUdCHy+B0JbMPO3ENYX+4WO5G4eK+8I4qXTaea4kwikuBxMj6yLheY35IcdKzZqP+3Lp3s69adl+hw3vQbNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=34z5GOaQ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="34z5GOaQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1770051915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5aK7VYn5DbqDUI192vSKeBgPLokX65bsPtUKpTgYaGs=;
	b=34z5GOaQEB6a4lwClJIT6nllOz1m5Cn3QGxXYmzRRH1XDU+Ia61ulnXYPTGb/Mu681Ub2G
	pfXAhh0uf/FSWBmIqxX7XcTt1LRd12Oj/kv8zVvW1fsUyAlVwwnZ24naskHOz9NEmWefgw
	NnqpLgG4aOS1F5OXxoXm3ce82IL+40c=
From: =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Date: Mon, 02 Feb 2026 18:04:43 +0100
Subject: [PATCH] rtmutex: Introduce __cleanup() based infrastructure
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260202-rt_mutex-guard-v1-1-1c078dbeee57@wiredspace.de>
X-B4-Tracking: v=1; b=H4sIACrZgGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIKFbVBKfW1qSWqGbXppYlKKblJZoaGpokWSSZmisBNRUUJSallkBNjA
 6trYWAJfEN35gAAAA
X-Change-ID: 20260202-rt_mutex-guard-bfa1518b4f13
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
X-Migadu-Flow: FLOW_OUT

Commit 54da6a092431 ("locking: Introduce __cleanup() based
infrastructure") introduced lock guards for mutexes in
include/linux/mutex.h, but, presumably as PREEMPT_RT wasn't merged at
the time, the guard for rt_mutex was never created. Do this now so this
infrastructure exists for rt_mutex as well.

Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
---
 include/linux/rtmutex.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index ede4c6bf6f22..3c766eba2c7d 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -17,6 +17,7 @@
 #include <linux/linkage.h>
 #include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
+#include <linux/cleanup.h>
 
 extern int max_lock_depth;
 
@@ -129,4 +130,8 @@ extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
 
+DEFINE_GUARD(rt_mutex, struct rt_mutex *, rt_mutex_lock(_T), rt_mutex_unlock(_T))
+DEFINE_GUARD_COND(rt_mutex, _try, rt_mutex_trylock(_T))
+DEFINE_GUARD_COND(rt_mutex, _intr, rt_mutex_lock_interruptible(_T), _RET == 0)
+
 #endif

---
base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
change-id: 20260202-rt_mutex-guard-bfa1518b4f13

Best regards,
-- 
Thomas Böhler <witcher@wiredspace.de>

