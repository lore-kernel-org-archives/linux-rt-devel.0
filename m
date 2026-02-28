Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F373ED136
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269629; cv=none; b=SHdJZUzbaU2foBHbkg66Vag2UE+KOEotXnktNpksx3YqV0iBLSddvwjKXR+5pckLpNF5F4t8uDOIYEDljgyts3q+iUZsW5Wvy2FBYe+RoajTgYehvVBx50WcUOoobXllFEVf8qwvVS/LYcm1V1byR8aze4xuwMlHZ8Rp3zYQE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269629; c=relaxed/simple;
	bh=FYDCrvmbavmVMM0l/9ogzr+nuZLVBuDVcwYj3BWg0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwrJt7vi6Ewj37taGpFoOYXku9gpLW9UdW19Px9ayf+CKt9ykHuFvFa5lq8ieHTaLf/MPTzctJsTaj2vYNp0+2hzFvp/NJuVXB9FQWwLYnGmFurmWKaSlxgl2oV3zQOcLlTqyKOzsoAnTUN3m0epAWQZV0/T5py0R/n0CSL+xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMQjd5+8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMQjd5+8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772269625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C5U/yNy/KMt3+3/ZSU8Fyr9O8lEuu9x3SLzaQ0k6sD0=;
	b=vMQjd5+8irnCjtAKozlW/91o6SA1mUUrx2tIUl/MxfzcCjdoqS0WDEzXJkAHEHKHG0QlPU
	PgdANnYo5EuAtPvTGs3iCay1cdBZONUJXGmgjZzrj/oa9d5IBIcjQ9A2nHH4a5kxy05Qp5
	oXUNFCT0KD3Jq5A9UWj4wsxqFIxKazA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net-next v1] net: fix sock compilation error under CONFIG_PREEMPT_RT
Date: Sat, 28 Feb 2026 17:06:43 +0800
Message-ID: <20260228090644.362807-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
brace-enclosed initializer rather than a compound literal, which cannot
be used in assignment expressions. This causes a build failure:

  net/core/sock.c:3787:29: error: expected expression before '{' token
   3787 |                 tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);

Use declaration-with-initializer instead of assignment, consistent with
how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
DEFINE_SPINLOCK).

Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/core/sock.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9d841975a7a1..2461aba7b18a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,12 +3782,10 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
 	might_sleep();
 #ifdef CONFIG_64BIT
 	if (sizeof(struct slock_owned) == sizeof(long)) {
-		socket_lock_t tmp, old;
-
-		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
-		tmp.owned = 1;
-		old.slock = __SPIN_LOCK_UNLOCKED(old.slock);
-		old.owned = 0;
+		socket_lock_t tmp = { .slock = __SPIN_LOCK_UNLOCKED(tmp.slock),
+				      .owned = 1 };
+		socket_lock_t old = { .slock = __SPIN_LOCK_UNLOCKED(old.slock),
+				      .owned = 0 };
 		if (likely(try_cmpxchg(&sk->sk_lock.combined,
 				       &old.combined, tmp.combined)))
 			return;
-- 
2.43.0

